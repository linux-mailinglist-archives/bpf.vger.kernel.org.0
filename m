Return-Path: <bpf+bounces-18675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C890081E7DE
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 15:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16D08283159
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 14:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42CB1DDE7;
	Tue, 26 Dec 2023 14:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCaIFXxr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D641DFDB;
	Tue, 26 Dec 2023 14:41:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E029FC433C9;
	Tue, 26 Dec 2023 14:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703601678;
	bh=99Ww84La77nNm0zpCCzrDa5+kHxswmTCeN2+XPiGBnc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YCaIFXxrkI12vk+6omNA+lt3oBR3+FX4Crnh0s3qLXNFnmJe/haiBpEhfbBbmsSEK
	 b+HMNETya1Ys3bHp5MwPCt1nChCEaOSNPkQ+wEDX/+x3Azkd+UJ5JuBgJsJQhpRbQ5
	 Lp0jkMwJV5kzkiC/5MKI9SNRLfCgL+DDqjPVrM2Yqe6nsbOap+JVjEyqCunCWaa08G
	 icJwG9dIO/k64K5tz7AK7q8CCQoE2s9+jF+FXF0sX9M7OplOHBpv8gfLND3ZwQtrVX
	 25hidQz2DC4sMEp+unhSiEJ0Wsc2rtmWDQ30ALdcVJi0/HeUeX2ahc4h5P8o/raIXK
	 CZltgYrSiTQKg==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5553f768149so146522a12.3;
        Tue, 26 Dec 2023 06:41:18 -0800 (PST)
X-Gm-Message-State: AOJu0YyEXYnT9RHY/Z1r6apfRNqL0OcKVYNsf2dakNR0ZFAX9P+6RtB2
	HxSeAjvFPjFhjwV6xFA114tn94rKBRMCbKIhIAY=
X-Google-Smtp-Source: AGHT+IEtl8+Lf10lZk7z0nJU4OIJkSw8ChVKPP/jEKIjSh/fpwGcpSGFzhw+qsAdQKWW7QIVBuc3B38p/g7ydh1iS24=
X-Received: by 2002:a17:906:1083:b0:a23:6cb4:e627 with SMTP id
 u3-20020a170906108300b00a236cb4e627mr3211287eju.96.1703601677285; Tue, 26 Dec
 2023 06:41:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231225090730.6074-1-yangtiezhu@loongson.cn> <CAAhV-H4J6qRcC-nwJfVzoQYhOPKAMZmq=3xWuDpgdLrw4A2SPg@mail.gmail.com>
 <e9f3c6c3-69f6-621c-92a2-9786f09fe3d6@loongson.cn>
In-Reply-To: <e9f3c6c3-69f6-621c-92a2-9786f09fe3d6@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 26 Dec 2023 22:41:05 +0800
X-Gmail-Original-Message-ID: <CAAhV-H42nquHpBav_9Ys6AYCynX4WJ7geSATqE9NOC_if3HjSw@mail.gmail.com>
Message-ID: <CAAhV-H42nquHpBav_9Ys6AYCynX4WJ7geSATqE9NOC_if3HjSw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add BPF JIT for LOONGARCH entry
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Hengqi Chen <hengqi.chen@gmail.com>, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 6:15=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
>
>
> On 12/26/2023 12:05 PM, Huacai Chen wrote:
> > Also list the loongarch maillist? See the "KERNEL VIRTUAL MACHINE FOR
> > MIPS (KVM/mips)" entry.
>
> I think it is not necessary, it is duplicate.
>
> Because this file is used for get_maintainer.pl, and arch/loongarch/net/
> is a subdirectory of arch/loongarch, so when execute the command
>
>    ./scripts/get_maintainer.pl -f arch/loongarch/net/
>
> the outputs will include both bpf@ and loongarch@ maillists automatically=
.
OK, then I queued it for loongarch-next.

Huacai

>
> Thanks,
> Tiezhu
>
> > Huacai
> >
> > On Mon, Dec 25, 2023 at 5:08=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongso=
n.cn> wrote:
> >>
> >> After commit 5dc615520c4d ("LoongArch: Add BPF JIT support"),
> >> there is no BPF JIT for LOONGARCH entry, in order to maintain
> >> the current code and the new features timely, just add it.
> >>
> >> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> >> ---
> >>  MAINTAINERS | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 7cef2d2ef8d7..3ba07b212d38 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -3651,6 +3651,13 @@ L:       bpf@vger.kernel.org
> >>  S:     Supported
> >>  F:     arch/arm64/net/
> >>
> >> +BPF JIT for LOONGARCH
> >> +M:     Tiezhu Yang <yangtiezhu@loongson.cn>
> >> +R:     Hengqi Chen <hengqi.chen@gmail.com>
> >> +L:     bpf@vger.kernel.org
> >> +S:     Maintained
> >> +F:     arch/loongarch/net/
> >> +
> >>  BPF JIT for MIPS (32-BIT AND 64-BIT)
> >>  M:     Johan Almbladh <johan.almbladh@anyfinetworks.com>
> >>  M:     Paul Burton <paulburton@kernel.org>
> >> --
> >> 2.42.0
> >>
> >>
>
>

