Return-Path: <bpf+bounces-64502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B01B13899
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 12:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63963B4E69
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 10:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB8E254849;
	Mon, 28 Jul 2025 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIMfEX/n"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7181A2472B4
	for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753697418; cv=none; b=qHLaWAccTWRp5XDcVDGZIFf2Jg99xo6YeBAzK5vlDzZ9q9ylnOe3KNARWM66sKQe5vW2zUSYLm1XA00GeRTtShhs+Bn02j+a0n53QS42VlQTyNOSpdmPLacF/dr7jMBcGLTWMWNpk8rl7gXEI8sgelInxtNbD4oHSRnL3PjS6CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753697418; c=relaxed/simple;
	bh=kTZsx80FlUs2XdqbHTMxBeKFNESUIZGy4QlnzEVaAtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IeL9jE/MXBzs/Qijw/woRce8eDBE7brFSndwJ18ngImsbdOuGK5KPGWL9j4QgO6KH20wKB6+efzCtTQrwY7qw+0RfY40gpp50LCMQ1uA5Lh2ICdvZesW/k1TMNK8x55WLNtpGrJmy7tXLw3LNFQxjQ/95PQcOwZnqhJM3xcAEy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIMfEX/n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1A8C4CEF7
	for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 10:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753697418;
	bh=kTZsx80FlUs2XdqbHTMxBeKFNESUIZGy4QlnzEVaAtw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KIMfEX/nzmoJjwhTLDureSIt/hao4fF90I3OenED5h0ThRGmxHkHqcO8fwaQSzwYY
	 eXW0OHSEVf8qiHkcjzFuLByG6F3ia2erZXl7G09aTMLEiJEq51MI+nYwNsxyhrGsD1
	 vo5goitMtvNp6hg6tzVz5tW853jc7YShOgff2j0ideSHOROBhHDHwoAmNX/WOdV+C3
	 Nfl9EFdr+Ws6e4fJbJZCNUWzHTIazr7ttVXhbOFbL2QAzpZPlAvZV2q1wXDQJ7ZYfD
	 Thyu4SRd6Y9OP4t5DYsezTETWb7v6Gpk4mVkcJdP9ghS8e4EQzZHqY/fPCXgFIqa4Y
	 CUhAiu8MMWVEg==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6088d856c6eso8167680a12.0
        for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 03:10:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVoe7/4PtDI3w0QcI3baEyDvxjWyQpM1yxYw5yykLydWbK6cbsywp4wRv/f3ZEO00pl9s8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfiZm3KWHSIMAEwT5slna1srO0ikmlfatTRvcRwIzFCveMZWKR
	m4pU2fTcHiSwUxaUYSfgGcKJUcoJUK/QDe6y2Z/xmc8Fr0gb1WeNFr09HYqTekZ8HJuMUy4BGOo
	3GpiXXWEHDfqeoSfbWNZpNrof7OrEyiQ=
X-Google-Smtp-Source: AGHT+IHUaX3PxhMevkSYPtyJWPakuO1UaEacEmkrv1dTcaqmysbetgIt4+vk2d/eIsNJiiM5eK+ANDRhD1IMVmixkZ4=
X-Received: by 2002:a05:6402:26c6:b0:615:37ed:b255 with SMTP id
 4fb4d7f45d1cf-61537edb3b8mr3241149a12.30.1753697416585; Mon, 28 Jul 2025
 03:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725102307.1026434-1-jianghaoran@kylinos.cn> <61c20b77-b664-46dd-8555-9142f6d647da@iogearbox.net>
In-Reply-To: <61c20b77-b664-46dd-8555-9142f6d647da@iogearbox.net>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 28 Jul 2025 18:10:02 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6M7pjcLPf535vYHvaTaHVNb1VOh1aim5CmwVmQfdKeBg@mail.gmail.com>
X-Gm-Features: Ac12FXzisr3sRYaRo_PTKjaK62aJlBziZJowpDQWfjQ0USyELFmiMVNgzHtFL8M
Message-ID: <CAAhV-H6M7pjcLPf535vYHvaTaHVNb1VOh1aim5CmwVmQfdKeBg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Fix two tailcall-related issues
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Haoran Jiang <jianghaoran@kylinos.cn>, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	kernel@xen0n.name, hengqi.chen@gmail.com, yangtiezhu@loongson.cn, 
	jolsa@kernel.org, haoluo@google.com, sdf@fomichev.me, kpsingh@kernel.org, 
	john.fastabend@gmail.com, yonghong.song@linux.dev, song@kernel.org, 
	eddyz87@gmail.com, martin.lau@linux.dev, andrii@kernel.org, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 27, 2025 at 3:19=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 7/25/25 12:23 PM, Haoran Jiang wrote:
> > v4:
> > 1,There is a conflict when merging these two patches on the basis of th=
e trampoline series patches, resolve the conflict issue
> [...]
> > Haoran Jiang (2):
> >    LoongArch: BPF: Fix jump offset calculation in tailcall
> >    LoongArch: BPF: Fix tailcall hierarchy
> >
> >   arch/loongarch/net/bpf_jit.c | 181 +++++++++++++++++++++++-----------=
-
> >   1 file changed, 119 insertions(+), 62 deletions(-)
>
> Same here, I presume Huacai will pick these up.
Yes, I will do.

Huacai
>
> Thanks,
> Daniel

