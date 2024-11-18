Return-Path: <bpf+bounces-45234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB03D9D3233
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 03:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742B81F23DCA
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 02:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892384595B;
	Wed, 20 Nov 2024 02:32:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55ACD3F9C5;
	Wed, 20 Nov 2024 02:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732069961; cv=none; b=jtfI+y9SbI7V6Kk3ZZhbscejuF6KPYigpNsEt6hckwR4dg9/PaVDRi8BVQfvEiT2gIXwoMa1qF6BdYGg5Cx9SqGlUQ8/HLJDiX8+YYJ/RaXdvbmBnosNQX2DNj56aWouQGq1WD0GfnamZdsIbOLTuPL+NFVAtH7yXXleESosu3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732069961; c=relaxed/simple;
	bh=M6eWbrJh9EXvL33sg7IgSaTZviGzfJgQ7VzmUtmc9Jw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fU7jDLMYYcd1URlQzuU8Ao42n8ZoQ/3yAcq4H5uYgt58DczriQob33GRJNMWZtQG5+bIorEmaFmAcSljONgAvmoO368WCjCo22NyA8t+4qMZVsuyNsJzOMD/ziyqD5bxtMh0DS0uArU0ixqJjarLOmf1GvQ0enWAam0dz0jWtlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee7673d4a4122a-50247;
	Wed, 20 Nov 2024 10:32:33 +0800 (CST)
X-RM-TRANSID:2ee7673d4a4122a-50247
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee3673d4a30dd0-5c7b3;
	Wed, 20 Nov 2024 10:32:33 +0800 (CST)
X-RM-TRANSID:2ee3673d4a30dd0-5c7b3
From: guanjing <guanjing@cmss.chinamobile.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	james.clark@linaro.org,
	yangjihong1@huawei.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	guanjing <guanjing@cmss.chinamobile.com>
Subject: [PATCH v2] perf kwork: Fix unnecessary conversion to bool in 'valid_kwork_class_type'
Date: Mon, 18 Nov 2024 12:39:39 +0800
Message-Id: <20241118043939.270819-1-guanjing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following coccicheck:

tools/perf/util/bpf_kwork.c:145:53-58: WARNING: conversion to bool not needed here

Fixes: daf07d220710 ("perf kwork: Implement BPF trace")
Signed-off-by: guanjing <guanjing@cmss.chinamobile.com>
---
 tools/perf/util/bpf_kwork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_kwork.c b/tools/perf/util/bpf_kwork.c
index 6c7126b7670d..c71461082683 100644
--- a/tools/perf/util/bpf_kwork.c
+++ b/tools/perf/util/bpf_kwork.c
@@ -142,7 +142,7 @@ kwork_class_bpf_supported_list[KWORK_CLASS_MAX] = {
 
 static bool valid_kwork_class_type(enum kwork_class_type type)
 {
-	return type >= 0 && type < KWORK_CLASS_MAX ? true : false;
+	return type >= 0 && type < KWORK_CLASS_MAX;
 }
 
 static int setup_filters(struct perf_kwork *kwork)
-- 
2.33.0




