Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077696E5984
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 08:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjDRGie (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 02:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjDRGid (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 02:38:33 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36F73AA8
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 23:38:30 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id ok10so6137403qvb.11
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 23:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681799910; x=1684391910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :in-reply-to:mime-version:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YxCMCoI/kAx0ckzmXQbM3Vjb4R3V2PpBz3elfSnUog=;
        b=WrW1n/Ts3oxys6+jw7I3YC2Gh86xeRqAkUmoq7rFeH2NiOMjPVvcZVZ1hEFv8ElqLr
         HI+a0bo7eCxoB4kyDxVth7Rv3T1yrw0OAU8gdirSCdX8jgErHiUT73il+jys4JLQNpH3
         Mt6+cnViFmZnPT8AgWoqtH3n5SIIYOPZ4amEHnNHrzBA0ZMFJxPqhbJ7wFrh6bNZw/ja
         js5jkOaxEG7lz5W7x8SrpeTgBJB3cIysPGjJxtrUO9FAm/VwG/OEBYXdKvPzNnG8wV8r
         5ZIXB6qP5ZzYzXxWxuHdlSi/puEnqqt0vKikQD/iu4fJrGLey7RsGONHU3T+8fhUagSm
         VSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681799910; x=1684391910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :in-reply-to:mime-version:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2YxCMCoI/kAx0ckzmXQbM3Vjb4R3V2PpBz3elfSnUog=;
        b=Xz+h4eN3MtkTT/Ym+uYm6D4asCUui+XFWV48ogGH4o/AO3mH+iH5np6vI8CPbvM7er
         7Aa3r95PUiCab/tKUc3VH136Z+/4GHNOWlVeecpPsCcMcpsRXDVfLLVKwL6ttolMndBd
         qPzU29Ujz3fdYGSlFn+WQtpZRxoLlM+F/H8bFgVUGSEuGY98onQl7VlgKYCCxQO99GW0
         mmWHagS79k5SVMYhbs1zB3mTd0S65PTpGuwTmUSbTTGNTmMsU6bysfNsvaQ9cUBQVWAi
         tfFTu0SCq7a0JuTA2ILInRidKfjT1hIjv1sF3ZWRdfzwAhP3jI3fyC3a2fvA0Y86eKZ8
         J9aA==
X-Gm-Message-State: AAQBX9dgUfthLZ4INDsVZ3+jhhUP+LnVmpl7pOmR/CSbvTDIz/RajUuP
        X3vegWan1yw22LMB/Gk7mWMr6/A1qrnEYxmV6I+v
X-Google-Smtp-Source: AKy350Ye7GFqtQD//0IAm6vyvh3nZDrp0hAaS7yYMrEfy14+2qdMezLiEXI5eSwB2iicD9bxy3OZTtOXFluAQQuwxHg=
X-Received: by 2002:a05:6214:c89:b0:5ef:4254:d6f0 with SMTP id
 r9-20020a0562140c8900b005ef4254d6f0mr21206763qvr.36.1681799910109; Mon, 17
 Apr 2023 23:38:30 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 17 Apr 2023 23:38:29 -0700
From:   =?UTF-8?B?5a6L6ZSQ?= <songrui.771@bytedance.com>
Mime-Version: 1.0
In-Reply-To: <ZD4z_pS3fur-owIT@kroah.com>
References: <20230417084449.99848-1-songrui.771@bytedance.com>
 <ZD09abW0YyHU3Snt@kroah.com> <CAAz4JzKB7kMi=fRZYSG=b4km-xA2gdBF32TFxU-ubqaaTs+_Hw@mail.gmail.com>
 <ZD4z_pS3fur-owIT@kroah.com>
Date:   Mon, 17 Apr 2023 23:38:29 -0700
Message-ID: <CAAz4JzL24ibnrfW_Vz0mvr5ZVszdH_gT7URO2KDuW2WDvBERkg@mail.gmail.com>
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

> > > > The introduced header file linux/version.h in libbpf_probes.c may h=
ave a
> > > > wrong macro KERNEL_VERSION for calculating LINUX_VERSION_CODE in so=
me old
> > > > kernel (Debian9, 10). Below is a version info example from Debian 1=
0.
> > > >
> > > > release: 4.19.0-22-amd64
> > > > version: #1 SMP Debian 4.19.260-1 (2022-09-29)
> > > >
> > > > The macro KERNEL_VERSION is defined to (((a) << 16) + ((b) << 8)) +=
 (c)),
> > > > which a, b, and c stand for major, minor and patch version. So in e=
xample here,
> > > > the major is 4, minor is 19, patch is 260, the LINUX_VERSION(4, 19,=
 260) which
> > > > is 267268 should be matched to LINUX_VERSION_CODE. However, the KER=
NEL_VERSION_CODE
> > > > in linux/version.h is defined to 267263.
> > > >
> > > > I noticed that the macro KERNEL_VERSION in linux/version.h of some =
new kernel is
> > > > defined to (((a) << 16) + ((b) << 8) + ((c) > 255 ? 255 : (c))). An=
d
> > > > KERNEL_VERSION(4, 19, 260) is equal to 267263 which is the right LI=
NUX_VERSION_CODE.
> > > >
> > > > The mismatched LINUX_VERSION_CODE which will cause failing to load =
kprobe BPF
> > > > programs in the version check of BPF syscall.
> > > >
> > > > The return value of get_kernel_version in libbpf_probes.c should be=
 matched to
> > > > LINUX_VERSION_CODE by correcting the macro KERNEL_VERSION.
> > > >
> > > > Signed-off-by: songrui.771 <songrui.771@bytedance.com>
> > >
> > > This needs to be your name, not your email alias (do you use ".771" a=
s a
> > > name to sign things with?)
> >
> > Thanks for your reminding. I will change it.
> > >
> > > > ---
> > > >=C2=A0 tools/lib/bpf/libbpf_probes.c | 10 +++++++---
> > > >=C2=A0 1 file changed, 7 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_p=
robes.c
> > > > index 4f3bc968ff8e..5b22a880c7e7 100644
> > > > --- a/tools/lib/bpf/libbpf_probes.c
> > > > +++ b/tools/lib/bpf/libbpf_probes.c
> > > > @@ -18,6 +18,10 @@
> > > >=C2=A0 #include "libbpf.h"
> > > >=C2=A0 #include "libbpf_internal.h"
> > > >
> > > > +#ifndef LIBBPF_KERNEL_VERSION
> > > > +#define LIBBPF_KERNEL_VERSION(a, b, c) (((a) << 16) + ((b) << 8) +=
 ((c) > 255 ? 255 : (c)))
> > > > +#endif
> > >
> > > What is wrong with using the KERNEL_VERSION() macro, it should be fix=
ed
> > > to work properly here, right?=C2=A0 Did we not get this resolved in t=
he
> > > main portion of the kernel already?
> >
> > The KERNEL_VERSION() macro from linux/version.h is wrong in some old
> > kernel(Debian 9, 10) that we would like to support. As you said, the
> > problem was resolved in the newer kernel. Here is the difference:
>
> But the kernels you want to "support" all have older kernel versions and
> so you do not need the change to the macro as they are not running newer
> kernel versions with an increased minor version number.
>
> So on those systems, building will work just fine, if not, then that's a
> Debian bug and they should fix it in their kernel packages.

> > linux/version.h
> > in older kernel: #define KERNEL_VERSION(a, b, c) (((a) << 16) + ((b)
> > << 8)) + (c)))
> > in newer kernel: #define KERNEL_VERSION(a, b, c) KERNEL_VERSION(a, b,
> > c) (((a) << 16) + ((b) << 8) + ((c) > 255 ? 255 : (c)))
> >
> > Using the KERNEL_VERSION macro in the older kernel returns the kern
> > version=C2=A0 which is=C2=A0 mismatched to the LINUX_VERSION_CODE that =
will
> > cause failing to load the BPF kprobe program.
> >
> > In my opinion, it is a more generic solution that corrects the
> > KERNEL_VERSION() macro in libbpf to support some old kernel.
>
> The KERNEL_VERSION() macro comes from the kernel you are building
> against.=C2=A0 And so that should match that kernel only.

Thanks again for your reply. You're absolutely right. This bug exists
on many older kernels(Debian9, 10, CentOS 7). It's not a kernel bug,
but the=C2=A0 kernel release package bug. I will correct the
KERNEL_VERSION() macro in header file linux/kernel.h provided by
kernel package to make things right.

Thanks
Best
Jerry Song
