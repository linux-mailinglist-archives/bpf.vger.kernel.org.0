Return-Path: <bpf+bounces-69668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D51B9E48C
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 11:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12BDD425345
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 09:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420D72EA177;
	Thu, 25 Sep 2025 09:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tKJrz/Xy"
X-Original-To: bpf@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0BE2E92DA;
	Thu, 25 Sep 2025 09:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792109; cv=none; b=tqiCJ06lPXaxjn5CRhwKSyplP1V3eUWwS529pQT3w9fpy9PfifN6j8U29sc7ex9ObXcR+DfoFs1Zh4ExKsciqQph7ihq4YWT2Td4A+HdeLDUznZgYWomaG1a3ehEUUF4RBKYEW2w29qABkbMrfQFSG0NToq2U8N5rECMosbvkeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792109; c=relaxed/simple;
	bh=0qQeB/6gn/T8/p9wiBHghRpgWgLXWO1FBCRV5CTOGKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NPQ7djbxCzeHEkDDXuo/1gNrX6SMH9dUQ8jjf2xOQUUJg5ya15oyrwBUGJ22sf/qQqM4IerGY5OKDfjT6YaPpFXoNnFKj1zDm20umD4BSBlFk+4sAwcEcx1PfDroLO2sotIfX85E1NW1YxXQmBxi37TXvpbtHNHic7NzSNlwbl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tKJrz/Xy; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758792103; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=0Q6buyohtLlYOn7TPpZmwiYOaXRdDuwMDlzi/LAu7BQ=;
	b=tKJrz/Xyn95OjhqwFv5wq9Tazwb3KE6k6NB2uAWOgjZfsLNl2ro7NpdC2RrZUACci068u1BMDOZy0FmM2E/nB32es/0rrvudQFp/K5Bs3MhaM6Y+Ln5Ks/cIWLU35T8FVtqGzX0B98XgMmCu8sEYv3G8IOiEmC71YF8BaF3+vno=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WonAJY5_1758792086 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Sep 2025 17:21:43 +0800
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
Subject: [PATCH -next] bpftool: Remove duplicate string.h header
Date: Thu, 25 Sep 2025 17:21:25 +0800
Message-ID: <20250925092125.2006892-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

./tools/bpf/bpftool/sign.c: string.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=25499
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
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


