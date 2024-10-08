Return-Path: <bpf+bounces-41204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B9599438D
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 11:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3C3283D2D
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 09:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9671517C9EA;
	Tue,  8 Oct 2024 09:02:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1326144D21
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 09:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378153; cv=none; b=A6Mo0pBoOkS0BqTIGdcR26GG8tGnk/awkx/SakYicpi9XpE/fGfNRN0RQuMiQJG74GL8i72PTWrRxTp7Hwqk1dFmWOG5HBUGTYhiLhSKNDhNCdxm1Nbc+m8OuOuG+3QXEskY8GpXDD2G7vGkZBNANdn7kNRDA/z9oS+ECjNFN3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378153; c=relaxed/simple;
	bh=8cUQ9+GaN+5wEUFTCpEst8SRcmkegpze/+Uuosquegc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gvOzRG9Q52vX/nB1D1aYTlE6m3UN4Esk1L8kky2z4Pk4a/d2PJ/QR3Bo/jn26e4URL8TE1IOxbwubJ4o1eK5hfmfxlaglmrWEj2okTp/FE37O7saWh2QiR9cBC7Xwdk0JWtG/cq0DfVJNTi1VrTgK2CX6Z7aoYsKo8ww/J0vwQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XN94y6nqsz4f3lfT
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:02:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7C41E1A058E
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:02:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.60])
	by APP4 (Coremail) with SMTP id gCh0CgDH+sYd9QRnbOEHDg--.25681S11;
	Tue, 08 Oct 2024 17:02:28 +0800 (CST)
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
Subject: [PATCH bpf-next 07/16] libbpf: Add helpers for bpf_dynptr_user
Date: Tue,  8 Oct 2024 17:14:52 +0800
Message-ID: <20241008091501.8302-8-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDH+sYd9QRnbOEHDg--.25681S11
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4fGw1ktw15Zr1xZw1rXrb_yoW8XF4fpa
	yrGry3Xr48JFW2kwsxJF4Iy3yruF48Xr1UGFWxt34rJr4UJr98ZFy0ywnxKrn8trZ5Wr47
	ZFZxKrW5Wr18Gr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUoo7KUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Add bpf_dynptr_user_init() to initialize a bpf_dynptr_user object,
bpf_dynptr_user_{data,size}() to get the address and length of the
dynptr object, and bpf_dynptr_user_set_size() to set the its size.

Instead of exporting these symbols, simply adding these helpers as
inline functions in bpf.h.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 tools/lib/bpf/bpf.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index a4a7b1ad1b63..92b4afac5f5f 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -700,6 +700,33 @@ struct bpf_token_create_opts {
 LIBBPF_API int bpf_token_create(int bpffs_fd,
 				struct bpf_token_create_opts *opts);
 
+/* sys_bpf() will check the validity of data and size */
+static inline void bpf_dynptr_user_init(void *data, __u32 size,
+					struct bpf_dynptr_user *dynptr)
+{
+	dynptr->data = (__u64)(unsigned long)data;
+	dynptr->size = size;
+	dynptr->rsvd = 0;
+}
+
+static inline void bpf_dynptr_user_set_size(struct bpf_dynptr_user *dynptr,
+					    __u32 new_size)
+{
+	dynptr->size = new_size;
+}
+
+static inline __u32
+bpf_dynptr_user_size(const struct bpf_dynptr_user *dynptr)
+{
+	return dynptr->size;
+}
+
+static inline void *
+bpf_dynptr_user_data(const struct bpf_dynptr_user *dynptr)
+{
+	return (void *)(unsigned long)dynptr->data;
+}
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
-- 
2.44.0


