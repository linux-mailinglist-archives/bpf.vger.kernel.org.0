Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334F22CEB07
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 10:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgLDJhK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Dec 2020 04:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgLDJhK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Dec 2020 04:37:10 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4579CC061A4F
        for <bpf@vger.kernel.org>; Fri,  4 Dec 2020 01:36:24 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id e7so4641297wrv.6
        for <bpf@vger.kernel.org>; Fri, 04 Dec 2020 01:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BqEAYW4EhE3wh0Ne5/63R8wPgVuksOtShuZAIDQhCGE=;
        b=S/bvfu+UBmzPVOH8FvXjVYCbMQ+oE9In1/b1fjfitbAT7uurO4ps7Ol4fN+XYqfxkg
         tcjjJX+LJLxr7TANbvE0mUTZfEppcC6cZskSVG9bVpQRz+dJorDShgkpjuZL4X5K5vWf
         khnGBuOP1sR8d9+7NEkaSb6vh1ISsy9x5yM788EYDbWSNE3gM8TKuFWdbolK1ifkMXJ9
         ZGDP7Qd2VXLi/xyNPf+fkmynZCDr64hSLLG/TsMe/ihCOdmN4hWlaurx7Ai8OICSLehJ
         fp6GBjy49aSFtaLVrPfNtvxkjuwuAmf8PHVQi3nf/lCk1jVk4fxNN0U57TWCtEcDQUzC
         ikGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BqEAYW4EhE3wh0Ne5/63R8wPgVuksOtShuZAIDQhCGE=;
        b=uETv/Q8QhbN0y4szGKp/vGu692y8Z4FrtP5YlvbjRkZ/gCBbIOoGRC5jZAQXpBeKmb
         cjcA/EnWyTLPvi1yCTBCsIiKHV+QJP2C5uXELHCSyyRzVI9yTeTR0EpPdE65Nl4Qk+E8
         7iQbquG8+5QZ/G2BL39EAQGrh5m7oE134mXTazuSODZGGz+S+I+bwmahZ/CnhOB4d7pw
         M3lIIAtxeHMDv2bKhRdLtl7mdRpIcVUlm00C/C26QrAkBF3tloun1PWQiJ5c7+GidI+l
         ClJx/Ib2Rq3h2fErcTAkrRFXnFJmPn7tKeatuachCpX9FOEcSVLTBBp0j8G7WxAmAFE7
         ghtw==
X-Gm-Message-State: AOAM531lnb77nM5WYNweU5JzkfvluLLK9ogqdzR1rbMll4XuMksa/mj9
        5D2wGn/d/HtKkyDWRr2msjdm+Q==
X-Google-Smtp-Source: ABdhPJxh9HEmyniQ4XK8S1PRAIU24gKBgG7zElH2XSLs8a+fsCv5Ec22unZIwJnOfzYZZhEZc6tm5A==
X-Received: by 2002:adf:d18a:: with SMTP id v10mr1819650wrc.273.1607074582839;
        Fri, 04 Dec 2020 01:36:22 -0800 (PST)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id o67sm2458527wmo.31.2020.12.04.01.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 01:36:22 -0800 (PST)
Date:   Fri, 4 Dec 2020 09:36:18 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH bpf-next v3 10/14] bpf: Add bitwise atomic instructions
Message-ID: <X8oDEsEjU059T7+k@google.com>
References: <20201203160245.1014867-1-jackmanb@google.com>
 <20201203160245.1014867-11-jackmanb@google.com>
 <86a88eba-83a1-93c0-490d-ceba238e3aad@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86a88eba-83a1-93c0-490d-ceba238e3aad@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 03, 2020 at 10:42:19PM -0800, Yonghong Song wrote:
> 
> 
> On 12/3/20 8:02 AM, Brendan Jackman wrote:
> > This adds instructions for
> > 
> > atomic[64]_[fetch_]and
> > atomic[64]_[fetch_]or
> > atomic[64]_[fetch_]xor
> > 
> > All these operations are isomorphic enough to implement with the same
> > verifier, interpreter, and x86 JIT code, hence being a single commit.
> > 
> > The main interesting thing here is that x86 doesn't directly support
> > the fetch_ version these operations, so we need to generate a CMPXCHG
> > loop in the JIT. This requires the use of two temporary registers,
> > IIUC it's safe to use BPF_REG_AX and x86's AUX_REG for this purpose.
> > 
> > Change-Id: I340b10cecebea8cb8a52e3606010cde547a10ed4
> > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > ---
> >   arch/x86/net/bpf_jit_comp.c  | 50 +++++++++++++++++++++++++++++-
> >   include/linux/filter.h       | 60 ++++++++++++++++++++++++++++++++++++
> >   kernel/bpf/core.c            |  5 ++-
> >   kernel/bpf/disasm.c          | 21 ++++++++++---
> >   kernel/bpf/verifier.c        |  6 ++++
> >   tools/include/linux/filter.h | 60 ++++++++++++++++++++++++++++++++++++
> >   6 files changed, 196 insertions(+), 6 deletions(-)
> > 
[...]
> > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > index 6186280715ed..698f82897b0d 100644
> > --- a/include/linux/filter.h
> > +++ b/include/linux/filter.h
> > @@ -280,6 +280,66 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
[...]
> > +#define BPF_ATOMIC_FETCH_XOR(SIZE, DST, SRC, OFF)		\
> > +	((struct bpf_insn) {					\
> > +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> > +		.dst_reg = DST,					\
> > +		.src_reg = SRC,					\
> > +		.off   = OFF,					\
> > +		.imm   = BPF_XOR | BPF_FETCH })
> > +
> >   /* Atomic exchange, src_reg = atomic_xchg((dst_reg + off), src_reg) */
> 
> Looks like BPF_ATOMIC_XOR/OR/AND/... all similar to each other.
> The same is for BPF_ATOMIC_FETCH_XOR/OR/AND/...
> 
> I am wondering whether it makes sence to have to
> BPF_ATOMIC_BOP(BOP, SIZE, DST, SRC, OFF) and
> BPF_ATOMIC_FETCH_BOP(BOP, SIZE, DST, SRC, OFF)
> can have less number of macros?

Hmm yeah I think that's probably a good idea, it would be consistent
with the macros for non-atomic ALU ops.

I don't think 'BOP' would be very clear though, 'ALU' might be more
obvious.

