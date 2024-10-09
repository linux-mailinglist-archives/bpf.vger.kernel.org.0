Return-Path: <bpf+bounces-41369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 697D59962FF
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 10:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C52AE1C23344
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 08:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D446618E751;
	Wed,  9 Oct 2024 08:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQGMd+rR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FF618E378;
	Wed,  9 Oct 2024 08:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462825; cv=none; b=dGRqv+GTRL2D9Q3Sg07ALOM9B8OMPNrM9DNAzXmbQk06eXA37N/zJPsMqCzVEE33evIl1TDjwnAI8qqqze/PUsvJMffHswuSW06a7/AgrSyksJfCb25vxAMRiAebS1Q1jxG8cJwO3Rgfkd78avoxe8Us/caYR4OAY/H1Veft5fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462825; c=relaxed/simple;
	bh=9Q/0qMMDwH3DhWlkAuznWJ4wMHL7IcScpi38s4BmJEM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ATxQ0/sW5nXfvMdKi1cCbsaEKezlmsz87EoM2pI8SrLvXCvL/XwIVOqwnY++xrwr02UQAfrwp5xIlnWv02k20ITAiwmIEFehxsN8Rpa82ElrMKUqF5yBf4iAqDqnwkalQqBSqVHUhTGvTklVb3Qcu5YwDANH4s5kvr6SXlGlGQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQGMd+rR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA5EC4CEC5;
	Wed,  9 Oct 2024 08:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728462824;
	bh=9Q/0qMMDwH3DhWlkAuznWJ4wMHL7IcScpi38s4BmJEM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QQGMd+rREhqfT7e8a/8uYchi7BjyVc1W8ajDw9epzh+YilnnPbdIUHi3WW+A9XxF8
	 BrUPt/mHdYxVZZcFUq+bEA9fnhrytUZY+bDhUEvAC+3/ikq2a5Di0WodbRTKsBnj24
	 WdNlj3D/63NY0NuWhDEzhJT0Qly0bryiCzQ41DPIRgAJ1ObDFUBzk2dGZfqqVzCR+l
	 cXPdRSSR3r4GkV2Z1Nm0Faj7/282YByA53AAWGKJoZ1rfpQvIl8wip9PjS7r5UmrHJ
	 HbA2T7LMaKE9oqah79wDL1QXrAQSgqYj80YriTGgWjPy6vk6Dcne4NfZGJH24v1nMm
	 CwxP345lB7+nQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou
 <aou@eecs.berkeley.edu>
Subject: Re: [PATCH bpf] riscv, bpf: Fix possible infinite tailcall when
 CONFIG_CFI_CLANG is enabled
In-Reply-To: <20241008124544.171161-1-pulehui@huaweicloud.com>
References: <20241008124544.171161-1-pulehui@huaweicloud.com>
Date: Wed, 09 Oct 2024 10:33:40 +0200
Message-ID: <87jzeh4qvv.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> From: Pu Lehui <pulehui@huawei.com>
>
> When CONFIG_CFI_CLANG is enabled, the number of prologue instructions
> skipped by tailcall needs to include the kcfi instruction, otherwise the
> TCC will be initialized every tailcall is called, which may result in
> infinite tailcalls.
>
> Fixes: e63985ecd226 ("bpf, riscv64/cfi: Support kCFI + BPF on riscv64")
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Thanks! Did you test this with the selftest suite? Did the tailcall
tests catch it?

Note to self is that I should run kCFI enabled tests for RISC-V.


Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

