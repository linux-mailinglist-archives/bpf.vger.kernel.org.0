Return-Path: <bpf+bounces-61792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3632DAEC446
	for <lists+bpf@lfdr.de>; Sat, 28 Jun 2025 04:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B14584A4C43
	for <lists+bpf@lfdr.de>; Sat, 28 Jun 2025 02:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A83E1E0DCB;
	Sat, 28 Jun 2025 02:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1Pz2f0p"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103B61A2C0B
	for <bpf@vger.kernel.org>; Sat, 28 Jun 2025 02:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751078980; cv=none; b=O5xvtAkTEisAG/SceczYRNhDjSEWc+7u2VJxH0N7hP2fZ05GtHOsCt8NJR/Agu7zcEzXN2mFRkhdQdw9/HZg5lz4M5aFpC5laoPzFM76BybT67M4PlMJtITeW8LwVG9wFMZ/yhyDXoM9JFpsz3X+GsdTzUDzkVVtd1JdktPQnAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751078980; c=relaxed/simple;
	bh=oIloyYH1FYgaVIXk2YG8HCsn9ii9uICwTBiZXk7qtDQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PaxJN91SBdHbPK2/BKHnDZo8QKWQTW7DONNyX2z9AJPOifk35ROg1zSQPBnP6wyz7XSAYtcrWW2Hltt/fkpERl7cejylrJWy4FXYGJDGgEpalE861auJOGr4DFo3h67G5xG52fFO5hdaUj4E+3svUlq9YXR9fkDyFJJuAJXKngk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1Pz2f0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D374BC4CEE3;
	Sat, 28 Jun 2025 02:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751078979;
	bh=oIloyYH1FYgaVIXk2YG8HCsn9ii9uICwTBiZXk7qtDQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R1Pz2f0p6nfur9ihZ57d0ZCPHCOb4giMqS8sTAzQ7cN0K3FAjv9l12lBmXfXEwcIk
	 cT+y+3Nldb8wUTlgoau56qW3sJtro315iU/shIVFQSbVVUZmNVrLo+FZfjqSYFVirA
	 gv6m13T9uKhxLxgouwZZS5jRj/On7ey0QRTwxU4U82PenxEGlBan7UGmu5F5a+oLsG
	 DHPMlmHjCi9w+gyuTt2FdiVY1QdFx1otb2ToRjmsNanomcOO2BRr9xJPUd7kMMUYCl
	 J0a74j2cPkvzP/jiihuRSsfDXUjZN3jXEmGI1Rp16yiIAXUmUrbnqCFxaH9pFp4N3m
	 bNIxULyO42kzg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADEC38111CE;
	Sat, 28 Jun 2025 02:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] selftests/bpf: bpf_rdonly_cast u{8,16,32,64}
 access tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175107900577.2118971.13642028018339865468.git-patchwork-notify@kernel.org>
Date: Sat, 28 Jun 2025 02:50:05 +0000
References: <20250627015539.1439656-1-eddyz87@gmail.com>
In-Reply-To: <20250627015539.1439656-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, andrii.nakryiko@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 26 Jun 2025 18:55:39 -0700 you wrote:
> Tests with aligned and misaligned memory access of different sizes via
> pointer returned by bpf_rdonly_cast().
> 
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  .../bpf/progs/mem_rdonly_untrusted.c          | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)

Here is the summary with links:
  - [bpf-next,v1] selftests/bpf: bpf_rdonly_cast u{8,16,32,64} access tests
    https://git.kernel.org/bpf/bpf-next/c/c4b1be928ea0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



