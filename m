Return-Path: <bpf+bounces-20097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCCB83951F
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 17:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FB22973E3
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 16:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF398823C1;
	Tue, 23 Jan 2024 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMLOuYLq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD297F7E3;
	Tue, 23 Jan 2024 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028059; cv=none; b=Uqb3XLWr1KXF2kUawVx5Y7XuBsfA02dCNtGIlYkZd1d3XTpHyesTupildWJJ8iDa9dbYOnb50cE3kg2XE39+i0opytFityKvQCbIWfntXuKRLQmBha0Xc7zvmlo07sI31dhuDDuNEEixfeSZIuSB8W2znbAOCYG/65efsHYCosI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028059; c=relaxed/simple;
	bh=488cibflGFigOOYtTvKeYwGvzyZCoAx+xMcXNO8a8g8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sXVcBKAq+PDrPFwyd9fjJeg3nuKMJJQ23Ka4lw4nUYp5YGi9F2jMDmEjiuBSsJvJEc9qpNsF3rwgkZBXX+37O1beBwtSYwxwYbtop2IL9+rUOroCF7HgW0wMeK+S+usoWJY+oP2JBwm7rMHd0fBSXIsXg68EPr4M0gTQyKh6x2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMLOuYLq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD86C433F1;
	Tue, 23 Jan 2024 16:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706028058;
	bh=488cibflGFigOOYtTvKeYwGvzyZCoAx+xMcXNO8a8g8=;
	h=From:Subject:Date:To:Cc:From;
	b=UMLOuYLqEKm3qz8Ftgr0SnlJ27+vPL8FQDIAGdoUwek3Qg4CpmiHXOtXudzqpGA3n
	 pglHIppROtY2NLSh1y7+GR/gTnYgOnKJ+/8xCwj+WP4NHTE8LwnIOZ2slg83hNqvAQ
	 xYF+Aeb+18L8fb0Qu6ZJLngALlExwZId/CyNFDIS/ELr153IUaaFDAHa7sR9LJfZCk
	 2bQJjBLioGIaBx1VAsOatIWTlAxcksBdzlOWgqUpzc46Lag5tc6kTBeLVnhWRUoejD
	 azVMYFXf+FJSsEuHI8mcWx5Gz0PzAHyZVry0Os2w7UftVOeBzFawy8zxHpg6aFKKsC
	 +1/QlI7oRKGgQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH 0/2] HID: bpf: couple of upstream fixes
Date: Tue, 23 Jan 2024 17:40:42 +0100
Message-Id: <20240123-b4-hid-bpf-fixes-v1-0-aa1fac734377@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAArsr2UC/x3LQQqAIBBA0avErBvQUaS6SrSoHHM2JQoRSHdPW
 j4+v0LhLFxg6ipkvqXIdTbovoM9rufBKL4ZSJFVmgxuFqN43FLAIA8XdI5GNQQmMhbaljL/oV3
 z8r4fKWwhuWIAAAA=
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Daniel Borkmann <daniel@iogearbox.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706028056; l=889;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=488cibflGFigOOYtTvKeYwGvzyZCoAx+xMcXNO8a8g8=;
 b=kRlE3NzuqFykYj5Oe0Nlt8Zyip+pPHfoIoEqdTFFlHmEmbPnUlA1aoFgb3MYteYdJFbXHIA4N
 iNW2TSjTEIeB1tq+Ikk30BvAZFCg//PSHVvs7XuNpDTNxQ23u6iRTdo
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Hi,

these are a couple of fixes for hid-bpf. The first one should
probably go in ASAP, after the reviews, and the second one is nice
to have and doesn't hurt much.

Thanks Dan for finding out the issue with bpf_prog_get()

Cheers,
Benjamin

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Benjamin Tissoires (2):
      HID: bpf: remove double fdget()
      HID: bpf: use __bpf_kfunc instead of noinline

 drivers/hid/bpf/hid_bpf_dispatch.c  | 88 +++++++++++++++++++++++++------------
 drivers/hid/bpf/hid_bpf_dispatch.h  |  4 +-
 drivers/hid/bpf/hid_bpf_jmp_table.c | 20 ++-------
 include/linux/hid_bpf.h             | 11 -----
 4 files changed, 66 insertions(+), 57 deletions(-)
---
base-commit: fef018d8199661962b5fc0f0d1501caa54b2b533
change-id: 20240123-b4-hid-bpf-fixes-662908fe2234

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


