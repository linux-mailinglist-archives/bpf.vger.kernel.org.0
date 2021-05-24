Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676E838F3BC
	for <lists+bpf@lfdr.de>; Mon, 24 May 2021 21:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbhEXTce (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 May 2021 15:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbhEXTcd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 May 2021 15:32:33 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91372C061574
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 12:31:05 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id a8so20873241ioa.12
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 12:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=wxJUgjAFyUoSdqwPJeQTByXuVrMTvm1+UctDNsaArdw=;
        b=aaBgrnn9B7fGto9H++jE0oZUaiJ9eZUhIsdz99ByQonkITaX470mCWc5/LFjioFXpM
         LKCqssgQDxypb9bWmOVDxGUIRG5CASWUHYJ+L57TghZbHjMm23ZDgLOF7eIcKahZSrHo
         T+GT4OQwyH87MHEfvYxPMEVqY1TXVm2Rg8UnSoqWaxc3uZVgL8zE6j9oDSO5nPLiomDz
         Z0+zQWIFt3l0owW40F9OmbOspGxM8O6aRwWH28bFaAVcKLvYGa+P3GmRwb8xjvuNJ2cj
         KWJE7BdUkeQR75IETNaCOGT0kIgxfX7VpurZu1pEbL995ZHyxL8LXZ2IbSWuc+X2YUjo
         hjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=wxJUgjAFyUoSdqwPJeQTByXuVrMTvm1+UctDNsaArdw=;
        b=Yw5A5oRdZtQlEIxoOuMn1OXu8nFdG/jHU0cIXWW/nVRw4zgp+3fjXMpJk7J7Qs0lbb
         Pqf9r3qXmnmBWun80yP+rZfzsgCYBxfjX7UZhXvDyt2q4JSQNPulbEPAykaBwEdW4TtF
         Pl7aRVY91NdrxhGy1FrWIfje/OMSckwZKSw7RXR+dGVorlpIe1D4jU6SwXU4iPa4QWHD
         vZZAIzLoB1Xs0/GhTgXi0uk/7g+677o82Y+GGH0JWBa5U27rRZ/M4Y/xuGfMmYdB4kBZ
         vjmVUPi/vJgWtcBgt9TcwaLPnO45cx0AmfCvM+kr5qAunJ0/8idWwce7iertfPBkx9Zp
         qkbA==
X-Gm-Message-State: AOAM5330K/JzweMUhL0kukLFAOFSno5PMXDHOGdgKZp7K9eAxvob4cSC
        4QJT6xtPQTi1U1mlEKFCHS0=
X-Google-Smtp-Source: ABdhPJwRvvHQIs3LRuyEydXTMf/CXLXkNMyd3DyIQHuBUWs3akYXKU09L3hFiHiHLbq3Cet5jHuvCw==
X-Received: by 2002:a02:83c2:: with SMTP id j2mr25979790jah.6.1621884664816;
        Mon, 24 May 2021 12:31:04 -0700 (PDT)
Received: from localhost ([172.242.244.146])
        by smtp.gmail.com with ESMTPSA id r9sm11798385ilo.52.2021.05.24.12.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 12:31:04 -0700 (PDT)
Date:   Mon, 24 May 2021 12:30:55 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>
Message-ID: <60abfeef59a6c_135f6208b8@john-XPS-13-9370.notmuch>
In-Reply-To: <CAEf4BzYd4GLOQTJOeK_=yAs7+DPC+R7cxynOmd7ZMvcRFG+8SQ@mail.gmail.com>
References: <CACAyw9-GQasDdE9m_f3qXCO1UrR49YuF_6K1tjGxyk+ZZGhM-Q@mail.gmail.com>
 <CAEf4BzYd4GLOQTJOeK_=yAs7+DPC+R7cxynOmd7ZMvcRFG+8SQ@mail.gmail.com>
Subject: Re: Portability of bpf_tracing.h
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko wrote:
> On Mon, May 24, 2021 at 8:05 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
> >
> > Hi Andrii,
> >
> > A user of bpf2go [1] recently ran into the problem of PT_REGS not
> > being defined after including bpf_tracing.h. It turns out this is
> > because we by default compile for bpfel / bpfeb so the logic in the
> > header file doesn't kick in. I originally filed [2] as a quick fix,
> > but looking at the issue some more made me wonder how to fit this into
> > bpf2go better.
> >
> > Basically, the convention of bpf2go is that the compiled BPF is
> > checked into the source code repository to facilitate distributing BPF
> > as part of Go packages (as opposed to libbpf tooling which doesn't
> > include generated source). To make this portable, bpf2go by default
> > generates both bpfel and bpfeb variants of the C.
> >
> > However, code using bpf_tracing.h is inherently non-portable since the
> > fields of struct pt_regs differ in name between platforms. It seems
> > like this forces one to compile to each possible __TARGET_ARCH
> > separately. If that is correct, could we extend CO-RE somehow to cover
> > this as well?
> 
> If there are enums/types/fields that we can use to reliably detect the
> platform, then yes, we can have a new set of helpers that would do
> this with CO-RE. Someone will need to investigate how to do that for
> all the platforms we have. It's all about finding something that's
> already in the kernel and can server as a reliably indicator of a
> target architecture.
> 
> >
> > If that isn't possible, I want to avoid compiling and shipping BPF for
> > each possible __TARGET_ARCH_xxx by default. Instead I would like to
> > achieve:
> > * Code that doesn't use bpf_tracing.h is distributed in bpfel and bpfeb variants
> > * Code that uses bpf_tracing.h has to explicitly opt into the
> > supported platforms via a flag to bpf2go
> >
> > The latter point is because the go tooling has to know the target arch
> > to be able to generate the correct Go wrappers. How would you feel
> > about adding something like the following to bpf_tracing.h:
> 
> Well, obviously I'm not a fan of even more magic #defines. But I think
> we can achieve a similar effect with a more "lazy" approach. I.e., if
> user tries to use PT_REGS_xxx macros but doesn't specify the platform
> -- only then it gets compilation errors. There is stuff in
> bpf_tracing.h that doesn't need pt_regs, so we can't just outright do
> #error unconditinally. But we can do something like this:
> 
> #else /* !bpf_target_defined */
> 
> #define PT_REGS_PARM1(x) _Pragma("GCC error \"blah blah something
> user-facing\"")
> 
> ... and so on for all macros
> 
> #endif
> 
> Thoughts?

I don't use bpf_tracing.h, but...

Can we do this similar to feature discovery and simply have the
user space tell us the platform? I at least do this fairly
frequently so have infra in place on my side for user space to
push down feature flags/fields. One of those could be platform then
we just need helpers,

  get_pt_regs_parm() {
    if (bpf_target_defined == is_x86)
     ...
    else if (bpf_target_defined == is_foo)
     ...
    else {
      hard_load_error()
    }
  }
    
I think we are suggesting the same thing? Then user would need to
have bpf_target_Defined set but that should be OK and the other
conditions should all look like dead code.

> 
> 
> While on the topic, I've noticed that we added BPF_SEQ_PRINTF and
> BPF_SNPRINTF into bpf_tracing.h, which seems like not the best fit
> (definitely not for BPF_SNPRINTF). Florent, can you please help moving
> them into bpf_helpers.h, as it's really more generic functionality
> rather than low-level tracing primitives. I think it was put here
> because we needed ___bpf_narg macros, but I'd rather copy/paste them
> into bpf_helpers.h (they won't change at all) and put
> BPF_SNPRINTF/BPF_SEQ_PRINTF into bpf_helpers.h.
> 
> >
> > --- a/tools/lib/bpf/bpf_tracing.h
> > +++ b/tools/lib/bpf/bpf_tracing.h
> > @@ -25,6 +25,9 @@
> >         #define bpf_target_sparc
> >         #define bpf_target_defined
> >  #else
> > +       #if defined(BPF_REQUIRE_EXPLICIT_TARGET_ARCH)
> > +               #error BPF_REQUIRE_EXPLICIT_TARGET_ARCH set and no
> > target arch defined
> > +       #endif
> >         #undef bpf_target_defined
> >  #endif
> >
> > bpf2go would always define BPF_REQUIRE_EXPLICIT_TARGET_ARCH. If the
> > user included bpf_tracing.h they get this error. They can then add
> > -target amd64, etc. and the tooling then defines __TARGET_ARCH_x86_64
> >
> > 1: https://pkg.go.dev/github.com/cilium/ebpf/cmd/bpf2go
> > 2: https://github.com/cilium/ebpf/issues/305
> >
> > --
> > Lorenz Bauer  |  Systems Engineer
> > 6th Floor, County Hall/The Riverside Building, SE1 7PB, UK
> >
> > www.cloudflare.com


