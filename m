Return-Path: <bpf+bounces-54785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 809DBA72B52
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 09:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31C661897DF0
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 08:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5750F204F94;
	Thu, 27 Mar 2025 08:22:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FB4204F75
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 08:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743063779; cv=none; b=BITdouR4ZQQ0JC2kLx5gcB7NkUs2BweiiS7t8UjfQksMHTSHOVeW+tNI0L1GOphchEUXO5ZWBQcBddDAcFLljH62Hulhjiv5KXlx4YqpyOjreW27wXOQyamcnCZxySzXqRwg5r+UPURfSQ3gUKZ/MVP7bCy4oCZt3Rbc1Ya28ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743063779; c=relaxed/simple;
	bh=ZgPbk1e+Tp2MrrcUgfu90AqAohp4UtLMSd85UTZOyJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fi1Fen21aVDhJHjXqGl9CEuOAvNa66/QqWm4+t1V4CwfBG+j59PUrC5tzM3XJ75GmfghAHJ35xQ53a6Q8iukiNZQMGEDPxv2cotgP1kFTSC5xriuj8EvJ65R48B0qRAejIDBVcm7ELz9JfjjoczVkFKyz/NuOguWv7NkUWg4vG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZNc8h31bmz4f3m76
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 16:22:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DD8AF1A0CD6
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 16:22:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAXe1_XCuVnluzSHg--.7420S7;
	Thu, 27 Mar 2025 16:22:52 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	houtao1@huawei.com
Subject: [PATCH bpf-next v3 03/16] bpf: Add helper bpf_map_has_dynptr_key()
Date: Thu, 27 Mar 2025 16:34:42 +0800
Message-Id: <20250327083455.848708-4-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250327083455.848708-1-houtao@huaweicloud.com>
References: <20250327083455.848708-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXe1_XCuVnluzSHg--.7420S7
X-Coremail-Antispam: 1UD129KBjvdXoW7XF1xJF1UAr4DGF18JFy3XFb_yoW3Xwc_Z3
	WxWF4xGws8uFnxX340ka1Iqry3G3WxJFn7XrZYvF13ZF1rZws8tw48Ar93Z34xWrs7GF47
	Gas5WrWxXr47WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbq8YFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r1rM2
	8IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
	4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	WUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFF4i
	UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Given that only bpf_dynptr is allowed in key_record, simply check
whether map->key_record is not NULL to detect if bpf_dynptr is enabled
in the map key.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e25ff78f1fabf..737890e5c58b4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -316,6 +316,11 @@ struct bpf_map {
 	s64 __percpu *elem_count;
 };
 
+static inline bool bpf_map_has_dynptr_key(const struct bpf_map *map)
+{
+	return !!map->key_record;
+}
+
 static inline const char *btf_field_type_name(enum btf_field_type type)
 {
 	switch (type) {
-- 
2.29.2


