Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77605F9887
	for <lists+bpf@lfdr.de>; Mon, 10 Oct 2022 08:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiJJGrK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 02:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiJJGrH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 02:47:07 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1833851A1F;
        Sun,  9 Oct 2022 23:47:05 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Mm8Xv0yYnzKFmZ;
        Mon, 10 Oct 2022 14:44:47 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
        by APP2 (Coremail) with SMTP id Syh0CgDnf9Tiv0NjoL4qAA--.49036S3;
        Mon, 10 Oct 2022 14:47:02 +0800 (CST)
From:   Xu Kuohai <xukuohai@huaweicloud.com>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Hou Tao <houtao1@huawei.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH bpf v2 1/5] libbpf: Fix use-after-free in btf_dump_name_dups
Date:   Mon, 10 Oct 2022 03:04:50 -0400
Message-Id: <20221010070454.577433-2-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221010070454.577433-1-xukuohai@huaweicloud.com>
References: <20221010070454.577433-1-xukuohai@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDnf9Tiv0NjoL4qAA--.49036S3
X-Coremail-Antispam: 1UD129KBjvJXoW3XFyDAr1rGF43Gr15Zw43KFg_yoWxKr1rpF
        W7Ja4DAr1fJFnavw47Jr1Sg34Skr4Ivr1jk347tw48uws3Xr97Gr4IyFy3WasxXrZ5Wr13
        A3W3KaykC3W8XwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFOJ5UUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Xu Kuohai <xukuohai@huawei.com>

ASAN reports an use-after-free in btf_dump_name_dups:

ERROR: AddressSanitizer: heap-use-after-free on address 0xffff927006db at pc 0xaaaab5dfb618 bp 0xffffdd89b890 sp 0xffffdd89b928
READ of size 2 at 0xffff927006db thread T0
    #0 0xaaaab5dfb614 in __interceptor_strcmp.part.0 (test_progs+0x21b614)
    #1 0xaaaab635f144 in str_equal_fn tools/lib/bpf/btf_dump.c:127
    #2 0xaaaab635e3e0 in hashmap_find_entry tools/lib/bpf/hashmap.c:143
    #3 0xaaaab635e72c in hashmap__find tools/lib/bpf/hashmap.c:212
    #4 0xaaaab6362258 in btf_dump_name_dups tools/lib/bpf/btf_dump.c:1525
    #5 0xaaaab636240c in btf_dump_resolve_name tools/lib/bpf/btf_dump.c:1552
    #6 0xaaaab6362598 in btf_dump_type_name tools/lib/bpf/btf_dump.c:1567
    #7 0xaaaab6360b48 in btf_dump_emit_struct_def tools/lib/bpf/btf_dump.c:912
    #8 0xaaaab6360630 in btf_dump_emit_type tools/lib/bpf/btf_dump.c:798
    #9 0xaaaab635f720 in btf_dump__dump_type tools/lib/bpf/btf_dump.c:282
    #10 0xaaaab608523c in test_btf_dump_incremental tools/testing/selftests/bpf/prog_tests/btf_dump.c:236
    #11 0xaaaab6097530 in test_btf_dump tools/testing/selftests/bpf/prog_tests/btf_dump.c:875
    #12 0xaaaab6314ed0 in run_one_test tools/testing/selftests/bpf/test_progs.c:1062
    #13 0xaaaab631a0a8 in main tools/testing/selftests/bpf/test_progs.c:1697
    #14 0xffff9676d214 in __libc_start_main ../csu/libc-start.c:308
    #15 0xaaaab5d65990  (test_progs+0x185990)

0xffff927006db is located 11 bytes inside of 16-byte region [0xffff927006d0,0xffff927006e0)
freed by thread T0 here:
    #0 0xaaaab5e2c7c4 in realloc (test_progs+0x24c7c4)
    #1 0xaaaab634f4a0 in libbpf_reallocarray tools/lib/bpf/libbpf_internal.h:191
    #2 0xaaaab634f840 in libbpf_add_mem tools/lib/bpf/btf.c:163
    #3 0xaaaab636643c in strset_add_str_mem tools/lib/bpf/strset.c:106
    #4 0xaaaab6366560 in strset__add_str tools/lib/bpf/strset.c:157
    #5 0xaaaab6352d70 in btf__add_str tools/lib/bpf/btf.c:1519
    #6 0xaaaab6353e10 in btf__add_field tools/lib/bpf/btf.c:2032
    #7 0xaaaab6084fcc in test_btf_dump_incremental tools/testing/selftests/bpf/prog_tests/btf_dump.c:232
    #8 0xaaaab6097530 in test_btf_dump tools/testing/selftests/bpf/prog_tests/btf_dump.c:875
    #9 0xaaaab6314ed0 in run_one_test tools/testing/selftests/bpf/test_progs.c:1062
    #10 0xaaaab631a0a8 in main tools/testing/selftests/bpf/test_progs.c:1697
    #11 0xffff9676d214 in __libc_start_main ../csu/libc-start.c:308
    #12 0xaaaab5d65990  (test_progs+0x185990)

previously allocated by thread T0 here:
    #0 0xaaaab5e2c7c4 in realloc (test_progs+0x24c7c4)
    #1 0xaaaab634f4a0 in libbpf_reallocarray tools/lib/bpf/libbpf_internal.h:191
    #2 0xaaaab634f840 in libbpf_add_mem tools/lib/bpf/btf.c:163
    #3 0xaaaab636643c in strset_add_str_mem tools/lib/bpf/strset.c:106
    #4 0xaaaab6366560 in strset__add_str tools/lib/bpf/strset.c:157
    #5 0xaaaab6352d70 in btf__add_str tools/lib/bpf/btf.c:1519
    #6 0xaaaab6353ff0 in btf_add_enum_common tools/lib/bpf/btf.c:2070
    #7 0xaaaab6354080 in btf__add_enum tools/lib/bpf/btf.c:2102
    #8 0xaaaab6082f50 in test_btf_dump_incremental tools/testing/selftests/bpf/prog_tests/btf_dump.c:162
    #9 0xaaaab6097530 in test_btf_dump tools/testing/selftests/bpf/prog_tests/btf_dump.c:875
    #10 0xaaaab6314ed0 in run_one_test tools/testing/selftests/bpf/test_progs.c:1062
    #11 0xaaaab631a0a8 in main tools/testing/selftests/bpf/test_progs.c:1697
    #12 0xffff9676d214 in __libc_start_main ../csu/libc-start.c:308
    #13 0xaaaab5d65990  (test_progs+0x185990)

The reason is that the key stored in hash table name_map is a string
address, and the string memory is allocated by realloc() function, when
the memory is resized by realloc() later, the old memory may be freed,
so the address stored in name_map references to a freed memory, causing
use-after-free.

Fix it by storing duplicated string address in name_map.

Fixes: 351131b51c7a ("libbpf: add btf_dump API for BTF-to-C conversion")
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 tools/lib/bpf/btf_dump.c | 47 +++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index e4da6de68d8f..8365d801cbd0 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -219,6 +219,17 @@ static int btf_dump_resize(struct btf_dump *d)
 	return 0;
 }
 
+static void btf_dump_free_names(struct hashmap *map)
+{
+	size_t bkt;
+	struct hashmap_entry *cur;
+
+	hashmap__for_each_entry(map, cur, bkt)
+		free((void *)cur->key);
+
+	hashmap__free(map);
+}
+
 void btf_dump__free(struct btf_dump *d)
 {
 	int i;
@@ -237,8 +248,8 @@ void btf_dump__free(struct btf_dump *d)
 	free(d->cached_names);
 	free(d->emit_queue);
 	free(d->decl_stack);
-	hashmap__free(d->type_names);
-	hashmap__free(d->ident_names);
+	btf_dump_free_names(d->type_names);
+	btf_dump_free_names(d->ident_names);
 
 	free(d);
 }
@@ -634,8 +645,8 @@ static void btf_dump_emit_type_chain(struct btf_dump *d,
 
 static const char *btf_dump_type_name(struct btf_dump *d, __u32 id);
 static const char *btf_dump_ident_name(struct btf_dump *d, __u32 id);
-static size_t btf_dump_name_dups(struct btf_dump *d, struct hashmap *name_map,
-				 const char *orig_name);
+static ssize_t btf_dump_name_dups(struct btf_dump *d, struct hashmap *name_map,
+				  const char *orig_name);
 
 static bool btf_dump_is_blacklisted(struct btf_dump *d, __u32 id)
 {
@@ -995,7 +1006,7 @@ static void btf_dump_emit_enum32_val(struct btf_dump *d,
 	bool is_signed = btf_kflag(t);
 	const char *fmt_str;
 	const char *name;
-	size_t dup_cnt;
+	ssize_t dup_cnt;
 	int i;
 
 	for (i = 0; i < vlen; i++, v++) {
@@ -1020,7 +1031,7 @@ static void btf_dump_emit_enum64_val(struct btf_dump *d,
 	bool is_signed = btf_kflag(t);
 	const char *fmt_str;
 	const char *name;
-	size_t dup_cnt;
+	ssize_t dup_cnt;
 	__u64 val;
 	int i;
 
@@ -1521,14 +1532,30 @@ static void btf_dump_emit_type_cast(struct btf_dump *d, __u32 id,
 }
 
 /* return number of duplicates (occurrences) of a given name */
-static size_t btf_dump_name_dups(struct btf_dump *d, struct hashmap *name_map,
-				 const char *orig_name)
+static ssize_t btf_dump_name_dups(struct btf_dump *d, struct hashmap *name_map,
+				  const char *orig_name)
 {
-	size_t dup_cnt = 0;
+	int err;
+	char *old_name;
+	char *new_name;
+	ssize_t dup_cnt = 0;
+
+	new_name = strdup(orig_name);
+	if (!new_name)
+		return -ENOMEM;
 
 	hashmap__find(name_map, orig_name, (void **)&dup_cnt);
 	dup_cnt++;
-	hashmap__set(name_map, orig_name, (void *)dup_cnt, NULL, NULL);
+
+	err = hashmap__set(name_map, new_name, (void *)dup_cnt,
+			   (const void **)&old_name, NULL);
+	if (err) {
+		free(new_name);
+		return err;
+	}
+
+	if (old_name)
+		free(old_name);
 
 	return dup_cnt;
 }
-- 
2.30.2

