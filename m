Return-Path: <bpf+bounces-8300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AD5784BA1
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 22:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71E82810F9
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 20:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6A32B541;
	Tue, 22 Aug 2023 20:52:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439FA2018C
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 20:52:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F3ECF3
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 13:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692737520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8XLui8B57SJb6dmFNOQaUJZo2WVZ47mpS7Qsyz0IiRk=;
	b=BvyhxX2HsfqtR/FfeAoYWoX1JyVi1pt1u5+8egEEeANi8dieyJDjFVECYGOBjTkNcBlruB
	+gczr3VVeLvKzPRrPLk9kZU4+roU11RQmvP9HZyRXXpeWOM3NGDNpptV49quPnDt5zRf0S
	ZW/FqJyxPHTeauYctMriRAZo/6gph1s=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-zEij9xPXPP-1eAtSLKt-kg-1; Tue, 22 Aug 2023 16:51:58 -0400
X-MC-Unique: zEij9xPXPP-1eAtSLKt-kg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-51a5296eb8eso3321498a12.2
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 13:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692737517; x=1693342317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XLui8B57SJb6dmFNOQaUJZo2WVZ47mpS7Qsyz0IiRk=;
        b=GGBIQ84bXh5SWTVsMSLLoaZ8wkCIxGVp4u+IorBIP4Kp+YTiJ+ScWeSNNUg9Yekk8v
         xfxqoRTreRfDv1ww3J0z1KOxwLqUaQw2GHAWZhx0gSD6IXutGbUhhoM5z2ZrUfl1K3M9
         2thFaq+YrHMsyKfDKlKR9+uw9W9amh7Iwyn0LiTwnPdx19otKOHP3y4xPjBpBR0voLyW
         1Vvx92sT02TVf9OcsGRypMOswRhh/XusiTSE82EuGTerJC+8K15vl5bC/zN6IoCwCxl3
         FNs2u+ZHCZEshrZ2ESjqkVUxNBigSp3719hNU0NYTlR2a4Uea6ehCoj2eEvfrfV1lNII
         oX5g==
X-Gm-Message-State: AOJu0Yw2MK0rJ00tVkLRKTfPn11oVZh6UUi+qb1jYPX8JAWP5qoQ0miO
	zk8AIm4vgTx0dHVczd6AAEEizakrTd2IlF/RpAFNZ1jqFaOaspeEXhwhkVTe4UZQrnyRI7khNwn
	Yl7NKJqY1qc5bRHR/7jY/orrHxx5cj6nxe+GnIRQ=
X-Received: by 2002:aa7:d996:0:b0:522:d6f4:c0eb with SMTP id u22-20020aa7d996000000b00522d6f4c0ebmr7256014eds.40.1692737516975;
        Tue, 22 Aug 2023 13:51:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExNcZZMTNRhQ/wVLWqr83IsqKzBJcMdIjR1e2iyPIrwYLZHNPDWf2vJaZLk2I2cpotnkIlKBCLEHXXEoehx2E=
X-Received: by 2002:aa7:d996:0:b0:522:d6f4:c0eb with SMTP id
 u22-20020aa7d996000000b00522d6f4c0ebmr7256011eds.40.1692737516708; Tue, 22
 Aug 2023 13:51:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFhGd8ryUcu2yPC+dFyDKNuVFHxT-=iayG+n2iErotBxgd0FVw@mail.gmail.com>
 <CAKwvOd=p_7gWwBnR_RHUPukkG1A25GQy6iOnX_eih7u65u=oxw@mail.gmail.com>
In-Reply-To: <CAKwvOd=p_7gWwBnR_RHUPukkG1A25GQy6iOnX_eih7u65u=oxw@mail.gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Tue, 22 Aug 2023 22:51:45 +0200
Message-ID: <CAO-hwJLio2dWs01VAhCgmub5GVxRU-3RFQifviOL0OTaqj9Ktg@mail.gmail.com>
Subject: Re: selftests: hid: trouble building with clang due to missing header
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Justin Stitt <justinstitt@google.com>, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-input@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Justin,

On Tue, Aug 22, 2023 at 10:44=E2=80=AFPM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> + Ben, author of commit dbb60c8a26da ("selftests: add tests for the
> HID-bpf initial implementation")
>
> On Tue, Aug 22, 2023 at 1:34=E2=80=AFPM Justin Stitt <justinstitt@google.=
com> wrote:
> >
> > Hi, I'd like to get some help with building the kselftest target.
> >
> > I am running into some warnings within the hid tree:
> > | progs/hid_bpf_helpers.h:9:38: error: declaration of 'struct
> > hid_bpf_ctx' will \
> > |       not be visible outside of this function [-Werror,-Wvisibility]
> > |     9 | extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
> > |       |                                      ^
> > | progs/hid.c:23:35: error: incompatible pointer types passing 'struct
> > hid_bpf_ctx *' \
> > |       to parameter of type 'struct hid_bpf_ctx *'
> > [-Werror,-Wincompatible-pointer-types]
> > |    23 |         __u8 *rw_data =3D hid_bpf_get_data(hid_ctx, 0 /*
> > offset */, 3 /* size */);
> >
> > This warning, amongst others, is due to some symbol not being included.
> > In this case, `struct hid_bpf_ctx` is not being defined anywhere that I
> > can see inside of the testing tree itself.
> >
> > Instead, `struct hid_bpf_ctx` is defined and implemented at
> > `include/linux/hid_bpf.h`. AFAIK, I cannot just include this header as
> > the tools directory is a separate entity from kbuild and these tests ar=
e
> > meant to be built/ran without relying on kernel headers. Am I correct i=
n
> > this assumption? At any rate, the include itself doesn't work. How can =
I
> > properly include this struct definition and fix the warning(s)?
> >
> > Please note that we cannot just forward declare the struct as it is
> > being dereferenced and would then yield a completely different
> > error/warning for an incomplete type. We need the entire implementation
> > for the struct included.
> >
> > Other symbols also defined in `include/linux/hid_bpf.h` that we need ar=
e
> > `struct hid_report_type` and `HID_BPF_FLAG...`
> >
> > Here's the invocation I am running to build kselftest:
> > `$ make LLVM=3D1 ARCH=3Dx86_64 mrproper headers && make LLVM=3D1 ARCH=
=3Dx86_64
> > -j128 V=3D1 -C tools/testing/selftests`

I think I fixed the same issue in the script I am running to launch
those tests in a VM. This was in commit
f9abdcc617dad5f14bbc2ebe96ee99f3e6de0c4e (in the v6.5-rc+ series).

And in the commit log, I wrote:
```
According to commit 01d6c48a828b ("Documentation: kselftest:
"make headers" is a prerequisite"), running the kselftests requires
to run "make headers" first.
```

So my assumption is that you also need to run "make headers" with the
proper flags before compiling the selftests themselves (I might be
wrong but that's how I read the commit).

Cheers,
Benjamin

> >
> > If anyone is currently getting clean builds of kselftest with clang,
> > what invocation works for you?
> >
> >
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1698
> > Full-build-log:
> > https://gist.github.com/JustinStitt/b217f6e47c1d762e5e1cc6c3532f1bbb
> > (V=3D1)
> >
> > Thanks.
> > Justin
>
>
>
> --
> Thanks,
> ~Nick Desaulniers
>


