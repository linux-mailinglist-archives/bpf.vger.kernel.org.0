Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1EA61522A
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 20:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiKATV2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 15:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKATV1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 15:21:27 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26F31C93C
        for <bpf@vger.kernel.org>; Tue,  1 Nov 2022 12:21:25 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id d3so22412044ljl.1
        for <bpf@vger.kernel.org>; Tue, 01 Nov 2022 12:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xicn+dUIp0KxW+VW2yYllyAioAJ6BiGg/tmrEoOkdiQ=;
        b=P9RVdIQvbFWv+nA2+ULoZI8Ok5/uQF6ORTE7BUpWLV0z8RWfwoFomqz4dpuqniU4sG
         bpNmIw4OtUXzgyPa4jNwcR0LfL6VAfalrIkuu+KH13YQpyNqSdSNvPuglSPsI/5QEMmS
         njm3+s9WcUSlJ6Pvu1eBO6gQnaorZCePD1iLpGJ3uRD4NuysTvLR+P44acVMsS+fOFYH
         zP/IEJnruwRXkPdGQSMbMzg0DZ1/kECUvSrM/W52MsEcjhOabhHi1FlemIx1Li3LNMjV
         Q1+inDqcrH2k91z6rMFls2r3hyixO79wrzy43kmVVCUVhe/hUuXib1JtUX5VmcpT3hVv
         NgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xicn+dUIp0KxW+VW2yYllyAioAJ6BiGg/tmrEoOkdiQ=;
        b=GyGzoEgqQCGwiY66IsjL86U3FMwj0lr8AJlOwMbxpXG2tNiWKkPeGnwJlARM6AlqQC
         fo/bdrY2p1XjVqm7NcdXdqDKB19scODTVMbNaYEXlhPR1/OB60bqoVMII2Tf5/sOlIPR
         FmD5SQL20SGtSsERjxmCClhrMbVKRFefdZhY9yQBv0V2eY+WMGFsWA41nEKyQXSa/ubh
         VhaOojG8dQ+Gf56v0Y0YwTJOJSr7xIG3PsyGEJvdVfRMkN0cZEE65S3xPamUDqDQUvL2
         OjdG9aCHHZ7s2yA8EkhWsuf6fK/bnOQ1BKbw6sc1NpJheuwqKAKyf4bhufcK44bTR1YG
         2Psg==
X-Gm-Message-State: ACrzQf0nVKdBOVzQZprBpXMkVxvKtv3FZaByOOYv4XFUjK7d52PknMIG
        yNpvP2TALFYPRHH0TxDMKm8=
X-Google-Smtp-Source: AMsMyM7BXzBfvAMf9nuxqWqyKmHS7djpoWvLmyzKolHhjuFnZPGORc7uCJ1W7vFieEjahCkkv2iXGw==
X-Received: by 2002:a2e:2415:0:b0:277:56d:f195 with SMTP id k21-20020a2e2415000000b00277056df195mr7843242ljk.8.1667330484200;
        Tue, 01 Nov 2022 12:21:24 -0700 (PDT)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id h22-20020ac250d6000000b0048b08e25979sm1727735lfm.199.2022.11.01.12.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 12:21:23 -0700 (PDT)
Message-ID: <a1f1cce3ad89c7ff9857cea643763f44d5047186.camel@gmail.com>
Subject: Re: [RFC bpf-next 00/12] Use uapi kernel headers with vmlinux.h
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@meta.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Date:   Tue, 01 Nov 2022 21:21:21 +0200
In-Reply-To: <CAADnVQ+Oe-euDp7dFEOntzdy9uYmGqapVM0YNdRDNerCN-8OQQ@mail.gmail.com>
References: <20221025222802.2295103-1-eddyz87@gmail.com>
         <CAEf4BzbScntAd4Yh5AWw+7bZhooYYaomwLYiuM0+iBtx_7LKoQ@mail.gmail.com>
         <f62834eb-fd3f-ba55-2cec-c256c328926e@meta.com>
         <CAEf4BzYT4pwmw64DaCTxR3_QjO5RRVadqVLO0h-hNa-+xOyLZw@mail.gmail.com>
         <af1facf9-7bc8-8a3d-0db4-7b3f333589a2@meta.com>
         <CAEf4BzZE7boex4KBjMmhJ4Nib6BA71-pf5jiAg74FjEdr_2e6A@mail.gmail.com>
         <ea841d91-a43f-a6e0-e8ce-90f9b2d3f77c@oracle.com>
         <CAADnVQ+Oe-euDp7dFEOntzdy9uYmGqapVM0YNdRDNerCN-8OQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2022-11-01 at 11:35 -0700, Alexei Starovoitov wrote:
> On Tue, Nov 1, 2022 at 9:02 AM Alan Maguire <alan.maguire@oracle.com> wro=
te:
> >=20
> > > > Yes, we discussed this before. This will need to add additional wor=
k
> > > > in preprocessor. I just made a discussion topic in llvm discourse
> > > >=20
> > > > https://discourse.llvm.org/t/add-a-type-checking-macro-is-type-defi=
ned-type/66268
>=20
> That would be a great clang feature.
> Thanks Yonghong!
>=20
> > > >=20
> > > > Let us see whether we can get some upstream agreement or not.
> > > >=20
> > >=20
> > > Thanks for starting the conversation! I'll be following along.
> > >=20
> >=20
> >=20
> > I think this sort of approach assumes that vmlinux.h is included after
> > any uapi headers, and would guard type definitions with
> >=20
> > #if type_is_defined(foo)
> > struct foo {
> >=20
> > };
> > #endif
> >=20
> > ...is that right? My concern is that the vmlinux.h definitions have
> > the CO-RE attributes. From a BPF perspective, would we like the vmlinux=
.h
> > definitions to dominate over UAPI definitions do you think, or does it
> > matter?
>=20
> I think it's totally fine to require #include "vmlinux.h" to be last.
> The attr(preserve_access_index) is only useful for kernel internal
> structs. uapi structs don't need it.
>=20
> >=20
> > I was wondering if there might be yet another way to crack this;
> > if we did want the vmlinux.h type definitions to be authoritative
> > because they have the preserve access index attribute, and because
> > bpftool knows all vmlinux types, it could use that info to selectively
> > redefine those type names such that we avoid name clashes when later
> > including UAPI headers. Something like
> >=20
> > #ifdef __VMLINUX_H__
> > //usual vmlinux.h type definitions
> > #endif /* __VMLINUX_H__ */
> >=20
> > #ifdef __VMLINUX_ALIAS__
> > if !defined(timespec64)
> > #define timespec64 __VMLINUX_ALIAS__timespec64
> > #endif
> > // rest of the types define aliases here
> > #undef __VMLINUX_ALIAS__
> > #else /* unalias */
> > #if defined(timespec64)
> > #undef timespec64
> > #endif
> > // rest of types undef aliases here
> > #endif /* __VMLINUX_ALIAS__ */
> >=20
> >=20
> > Then the consumer does this:
> >=20
> > #define __VMLINUX_ALIAS__
> > #include "vmlinux.h"
> > // include uapi headers
> > #include "vmlinux.h"
> >=20
> > (the latter include of vmlinux.h is needed to undef all the type aliase=
s)
>=20
> Sounds like a bunch of complexity for the use case that is not
> clear to me.

Well, my RFC is not shy of complexity :)
What Alan suggests should solve the confilicts described in [1] or any
other confilicts of such kind.

[1] https://lore.kernel.org/bpf/999da51bdf050f155ba299500061b3eb6e0dcd0d.ca=
mel@gmail.com/


> >=20
> > I tried hacking up bpftool to support this aliasing scheme and while
> > it is kind of hacky it does seem to work, aside from some issues with
> > IPPROTO_* definitions - for the enumerated IPPROTO_ values linux/in.h d=
oes
> > this:
> >=20
> > enum {
> >   IPPROTO_IP =3D 0,               /* Dummy protocol for TCP            =
   */
> > #define IPPROTO_IP              IPPROTO_IP
> >   IPPROTO_ICMP =3D 1,             /* Internet Control Message Protocol =
   */
> > #define IPPROTO_ICMP            IPPROTO_ICMP
> >=20
> >=20
> > ...so our enum value definitions for IPPROTO_ values clash with the abo=
ve
> > definitions. These could be individually ifdef-guarded if needed though=
 I think.
>=20
> Including vmlinux.h last won't have this enum conflicts, right?
>=20
> > I can send the proof-of-concept patch if it would help, I just wanted t=
o
> > check in case that might be a workable path too, since it just requires
> > changes to bpftool (and changes to in.h).
>=20
> I think changing the uapi header like in.h is no-go.
> Touching anything in uapi is too much of a risk.

