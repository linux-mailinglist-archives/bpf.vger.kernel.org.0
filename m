Return-Path: <bpf+bounces-38381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB71E963ED7
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 10:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0D31C2420C
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 08:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73DD18C03F;
	Thu, 29 Aug 2024 08:42:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F9818C036
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 08:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724920963; cv=none; b=duTPlF/ZyMMM8Fm5rhmrtLRFu3dmcqKs02f/4CHWTWGBniyuRIWkVegqmOPYIet8mcRZf3lZWw797TotAAVJgVxY0T3+4hlzyFTW7KnPVmJueRrAdva+JwJo58zjt+7muLFZ0Ep1uolnrwrWFjL/OvXcMNKTuHcke8CWrTi3f3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724920963; c=relaxed/simple;
	bh=ev15jcLmEDtnHnpeXFRKbWZ6cXlcqDtV/aT2V4R+1Tc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RDZHyYsnYR4tZX6ovnRGPfyTvgSlZz59uATcfnbTCM4ewFKnzPrnr1cg6kdyo1BRnT+h5UtXJ99BWUiNFhUlyGEuCf2bQeUXCviJPUDWQOIfcskzerX1opFdLp8yzvdEOBP5tom0EFY/VY2xO56m/Z5ZJ6TdYkLe+7IEBv0QKyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WvZXd4Tkfz2DbZ1;
	Thu, 29 Aug 2024 16:42:25 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 209CF1A0188;
	Thu, 29 Aug 2024 16:42:38 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 29 Aug
 2024 16:42:37 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <eddyz87@gmail.com>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
	<sdf@fomichev.me>, <haoluo@google.com>, <jolsa@kernel.org>,
	<bpf@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] bpf: Use sockfd_put() helper
Date: Thu, 29 Aug 2024 16:50:40 +0800
Message-ID: <20240829085040.156043-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Replace fput() with sockfd_put() in bpf_fd_reuseport_array_update_elem().

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
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


