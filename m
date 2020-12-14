Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4E62D9B4B
	for <lists+bpf@lfdr.de>; Mon, 14 Dec 2020 16:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408123AbgLNPk2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Dec 2020 10:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405532AbgLNPkZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Dec 2020 10:40:25 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F06C0613D6
        for <bpf@vger.kernel.org>; Mon, 14 Dec 2020 07:39:45 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id g25so9237884wmh.1
        for <bpf@vger.kernel.org>; Mon, 14 Dec 2020 07:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2v32g2+g7NoLmT8mxjxrPYHTmiFDOu5TOwqsKq+Dn9A=;
        b=hUbI8Ekux1+83kBcz/BLKSbyR4vWDK3ljGxKYXbgy0jh/qOUGA7N/ng2qcMiHloqpj
         ulHWUbjePLyQjTdqIxbCCpwVPoDYPjimP35imvKHPuSGR0+TQJM4k7qmLNB1OUcNGZZu
         0wrwAs1Mvm83sZnBw9n32QiDmxOu9Y+ly4wtx9lKLJslN1Qb2be2YF1SbDECWjXIlaHO
         iUdos3kdwfQ60lxnVKi+a+TeWJf0GB8N18kHnie2YQ9ph2CvFm2NlvZKQ84fnWJ0Z4cC
         zo13AmCntjE8D94yih7Gvbhwi4uWJgx9QRPQsFQOlwLDptA264Qnw9k6AHDngXvDQFRv
         SDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2v32g2+g7NoLmT8mxjxrPYHTmiFDOu5TOwqsKq+Dn9A=;
        b=Spw4wvi4p9bI4CWOSUlrbP2k4s48hgptNlJOAIV/767PFLtdud07t3AQ94fzEe/lnJ
         s3kd7PERObIGZN9xqmoZLhrIYqofNTQBPjP3CtbKearBq4vzCMNJWkp7y05/aUu5bWD/
         01iwCt7RmPzqw7REWBu4Zt/wQq4W2iUBwp+QZK9fSAxycYRqBg1VIgZ3vw9WNVKLT/22
         vru8c9Ze7MVVoeU5roA08bxhTBhSbzmhh5L6qTdjwRptCKxgOAmIgfETpL/a44KaLZ2v
         j+Bkmr/snn53xcIdz4XiScmbZD3rLRzznqHisVVMIL+hgc0I9uUxwf66grUo2c7+vIaf
         lwjw==
X-Gm-Message-State: AOAM530v/6q8AWzPMY8DByDxB+8Yna9uaTCZsTyQ3ph9U1+NsNIi1Neq
        h1rzbcSTTD4jVcWXAF+TSMXKVHFrGLH2bQ==
X-Google-Smtp-Source: ABdhPJyRq2ZTBw8ZjNk+E44MrgpYVEcJr6tNgAlw6huK6vn97GZ8bBow9UGvOPHtXUpghzGxwkbxHg==
X-Received: by 2002:a1c:2d8b:: with SMTP id t133mr27809264wmt.127.1607960383787;
        Mon, 14 Dec 2020 07:39:43 -0800 (PST)
Received: from google.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id k1sm3911631wrn.46.2020.12.14.07.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 07:39:42 -0800 (PST)
Date:   Mon, 14 Dec 2020 15:39:38 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH bpf-next v4 07/11] bpf: Add instructions for
 atomic_[cmp]xchg
Message-ID: <X9eHOu2xwMT9m//z@google.com>
References: <20201207160734.2345502-1-jackmanb@google.com>
 <20201207160734.2345502-8-jackmanb@google.com>
 <5fcf1f2cd24e1_9ab320888@john-XPS-13-9370.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fcf1f2cd24e1_9ab320888@john-XPS-13-9370.notmuch>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Seems I never replied to this, thanks for the reviews!

On Mon, Dec 07, 2020 at 10:37:32PM -0800, John Fastabend wrote:
> Brendan Jackman wrote:
> > This adds two atomic opcodes, both of which include the BPF_FETCH
> > flag. XCHG without the BPF_FETCH flag would naturally encode
> > atomic_set. This is not supported because it would be of limited
> > value to userspace (it doesn't imply any barriers). CMPXCHG without
> > BPF_FETCH woulud be an atomic compare-and-write. We don't have such
> > an operation in the kernel so it isn't provided to BPF either.
> > 
> > There are two significant design decisions made for the CMPXCHG
> > instruction:
> > 
> >  - To solve the issue that this operation fundamentally has 3
> >    operands, but we only have two register fields. Therefore the
> >    operand we compare against (the kernel's API calls it 'old') is
> >    hard-coded to be R0. x86 has similar design (and A64 doesn't
> >    have this problem).
> > 
> >    A potential alternative might be to encode the other operand's
> >    register number in the immediate field.
> > 
> >  - The kernel's atomic_cmpxchg returns the old value, while the C11
> >    userspace APIs return a boolean indicating the comparison
> >    result. Which should BPF do? A64 returns the old value. x86 returns
> >    the old value in the hard-coded register (and also sets a
> >    flag). That means return-old-value is easier to JIT.
> 
> Just a nit as it looks like perhaps we get one more spin here. Would
> be nice to be explicit about what the code does here. The above reads
> like it could go either way. Just an extra line "So we use ...' would
> be enough.

Ack, adding the note.

> > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > ---
> 
> One question below.
> 
> >  arch/x86/net/bpf_jit_comp.c    |  8 ++++++++
> >  include/linux/filter.h         | 22 ++++++++++++++++++++++
> >  include/uapi/linux/bpf.h       |  4 +++-
> >  kernel/bpf/core.c              | 20 ++++++++++++++++++++
> >  kernel/bpf/disasm.c            | 15 +++++++++++++++
> >  kernel/bpf/verifier.c          | 19 +++++++++++++++++--
> >  tools/include/linux/filter.h   | 22 ++++++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h |  4 +++-
> >  8 files changed, 110 insertions(+), 4 deletions(-)
> > 
> 
> [...]
> 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index f8c4e809297d..f5f4460b3e4e 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -3608,11 +3608,14 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
> >  
> >  static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_insn *insn)
> >  {
> > +	int load_reg;
> >  	int err;
> >  
> >  	switch (insn->imm) {
> >  	case BPF_ADD:
> >  	case BPF_ADD | BPF_FETCH:
> > +	case BPF_XCHG:
> > +	case BPF_CMPXCHG:
> >  		break;
> >  	default:
> >  		verbose(env, "BPF_ATOMIC uses invalid atomic opcode %02x\n", insn->imm);
> > @@ -3634,6 +3637,13 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
> >  	if (err)
> >  		return err;
> >  
> > +	if (insn->imm == BPF_CMPXCHG) {
> > +		/* Check comparison of R0 with memory location */
> > +		err = check_reg_arg(env, BPF_REG_0, SRC_OP);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> 
> I need to think a bit more about it, but do we need to update is_reg64()
> at all for these?

I don't think so - this all falls into the same
`if (class == BPF_STX)` case as the existing BPF_STX_XADD instruction.

> >  	if (is_pointer_value(env, insn->src_reg)) {
> >  		verbose(env, "R%d leaks addr into mem\n", insn->src_reg);
> >  		return -EACCES;
> > @@ -3664,8 +3674,13 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
> >  	if (!(insn->imm & BPF_FETCH))
> >  		return 0;
> >  
> > -	/* check and record load of old value into src reg  */
> > -	err = check_reg_arg(env, insn->src_reg, DST_OP);
> > +	if (insn->imm == BPF_CMPXCHG)
> > +		load_reg = BPF_REG_0;
> > +	else
> > +		load_reg = insn->src_reg;
> > +
> > +	/* check and record load of old value */
> > +	err = check_reg_arg(env, load_reg, DST_OP);
> >  	if (err)
> >  		return err;
