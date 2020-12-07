Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A862D0F05
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 12:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgLGL3d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 06:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbgLGL3c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 06:29:32 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FC1C061A54
        for <bpf@vger.kernel.org>; Mon,  7 Dec 2020 03:28:42 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id g25so9358312wmh.1
        for <bpf@vger.kernel.org>; Mon, 07 Dec 2020 03:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uHU8ebv9ZwzgWtYFikVpZiNJ4prcda3hg71IDSFXm/E=;
        b=lKZLmN1YLmJ5CMELdnMLtS4Q5UeEj9a5mB0BIZ7rsgDlKVpOB93vBf2NtffgGBnfdq
         xM026KHpsrhDdmcsFH+GhWXj9aBcw/2LL6A4p+VUu4R/AjGj0E1ZB94aZy2vpBfDUMk/
         SsqbdQrUSQ8v+V3GC8CkIf2zu+K36lu+vUO9zdZ8hxO5IEBaYf2tHbtGPFgpWukhnruU
         JVwUeO/W3g4sTbwn5K+r9ehLFHZOYxIF883yledKhYG8XWPNVPoxlNLB6Sqb6TCD175/
         ggWfSdJncdSACYAgSdTKzlo+s/vTTUJAAtwB0SsQwMoxhFrNWab4d/leaAQ8Bd83txfz
         pbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uHU8ebv9ZwzgWtYFikVpZiNJ4prcda3hg71IDSFXm/E=;
        b=HL0zP4pPRmkwbXWPFVzKAAwnXHCAh27uNx88WpWM5v5JtcNZLiHoZ73V2nejib4nXY
         r8d8xZtrNEUHmJl1SWrBCJULFVOHKfZ6pptWnrwpsIwKRWcX50vgaJd4kT6wgghfBXDk
         o9vVJR/EFdm0jp50W7QeA+78LSFOLTzyzpg+sShpSKavGLvJSUO67IVElwb1KJ7B9pV4
         vXcfsQovwX8xXxxthhcZdOwIWN0vghixKP4jdMvg5mcbewHHpPvNy/KlKKyGXa/RHU+1
         YVnCZZL+Lijoeut/Czl8eeBUl9tvfQF3dnHnLnk/l0uilE9F5M3W0rWAuoyf74yvhZsM
         nGlA==
X-Gm-Message-State: AOAM531oZBL8L/ZRqg3BkxUFf+iBKSxrT2wc//CWo/x8YkKdseVWSVSU
        sD/sPzvKqCFfA1qjXOMrPZB3Bw==
X-Google-Smtp-Source: ABdhPJyJ9tuZHfKVa7CqR/qTSOyOI7GfCSP46VmGYfbnFlylpaOfb8RbZt+ItLdAEW0Z/P7QNxkVsA==
X-Received: by 2002:a1c:b742:: with SMTP id h63mr17815588wmf.122.1607340521106;
        Mon, 07 Dec 2020 03:28:41 -0800 (PST)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id f4sm13449427wmb.47.2020.12.07.03.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 03:28:40 -0800 (PST)
Date:   Mon, 7 Dec 2020 11:28:36 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH bpf-next v3 10/14] bpf: Add bitwise atomic instructions
Message-ID: <X84R5DttN3WuHDYo@google.com>
References: <20201203160245.1014867-1-jackmanb@google.com>
 <20201203160245.1014867-11-jackmanb@google.com>
 <86a88eba-83a1-93c0-490d-ceba238e3aad@fb.com>
 <X8oDEsEjU059T7+k@google.com>
 <534a6371-a5ed-2459-999b-90b8a8b773e8@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <534a6371-a5ed-2459-999b-90b8a8b773e8@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 04, 2020 at 07:21:22AM -0800, Yonghong Song wrote:
> 
> 
> On 12/4/20 1:36 AM, Brendan Jackman wrote:
> > On Thu, Dec 03, 2020 at 10:42:19PM -0800, Yonghong Song wrote:
> > > 
> > > 
> > > On 12/3/20 8:02 AM, Brendan Jackman wrote:
> > > > This adds instructions for
> > > > 
> > > > atomic[64]_[fetch_]and
> > > > atomic[64]_[fetch_]or
> > > > atomic[64]_[fetch_]xor
> > > > 
> > > > All these operations are isomorphic enough to implement with the same
> > > > verifier, interpreter, and x86 JIT code, hence being a single commit.
> > > > 
> > > > The main interesting thing here is that x86 doesn't directly support
> > > > the fetch_ version these operations, so we need to generate a CMPXCHG
> > > > loop in the JIT. This requires the use of two temporary registers,
> > > > IIUC it's safe to use BPF_REG_AX and x86's AUX_REG for this purpose.
> > > > 
> > > > Change-Id: I340b10cecebea8cb8a52e3606010cde547a10ed4
> > > > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > > > ---
> > > >    arch/x86/net/bpf_jit_comp.c  | 50 +++++++++++++++++++++++++++++-
> > > >    include/linux/filter.h       | 60 ++++++++++++++++++++++++++++++++++++
> > > >    kernel/bpf/core.c            |  5 ++-
> > > >    kernel/bpf/disasm.c          | 21 ++++++++++---
> > > >    kernel/bpf/verifier.c        |  6 ++++
> > > >    tools/include/linux/filter.h | 60 ++++++++++++++++++++++++++++++++++++
> > > >    6 files changed, 196 insertions(+), 6 deletions(-)
> > > > 
> > [...]
> > > > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > > > index 6186280715ed..698f82897b0d 100644
> > > > --- a/include/linux/filter.h
> > > > +++ b/include/linux/filter.h
> > > > @@ -280,6 +280,66 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
> > [...]
> > > > +#define BPF_ATOMIC_FETCH_XOR(SIZE, DST, SRC, OFF)		\
> > > > +	((struct bpf_insn) {					\
> > > > +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> > > > +		.dst_reg = DST,					\
> > > > +		.src_reg = SRC,					\
> > > > +		.off   = OFF,					\
> > > > +		.imm   = BPF_XOR | BPF_FETCH })
> > > > +
> > > >    /* Atomic exchange, src_reg = atomic_xchg((dst_reg + off), src_reg) */
> > > 
> > > Looks like BPF_ATOMIC_XOR/OR/AND/... all similar to each other.
> > > The same is for BPF_ATOMIC_FETCH_XOR/OR/AND/...
> > > 
> > > I am wondering whether it makes sence to have to
> > > BPF_ATOMIC_BOP(BOP, SIZE, DST, SRC, OFF) and
> > > BPF_ATOMIC_FETCH_BOP(BOP, SIZE, DST, SRC, OFF)
> > > can have less number of macros?
> > 
> > Hmm yeah I think that's probably a good idea, it would be consistent
> > with the macros for non-atomic ALU ops.
> > 
> > I don't think 'BOP' would be very clear though, 'ALU' might be more
> > obvious.
> 
> BPF_ATOMIC_ALU and BPF_ATOMIC_FETCH_ALU indeed better.

On second thoughts I think it feels right (i.e. it would be roughly
consistent with the level of abstraction of the rest of this macro API)
to go further and just have two macros BPF_ATOMIC64 and BPF_ATOMIC32:

	/*
	 * Atomic ALU ops:
	 *
	 *   BPF_ADD                  *(uint *) (dst_reg + off16) += src_reg
	 *   BPF_AND                  *(uint *) (dst_reg + off16) &= src_reg
	 *   BPF_OR                   *(uint *) (dst_reg + off16) |= src_reg
	 *   BPF_XOR                  *(uint *) (dst_reg + off16) ^= src_reg
	 *   BPF_ADD | BPF_FETCH      src_reg = atomic_fetch_add(dst_reg + off16, src_reg);
	 *   BPF_AND | BPF_FETCH      src_reg = atomic_fetch_and(dst_reg + off16, src_reg);
	 *   BPF_OR | BPF_FETCH       src_reg = atomic_fetch_or(dst_reg + off16, src_reg);
	 *   BPF_XOR | BPF_FETCH      src_reg = atomic_fetch_xor(dst_reg + off16, src_reg);
	 *   BPF_XCHG                 src_reg = atomic_xchg(dst_reg + off16, src_reg)
	 *   BPF_CMPXCHG              r0 = atomic_cmpxchg(dst_reg + off16, r0, src_reg)
	 */

	#define BPF_ATOMIC64(OP, DST, SRC, OFF)                         \
		((struct bpf_insn) {                                    \
			.code  = BPF_STX | BPF_DW | BPF_ATOMIC,         \
			.dst_reg = DST,                                 \
			.src_reg = SRC,                                 \
			.off   = OFF,                                   \
			.imm   = OP })

	#define BPF_ATOMIC32(OP, DST, SRC, OFF)                         \
		((struct bpf_insn) {                                    \
			.code  = BPF_STX | BPF_W | BPF_ATOMIC,         \
			.dst_reg = DST,                                 \
			.src_reg = SRC,                                 \
			.off   = OFF,                                   \
			.imm   = OP })

The downside compared to what's currently in the patchset is that the
user can write e.g. BPF_ATOMIC64(BPF_SUB, BPF_REG_1, BPF_REG_2, 0) and
it will compile. On the other hand they'll get a pretty clear
"BPF_ATOMIC uses invalid atomic opcode 10" when they try to load the
prog, and the valid atomic ops are clearly listed in Documentation as
well as the comments here.
