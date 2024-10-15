Return-Path: <bpf+bounces-42092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C00C99F6B0
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 21:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 016891F2438F
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 19:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E151F80C1;
	Tue, 15 Oct 2024 18:58:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553C81F80B3;
	Tue, 15 Oct 2024 18:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729018738; cv=none; b=DF+7E9D4g23d5nsBGHY0nkLJkMQnOHcpFAK4g5wD48iuaysQMF9lvgjW0xY4RZ+ylhvHjiCCd45XQGirNvx6OyWJSfK/IEhpgprW6ELJeVOHj8fFb8hYZyQV1/eHg1v+CrTNaF+M6mu5+ZgXq6ZG++X+CHiqqLjkbUckCvw4sxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729018738; c=relaxed/simple;
	bh=uXFae75GHQA9LDufG7vgBmKwunC+sPn1yCbhUgcBonw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ippnBtwF0PTVk2K7y7qE9Kf0Zx+Cogd4VEQBS9cVb0NMIEwT4dsyAxVOb01N6zCqr9XosQFV/h9ldIen9sFmPhNHdH/8khuKREyGBtw3pzNdpOA+5/hMlT49FR+pTEm6Uf/Ed4pStNUqLhwk85zBjiaky5Uz7drOUYYQmhUd3jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BBAC4CEC6;
	Tue, 15 Oct 2024 18:58:56 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: will@kernel.org,
	ast@kernel.org,
	puranjay@kernel.org,
	andrii@kernel.org,
	mark.rutland@arm.com,
	Liao Chang <liaochang1@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2] arm64: insn: Simulate nop instruction for better uprobe performance
Date: Tue, 15 Oct 2024 19:58:53 +0100
Message-Id: <172901867521.2735310.14333146229393737694.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240909071114.1150053-1-liaochang1@huawei.com>
References: <20240909071114.1150053-1-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 09 Sep 2024 07:11:14 +0000, Liao Chang wrote:
> v2->v1:
> 1. Remove the simuation of STP and the related bits.
> 2. Use arm64_skip_faulting_instruction for single-stepping or FEAT_BTI
>    scenario.
> 
> As Andrii pointed out, the uprobe/uretprobe selftest bench run into a
> counterintuitive result that nop and push variants are much slower than
> ret variant [0]. The root cause lies in the arch_probe_analyse_insn(),
> which excludes 'nop' and 'stp' from the emulatable instructions list.
> This force the kernel returns to userspace and execute them out-of-line,
> then trapping back to kernel for running uprobe callback functions. This
> leads to a significant performance overhead compared to 'ret' variant,
> which is already emulated.
> 
> [...]

Applied to arm64 (for-next/probes), thanks! I fixed it up according to
Mark's comments.

[1/1] arm64: insn: Simulate nop instruction for better uprobe performance
      https://git.kernel.org/arm64/c/ac4ad5c09b34

-- 
Catalin


