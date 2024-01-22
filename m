Return-Path: <bpf+bounces-20007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C99836580
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 15:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D38D1F23650
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 14:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C356D3D558;
	Mon, 22 Jan 2024 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SS2SBpYw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F033D551;
	Mon, 22 Jan 2024 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705934013; cv=none; b=OGQOCh1VZC9DohPAyETTkv2Pdg16duNlr5Eq82H9DAi8QfVDkIxjijsYXljr2R7wrpVRgolEDAeNuD9BmLmkKljORQlggIaSUmz3Sua5yv2PGZuRGEsmdL7Fhrg6FKWDdx664PwkcWKMOm80v5CV3AjGGtxrJTUyor5rEJBkBI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705934013; c=relaxed/simple;
	bh=8gCK9vmYYbOmXz91aeGohAAbZ9CT8MPYBv+dkby9x6g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bQDN6ocmCduq0OgEW4CQEBybgDI53ICctDJhNlw/LDLxtJUrgFngxqeaHkZ6hC4gCad09gUF7f8j+geGY2a8NRnf8ayDTrhrFGk8Az6sa42GT08TtSjEPmkOj53ZfG+GfvJ28qq2WF2Uhf+1oPYLNL7exI0N3/SVJPiIDb5hUu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SS2SBpYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D4BC433F1;
	Mon, 22 Jan 2024 14:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705934012;
	bh=8gCK9vmYYbOmXz91aeGohAAbZ9CT8MPYBv+dkby9x6g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SS2SBpYwtQoQnArem80S7dL4zsJ2zVdK5bcRSlUrJvQR1V4o1MX2/RfEXhr9/r13A
	 8b/Ncj+rdng+0cBrQCZUlCPpusOa/m/AL7HtQ+i4xEtIxxEqFg5Ybs2XPI5U/ZIQBN
	 g2/jqv+0ts2Mg3+qaoG8mMPGgsxV91EkU5UJmdhcE04PsnBWN0fXBTnzEaBSYFPDmb
	 zFp78QiqOC/cORxGM2AVJgujShJlIiDsZvo3dUyqMmh9nZjMUBSMRQwETCXBiP3lEc
	 e6SZkwL0F2xpO5Q7GgkOAINufxnQ/y7qEUtCEszbU6e+6QBtVT+i0zk9dzjWG3vKC7
	 KkERSGly33Jug==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, Luke Nelson
 <luke.r.nels@gmail.com>, Pu Lehui <pulehui@huawei.com>, Pu Lehui
 <pulehui@huaweicloud.com>
Subject: Re: [PATCH RESEND bpf-next v3 0/6] Zbb support and code
 simplification for RV64 JIT
In-Reply-To: <20240115131235.2914289-1-pulehui@huaweicloud.com>
References: <20240115131235.2914289-1-pulehui@huaweicloud.com>
Date: Mon, 22 Jan 2024 15:33:29 +0100
Message-ID: <87il3lqvye.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> Add Zbb support [0] to optimize code size and performance of RV64 JIT.
> Meanwhile, adjust the code for unification and simplification. Tests
> test_bpf.ko and test_verifier have passed, as well as the relative
> testcases of test_progs*.
>
> Link: https://github.com/riscv/riscv-bitmanip/releases/download/1.0.0/bit=
manip-1.0.0-38-g865e7a7.pdf [0]
>
> v3 resend:
> - resend for mail be treated as spam.
>
> v3:
> - Change to early-exit code style and make code more explicit.

Lehui,

Sorry for the delay. I'm chasing a struct_ops RISC-V BPF regression in
6.8-rc1, I will need to wrap my head around that prior reviewing
properly.


Bj=C3=B6rn


