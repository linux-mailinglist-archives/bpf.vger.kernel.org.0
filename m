Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1922D23B9
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 07:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgLHGm5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Dec 2020 01:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgLHGm5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Dec 2020 01:42:57 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34204C061749;
        Mon,  7 Dec 2020 22:42:11 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id d8so7044581otq.6;
        Mon, 07 Dec 2020 22:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=GHGxlyc9EsC37JwbegkZqr7jGQdGFYOwxkgqYx90MSM=;
        b=khMqjn8XFM3wXwNerjZdteRluOxbgVrO255TekQJBKHqEG4eRFH/2fZY1vil/jVsQq
         n/Vl8tDhkFawgivSqDCpOAZfdKC72fw9sh4ajL47G+Pu1XGKwU81TRKGFVOVo4V6J6P3
         HkfJybWiRrFqji/JDvvOqPUghlYQiaEOCog8IbiELJ8+nysn1KsIPxB7Yp3R2svfoT2F
         fIV4kGq3WTV/f1cCqr4C26giyHO/NMb0B1JkGQidVuH5jz1SU8SbglIPxMCUqn19sZ1g
         XCQ5cQaVVpXa/IHZ6FCmC04jX5vqLAnNjif2Msx2j8MewjA1igk3UPIkZb229Zor6mBm
         x4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=GHGxlyc9EsC37JwbegkZqr7jGQdGFYOwxkgqYx90MSM=;
        b=pbvhn2DbKG+1eEVU97eaaAdPLMPw2YN1POr2FwyU3KDf+pLU6K/4Ri1AszH7YDc9sx
         oZgPjaf1XxfXUPR3PIhgnX7iTaaNaLzsCad/uyfaT3FRCFnlCt66RQ3TH0Mc1F0c5Saj
         i7ABzqDtdjEO1xSKVlqmawCzeuYXgdotyr5ak2CC0LxcVl0azO9aFB5l8QijRIdsbrbF
         8zZxPvGUtIHt9nKhhP0bq0sz8JJPda6IdregFO5wWXiTVg9BxAi5n2oBsmhifX1p8tE/
         l19U8QkwYeWoe1iJ0jazVNgFNaIQl99+ubIrU0yUet4K43zxRh3FypjLjyJFcCWXVo5T
         YI2Q==
X-Gm-Message-State: AOAM531PhQA1sCUoYIrkIjF7FsaIkgN6dy0gSOM+Ign2Dc3HB9e+amqc
        IdANOVkX8O9G4XLk2UQa37U=
X-Google-Smtp-Source: ABdhPJzhoxk6OeXWhDdD+pSpD0FxTfnqsQjv5SlnNFWdEZ8g5jZ1uJcmMPmTgcr1WwlcYEo2vnDZHg==
X-Received: by 2002:a05:6830:1482:: with SMTP id s2mr5848385otq.296.1607409730674;
        Mon, 07 Dec 2020 22:42:10 -0800 (PST)
Received: from localhost ([184.21.204.5])
        by smtp.gmail.com with ESMTPSA id u141sm318252oie.46.2020.12.07.22.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 22:42:10 -0800 (PST)
Date:   Mon, 07 Dec 2020 22:42:02 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Brendan Jackman <jackmanb@google.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Brendan Jackman <jackmanb@google.com>
Message-ID: <5fcf203ab087a_d22720855@john-XPS-13-9370.notmuch>
In-Reply-To: <20201207160734.2345502-8-jackmanb@google.com>
References: <20201207160734.2345502-1-jackmanb@google.com>
 <20201207160734.2345502-8-jackmanb@google.com>
Subject: RE: [PATCH bpf-next v4 07/11] bpf: Add instructions for
 atomic_[cmp]xchg
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Brendan Jackman wrote:
> This adds two atomic opcodes, both of which include the BPF_FETCH
> flag. XCHG without the BPF_FETCH flag would naturally encode
> atomic_set. This is not supported because it would be of limited
> value to userspace (it doesn't imply any barriers). CMPXCHG without
> BPF_FETCH woulud be an atomic compare-and-write. We don't have such
> an operation in the kernel so it isn't provided to BPF either.
> 
> There are two significant design decisions made for the CMPXCHG
> instruction:
> 
>  - To solve the issue that this operation fundamentally has 3
>    operands, but we only have two register fields. Therefore the
>    operand we compare against (the kernel's API calls it 'old') is
>    hard-coded to be R0. x86 has similar design (and A64 doesn't
>    have this problem).
> 
>    A potential alternative might be to encode the other operand's
>    register number in the immediate field.
> 
>  - The kernel's atomic_cmpxchg returns the old value, while the C11
>    userspace APIs return a boolean indicating the comparison
>    result. Which should BPF do? A64 returns the old value. x86 returns
>    the old value in the hard-coded register (and also sets a
>    flag). That means return-old-value is easier to JIT.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---

Sorry if this is a dup, client crashed while I sent the previous version
and don't see it on the list.

> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3608,11 +3608,14 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>  
>  static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_insn *insn)
>  {
> +	int load_reg;
>  	int err;
>  
>  	switch (insn->imm) {
>  	case BPF_ADD:
>  	case BPF_ADD | BPF_FETCH:
> +	case BPF_XCHG:
> +	case BPF_CMPXCHG:
>  		break;
>  	default:
>  		verbose(env, "BPF_ATOMIC uses invalid atomic opcode %02x\n", insn->imm);
> @@ -3634,6 +3637,13 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
>  	if (err)
>  		return err;
>  
> +	if (insn->imm == BPF_CMPXCHG) {
> +		/* Check comparison of R0 with memory location */
> +		err = check_reg_arg(env, BPF_REG_0, SRC_OP);
> +		if (err)
> +			return err;
> +	}
> +

Need to think a bit more on this, but do we need to update is_reg64() here
as well?

>  	if (is_pointer_value(env, insn->src_reg)) {
>  		verbose(env, "R%d leaks addr into mem\n", insn->src_reg);
>  		return -EACCES;
> @@ -3664,8 +3674,13 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
>  	if (!(insn->imm & BPF_FETCH))
>  		return 0;
>  
> -	/* check and record load of old value into src reg  */
> -	err = check_reg_arg(env, insn->src_reg, DST_OP);
> +	if (insn->imm == BPF_CMPXCHG)
> +		load_reg = BPF_REG_0;
> +	else
> +		load_reg = insn->src_reg;
> +
> +	/* check and record load of old value */
> +	err = check_reg_arg(env, load_reg, DST_OP);
>  	if (err)
>  		return err;
>  

Thanks,
John
