Return-Path: <bpf+bounces-35307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9508A939797
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 02:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 502BB281C59
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 00:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3F11311AC;
	Tue, 23 Jul 2024 00:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmTRnugq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA79EDDD9
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 00:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721695788; cv=none; b=kTpkDCOF1VWerFajD2La9zud/p4NcG0RqTUyiSKvozUy5Mpf5n+NICF/9OVTRPvgVPZtpnIz8hmIFshLxU2cpWrwQLLLOy6wMTboouh4vvzq8ZS9OoHJK7XzZfS0qa8W7K3sCFB6ud6ZVgfXfZc2mQzfWQSidaVtd/MN3jhiPdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721695788; c=relaxed/simple;
	bh=oZIl8+FFZur2qS+RgyFoIjHQZhVi5suxTHHC53dsi00=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kPM35Uvbn4uDfWDbyMCoXGWyU0Twmiyi/+u3pJ9QxcCqTqRDXrBuXzXhq5dpB5WqAi+VLNc8oNasuMG9UV0YJrkgePnH5KMJeEE9FX6iqZp7oAlb/e07nDYNWlnKVKPezol1q/BItHcD4neT0vQY+26VjcZcYpPHuJuHNnRF69g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmTRnugq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FDBC116B1;
	Tue, 23 Jul 2024 00:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721695788;
	bh=oZIl8+FFZur2qS+RgyFoIjHQZhVi5suxTHHC53dsi00=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=HmTRnugqx30io0phmxLJ/77N47fkvDqqJQoEaUYnE39SeSayjnPZAufmeXHNGKxEE
	 cPi/2adJtnun8IY84AfLQXbWjR2ULW1RBh0ihmMJzYWpwb4BzyUAUSmccsb0dRV04K
	 dlwn4raLlajQQVRp/5Dw2hPArPRyXy/mRk6KyxjenCt28d3qRJtn2+x5yOJ7Q2PjZA
	 kjLxe+hVp0X72V0c/h95pjXkk/6BsgDLHJHPXaovAsv/WCprcAo3d+H1tCDCFuh3DA
	 RH49SUmwcXVSy1GGSZaqfThknkOF9z2NZDyjRlLkXpL4Y6f/+mcogG6Q3eCD2fnMtH
	 WOb0kKvvrNomA==
Content-Type: multipart/mixed; boundary="===============8890545215810533222=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ec70e1e197a3788704d87f232fc8f358213db571b636d70846de903d59bc9e07@mail.kernel.org>
In-Reply-To: <20240718050228.3543663-1-yonghong.song@linux.dev>
References: <20240718050228.3543663-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add tests for ldsx of pkt data/data_end/data_meta accesses
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Tue, 23 Jul 2024 00:49:48 +0000 (UTC)

--===============8890545215810533222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     CONFLICT
Name:       [bpf-next,v2,2/2] selftests/bpf: Add tests for ldsx of pkt data/data_end/data_meta accesses
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=872131&state=*
PR:         https://github.com/kernel-patches/bpf/pull/7379

Please rebase your submission onto the most recent upstream change and resubmit
the patch to get it tested again.


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============8890545215810533222==--

