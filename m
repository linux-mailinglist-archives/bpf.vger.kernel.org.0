Return-Path: <bpf+bounces-65018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF70B1AA2D
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 22:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C00A93B1F56
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 20:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A797232386;
	Mon,  4 Aug 2025 20:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9YRPVMn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1186F143C69;
	Mon,  4 Aug 2025 20:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754339781; cv=none; b=rrahLQc+wEckgPCmLhtyI7nygP/hFpFcpyPllNEcmLlj2c4Fasz0XHZk5GDJHOUtcVCPDwvMGDShavUKTrWSJQoWy1bHcaYY0qR/eOTEZToNMcEjYkyMgM82Xljm7HjgMWJluWVNpXcvkaS+aSlk5AoGd3bar0vqTL0JBpOlYLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754339781; c=relaxed/simple;
	bh=GO8rvGk02sRCddqfEgsRwqixNwiAebU7mXFuh9NuWl8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ucrFLa8KtfIq05kJssY1ZIq6Qd/jg9up+d9Iux5jS5vSnzAPWsWX8VTfxUHZl1CQZFhVgMWOQb3oLCkrF2L1ccMQZOGSui9wtqQ8Z+Od2EOT7fWtVNCEJKqdgMyeF2llv2Z0UmAgEfFozbC/zo09FIcGeJJbxwbsBF3pOYPUkMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9YRPVMn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39429C4CEE7;
	Mon,  4 Aug 2025 20:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754339780;
	bh=GO8rvGk02sRCddqfEgsRwqixNwiAebU7mXFuh9NuWl8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=I9YRPVMnB//PRNbbfMeCvtZOrFsvnU0M2gd4QzQSSs5LCVvdPmrhjwz3NQYK1M7JL
	 W7Oj/IaYa+AY0AMvUhs5Usg16Z0xLMNEeJyH4DY7uYkxEX8dY7b6XGJVQwyI20WBzy
	 8PBdJoi86C/Lnx6BnkTjU+AJBOzMrJa1Wfxl0ecVCUAUyUwE8w6gLVMUYdE3Hle2Hs
	 r44O6GMJ4Toklhani1i8BK3TBUDx4LEM/PApPjPJqRJywqA1GfjKifDfrsQLvhw78T
	 VNGKm5oSZrOfYGartPfsLdtT5dlMSp/NU5ZkQWHwR8t0e9XoOFSfpcZvbEb+xGw2zE
	 hSVDm8eXxaGWQ==
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
Subject: Re: [PATCH bpf-next 10/10] selftests/bpf: Enable arena atomics
 tests for RV64
In-Reply-To: <20250719091730.2660197-11-pulehui@huaweicloud.com>
References: <20250719091730.2660197-1-pulehui@huaweicloud.com>
 <20250719091730.2660197-11-pulehui@huaweicloud.com>
Date: Mon, 04 Aug 2025 22:36:17 +0200
Message-ID: <87ectq3jum.fsf@all.your.base.are.belong.to.us>
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
> Enable arena atomics tests for RV64.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

