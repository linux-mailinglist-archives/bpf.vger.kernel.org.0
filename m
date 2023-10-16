Return-Path: <bpf+bounces-12348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4737CB46F
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 22:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1161E1C20BF1
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 20:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56E73715E;
	Mon, 16 Oct 2023 20:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ay4qhJzH"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25B234CE3
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 20:16:29 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721ECED
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 13:16:28 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53d9b94731aso8828709a12.1
        for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 13:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697487387; x=1698092187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXT4xavxEJtAtknYxh4SYxXI0tSOBAzwFCWHWGjp//Q=;
        b=ay4qhJzHYpdj0b3BtJ/FS4HMCHy77eaWh4qClf+wDQpG5WaInrGhSVUzPF1Dh/lFov
         FgcpXeSLHORG2dv45sLy5F+d92ifeqx056gwhu+qUtw2f8mk1GbeFUmAmchgSH7AXuuj
         1mJLRukUDzJ7Rj/569NiosTa5GJAvUm5DDCOISzyBOJbwIW0osgvBATdleetL0nOPiHI
         lJwcxEVm0vmjwGKIpoYW6qQJPoG9qssLenk6m735sjj+0WtA3htygVA62+dn9R39U+nC
         z/sYrT5ktTa3LEtMqcXgW/CK5DnLewmw14PjKGj0+8f9TGA7LqwW5GbhX1t1mu5ROmBt
         Z+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697487387; x=1698092187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXT4xavxEJtAtknYxh4SYxXI0tSOBAzwFCWHWGjp//Q=;
        b=Ytc+1IuSxc1m5xjmYmW6GYqkFItvXRDuDxf1oQtyRGewl/gtb0vbSsUEU7xGiSDxt7
         tdxOTbyJfzFo7Z5FvNV7T+IFlOrGPToel7oZOGyuhV5WrRsFQNyjoWCruKTITfhj3x4B
         aBRYQ895+SAP5ArcUMJ9qJjfwjWAJd4rnjrcGf87sC2tlg05dZqR8Mura+Au/AxqJwyi
         MGq4uINi5jO5017R7NfnsoQquVegq0+IKqR94o+BrauRNsIgbudnRS2+YMrv+oA1RKi8
         86nY62mf1W6ypEJlidwSEfk/aKFfwnbl5g0P1mpAtVbj9J80rt9hWv2Koq6LYIq1oz3v
         JvyA==
X-Gm-Message-State: AOJu0Yzyvi9TPY3/bVBYsP20K/tCf0pKW1zrGZqr7Yj0ZkR2MdyHpkN6
	NMuPPN4xLLMoVbVc6avglUeY8P91Jz6Z6sncw2mZH7sV
X-Google-Smtp-Source: AGHT+IH88s8F2UlaQaPwkpKsRUBrMtsViLsV2ELhSc6gNsvBlAjMME1fDAtL9NK4Yj0W7O5x4T2WRwyNX59ZKfZMxpQ=
X-Received: by 2002:a50:cd95:0:b0:53d:b7e7:301b with SMTP id
 p21-20020a50cd95000000b0053db7e7301bmr226142edi.24.1697487386591; Mon, 16 Oct
 2023 13:16:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzZnZ=jqTxShQ7p2tp=0sT5iMEJVB+zqhf55XtwQHOODtA@mail.gmail.com>
 <tencent_69D8DE86B0CF09BC89A9561C6B9771D2F608@qq.com>
In-Reply-To: <tencent_69D8DE86B0CF09BC89A9561C6B9771D2F608@qq.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 16 Oct 2023 13:16:13 -0700
Message-ID: <CAEf4BzYYdLX9+=juNHwMmXeOO_EbGF7qXf_FJjLjLFPjpzKkfg@mail.gmail.com>
Subject: Re: Re: [PATCH] Fix 'libbpf: failed to find BTF info for
 global/extern symbol' since uninitialized global variables
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

On Sat, Oct 14, 2023 at 4:27=E2=80=AFAM LiuLingze <luiyanbing@foxmail.com> =
wrote:
>
> Hi Andrii Nakryiko,
>
> > On Fri, Oct 13, 2023 at 6:45=3DE2=3D80=3DAFAM LiuLingze <luiyanbing@fox=
mail.com> =3D
> > wrote:
> > >
> > > ---
> > >  examples/c/usdt.bpf.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/examples/c/usdt.bpf.c b/examples/c/usdt.bpf.c
> > > index 49ba506..2612ec1 100644
> > > --- a/examples/c/usdt.bpf.c
> > > +++ b/examples/c/usdt.bpf.c
> > > @@ -5,7 +5,7 @@
> > >  #include <bpf/bpf_tracing.h>
> > >  #include <bpf/usdt.bpf.h>
> > >
> > > -pid_t my_pid;
> > > +pid_t my_pid =3D3D 0;
> >
> > This is effectively the same, my_pid will be initialized to zero
> > anyways. The difference might be due to you using too old Clang
> > version that might still be putting my_pid into a special COM section.
> >
> > Also "failed to find BTF info for global/extern symbol" is usually due
> > to too old Clang that doesn't emit BTF information for global
> > variables.
> >
> > So either way, can you try upgrading your Clang and see if the problem =
pers=3D
> > ists?
> >
> > >
> > >  SEC("usdt/libc.so.6:libc:setjmp")
> > >  int BPF_USDT(usdt_auto_attach, void *arg1, int arg2, void *arg3)
> > > --
> > > 2.37.2
> > >
> > >
> >
>
> Thank you for your reply.
>
> Yes, I was able to compile on a newer ubuntu with a higher version of cla=
ng.
>
> However, on a development module (nVidia Orin AGX) running an older versi=
on of ubuntu, it is not possible to use apt to update clang to a new versio=
n. Downloading the source code of a higher version of clang for compilation=
 is cumbersome and affects compatibility. So I hope that with the above cha=
nges, the project code can be easily compiled and used in earlier versions.

Did you verify that specifically adding explicit `=3D 0` makes it more
compatible with old compiler or it's just a theory?

>
> Thanks,
> LiuLingze
>

