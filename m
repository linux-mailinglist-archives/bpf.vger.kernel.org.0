Return-Path: <bpf+bounces-65017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E50B1AA27
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 22:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605AB623291
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 20:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67912224B1B;
	Mon,  4 Aug 2025 20:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poAF1fWY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E198F1514DC;
	Mon,  4 Aug 2025 20:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754339572; cv=none; b=h2SU1F35LLV3N082ztlnlSUDM5BRlm4Bj8uUcP1vB/19dwhHNBbsRbjcKLN8hHBljEEoBS+ElbXQAV9fzxjss8uUaQAFKGHK0rrSRy5UF+HSs3sXnDK3Y5W1uQqTJgq/xuA2fPyy1w7HjqLVyRkw5EJhGR6ju7tJJdl5oYLC31s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754339572; c=relaxed/simple;
	bh=Oz3qdUQptaVyyIeecrQbI/P2BVjPtce/YqRDIENIsn4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tRMw09CpIYh5ygfqmN48HxcftQokVRgPZs1LyCbZS0xRnVBUHWoZdA+elI4aP9TyroEiC0D+LwV7A17iWOTo+5AEwbEFZckKCAvvYKxB008ag5q3b8LUdUTXnbbn8r9EtfvU9ZdRuZx9RKb67P3xYT2u1+o2QtovQHjKn055ROY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poAF1fWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4675C4CEF0;
	Mon,  4 Aug 2025 20:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754339571;
	bh=Oz3qdUQptaVyyIeecrQbI/P2BVjPtce/YqRDIENIsn4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=poAF1fWYETD5JZJ5G3g6mEJv/elwzab8VawLlayZjSMUerd5gLQ+8Y1fj1r0PEGkO
	 9LYL75KrXjcAk7jLr1wuMuhNTzy+NR+D3cTYjQanlmG3xOd8M0QMielTy4ILBgkzpO
	 CiHZzot+4rXhnbgxYIzZCNHwYhzV764yPJUj+R3P4wPpaEA53uDropOJ98TqD8NAYh
	 jwnlyMBlTdotRtbn406xtAOHgARV+kWYRFcYykGMf0YlaUt9/d24BPv4QQ7BP5+htz
	 r0fFSo2gAN50OhZdMM8cQC0vlc0cv8XY/VbPn2HXLBFrQYXD+KuuDQJa4fRkqw85iO
	 HyLpYYSQljhiw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Pu Lehui
 <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next 06/10] riscv, bpf: Add Zacas instructions
In-Reply-To: <20250719091730.2660197-7-pulehui@huaweicloud.com>
References: <20250719091730.2660197-1-pulehui@huaweicloud.com>
 <20250719091730.2660197-7-pulehui@huaweicloud.com>
Date: Mon, 04 Aug 2025 22:32:48 +0200
Message-ID: <87ikj23k0f.fsf@all.your.base.are.belong.to.us>
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
> Add Zacas instructions introduced by [0] to reduce code size and
> improve performance of RV64 JIT.
>
> Link: https://github.com/riscvarchive/riscv-zacas/releases/download/v1.0/=
riscv-zacas.pdf [0]
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

