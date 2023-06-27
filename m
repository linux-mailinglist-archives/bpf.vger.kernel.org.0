Return-Path: <bpf+bounces-3565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FDC73FCE8
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 15:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E612810B3
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 13:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18735182C2;
	Tue, 27 Jun 2023 13:35:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DE7111E;
	Tue, 27 Jun 2023 13:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E91C433C8;
	Tue, 27 Jun 2023 13:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687872914;
	bh=TV1qg0oAArUuXRSZzw89Zq1glYP5kqNzvG4JVxR8jsc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZVWM2DOQTPyNLM0jr058t8nyoWeZx05XtSj1kMXwvZrs61+O+oyOFvIBHWxgrptg+
	 EKxgkemPvjy1WtQU8bj2F7sRSvuU27r704GrrYiHomnpkte0s5pS3DZ7QU7o1OssMf
	 ZgW7efuqCNMjYII3JmF+rlQnWN+YCrqdut4G47FvJhbKbyGLKZfS5+0o0fjKSzULuC
	 o54npEkZQsItYBoSplxxv+92odkF9rpKxSJ/M5PLnXxY3M3+8wySjPJshDr5PJV65S
	 wNZVQifM2lPH76Qgt0DJOTc+kIOhRE+v98W5f1iE+PWk8r8P1a6bXQKaRZDk7Lhp4o
	 sIsTwrgxz5Jrg==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 16905BBFF5A; Tue, 27 Jun 2023 15:35:12 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Stanislav Fomichev <sdf@google.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Donald Hunter <donald.hunter@gmail.com>, bpf
 <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Network Development
 <netdev@vger.kernel.org>
Subject: Re: [RFC bpf-next v2 11/11] net/mlx5e: Support TX timestamp metadata
In-Reply-To: <CAKH8qBv-jU6TUcWrze5VeiVhiJ-HUcpHX7rMJzN5o2tXFkS8kA@mail.gmail.com>
References: <20230622195757.kmxqagulvu4mwhp6@macbook-pro-8.dhcp.thefacebook.com>
 <CAKH8qBvJmKwgdrLkeT9EPnCiTu01UAOKvPKrY_oHWySiYyp4nQ@mail.gmail.com>
 <CAADnVQKfcGT9UaHtAmWKywtuyP9+_NX0_mMaR0m9D0-a=Ymf5Q@mail.gmail.com>
 <CAKH8qBuJpybiTFz9vx+M+5DoGuK-pPq6HapMKq7rZGsngsuwkw@mail.gmail.com>
 <CAADnVQ+611dOqVFuoffbM_cnOf62n6h+jaB1LwD2HWxS5if2CA@mail.gmail.com>
 <m2bkh69fcp.fsf@gmail.com> <649637e91a709_7bea820894@john.notmuch>
 <CAADnVQKUVDEg12jOc=5iKmfN-aHvFEtvFKVEDBFsmZizwkXT4w@mail.gmail.com>
 <20230624143834.26c5b5e8@kernel.org> <ZJeUlv/omsyXdO/R@google.com>
 <ZJoExxIaa97JGPqM@google.com>
 <CAADnVQKePtxk6Nn=M6in6TTKaDNnMZm-g+iYzQ=mPoOh8peoZQ@mail.gmail.com>
 <CAKH8qBv-jU6TUcWrze5VeiVhiJ-HUcpHX7rMJzN5o2tXFkS8kA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 27 Jun 2023 15:35:12 +0200
Message-ID: <878rc5hvu7.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Stanislav Fomichev <sdf@google.com> writes:

> Ack, let me see if I can fit tx csum into the picture. I still feel
> like we need these dev-bound tracing programs if we want to trigger
> kfuncs safely, but maybe we can simplify further..

FWIW, I absolutely think we should go with "attach to ifindex + dev
bound" model instead of the "attach to driver kfunc and check ifindex in
BPF". The latter may be fine for BPF kernel devs, but it's a terrible
API for a dataplane, which IMO is what we're building here...

-Toke

