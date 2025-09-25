Return-Path: <bpf+bounces-69669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 515A8B9E5D6
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 11:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A8221BC77B4
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 09:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C9F2EB5DA;
	Thu, 25 Sep 2025 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bRAjyEjR"
X-Original-To: bpf@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850142EAD15;
	Thu, 25 Sep 2025 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792495; cv=none; b=Letr3TZi+oN+7rrWlU4/2LBnGiYjov9hqQlZYXuYpHrYMiibwB92rsH2nndky74jlpCAMMFH3UW2CR4uFvaHU8jzt5fYyQ3NLgFZuXBwRhLbjH09aWR0LX9FosGAe7B0RIG+qtyAvO/WBbT3xKu4qM5T4bT4sbZze6zPqi/sodw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792495; c=relaxed/simple;
	bh=5j+ArQdmDDkUKP3J0QwiUJd9dv6Wa2bFTQL3uDHdU4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uoiveXFPXUgDQf+Cd4fp5NgNpXBL/sbvqRG+w9rahB4tjdLkDZGgIFIWJI6FXKGz07RKXDmwv/ZeTOxdFWaHEqxZUMmTtUSvK8C9FQMfCJ4crekVNmWFdh3HBn6OfbeIjqWoRwH8F2W+Lds8PpwCeOVLlcjm9YwhQszdEXXp5NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bRAjyEjR; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758792489; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=vaU4q1rjyZjglOB40P8eGw3/0j5KqnOwmaDvTyXzFCU=;
	b=bRAjyEjRRNmVMVzoZazwd5lCGtBawY67toNAoC1SbeUocaoRZKop3akpngDKqCrahZOIK6heLYN+nkR19LvhS4TfGvvyKh4zLjOxNV/NAYHdZ8V+OxAxQ9dfEdizqQ4AMCFE74jyZ26/6ogIg78twF0qwPX3JNti/ZpvzwVSS7s=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WonK-To_1758792481 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Sep 2025 17:28:09 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
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
Subject: [PATCH -next] bpf: Remove duplicate crypto/sha2.h header
Date: Thu, 25 Sep 2025 17:28:00 +0800
Message-ID: <20250925092800.2012758-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

./include/linux/bpf.h: crypto/sha2.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=25501
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 include/linux/bpf.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ba3a3be7eb2a..6d6460efcf11 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -32,7 +32,6 @@
 #include <linux/memcontrol.h>
 #include <linux/cfi.h>
 #include <asm/rqspinlock.h>
-#include <crypto/sha2.h>
 
 struct bpf_verifier_env;
 struct bpf_verifier_log;
-- 
2.43.5


