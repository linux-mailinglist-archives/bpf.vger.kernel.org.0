Return-Path: <bpf+bounces-35200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38018938608
	for <lists+bpf@lfdr.de>; Sun, 21 Jul 2024 21:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2E4E1F21166
	for <lists+bpf@lfdr.de>; Sun, 21 Jul 2024 19:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7C216A95E;
	Sun, 21 Jul 2024 19:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBvatfAE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042CB166313
	for <bpf@vger.kernel.org>; Sun, 21 Jul 2024 19:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721591723; cv=none; b=UTq17W+wpJ51grCJRIpyI13gPw38Fu3byPaGOuczXFD7plm0KDx1KrBA/Cn9lh4doWLpyTdQkEM9wJVPv7HqbDxzqO5QwkyUFGlLI69rPOSaJXagBucC3kHOju/0FSZ3nAaZGV4FQQQjdTBfsfe1gn4rGSWC0Ovc3P4yW6/VmfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721591723; c=relaxed/simple;
	bh=gWNeaCoCOyzX2qNjvNQEx6/u/dLQZHzcCiFELM+lR+U=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=f6+2/d0ZcM0E9YvaRdzfKknube4R44lTXQ9e6rk1gthptSqN+rF2Lp/82YO2LsgxHQT5DrCnMd43AbKfbZaxSfoOWN4BDLXQBk/O3QhnMepfmmF4xMdwoyVG9yB5pH3WSFOrQ2Mg7bjEzSYcGut5WUri8/zAR1M81nmMCXbAwac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBvatfAE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807BAC116B1;
	Sun, 21 Jul 2024 19:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721591722;
	bh=gWNeaCoCOyzX2qNjvNQEx6/u/dLQZHzcCiFELM+lR+U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=VBvatfAE+mO1qZ6Vx4EblkEd357GTPgcxOR/nZtjzG7kL+yLXGmH/czlLmNa6ucLV
	 q2jjVLJ2eoKbNjen/BMA1PgZjqSggnwGia2V9943TQSkvqFuPUF4VFoWa+ItXnUxWs
	 iR/ERPzoWvgvSXC4SnlASD8jDh2cfWOi3giy0oTXbMePknCvqg4z+4fp6tJu7PBTUz
	 4BukoV9jyuTVTRf632K3pynGBk8t6gq+E1LvG7C7wCse475/aGY8OOj54wK2JgdZqL
	 n13LIpy+WDWGgQHyDubuuKbAHH12XOWZF31jO9NEl/dka5NtpPlvM3XPmUx9FoM0us
	 JY2ZSZhkP5NKg==
Content-Type: multipart/mixed; boundary="===============4450476808312427623=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <44b65553820aeb8d5a829b663422ad2e312065d0bde51cd0aa9e250e1fec3f09@mail.kernel.org>
In-Reply-To: <20240721-convert_test_xdp_veth-v4-0-23bdba21b2f9@bootlin.com>
References: <20240721-convert_test_xdp_veth-v4-0-23bdba21b2f9@bootlin.com>
Subject: Re: [PATCH v4 0/2] selftests/bpf: convert test_xdp_veth to test_progs framework
From: bot+bpf-ci@kernel.org
To: alexis.lothore@bootlin.com
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Sun, 21 Jul 2024 19:55:22 +0000 (UTC)

--===============4450476808312427623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     SUCCESS
Name:       [v4,0/2] selftests/bpf: convert test_xdp_veth to test_progs framework
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=872778&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10030891716

No further action is necessary on your part.


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============4450476808312427623==--

