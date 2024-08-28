Return-Path: <bpf+bounces-38246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6CC961F3F
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 08:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B77B31F2578E
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 06:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566781553AF;
	Wed, 28 Aug 2024 06:13:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B766715530C
	for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 06:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724825613; cv=none; b=fKIwf0byL2+z9nO5BkbNml9CvkZle0qrE8ivKXk2CD1K4rJbtDR5FMqRcK9muEQ+wLCqDd5XGfxeK3wM86UcYfbJpzF0CBo6+SWArLiMLNNpRcYtns7NBPGav78MuiOs/6OXNXfuL3D6cVXZ60e6emVS6XFcC2QRS3/rdLualjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724825613; c=relaxed/simple;
	bh=L0+jkmAdi5WIuzR++/F76uaTBo/Eqkfo/l9fJQk7qO0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cdY33mAbKOGsdy9RaYtb6dOXfBwc09IiIXe3n/IcybXNUJN6Ivkc6YnE9Foij40XObHFtFWlsiheU0PxswgiLOjZodgoaZaHIm1T7B+fuHuB2v23Ejl7pOp6hM6h/vWF5hCuNJRuSU1ibVh34ikF6hYRn+Lp3lbamLYro3pFF/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WtvGc51YmzyR3y;
	Wed, 28 Aug 2024 14:12:56 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id CF2BD180AE7;
	Wed, 28 Aug 2024 14:13:26 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 14:13:26 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <martin.lau@linux.dev>, <eddyz87@gmail.com>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
	<sdf@fomichev.me>, <haoluo@google.com>, <jolsa@kernel.org>
CC: <bpf@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH bpf-next v2] bpf/btf: Use kvmemdup to simplify the code
Date: Wed, 28 Aug 2024 14:21:28 +0800
Message-ID: <20240828062128.1223417-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Use kvmemdup instead of kvmalloc() + memcpy() to simplify the
code.

No functional change intended.

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
v2:
  - Change the subject-prefix and add acked-by.

v1: https://lore.kernel.org/bpf/20240827112904.4017810-1-lihongbo22@huawei.com/T/
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


