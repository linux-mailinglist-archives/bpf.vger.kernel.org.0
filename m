Return-Path: <bpf+bounces-54786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD73CA72B53
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 09:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA4B1189852B
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 08:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B027F2054E5;
	Thu, 27 Mar 2025 08:22:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD51204F74
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 08:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743063779; cv=none; b=VCLaRxLh7zQo3BWt/JkMUY9LUhJ6b35+iXnxWUfF9kHS/P/G1usLQckHAuIOsDMF0W6VBKbBNtotfjP0ANTYGuFcvNMTRdD1ICXfEFJYGBOEwkDJCn5GallXzyVxKf84mvth+QFypJlhuZZiiEsWebHUGCcBL3O8TO+1GDhlEmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743063779; c=relaxed/simple;
	bh=iYbYzWNYS1TOZdCURnLNvyC1k+2EpCeItDFCF5UiBOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FBSjDNLa2oLffeEN3zXyb4AYSEKZoX1lZgi6QEEY7R1CkCtT5j8nce0rQlvuOcqDr9qrwDLr2J9OWEF5ljxmArFe8eOYtm1vatsaLVKxONIc1cLjdm50l/ixTpwS8NmyF1HAyrHNVvQKJ/MXqCBVqahQmyEBmzUSNMl+UIRQM5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZNc8k0w7hz4f3lgS
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 16:22:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 952421A0CD6
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 16:22:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAXe1_XCuVnluzSHg--.7420S10;
	Thu, 27 Mar 2025 16:22:54 +0800 (CST)
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
Subject: [PATCH bpf-next v3 06/16] bpf: Reuse bpf_dynptr for userspace application use case
Date: Thu, 27 Mar 2025 16:34:45 +0800
Message-Id: <20250327083455.848708-7-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAXe1_XCuVnluzSHg--.7420S10
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4rKFW7ZrW7Jw4rGry5CFg_yoW8ury7pF
	s5CrWfC3y8XFW7Cr1Uua1Iyr1ruF4rur17G39rW34Y9FW2gas7ZwnrKF9FyFn5t3yjyr4x
	XryIgrW5W34rArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
	U1aLvJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

For bpf map with dynptr key support, the userspace application will use
bpf_dynptr to represent the variable-sized part in the map key and pass
it to bpf syscall. The bpf syscall will copy from bpf_dynptr to
construct a corresponding bpf_dynptr_kern object when the map key is an
input argument, and copy to bpf_dynptr from a bpf_dynptr_kern object
when the map key is an output argument.

Instead of adding a new uapi struct (e.g., bpf_dynptr_user) for
userspace application, reuse bpf_dynptr to unify the API for both bpf
program and userspace application. For the userspace application case,
the last 4-bytes of bpf_dynptr are not used, so make it a reserved
field.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/uapi/linux/bpf.h       | 11 ++++++++++-
 tools/include/uapi/linux/bpf.h | 11 ++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 28705ae677849..560289f0f560b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7370,7 +7370,16 @@ struct bpf_wq {
 } __attribute__((aligned(8)));
 
 struct bpf_dynptr {
-	__u64 __opaque[2];
+	union {
+		/* For bpf program */
+		__u64 __opaque[2];
+		/* For userspace application only */
+		struct {
+			__bpf_md_ptr(void *, data);
+			__u32 size;
+			__u32 reserved;
+		};
+	};
 } __attribute__((aligned(8)));
 
 struct bpf_list_head {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 28705ae677849..560289f0f560b 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7370,7 +7370,16 @@ struct bpf_wq {
 } __attribute__((aligned(8)));
 
 struct bpf_dynptr {
-	__u64 __opaque[2];
+	union {
+		/* For bpf program */
+		__u64 __opaque[2];
+		/* For userspace application only */
+		struct {
+			__bpf_md_ptr(void *, data);
+			__u32 size;
+			__u32 reserved;
+		};
+	};
 } __attribute__((aligned(8)));
 
 struct bpf_list_head {
-- 
2.29.2


