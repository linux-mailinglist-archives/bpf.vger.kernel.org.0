Return-Path: <bpf+bounces-63412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B7FB06DCF
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 08:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77891AA0316
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 06:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88170286413;
	Wed, 16 Jul 2025 06:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUW2CmGx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA91221FA4;
	Wed, 16 Jul 2025 06:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752646993; cv=none; b=Du/UjxTIJLfmkOjqYkjXCxXVVzYeGYva9tPbWGA8V5gJcuBro/qtnOjngqebrIdlEPiohAFk7iWNEv1P2hjX+tmO5S4jrH9a8VIT54YAWjEv1AmGeeJ1XaeLUZTbEoLLRBJhDXgcmXNgxMZiGKbHoEe0Z5gzm8D4EiV5xql/IWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752646993; c=relaxed/simple;
	bh=Y5uVXVyPMMACYibIROdIlKUi17CwACMmbkg9TUVyo9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cNzgreVSSVF+zAfP6+fe3PT4VNgsOM5Dd+8RZkds1biKLygRfBg0dBBwMipLhXc+yIAug3JRO1vqsT5SQuFEKWESpp6klvnqSw2fGqPLCsduNF73+sNqFYzDGs3SXazVdc0s02TX6lKQNerb5uNkk9tA8R5C8bDUUE/1d7UWEZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUW2CmGx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87B7C4AF0B;
	Wed, 16 Jul 2025 06:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752646992;
	bh=Y5uVXVyPMMACYibIROdIlKUi17CwACMmbkg9TUVyo9I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eUW2CmGx/xFvxqLsTED7kJn+c1DNylVPFqNSki9nAX3q6WyFhA7A7qSVN7Q4JvN4Y
	 ytj5mL5s9r7jTLLZZpz2/L43i8YZeeYdDU94Z5PjNdtcfNCrvR9zAMyAp4GhhdqOGX
	 N0Qz+opwZgy/cxAvOpvSog3Lk2yFqRUiytcZy+EtXlwZ5JOjTFlg0/CSqgNcOLBvDh
	 7FXjxd98pNCtaFQXRq6feKvoYQ7Y/AW8y+aw3D3ILZcNNdQXX0qloaPrnKYxMFLi2b
	 mDZhVWc1hGDgYMKtN4DHrNIM7qJ3qZ6VfdspozVqcXhXNA4d8+bo4xX4Zqj7XT/I1K
	 JNx0EKP+bg5bQ==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so10336374a12.2;
        Tue, 15 Jul 2025 23:23:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVyuT7ID8vFQLrBJAeqKv5JZ8DgqUpfWm4L+GILs6S1LNUn7Zk9lptXZdnSlKwg6aL+lQ4=@vger.kernel.org, AJvYcCWNhA6xXj2hslptLfhqwcQbSBWuaDax1/z5baAaiPcB4MnrbaXSfy8C62FunY780Zv3bPlWU9wzmCF5XjHe@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaw2a2AjVrxoEd0PKLXACdoMqCOa+Yfp+rKtNwLC9x0qxXJ4/p
	D7Y/ybjeD9SEZ/mThX5H7qgp5bfwR7Ju/sUVnY3u+tI1DC+/O7yduqpe+BO1A5uD5DRWJbUV/c6
	S3ACPLrE2hi/DtaB+IagOyy0dnypzNnI=
X-Google-Smtp-Source: AGHT+IHkOqANW0HF9RVzQ81ncUpQtyJXlc2ePfhQR0yLzIQEZR36C9rl+xosZo6zt0eh/hJoK+xs4X/LRnAYQzeCtTA=
X-Received: by 2002:a05:6402:2755:b0:609:9115:60f8 with SMTP id
 4fb4d7f45d1cf-61285be4399mr1051377a12.21.1752646991218; Tue, 15 Jul 2025
 23:23:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716043915.15034-1-yangtiezhu@loongson.cn>
 <CAAhV-H5yPPcU03MGenKDH=sUTkmMPnsGj13zkLA1h-uHVMcHOQ@mail.gmail.com> <cd190c8a-a7b9-53de-d363-c3d695fe3191@loongson.cn>
In-Reply-To: <cd190c8a-a7b9-53de-d363-c3d695fe3191@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 16 Jul 2025 14:22:59 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Ar0=enpFwPeJzu2rcp=-QopySYQuntL9KDv9Nc=+mQg@mail.gmail.com>
X-Gm-Features: Ac12FXxzs7JQs2RvbrAF90p0piA3re-uZkEFJq5zc8i9njC300-2r7fDTxOf9JE
Message-ID: <CAAhV-H4Ar0=enpFwPeJzu2rcp=-QopySYQuntL9KDv9Nc=+mQg@mail.gmail.com>
Subject: Re: [RFC PATCH] LoongArch: BPF: Add struct ops support for trampoline
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Hengqi Chen <hengqi.chen@gmail.com>, bpf@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 1:10=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> On 2025/7/16 =E4=B8=8B=E5=8D=8812:42, Huacai Chen wrote:
> > Hi, Tiezhu,
> >
> > I hope this patch can be squashed to V4 of chenghao's patchset, as a
> > co-developer.
>
> No, do not squash, just add it as the last patch if necessary.
>
> I think keep it as a single patch is proper due to it is an
> additional independent feature and the log can be clear.
OK, then put this as the last patch of chenghao's V4.

Huacai
>
> Thanks,
> Tiezhu
>
>

