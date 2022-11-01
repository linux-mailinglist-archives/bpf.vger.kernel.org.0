Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F6E6151A0
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 19:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiKASfW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 14:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiKASfU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 14:35:20 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77931AF00
        for <bpf@vger.kernel.org>; Tue,  1 Nov 2022 11:35:17 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id kt23so39215613ejc.7
        for <bpf@vger.kernel.org>; Tue, 01 Nov 2022 11:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3GaGfQKjTi8JaEFV7e7/zAN9r73rdp9AFp+ya4eP2ok=;
        b=dRXiIdlXf9+w1EMZ3zBJGQk5WAbJ0eJ6ZcUxDTnZWDz1gb/6BZSUHTP78oRKUkIxKO
         Cll4qnBEYuw4Rb/3ZDMznBmYTDJPYlCKYdy6ZV00BhA357MRs4zEtqPMSWRul7M2WGYx
         ddvMfzPhfWFTrlY5mZs9q0pImfieLwDZT22aawjMCE/aPkRpDkTD5SqobKx/+Wvx2x5E
         p+66SWTzNKWE+6iAHG32smP7oEb0yQDCCnogjZgTbESVRQ+AT9+vCHhE06RBhwtwhgVY
         fJqFnOMW9gKgz2Q+AMqt4PTSTxDk2RWytpVGin8OJ8Vy7a6KTSGJ1v/swMpJ1vq2I2np
         5YCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3GaGfQKjTi8JaEFV7e7/zAN9r73rdp9AFp+ya4eP2ok=;
        b=vlJZm2X9eyqey72bOyx8PBvhoLIbZsKwqfEtx217+gkN3lQOtYSG7wnMZ2BPoZYXpW
         A1L4vX8+ATxbxyb2Bu02UF1FLTtNH/VZArDSOa6JEh0MjCVxoweVyktwr63Y6UGCj3Kj
         rlVQC1ZcahZc8bwc311gWWTKmCEa1yVX2HLn9+oruZ8410TZFNKP4jwgSeIKiYwE7fKs
         0JwkGuhzh9oo/Q5spx0Vrv6uRgJqEgUZMBPklPVfJa9ttqTV0bZ94Zemz5Xsi7nsGEnb
         HuTpdiCYHoDl/BlL3brI1An49Yvb96XZytFMSXGkfxpY/tUuv7aubkMkFp2CMByYZEMS
         PFAA==
X-Gm-Message-State: ACrzQf1laCr7UNycUnYNz/NIOQj0Onv4OPucDccOGUxMnVYmKdZocEdR
        /cCtiKQXBqGpMpP1ZZkZPAMFN1ZTNLyrXJI9vIY=
X-Google-Smtp-Source: AMsMyM5wWc1MDctIAHDnaKSuSQLU+z0frPcsfE1d2al2HUppkCZloAmPOUGu83lakv2DW7oSJb90SZYzE3IAZFID9WM=
X-Received: by 2002:a17:906:9510:b0:7ad:fd3e:124b with SMTP id
 u16-20020a170906951000b007adfd3e124bmr353912ejx.502.1667327716091; Tue, 01
 Nov 2022 11:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221025222802.2295103-1-eddyz87@gmail.com> <CAEf4BzbScntAd4Yh5AWw+7bZhooYYaomwLYiuM0+iBtx_7LKoQ@mail.gmail.com>
 <f62834eb-fd3f-ba55-2cec-c256c328926e@meta.com> <CAEf4BzYT4pwmw64DaCTxR3_QjO5RRVadqVLO0h-hNa-+xOyLZw@mail.gmail.com>
 <af1facf9-7bc8-8a3d-0db4-7b3f333589a2@meta.com> <CAEf4BzZE7boex4KBjMmhJ4Nib6BA71-pf5jiAg74FjEdr_2e6A@mail.gmail.com>
 <ea841d91-a43f-a6e0-e8ce-90f9b2d3f77c@oracle.com>
In-Reply-To: <ea841d91-a43f-a6e0-e8ce-90f9b2d3f77c@oracle.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 1 Nov 2022 11:35:04 -0700
Message-ID: <CAADnVQ+Oe-euDp7dFEOntzdy9uYmGqapVM0YNdRDNerCN-8OQQ@mail.gmail.com>
Subject: Re: [RFC bpf-next 00/12] Use uapi kernel headers with vmlinux.h
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@meta.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 1, 2022 at 9:02 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> >> Yes, we discussed this before. This will need to add additional work
> >> in preprocessor. I just made a discussion topic in llvm discourse
> >>
> >> https://discourse.llvm.org/t/add-a-type-checking-macro-is-type-defined-type/66268

That would be a great clang feature.
Thanks Yonghong!

> >>
> >> Let us see whether we can get some upstream agreement or not.
> >>
> >
> > Thanks for starting the conversation! I'll be following along.
> >
>
>
> I think this sort of approach assumes that vmlinux.h is included after
> any uapi headers, and would guard type definitions with
>
> #if type_is_defined(foo)
> struct foo {
>
> };
> #endif
>
> ...is that right? My concern is that the vmlinux.h definitions have
> the CO-RE attributes. From a BPF perspective, would we like the vmlinux.h
> definitions to dominate over UAPI definitions do you think, or does it
> matter?

I think it's totally fine to require #include "vmlinux.h" to be last.
The attr(preserve_access_index) is only useful for kernel internal
structs. uapi structs don't need it.

>
> I was wondering if there might be yet another way to crack this;
> if we did want the vmlinux.h type definitions to be authoritative
> because they have the preserve access index attribute, and because
> bpftool knows all vmlinux types, it could use that info to selectively
> redefine those type names such that we avoid name clashes when later
> including UAPI headers. Something like
>
> #ifdef __VMLINUX_H__
> //usual vmlinux.h type definitions
> #endif /* __VMLINUX_H__ */
>
> #ifdef __VMLINUX_ALIAS__
> if !defined(timespec64)
> #define timespec64 __VMLINUX_ALIAS__timespec64
> #endif
> // rest of the types define aliases here
> #undef __VMLINUX_ALIAS__
> #else /* unalias */
> #if defined(timespec64)
> #undef timespec64
> #endif
> // rest of types undef aliases here
> #endif /* __VMLINUX_ALIAS__ */
>
>
> Then the consumer does this:
>
> #define __VMLINUX_ALIAS__
> #include "vmlinux.h"
> // include uapi headers
> #include "vmlinux.h"
>
> (the latter include of vmlinux.h is needed to undef all the type aliases)

Sounds like a bunch of complexity for the use case that is not
clear to me.

>
> I tried hacking up bpftool to support this aliasing scheme and while
> it is kind of hacky it does seem to work, aside from some issues with
> IPPROTO_* definitions - for the enumerated IPPROTO_ values linux/in.h does
> this:
>
> enum {
>   IPPROTO_IP = 0,               /* Dummy protocol for TCP               */
> #define IPPROTO_IP              IPPROTO_IP
>   IPPROTO_ICMP = 1,             /* Internet Control Message Protocol    */
> #define IPPROTO_ICMP            IPPROTO_ICMP
>
>
> ...so our enum value definitions for IPPROTO_ values clash with the above
> definitions. These could be individually ifdef-guarded if needed though I think.

Including vmlinux.h last won't have this enum conflicts, right?

> I can send the proof-of-concept patch if it would help, I just wanted to
> check in case that might be a workable path too, since it just requires
> changes to bpftool (and changes to in.h).

I think changing the uapi header like in.h is no-go.
Touching anything in uapi is too much of a risk.
