Return-Path: <bpf+bounces-12375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 313127CB995
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 06:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAE7FB20FE3
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 04:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143DBBE5D;
	Tue, 17 Oct 2023 04:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYLW5tf4"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FA78BF9
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 04:11:23 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A36683
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 21:11:22 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c5039d4e88so56881121fa.3
        for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 21:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697515881; x=1698120681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiChKg8+VjYtUeDTojfUeUEmVnQGo8ibkQaxn4SWWA4=;
        b=NYLW5tf4JQxCKER2vnQppkVxnSYDYt515346zIVXqVlJb+3as24qGnGwTEKOgCkC58
         vZ89rT4AUke7KV1VR73tBmuRSv5xdcGuYkffJNq5C7bP5qIz2ztAptYUsxWyii2cuHT1
         zcNtgvZAFlKRKLX0MORzt9bLfSJL4Z+EmzT6qb/YsBdN2pNFCQJRhLIvnnV40HOoxsva
         gu4p/6WZF6W3lgd3wLKhHiZVdSn7H1NgqM7wzyvsXx7QokwawBMDpC8cEHE7TJImbQnq
         MrKW/1Mor27C3lBOWr4GjPDB854uJkhM9mlHZjDRhxAynqnkFYzs9TQIBeBqS6GxK/Vs
         2I1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697515881; x=1698120681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiChKg8+VjYtUeDTojfUeUEmVnQGo8ibkQaxn4SWWA4=;
        b=VRvooUxJmdbhNyVDZcfMu/Vh0ghkjny7kU9gXwNEMZrojCRYooazqaXnf6OxRr30E6
         aLn9N+HQ01zNAYVT1oPCHIgbuN58w88D8d+55iZPebVAV1k0HqEUvd71Kh6sthhtytKo
         nqbMFael5474gzpPjkW/x0+817H2k3SjSBNZT+smjzdnAKObOdK3FuH3gExs3mLI7mkz
         cBVgzCuLIYq8Y+C8hdaUg5ZcV3NWiGE9m2WEqYLrxdmGBRailpI3P19Rspp763o2YrIf
         Uf+F9v3aTU73UfBYvFPtEELaEt0WazBjD5Ab9rWBZj5y18kTK6gWDlO+ARafDFfRPhnF
         dYJw==
X-Gm-Message-State: AOJu0YzHy5hXJGc2GvwsvpCIipWY2rQv8SaFbZUYKvGrTtgrnVVh0zuj
	kPWQKTYOk9b4lSLimtj7bIbYHhhI5NVmT7kkDJfU6xwdK8k=
X-Google-Smtp-Source: AGHT+IFEonucgXGwsc6zltaU4tY8MU6ouM2BvDmWGiDCrDSZApmNZ/o8TKDtKn+GdTmUzXry01CvqH+hBnNftnI3ESw=
X-Received: by 2002:ac2:522c:0:b0:502:fe11:a68f with SMTP id
 i12-20020ac2522c000000b00502fe11a68fmr771108lfl.28.1697515880584; Mon, 16 Oct
 2023 21:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzYYdLX9+=juNHwMmXeOO_EbGF7qXf_FJjLjLFPjpzKkfg@mail.gmail.com>
 <tencent_E339382F4BA4C7B1890CE59F61787D532D09@qq.com>
In-Reply-To: <tencent_E339382F4BA4C7B1890CE59F61787D532D09@qq.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 16 Oct 2023 21:11:09 -0700
Message-ID: <CAEf4BzZJqzmV5Bkm6uc3wRV4+WBEQtSTmRTX5ZWvMJOoRcOpFg@mail.gmail.com>
Subject: Re: [PATCH] Fix 'libbpf: failed to find BTF info for global/extern
 symbol' since uninitialized global variables
To: LiuLingze <luiyanbing@foxmail.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 9:04=E2=80=AFPM LiuLingze <luiyanbing@foxmail.com> =
wrote:
>
> On Mon, Oct 16, 2023 at 8:16 PM Andrii Nakryiko <andrii.nakryiko@gmail.co=
m> wrote:
>
> > On Sat, Oct 14, 2023 at 4:27 AM LiuLingze <luiyanbing@foxmail.com> wrot=
e:
> > >
> > > Hi Andrii Nakryiko,
> > >
> > > > On Fri, Oct 13, 2023 at 6:45 AM LiuLingze <luiyanbing@foxmail.com> =
wrote:
> > > > >
> > > > > ---
> > > > >  examples/c/usdt.bpf.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/examples/c/usdt.bpf.c b/examples/c/usdt.bpf.c
> > > > > index 49ba506..2612ec1 100644
> > > > > --- a/examples/c/usdt.bpf.c
> > > > > +++ b/examples/c/usdt.bpf.c
> > > > > @@ -5,7 +5,7 @@
> > > > >  #include <bpf/bpf_tracing.h>
> > > > >  #include <bpf/usdt.bpf.h>
> > > > >
> > > > > -pid_t my_pid;
> > > > > +pid_t my_pid =3D3D 0;
> > > >
> > > > This is effectively the same, my_pid will be initialized to zero
> > > > anyways. The difference might be due to you using too old Clang
> > > > version that might still be putting my_pid into a special COM secti=
on.
> > > >
> > > > Also "failed to find BTF info for global/extern symbol" is usually =
due
> > > > to too old Clang that doesn't emit BTF information for global
> > > > variables.
> > > >
> > > > So either way, can you try upgrading your Clang and see if the prob=
lem pers=3D
> > > > ists?
> > > >
> > > > >
> > > > >  SEC("usdt/libc.so.6:libc:setjmp")
> > > > >  int BPF_USDT(usdt_auto_attach, void *arg1, int arg2, void *arg3)
> > > > > --
> > > > > 2.37.2
> > > > >
> > > > >
> > > >
> > >
> > > Thank you for your reply.
> > >
> > > Yes, I was able to compile on a newer ubuntu with a higher version of=
 clang.
> > >
> > > However, on a development module (nVidia Orin AGX) running an older v=
ersion of ubuntu, it is not possible to use apt to update clang to a new ve=
rsion. Downloading the source code of a higher version of clang for compila=
tion is cumbersome and affects compatibility. So I hope that with the above=
 changes, the project code can be easily compiled and used in earlier versi=
ons.
> >
> > Did you verify that specifically adding explicit `=3D 0` makes it more
> > compatible with old compiler or it's just a theory?
>
> Yes, I have compiled usdt successfully on Ubuntu 20.04.6 LTS with clang v=
ersion 10.0.0-4ubuntu1 by specifically adding explicit `=3D 0`.
>

Ok, please send a PR against libbpf-bootstrap repo ([0]) then, which
is what you seem to be targeting here.

  [0] https://github.com/libbpf/libbpf-bootstrap

