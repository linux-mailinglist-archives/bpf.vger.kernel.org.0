Return-Path: <bpf+bounces-17561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D2480F548
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 19:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12763281E11
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 18:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79947E777;
	Tue, 12 Dec 2023 18:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTH0WMbe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6BC7E770
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 18:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5ADC433C9
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 18:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702404742;
	bh=Oc0caK+z93EfQ2zFjDp0hTRPWOoxDfa+QR5OIdx+cPw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NTH0WMbeyZTsoEYggwoFy6559chGd/69rm1sHETNu6WqemAsf8u0G25RqJc+mfYcp
	 wCqlogVxzcdlcE9DqCsSVg9+2zMfmnwgH7LDrXL/xkp8XEpFFgUmWtKew6sCnDt5yr
	 4qj4qysFJ88rs9YtxzzpWOX5zDwv/HAmH35cXJmYIrIoSevVJr2XdNuNCMxIr4/gaj
	 fmNcm/XJXBpdqzI4AMq1/iGoJkEy13D5PKEd4sMDwsZ5PsWo0b1qOSbWmBkyOB3B1Z
	 k9RifeZwX5wNviNmfLrAhV3dHY9/gvlUE7gwmGCPuvRYaL+d0ROes7NWtHM3mfjzQ0
	 T+k15pYnNmjRg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50bf26b677dso5693667e87.2
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 10:12:22 -0800 (PST)
X-Gm-Message-State: AOJu0YxCyQvwi0hdebC8dOy4Uis1Jur0YO2bxgapwYygW9WnK6EmjgQY
	nVOq5Iev3OmEgmQYEXff2iy+KERMIPSwdnK9Gto=
X-Google-Smtp-Source: AGHT+IFY/4QGzAfra7HzepETbT0AZdZfN3QECFs7cNcxeQtFpF49vfSBo46zgNwMEqKcY/7SKyWGTZuzNBH6N0aRkc0=
X-Received: by 2002:ac2:5f85:0:b0:50b:f29a:9c2b with SMTP id
 r5-20020ac25f85000000b0050bf29a9c2bmr1749283lfe.71.1702404741019; Tue, 12 Dec
 2023 10:12:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211180733.763025-1-chantr4@gmail.com>
In-Reply-To: <20231211180733.763025-1-chantr4@gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 12 Dec 2023 10:12:09 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4RXFSSm+Fd=nRtpRrAqCA87xO1KSoEjpWnnH0RJMvWYQ@mail.gmail.com>
Message-ID: <CAPhsuW4RXFSSm+Fd=nRtpRrAqCA87xO1KSoEjpWnnH0RJMvWYQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next ] selftests/bpf: Fixes tests for filesystem kfuncs
To: Manu Bretelle <chantr4@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	ast@kernel.org, martin.lau@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 10:08=E2=80=AFAM Manu Bretelle <chantr4@gmail.com> =
wrote:
>
[...]
>   =3D=3D=3D> Booting
>   =3D=3D=3D> Setting up VM
>   =3D=3D=3D> Running command
>   [    4.291434] loop0: detected capacity change from 0 to 2097152
>   [    4.460828] EXT4-fs (loop0): recovery complete
>   [    4.468631] EXT4-fs (loop0): mounted filesystem
>   7b4a7b7f-c442-4b06-9ede-254e63cceb52 r/w with ordered data mode. Quota
>   mode: none.
>   [    4.988074] fs-verity: sha256 using implementation "sha256-generic"
>   WARNING! Selftests relying on bpf_testmod.ko will be skipped.
>   Can't find bpf_testmod.ko kernel module: -2
>   #90/1    fs_kfuncs/xattr:OK
>   #90/2    fs_kfuncs/fsverity:OK
>   #90      fs_kfuncs:OK
>   Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
>
> Fixes: 341f06fdddf7 ("selftests/bpf: Add tests for filesystem kfuncs")
> Signed-off-by: Manu Bretelle <chantr4@gmail.com>

Thanks for the fix!

[...]

