Return-Path: <bpf+bounces-18604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C9D81C9CC
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 13:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBB1E1C220E7
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 12:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A991803E;
	Fri, 22 Dec 2023 12:21:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A5418631;
	Fri, 22 Dec 2023 12:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0Vz-mQOA_1703247709;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0Vz-mQOA_1703247709)
          by smtp.aliyun-inc.com;
          Fri, 22 Dec 2023 20:21:51 +0800
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
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	xuanzhuo@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	alibuda@linux.alibaba.com,
	guwen@linux.alibaba.com,
	hengqi@linux.alibaba.com,
	shung-hsi.yu@suse.com
Subject: [PATCH bpf-next 2/3] bpf: implement map_update_elem to init relay file
Date: Fri, 22 Dec 2023 20:21:45 +0800
Message-Id: <20231222122146.65519-3-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231222122146.65519-1-lulie@linux.alibaba.com>
References: <20231222122146.65519-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

map_update_elem is used to create relay files and bind them with the
relay channel, which is created with BPF_MAP_CREATE. This allows users
to set a custom directory name. It must be used with key=NULL and
flag=0.

Here is an example:
```
struct {
__uint(type, BPF_MAP_TYPE_RELAY);
__uint(max_entries, 4096);
} my_relay SEC(".maps");
...
char dir_name[] = "relay_test";
bpf_map_update_elem(map_fd, NULL, dir_name, 0);
```

Then, directory `/sys/kerenl/debug/relay_test` will be created, which
includes files of my_relay0...my_relay[#cpu]. Each represents a per-cpu
buffer with size 8 * 4096 B (there are 8 subbufs by default, each with
size 4096B).

Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 kernel/bpf/relaymap.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/relaymap.c b/kernel/bpf/relaymap.c
index d0adc7f67758..588c8de0a4bd 100644
--- a/kernel/bpf/relaymap.c
+++ b/kernel/bpf/relaymap.c
@@ -117,7 +117,37 @@ static void *relay_map_lookup_elem(struct bpf_map *map, void *key)
 static long relay_map_update_elem(struct bpf_map *map, void *key, void *value,
 				   u64 flags)
 {
-	return -EOPNOTSUPP;
+	struct bpf_relay_map *rmap;
+	struct dentry *parent;
+	int err;
+
+	if (unlikely(flags))
+		return -EINVAL;
+
+	if (unlikely(key))
+		return -EINVAL;
+
+	rmap = container_of(map, struct bpf_relay_map, map);
+
+	/* The directory already exists */
+	if (rmap->relay_chan->has_base_filename)
+		return -EEXIST;
+
+	/* Setup relay files. Note that the directory name passed as value should
+	 * not be longer than map->value_size, including the '\0' at the end.
+	 */
+	((char *)value)[map->value_size - 1] = '\0';
+	parent = debugfs_create_dir(value, NULL);
+	if (IS_ERR_OR_NULL(parent))
+		return PTR_ERR(parent);
+
+	err = relay_late_setup_files(rmap->relay_chan, map->name, parent);
+	if (err) {
+		debugfs_remove_recursive(parent);
+		return err;
+	}
+
+	return 0;
 }
 
 static long relay_map_delete_elem(struct bpf_map *map, void *key)
-- 
2.32.0.3.g01195cf9f


