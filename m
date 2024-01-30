Return-Path: <bpf+bounces-20757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4F7842B1E
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 18:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A4B1F290BC
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 17:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943A014E2F2;
	Tue, 30 Jan 2024 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiCvA2Ng"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A36A14E2D2;
	Tue, 30 Jan 2024 17:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706636393; cv=none; b=sLPbS9KxkyC0Nbr23lJz1/PZ9pbrM8Dgyz3L82cTqUSFJMZSjZj3Dk25/4tnkf5cdQSSmnWlREqyPN+Ja5GMW1wpYtumnKe24g59UOJ9QZph7QGKHHIb23f4Xyba4ST9VOMluXuiavbnXZPZbgQtecXfHpRUyhy8wb8ZLTnL/dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706636393; c=relaxed/simple;
	bh=1bdXVoog3gCDNm4UnOcpyOfs3ya81qai/EuCHrPGD4s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TMHpw96s6ltROUTVE9JyVKw3uOvhWQlsTxFbCrW3tP+4rjKpczdpCoPWNS+hjgr6JXaPN6GCIk/2RCBIKIBG2oPcZjJw3EhKZkmLGvP2NsBeA8zrTbAbtBGPGt+3CAS0wdkCMKoy2SNQForYxowlGrSnl6waHTaGg88g+xfwiTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiCvA2Ng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3129C43390;
	Tue, 30 Jan 2024 17:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706636392;
	bh=1bdXVoog3gCDNm4UnOcpyOfs3ya81qai/EuCHrPGD4s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DiCvA2Ng1qXQ14DmbfbH/Pyme8b5Jrw2NHgNKywxJL3R4Jqpu/zrAGeyx3xTiNwvv
	 //MiLj3dme1qnqDixiOLfriedtlVsJanELS4MM3cS9D2kxgymmvxWpoMQcrDFo/0hh
	 k7tS3gCehGtTLXLQFHhtwW/Sqi/DuOSbn0b6U0oXSMWEsv06i8nxe+2l31Clg46H6F
	 LSa1pR9hK8MsFFZWc8zI75oM+9Jh3fEzjMPp4FKxi4ZQ0g0xJXxBPPHCo2kW5PliKZ
	 hETKYRjcKDVzkWQujOjDL5Sj9iYN9dmJQlml0fHWSvRBzDVR2SJcTYAdUUAgFw6Mgd
	 AL1Fyuyl8Zrpg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Hou Tao <houtao1@huawei.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Luke Nelson <luke.r.nels@gmail.com>, Pu Lehui
 <pulehui@huawei.com>, Pu Lehui <pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf-next 0/2] Enable inline bpf_kptr_xchg() for RV64
In-Reply-To: <20240130124659.670321-1-pulehui@huaweicloud.com>
References: <20240130124659.670321-1-pulehui@huaweicloud.com>
Date: Tue, 30 Jan 2024 18:39:49 +0100
Message-ID: <87jznqoh3u.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> This patch is the RV64 implementation of inline bpf_kptr_xchg()[0]. RV64
> JIT supports 64-bit BPF_XCHG atomic instructions. At the same time, the
> underlying implementation of xchg() and atomic64_xchg() in RV64 both are
> raw_xchg() that supported 64-bit. Therefore inline bpf_kptr_xchg() will
> have equivalent semantics. Let's inline it for better performance.
>
> link: https://lore.kernel.org/bpf/20240105104819.3916743-1-houtao@huaweic=
loud.com [0]

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

