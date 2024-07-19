Return-Path: <bpf+bounces-35130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 736B0937E3C
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 01:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10ECE1F23E48
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 23:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F00149C4F;
	Fri, 19 Jul 2024 23:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHtzS8ls"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61481149C4C
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 23:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721433153; cv=none; b=BChExfgT4T1U33EhjbcQbWV391T5nkwX46b6XuwebpnlE4er5rQCSaVkcWJXVNZy7dW6Ci68d19MG1eCUQjHExkRci7IYB3ZCSPiEg82eVDL16hyKFRA950aJPsc16XSX5pNbfUpqXXOgf1KS1Uiln8nirIjJoMT2btZAWzMf+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721433153; c=relaxed/simple;
	bh=IXQEqQoNtPDWCmcFUT4SQbBBe8bmTPU5bwJEiCM/dRo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:Cc:Date; b=s8JstJbFXzSSDVbKyp90K2lxGWc9FYkHMSUhjEW9abfsj0fYA/m9q5QudOwfKL2qbkMMqf5gdTIdgmewyqPKCf57mtFTQrEmE6pEC3qVKe3tWMYu7cnEXCshz9XCOIE+enBR8PnMLldZ0+WfaaY7fmP9kAF07cCqg2B79L1xxGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHtzS8ls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7862C32782;
	Fri, 19 Jul 2024 23:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721433153;
	bh=IXQEqQoNtPDWCmcFUT4SQbBBe8bmTPU5bwJEiCM/dRo=;
	h=In-Reply-To:References:Subject:From:Cc:Date:From;
	b=HHtzS8lsjclyMR3ny9op61kZc+TY7tnWdNDrMCn/Qo+kQgWTR9vTR3fO3TnWWsDgp
	 S2tV9l3hMHqQzpBN7cbsHNRIgRxfb8wPnVFVjH2uEdoQwyROuHn6v+4AGb5cLJeWDz
	 +jnfiuCU3WKaLQks1nLmhDkcOLDZYlknievJuR8a6V9nmj7ZmgiDFlpzwLuy1dG0QT
	 WBFm81Q+WbsYhkKNcu3Cu+6N6LMYTMUrCKxoUWAwk8MboEOgpsJY7WPOYl5tXb0dHU
	 6sgSurIt3ifJ1Gx8yWwVZagATu/X6ix7tJW/NGGiLPlaAZ+WTqgS2BfbhwomMWLmI5
	 imKQBbougo6Ng==
Content-Type: multipart/mixed; boundary="===============5564946786811980416=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a8072ff355e9458762fa1dcd76d4b5814d1c026fd830f3cacae59b5273820613@mail.kernel.org>
In-Reply-To: <20240714123902.32305-1-hffilwlqm@gmail.com>
References: <20240714123902.32305-1-hffilwlqm@gmail.com>
Subject: Re: [PATCH v6 bpf-next 0/3] bpf: Fix tailcall hierarchy
From: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Fri, 19 Jul 2024 23:52:32 +0000 (UTC)

--===============5564946786811980416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     FAILURE
Name:       [v6,bpf-next,0/3] bpf: Fix tailcall hierarchy
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=871133&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10015594671

Failed jobs:
test_maps-s390x-gcc: https://github.com/kernel-patches/bpf/actions/runs/10015594671/job/27687419423


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============5564946786811980416==--

