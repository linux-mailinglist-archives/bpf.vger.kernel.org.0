Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7F06F6305
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 04:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjEDCxP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 22:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEDCxO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 22:53:14 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F110BE4E
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 19:53:12 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64384274895so21025b3a.2
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 19:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683168792; x=1685760792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rI1nmThTALjLb4yiGEnt/u8i/RipddozPHzaD2QhlcA=;
        b=FbhbpwT9oGhAuEf8r3KZ7LTm+SYqTAEL0l626TvJh0NgLBifQsuJ45pCf/x9vZM3Y/
         ioOugnv4veeJOMSF7wbzJ2w4j06ebskELhreMtIg9oDwoSr0vVM1zAk1HAdsavc4awIe
         d6VM7JQvtO4zgNJ7buG+cM+mEviw/9tlkhGqmNK6R7avsNbl3fjPYyKeX5E1ECqo1B5b
         q1zumMyavqi+GeuYAQOY6WKz+SU839oyDT2Ho0R1g1nd9O7vik8DdhP6/aR78WePqSD4
         Te/hmC5yjl83V2MNMaypY0K0vbadm6KCdcomR8S4eErL9d8hSGEIlirqEwZ2UXEHEGYC
         +8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683168792; x=1685760792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rI1nmThTALjLb4yiGEnt/u8i/RipddozPHzaD2QhlcA=;
        b=mC3IU6ahV1/VTv959u9o18RoUxcLkYA1FyQbMggfsO9kmB55jVNaJamjcwJaILcQf/
         LMhsKfhXaT2vUv7gz3PfMf7d1+nc+H9+H7gs+EApNv/nmHoydHHqOob5aJ7a6U+qdceP
         YfCzWrGMZwHuTJ6LvRHhdExYhnZVG2wR77Gq5VKIiyE3Cg50s6Zt/Ny0rjhgVNNJjSir
         GMmztb9XPBdjlSnyHZtKDDlWX6NKkkAZ+DWNTdPYBH3FwW86hJRz3Dg+YduDS9ksFkws
         k/Zzrhtrtl+m7mqvqVq7JeARNU3VqQ8E+mxB3VAT2rM3U2bPHjvaNAGCikQHPFGLa7cM
         6xNQ==
X-Gm-Message-State: AC+VfDyzk8AtEL8GbBDG5F8Odvnziiu0sMYS+8pZuITkZFp7r57mgFR/
        VrJX1qjguPhWR45z/1CPmHs=
X-Google-Smtp-Source: ACHHUZ6ljPTc8l16dGAJ0orWxC7YRQfE+0WX3abYM8qUXeTxdrF+L8TrJ71nbdFhMxUz3CWlXkysxA==
X-Received: by 2002:a05:6a00:1901:b0:624:2e60:f21e with SMTP id y1-20020a056a00190100b006242e60f21emr725178pfi.29.1683168792190;
        Wed, 03 May 2023 19:53:12 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:396f])
        by smtp.gmail.com with ESMTPSA id g4-20020a056a001a0400b0062a7462d398sm25093045pfv.170.2023.05.03.19.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 19:53:11 -0700 (PDT)
Date:   Wed, 3 May 2023 19:53:09 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 03/10] bpf: encapsulate precision backtracking
 bookkeeping
Message-ID: <20230504025309.actotyekpawodfar@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230425234911.2113352-1-andrii@kernel.org>
 <20230425234911.2113352-4-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425234911.2113352-4-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Few early comments so far...

On Tue, Apr 25, 2023 at 04:49:04PM -0700, Andrii Nakryiko wrote:
> Add struct backtrack_state and straightforward API around it to keep
> track of register and stack masks used and maintained during precision
> backtracking process. Having this logic separately allow to keep
> high-level backtracking algorithm cleaner, but also it sets us up to
> cleanly keep track of register and stack masks per frame, allowing (with
> some further logic adjustments) to perform precision backpropagation
> across multiple frames (i.e., subprog calls).
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf_verifier.h |  15 ++
>  kernel/bpf/verifier.c        | 258 ++++++++++++++++++++++++++---------
>  2 files changed, 206 insertions(+), 67 deletions(-)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 3dd29a53b711..185bfaf0ec6b 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -238,6 +238,10 @@ enum bpf_stack_slot_type {
>  
>  #define BPF_REG_SIZE 8	/* size of eBPF register in bytes */
>  
> +#define BPF_REGMASK_ARGS ((1 << BPF_REG_1) | (1 << BPF_REG_2) | \
> +			  (1 << BPF_REG_3) | (1 << BPF_REG_4) | \
> +			  (1 << BPF_REG_5))
> +
>  #define BPF_DYNPTR_SIZE		sizeof(struct bpf_dynptr_kern)
>  #define BPF_DYNPTR_NR_SLOTS		(BPF_DYNPTR_SIZE / BPF_REG_SIZE)
>  
> @@ -541,6 +545,16 @@ struct bpf_subprog_info {
>  	bool is_async_cb;
>  };
>  
> +struct bpf_verifier_env;
> +
> +struct backtrack_state {
> +	struct bpf_verifier_env *env;
> +	u32 frame;
> +	u32 bitcnt;
> +	u32 reg_masks[MAX_CALL_FRAMES];
> +	u64 stack_masks[MAX_CALL_FRAMES];
> +};
> +
>  /* single container for all structs
>   * one verifier_env per bpf_check() call
>   */
> @@ -578,6 +592,7 @@ struct bpf_verifier_env {
>  		int *insn_stack;
>  		int cur_stack;
>  	} cfg;
> +	struct backtrack_state bt;
>  	u32 pass_cnt; /* number of times do_check() was called */
>  	u32 subprog_cnt;
>  	/* number of instructions analyzed by the verifier */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fea6fe4acba2..1cb89fe00507 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1254,6 +1254,12 @@ static bool is_spilled_reg(const struct bpf_stack_state *stack)
>  	return stack->slot_type[BPF_REG_SIZE - 1] == STACK_SPILL;
>  }
>  
> +static bool is_spilled_scalar_reg(const struct bpf_stack_state *stack)
> +{
> +	return stack->slot_type[BPF_REG_SIZE - 1] == STACK_SPILL &&
> +	       stack->spilled_ptr.type == SCALAR_VALUE;
> +}
> +
>  static void scrub_spilled_slot(u8 *stype)
>  {
>  	if (*stype != STACK_INVALID)
> @@ -3144,12 +3150,137 @@ static const char *disasm_kfunc_name(void *data, const struct bpf_insn *insn)
>  	return btf_name_by_offset(desc_btf, func->name_off);
>  }
>  
> +static inline void bt_init(struct backtrack_state *bt, u32 frame)
> +{
> +	bt->frame = frame;
> +}
> +
> +static inline void bt_reset(struct backtrack_state *bt)
> +{
> +	struct bpf_verifier_env *env = bt->env;
> +	memset(bt, 0, sizeof(*bt));
> +	bt->env = env;
> +}
> +
> +static inline u32 bt_bitcnt(struct backtrack_state *bt)
> +{
> +	return bt->bitcnt;
> +}

I could have missed it, but it doesn't look that any further patch uses
the actual number of bits set.
All uses are: if (bt_bitcnt(bt) != 0)

Hence keeping bitcnt as extra 4 bytes and doing ++, -- on it
seems wasteful.
Maybe rename bt_bitcnt into bt_empty or bt_non_empty that
will do !!bt->reg_masks[bt->frame] | !!bt->stack_masks[bt->frame]


> +static inline int bt_subprog_enter(struct backtrack_state *bt)
> +{
> +	if (bt->frame == MAX_CALL_FRAMES - 1) {
> +		verbose(bt->env, "BUG subprog enter from frame %d\n", bt->frame);
> +		WARN_ONCE(1, "verifier backtracking bug");
> +		return -EFAULT;
> +	}
> +	bt->frame++;
> +	return 0;
> +}
> +
> +static inline int bt_subprog_exit(struct backtrack_state *bt)
> +{
> +	if (bt->frame == 0) {
> +		verbose(bt->env, "BUG subprog exit from frame 0\n");
> +		WARN_ONCE(1, "verifier backtracking bug");
> +		return -EFAULT;
> +	}
> +	bt->frame--;
> +	return 0;
> +}
> +
> +static inline void bt_set_frame_reg(struct backtrack_state *bt, u32 frame, u32 reg)
> +{
> +	if (bt->reg_masks[frame] & (1 << reg))
> +		return;
> +
> +	bt->reg_masks[frame] |= 1 << reg;
> +	bt->bitcnt++;
> +}

It doesnt' look that any further patch is using bt_set_frame_reg with explicit frame.
If not, collapse bt_set_frame_reg and bt_set_reg ?

> +
> +static inline void bt_clear_frame_reg(struct backtrack_state *bt, u32 frame, u32 reg)
> +{
> +	if (!(bt->reg_masks[frame] & (1 << reg)))
> +		return;
> +
> +	bt->reg_masks[frame] &= ~(1 << reg);
> +	bt->bitcnt--;
> +}

If we remove ++,-- of bitcnt this function will be much shorter and faster:
+static inline void bt_clear_frame_reg(struct backtrack_state *bt, u32 frame, u32 reg)
+{
+	bt->reg_masks[frame] &= ~(1 << reg);
+}

Removing runtime conditional has a nice perf benefit. Obviously tiny in a grand scheme, but still.

Overall it's a nice cleanup.
