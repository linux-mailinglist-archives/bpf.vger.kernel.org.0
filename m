Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F81B5E8D07
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 15:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiIXNSa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 24 Sep 2022 09:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiIXNS0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 24 Sep 2022 09:18:26 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AD3B5E76
        for <bpf@vger.kernel.org>; Sat, 24 Sep 2022 06:18:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MZV0614HWz6S29b
        for <bpf@vger.kernel.org>; Sat, 24 Sep 2022 21:16:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDXKXOXAy9jXzpPBQ--.3282S12;
        Sat, 24 Sep 2022 21:18:22 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, houtao1@huawei.com
Subject: [PATCH bpf-next v2 08/13] bpftool: Add support for qp-trie map
Date:   Sat, 24 Sep 2022 21:36:15 +0800
Message-Id: <20220924133620.4147153-9-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220924133620.4147153-1-houtao@huaweicloud.com>
References: <20220924133620.4147153-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDXKXOXAy9jXzpPBQ--.3282S12
X-Coremail-Antispam: 1UD129KBjvAXoW3uw4ftw1fKF45KF4xWFW8Crg_yoW8JFyxGo
        WfZr45u3W8Wr18Zr48KF1vvFZ3XryjkrWDAr4avrs8GF1Iyr90vFy7Jw43uayjva4Ygryx
        X3Wqqw4fWFWxGF1rn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYu7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
        0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
        j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxV
        AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x02
        67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
        c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28Icx
        kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
        Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IUbGXdUUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Support lookup/update/delete/iterate/dump operations for qp-trie in
bpftool. Mainly add two functions: one function to parse dynptr key and
another one to dump dynptr key. The input format of dynptr key is:
"key [hex] size BYTES" and the output format of dynptr key is:
"size BYTES".

The following is the output when using bpftool to manipulate
qp-trie:

  $ bpftool map pin id 724953 /sys/fs/bpf/qp
  $ bpftool map show pinned /sys/fs/bpf/qp
  724953: qp_trie  name qp_trie  flags 0x1
          key 16B  value 4B  max_entries 2  memlock 65536B  map_extra 8
          btf_id 779
          pids test_qp_trie.bi(109167)
  $ bpftool map dump pinned /sys/fs/bpf/qp
  [{
          "key": {
              "size": 4,
              "data": ["0x0","0x0","0x0","0x0"
              ]
          },
          "value": 0
      },{
          "key": {
              "size": 4,
              "data": ["0x0","0x0","0x0","0x1"
              ]
          },
          "value": 2
      }
  ]
  $ bpftool map lookup pinned /sys/fs/bpf/qp key 4 0 0 0 1
  {
      "key": {
          "size": 4,
          "data": ["0x0","0x0","0x0","0x1"
          ]
      },
      "value": 2
  }
  $ bpftool map update pinned /sys/fs/bpf/qp key 4 0 0 0 1 value 2 0 0 0
  $ bpftool map getnext pinned /sys/fs/bpf/qp
  key: None
  next key:
  00 00 00 00
  $ bpftool map getnext pinned /sys/fs/bpf/qp key 4 0 0 0 0
  key:
  00 00 00 00
  next key:
  00 00 00 01
  $ bpftool map getnext pinned /sys/fs/bpf/qp key 4 0 0 0 1
  Error: can't get next key: No such file or directory
  $ bpftool map delete pinned /sys/fs/bpf/qp key 4 0 0 0 1
  $ bpftool map dump pinned /sys/fs/bpf/qp
  [{
          "key": {
              "size": 4,
              "data": ["0x0","0x0","0x0","0x0"
              ]
          },
          "value": 0
      }
  ]

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../bpf/bpftool/Documentation/bpftool-map.rst |   4 +-
 tools/bpf/bpftool/btf_dumper.c                |  33 ++++
 tools/bpf/bpftool/map.c                       | 149 +++++++++++++++---
 3 files changed, 164 insertions(+), 22 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index 7f3b67a8b48f..020df5481fd6 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -45,7 +45,7 @@ MAP COMMANDS
 |	**bpftool** **map help**
 |
 |	*MAP* := { **id** *MAP_ID* | **pinned** *FILE* | **name** *MAP_NAME* }
-|	*DATA* := { [**hex**] *BYTES* }
+|	*DATA* := { [**hex**] *BYTES* | [**hex**] *size* *BYTES* }
 |	*PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* | **name** *PROG_NAME* }
 |	*VALUE* := { *DATA* | *MAP* | *PROG* }
 |	*UPDATE_FLAGS* := { **any** | **exist** | **noexist** }
@@ -55,7 +55,7 @@ MAP COMMANDS
 |		| **devmap** | **devmap_hash** | **sockmap** | **cpumap** | **xskmap** | **sockhash**
 |		| **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_storage**
 |		| **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf** | **inode_storage**
-|		| **task_storage** | **bloom_filter** | **user_ringbuf** }
+|		| **task_storage** | **bloom_filter** | **user_ringbuf** | **qp_trie** }
 
 DESCRIPTION
 ===========
diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index 19924b6ce796..817868961963 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -462,6 +462,30 @@ static int btf_dumper_int(const struct btf_type *t, __u8 bit_offset,
 	return 0;
 }
 
+static int btf_dumper_dynptr_user(const struct btf_dumper *d,
+				  const struct bpf_dynptr_user *dynptr)
+{
+	unsigned int i, size;
+	unsigned char *data;
+
+	data = bpf_dynptr_user_get_data(dynptr);
+	size = bpf_dynptr_user_get_size(dynptr);
+
+	jsonw_start_object(d->jw);
+
+	jsonw_name(d->jw, "size");
+	jsonw_printf(d->jw, "%u", size);
+	jsonw_name(d->jw, "data");
+	jsonw_start_array(d->jw);
+	for (i = 0; i < size; i++)
+		jsonw_printf(d->jw, "\"0x%hhx\"", data[i]);
+	jsonw_end_array(d->jw);
+
+	jsonw_end_object(d->jw);
+
+	return 0;
+}
+
 static int btf_dumper_struct(const struct btf_dumper *d, __u32 type_id,
 			     const void *data)
 {
@@ -552,6 +576,12 @@ static int btf_dumper_datasec(const struct btf_dumper *d, __u32 type_id,
 	return ret;
 }
 
+static bool btf_is_dynptr(const struct btf *btf, const struct btf_type *t)
+{
+	return t->size == sizeof(struct bpf_dynptr) &&
+	       !strcmp(btf__name_by_offset(btf, t->name_off), "bpf_dynptr");
+}
+
 static int btf_dumper_do_type(const struct btf_dumper *d, __u32 type_id,
 			      __u8 bit_offset, const void *data)
 {
@@ -562,6 +592,9 @@ static int btf_dumper_do_type(const struct btf_dumper *d, __u32 type_id,
 		return btf_dumper_int(t, bit_offset, data, d->jw,
 				     d->is_plain_text);
 	case BTF_KIND_STRUCT:
+		if (btf_is_dynptr(d->btf, t))
+			return btf_dumper_dynptr_user(d, data);
+		/* fallthrough */
 	case BTF_KIND_UNION:
 		return btf_dumper_struct(d, type_id, data);
 	case BTF_KIND_ARRAY:
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 9a6ca9f31133..92c175518293 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -43,6 +43,17 @@ static bool map_is_map_of_progs(__u32 type)
 	return type == BPF_MAP_TYPE_PROG_ARRAY;
 }
 
+static bool map_is_dynptr_key(__u32 type)
+{
+	return type == BPF_MAP_TYPE_QP_TRIE;
+}
+
+static bool map_use_map_extra(__u32 type)
+{
+	return type == BPF_MAP_TYPE_BLOOM_FILTER ||
+	       type == BPF_MAP_TYPE_QP_TRIE;
+}
+
 static int map_type_from_str(const char *type)
 {
 	const char *map_type_str;
@@ -130,14 +141,44 @@ static json_writer_t *get_btf_writer(void)
 	return jw;
 }
 
-static void print_entry_json(struct bpf_map_info *info, unsigned char *key,
+static void print_key_by_hex_data_json(struct bpf_map_info *info, void *key)
+{
+	unsigned int data_size;
+	unsigned char *data;
+
+	if (map_is_dynptr_key(info->type)) {
+		data = bpf_dynptr_user_get_data(key);
+		data_size = bpf_dynptr_user_get_size(key);
+	} else {
+		data = key;
+		data_size = info->key_size;
+	}
+	print_hex_data_json(data, data_size);
+}
+
+static void fprint_key_in_hex(struct bpf_map_info *info, void *key)
+{
+	unsigned int data_size;
+	unsigned char *data;
+
+	if (map_is_dynptr_key(info->type)) {
+		data = bpf_dynptr_user_get_data(key);
+		data_size = bpf_dynptr_user_get_size(key);
+	} else {
+		data = key;
+		data_size = info->key_size;
+	}
+	fprint_hex(stdout, data, data_size, " ");
+}
+
+static void print_entry_json(struct bpf_map_info *info, void *key,
 			     unsigned char *value, struct btf *btf)
 {
 	jsonw_start_object(json_wtr);
 
 	if (!map_is_per_cpu(info->type)) {
 		jsonw_name(json_wtr, "key");
-		print_hex_data_json(key, info->key_size);
+		print_key_by_hex_data_json(info, key);
 		jsonw_name(json_wtr, "value");
 		print_hex_data_json(value, info->value_size);
 		if (btf) {
@@ -242,19 +283,23 @@ print_entry_error(struct bpf_map_info *map_info, void *key, int lookup_errno)
 	}
 }
 
-static void print_entry_plain(struct bpf_map_info *info, unsigned char *key,
+static void print_entry_plain(struct bpf_map_info *info, void *key,
 			      unsigned char *value)
 {
 	if (!map_is_per_cpu(info->type)) {
 		bool single_line, break_names;
+		unsigned int key_size;
 
-		break_names = info->key_size > 16 || info->value_size > 16;
-		single_line = info->key_size + info->value_size <= 24 &&
-			!break_names;
+		if (map_is_dynptr_key(info->type))
+			key_size = bpf_dynptr_user_get_size(key);
+		else
+			key_size = info->key_size;
+		break_names = key_size > 16 || info->value_size > 16;
+		single_line = key_size + info->value_size <= 24 && !break_names;
 
-		if (info->key_size) {
+		if (key_size) {
 			printf("key:%c", break_names ? '\n' : ' ');
-			fprint_hex(stdout, key, info->key_size, " ");
+			fprint_key_in_hex(info, key);
 
 			printf(single_line ? "  " : "\n");
 		}
@@ -316,6 +361,38 @@ static char **parse_bytes(char **argv, const char *name, unsigned char *val,
 	return argv + i;
 }
 
+/* The format of dynptr is "[hex] size BYTES" */
+static char **parse_dynptr(char **argv, const char *name,
+			   struct bpf_dynptr_user *dynptr)
+{
+	unsigned int base = 0, size;
+	char *endptr;
+
+	if (is_prefix(*argv, "hex")) {
+		base = 16;
+		argv++;
+	}
+	if (!*argv) {
+		p_err("no byte length");
+		return NULL;
+	}
+
+	size = strtoul(*argv, &endptr, base);
+	if (*endptr) {
+		p_err("error parsing byte length: %s", *argv);
+		return NULL;
+	}
+	if (!size || size > bpf_dynptr_user_get_size(dynptr)) {
+		p_err("invalid byte length %u (max length %u)",
+		      size, bpf_dynptr_user_get_size(dynptr));
+		return NULL;
+	}
+	bpf_dynptr_user_trim(dynptr, size);
+
+	return parse_bytes(argv + 1, name, bpf_dynptr_user_get_data(dynptr),
+			   size);
+}
+
 /* on per cpu maps we must copy the provided value on all value instances */
 static void fill_per_cpu_value(struct bpf_map_info *info, void *value)
 {
@@ -350,7 +427,10 @@ static int parse_elem(char **argv, struct bpf_map_info *info,
 			return -1;
 		}
 
-		argv = parse_bytes(argv + 1, "key", key, key_size);
+		if (map_is_dynptr_key(info->type))
+			argv = parse_dynptr(argv + 1, "key", key);
+		else
+			argv = parse_bytes(argv + 1, "key", key, key_size);
 		if (!argv)
 			return -1;
 
@@ -568,6 +648,9 @@ static int show_map_close_plain(int fd, struct bpf_map_info *info)
 		printf("  memlock %sB", memlock);
 	free(memlock);
 
+	if (map_use_map_extra(info->type))
+		printf("  map_extra %llu", info->map_extra);
+
 	if (info->type == BPF_MAP_TYPE_PROG_ARRAY) {
 		char *owner_prog_type = get_fdinfo(fd, "owner_prog_type");
 		char *owner_jited = get_fdinfo(fd, "owner_jited");
@@ -820,6 +903,18 @@ static void free_btf_vmlinux(void)
 		btf__free(btf_vmlinux);
 }
 
+static struct bpf_dynptr_user *bpf_dynptr_user_new(__u32 size)
+{
+	struct bpf_dynptr_user *dynptr;
+
+	dynptr = malloc(sizeof(*dynptr) + size);
+	if (!dynptr)
+		return NULL;
+
+	bpf_dynptr_user_init(&dynptr[1], size, dynptr);
+	return dynptr;
+}
+
 static int
 map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 	 bool show_header)
@@ -829,7 +924,10 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 	struct btf *btf = NULL;
 	int err;
 
-	key = malloc(info->key_size);
+	if (map_is_dynptr_key(info->type))
+		key = bpf_dynptr_user_new(info->map_extra);
+	else
+		key = malloc(info->key_size);
 	value = alloc_value(info);
 	if (!key || !value) {
 		p_err("mem alloc failed");
@@ -966,7 +1064,10 @@ static int alloc_key_value(struct bpf_map_info *info, void **key, void **value)
 	*value = NULL;
 
 	if (info->key_size) {
-		*key = malloc(info->key_size);
+		if (map_is_dynptr_key(info->type))
+			*key = bpf_dynptr_user_new(info->map_extra);
+		else
+			*key = malloc(info->key_size);
 		if (!*key) {
 			p_err("key mem alloc failed");
 			return -1;
@@ -1132,8 +1233,13 @@ static int do_getnext(int argc, char **argv)
 	if (fd < 0)
 		return -1;
 
-	key = malloc(info.key_size);
-	nextkey = malloc(info.key_size);
+	if (map_is_dynptr_key(info.type)) {
+		key = bpf_dynptr_user_new(info.map_extra);
+		nextkey = bpf_dynptr_user_new(info.map_extra);
+	} else {
+		key = malloc(info.key_size);
+		nextkey = malloc(info.key_size);
+	}
 	if (!key || !nextkey) {
 		p_err("mem alloc failed");
 		err = -1;
@@ -1160,23 +1266,23 @@ static int do_getnext(int argc, char **argv)
 		jsonw_start_object(json_wtr);
 		if (key) {
 			jsonw_name(json_wtr, "key");
-			print_hex_data_json(key, info.key_size);
+			print_key_by_hex_data_json(&info, key);
 		} else {
 			jsonw_null_field(json_wtr, "key");
 		}
 		jsonw_name(json_wtr, "next_key");
-		print_hex_data_json(nextkey, info.key_size);
+		print_key_by_hex_data_json(&info, nextkey);
 		jsonw_end_object(json_wtr);
 	} else {
 		if (key) {
 			printf("key:\n");
-			fprint_hex(stdout, key, info.key_size, " ");
+			fprint_key_in_hex(&info, key);
 			printf("\n");
 		} else {
 			printf("key: None\n");
 		}
 		printf("next key:\n");
-		fprint_hex(stdout, nextkey, info.key_size, " ");
+		fprint_key_in_hex(&info, nextkey);
 		printf("\n");
 	}
 
@@ -1203,7 +1309,10 @@ static int do_delete(int argc, char **argv)
 	if (fd < 0)
 		return -1;
 
-	key = malloc(info.key_size);
+	if (map_is_dynptr_key(info.type))
+		key = bpf_dynptr_user_new(info.map_extra);
+	else
+		key = malloc(info.key_size);
 	if (!key) {
 		p_err("mem alloc failed");
 		err = -1;
@@ -1449,7 +1558,7 @@ static int do_help(int argc, char **argv)
 		"       %1$s %2$s help\n"
 		"\n"
 		"       " HELP_SPEC_MAP "\n"
-		"       DATA := { [hex] BYTES }\n"
+		"       DATA := { [hex] BYTES | [hex] size BYTES }\n"
 		"       " HELP_SPEC_PROGRAM "\n"
 		"       VALUE := { DATA | MAP | PROG }\n"
 		"       UPDATE_FLAGS := { any | exist | noexist }\n"
@@ -1459,7 +1568,7 @@ static int do_help(int argc, char **argv)
 		"                 devmap | devmap_hash | sockmap | cpumap | xskmap | sockhash |\n"
 		"                 cgroup_storage | reuseport_sockarray | percpu_cgroup_storage |\n"
 		"                 queue | stack | sk_storage | struct_ops | ringbuf | inode_storage |\n"
-		"                 task_storage | bloom_filter | user_ringbuf }\n"
+		"                 task_storage | bloom_filter | user_ringbuf | qp_trie }\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
 		"                    {-f|--bpffs} | {-n|--nomount} }\n"
 		"",
-- 
2.29.2

