Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A9A2D15CC
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 17:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgLGQOz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 11:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgLGQOz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 11:14:55 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9495FC061793
        for <bpf@vger.kernel.org>; Mon,  7 Dec 2020 08:14:14 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id k14so13327016wrn.1
        for <bpf@vger.kernel.org>; Mon, 07 Dec 2020 08:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xM+aZywcBdvQBaUe17dR3sYjKTkJecfKmvE4vEcfQUk=;
        b=tyrt6UO/mpDDN7h9qGocCXtFmEhnc4MsX7ndpcelJWl+gHXXz8IoS8fRe76cY3QwvN
         MSfJbywxm5/M33t3zJWC3YJ0dqEeGV0Mjse8/YEjj+1BvyVWThtDalGlZkPD1G3/yLiq
         mS0ds8bXBwbD1ZMxGjvr/GLn8jMy4jn3lbIpMWqevsTnV7m5283G/F/l1/0vJfzKkhI4
         OaATnaI9l6deeQ8rPUGaMn6DecsgkB3G8tYi43OvpWxzhcDQvEpAjZ9tjBo6q0rki7eu
         VPvFmh9i+ejUShkiZ9ZLu6jblbKJiigp+lGuKEErFVnMVkkikVDbgcoPg/dCQicLT+Dw
         VNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xM+aZywcBdvQBaUe17dR3sYjKTkJecfKmvE4vEcfQUk=;
        b=eVGllgDwSlvpo9dEtkOtm6n86tkasYDL5DrB2RiqtynCODSYxZXaMD+c6o91pGQOeE
         CvQzyKb0rScD4V3UMMwDnv+ROhjpNVn3S3r9RzU7v6oi2QVgp1SRNQG7QnJaJ+Ng6Bh7
         Nv2LcKeHkQ9dHN4t9/Gh247q0oAaCti77tPdqTuek66qVFuOdrH5aHMMAlzkdf5/MkcG
         YQsQFiYzTZOhZuc8l7m+bRj6uO3v7c+L+V7wX7jnjnLy6D5P3IDb/mCQ0zyd5iUk1H5D
         p1/It0515CZbFD8BAgWYlu+W8C8xIVHAyRZXdnXNMTF1qNW6PwPfMRr3xj/mk7TTx6mn
         AtYw==
X-Gm-Message-State: AOAM532qbPteX7EKyZnfgSRmUfTCDK9BPs6IXF6tMeaSeQDw5vmMsdwi
        /510ADZbWbJ/ly6APRF1Yhfn5A==
X-Google-Smtp-Source: ABdhPJw0SotK4YNvCfpZ+5ItfAFM5DVAoZ/JbPzjaIaeIRWGg0MQWlQOsHvzuoyKJnyjG5tfP7LUKA==
X-Received: by 2002:adf:8b8f:: with SMTP id o15mr20750726wra.311.1607357653084;
        Mon, 07 Dec 2020 08:14:13 -0800 (PST)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id f7sm357577wmc.1.2020.12.07.08.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:14:12 -0800 (PST)
Date:   Mon, 7 Dec 2020 16:14:08 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH bpf-next v3 10/14] bpf: Add bitwise atomic instructions
Message-ID: <X85U0AcIbTdw7UAO@google.com>
References: <20201203160245.1014867-1-jackmanb@google.com>
 <20201203160245.1014867-11-jackmanb@google.com>
 <86a88eba-83a1-93c0-490d-ceba238e3aad@fb.com>
 <X8oDEsEjU059T7+k@google.com>
 <534a6371-a5ed-2459-999b-90b8a8b773e8@fb.com>
 <X84R5DttN3WuHDYo@google.com>
 <881f46d7-b8c1-d718-660b-b4db61b98e29@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <881f46d7-b8c1-d718-660b-b4db61b98e29@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 07, 2020 at 07:58:09AM -0800, Yonghong Song wrote:
> 
> 
> On 12/7/20 3:28 AM, Brendan Jackman wrote:
> > On Fri, Dec 04, 2020 at 07:21:22AM -0800, Yonghong Song wrote:
> > > 
> > > 
> > > On 12/4/20 1:36 AM, Brendan Jackman wrote:
> > > > On Thu, Dec 03, 2020 at 10:42:19PM -0800, Yonghong Song wrote:
> > > > > 
> > > > > 
> > > > > On 12/3/20 8:02 AM, Brendan Jackman wrote:
> > > > > > This adds instructions for
> > > > > > 
> > > > > > atomic[64]_[fetch_]and
> > > > > > atomic[64]_[fetch_]or
> > > > > > atomic[64]_[fetch_]xor
> > > > > > 
> > > > > > All these operations are isomorphic enough to implement with the same
> > > > > > verifier, interpreter, and x86 JIT code, hence being a single commit.
> > > > > > 
> > > > > > The main interesting thing here is that x86 doesn't directly support
> > > > > > the fetch_ version these operations, so we need to generate a CMPXCHG
> > > > > > loop in the JIT. This requires the use of two temporary registers,
> > > > > > IIUC it's safe to use BPF_REG_AX and x86's AUX_REG for this purpose.
> > > > > > 
> > > > > > Change-Id: I340b10cecebea8cb8a52e3606010cde547a10ed4
> > > > > > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > > > > > ---
> > > > > >     arch/x86/net/bpf_jit_comp.c  | 50 +++++++++++++++++++++++++++++-
> > > > > >     include/linux/filter.h       | 60 ++++++++++++++++++++++++++++++++++++
> > > > > >     kernel/bpf/core.c            |  5 ++-
> > > > > >     kernel/bpf/disasm.c          | 21 ++++++++++---
> > > > > >     kernel/bpf/verifier.c        |  6 ++++
> > > > > >     tools/include/linux/filter.h | 60 ++++++++++++++++++++++++++++++++++++
> > > > > >     6 files changed, 196 insertions(+), 6 deletions(-)
> > > > > > 
> > > > [...]
> > > > > > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > > > > > index 6186280715ed..698f82897b0d 100644
> > > > > > --- a/include/linux/filter.h
> > > > > > +++ b/include/linux/filter.h
> > > > > > @@ -280,6 +280,66 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
> > > > [...]
> > > > > > +#define BPF_ATOMIC_FETCH_XOR(SIZE, DST, SRC, OFF)		\
> > > > > > +	((struct bpf_insn) {					\
> > > > > > +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> > > > > > +		.dst_reg = DST,					\
> > > > > > +		.src_reg = SRC,					\
> > > > > > +		.off   = OFF,					\
> > > > > > +		.imm   = BPF_XOR | BPF_FETCH })
> > > > > > +
> > > > > >     /* Atomic exchange, src_reg = atomic_xchg((dst_reg + off), src_reg) */
> > > > > 
> > > > > Looks like BPF_ATOMIC_XOR/OR/AND/... all similar to each other.
> > > > > The same is for BPF_ATOMIC_FETCH_XOR/OR/AND/...
> > > > > 
> > > > > I am wondering whether it makes sence to have to
> > > > > BPF_ATOMIC_BOP(BOP, SIZE, DST, SRC, OFF) and
> > > > > BPF_ATOMIC_FETCH_BOP(BOP, SIZE, DST, SRC, OFF)
> > > > > can have less number of macros?
> > > > 
> > > > Hmm yeah I think that's probably a good idea, it would be consistent
> > > > with the macros for non-atomic ALU ops.
> > > > 
> > > > I don't think 'BOP' would be very clear though, 'ALU' might be more
> > > > obvious.
> > > 
> > > BPF_ATOMIC_ALU and BPF_ATOMIC_FETCH_ALU indeed better.
> > 
> > On second thoughts I think it feels right (i.e. it would be roughly
> > consistent with the level of abstraction of the rest of this macro API)
> > to go further and just have two macros BPF_ATOMIC64 and BPF_ATOMIC32:
> > 
> > 	/*
> > 	 * Atomic ALU ops:
> > 	 *
> > 	 *   BPF_ADD                  *(uint *) (dst_reg + off16) += src_reg
> > 	 *   BPF_AND                  *(uint *) (dst_reg + off16) &= src_reg
> > 	 *   BPF_OR                   *(uint *) (dst_reg + off16) |= src_reg
> > 	 *   BPF_XOR                  *(uint *) (dst_reg + off16) ^= src_reg
> 
> "uint *" => "size_type *"?
> and give an explanation that "size_type" is either "u32" or "u64"?

"uint *" is already used in the file so I'll follow the precedent there.

> 
> > 	 *   BPF_ADD | BPF_FETCH      src_reg = atomic_fetch_add(dst_reg + off16, src_reg);
> > 	 *   BPF_AND | BPF_FETCH      src_reg = atomic_fetch_and(dst_reg + off16, src_reg);
> > 	 *   BPF_OR | BPF_FETCH       src_reg = atomic_fetch_or(dst_reg + off16, src_reg);
> > 	 *   BPF_XOR | BPF_FETCH      src_reg = atomic_fetch_xor(dst_reg + off16, src_reg);
> > 	 *   BPF_XCHG                 src_reg = atomic_xchg(dst_reg + off16, src_reg)
> > 	 *   BPF_CMPXCHG              r0 = atomic_cmpxchg(dst_reg + off16, r0, src_reg)
> > 	 */
> > 
> > 	#define BPF_ATOMIC64(OP, DST, SRC, OFF)                         \
> > 		((struct bpf_insn) {                                    \
> > 			.code  = BPF_STX | BPF_DW | BPF_ATOMIC,         \
> > 			.dst_reg = DST,                                 \
> > 			.src_reg = SRC,                                 \
> > 			.off   = OFF,                                   \
> > 			.imm   = OP })
> > 
> > 	#define BPF_ATOMIC32(OP, DST, SRC, OFF)                         \
> > 		((struct bpf_insn) {                                    \
> > 			.code  = BPF_STX | BPF_W | BPF_ATOMIC,         \
> > 			.dst_reg = DST,                                 \
> > 			.src_reg = SRC,                                 \
> > 			.off   = OFF,                                   \
> > 			.imm   = OP })
> 
> You could have
>   BPF_ATOMIC(OP, SIZE, DST, SRC, OFF)
> where SIZE is BPF_DW or BPF_W.

Ah sorry, I didn't see this mail and have just posted v4 with the 2
separate macros. Let's see if anyone else has an opinion on
this point.

> > 
> > The downside compared to what's currently in the patchset is that the
> > user can write e.g. BPF_ATOMIC64(BPF_SUB, BPF_REG_1, BPF_REG_2, 0) and
> > it will compile. On the other hand they'll get a pretty clear
> > "BPF_ATOMIC uses invalid atomic opcode 10" when they try to load the
> > prog, and the valid atomic ops are clearly listed in Documentation as
> > well as the comments here.
> 
> This should be fine. As you mentioned, documentation has mentioned
> what is supported and what is not...
