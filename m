Return-Path: <bpf+bounces-39004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E48A96D7CA
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 14:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F7E1F2414E
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 12:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DC119AA53;
	Thu,  5 Sep 2024 12:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="A24zEzBu"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE39C194AF3
	for <bpf@vger.kernel.org>; Thu,  5 Sep 2024 12:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725537705; cv=none; b=rVBzK5xEINO/zphS/fiZQo3An8xOCuVbtqVIdmNUNnCS0xlo8JVDdeqJywgpvOklvZvnchjCa1ar/j6mIbHILECI2Jc4xC1E+PDH9R9sylto3Rlf2M7MIOh13eQWiXvaMdAR3vkuJ/46rB0fnBbp2CQtBxMXj7pow9JHxX5U7m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725537705; c=relaxed/simple;
	bh=C7x3Qhn8K0myir3LhvG6UkAeYGwz4eBOQ00P3679p/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tQvnS7RKS2V9gSihbqONZpubWA+N803NwyAbcnzWilqgtR5k67v8ZCqW9y+cwuaf/bK308F9gWys4jzs4Bfd4CS/2xCg1szi5YKO8I+uWkbskL2l70zlRcVZyY0ZS6lJdi/PW55WJPuwR2GixoPIg7E3Ry5ugpLR5daT0vMdvsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=A24zEzBu; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=4t2IOyFua47v4U1VF+xfta9q145bR/4r5FS//oQXIak=; b=A24zEzBu4F8yywKOcLRkIvNDY6
	/CvNqdBmRoDJlbNWuNr/sjG6UBklfFUjFcCXtRA2DD1tvuw1+jQ8tPmEs76IvGQns8rvrZIipMGKp
	p1sI80ojYdpTm1Hr98NoZRwpZ1AbEnFw79UAcf0NVW457jQ0N/movb1wCbH23zTTdXRtg0OHzQIpI
	DEkNqeXBv9Np3BRV68HMDWIdx5n1pCB4kToYSpwrjuT7HCtaNNBBhr2FtHnze8u9OR0hXMgmyPldI
	nj5SwH8Asef/7MXy+eURb+fXIR5NDig0X2/EY62tsnFCAK7PuM+V6wly3PZ/eoNHMGGri/ULqVbKQ
	vYgnDkUg==;
Received: from 23.248.197.178.dynamic.cust.swisscom.net ([178.197.248.23] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1smBB8-0001gj-Qm; Thu, 05 Sep 2024 14:01:34 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: shung-hsi.yu@suse.com,
	andrii@kernel.org,
	ast@kernel.org,
	kongln9170@gmail.com,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v2 4/6] selftests/bpf: Fix ARG_PTR_TO_LONG {half-,}uninitialized test
Date: Thu,  5 Sep 2024 14:01:26 +0200
Message-Id: <20240905120128.7322-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240905120128.7322-1-daniel@iogearbox.net>
References: <20240905120128.7322-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27389/Thu Sep  5 10:33:25 2024)

The assumption of 'in privileged mode reads from uninitialized stack locations
are permitted' is not quite correct since the verifier was probing for read
access rather than write access. Both tests need to be annotated as __success
for privileged and unprivileged.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/testing/selftests/bpf/progs/verifier_int_ptr.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_int_ptr.c b/tools/testing/selftests/bpf/progs/verifier_int_ptr.c
index 9fc3fae5cd83..87206803c025 100644
--- a/tools/testing/selftests/bpf/progs/verifier_int_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_int_ptr.c
@@ -8,7 +8,6 @@
 SEC("socket")
 __description("ARG_PTR_TO_LONG uninitialized")
 __success
-__failure_unpriv __msg_unpriv("invalid indirect read from stack R4 off -16+0 size 8")
 __naked void arg_ptr_to_long_uninitialized(void)
 {
 	asm volatile ("					\
@@ -36,9 +35,7 @@ __naked void arg_ptr_to_long_uninitialized(void)
 
 SEC("socket")
 __description("ARG_PTR_TO_LONG half-uninitialized")
-/* in privileged mode reads from uninitialized stack locations are permitted */
-__success __failure_unpriv
-__msg_unpriv("invalid indirect read from stack R4 off -16+4 size 8")
+__success
 __retval(0)
 __naked void ptr_to_long_half_uninitialized(void)
 {
-- 
2.43.0


