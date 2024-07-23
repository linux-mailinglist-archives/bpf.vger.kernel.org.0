Return-Path: <bpf+bounces-35335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 951D0939858
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 04:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389581F22715
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 02:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DD413699A;
	Tue, 23 Jul 2024 02:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBKe9mmt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCAE3D6A
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 02:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721702250; cv=none; b=lGLUnO4sFL/HwjdzR48MZSwwdLkFJ//2eqXpNCSPtie/kojDI2GA3zZ+R5hDF1asXcxV5z941moCPZyPav3Yb4UDdxytjg/gN8wx9KKYPYnh9LeXub3eavUmfk0Ea58+eKThld2nB+gkQbaFePVuMGKje6pApw3Z1uuNQIpSKjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721702250; c=relaxed/simple;
	bh=SRcrPqT7xh8bs3FwtdPAPmvnh4PYc7abu3UF3IUiRzE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=rvztshWGlL6+h06lqw7lcDYfAX6a4tsL86hmv37Uch/zL8cp6Dy9RGSq8FMKmK7CS8yVuDTnfe50VaY57GpuJrRh3lVFSriKF+21k4FdZrpmfFu3Vfcxa6yhaVXPfgLUK2ebBd4NjN85VSZwjOS24rNzqjFCXKhXLPLRYSd4k4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBKe9mmt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF41C116B1;
	Tue, 23 Jul 2024 02:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721702249;
	bh=SRcrPqT7xh8bs3FwtdPAPmvnh4PYc7abu3UF3IUiRzE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=hBKe9mmtDuYPZtb2hv7q57vUvXQ7U/rFCNoiTN+qsV6V7lX7tnvkT+prEkkV83XOs
	 SgFSkOcV69a0hL7i5Gh+3HanlNxHElEnmJWdAykxz2Ci316l2rY/jfpcBQBlZmWizX
	 h8ogjqOhY7LDJ7jMIXFveQJSpWkpcCADhpdYi22wLWo4JiZx2gIgQ6wy1FH4Qim1aF
	 1NPPY1GT1LtSctwYtEIsGKjrTELBVIqUee6g9kCys5KmKRn60medTkqH2bsvkPbT90
	 Mbfaf99o6RKulfi3S5lsEnroENdpt1b+lzx0qboXycTeHXcWNDWLNfdjdVia2PgNAJ
	 bbhLElWRDaYdw==
Content-Type: multipart/mixed; boundary="===============4477046908109995185=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0843367b7c1509b8b9729f0d5d4d3f957bcbec6fc4996f9a76412a75cf3c515a@mail.kernel.org>
In-Reply-To: <20240722202758.3889061-1-jolsa@kernel.org>
References: <20240722202758.3889061-1-jolsa@kernel.org>
Subject: Re: [PATCHv3 bpf-next 0/2] selftests/bpf: Add more uprobe multi tests
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Tue, 23 Jul 2024 02:37:29 +0000 (UTC)

--===============4477046908109995185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     SUCCESS
Name:       [PATCHv3,bpf-next,0/2] selftests/bpf: Add more uprobe multi tests
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=873053&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10051533401

No further action is necessary on your part.


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============4477046908109995185==--

