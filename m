Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F366864C1ED
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 02:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbiLNBpy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 20:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiLNBpx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 20:45:53 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDE8CD4
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 17:45:52 -0800 (PST)
Message-ID: <1a0436c5-2198-0c69-1306-872454d2fb13@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1670982350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OHnbssF5kx+I5sG8VM+6P0tSAKVMpIa/fmv+Q6GDaC4=;
        b=uz4jfsjNYp3jtf7QOLaTewU5JgJaMV5LI1EwzkiJFXMS4ZhUx4ZW/ElsvESG2c96hhMy2L
        LCP3HnDaE9tDBWB5TJEaCwQUp/dgWbbOhE5CVewmUfU019v9iaJvBe4sh+CVmtC03FuTZo
        3Pse2/OhTSJZpqdpNuPcO4hjy/Wp3HU=
Date:   Tue, 13 Dec 2022 17:45:44 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 06/15] bpf: Support consuming XDP HW metadata
 from fext programs
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        bpf@vger.kernel.org
References: <20221213023605.737383-1-sdf@google.com>
 <20221213023605.737383-7-sdf@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20221213023605.737383-7-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/12/22 6:35 PM, Stanislav Fomichev wrote:
> From: Toke Høiland-Jørgensen <toke@redhat.com>
> 
> Instead of rejecting the attaching of PROG_TYPE_EXT programs to XDP
> programs that consume HW metadata, implement support for propagating the
> offload information. The extension program doesn't need to set a flag or
> ifindex, it these will just be propagated from the target by the verifier.

s/it/because/ ... these will just be propagated....

> We need to create a separate offload object for the extension program,
> though, since it can be reattached to a different program later (which
> means we can't just inhering the offload information from the target).

hmm.... inheriting?

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 11c558be4992..8686475f0dbe 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3021,6 +3021,14 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>   			goto out_put_prog;
>   		}
>   
> +		if (bpf_prog_is_dev_bound(prog->aux) &&


> +		    (bpf_prog_is_offloaded(tgt_prog->aux) ||
> +		     !bpf_prog_is_dev_bound(tgt_prog->aux) ||
> +		     !bpf_offload_dev_match(prog, tgt_prog->aux->offload->netdev))) {

hmm... tgt_prog->aux->offload does not look safe without taking bpf_devs_lock. 
offload could be NULL, no?

It probably needs a bpf_prog_dev_bound_match(prog, tgt_prog) which takes the lock.

> +			err = -EINVAL;
> +			goto out_put_prog;
> +		}
> +
>   		key = bpf_trampoline_compute_key(tgt_prog, NULL, btf_id);
>   	}
>   
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e61fe0472b9b..5c6d6d61e57a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16524,11 +16524,6 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>   	if (tgt_prog) {
>   		struct bpf_prog_aux *aux = tgt_prog->aux;
>   
> -		if (bpf_prog_is_dev_bound(tgt_prog->aux)) {
> -			bpf_log(log, "Replacing device-bound programs not supported\n");
> -			return -EINVAL;
> -		}
> -
>   		for (i = 0; i < aux->func_info_cnt; i++)
>   			if (aux->func_info[i].type_id == btf_id) {
>   				subprog = i;
> @@ -16789,10 +16784,22 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
>   	if (tgt_prog && prog->type == BPF_PROG_TYPE_EXT) {
>   		/* to make freplace equivalent to their targets, they need to
>   		 * inherit env->ops and expected_attach_type for the rest of the
> -		 * verification
> +		 * verification; we also need to propagate the prog offload data
> +		 * for resolving kfuncs.
>   		 */
>   		env->ops = bpf_verifier_ops[tgt_prog->type];
>   		prog->expected_attach_type = tgt_prog->expected_attach_type;
> +
> +		if (bpf_prog_is_dev_bound(tgt_prog->aux)) {
> +			if (bpf_prog_is_offloaded(tgt_prog->aux))
> +				return -EINVAL;
> +
> +			prog->aux->dev_bound = true;
> +			ret = __bpf_prog_dev_bound_init(prog,
> +							tgt_prog->aux->offload->netdev);

Same here for tgt_prog->aux->offload.  bpf_prog_dev_bound_init() will need to 
take an extra dst_prog arg, like bpf_prog_dev_bound_init(prog, attr, dst_prog). 
It should be called earlier in syscall.c.

> +			if (ret)
> +				return ret;
> +		}
>   	}
>   
>   	/* store info about the attachment target that will be used later */

