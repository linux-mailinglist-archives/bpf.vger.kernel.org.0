Return-Path: <bpf+bounces-18691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22A881EDF5
	for <lists+bpf@lfdr.de>; Wed, 27 Dec 2023 11:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67765282674
	for <lists+bpf@lfdr.de>; Wed, 27 Dec 2023 10:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E908A2C866;
	Wed, 27 Dec 2023 10:01:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6AB29411
	for <bpf@vger.kernel.org>; Wed, 27 Dec 2023 10:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0VzKnOgE_1703671293;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0VzKnOgE_1703671293)
          by smtp.aliyun-inc.com;
          Wed, 27 Dec 2023 18:01:34 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	joannelkoong@gmail.com,
	laoar.shao@gmail.com,
	kuifeng@meta.com,
	houtao@huaweicloud.com,
	shung-hsi.yu@suse.com,
	xuanzhuo@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	alibuda@linux.alibaba.com,
	guwen@linux.alibaba.com,
	hengqi@linux.alibaba.com
Subject: [PATCH bpf-next v1 2/3] bpf: add bpf_relay_output kfunc
Date: Wed, 27 Dec 2023 18:01:29 +0800
Message-Id: <20231227100130.84501-3-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231227100130.84501-1-lulie@linux.alibaba.com>
References: <20231227100130.84501-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A kfunc is needed to write into the relay channel, named
bpf_relay_output. The usage is same as bpf_ringbuf_output helper. It
only works after relay files are set, i.e., after calling
map_update_elem for the created relay map.

Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 kernel/bpf/helpers.c  |  3 +++
 kernel/bpf/relaymap.c | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index be72824f32b2..22480b69ff27 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2617,6 +2617,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
 BTF_ID_FLAGS(func, bpf_dynptr_size)
 BTF_ID_FLAGS(func, bpf_dynptr_clone)
+#ifdef CONFIG_RELAY
+BTF_ID_FLAGS(func, bpf_relay_output)
+#endif
 BTF_SET8_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/relaymap.c b/kernel/bpf/relaymap.c
index 02b33a8e6b6c..37280d60133c 100644
--- a/kernel/bpf/relaymap.c
+++ b/kernel/bpf/relaymap.c
@@ -6,6 +6,7 @@
 #include <linux/slab.h>
 #include <linux/bpf.h>
 #include <linux/err.h>
+#include <linux/btf.h>
 
 #define RELAY_CREATE_FLAG_MASK (BPF_F_OVERWRITE)
 
@@ -197,3 +198,24 @@ const struct bpf_map_ops relay_map_ops = {
 	.map_mem_usage = relay_map_mem_usage,
 	.map_btf_id = &relay_map_btf_ids[0],
 };
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc int bpf_relay_output(struct bpf_map *map,
+				   void *data, u64 data__sz, u32 flags)
+{
+	struct bpf_relay_map *rmap;
+
+	/* not support any flag now */
+	if (unlikely(!map || flags))
+		return -EINVAL;
+
+	rmap = container_of(map, struct bpf_relay_map, map);
+	if (!rmap->relay_chan->has_base_filename)
+		return -ENOENT;
+
+	relay_write(rmap->relay_chan, data, data__sz);
+	return 0;
+}
+
+__bpf_kfunc_end_defs();
-- 
2.32.0.3.g01195cf9f


