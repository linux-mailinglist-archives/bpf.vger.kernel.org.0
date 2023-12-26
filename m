Return-Path: <bpf+bounces-18668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB48C81E4D1
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 05:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9461F1C21C1F
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 04:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C61E1E4A7;
	Tue, 26 Dec 2023 04:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LX0MA6Yd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3AB18EBE;
	Tue, 26 Dec 2023 04:05:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8238BC433C8;
	Tue, 26 Dec 2023 04:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703563538;
	bh=88qZqX6FvEAqXKjlf4JusAJMCOr/iqqN/aaHLuITe7o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LX0MA6Ydz+Fu/oppRah8/YZWdY+giI3yLx6dyUMWavRp4FuW5/e2PapSiN/m9OG3z
	 TW2lk0lIryNpK75rpSe/gyV1y9gCpZk4M2skX+aueWWHzZNBEMWVQwJa3IMS9YlQBs
	 0Rz5xoa2JfTGdfyFC3XQR1R3CPfCGDr0R+ASNlIPfiaFqGUsSz/FOBracmfFYPalRM
	 K/yJgPw6crWAC+cwIAdVfQKTluzGxKPcaUlG87sbOCAL1VirGfXGEDZMGIfb8VTJal
	 peZlfWcxDdFmdnN5e9BVsUK5JtXmcM544QzbP35LFMpGnUNIGNA5Mr5vBuDG6c4Auz
	 OKp/b0meg39kg==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2335397e64so456729766b.2;
        Mon, 25 Dec 2023 20:05:38 -0800 (PST)
X-Gm-Message-State: AOJu0YyisJatePnmOOUmebMArpN1osAqmpVGZedKvfnDVt2UG6J2OH3H
	dpx8ZA7f/Z5fRFGs1388+my1nhbtzvsUSsbaL2Q=
X-Google-Smtp-Source: AGHT+IEGa6+8bEU9gUw/mjnCAVIWnhuOjEyxauSi9//dbs3tPS1ULTd/ep91JzpcFcxgocWR+jf0ShZZdfKyz7g11Ts=
X-Received: by 2002:a17:906:38c8:b0:a1c:45c0:4992 with SMTP id
 r8-20020a17090638c800b00a1c45c04992mr2898375ejd.106.1703563536979; Mon, 25
 Dec 2023 20:05:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231225090730.6074-1-yangtiezhu@loongson.cn>
In-Reply-To: <20231225090730.6074-1-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 26 Dec 2023 12:05:25 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4J6qRcC-nwJfVzoQYhOPKAMZmq=3xWuDpgdLrw4A2SPg@mail.gmail.com>
Message-ID: <CAAhV-H4J6qRcC-nwJfVzoQYhOPKAMZmq=3xWuDpgdLrw4A2SPg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add BPF JIT for LOONGARCH entry
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Hengqi Chen <hengqi.chen@gmail.com>, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Also list the loongarch maillist? See the "KERNEL VIRTUAL MACHINE FOR
MIPS (KVM/mips)" entry.

Huacai

On Mon, Dec 25, 2023 at 5:08=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> After commit 5dc615520c4d ("LoongArch: Add BPF JIT support"),
> there is no BPF JIT for LOONGARCH entry, in order to maintain
> the current code and the new features timely, just add it.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7cef2d2ef8d7..3ba07b212d38 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3651,6 +3651,13 @@ L:       bpf@vger.kernel.org
>  S:     Supported
>  F:     arch/arm64/net/
>
> +BPF JIT for LOONGARCH
> +M:     Tiezhu Yang <yangtiezhu@loongson.cn>
> +R:     Hengqi Chen <hengqi.chen@gmail.com>
> +L:     bpf@vger.kernel.org
> +S:     Maintained
> +F:     arch/loongarch/net/
> +
>  BPF JIT for MIPS (32-BIT AND 64-BIT)
>  M:     Johan Almbladh <johan.almbladh@anyfinetworks.com>
>  M:     Paul Burton <paulburton@kernel.org>
> --
> 2.42.0
>
>

