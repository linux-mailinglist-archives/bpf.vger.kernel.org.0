Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A0D6F630B
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 04:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjEDCzo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 22:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEDCzn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 22:55:43 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF838E68
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 19:55:40 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-643465067d1so31747b3a.0
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 19:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683168940; x=1685760940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lz5o6fbo9E4OwYsU6QcPT/MTSPW6UQMsVdgsggLtimA=;
        b=f6H4inpp9XgUgvoZ7hlC9/qk2EKfDd77mJy7N2L+FpO5PKNWi9Ry49ETA1CwyxuEBa
         MaXryua304Kb2ZBf0SdhxpOJxnwgGzgThllo+8MvX/qxcXsckZE4GVACF0jQU4lPGNQy
         HX1BzsnoTuwoitvn1ZWTsuZC1oLr/nXbSrqnci9SNC2Wh9bMRYwdAHl0V+5DIYTOh47Z
         lrmV94xvFqUVt6H9FIuGy3y/AfeNXtQBNHnVlFtedlCY8pags00+WUwvxeSVVTWUVlwo
         V/Uzb93t1jFLnUh68+q1jpeoawGQ9PDjGf26G7pWF1/PX5zINjsiw8HMyrByT/UuddYX
         5o3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683168940; x=1685760940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lz5o6fbo9E4OwYsU6QcPT/MTSPW6UQMsVdgsggLtimA=;
        b=DfI7n5V2aBjzMTr7K6Nudbs0Soz9gSqZO3oD3+6ald6ZkwuWIz71J/Yk0LpdBDtWgE
         EhlD5hRLDC97SPv795aZq+tuG6gAm+lUJaMxjLN4DzkNDx2IpNAqKlc1WTuAKCUDVjdz
         2syBOHVR+LhWzIqUuxtCw4Jyx163h5rYI1vC/5m2OHMUs5l20ogUbiuMzn7Q2xasD+Mo
         9zSDkGMi7iMuU8puQEl4tDpYzM7tL7miJ9DcSj+Z/g0cLEnJamWLwmGMEUY7l9vPmsjo
         +XylOPAqtFbpXgCZ2D2leFD8OuqSB1zHdCzlXaS1EnPalQC/QoOXkibhrg1PMtmi9e2I
         X41A==
X-Gm-Message-State: AC+VfDzRhZHR3G+/nKyU6Bkogqw4318UjPfLYSPZYfu96d31Njs6Vxyd
        dk5AuvxV3b0zcREFakelybw=
X-Google-Smtp-Source: ACHHUZ4q+dnl3Oc63yyaihGGyFVTm2WJwVXQzD+2DIRTuyfEmw5gtJmE2idRSrBM8Bc1iUdq0NuMmQ==
X-Received: by 2002:a05:6a20:914e:b0:f3:8fc6:6562 with SMTP id x14-20020a056a20914e00b000f38fc66562mr954378pzc.7.1683168940199;
        Wed, 03 May 2023 19:55:40 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:396f])
        by smtp.gmail.com with ESMTPSA id q63-20020a632a42000000b0052c737ea9bbsm1116079pgq.39.2023.05.03.19.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 19:55:39 -0700 (PDT)
Date:   Wed, 3 May 2023 19:55:37 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 04/10] bpf: improve precision backtrack logging
Message-ID: <20230504025537.dr32drbhiqxffgc7@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230425234911.2113352-1-andrii@kernel.org>
 <20230425234911.2113352-5-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425234911.2113352-5-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 25, 2023 at 04:49:05PM -0700, Andrii Nakryiko wrote:
> Add helper to format register and stack masks in more human-readable
> format. Adjust logging a bit during backtrack propagation and especially
> during forcing precision fallback logic to make it clearer what's going
> on (with log_level=2, of course), and also start reporting affected
> frame depth. This is in preparation for having more than one active
> frame later when precision propagation between subprog calls is added.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf_verifier.h                  |  13 ++-
>  kernel/bpf/verifier.c                         |  72 ++++++++++--
>  .../testing/selftests/bpf/verifier/precise.c  | 106 +++++++++---------
>  3 files changed, 128 insertions(+), 63 deletions(-)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 185bfaf0ec6b..0ca367e13dd8 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -18,8 +18,11 @@
>   * that converting umax_value to int cannot overflow.
>   */
>  #define BPF_MAX_VAR_SIZ	(1 << 29)
> -/* size of type_str_buf in bpf_verifier. */
> -#define TYPE_STR_BUF_LEN 128
> +/* size of tmp_str_buf in bpf_verifier.
> + * we need at least 306 bytes to fit full stack mask representation
> + * (in the "-8,-16,...,-512" form)
> + */
> +#define TMP_STR_BUF_LEN 320
>  
>  /* Liveness marks, used for registers and spilled-regs (in stack slots).
>   * Read marks propagate upwards until they find a write mark; they record that
> @@ -621,8 +624,10 @@ struct bpf_verifier_env {
>  	/* Same as scratched_regs but for stack slots */
>  	u64 scratched_stack_slots;
>  	u64 prev_log_pos, prev_insn_print_pos;
> -	/* buffer used in reg_type_str() to generate reg_type string */
> -	char type_str_buf[TYPE_STR_BUF_LEN];
> +	/* buffer used to generate temporary string representations,
> +	 * e.g., in reg_type_str() to generate reg_type string
> +	 */
> +	char tmp_str_buf[TMP_STR_BUF_LEN];
>  };
>  
>  __printf(2, 0) void bpf_verifier_vlog(struct bpf_verifier_log *log,
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1cb89fe00507..8faf9170acf0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -604,9 +604,9 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
>  		 type & PTR_TRUSTED ? "trusted_" : ""
>  	);
>  
> -	snprintf(env->type_str_buf, TYPE_STR_BUF_LEN, "%s%s%s",
> +	snprintf(env->tmp_str_buf, TMP_STR_BUF_LEN, "%s%s%s",
>  		 prefix, str[base_type(type)], postfix);
> -	return env->type_str_buf;
> +	return env->tmp_str_buf;
>  }
>  
>  static char slot_type_char[] = {
> @@ -3275,6 +3275,45 @@ static inline bool bt_is_slot_set(struct backtrack_state *bt, u32 slot)
>  	return bt->stack_masks[bt->frame] & (1ull << slot);
>  }
>  
> +/* format registers bitmask, e.g., "r0,r2,r4" for 0x15 mask */
> +static void fmt_reg_mask(char *buf, ssize_t buf_sz, u32 reg_mask)
> +{
> +	DECLARE_BITMAP(mask, 64);
> +	bool first = true;
> +	int i, n;
> +
> +	buf[0] = '\0';
> +
> +	bitmap_from_u64(mask, reg_mask);
> +	for_each_set_bit(i, mask, 32) {
> +		n = snprintf(buf, buf_sz, "%sr%d", first ? "" : ",", i);
> +		first = false;
> +		buf += n;
> +		buf_sz -= n;
> +		if (buf_sz < 0)
> +			break;
> +	}
> +}
> +/* format stack slots bitmask, e.g., "-8,-24,-40" for 0x15 mask */
> +static void fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask)
> +{
> +	DECLARE_BITMAP(mask, 64);
> +	bool first = true;
> +	int i, n;
> +
> +	buf[0] = '\0';
> +
> +	bitmap_from_u64(mask, stack_mask);
> +	for_each_set_bit(i, mask, 64) {
> +		n = snprintf(buf, buf_sz, "%s%d", first ? "" : ",", -(i + 1) * 8);
> +		first = false;
> +		buf += n;
> +		buf_sz -= n;
> +		if (buf_sz < 0)
> +			break;
> +	}
> +}
> +
>  /* For given verifier state backtrack_insn() is called from the last insn to
>   * the first insn. Its purpose is to compute a bitmask of registers and
>   * stack slots that needs precision in the parent verifier state.
> @@ -3298,7 +3337,11 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
>  	if (insn->code == 0)
>  		return 0;
>  	if (env->log.level & BPF_LOG_LEVEL2) {
> -		verbose(env, "regs=%x stack=%llx before ", bt_reg_mask(bt), bt_stack_mask(bt));
> +		fmt_reg_mask(env->tmp_str_buf, TMP_STR_BUF_LEN, bt_reg_mask(bt));
> +		verbose(env, "mark_precise: frame%d: regs(0x%x)=%s ",
> +			bt->frame, bt_reg_mask(bt), env->tmp_str_buf);
> +		fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN, bt_stack_mask(bt));
> +		verbose(env, "stack(0x%llx)=%s before ", bt_stack_mask(bt), env->tmp_str_buf);

Let's drop (0x%llx) part from regs and stack.
With nice human readable addition no one will be reading the hex anymore.
It's just wasting screen real estate.

> +	"mark_precise: frame0: last_idx 26 first_idx 20\
> +	mark_precise: frame0: regs(0x4)=r2 stack(0x0)= before 25\
> +	mark_precise: frame0: regs(0x4)=r2 stack(0x0)= before 24\
> +	mark_precise: frame0: regs(0x4)=r2 stack(0x0)= before 23\
> +	mark_precise: frame0: regs(0x4)=r2 stack(0x0)= before 22\
> +	mark_precise: frame0: regs(0x4)=r2 stack(0x0)= before 20\
> +	parent didn't have regs=4 stack=0 marks:\
> +	mark_precise: frame0: last_idx 19 first_idx 10\
> +	mark_precise: frame0: regs(0x4)=r2 stack(0x0)= before 19\
> +	mark_precise: frame0: regs(0x200)=r9 stack(0x0)= before 18\
> +	mark_precise: frame0: regs(0x300)=r8,r9 stack(0x0)= before 17\
> +	mark_precise: frame0: regs(0x201)=r0,r9 stack(0x0)= before 15\
> +	mark_precise: frame0: regs(0x201)=r0,r9 stack(0x0)= before 14\
> +	mark_precise: frame0: regs(0x200)=r9 stack(0x0)= before 13\
> +	mark_precise: frame0: regs(0x200)=r9 stack(0x0)= before 12\
> +	mark_precise: frame0: regs(0x200)=r9 stack(0x0)= before 11\
> +	mark_precise: frame0: regs(0x200)=r9 stack(0x0)= before 10\
> +	parent already had regs=0 stack=0 marks:",

This part would be much cleaner without (0x...)
