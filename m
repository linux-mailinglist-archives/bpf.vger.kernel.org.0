Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB92D432C3E
	for <lists+bpf@lfdr.de>; Tue, 19 Oct 2021 05:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbhJSD0e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Oct 2021 23:26:34 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:29907 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhJSD0e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Oct 2021 23:26:34 -0400
Received: from dggeme764-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HYJrh3X66zbnGN;
        Tue, 19 Oct 2021 11:19:48 +0800 (CST)
Received: from huawei.com (10.67.174.119) by dggeme764-chm.china.huawei.com
 (10.3.19.110) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Tue, 19
 Oct 2021 11:24:20 +0800
From:   Xu Kuohai <xukuohai@huawei.com>
To:     <bpf@vger.kernel.org>
CC:     Brian Vazquez <brianvv@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Xu Kuohai <xukuohai@huawei.com>
Subject: [PATCH bpf] bpf: Fix error usage of map_fd and fdget() in generic_map_update_batch()
Date:   Tue, 19 Oct 2021 03:29:34 +0000
Message-ID: <20211019032934.1210517-1-xukuohai@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.119]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme764-chm.china.huawei.com (10.3.19.110)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

1. The ufd in generic_map_update_batch() should be read from batch.map_fd;
2. A call to fdget() should be followed by a symmetric call to fdput().

Fixes: aa2e93b8e58e ("bpf: Add generic support for update and delete batch ops")
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 kernel/bpf/syscall.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4e50c0bfdb7d..9dab49d3f394 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1337,12 +1337,11 @@ int generic_map_update_batch(struct bpf_map *map,
 	void __user *values = u64_to_user_ptr(attr->batch.values);
 	void __user *keys = u64_to_user_ptr(attr->batch.keys);
 	u32 value_size, cp, max_count;
-	int ufd = attr->map_fd;
+	int ufd = attr->batch.map_fd;
 	void *key, *value;
 	struct fd f;
 	int err = 0;
 
-	f = fdget(ufd);
 	if (attr->batch.elem_flags & ~BPF_F_LOCK)
 		return -EINVAL;
 
@@ -1367,6 +1366,7 @@ int generic_map_update_batch(struct bpf_map *map,
 		return -ENOMEM;
 	}
 
+	f = fdget(ufd); /* bpf_map_do_batch() guarantees ufd is valid */
 	for (cp = 0; cp < max_count; cp++) {
 		err = -EFAULT;
 		if (copy_from_user(key, keys + cp * map->key_size,
@@ -1386,6 +1386,7 @@ int generic_map_update_batch(struct bpf_map *map,
 
 	kvfree(value);
 	kvfree(key);
+	fdput(f);
 	return err;
 }
 
-- 
2.27.0

