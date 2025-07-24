Return-Path: <bpf+bounces-64274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4F1B10DB2
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 16:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22D5218972F8
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 14:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04E72D29B7;
	Thu, 24 Jul 2025 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="rVK6m6am"
X-Original-To: bpf@vger.kernel.org
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CA0299A94;
	Thu, 24 Jul 2025 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367680; cv=none; b=nPp+R22x4O+jR8wBqwgXUbtZ2hrActLSO3GjEdj1j/mcA9XSRK1aQtHNy1nmmLj5hp19iORVqxS+iymdp+Nie5EWEYOSEgc/GUNM9ZW+vZHEKDx0K+KyLpDBC/LLI1MOQTthNEix8CVQdHdyoZ6WRM601aW6uU2gqqaW1i0MRKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367680; c=relaxed/simple;
	bh=UbD94arm8FPyd5udKXxyFoh4IJLtMxH9ZBjyzqIlNx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uU5ejFn+utyAXku1kp2og3VvlEMq19QMDtYzh2DWquC+xeBhNKYKgN1ORZIGnOb4Tn3lUebqvWsCjn3p7Us6tWsb9S5avmPiJrm1q7MNL8ZTaBj/qWIV2SagTo7OTfMUXHkBu1W/D81YXCYobvy6LOqfenrliEU0ixnVhNDN8D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=rVK6m6am; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1753367674;
	bh=UbD94arm8FPyd5udKXxyFoh4IJLtMxH9ZBjyzqIlNx4=;
	h=From:To:Subject:Date:Message-ID:From;
	b=rVK6m6amV+ndJlusROW2MCwFEF6tvvr0jaOARNdz/axW++QDM66jAddeMrNozQ7b5
	 LUuBWF0bPzPM2R++qb+iwYuSnsusK540g5SM6Ksl3k7rrAhIYisMugkvG97VuwT8Gm
	 LFE05miUCeO8Y987oiiB8aTMVHKBNx3CdhpFq53E=
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by lamorak.hansenpartnership.com (Postfix) with ESMTP id 696E91C0353;
	Thu, 24 Jul 2025 10:34:34 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 0/3] bpf: tidy up internals of bpf key handling
Date: Thu, 24 Jul 2025 10:34:25 -0400
Message-ID: <20250724143428.4416-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series reduces the size of the implementing code and
eliminates allocations on the bpf_key_lookup paths.  There is no
externally visible change to the BPF API.

Regards,

James

---

James Bottomley (3):
  bpf: make bpf_key an opaque type
  bpf: remove bpf_key reference
  bpf: eliminate the allocation of an intermediate struct bpf_key

 include/linux/bpf.h      |  5 +----
 kernel/trace/bpf_trace.c | 37 +++++++++----------------------------
 2 files changed, 10 insertions(+), 32 deletions(-)

-- 
2.43.0


