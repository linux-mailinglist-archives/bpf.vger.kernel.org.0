Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7A72D23B2
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 07:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgLHGiV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Dec 2020 01:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgLHGiV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Dec 2020 01:38:21 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AEEC061749;
        Mon,  7 Dec 2020 22:37:41 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id y24so14984347otk.3;
        Mon, 07 Dec 2020 22:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=XHxE+9D2MV73874pg6D94J5O/5wRxrsY3k6+WdKxVCo=;
        b=ulXhPJ4GwaWmDj57S3kfauTXdQFc9pcBR2BItjRXtv1Y55Mc1TFlNeFD13ekQ6n4ZZ
         YIK9SUYem5L0qD4H1FepfFaHwZzwl0E4w2xI+SGCxv0OAcIESrpRBKnOCAJ2pZGTIe2j
         24PjHT7xoEWZHpK4u97FiWtvBx++C155sx86f0GgjYppubsyXvuAAL01Y2D7STxQWssP
         SnrPX+2TYAprsgM9IpdkBWOAAX/+1vK0gmVFy2TRKUt/5lP2bM/n+nEmIWst5cTCb7vV
         5djLHbjvU/QuPaqzDL/b1END4h0OndtoMNHuI8MUf/3auGez9h/Io2/2wcpeLA014MkM
         PWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=XHxE+9D2MV73874pg6D94J5O/5wRxrsY3k6+WdKxVCo=;
        b=DWYWkethavPFI8fKfU2PppWQBbwlCNzdTzzgBnmQr+dmJv/P3GJvUFeEBWtsDCZeYl
         1cFIyeWkjjiGXMtLoM3JJ4X+akcA8FVoEsupB/ODsuGxH/xHjaRCb+f7FKP4ZFCDU81F
         jIVzgC4qK5dZFfq28oco70g0j88RCiYPWEGUlc6Kk8xlqkGXDwgutjanB1Wq4uQpzXva
         xL8N1Ikx+S4dtxW3jkiPAClI1EXQFGdiPpOmopjgNS3zir3jU9M+ir9tnEV54+ctXXQH
         WYMqh1CnKDh81jGZdlIP4YtBzlv/M5fmfdOrG3j+p30cCmpMmsglGYqpI3RueZHMlIXy
         VDFQ==
X-Gm-Message-State: AOAM531wLNzK7BKV0KNcYEezpZukX8Kykl5b99C3KjQfcgZAJbutDyG/
        iCqqW+sWGAIgVUirURJumh4=
X-Google-Smtp-Source: ABdhPJz52XHCFNNeXCTDeFYlENOBVWasWiuxpqRScVNMq0zAREeo9Q95K/XxmBLfGhKL32UyBq+jkA==
X-Received: by 2002:a9d:2065:: with SMTP id n92mr15440932ota.150.1607409460685;
        Mon, 07 Dec 2020 22:37:40 -0800 (PST)
Received: from localhost ([184.21.204.5])
        by smtp.gmail.com with ESMTPSA id l21sm3439466otd.0.2020.12.07.22.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 22:37:40 -0800 (PST)
Date:   Mon, 07 Dec 2020 22:37:32 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Brendan Jackman <jackmanb@google.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Brendan Jackman <jackmanb@google.com>
Message-ID: <5fcf1f2cd24e1_9ab320888@john-XPS-13-9370.notmuch>
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

Just a nit as it looks like perhaps we get one more spin here. Would
be nice to be explicit about what the code does here. The above reads
like it could go either way. Just an extra line "So we use ...' would
be enough.

> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---

One question below.

>  arch/x86/net/bpf_jit_comp.c    |  8 ++++++++
>  include/linux/filter.h         | 22 ++++++++++++++++++++++
>  include/uapi/linux/bpf.h       |  4 +++-
>  kernel/bpf/core.c              | 20 ++++++++++++++++++++
>  kernel/bpf/disasm.c            | 15 +++++++++++++++
>  kernel/bpf/verifier.c          | 19 +++++++++++++++++--
>  tools/include/linux/filter.h   | 22 ++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  4 +++-
>  8 files changed, 110 insertions(+), 4 deletions(-)
> 

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f8c4e809297d..f5f4460b3e4e 100644
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

I need to think a bit more about it, but do we need to update is_reg64()
at all for these?

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
