Return-Path: <bpf+bounces-38152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4664D960871
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 13:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02CC02844A9
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 11:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D2A19F482;
	Tue, 27 Aug 2024 11:21:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896B219E802
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 11:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724757673; cv=none; b=jN9JUQsgyluj2iRSNGRwrPSA4DT7hy4PksDzOJcxKRtO4pztYR1usP8L9n7UTSY9GvU85slazbTlRDkHcwCym7WzwraDgmyG+q3e5KwFy22zjW5DFiDT5zo2e+ZihXcvzJzr/PoaI8uEx8ZxF8/Cms2zH7WMywTIlvetE3E2/3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724757673; c=relaxed/simple;
	bh=22wKgKmBHV1HoKJxXrXjfVA9WVDo38H/NPKynsCLjb4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iGuH8ErcEIAQofZh7vQPTf+vMEgdDpbpFdInqVMu1AqDcnCC8hgAljsFledV8GGP0rgfb0i7AMYN4dwkt4sYyWfzlk5Fgi3BxeF8sBdTHGWMPTesc5tpShQV2RS5mNUkv6scYfwbKquLJjgv6K8c9akfbT3Hij2XxDTAD+CjAOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WtQ7l38NlzyQXr;
	Tue, 27 Aug 2024 19:20:19 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A93D1401F1;
	Tue, 27 Aug 2024 19:21:06 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 19:21:06 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <martin.lau@linux.dev>, <eddyz87@gmail.com>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
	<sdf@fomichev.me>, <haoluo@google.com>, <jolsa@kernel.org>
CC: <bpf@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH -next] bpf/btf: Use kvmemdup to simplify the code
Date: Tue, 27 Aug 2024 19:29:04 +0800
Message-ID: <20240827112904.4017810-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Use kvmemdup instead of kvmalloc() + memcpy() to simplify the
code.

No functional change intended.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 kernel/bpf/btf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9d6f9924eca7..cbbc1c2bc62e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6238,12 +6238,11 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
 	btf->kernel_btf = true;
 	snprintf(btf->name, sizeof(btf->name), "%s", module_name);
 
-	btf->data = kvmalloc(data_size, GFP_KERNEL | __GFP_NOWARN);
+	btf->data = kvmemdup(data, data_size, GFP_KERNEL | __GFP_NOWARN);
 	if (!btf->data) {
 		err = -ENOMEM;
 		goto errout;
 	}
-	memcpy(btf->data, data, data_size);
 	btf->data_size = data_size;
 
 	err = btf_parse_hdr(env);
-- 
2.34.1


