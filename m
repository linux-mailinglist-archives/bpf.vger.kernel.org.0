Return-Path: <bpf+bounces-38509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDF89654E9
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 03:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F30FEB2139B
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 01:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1BC55C29;
	Fri, 30 Aug 2024 01:58:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A905A2C18C;
	Fri, 30 Aug 2024 01:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983087; cv=none; b=Sj0kjKZe0Ulw9ZD0dX0St0zC0oLzKyJwcT0IUvMDlq+KHKCQWtmjVXPT5mLqrKbaWwRrPE4T2/KnzS80VLRkXCf12WiOB+dRq2s7KILel9ObwdnaI4XZWBMM4l3HVOmlrYkr5TumYA4Hc6ywCEhrD1wASQAXdgsJJ6nmpxjYRuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983087; c=relaxed/simple;
	bh=uKSvwoZXpADirUHvE6G1Q1pSCnJitgmjTM+tkmTDg04=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R9El9sHi4RIWL0GLTX2BV8g+w95gJ1a9MXi6Vkx2mGI73fEOCsZVQGU7YQjIra2nJM08VvKYEXEsKlJrYS2o0sNMCzACZ+Wl6R4xdzpIQH0z9OAQJ8nohZJ+EQH+pJkn3Py03k7xevGRtxpuKrfTiVpD02p0GFo3s5v49yO6A8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ww1Vy6MD0zyR8S;
	Fri, 30 Aug 2024 09:57:30 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 08F13140202;
	Fri, 30 Aug 2024 09:58:03 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Aug
 2024 09:58:02 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <eddyz87@gmail.com>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
	<sdf@fomichev.me>, <haoluo@google.com>, <jolsa@kernel.org>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH bpf-next RESEND] bpf: Use sockfd_put() helper
Date: Fri, 30 Aug 2024 10:06:07 +0800
Message-ID: <20240830020607.607516-1-ruanjinjie@huawei.com>
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
 kwepemh500013.china.huawei.com (7.202.181.146)

Replace fput() with sockfd_put() in bpf_fd_reuseport_array_update_elem().

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v1-> RESEND
- Use bpf-next instead of -next for commit title prefix.
---
 kernel/bpf/reuseport_array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/reuseport_array.c b/kernel/bpf/reuseport_array.c
index 4b4f9670f1a9..49b8e5a0c6b4 100644
--- a/kernel/bpf/reuseport_array.c
+++ b/kernel/bpf/reuseport_array.c
@@ -308,7 +308,7 @@ int bpf_fd_reuseport_array_update_elem(struct bpf_map *map, void *key,
 
 	spin_unlock_bh(&reuseport_lock);
 put_file:
-	fput(socket->file);
+	sockfd_put(socket);
 	return err;
 }
 
-- 
2.34.1


