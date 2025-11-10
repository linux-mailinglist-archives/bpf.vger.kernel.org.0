Return-Path: <bpf+bounces-74085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0982AC4786A
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 16:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE8B04F5C86
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 15:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8D5244694;
	Mon, 10 Nov 2025 15:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b="CT3zHVtJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [131.169.56.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ACD22D780
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 15:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787939; cv=none; b=s0+nlWlL7yllhLTocspkzP+wb/s2C5exxKFTqwJnsarc1WEP9d735CgCusRycvVG6tQiioEuBL/MHV1E0ArCjXzi7vsxnQD8dzqvskPRl4J527578bfiyjGJHnBiXBa1kiXS1fiIQnMR6eyu3zraqlgc7KhypPH6R/Ttvgy1Nz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787939; c=relaxed/simple;
	bh=OYjYwaWOLSYhRM9cdz8xoqLbAlkBT98LAVi9dHMQcMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+dnWosGHTTF0NTWJjznc2xdVNZFK8amE7BXBP8Zoz1w6cW3Px8KFvBdaVWOG7ICsqq7/nx8hi60ozOa/as/XsvAcVmyjkvmsiGOfrMk7BH3cYHQydwPzu8DUm7oZ+c6lHi5gFAk5Pk8BGutKylDqJLAtKfmXXJxowBwheha/Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu; spf=none smtp.mailfrom=mail.desy.de; dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b=CT3zHVtJ; arc=none smtp.client-ip=131.169.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mail.desy.de
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [IPv6:2001:638:700:1038::1:a4])
	by smtp-o-2.desy.de (Postfix) with ESMTP id 6D3D013F647
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 16:18:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 6D3D013F647
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xfel.eu; s=default;
	t=1762787929; bh=L2L//xmtfDh6NdvGWSd7E6w2KQU2qtOEoRTX/Mql3GU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CT3zHVtJ7CYSRcFnwJqCgwCRoKYC4+by0ODqmmA9mMTdtQwUpBWCJA85WdicI8Pgd
	 9POUp7hTt5FvkQ4rVLm0xox6iZzqotQH1al2QJT7m3lKOy0pcy2RXKphylT63/fGI4
	 yRnz7NXPoAWa5pMgSVhOnyBMVdeOrbrPDPeOYtbk=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [IPv6:2001:638:700:1038::1:82])
	by smtp-buf-1.desy.de (Postfix) with ESMTP id 626E420056;
	Mon, 10 Nov 2025 16:18:49 +0100 (CET)
Received: from c1722.mx.srv.dfn.de (c1722.mx.srv.dfn.de [IPv6:2001:638:d:c303:acdc:1979:2:e7])
	by smtp-m-2.desy.de (Postfix) with ESMTP id 553DA16003F;
	Mon, 10 Nov 2025 16:18:49 +0100 (CET)
Received: from smtp-intra-1.desy.de (smtp-intra-1.desy.de [131.169.56.82])
	by c1722.mx.srv.dfn.de (Postfix) with ESMTP id A86FB100033;
	Mon, 10 Nov 2025 16:18:48 +0100 (CET)
Received: from exflqr30474.desy.de (exflqr30474.desy.de [192.168.177.248])
	by smtp-intra-1.desy.de (Postfix) with ESMTP id 88C4380046;
	Mon, 10 Nov 2025 16:18:48 +0100 (CET)
Received: by exflqr30474.desy.de (Postfix, from userid 31112)
	id 82020201A6; Mon, 10 Nov 2025 16:18:48 +0100 (CET)
From: Martin Teichmann <martin.teichmann@xfel.eu>
To: bpf@vger.kernel.org
Cc: eddyz87@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	Martin Teichmann <martin.teichmann@xfel.eu>
Subject: [PATCH v4 bpf-next 0/2] bpf: properly verify tail call behavior
Date: Mon, 10 Nov 2025 16:18:42 +0100
Message-ID: <20251110151844.3630052-1-martin.teichmann@xfel.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <998304ddd050ef81ce6281ebb88130e836c07fc3.camel@gmail.com>
References: <998304ddd050ef81ce6281ebb88130e836c07fc3.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Eduard,

sorry, it took me a while to get my head around this, but now I found a nice
solution. The test you proposed is now correctly found to fail.

Martin Teichmann (2):
  bpf: properly verify tail call behavior
  bpf: test the proper verification of tail calls

 kernel/bpf/liveness.c                         |  4 ++
 kernel/bpf/verifier.c                         | 31 ++++++++++--
 .../selftests/bpf/progs/verifier_live_stack.c | 49 +++++++++++++++++++
 .../selftests/bpf/progs/verifier_sock.c       | 39 ++++++++++++++-
 .../bpf/progs/verifier_subprog_precision.c    | 47 ++++++++++++++++++
 5 files changed, 165 insertions(+), 5 deletions(-)

-- 
2.43.0


