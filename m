Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E676E58BD
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 07:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjDRFpQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 01:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjDRFpQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 01:45:16 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9E3423B
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 22:44:52 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id op30so16118760qvb.3
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 22:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681796691; x=1684388691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :references:from:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IiOZgk6jnwXmajgQZ+L1GPoK22YoYyTWz0n0rEZoPdo=;
        b=Up1UNKiZifKV/xPO3rzXGQ+rihujNepicf+4idK7rHuGqyMEbj/yyUfWFZPAVGR4aF
         HsUL4tOJHMCYVT2sb7sdFncToHOrM0xhk7htIFyor5IGw6mpc+5eVTuaqKzrbnverNgL
         kilnnwBgOkZaUU49u4KAmAQrejUOHw4PtFNfJnzwNnZJb3XTzGG7IxBxkxhbqSnjaV/t
         NkAN+OXcwQC3OuGlyF8mxrhCIDa5T66Ja/NzSJzYUtDPwRFYnVL5Q0Sgmh7yNZV0oRpo
         dg2hGxEUVzzWzRVQCDbKbNKZ8YgG3XTCC59tiDIadg5mdOTH+E8wkb6RRIkfJlQkYFLr
         Tmgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681796691; x=1684388691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :references:from:mime-version:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IiOZgk6jnwXmajgQZ+L1GPoK22YoYyTWz0n0rEZoPdo=;
        b=AQJhwRXBSEEBDyu2mFzm+QfuVHFJfo9QXd9Lw3w/N+KWzWuTAOPQzVbw/D43rYWRaQ
         zJeuSxmusmUrW5wKZDlEr4H87VSslgKpUsWlTKnVaKfvG/Bd/txTjAKBk+ED+AaodKtW
         IMu1gumpBh3QYs9Al+Q9cfkKm3mQ31X8IVdKf913cYiRTmKMshtLoXMELrQlYw98Imwx
         a5JJTHO3Jtur/aYeC0oayiXD2CG8GlHGRpXybA6gnr1Tra9KgOaMwiydJGHamzPSemg2
         VQMPl+D4f1g3+muZXg5dcsUUSS2W8wHZkoL1KoCVatEu3yT4ZBazRqDcVX0SUFriLrUk
         fCdQ==
X-Gm-Message-State: AAQBX9ds2I3IE4g8qXoGVTE7NKKgRaAv9uHA9SUhv+OfVJTLAHDtZHF1
        e4ydEgoluDqQCEiSTGRjKNAy3gZDPUbrSCu1mJuRtLZX9bhUaLY=
X-Google-Smtp-Source: AKy350Zs37lQTTrhf5dH/uqvHa3tLNDfP1gua4g6NB66QhJ7en6/0Iti1VAUOIYnXsDJTL4HO2+oM0qh2F+1Q/mKuxQ=
X-Received: by 2002:a05:6214:ca4:b0:5f1:5f73:aec2 with SMTP id
 s4-20020a0562140ca400b005f15f73aec2mr356620qvs.32.1681796691523; Mon, 17 Apr
 2023 22:44:51 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 17 Apr 2023 22:44:47 -0700
Mime-Version: 1.0
From:   =?UTF-8?B?5a6L6ZSQ?= <songrui.771@bytedance.com>
References: <20230417084449.99848-1-songrui.771@bytedance.com> <ZD09abW0YyHU3Snt@kroah.com>
In-Reply-To: <ZD09abW0YyHU3Snt@kroah.com>
Date:   Mon, 17 Apr 2023 22:44:47 -0700
Message-ID: <CAAz4JzKB7kMi=fRZYSG=b4km-xA2gdBF32TFxU-ubqaaTs+_Hw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] libbpf: correct the macro KERNEL_VERSION
 for old kernel
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> > The introduced header file linux/version.h in libbpf_probes.c may have =
a
> > wrong macro KERNEL_VERSION for calculating LINUX_VERSION_CODE in some o=
ld
> > kernel (Debian9, 10). Below is a version info example from Debian 10.
> >
> > release: 4.19.0-22-amd64
> > version: #1 SMP Debian 4.19.260-1 (2022-09-29)
> >
> > The macro KERNEL_VERSION is defined to (((a) << 16) + ((b) << 8)) + (c)=
),
> > which a, b, and c stand for major, minor and patch version. So in examp=
le here,
> > the major is 4, minor is 19, patch is 260, the LINUX_VERSION(4, 19, 260=
) which
> > is 267268 should be matched to LINUX_VERSION_CODE. However, the KERNEL_=
VERSION_CODE
> > in linux/version.h is defined to 267263.
> >
> > I noticed that the macro KERNEL_VERSION in linux/version.h of some new =
kernel is
> > defined to (((a) << 16) + ((b) << 8) + ((c) > 255 ? 255 : (c))). And
> > KERNEL_VERSION(4, 19, 260) is equal to 267263 which is the right LINUX_=
VERSION_CODE.
> >
> > The mismatched LINUX_VERSION_CODE which will cause failing to load kpro=
be BPF
> > programs in the version check of BPF syscall.
> >
> > The return value of get_kernel_version in libbpf_probes.c should be mat=
ched to
> > LINUX_VERSION_CODE by correcting the macro KERNEL_VERSION.
> >
> > Signed-off-by: songrui.771 <songrui.771@bytedance.com>
>
> This needs to be your name, not your email alias (do you use ".771" as a
> name to sign things with?)

Thanks for your reminding. I will change it.
>
> > ---
> >=C2=A0 tools/lib/bpf/libbpf_probes.c | 10 +++++++---
> >=C2=A0 1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probe=
s.c
> > index 4f3bc968ff8e..5b22a880c7e7 100644
> > --- a/tools/lib/bpf/libbpf_probes.c
> > +++ b/tools/lib/bpf/libbpf_probes.c
> > @@ -18,6 +18,10 @@
> >=C2=A0 #include "libbpf.h"
> >=C2=A0 #include "libbpf_internal.h"
> >
> > +#ifndef LIBBPF_KERNEL_VERSION
> > +#define LIBBPF_KERNEL_VERSION(a, b, c) (((a) << 16) + ((b) << 8) + ((c=
) > 255 ? 255 : (c)))
> > +#endif
>
> What is wrong with using the KERNEL_VERSION() macro, it should be fixed
> to work properly here, right?=C2=A0 Did we not get this resolved in the
> main portion of the kernel already?

The KERNEL_VERSION() macro from linux/version.h is wrong in some old
kernel(Debian 9, 10) that we would like to support. As you said, the
problem was resolved in the newer kernel. Here is the difference:

linux/version.h
in older kernel: #define KERNEL_VERSION(a, b, c) (((a) << 16) + ((b)
<< 8)) + (c)))
in newer kernel: #define KERNEL_VERSION(a, b, c) KERNEL_VERSION(a, b,
c) (((a) << 16) + ((b) << 8) + ((c) > 255 ? 255 : (c)))

Using the KERNEL_VERSION macro in the older kernel returns the kern
version=C2=A0 which is=C2=A0 mismatched to the LINUX_VERSION_CODE that will
cause failing to load the BPF kprobe program.

In my opinion, it is a more generic solution that corrects the
KERNEL_VERSION() macro in libbpf to support some old kernel.

Hope I make that clear. Thanks.

Jerry Song
