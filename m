Return-Path: <bpf+bounces-35302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0297893977D
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 02:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3456F1C219BF
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 00:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECC55B1E8;
	Tue, 23 Jul 2024 00:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClLEPW6V"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3535FDA5
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 00:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721694873; cv=none; b=aTn6XZekrsA7oGFqAebBL0tnwnOfCBosYDaamAia6TH9ZOkc4EtfICHulEWsftfgQqAhB5dG/QaKGNpeH2BVOW8i+0T9ZAmJ88LF/FWm57/rfFExS9wtZjBxTIZbh/ArQKUUxaLMCAXw5hruL1Fw4v/QA870Zwi6yLrZoTDMtSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721694873; c=relaxed/simple;
	bh=HgeuH5tgPhAVB7K8zvuJbzrqyfzHhkvMQAxGkPiYk8M=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:Cc:Date; b=tSJhByB4lNGIUdwkpBkN5t8sWm8LRjQEZXXSC/h0fSd6FB8jsKojXwFEqUSdtoiQHECxyd/Qpgvgo3Tc6XZBx8RS8Qi1DS4DuwQjVnP1OO5Sy8/118KXdssWG8H3uMFMAV6eQCI6iNO4qwJBTyCGT99TYnzeMkHdfECuyLIKW6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClLEPW6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB29C116B1;
	Tue, 23 Jul 2024 00:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721694873;
	bh=HgeuH5tgPhAVB7K8zvuJbzrqyfzHhkvMQAxGkPiYk8M=;
	h=In-Reply-To:References:Subject:From:Cc:Date:From;
	b=ClLEPW6Veoxlu3i/WJaxKgFfO2bjZnv2zzb3EUR2ffGeH9iBiNiH3hesUzX7GEa0T
	 9hUty16iHnqJzayAMirf6dGrKGUwWszW/qD8bd5//d6VC9aGKSN0TwQSJH4Pa+rMx6
	 gd1SkKEv6E5vefbl8rSQ+hkerCWFrGbkV3emJo6IrGKWnK/NUbGGP2pdHwVXLhNKqf
	 oR1O2IU311nsDGQt4lOO/59Ls9zgHUVCceaxccj0RRGkfdcA93aWH4X5GgQj3riN3i
	 ArgnJ2YY7h+o6SifUwO3JceB+OHmaktHbJ7Vc9aRtahSBiLTy6/iPJc046MtLYEUpH
	 7Qb0rXSGmPfxw==
Content-Type: multipart/mixed; boundary="===============7071311076683860080=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c1cd21a5c18c042a13939e043145f1b04839460da75ce3e641106b281a5dc613@mail.kernel.org>
In-Reply-To: <20240723003045.2273499-1-tony.ambardar@gmail.com>
References: <20240723003045.2273499-1-tony.ambardar@gmail.com>
Subject: Re: [PATCH bpf-next v2] tools/runqslower: Fix LDFLAGS and add LDLIBS support
From: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Tue, 23 Jul 2024 00:34:33 +0000 (UTC)

--===============7071311076683860080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     SUCCESS
Name:       [bpf-next,v2] tools/runqslower: Fix LDFLAGS and add LDLIBS support
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=873093&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10047138493

No further action is necessary on your part.


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============7071311076683860080==--

