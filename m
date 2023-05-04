Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A116F632F
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 05:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjEDDO5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 23:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjEDDOb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 23:14:31 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A41F10D1
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 20:14:07 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-643846c006fso64313b3a.0
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 20:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683170044; x=1685762044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TUICe8NWWHYXYgrrKj5WOGZQy1/3vJzVlZyYDZC1mxg=;
        b=phDPmUstMuvFZyEVkxgi4QlOSIw64U9J2xEHOQnL5kYNu1QKffCil0+x02gyKPvXhV
         aor5AuuSKH9Dpi/qtgP2x5kDBcGulTV9e7vVechuhrhLAuMLlRU9IYEUjCb0ePF1zy/p
         /ATtD9SrJ2E5vL7vgsDsIHICN966nlQWlK1VVAFJn1KwCvfnll5FbUDFJKWPTXEnsQ4J
         f7Gptkrvz8yhRV30PoXKzRGA7wSQPsxMHFD1zU5jGP+zaYfEeI2AE/WRE0pCniv/DjDg
         Xz6qvKkvtPPTpWPnohDn2Qxom6aCe6uGSCtCgQA/NontS3wzJkpDIwNspbw0+WNyYSLV
         h1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683170044; x=1685762044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUICe8NWWHYXYgrrKj5WOGZQy1/3vJzVlZyYDZC1mxg=;
        b=BnNRHCvf067u8Zsj+GeIv3k2xQjfK1JJKo+Men2nBokGmtFHwr4/Ln24slecWL/X4L
         iFRPliZqkvPwdvs36pd4hTz/LFv42pnxiYOf6SoYsmDs7vwhqjp/T7td05uHJ5f4QsXR
         VgOcFGd1ZMMVuIJ+3EXB/elcoCkly/+7KNURQPCSvlmdAwCXZyOgFEhRzyX86lXAN52d
         wq/K2/bX2sdM8hIitjamz8VeqeoDx46+MvYplLUEnWc2DTqTOMR4oTuha6/HTg1twflz
         /JO0Olv1laciUKFD1tyj4MzvbkTf4ViIMGiiZtPZfLh8EihH/rpKHs2NskctcOD6dj3n
         wveg==
X-Gm-Message-State: AC+VfDwvcPNx15KpW3NyiGxcBZRJJh5efdFCp9ekznqwsqSkixN3Itwm
        Z74WieV9KXXC/qHcAoXBFOQ=
X-Google-Smtp-Source: ACHHUZ5xiR8d7Ul48Xb5awaOkm+6qGg+ITS3/j3k4+fe3jwDR/U3Uy7rA8x4aiNoNrSKBW3lRWgX3g==
X-Received: by 2002:a05:6a00:1913:b0:62a:c1fa:b253 with SMTP id y19-20020a056a00191300b0062ac1fab253mr839087pfi.31.1683170044113;
        Wed, 03 May 2023 20:14:04 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:396f])
        by smtp.gmail.com with ESMTPSA id y1-20020a056a001c8100b005a8173829d5sm24040620pfw.66.2023.05.03.20.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 20:14:03 -0700 (PDT)
Date:   Wed, 3 May 2023 20:14:01 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 06/10] bpf: fix propagate_precision() logic for
 inner frames
Message-ID: <20230504031401.pdfcnkjwke6bpjur@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230425234911.2113352-1-andrii@kernel.org>
 <20230425234911.2113352-7-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425234911.2113352-7-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 25, 2023 at 04:49:07PM -0700, Andrii Nakryiko wrote:
> Fix propagate_precision() logic to perform propagation of all necessary
> registers and stack slots across all active frames *in one batch step*.
> 
> Doing this for each register/slot in each individual frame is wasteful,
> but the main problem is that backtracking of instruction in any frame
> except the deepest one just doesn't work. This is due to backtracking
> logic relying on jump history, and available jump history always starts
> (or ends, depending how you view it) in current frame. So, if
> prog A (frame #0) called subprog B (frame #1) and we need to propagate
> precision of, say, register R6 (callee-saved) within frame #0, we
> actually don't even know where jump history that corresponds to prog
> A even starts. We'd need to skip subprog part of jump history first to
> be able to do this.
> 
> Luckily, with struct backtrack_state and __mark_chain_precision()
> handling bitmasks tracking/propagation across all active frames at the
> same time (added in previous patch), propagate_precision() can be both
> fixed and sped up by setting all the necessary bits across all frames
> and then performing one __mark_chain_precision() pass. This makes it
> unnecessary to skip subprog parts of jump history.
> 
> We also improve logging along the way, to clearly specify which
> registers' and slots' precision markings are propagated within which
> frame.
> 
> Fixes: 529409ea92d5 ("bpf: propagate precision across all frames, not just the last one")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/verifier.c | 49 +++++++++++++++++++++++++++----------------
>  1 file changed, 31 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0b19b3d9af65..66d64ac10fb1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3885,14 +3885,12 @@ int mark_chain_precision(struct bpf_verifier_env *env, int regno)
>  	return __mark_chain_precision(env, env->cur_state->curframe, regno, -1);
>  }
>  
> -static int mark_chain_precision_frame(struct bpf_verifier_env *env, int frame, int regno)
> +static int mark_chain_precision_batch(struct bpf_verifier_env *env, int frame)
>  {
> -	return __mark_chain_precision(env, frame, regno, -1);
> -}
> -
> -static int mark_chain_precision_stack_frame(struct bpf_verifier_env *env, int frame, int spi)
> -{
> -	return __mark_chain_precision(env, frame, -1, spi);
> +	/* we assume env->bt was set outside with desired reg and stack masks
> +	 * for all frames
> +	 */
> +	return __mark_chain_precision(env, frame, -1, -1);
>  }
>  
>  static bool is_spillable_regtype(enum bpf_reg_type type)
> @@ -15308,20 +15306,25 @@ static int propagate_precision(struct bpf_verifier_env *env,
>  	struct bpf_reg_state *state_reg;
>  	struct bpf_func_state *state;
>  	int i, err = 0, fr;
> +	bool first;
>  
>  	for (fr = old->curframe; fr >= 0; fr--) {
>  		state = old->frame[fr];
>  		state_reg = state->regs;
> +		first = true;
>  		for (i = 0; i < BPF_REG_FP; i++, state_reg++) {
>  			if (state_reg->type != SCALAR_VALUE ||
>  			    !state_reg->precise ||
>  			    !(state_reg->live & REG_LIVE_READ))
>  				continue;
> -			if (env->log.level & BPF_LOG_LEVEL2)
> -				verbose(env, "frame %d: propagating r%d\n", fr, i);
> -			err = mark_chain_precision_frame(env, fr, i);
> -			if (err < 0)
> -				return err;
> +			if (env->log.level & BPF_LOG_LEVEL2) {
> +				if (first)
> +					verbose(env, "frame %d: propagating r%d", fr, i);
> +				else
> +					verbose(env, ",r%d", i);
> +			}
> +			bt_set_frame_reg(&env->bt, fr, i);
> +			first = false;
>  		}
>  
>  		for (i = 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
> @@ -15332,14 +15335,24 @@ static int propagate_precision(struct bpf_verifier_env *env,
>  			    !state_reg->precise ||
>  			    !(state_reg->live & REG_LIVE_READ))
>  				continue;
> -			if (env->log.level & BPF_LOG_LEVEL2)
> -				verbose(env, "frame %d: propagating fp%d\n",
> -					fr, (-i - 1) * BPF_REG_SIZE);
> -			err = mark_chain_precision_stack_frame(env, fr, i);
> -			if (err < 0)
> -				return err;
> +			if (env->log.level & BPF_LOG_LEVEL2) {
> +				if (first)
> +					verbose(env, "frame %d: propagating fp%d",
> +						fr, (-i - 1) * BPF_REG_SIZE);
> +				else
> +					verbose(env, ",fp%d", (-i - 1) * BPF_REG_SIZE);
> +			}
> +			bt_set_frame_slot(&env->bt, fr, i);
> +			first = false;
>  		}
> +		if (!first)
> +			verbose(env, "\n");
>  	}
> +
> +	err = mark_chain_precision_batch(env, old->curframe);

The optimization makes sense, sort-of, but 'first' flag is to separate frames on
different lines ?
The code in propagate_precision() before mark_chain_precision_batch()
will only print '... propagating...' few times.
regs and stack will be on one line anyway.
Is it that ugly to print all frames on one line in practice?
The 2nd and 3rd frames will be on one line too. Only 1st frame is on its own line?
I'm not getting the idea of 'first'.
