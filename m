Return-Path: <bpf+bounces-64732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87569B1657E
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 19:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E956D1AA453C
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 17:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB69E24B26;
	Wed, 30 Jul 2025 17:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="PA8dEPdm"
X-Original-To: bpf@vger.kernel.org
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3014B173;
	Wed, 30 Jul 2025 17:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896475; cv=none; b=KIoAHRmcFlfxJKW9CYk5Y5k8/JmCd4pdPTjw9zr1wEszyNPXqTzHJ0bp/ZfmY4MocoptcPRHW7QlspRof8IqA8JtjnbehRitZMKJWYg9s/qud0yI/bIZo2/eGUWoJ9jHpd2T673jrXYOjX4myUu5SKfEPOAKLR6VodamJNH/WBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896475; c=relaxed/simple;
	bh=qTGOnG+4FbEQWLabid6wEdaHLc0aXLp7YO0vAo8EkOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cjOQwANns+rDPs5NmwK6sDbFYpIXkUQ7rVmiyqJ6O6ltq99cuKfqm9MMBhonExCs84op1DOluAl61xoJEn+IAAVy/PnfjGbBJSvYppRMnpsbsE30FmublyZ15XzuHI7kpNlqXcRjOYaK30wH0u3x+BikH6vMAtr8o3iGsTstN1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=PA8dEPdm; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1753896471;
	bh=qTGOnG+4FbEQWLabid6wEdaHLc0aXLp7YO0vAo8EkOc=;
	h=From:To:Subject:Date:Message-ID:From;
	b=PA8dEPdmkxMNPrIYpl18aYJzPDaOg4w6nGj1nX1qZ8r6aYhTHrvBG6fJoq+LQni96
	 /SFsk3eRA44vT+v5NvtrMNe2sWFo8z+jiatJfaENEfkrpCyWMCCGunbQsB8yCnxywT
	 N4xMol5ETEINWlvHtwg7pC0B8IZQgdqQWx8YX0vY=
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by lamorak.hansenpartnership.com (Postfix) with ESMTP id F0FD61C0248;
	Wed, 30 Jul 2025 13:27:50 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 0/3] bpf: tidy up internals of bpf key handling
Date: Wed, 30 Jul 2025 13:27:42 -0400
Message-ID: <20250730172745.8480-1-James.Bottomley@HansenPartnership.com>
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

v2 fixes the test failures by keeping an empty bpf_key structure and
differentiating between failure and builtin key returns.

Regards,

James

James Bottomley (3):
  bpf: make bpf_key an opaque type
  bpf: remove bpf_key reference
  bpf: eliminate the allocation of an intermediate struct bpf_key

 include/linux/bpf.h      |  5 +----
 kernel/trace/bpf_trace.c | 47 ++++++++++++++++------------------------
 2 files changed, 20 insertions(+), 32 deletions(-)

-- 
2.43.0


