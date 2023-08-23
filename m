Return-Path: <bpf+bounces-8386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD991785CAF
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 17:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9731C202E8
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 15:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FDDC8F2;
	Wed, 23 Aug 2023 15:52:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAC3AD42
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 15:52:06 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FB910D0
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 08:52:01 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b9b50be31aso89029741fa.3
        for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 08:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692805919; x=1693410719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdzvUnmQGqPL33vdbadyluhAnWE0eYSjwxwQRt99O+k=;
        b=VDv86vvEMBD3hbDznCp0GL8ywxB5n4o6ZazLM46f0FmPD8PjtvgRxUYnF2SDxMb2sH
         KO17WGJjNnGL0a5dtEzW1HPbLs9+1FvB+mnX44d9rXrD/jgCvTKA0I2cZwttzGA6eZHW
         vgnETZC5CgiVUfISIG7E0Tg58A4OoNAMB610NIYnxmLDARfA7Qo3Obgfu0iiKkS8R775
         LAgiGCLRKeTMNPvb0gVCGP/VRYNI/VIS6DNoLz1usJjd92VBSlVagJyJNcqOfJFFeMod
         3zM0qOVEPO0K/EoU4L9/5qorIaidO9DnC94OlnmzuQQHRm+bmfOPOQkrIG9nhaNysGFs
         IE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692805919; x=1693410719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdzvUnmQGqPL33vdbadyluhAnWE0eYSjwxwQRt99O+k=;
        b=i2AoCy2HMxcAhfBuofZUyfphN/Osa0Oj7PkL32pEBM7YAUnJim9vi5+IPYcIhga4Eb
         mLAszwMMnnTASJecKSuq6LJ77p+RzLutE8iD+WbCFbx6G4sDQ2YZ62sSQ4qhAyveoetG
         C8oeRCHhQgPq+kuIcTvy0ZiGrJReK2vKBrkIEqfvcmen1F4N98xoxc6T+rfe8gQ5V7P1
         L6n6yTkZv8IPat1E2sFulNt1Me/hn6vWEQbCBQsKqi8JXAjl6FKtwB/cAQ/D64Y4wJ/H
         n5NLL0n3Vg32i9rbAq+/YSzbXlrQwuoJd1JxlxkfISYNrX1xiwYPjId3i5XSUJTsl8Wc
         ELdw==
X-Gm-Message-State: AOJu0Yz2fcnsO28XZ/VZZu/AX0lHyyriElZwBoL/aiGENfPxkNrbFvtP
	cWJeFewnZ3ZpUFpuA6d6ljLWpy7gv/l5Sjz+zMg=
X-Google-Smtp-Source: AGHT+IHWG28AOMLv0RAnyrENlqwvI9nK4CJg8w6Ob7T/8FXLSCmjQFYw0ysLXyZdIESk/wVmZQZF61wA9alG0AHLk00=
X-Received: by 2002:a2e:9b4e:0:b0:2b5:7a87:a85a with SMTP id
 o14-20020a2e9b4e000000b002b57a87a85amr9642528ljj.13.1692805919168; Wed, 23
 Aug 2023 08:51:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230818083920.3771-1-laoar.shao@gmail.com> <20230818083920.3771-3-laoar.shao@gmail.com>
 <CAADnVQJ-BcSfPVL4J8DPA0XXgWtfUSXDzjnNeQvf1Z2SAASQ2g@mail.gmail.com> <45af850d8a07305eee252e5aa5014dbe743ca2af.camel@gmail.com>
In-Reply-To: <45af850d8a07305eee252e5aa5014dbe743ca2af.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 23 Aug 2023 08:51:48 -0700
Message-ID: <CAADnVQKGzQpcP+GhYOH2pg-M0WqBXsQErZT6MyFYdSNypUPWDA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add selftest for allow_ptr_leaks
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 23, 2023 at 2:45=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2023-08-21 at 15:45 -0700, Alexei Starovoitov wrote:
> [...]
> > > diff --git a/tools/testing/selftests/bpf/progs/test_tc_bpf.c b/tools/=
testing/selftests/bpf/progs/test_tc_bpf.c
> > > index d28ca8d..3e0f218 100644
> > > --- a/tools/testing/selftests/bpf/progs/test_tc_bpf.c
> > > +++ b/tools/testing/selftests/bpf/progs/test_tc_bpf.c
> > > @@ -1,5 +1,8 @@
> > >  // SPDX-License-Identifier: GPL-2.0
> > >
> > > +#include <linux/pkt_cls.h>
> > > +#include <linux/ip.h>
> > > +#include <linux/if_ether.h>
> >
> > Due to above it fails to compile:
> >
> > In file included from progs/test_tc_bpf.c:4:
> > In file included from /usr/include/linux/ip.h:21:
> > In file included from /usr/include/asm/byteorder.h:5:
> > In file included from /usr/include/linux/byteorder/little_endian.h:13:
> > /usr/include/linux/swab.h:136:8: error: unknown type name '__always_inl=
ine'
> >   136 | static __always_inline unsigned long __swab(const unsigned long=
 y)
> >       |        ^
> >
>
> This is strange, I can compile it no problem. On my system:
> /usr/include/linux/swab.h includes /usr/include/linux/stddef.h
> which defines __always_inline.
>
> What distro are you using?

That was centos8.
dnf provides /usr/include/linux/swab.h
kernel-headers-6.4.3.x86_64 : Header files for the Linux kernel for use by =
glibc
Repo        : kernel
Matched from:
Filename    : /usr/include/linux/swab.h

