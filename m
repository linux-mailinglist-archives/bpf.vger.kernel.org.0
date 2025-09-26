Return-Path: <bpf+bounces-69826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD72CBA33FE
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 11:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22CBC624998
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 09:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A83429DB99;
	Fri, 26 Sep 2025 09:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AAlnd/zt"
X-Original-To: bpf@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9D529D282;
	Fri, 26 Sep 2025 09:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758880399; cv=none; b=h57waewFXLLoEEZxYlwhYIf0iBsbBrmKqytsppcmRheajl+oLviusPHnoZHVoPmbOXr96IecbO8P3RvPgd8o0a4L2LRSMxKTEf0zndJDH3ckBxVakmbtRphhR1GG/r7awQP/MbhTaDRMlTXJGUbUZ+l8SSLSENNFrfj+5oumOfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758880399; c=relaxed/simple;
	bh=YUKhSKV5krxK7aq0YL6uBUQZ9x8JAclefSml8Zbo5u8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4xDUGjQtdyYxDQ1OvnaInOmduZf+VIMUl4nKqzDBeiwUsec8AuNjCrppvRjM5CbULGX69woUPtGsQFCCpkD3f9Nlk4KzGwf/nKEfYIAA1fdRlAjltbpqfcXsEyjDJQhDDJL3urbtQBMhf05vl+cJimvAcD6nRl2ATpFsNU0RrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AAlnd/zt; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758880386; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=07lNl39kQLzLpg6IBgmzyG/mxPBQl/aph/gu4dnu+TY=;
	b=AAlnd/ztAKCMUrDpOjF4QDVrYvplq7O0MHWr2SehHrdpalkLXEVaz39hYy8iaFEl8RgIV9uap5oF5XdKe8vVGEkjtkjwstSmO7qO699HWJQhaZeYNNcp9qaoXKnd8cOFLcr2Zz4ZuTCrrtrhuAWtwDugZ8GvHBAc7R68mhMgYsg=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Wornc9V_1758880382 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 26 Sep 2025 17:53:05 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: qmo@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next v2 2/2] bpftool: Remove duplicate string.h header
Date: Fri, 26 Sep 2025 17:52:40 +0800
Message-ID: <20250926095240.3397539-2-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250926095240.3397539-1-jiapeng.chong@linux.alibaba.com>
References: <20250926095240.3397539-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

./tools/bpf/bpftool/sign.c: string.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=25502
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  -Modify in the 'close' section
https://bugzilla.openanolis.cn/show_bug.cgi?id=25499 for
https://bugzilla.openanolis.cn/show_bug.cgi?id=25502.

 tools/bpf/bpftool/sign.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/bpf/bpftool/sign.c b/tools/bpf/bpftool/sign.c
index b29d825bb1d4..b34f74d210e9 100644
--- a/tools/bpf/bpftool/sign.c
+++ b/tools/bpf/bpftool/sign.c
@@ -11,7 +11,6 @@
 #include <stdint.h>
 #include <stdbool.h>
 #include <string.h>
-#include <string.h>
 #include <getopt.h>
 #include <err.h>
 #include <openssl/opensslv.h>
-- 
2.43.5


