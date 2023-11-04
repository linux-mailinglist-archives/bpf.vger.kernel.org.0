Return-Path: <bpf+bounces-14207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822CF7E0FCD
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 15:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE72D1C20A21
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 14:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504C21A590;
	Sat,  4 Nov 2023 14:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCLU2ipf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B370E18632
	for <bpf@vger.kernel.org>; Sat,  4 Nov 2023 14:05:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39332C433C7
	for <bpf@vger.kernel.org>; Sat,  4 Nov 2023 14:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699106734;
	bh=hC/N72R9DWJ/O5KsEmvstmyxCfHCAO7ogbbyTpxOqkc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aCLU2ipfuAvsWeG9Vn6XLol8BKJxa4RvF1r3qrFHM1WT7jFoC8VHlM+3FZIu8I6QM
	 QEEemZdrVg8Ku+Gn9AhDZfux14nsuZZ9ATfgmeYD8A+80g8IAjgsIwKdxVEed5JI3h
	 NL8EbLl3FjkdxoSPb+V0op15sZbWDrDMhF5exy3FV9BbrfG1XEpHXlpJ8KfPyjGAR1
	 L/OrRU/cZmrdJJ+JPoV/O0cQ2439Uysnu5O5bUO6aOYjJ8ajK+7DTgijxHd7zSJDRP
	 O+dZ1tfcbBwvOMU8Yz5fpqyoLCuRB61YgkrwdyIY807Gt/8Ggfp8OHZuJ7qCPxMGwH
	 +jsHML6pwe51Q==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-507ad511315so4298167e87.0
        for <bpf@vger.kernel.org>; Sat, 04 Nov 2023 07:05:34 -0700 (PDT)
X-Gm-Message-State: AOJu0YxH5ppTVzePl6GfD91sRjA7hZ6Vopmgwj9gwR3xMSQjyT55WRSY
	r92cVVA3XX15BblGpu8qcdN90lnbT5bvr0b4n00=
X-Google-Smtp-Source: AGHT+IHuWW4wJ6bhzqG3d9WhO5EiH29wXSm3Wa5EVkp2le2lGshzff+7/vGv2+X/Pq64NgFY+CBL+dHW2/4dPsq+8aY=
X-Received: by 2002:a05:6512:e95:b0:509:4405:d5a8 with SMTP id
 bi21-20020a0565120e9500b005094405d5a8mr9394912lfb.68.1699106732276; Sat, 04
 Nov 2023 07:05:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231104001313.3538201-1-song@kernel.org> <CAADnVQLZ7RkH2ykEohFdDLJkjhmizHUuBakoevjEwvxOFMFjBw@mail.gmail.com>
In-Reply-To: <CAADnVQLZ7RkH2ykEohFdDLJkjhmizHUuBakoevjEwvxOFMFjBw@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Sat, 4 Nov 2023 07:05:20 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7AoNK4SoMeaPfjnP85pVida612HTnnsm7pjER1nCajNQ@mail.gmail.com>
Message-ID: <CAPhsuW7AoNK4SoMeaPfjnP85pVida612HTnnsm7pjER1nCajNQ@mail.gmail.com>
Subject: Re: [PATCH v12 bpf-next 0/9] bpf: File verification with LSM and fsverity
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, ebiggers@kernel.org, fsverity@lists.linux.dev, 
	kernel-team@meta.com, kpsingh@kernel.org, martin.lau@kernel.org, 
	roberto.sassu@huaweicloud.com, tytso@mit.edu, vadfed@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexei,

On Sat, Nov 4, 2023 at 1:38=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
>
>
> On Sat, Nov 4, 2023 at 1:13 AM Song Liu <song@kernel.org> wrote:
>>
>> Changes v11 =3D> v12:
>> 1. Fix typo (data_ptr =3D> sig_ptr) in bpf_get_file_xattr().
>>
>> Changes v10 =3D> v11:
>> 1. Let __bpf_dynptr_data() return const void *. (Andrii)
>> 2. Optimize code to reuse output from __bpf_dynptr_size(). (Andrii)
>> 3. Add __diag_ignore_all("-Wmissing-declarations") for kfunc definition.
>> 4. Fix an off indentation. (Andrii)
>
>
> Song,
>
> You=E2=80=99re spamming. I keep deleting your patches.

Sorry for the spamming. I knew I was sending too much.

Song

> Pls wait at least a day or two before reposting.
> In this case you need to wait for trees to converge.
>
> Thanks

