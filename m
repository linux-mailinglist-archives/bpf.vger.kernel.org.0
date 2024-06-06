Return-Path: <bpf+bounces-31487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 263D28FE2D7
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 11:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B75301F25766
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 09:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D589178394;
	Thu,  6 Jun 2024 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azz02lmp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F6A153597;
	Thu,  6 Jun 2024 09:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666083; cv=none; b=se3NjrcTTkHPO3zwZL57bXJ+NwETGU72ARq8G0eTcx51R3AbmraVXbwhd8RSrjCuP7w4jGoLEdHw6IGc1LYB3MwR4UgNtbitxTvSpWzBe1XFGO9+s05/sPr/p598mz+8/TRRRLGA8vS/CKhzwCSqF3nldn7RRcwejQRWrdRt0l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666083; c=relaxed/simple;
	bh=3jtGlH/vJOZwEuic+3S8X/WuUsePedwqRR/gd3oODNk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fRXB7Iu/vJuETaxxr0oclCRbQ31XCvu29a/nz5Iq9PxoDm7poRod+PwgriwlA6xXimS9CSngPbvyhcxIQGXFaBB8zRr9dD5e/N5LOSHa45W4eX14OTP6iBGGxgfLz2uSGPWQPDO4MPWFCnCoSlHkvu5OHrPJbYqTFmk1fnPsh/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azz02lmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99EBFC4AF14;
	Thu,  6 Jun 2024 09:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717666082;
	bh=3jtGlH/vJOZwEuic+3S8X/WuUsePedwqRR/gd3oODNk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=azz02lmp9OlVeAZAkKgpiBj3SjjpIG6XeMv5MFmRwo5BZWSp8LjwrBEFm5pR2aPr8
	 rlq3VF+uUatjZT4RyiTgi7ntW/2f5MOWb+3BBEDzgobrH402umY9DpcnRVd9tLsJ6I
	 zPqIkfbWJ1ywI1kKLBwuzE9jSWEG0ljFpdrteIoLTT9w2YU7vmcq0/ZlaAketpJCHE
	 ncQ9RwqKDnEfPAeSXMqAvhKhGI+onx375MsdOrr+6Jh1qPaLuQI96HpjlUZKDfVXgk
	 KrgMRkhRpwRc4XVNAwhkMGYdPXZ811HYDUJ2yGB+Xi9xbNNnCEnSKOKp3kFromW0i3
	 zK/EBZ7lPTCzg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E589C27C52;
	Thu,  6 Jun 2024 09:28:02 +0000 (UTC)
From: Vincent Whitchurch via B4 Relay <devnull+vincent.whitchurch.datadoghq.com@kernel.org>
Subject: [PATCH bpf-next 0/5] sockmap: Fix reading with splice(2)
Date: Thu, 06 Jun 2024 11:27:51 +0200
Message-Id: <20240606-sockmap-splice-v1-0-4820a2ab14b5@datadoghq.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABeBYWYC/x3MSQqAMAxA0atI1gbqgAWvIi46RA1qLY2IIN7d4
 vIt/n9AKDEJ9MUDiS4WPkJGVRbgFhNmQvbZUKu6VZ3qUA637iaixI0doW90ZZzSXtsWchQTTXz
 /wwFsnDDQfcL4vh+tlFU+agAAAA==
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717666080; l=1284;
 i=vincent.whitchurch@datadoghq.com; s=20240606; h=from:subject:message-id;
 bh=3jtGlH/vJOZwEuic+3S8X/WuUsePedwqRR/gd3oODNk=;
 b=YP59EoxHRvNGfrOBcds1lxe8/uU8MyogOBvjqnjGQz816BDh0Vy5G2V0QVA9zfffi/YpdJhyC
 R5DQabnxMWcCCLaTQLT1yZgeQlD1tNOtd95jNCbWj+g0bl8ku+WDC80
X-Developer-Key: i=vincent.whitchurch@datadoghq.com; a=ed25519;
 pk=GwUiPK96WuxbUAD4UjapyK7TOt+aX0EqABOZ/BOj+/M=
X-Endpoint-Received: by B4 Relay for
 vincent.whitchurch@datadoghq.com/20240606 with auth_id=170
X-Original-From: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
Reply-To: vincent.whitchurch@datadoghq.com

I noticed that if the verdict callback returns SK_PASS, using splice(2)
to read from the socket doesn't work since it never sees the data queued
on to it.  As far as I can see, this is not a regression but just
something that has never worked.

This series attempts to fix it and add a test for it.

---
Vincent Whitchurch (5):
      net: Add splice_read to prot
      tcp_bpf: Fix reading with splice(2)
      selftests/bpf: sockmap: Exit with error on failure
      selftests/bpf: sockmap: Allow SK_PASS in verdict
      selftests/bpf: sockmap: Add basic splice(2) mode

 include/net/inet_common.h                  |  3 ++
 include/net/sock.h                         |  3 ++
 net/ipv4/af_inet.c                         | 18 ++++++-
 net/ipv4/tcp_bpf.c                         |  9 ++++
 net/ipv4/tcp_ipv4.c                        |  1 +
 net/ipv6/af_inet6.c                        |  2 +-
 net/ipv6/tcp_ipv6.c                        |  1 +
 tools/testing/selftests/bpf/test_sockmap.c | 78 +++++++++++++++++++++++++++++-
 8 files changed, 111 insertions(+), 4 deletions(-)
---
base-commit: 072088704433f75dacf9e33179dd7a81f0a238d4
change-id: 20240606-sockmap-splice-d371ac07d7b4

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@datadoghq.com>



