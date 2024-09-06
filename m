Return-Path: <bpf+bounces-39137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 291DB96F60C
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 15:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4DAA1F25664
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 13:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579601D0174;
	Fri,  6 Sep 2024 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Kl+MyOH8"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D97F1CF2BE
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725630983; cv=none; b=JJsqul++OD7lL35jAfn1R9kPyoOGmSAePRMpFzs5u8kBSRniYLtsyLKoj0+La85pdgItVKzw4hz1AGge66w7qXhOtPbjZlO4A6aBPK/Qxt1ABzMQXDlJdL323h9w3eT9tv4fKIl09SRk1Mnd2xQzVaewpN4efoBDwKqcIiZAr8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725630983; c=relaxed/simple;
	bh=jtHROiy8ztZAO6s3m9hHUwUDBEjxrCHdHNJWqzybUuM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aE2uzj0i5ly+Mz6YGBcKftJZX5QMdr10MtBDDQqY+hmC41vcdsxaez9lLdAxVwy6LRoHz8EQB/s5gT8wHYnrv5pjlOB38vOlzsYRhv83jAdgfHr+SnGLBq5ZioJkAO5h66Iqd4K24XgRpbBeuYI3TRc/ebIMIZnQ/CdduG6iC+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Kl+MyOH8; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=UQb/Mq4JBwlTVzgEJDhEBykB0OnacQBYbFi0HQkTpG4=; b=Kl+MyOH8QsrlwGRHd+iaPEH6b2
	00jxHWAkv61okSRY1/7U1HfgniDehlrJUIXvQFf4Pavrm716a0OXojtZ9bIk1EvjvAV6EkofdepEO
	kHr0AytJuJU3XFDIgCHqIbI6qhkwe6TvXInuOWMokwXY1TM0x1AWz19EETXsfPb+AZ6fupRRCSwKS
	aUgSo9Qgk6PaRvHVCYueCqAgDIjebn5/+5TXRSZzWvKFVL3AK+VvA6JONb7bXZtIWlW0FtR7rkaoY
	O0gQwKU/r2Jb5Z1+3+elgmfYjdc3zSnWo29y9X1ELXrJCNCLV+ruH+aDEyJk20G/gCZxNx0PjkgKO
	bfrn2vhQ==;
Received: from 15.248.197.178.dynamic.cust.swisscom.net ([178.197.248.15] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1smZRd-0001zf-Vu; Fri, 06 Sep 2024 15:56:13 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: shung-hsi.yu@suse.com,
	andrii@kernel.org,
	ast@kernel.org,
	kongln9170@gmail.com,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v4 7/8] selftests/bpf: Rename ARG_PTR_TO_LONG test description
Date: Fri,  6 Sep 2024 15:56:07 +0200
Message-Id: <20240906135608.26477-7-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240906135608.26477-1-daniel@iogearbox.net>
References: <20240906135608.26477-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27390/Fri Sep  6 10:38:06 2024)

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


