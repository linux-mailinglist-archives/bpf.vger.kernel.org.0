Return-Path: <bpf+bounces-39855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDD89788C3
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 21:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A65781C22EED
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 19:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D0D14F9D7;
	Fri, 13 Sep 2024 19:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="A28sg/gv"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA0313CAA5
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 19:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726255089; cv=none; b=WmNqkn+/X9Ap5UEN4FAYtxfj6c7BniRk/JoJKbl4aTnNov5Err6kDmYxFOq3mcF2hiSrGaeuc7WbMXMK+9P8iW1fpqaDr3UxcMw2M19O3BH8Oy2XVxIrfPMF57ewvQmk5vdYlgcii1FSjrKb0+/jisSn/cUeIlkseqP/hy0t1gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726255089; c=relaxed/simple;
	bh=jtHROiy8ztZAO6s3m9hHUwUDBEjxrCHdHNJWqzybUuM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J93l3oDlfX13bKA5A4rSSLRlAHfu+Yj50GCBo7/GmeqId+340eHL4Ti7uQc7HqIuZgbi1YWEbUWikDXeFmYNVEHKPF5qfrnGH/VmzCe9IjpB4uiy3gP+97/JEP/BloD0anByym+7fNTfBbAbZtHqK2bJK4kQUKYGb1js4OaY4GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=A28sg/gv; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=UQb/Mq4JBwlTVzgEJDhEBykB0OnacQBYbFi0HQkTpG4=; b=A28sg/gvmK+Eba2SG1f8DdO1Yn
	xz5nXufOD4wkHb7+ZOWmRlccPH6gGXzqeYlmv8VUxoqdEBd82+xbXNkPtAll/icQgbsdkY2+2inE3
	kdGeULOCfMO0imPBHVhAaiBDUPh4/edh6kEi3l9tmLwgtBE5ieDAlts2nz6gaNL3Pt3b/AbgMS8EH
	RGn+A0tvmGgXF2ZC5TAXOzZm5TYw4xZjgXL187A3bBWwbK7hUGi2O52B6Fy1pwYJwdrM60aoQ7RuF
	qF3rKPpMn+w1Uo9m5UD9Qz57M2TZZ9vtGnkiM8lewnObnuYIZZXx6MusXG88orxqOKAN0JHkVKRy8
	2SLYxdKg==;
Received: from 43.249.197.178.dynamic.cust.swisscom.net ([178.197.249.43] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1spBnr-000Ktb-T5; Fri, 13 Sep 2024 21:17:59 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: shung-hsi.yu@suse.com,
	andrii@kernel.org,
	ast@kernel.org,
	kongln9170@gmail.com,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v5 7/9] selftests/bpf: Rename ARG_PTR_TO_LONG test description
Date: Fri, 13 Sep 2024 21:17:52 +0200
Message-Id: <20240913191754.13290-7-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240913191754.13290-1-daniel@iogearbox.net>
References: <20240913191754.13290-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27397/Fri Sep 13 10:48:01 2024)

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


