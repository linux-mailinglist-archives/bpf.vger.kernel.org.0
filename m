Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968E22D27B6
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 10:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgLHJcF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Dec 2020 04:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgLHJcF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Dec 2020 04:32:05 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20E6C0613D6
        for <bpf@vger.kernel.org>; Tue,  8 Dec 2020 01:31:24 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c198so1541908wmd.0
        for <bpf@vger.kernel.org>; Tue, 08 Dec 2020 01:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0vbqC0u2JWnbtIGEpLPfBL9KiWsE3RZwvKDpY4RGpF8=;
        b=kdoKB6JBLBTZ8b22lJh0msXPFZt5UtbsZb33+FNj5OAInJYHfXNLVFxlGwHJ4zFIT1
         HkTbyKnC+JUjwaf8ZeNhu9PAx90HlRUFvJ1SUffrJSmjatJHIub7B7rwaG0/M+FpfIQW
         UpSD7zzdi5DcxB5Jes2TGDsUy5slAEXZvBy+j7ykT8ac2xo0cme7FgvBPY6kS7gW1Fxu
         uPaG0DjAdPHiIlzzEeQPUezEZ6ZgnwpdC0EYotRTyfTTTkguRzmwxuFivID+fsw1TA8w
         wq4RLdZIq8xaYRB29xwrYOQm2r0uu7hJUa2VkS0lOcJy8UBZamlgPoMWuj5WO7/Q6pFN
         XHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0vbqC0u2JWnbtIGEpLPfBL9KiWsE3RZwvKDpY4RGpF8=;
        b=U25sKK30ZCSKQhMEa8T0dPmH/J0ValKD/aqo1xDjMRBoj1ihIpjaiFugKFGzFLRtlj
         rwJ642Krs04fpP5HffXmmEb4uO6piTdU4nlaT/qYuPC8bKls5UJdwMl2C+Bbw3rOupIP
         iahdDgYqAYl9+msVabv9uSZCdQ3WeFWBbZcRRnJEVFKj390xcWswzdU5336AKfAodwRq
         ++Pt6F8Ajmn01N9aFpsiCImmMdD6Xb8MFcJnpwWps3wJ4XXaTZ+enQ90PN/e4BDitFem
         0C2CPL6oRQ1E/S0ZouZ/G1857W5TSiqr6i+GGA/5nTGGrk6plyyg7YbtFF14SD+bClpB
         kYPA==
X-Gm-Message-State: AOAM530BF4nX5b+I3VtnssWFf43OOGjum1ZC+fkdF3zmx3ObvWaP9UmC
        AqZiCgsoi0g4FSUkuUWJSuvceQ==
X-Google-Smtp-Source: ABdhPJx1tn0cejKXc4GJWNJNSvJ9H7muYwgwMfEVdv5BDWHh4l/WblI6GJ5RZKzVE0by7dJ91gAlZQ==
X-Received: by 2002:a1c:e2c2:: with SMTP id z185mr3095349wmg.49.1607419883353;
        Tue, 08 Dec 2020 01:31:23 -0800 (PST)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id k11sm2370546wmj.42.2020.12.08.01.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 01:31:22 -0800 (PST)
Date:   Tue, 8 Dec 2020 09:31:18 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH bpf-next v4 06/11] bpf: Add BPF_FETCH field / create
 atomic_fetch_add instruction
Message-ID: <X89H5i6OaYoNaUhN@google.com>
References: <20201207160734.2345502-1-jackmanb@google.com>
 <20201207160734.2345502-7-jackmanb@google.com>
 <4163e34b-754a-5607-c28a-4c575a2cc6e5@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4163e34b-754a-5607-c28a-4c575a2cc6e5@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 07, 2020 at 05:41:05PM -0800, Yonghong Song wrote:
> 
> 
> On 12/7/20 8:07 AM, Brendan Jackman wrote:
> > The BPF_FETCH field can be set in bpf_insn.imm, for BPF_ATOMIC
> > instructions, in order to have the previous value of the
> > atomically-modified memory location loaded into the src register
> > after an atomic op is carried out.
> > 
> > Suggested-by: Yonghong Song <yhs@fb.com>
> > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > ---
> >   arch/x86/net/bpf_jit_comp.c    |  4 ++++
> >   include/linux/filter.h         |  1 +
> >   include/uapi/linux/bpf.h       |  3 +++
> >   kernel/bpf/core.c              | 13 +++++++++++++
> >   kernel/bpf/disasm.c            |  7 +++++++
> >   kernel/bpf/verifier.c          | 33 ++++++++++++++++++++++++---------
> >   tools/include/linux/filter.h   | 11 +++++++++++
> >   tools/include/uapi/linux/bpf.h |  3 +++
> >   8 files changed, 66 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> [...]
> 
> > index f345f12c1ff8..4e0100ba52c2 100644
> > --- a/tools/include/linux/filter.h
> > +++ b/tools/include/linux/filter.h
> > @@ -173,6 +173,7 @@
> >    * Atomic operations:
> >    *
> >    *   BPF_ADD                  *(uint *) (dst_reg + off16) += src_reg
> > + *   BPF_ADD | BPF_FETCH      src_reg = atomic_fetch_add(dst_reg + off16, src_reg);
> >    */
> >   #define BPF_ATOMIC64(OP, DST, SRC, OFF)				\
> > @@ -201,6 +202,16 @@
> >   		.off   = OFF,					\
> >   		.imm   = BPF_ADD })
> > +/* Atomic memory add with fetch, src_reg = atomic_fetch_add(dst_reg + off, src_reg); */
> > +
> > +#define BPF_ATOMIC_FETCH_ADD(SIZE, DST, SRC, OFF)		\
> > +	((struct bpf_insn) {					\
> > +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
> > +		.dst_reg = DST,					\
> > +		.src_reg = SRC,					\
> > +		.off   = OFF,					\
> > +		.imm   = BPF_ADD | BPF_FETCH })
> 
> Not sure whether it is a good idea or not to fold this into BPF_ATOMIC
> macro. At least you can define BPF_ATOMIC macro and
> #define BPF_ATOMIC_FETCH_ADD(SIZE, DST, SRC, OFF)		\
>     BPF_ATOMIC(SIZE, DST, SRC, OFF, BPF_ADD | BPF_FETCH)
> 
> to avoid too many code duplications?

Oops.. I intended to totally get rid these and folded them into
BPF_ATOMIC{64,32}! OK, let's combine all of them into a single macro.
It will have to be called something slightly awkward like
BPF_ATOMIC_INSN because BPF_ATOMIC is the name of the BPF_OP.

> 
> > +
> >   /* Memory store, *(uint *) (dst_reg + off16) = imm32 */
> >   #define BPF_ST_MEM(SIZE, DST, OFF, IMM)				\
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> > index 98161e2d389f..d5389119291e 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -44,6 +44,9 @@
> >   #define BPF_CALL	0x80	/* function call */
> >   #define BPF_EXIT	0x90	/* function return */
> > +/* atomic op type fields (stored in immediate) */
> > +#define BPF_FETCH	0x01	/* fetch previous value into src reg */
> > +
> >   /* Register numbers */
> >   enum {
> >   	BPF_REG_0 = 0,
> > 
