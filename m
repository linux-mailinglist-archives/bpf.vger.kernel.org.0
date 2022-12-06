Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74230644E7A
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 23:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiLFWTV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 17:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiLFWTS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 17:19:18 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154983721E
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 14:19:17 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id c13so8741466pfp.5
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 14:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCGP06TQOELv09RFi5pCoJC6OzdrjsDIenE0h6yreeI=;
        b=LIbm4pSopeoMqd9LuMGSjEgnv40xCI+IKtwgO/+i1L3l86BWs8wZrQRRieuGDr50c/
         Xg2EzZhzfND3YDvn54N0YWrC0pkngLw7mjzCJAWuewR2qvSc/LvBE0+nv9A4dDvFPuIj
         oHLR5Nz/3wdeB+UGAqG4pl4yAH1AUdOxal+JBmj647xY2ynIWKUhWMslCC/bN8mmEOSR
         ZF8FA65jSDa2QSYk/jswU8wTlgI03Wa4yQMtk139lfF8bzFb2ZLmPyTdp/eVRpz9sVqY
         /wa2PONUCHjj8muA3TUlWtjma54F61UMSitOOfhbLPjw4dSymgq6F2utx1yYuoSzgamr
         hL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aCGP06TQOELv09RFi5pCoJC6OzdrjsDIenE0h6yreeI=;
        b=P0nhjClpXdaImQEaGS1muYBp/r5/hOdhnJch7BKL3NwnFI1KwBdCV6v9gbOe9uYWwx
         uCo2KNlGYGYl0P6si/NMiOuiMklzY46rMBcoWWsxCETNR5a//GCbXv/x6YTlOyXK8Hpu
         AhjmJCfNwBZuTiZJmgdC7m58f+HM1hFUkFTZTs5CFlfCMxey4Ox1MXym0mFV0abSmitP
         NwBXV2IoS+pRl+D01McK9TrvZlTBzUUh2A5lZ2jqFD7GxG5WArkoQAfaqUhlZoG/nQZN
         Ew65poO4tzZtLAH77fD/XwJtNHAWGdWbJTD16X1mgJGo2R3HnT7Q7oP5PZIftH/7BycT
         MI4A==
X-Gm-Message-State: ANoB5pnLqDHsU/gmT9n7Mjk5kcygVS7PXMpdMZPEltDJRdyxy3ri1DUr
        eodVu8pksL0oepPK1O5HF20=
X-Google-Smtp-Source: AA0mqf6ESRbSZM5mDsq3qSg2KTkuD9jy+AXnUSssqu964T7ljR+tPSz5M7KJ+7YfePiGQaV9q/EvtA==
X-Received: by 2002:aa7:83c1:0:b0:563:b60:b097 with SMTP id j1-20020aa783c1000000b005630b60b097mr92371669pfn.36.1670365156503;
        Tue, 06 Dec 2022 14:19:16 -0800 (PST)
Received: from localhost ([129.95.247.247])
        by smtp.gmail.com with ESMTPSA id d12-20020a17090a2a4c00b0021952b5e9bcsm12979042pjg.53.2022.12.06.14.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 14:19:15 -0800 (PST)
Date:   Tue, 06 Dec 2022 14:19:14 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com
Message-ID: <638fbfe234d9b_8a91208f5@john.notmuch>
In-Reply-To: <20221202051030.3100390-4-andrii@kernel.org>
References: <20221202051030.3100390-1-andrii@kernel.org>
 <20221202051030.3100390-4-andrii@kernel.org>
Subject: RE: [PATCH bpf-next 3/3] bpf: remove unnecessary prune and jump
 points
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko wrote:
> Don't mark some instructions as jump points when there are actually no
> jumps and instructions are just processed sequentially. Such case is
> handled naturally by precision backtracking logic without the need to
> update jump history.
> 

Sorry having trouble matching up commit message with code below.

> Also remove both jump and prune point marking for instruction right
> after unconditional jumps, as program flow can get to the instruction
> right after unconditional jump instruction only if there is a jump to
> that instruction from somewhere else in the program. In such case we'll
> mark such instruction as prune/jump point because it's a destination of
> a jump.
> 
> This change has no changes in terms of number of instructions or states
> processes across Cilium and selftests programs.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/verifier.c | 24 ++++--------------------
>  1 file changed, 4 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 75a56ded5aca..03c2cc116292 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12209,13 +12209,10 @@ static int visit_func_call_insn(int t, int insn_cnt,
>  	if (ret)
>  		return ret;
>  
> -	if (t + 1 < insn_cnt) {
> -		mark_prune_point(env, t + 1);
> -		mark_jmp_point(env, t + 1);
> -	}
> +	mark_prune_point(env, t + 1);
> +
>  	if (visit_callee) {
>  		mark_prune_point(env, t);
> -		mark_jmp_point(env, t);
>  		ret = push_insn(t, t + insns[t].imm + 1, BRANCH, env,
>  				/* It's ok to allow recursion from CFG point of
>  				 * view. __check_func_call() will do the actual
> @@ -12249,15 +12246,13 @@ static int visit_insn(int t, int insn_cnt, struct bpf_verifier_env *env)
>  		return DONE_EXPLORING;
>  
>  	case BPF_CALL:
> -		if (insns[t].imm == BPF_FUNC_timer_set_callback) {
> +		if (insns[t].imm == BPF_FUNC_timer_set_callback)
>  			/* Mark this call insn to trigger is_state_visited() check

maybe fix the comment here?

>  			 * before call itself is processed by __check_func_call().
>  			 * Otherwise new async state will be pushed for further
>  			 * exploration.
>  			 */
>  			mark_prune_point(env, t);
> -			mark_jmp_point(env, t);
> -		}
>  		return visit_func_call_insn(t, insn_cnt, insns, env,
>  					    insns[t].src_reg == BPF_PSEUDO_CALL);
>  
> @@ -12271,26 +12266,15 @@ static int visit_insn(int t, int insn_cnt, struct bpf_verifier_env *env)
>  		if (ret)
>  			return ret;
>  
> -		/* unconditional jmp is not a good pruning point,
> -		 * but it's marked, since backtracking needs
> -		 * to record jmp history in is_state_visited().
> -		 */
>  		mark_prune_point(env, t + insns[t].off + 1);
>  		mark_jmp_point(env, t + insns[t].off + 1);
> -		/* tell verifier to check for equivalent states
> -		 * after every call and jump
> -		 */
> -		if (t + 1 < insn_cnt) {
> -			mark_prune_point(env, t + 1);
> -			mark_jmp_point(env, t + 1);

This makes sense to me its unconditional jmp. So no need to
add jmp point.

> -		}
>  
>  		return ret;
>  
>  	default:
>  		/* conditional jump with two edges */
>  		mark_prune_point(env, t);
> -		mark_jmp_point(env, t);

                 ^^^^^^^^^^^^^^^^^^^^^^^

Specifically, try to see why we dropped this jmp_point?

> +
>  		ret = push_insn(t, t + 1, FALLTHROUGH, env, true);
>  		if (ret)
>  			return ret;
> -- 
> 2.30.2
> 


