Return-Path: <bpf+bounces-6765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC29E76DB09
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 00:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976D2281DC7
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 22:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B428E14AA9;
	Wed,  2 Aug 2023 22:56:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BD310947
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 22:56:19 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3488B9B
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 15:56:18 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b8ad356f03so2986375ad.1
        for <bpf@vger.kernel.org>; Wed, 02 Aug 2023 15:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691016977; x=1691621777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2w03jvfuTtGuc4fKhZ+CIyGNYiLn7keFDzHo8jvs/C4=;
        b=pIp7UqgI5qIrIYDepYSyKa2LgJERSNkRFPR3Rq7s98OKhLYSsUzRJYFgwWvmIaM7pe
         nFVoO6CXVZfsZwf0putJRCwBwXFg59Txvs2+9vMdqwZth8US7Q7w7s7gkY9iXaUpKUmM
         ltHksykEN3Vt1XOuT6jO2/hNO/10bLPLVdzk4iNNedt7SZTKgL53SOjUTLI85M33XdPg
         VH5mO3IyLCaY+bZfT8KKG2JDpHLEoRW2Dzzk/wWa0XxoTd84IKzuHzMW/4BrGJbcVwou
         opH86u7G0gO96rZlby96GPmnjnQBnsMP2AF4Hu5XfArXUFJrQuvNefsiNN1KhaNX5Kmk
         ZLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691016977; x=1691621777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2w03jvfuTtGuc4fKhZ+CIyGNYiLn7keFDzHo8jvs/C4=;
        b=I4QEE8Pv0M3ckBkCVH4joxO19+bcGpF3u12+URqL/F99WZ9VS4O0E2GBSFl4yuL093
         tjpUJ//8kXU7FD4qAtEDwl6evZMM1OdjhNIdiwMJXY9Q6W879gKoY3xVMAj9SS2tbGDL
         I43x+BK3aDOPPlNBE+aB548Iue0MwelACHbddaDdJ8YDsRjjUu9Bnz1G0YDSNKAjSyjc
         XffVKzXPfiTrLoHQIGxddH5+rQoY6KnQTmS7oraIeUr07qN1hJfTYWA7DiMrqpdkzzpW
         tbyqXkPYme8JCRbEibosVX+uGF46ZZr381jcdGgtGW8m9BndnEccX1jszfHtOS+H5JvK
         GvNA==
X-Gm-Message-State: ABy/qLaSQk1mw1PjdWNPM4h0RKNc030KnCrM3JmGfjmKg0EuTyT4eNSq
	nNz5q3mX12Lf1v9XZFG5Y3c=
X-Google-Smtp-Source: APBJJlEJS+mb88B/XM5K0vDtjR9eSq8iiBjEwCZ4XLobbBS/yK2cT+fOKhc69MPJa0wWXAXqN4xmRQ==
X-Received: by 2002:a17:903:1248:b0:1b8:a74e:56ae with SMTP id u8-20020a170903124800b001b8a74e56aemr18294471plh.40.1691016947759;
        Wed, 02 Aug 2023 15:55:47 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:35d3])
        by smtp.gmail.com with ESMTPSA id r11-20020a1709028bcb00b001b7cbc5871csm12869266plo.53.2023.08.02.15.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 15:55:47 -0700 (PDT)
Date: Wed, 2 Aug 2023 15:55:45 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v1 bpf-next 6/7] [RFC] bpf: Allow bpf_spin_{lock,unlock}
 in sleepable prog's RCU CS
Message-ID: <20230802225545.fitfzzedt2clsf5n@MacBook-Pro-8.local>
References: <20230801203630.3581291-1-davemarchevsky@fb.com>
 <20230801203630.3581291-7-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801203630.3581291-7-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 01, 2023 at 01:36:29PM -0700, Dave Marchevsky wrote:
> Commit 9e7a4d9831e8 ("bpf: Allow LSM programs to use bpf spin locks")
> disabled bpf_spin_lock usage in sleepable progs, stating:
> 
>  Sleepable LSM programs can be preempted which means that allowng spin
>  locks will need more work (disabling preemption and the verifier
>  ensuring that no sleepable helpers are called when a spin lock is
>  held).
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
>   RFC: Does preemption still need to be disabled here?

Yes. __bpf_spin_lock() needs to disable it before arch_spin_lock.
Since some sleepable progs are reentrable we need to make sure the bpf prog
isn't preempted while spin_lock is held. Otherwise dead lock is possible.

> ]
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  kernel/bpf/verifier.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4bda365000d3..d1b8e8964aec 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8270,6 +8270,10 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  			verbose(env, "can't spin_{lock,unlock} in rbtree cb\n");
>  			return -EACCES;
>  		}
> +		if (!in_rcu_cs(env)) {
> +			verbose(env, "sleepable progs may only spin_{lock,unlock} in RCU CS\n");
> +			return -EACCES;
> +		}

I don't see the point requiring bpf_spin_lock only under RCU CS.
It seems below !sleepable check can be dropped without adding above hunk.

>  		if (meta->func_id == BPF_FUNC_spin_lock) {
>  			err = process_spin_lock(env, regno, true);
>  			if (err)
> @@ -16972,11 +16976,6 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
>  			verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
>  			return -EINVAL;
>  		}
> -
> -		if (prog->aux->sleepable) {
> -			verbose(env, "sleepable progs cannot use bpf_spin_lock yet\n");
> -			return -EINVAL;
> -		}
>  	}
>  
>  	if (btf_record_has_field(map->record, BPF_TIMER)) {
> -- 
> 2.34.1
> 

