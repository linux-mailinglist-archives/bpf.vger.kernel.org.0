Return-Path: <bpf+bounces-6682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4BE76C553
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 08:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448D31C211F5
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 06:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAA315AC;
	Wed,  2 Aug 2023 06:33:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A572C373
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 06:33:57 +0000 (UTC)
Received: from out-109.mta1.migadu.com (out-109.mta1.migadu.com [95.215.58.109])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7DF9B
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 23:33:55 -0700 (PDT)
Message-ID: <322d07e2-0620-9fd6-504e-19cb63772fe1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690958034; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OfVGA6Z7+KSF7Wv4VE+ba51VJcdgtnGEBQ9V3dnzISM=;
	b=oZiTD9T8CpH4Ao4ZKVNnEPd+QqeD3/lDluqps11jsF7tunEQ9tpN3K278+2/hXm3dIV4qC
	osQSnBhUStzW4bv3+n3YiAPQq5kiDfQavHLStLZclnaL43G/UznEN+Y+FE68cWOhS4WdNe
	GlTrt+Ymiknryp6MJR7dnM78ceZPH9U=
Date: Tue, 1 Aug 2023 23:33:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH v1 bpf-next 6/7] [RFC] bpf: Allow bpf_spin_{lock,unlock}
 in sleepable prog's RCU CS
Content-Language: en-US
To: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20230801203630.3581291-1-davemarchevsky@fb.com>
 <20230801203630.3581291-7-davemarchevsky@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230801203630.3581291-7-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/1/23 1:36 PM, Dave Marchevsky wrote:
> Commit 9e7a4d9831e8 ("bpf: Allow LSM programs to use bpf spin locks")
> disabled bpf_spin_lock usage in sleepable progs, stating:
> 
>   Sleepable LSM programs can be preempted which means that allowng spin
>   locks will need more work (disabling preemption and the verifier
>   ensuring that no sleepable helpers are called when a spin lock is
>   held).
> 
> It seems that some of this 'ensuring that no sleepable helpers are
> called' was done for RCU critical section in commit 9bb00b2895cb ("bpf:
> Add kfunc bpf_rcu_read_lock/unlock()"), specifically the check which
> fails with verbose "sleepable helper %s#%d in rcu_read_lock region"
> message in check_helper_call and similar in check_kfunc_call. These
> checks prevent sleepable helper and kfunc calls in RCU critical
> sections. Accordingly, it should be safe to allow bpf_spin_{lock,unlock}
> in RCU CS. This patch does so, replacing the broad "sleepable progs cannot use
> bpf_spin_lock yet" check with a more targeted !in_rcu_cs.
> 
> [
>    RFC: Does preemption still need to be disabled here?

Good question. My hunch is that we do not need it since
   - spin lock is inside rcu cs, which is similar to a
     spin lock in a non-sleepable program.

I could be wrong as preemption with a sleepable program
may allow explicit blocking.


> ]
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>   kernel/bpf/verifier.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4bda365000d3..d1b8e8964aec 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8270,6 +8270,10 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>   			verbose(env, "can't spin_{lock,unlock} in rbtree cb\n");
>   			return -EACCES;
>   		}
> +		if (!in_rcu_cs(env)) {
> +			verbose(env, "sleepable progs may only spin_{lock,unlock} in RCU CS\n");
> +			return -EACCES;
> +		}
>   		if (meta->func_id == BPF_FUNC_spin_lock) {
>   			err = process_spin_lock(env, regno, true);
>   			if (err)
> @@ -16972,11 +16976,6 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
>   			verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
>   			return -EINVAL;
>   		}
> -
> -		if (prog->aux->sleepable) {
> -			verbose(env, "sleepable progs cannot use bpf_spin_lock yet\n");
> -			return -EINVAL;
> -		}
>   	}
>   
>   	if (btf_record_has_field(map->record, BPF_TIMER)) {

