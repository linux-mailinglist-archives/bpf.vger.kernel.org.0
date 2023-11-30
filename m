Return-Path: <bpf+bounces-16221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AD57FE7C6
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 04:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EE601C20CE0
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 03:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787A3134C6;
	Thu, 30 Nov 2023 03:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NocDVQWu"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF13C10C3;
	Wed, 29 Nov 2023 19:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701315890; x=1732851890;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/utSN1OR3/EBzwgfC3LaKdPzu0BgF9bHkLiCMUBUofc=;
  b=NocDVQWuviovUPFiaqbaSmdDz03DUse0299YjCPORM+abZQnvdK4mYhs
   K13hDzPEzgeyNhY3gZGHlp0jwA3vg/7PtE6QNXimvoU4jh867emnCW9vb
   LruoaHkol5Rp1agDl5QigLWKh+m6bPPG0R4UGQX8SswhQWXrRsS5NAtai
   rUCNbYLKLA4ASKgCTErKt0shZWtzclTpr3Io3hPOTtL0fbWh7kL0Wwun1
   kGzMCePfuMRkqhbP22z39ATc14HltCXQwFfXqkIB6vyqEfvI9XSyc+iwD
   pRNUb1mlhHrGG9falUUgphFa6Xv6Wf2zsf9CaOOIvWh3PQT0AcjjS9gVn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="393007738"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="393007738"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 19:44:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="762546446"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="762546446"
Received: from yujie-x299.sh.intel.com ([10.239.159.77])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 19:44:48 -0800
From: Yujie Liu <yujie.liu@intel.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Johan Almbladh <johan.almbladh@anyfinetworks.com>,
	bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] bpf/tests: Remove duplicate JSGT tests
Date: Thu, 30 Nov 2023 11:40:18 +0800
Message-Id: <20231130034018.2144963-1-yujie.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems unnecessary that JSGT is tested twice (one before JSGE and one
after JSGE) since others are tested only once. Remove the duplicate JSGT
tests.

Fixes: 0bbaa02b4816 ("bpf/tests: Add tests to check source register zero-extension")
Signed-off-by: Yujie Liu <yujie.liu@intel.com>
---
 lib/test_bpf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 7916503e6a6a..87a4ebcc65be 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -12215,7 +12215,6 @@ static struct bpf_test tests[] = {
 	BPF_JMP32_IMM_ZEXT(JLE),
 	BPF_JMP32_IMM_ZEXT(JSGT),
 	BPF_JMP32_IMM_ZEXT(JSGE),
-	BPF_JMP32_IMM_ZEXT(JSGT),
 	BPF_JMP32_IMM_ZEXT(JSLT),
 	BPF_JMP32_IMM_ZEXT(JSLE),
 #undef BPF_JMP2_IMM_ZEXT
@@ -12251,7 +12250,6 @@ static struct bpf_test tests[] = {
 	BPF_JMP32_REG_ZEXT(JLE),
 	BPF_JMP32_REG_ZEXT(JSGT),
 	BPF_JMP32_REG_ZEXT(JSGE),
-	BPF_JMP32_REG_ZEXT(JSGT),
 	BPF_JMP32_REG_ZEXT(JSLT),
 	BPF_JMP32_REG_ZEXT(JSLE),
 #undef BPF_JMP2_REG_ZEXT
-- 
2.34.1


