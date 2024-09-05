Return-Path: <bpf+bounces-39023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFCC96DAC0
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 15:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2D4282B47
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 13:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9BB19DFB9;
	Thu,  5 Sep 2024 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="hjApLPp6"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6579D19D880
	for <bpf@vger.kernel.org>; Thu,  5 Sep 2024 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544105; cv=none; b=jnyJt5nYkYO7cqpQ2m24Y0lX1tmPzLEZ/Un63qFaEITOqI9bdOLxgYnwmcFcrlbKoWMiKyU8EbwSVbWnI2Yy/RHwoiuTMpSEFMpUEuH3mLiR3ONjWt4MzKiE/lVK0w1MCV4k2FO6GHG0WE/1yeRMXb+RRwOp04lhCYifJgXECrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544105; c=relaxed/simple;
	bh=jtHROiy8ztZAO6s3m9hHUwUDBEjxrCHdHNJWqzybUuM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P8Ne+2gwQm7x0gqO2YlxRHK2qi630YH1XXzdQwx8NYI12bUd9rCPM+O5Kn31qzbOG50d/i5i9+OtVqNdGac2UfCZx18rD7njAciGXu3FiJD/aFXZoRaRuppnE1S/mvKnpscb4PtUrljaddw/dGBOmhsdAHpAoEHafQjMlvCrPHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=hjApLPp6; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=UQb/Mq4JBwlTVzgEJDhEBykB0OnacQBYbFi0HQkTpG4=; b=hjApLPp6UM0inlwy6H9VQquNTe
	lDslJTmtFy04vYoQEMz+u5QRoyhJ4yKIORVSPTKojlZLMpPcZPa9gUwsZmbmEfCZM+hXL9XgKry6a
	M71pIHcNcfpwxilNUQBuCQsLeD1qCXbuGTZJBg1jhMJRylc9rVZ1T7QF1rAYAYX+G+5aiPn/8NS2L
	TnDe3AOJtxXB48eiuLlYn69sB7RRcR5fCNC+72b0Rv3Y4vXNXPfmFADuAttDBs3Ik/5wog+htTy83
	wvjTRZZvXe+NLaMR9Y5hJ7jab0oGUG2TC0tit+OduOBYMHTDORkS6cdEEB/9Gp7njbjV91x+2Rsrc
	nEhi6Ckg==;
Received: from 23.248.197.178.dynamic.cust.swisscom.net ([178.197.248.23] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1smCqT-000FEa-19; Thu, 05 Sep 2024 15:48:20 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: shung-hsi.yu@suse.com,
	andrii@kernel.org,
	ast@kernel.org,
	kongln9170@gmail.com,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v3 5/6] selftests/bpf: Rename ARG_PTR_TO_LONG test description
Date: Thu,  5 Sep 2024 15:48:12 +0200
Message-Id: <20240905134813.874-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240905134813.874-1-daniel@iogearbox.net>
References: <20240905134813.874-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27389/Thu Sep  5 10:33:25 2024)

Given we got rid of ARG_PTR_TO_LONG, change the test case description to
avoid potential confusion:

  # ./vmtest.sh -- ./test_progs -t verifier_int_ptr
  [...]
  ./test_progs -t verifier_int_ptr
  [    1.610563] bpf_testmod: loading out-of-tree module taints kernel.
  [    1.611049] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
  #489/1   verifier_int_ptr/arg pointer to long uninitialized:OK
  #489/2   verifier_int_ptr/arg pointer to long half-uninitialized:OK
  #489/3   verifier_int_ptr/arg pointer to long misaligned:OK
  #489/4   verifier_int_ptr/arg pointer to long size < sizeof(long):OK
  #489/5   verifier_int_ptr/arg pointer to long initialized:OK
  #489     verifier_int_ptr:OK
  Summary: 1/5 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 v1 -> v2:
 - new patch

 tools/testing/selftests/bpf/progs/verifier_int_ptr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_int_ptr.c b/tools/testing/selftests/bpf/progs/verifier_int_ptr.c
index 87206803c025..5f2efb895edb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_int_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_int_ptr.c
@@ -6,7 +6,7 @@
 #include "bpf_misc.h"
 
 SEC("socket")
-__description("ARG_PTR_TO_LONG uninitialized")
+__description("arg pointer to long uninitialized")
 __success
 __naked void arg_ptr_to_long_uninitialized(void)
 {
@@ -34,7 +34,7 @@ __naked void arg_ptr_to_long_uninitialized(void)
 }
 
 SEC("socket")
-__description("ARG_PTR_TO_LONG half-uninitialized")
+__description("arg pointer to long half-uninitialized")
 __success
 __retval(0)
 __naked void ptr_to_long_half_uninitialized(void)
@@ -64,7 +64,7 @@ __naked void ptr_to_long_half_uninitialized(void)
 }
 
 SEC("cgroup/sysctl")
-__description("ARG_PTR_TO_LONG misaligned")
+__description("arg pointer to long misaligned")
 __failure __msg("misaligned stack access off 0+-20+0 size 8")
 __naked void arg_ptr_to_long_misaligned(void)
 {
@@ -95,7 +95,7 @@ __naked void arg_ptr_to_long_misaligned(void)
 }
 
 SEC("cgroup/sysctl")
-__description("ARG_PTR_TO_LONG size < sizeof(long)")
+__description("arg pointer to long size < sizeof(long)")
 __failure __msg("invalid indirect access to stack R4 off=-4 size=8")
 __naked void to_long_size_sizeof_long(void)
 {
@@ -124,7 +124,7 @@ __naked void to_long_size_sizeof_long(void)
 }
 
 SEC("cgroup/sysctl")
-__description("ARG_PTR_TO_LONG initialized")
+__description("arg pointer to long initialized")
 __success
 __naked void arg_ptr_to_long_initialized(void)
 {
-- 
2.43.0


