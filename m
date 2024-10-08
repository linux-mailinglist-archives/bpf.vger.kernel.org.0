Return-Path: <bpf+bounces-41203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5465199438C
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 11:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8658B1C24C00
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 09:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4E717BB03;
	Tue,  8 Oct 2024 09:02:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36427176FCE
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378153; cv=none; b=oUH/eOe6x8kbo1NRyny9qIqrvUt8VUQdj2Z/dw+ac4PtDvo5TD/DYLTzq5U+UyunOyCcaG9J+1P7+RL3n4b0o/yueBHUzWyr9x90ReZtg8YouwgawkL6A4S0sq0i/KOUOTOv544GbAqZ3GGA6IwM0WuAco/w/r93KrAcH017oXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378153; c=relaxed/simple;
	bh=AG9QykCHtjlQad1wQaHyYZ98sUxDRwlfk0McW+uJnKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c16Csl6uR8GQgX9uHfdeIG+vcc5IkD61eE+i+rOZSvolmNHS+0AcovmFX5cCxGwniRemLmTCi0ASQtrnKXvK+Oyj7yeVqWtwxcPSqZEu8/cF5XfY0ryMeA2C22yHTUVBlcrATxMiuoLO97/FtezefMr3OeQ5iLmlTTx2SLpFVxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XN9541R6jz4f3jqx
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:02:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E4F341A147B
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:02:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.60])
	by APP4 (Coremail) with SMTP id gCh0CgDH+sYd9QRnbOEHDg--.25681S10;
	Tue, 08 Oct 2024 17:02:27 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
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
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next 06/16] bpf: Introduce bpf_dynptr_user
Date: Tue,  8 Oct 2024 17:14:51 +0800
Message-ID: <20241008091501.8302-7-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241008091501.8302-1-houtao@huaweicloud.com>
References: <20241008091501.8302-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDH+sYd9QRnbOEHDg--.25681S10
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4xGF1rJF17tFWfXFyDAwb_yoW8AryxpF
	95GrW3u3y8XFW7AryDJa1Ivr4ruFWrur17K3y2934jkFWDXas7Zw4xKas0kFZ8t3y5CrW7
	JryxKrWrWryrXr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUoo7KUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

For bpf map with dynptr key support, the userspace application will use
bpf_dynptr_user to represent the bpf_dynptr in the map key and pass it
to bpf syscall. The bpf syscall will copy from bpf_dynptr_user to
construct a corresponding bpf_dynptr_kern object when the map key is an
input argument, and copy to bpf_dynptr_user from a bpf_dynptr_kern
object when the map key is an output argument.

For now the size of bpf_dynptr_user must be the same as bpf_dynptr, but
the last u32 field is not used, so make it a reserved field.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/uapi/linux/bpf.h       | 6 ++++++
 tools/include/uapi/linux/bpf.h | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 07f7df308a01..72fe6a96b54c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7329,6 +7329,12 @@ struct bpf_dynptr {
 	__u64 __opaque[2];
 } __attribute__((aligned(8)));
 
+struct bpf_dynptr_user {
+	__u64 data;
+	__u32 size;
+	__u32 rsvd;
+} __attribute__((aligned(8)));
+
 struct bpf_list_head {
 	__u64 __opaque[2];
 } __attribute__((aligned(8)));
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 14f223282bfa..f12ce268e6be 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7328,6 +7328,12 @@ struct bpf_dynptr {
 	__u64 __opaque[2];
 } __attribute__((aligned(8)));
 
+struct bpf_dynptr_user {
+	__u64 data;
+	__u32 size;
+	__u32 rsvd;
+} __attribute__((aligned(8)));
+
 struct bpf_list_head {
 	__u64 __opaque[2];
 } __attribute__((aligned(8)));
-- 
2.44.0


