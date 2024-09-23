Return-Path: <bpf+bounces-40214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFDD983979
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 00:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BA951F21A70
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 22:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2620B85654;
	Mon, 23 Sep 2024 22:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4KWVzUf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39717DA7D
	for <bpf@vger.kernel.org>; Mon, 23 Sep 2024 22:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727128987; cv=none; b=VKRLBbsk84cLVVmcRtJzr6eik4Ag2AtvU/lm2og/ErUJfQqhKArAOoApZkdU6x28OiHwH4V+2r45MxGzzH8zc3TTP5xXKDEjjSiJuG5l1oE1zy+kgcOY6lswNkwKYvKonjVce8nrWWbYhXlfwtrEJBQW6qQuskLelNsfmQyxyLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727128987; c=relaxed/simple;
	bh=1vAxq2N8NQEqHYt1SjAgoe/iB30bh5QaDV814F9GBgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CrBLKcw4Dq3yHv1nULpGeaZQ9WjehssnbH7fp1HDjEL1HyWQ/RCtfcxfmdCD68k2fFs9YkQS3vUy/AU/kz5semRNryKssCk+gggxpmjpGYOt6OV4yqSdsvReHIDDbP7wvvjbuwI8VscalzEa24rWK9Hk7P/Jltc2b5ri82cOqgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4KWVzUf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BE8C4CEC4
	for <bpf@vger.kernel.org>; Mon, 23 Sep 2024 22:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727128987;
	bh=1vAxq2N8NQEqHYt1SjAgoe/iB30bh5QaDV814F9GBgM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r4KWVzUflF9uimP9MzE/PI6j4/5PiuDmqGCJmnFxIDmdE2ZQJKr0XplpSdxHsRR+6
	 oxYtlW4bRKVSWTQixti7gcbbZFlBeWEXF3CxHTbO9I0rNa8bPCL5CP1SZyEi9dPeGg
	 Ej3EReI+rOjdoL5sPX5MEmWn1+73LO7ToVU/mNRa9b8GgwCsVQFoGhvaWgPrUKty/S
	 fExrLjo5c7RKDeeLLqo4xNNUdqOByN7Jclubbhc8Ss4jSm4x6TLblMyaOqGwISdSDq
	 96uu8UnjSll2NbbDRxJDbLVjKSoeDFJRMBgJpR+qrwsb1szpWh5s3ACHM8uM5ec+l1
	 xXA39bfqtJfHA==
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a07bd770e2so26582505ab.0
        for <bpf@vger.kernel.org>; Mon, 23 Sep 2024 15:03:07 -0700 (PDT)
X-Gm-Message-State: AOJu0YwhrSagr/euXIfD/uMYaq22kF1ulmXXPA2oVT7gSrOWM9ECoQjU
	w8JU9DPXjOa3X4dhn+hlzSG7p+bcUaW1tz0zVCDgr8G78ynPofcB0Kf8g80RDFLzuola8i062gD
	jjyXiryMM8Ra3Rvzk1xwGPxa9z4k=
X-Google-Smtp-Source: AGHT+IH+BwzVVQKa8PuqJ/uYtuC+IMq3xgrXIO2o3jL18oOrcX4pnqLsyt8tDFk3y4Z41xtPgSQMUesnAOcFMSdbtyU=
X-Received: by 2002:a05:6e02:1748:b0:39a:eb57:dc7 with SMTP id
 e9e14a558f8ab-3a0c8c6a2f2mr125296675ab.1.1727128986348; Mon, 23 Sep 2024
 15:03:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923210049.2558881-1-chantr4@gmail.com>
In-Reply-To: <20240923210049.2558881-1-chantr4@gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 23 Sep 2024 15:02:55 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5P=6tbGe_LGJVfa41MbBF8kQ4JabCW-bvmN_AbeT3y=w@mail.gmail.com>
Message-ID: <CAPhsuW5P=6tbGe_LGJVfa41MbBF8kQ4JabCW-bvmN_AbeT3y=w@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: vm: add support for VIRTIO_FS
To: Manu Bretelle <chantr4@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, 
	yonghong.song@linux.dev, dxu@dxuuu.xyz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 2:01=E2=80=AFPM Manu Bretelle <chantr4@gmail.com> w=
rote:
>
> danobi/vmtest is going to migrate from using 9p to using virtio_fs to
> mount the local rootfs: https://github.com/danobi/vmtest/pull/88
>
> BPF CI uses danobi/vmtest to run bpf selftests and will need to support
> VIRTIO_FS.
>
> This change enables new kconfigs to be able to support the upcoming
> danobi/vmtest.
>
> Tested by building a new kernel with those config and confirming it
> would successfully run with 9p (currently what is used by vmtest), and
> with virtio_fs (using a local build of vmtest).
>
>   $ vmtest -k arch/x86/boot/bzImage "findmnt /"
>   =3D> bzImage
>   =3D=3D=3D> Booting
>   =3D=3D=3D> Setting up VM
>   =3D=3D=3D> Running command
>   TARGET SOURCE    FSTYPE OPTIONS
>   /      /dev/root 9p     rw,relatime,cache=3D5,access=3Dclient,msize=3D5=
12000,trans=3Dvirtio
>   $ /home/chantra/local/danobi-vmtest/target/debug/vmtest -k arch/x86/boo=
t/bzImage "findmnt /"
>   =3D> bzImage
>   =3D=3D=3D> Initializing host environment
>   =3D=3D=3D> Booting
>   =3D=3D=3D> Setting up VM
>   =3D=3D=3D> Running command
>   TARGET SOURCE FSTYPE   OPTIONS
>   /      rootfs virtiofs rw,relatime
>
> Signed-off-by: Manu Bretelle <chantr4@gmail.com>
> ---
>  tools/testing/selftests/bpf/config.vm | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/config.vm b/tools/testing/selfte=
sts/bpf/config.vm
> index a9746ca78777..b96b1fad2a04 100644
> --- a/tools/testing/selftests/bpf/config.vm
> +++ b/tools/testing/selftests/bpf/config.vm
> @@ -10,3 +10,6 @@ CONFIG_VIRTIO_CONSOLE=3Dy
>  CONFIG_VIRTIO_NET=3Dy
>  CONFIG_VIRTIO_PCI=3Dy
>  CONFIG_VIRTIO_VSOCKETS_COMMON=3Dy
> +CONFIG_FUSE_FS=3Dy
> +CONFIG_VIRTIO_FS=3Dy
> +CONFIG_FUSE_PASSTHROUGH=3Dy

Please sort these CONFIG_* in alphabetical order.

Other than this,

Acked-by: Song Liu <song@kernel.org>

Thanks,
Song

