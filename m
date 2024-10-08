Return-Path: <bpf+bounces-41198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B199943D2
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 11:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B938B2503A
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 09:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415621779BD;
	Tue,  8 Oct 2024 09:02:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3DC7603F
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378150; cv=none; b=WREDWvdOLuGErpsGd7cIM/1iK55Jp2YZ987ERVLmWRfAAmZ8Egq8ciGs2TVVaY2AwpWmxq31cU+w4ooGfKOJBrp+yL8XxkaFXCKiNKymeieH4YheTDithhpuHcJmUo+EGos02tgiWAyjwy5TThcTRLnLrFalVEbIMaelBVmA9Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378150; c=relaxed/simple;
	bh=hMlQ465msOI+bKPFDzJcTc/5/xgEgFCXP/cnqYD8g2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YhdbYCViZcXJsRRYOtQpm8HyB5uOxr/RwC+7ObIwmUJYtsJiI7zCSHdNj+qv0441YnIU9l61vaw5dYIm3WjjT4BEmxrEi+3E8vCrqi/L8ebow6mf8tXCyE8yWtUW0El+tVmDFbUHGVgtB+Ky6FXojT1qSv5NK3ViJa4XV8Cpnjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XN94v3s5Kz4f3lfY
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:02:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 178651A018D
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:02:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.60])
	by APP4 (Coremail) with SMTP id gCh0CgDH+sYd9QRnbOEHDg--.25681S5;
	Tue, 08 Oct 2024 17:02:24 +0800 (CST)
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
Subject: [PATCH bpf-next 01/16] bpf: Introduce map flag BPF_F_DYNPTR_IN_KEY
Date: Tue,  8 Oct 2024 17:14:46 +0800
Message-ID: <20241008091501.8302-2-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDH+sYd9QRnbOEHDg--.25681S5
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4fWr1kKr4Utr17Ar4DCFg_yoW5Gr4xpF
	s5CrWxCr40qFW7CrWDGa18Zry5Zw43ur1ak3ya9ryrAF12vr9aqr18WF1YyF95tw4jyrWr
	Xr4UKrWrGa4xZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7S_M
	UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Introduce map flag BPF_F_DYNPTR_IN_KEY to support dynptr in map key. Add
the corresponding helper bpf_map_has_dynptr_key() to check whether or
not the dynptr-key is supported.

For map with dynptr key support, it needs to use map_extra to specify
the maximum length of these dynptrs. The implementation of the map will
check whether map_extra is smaller than the limitation imposed by memory
allocation during map creation. It may also use map_extra to optimizate
the memory allocation for dynptr.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf.h            | 5 +++++
 include/uapi/linux/bpf.h       | 3 +++
 kernel/bpf/syscall.c           | 1 +
 tools/include/uapi/linux/bpf.h | 3 +++
 4 files changed, 12 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 19d8ca8ac960..f61bf427e14e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -308,6 +308,11 @@ struct bpf_map {
 	s64 __percpu *elem_count;
 };
 
+static inline bool bpf_map_has_dynptr_key(const struct bpf_map *map)
+{
+	return map->map_flags & BPF_F_DYNPTR_IN_KEY;
+}
+
 static inline const char *btf_field_type_name(enum btf_field_type type)
 {
 	switch (type) {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c6cd7c7aeeee..07f7df308a01 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1409,6 +1409,9 @@ enum {
 
 /* Do not translate kernel bpf_arena pointers to user pointers */
 	BPF_F_NO_USER_CONV	= (1U << 18),
+
+/* Create a map with bpf_dynptr in key */
+	BPF_F_DYNPTR_IN_KEY     = (1U << 19),
 };
 
 /* Flags for BPF_PROG_QUERY. */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a8f1808a1ca5..bffd803c5977 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1232,6 +1232,7 @@ static int map_create(union bpf_attr *attr)
 
 	if (attr->map_type != BPF_MAP_TYPE_BLOOM_FILTER &&
 	    attr->map_type != BPF_MAP_TYPE_ARENA &&
+	    !(attr->map_flags & BPF_F_DYNPTR_IN_KEY) &&
 	    attr->map_extra != 0)
 		return -EINVAL;
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 1fb3cb2636e6..14f223282bfa 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1409,6 +1409,9 @@ enum {
 
 /* Do not translate kernel bpf_arena pointers to user pointers */
 	BPF_F_NO_USER_CONV	= (1U << 18),
+
+/* Create a map with bpf_dynptr in key */
+	BPF_F_DYNPTR_IN_KEY     = (1U << 19),
 };
 
 /* Flags for BPF_PROG_QUERY. */
-- 
2.44.0


