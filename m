Return-Path: <bpf+bounces-35189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9F1938408
	for <lists+bpf@lfdr.de>; Sun, 21 Jul 2024 10:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449EE1F211BD
	for <lists+bpf@lfdr.de>; Sun, 21 Jul 2024 08:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546B48F58;
	Sun, 21 Jul 2024 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrG/lRMa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC558F6A
	for <bpf@vger.kernel.org>; Sun, 21 Jul 2024 08:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721550931; cv=none; b=c4JgypqsjL5W7MVaCAZrkmCad7WCOy+ndMC7sRn1iiLiCtIGu4JZe2of5tNkP+NbNjqpdEAV6WnJ4GQAKBIjJOfh0K+doueMS59/qK98ALYAlxPaCMWNU3YtoWbfrTWUCWm9LNo4xGxJEdKyzq7TwwBugUojosHqUO4ek5j95pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721550931; c=relaxed/simple;
	bh=LyoRJPAnzGIR9ATvvfvFPpZLiTcZAEa0dRAQD3sNRh0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:Cc:Date; b=Tet1je65kagT5JoXbFZXEpluZt4vwlzw3XcvjlLugz4sDHnFU4ro3RMzw9Q3E7JDXpHsMuPW96FH8DmKXR5Hs4fkw4QerqzersSbkM1/hXY8bm+5yuSAIdqFx6ZEFKGhtyYjw0cF3Hv6BrsLElhmLTo4D2YC2qnBo8cYN4DhA4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrG/lRMa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84B5C116B1;
	Sun, 21 Jul 2024 08:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721550931;
	bh=LyoRJPAnzGIR9ATvvfvFPpZLiTcZAEa0dRAQD3sNRh0=;
	h=In-Reply-To:References:Subject:From:Cc:Date:From;
	b=mrG/lRMa/OtdsFhWagcd3Jf5vnrkluPxRc4BlghZghM+9MAR/uQpNhMN8tVxA83W2
	 K7uAxUPPfhtFe2wWbMbYEd9rQS/pVJDBi9xiUQ3DHGnFRjOVLmballLpAHnJrfuZJh
	 JZZT+02MVPqE0TnA1w3ycfKvmeiT0cwtrMmXixKyQbQYyzfLKhODOTodwmWdyHqX40
	 Z/420kd3s8J2gO3Ivd+rRIwdlLVtc7VHKgYGmlrUM9ZQ7EmH0KfZEdGax8sViGDUWx
	 DeAqKxSvnmslzx7OmNVoYnqhd0d/nsgeLtoea3etk2nlh3j/BDAE2wwx4liSWWAYZK
	 8ku8XZrYJA4UA==
Content-Type: multipart/mixed; boundary="===============4661431320391451162=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f76bf2da8c15b34924a3ab9d8ca3a5f694b5c19246153604c76cce75ec55f75e@mail.kernel.org>
In-Reply-To: <cover.1721541467.git.tony.ambardar@gmail.com>
References: <cover.1721541467.git.tony.ambardar@gmail.com>
Subject: Re: [PATCH bpf-next v1 0/2] selftests/bpf: Add support for MIPS systems
From: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Sun, 21 Jul 2024 08:35:30 +0000 (UTC)

--===============4661431320391451162==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     SUCCESS
Name:       [bpf-next,v1,0/2] selftests/bpf: Add support for MIPS systems
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=872744&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10026705403

No further action is necessary on your part.


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============4661431320391451162==--

