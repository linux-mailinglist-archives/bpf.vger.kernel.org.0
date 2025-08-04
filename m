Return-Path: <bpf+bounces-65013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D913B1AA10
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 22:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EBC21806D5
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 20:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF19E231856;
	Mon,  4 Aug 2025 20:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5ndDOhV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AFA219E93;
	Mon,  4 Aug 2025 20:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754339192; cv=none; b=iKBRpEj0aslbs4/1dCF5uPBq9yiiDti2SQUM1WuWX7VgsFDkRwrjSrc0qj8N3NR/4ckbgfv8Q5AGISexStQsE/PtWjwumnaYdB/iwe3QysCzFsUmecKnhhBlA8BlRuNza7NUFoItuWk7kwBWizxE2jpwc9oRbAlpXRTVpAhv18k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754339192; c=relaxed/simple;
	bh=2g+ZtCuz9i9TcOCHiTSR4G/KrKNvVE5KUDD6gEF1B1k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O5DZNyZdSepnqcQspilyPBOWtWr1HJzNxSY0LY5Ig3oPBdAVirpPVKby1zgFI2nK/6u9vLQCyO5lOeD6UhQSCZR24sBZq/1v2POj9+NdJ6fBhY7grTLGXzepC9ye8xzk28APkIbgwiXumkVc57D9wf5ry/iW+M9Dy40MONWlxO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5ndDOhV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F4AC4CEE7;
	Mon,  4 Aug 2025 20:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754339192;
	bh=2g+ZtCuz9i9TcOCHiTSR4G/KrKNvVE5KUDD6gEF1B1k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Y5ndDOhVwr9I8AB/Z656guxCxKS4jZGcjY1uJzlMQlMbrPzckMFZCoqd0w8YfHvcA
	 uK+C//hiH5FEU86faicQviLtZo5tBzvp4BNUMn0VyKK19GKWN00p4Bp2KBQDshX1rO
	 QSCVlBc+I1I8Z4837aTTjCOXM4QwfDPdgBZPsecdblABrJql4lKCskK7FET7TvY3cs
	 DT9l0uNVxGQ9vL6sp0sKloHEN0QTeXEzf3qsQl09qTUk90h3+PLh2/D6wuvCpelCI6
	 rK0CGKIqdjdqgXn2MZ4KkGpuEGkpkwTvNhQqwlJW7jsP47pZ95bY7CqGqh262LbNWG
	 qpeQqLFBORsMA==
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
Subject: Re: [PATCH bpf-next 02/10] riscv, bpf: Extract emit_st() helper
In-Reply-To: <20250719091730.2660197-3-pulehui@huaweicloud.com>
References: <20250719091730.2660197-1-pulehui@huaweicloud.com>
 <20250719091730.2660197-3-pulehui@huaweicloud.com>
Date: Mon, 04 Aug 2025 22:26:28 +0200
Message-ID: <87zfce3kaz.fsf@all.your.base.are.belong.to.us>
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
> There's a lot of redundant code related to store from immediate
> operations, let's extract emit_st() to make code more compact.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

