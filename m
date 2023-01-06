Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EA765F868
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 01:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbjAFA6B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Jan 2023 19:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbjAFA6A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Jan 2023 19:58:00 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638221AD80
        for <bpf@vger.kernel.org>; Thu,  5 Jan 2023 16:57:59 -0800 (PST)
Message-ID: <42984784-2910-bf5a-93a9-bd4db86a5a50@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1672966678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jopsYez2M7ixi9cebg6P/nsVXGdVUj6M4crDBWLQJj0=;
        b=SStPnxBKNlMhILyIeyZ5tH9JQlxjaAMdE0fyDvwMtzn2o9g1XbX5u6LgN15xf/fWl/9wFa
        B7TnPpNru5hQ2zNilguLkSYmbPMCQhOF87gKV14dlFJ5V5Qy+aITHvYh/+KF5yY3uSUeGr
        50Iqp8bNyyDrdM8M/u3LBXIMzthDI/Q=
Date:   Thu, 5 Jan 2023 16:57:54 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 08/17] bpf: Support consuming XDP HW metadata
 from fext programs
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        bpf@vger.kernel.org
References: <20230104215949.529093-1-sdf@google.com>
 <20230104215949.529093-9-sdf@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230104215949.529093-9-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/4/23 1:59 PM, Stanislav Fomichev wrote:
> -int bpf_prog_dev_bound_init(struct bpf_prog *prog, union bpf_attr *attr)
> +static int __bpf_prog_dev_bound_init(struct bpf_prog *prog, struct net_device *netdev)
>   {
>   	struct bpf_offload_netdev *ondev;
>   	struct bpf_prog_offload *offload;
>   	int err;
>   
> -	if (attr->prog_type != BPF_PROG_TYPE_SCHED_CLS &&
> -	    attr->prog_type != BPF_PROG_TYPE_XDP)
> -		return -EINVAL;
> -
> -	if (attr->prog_flags & ~BPF_F_XDP_DEV_BOUND_ONLY)
> +	if (!netdev)

nit. I think this check is also unnecessary.

[ ... ]

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 191a4312f4b7..2ec2f53eeff6 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2605,6 +2605,13 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
>   			goto free_prog_sec;
>   	}
>   
> +	if (type == BPF_PROG_TYPE_EXT && dst_prog &&
> +	    bpf_prog_is_dev_bound(dst_prog->aux)) {
> +		err = bpf_prog_dev_bound_inherit(prog, dst_prog);
> +		if (err)
> +			goto free_prog_sec;
> +	}
> +
>   	/* find program type: socket_filter vs tracing_filter */
>   	err = find_prog_type(type, prog);
>   	if (err < 0)
> @@ -3021,6 +3028,12 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>   			goto out_put_prog;
>   		}
>   
> +		if (bpf_prog_is_dev_bound(prog->aux) &&
> +		    !bpf_prog_dev_bound_match(prog, tgt_prog)) {
> +			err = -EINVAL;
> +			goto out_put_prog;
> +		}

This looks good.  One minor comment...

> +
>   		key = bpf_trampoline_compute_key(tgt_prog, NULL, btf_id);
>   	}
>   
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0d0a49a2c5fd..8c1b1259f30b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16531,11 +16531,6 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>   	if (tgt_prog) {
>   		struct bpf_prog_aux *aux = tgt_prog->aux;
>   
> -		if (bpf_prog_is_dev_bound(tgt_prog->aux)) {
> -			bpf_log(log, "Replacing device-bound programs not supported\n");
> -			return -EINVAL;
> -		}

... can the above "bpf_prog_is_dev_bound(prog->aux) &&..." check in syscall.c be 
done in the bpf_check_attach_target() here?  Mentally that seems to belong more 
to bpf_check_attach_target().

> -
>   		for (i = 0; i < aux->func_info_cnt; i++)
>   			if (aux->func_info[i].type_id == btf_id) {
>   				subprog = i;

