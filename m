Return-Path: <bpf+bounces-11845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B157C438B
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 00:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5065C1C20D28
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 22:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB07D6119;
	Tue, 10 Oct 2023 22:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vpsc2ILa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594B832C60
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 22:13:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B881EC433CC
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 22:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696976035;
	bh=NfNuHqIXSmlPpblrIV9KRwQcCGAxB9CkX22OgE3EYRA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Vpsc2ILaNtuPEMpsVHCpfNZpPC5M7PanLnj7mpKKLGEspkpNb6APY0kYi0eoZiiOZ
	 3KvUO7WQztvXTqWAFRGSfLLx4CnjFuAt5Bu9HDrYPVTTMNwr+7wZBAoZpf1IizWs/+
	 2iJ1Qb4Qz8wUorc6EmmDUTtakT3Q+OIEydE3+dB8ftKAIQMmF/ftZhYIuh0VjTBe1t
	 e/h2gAC9bHjuvP+N8KeLcj1PRRJtiMoj2wfiqbLzTS8QHAPhPHlqAz4A6FC2NIXGJx
	 8Rho8+h+O77ZpFSdRrUrACiHJeUpjJJuaXb35mFnB6hupSDA08+KZ4rQGQRUo4otOq
	 rst2zaPaQCa/Q==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50433d8385cso8298711e87.0
        for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 15:13:55 -0700 (PDT)
X-Gm-Message-State: AOJu0YwzDJKuef9KQXM5wDdTFN1qINm6+ATGrl8Q/QRKdOJ/YejjJgMz
	5uakvNZK5ncBe3/fxBmyFoHuuDewNf9cSvoPoqk=
X-Google-Smtp-Source: AGHT+IG5U/IqM+Ipm4h0mT07jrE7ghvxus1w9qH8zPzX3V1LLnnAXl2SssJoK/zTNZaDsU7sEPy6LWa8Ny8/ekR841M=
X-Received: by 2002:a05:6512:1586:b0:505:6eef:cf2d with SMTP id
 bp6-20020a056512158600b005056eefcf2dmr19391703lfb.17.1696976033917; Tue, 10
 Oct 2023 15:13:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231004004350.533234-1-song@kernel.org> <CAEf4BzbM6yvBwT3-_7NkzKgqdoXc_G3+_5Fnv96b_2U68=Hunw@mail.gmail.com>
 <CAADnVQKMxUg3Djh8UjRPdw7RE6yOiNUgYGjG_eCPqMtnguO+fA@mail.gmail.com>
 <095DCE9A-BC4D-415F-81F6-B6C20BA08B9A@fb.com> <FCAD3D3A-B230-40D8-A422-DED507B95C89@fb.com>
 <A53BABCE-A22D-40B0-91BA-009B54AB8F09@fb.com> <92BDCF92-3219-4EDA-A6F8-1EA8D88BEE41@fb.com>
 <7a9576222aa40b1c84ad3a9ba3e64011d1a04d41.camel@linux.ibm.com>
In-Reply-To: <7a9576222aa40b1c84ad3a9ba3e64011d1a04d41.camel@linux.ibm.com>
From: Song Liu <song@kernel.org>
Date: Tue, 10 Oct 2023 15:13:41 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7yXG4pahGTuBUWYmqQzYBJji=VFLmBYotHWL82janT_A@mail.gmail.com>
Message-ID: <CAPhsuW7yXG4pahGTuBUWYmqQzYBJji=VFLmBYotHWL82janT_A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: Avoid unnecessary -EBUSY from htab_lock_bucket
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Song Liu <songliubraving@meta.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilya,

On Tue, Oct 10, 2023 at 1:49=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
[...]
> >
> > Thanks,
> > Song
> >
> > PS: the root image from the CI is not easy to use. Hopefully you
> > have something better than that.
>
> Hi,
>
> Thanks for posting the analysis and links to the artifacts, that saved
> me quite some time. The crash is caused by a backchain issue in the
> trampoline code and has nothing to do with your patch; I've posted the
> fix here [1].

Thanks for the fix!

Song

>
> The difference between compilers is most likely caused by different
> inlining decisions around lookup_elem_raw(). When it's inlined, the
> test becomes a no-op.
>
> Regarding GDB, Debian and Ubuntu have gdb-multiarch package. On Fedora
> one has to build it from source; the magic binutils-gdb configure flag
> is --enable-targets=3Dall.
>
> Regarding the development environment, in this case I've sidestepped
> the need for a proper image by putting everything into initramfs:
>
> workdir=3D$(mktemp -d)
> tar -C "$workdir" -xf libbpf-vmtest-rootfs-2022.10.23-bullseye-
> s390x.tar.zst
> rsync -a selftests "$workdir"
> (cd "$workdir" && find . | cpio -o --format=3Dnewc -R root:root)
> >initrd.cpio
> qemu-system-s390x -accel kvm -smp 2 -m 4G -kernel kbuild-
> output/arch/s390/boot/bzImage -nographic -append 'nokaslr console=3DttyS1
> rdinit=3D/bin/sh' -initrd initrd.cpio -s

Nice trick!

> For the regular development I have a different setup, with a
> non-minimal Debian install inside the guest, and the testcases mounted
> from the host using 9p.
>
> Best regards,
> Ilya
>
> [1]
> https://lore.kernel.org/bpf/20231010203512.385819-1-iii@linux.ibm.com/

