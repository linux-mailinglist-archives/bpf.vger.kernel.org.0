Return-Path: <bpf+bounces-23263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FFC86F3C8
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 06:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6D52824E0
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 05:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEB379FD;
	Sun,  3 Mar 2024 05:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4F0eECe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83A679C0
	for <bpf@vger.kernel.org>; Sun,  3 Mar 2024 05:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709445029; cv=none; b=XnRFErMuPe0MfJ8SRTOYOC0XzQWylYYIaEvQqfjIAw1akpf+e3+tDF7MtxI55ijyUkriZgO+a5ONbVIikuZ3CpvZVUSh2/fowIcy48gFdKa1MA4WItCQp/5F19Y/Ney7nsQ39xvwqlMtr4TWhqQ1OlKXMQBe3vqIJpDQB2oXP48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709445029; c=relaxed/simple;
	bh=x2o1QtblRsB/cudYrRgm1ls8o+79k00JyUcAbwoTOCc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=diUI2keFm5qvDG48HT0uBg0WLy1ydENS8bV2ygmCjoZkQNGPc7sUigNXtUHyiiHT4GXgWLdimdjDIpyzPoCpm676PtkRgTDuVsuL3Iyb/INt5L0iMd21kP0NDZQT7079R4WdepGz0Rqz9Blgg80A3Nq/P3UqCqPPePyNfj6CsH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4F0eECe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC2A6C433F1;
	Sun,  3 Mar 2024 05:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709445029;
	bh=x2o1QtblRsB/cudYrRgm1ls8o+79k00JyUcAbwoTOCc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H4F0eECeJ2i2+7nB4jilTZPbFkzyTmoFKW6mAp0dvjdgYkyhnhCPbTwWf4kALSxBA
	 AjtsUhXp/T+gToOXrkS4XoR3b9BsM5moo8GgyWWTQpEmDMXDIUXSkGcg4bjTmeDy4C
	 +8cvHV+nxQIIkfCuW5F01H0uYSH8X2+IIzxKpSq/QfAcyFAXOzpFnn7MXsx8Rlqg2T
	 VPjYgLansuXCxAPgzBzEaS5KURHb9qpRCKLOJnE53blexAkM8bMBUriAeVAo0EbKKg
	 L5kByPpS1q9v8mLgUsZgZgNLI9xCJcljsEcUE/veqebqgY0NW6AgUflUFCCNtcHq1j
	 ZlbdbT2i9L6lA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92623C39563;
	Sun,  3 Mar 2024 05:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf,
 docs: Use IETF format for field definitions in instruction-set.rst
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170944502959.27671.4992508067162694223.git-patchwork-notify@kernel.org>
Date: Sun, 03 Mar 2024 05:50:29 +0000
References: <20240301222337.15931-1-dthaler1968@gmail.com>
In-Reply-To: <20240301222337.15931-1-dthaler1968@gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, dthaler1968@gmail.com,
 void@manifault.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  1 Mar 2024 14:23:37 -0800 you wrote:
> In preparation for publication as an IETF RFC, the WG chairs asked me
> to convert the document to use IETF packet format for field layout, so
> this patch attempts to make it consistent with other IETF documents.
> 
> Some fields that are not byte aligned were previously inconsistent
> in how values were defined.  Some were defined as the value of the
> byte containing the field (like 0x20 for a field holding the high
> four bits of the byte), and others were defined as the value of the
> field itself (like 0x2).  This PR makes them be consistent in using
> just the values of the field itself, which is IETF convention.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf, docs: Use IETF format for field definitions in instruction-set.rst
    https://git.kernel.org/bpf/bpf-next/c/4e73e1bc1abf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



