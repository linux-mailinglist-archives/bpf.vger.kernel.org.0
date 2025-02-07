Return-Path: <bpf+bounces-50762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3240BA2C2DE
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 13:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A6993AA03A
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 12:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3D61E3DD7;
	Fri,  7 Feb 2025 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ehq20GJd"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B604317C68;
	Fri,  7 Feb 2025 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738932012; cv=none; b=oyzG9y/jOIERzCxMa/DtjUnDFPExjdt/LeruT2HVs0AIJqlwiqyZn7LRQZwHUjrMTSmrPxFZIRM2oBchEBpbK+fiPEkNMh6DK35pTSs8qzEVE3KLqNUGksoke0lnv3z0Xg2H32x/GiK7uuc/rSkg8l3Do9FTSYTa3hXTUUc+bjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738932012; c=relaxed/simple;
	bh=cbhsiAlTxW/jz+3TdDAgt1Bp8X6UWDXtL5SGoaJj7Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4TYHlv68aDLx2jpbT8oX0od0dZLVfnX42DIpErKyNegLWCiK0wCzH0YukbFzgwVnTS6HMa3shpBiDFT7MlKMZR6dOzgR4Hti9y5Orl0mkX2O8elMs4Ea7qM8b82HfOMaPFDgYBbNyAVygFxMIIDBmLBSBMhAWumo9eYXDJbMQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ehq20GJd; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=9Q9Bx
	CWmpRUIFuvte9K7JfnZwgtYob++JS6RIEHXY3Y=; b=ehq20GJdr3yjcn6BP2777
	2EBkdiAW5qK4gfLQpKWUD9P1L2XuIKfl74sTdoS91hpHV3xB3R7vJC8268Xnz4Fj
	jM0uW1frXaGmYpBUHWJzujweMhasIAIFQHi81vBeWGknTRYauic+SfsswYUb5cWr
	ndnJ3eMfWR3drW1qQ0tm24=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wBXz910_qVn3DJjKQ--.8274S3;
	Fri, 07 Feb 2025 20:37:12 +0800 (CST)
From: Jiayuan Chen <mrpre@163.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	qmo@kernel.org,
	Jiayuan Chen <mrpre@163.com>
Subject: [PATCH bpf-next v1 1/1] bpftool: Using the right format specifiers
Date: Fri,  7 Feb 2025 20:37:06 +0800
Message-ID: <20250207123706.727928-2-mrpre@163.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250207123706.727928-1-mrpre@163.com>
References: <20250207123706.727928-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXz910_qVn3DJjKQ--.8274S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3XF1Dtw4kJF1rZryDXw15twb_yoW3uryDpa
	y5Jr92kr4IqrW3urWxA398uFWrXws7J347GF97K3yrZF1xWr98XF1jkFy0v345uF1Fyay7
	Za1YkFyYgws7ZFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRF_MsUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiDwDsp2el-KEViwADsG

Fixed some formatting specifiers errors, such as using %d for int and %u
for unsigned int, as well as other byte-length types.

Signed-off-by: Jiayuan Chen <mrpre@163.com>
---
 tools/bpf/bpftool/gen.c  | 12 ++++++------
 tools/bpf/bpftool/link.c | 14 +++++++-------
 tools/bpf/bpftool/main.c |  8 ++++----
 tools/bpf/bpftool/map.c  | 10 +++++-----
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 5a4d3240689e..67a60114368f 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -670,7 +670,7 @@ static void codegen_destroy(struct bpf_object *obj, const char *obj_name)
 			continue;
 		if (bpf_map__is_internal(map) &&
 		    (bpf_map__map_flags(map) & BPF_F_MMAPABLE))
-			printf("\tskel_free_map_data(skel->%1$s, skel->maps.%1$s.initial_value, %2$zd);\n",
+			printf("\tskel_free_map_data(skel->%1$s, skel->maps.%1$s.initial_value, %2$zu);\n",
 			       ident, bpf_map_mmap_sz(map));
 		codegen("\
 			\n\
@@ -984,7 +984,7 @@ static int walk_st_ops_shadow_vars(struct btf *btf, const char *ident,
 
 		offset = m->offset / 8;
 		if (next_offset < offset)
-			printf("\t\t\tchar __padding_%d[%d];\n", i, offset - next_offset);
+			printf("\t\t\tchar __padding_%d[%u];\n", i, offset - next_offset);
 
 		switch (btf_kind(member_type)) {
 		case BTF_KIND_INT:
@@ -1052,7 +1052,7 @@ static int walk_st_ops_shadow_vars(struct btf *btf, const char *ident,
 	/* Cannot fail since it must be a struct type */
 	size = btf__resolve_size(btf, map_type_id);
 	if (next_offset < (__u32)size)
-		printf("\t\t\tchar __padding_end[%d];\n", size - next_offset);
+		printf("\t\t\tchar __padding_end[%u];\n", size - next_offset);
 
 out:
 	btf_dump__free(d);
@@ -2095,7 +2095,7 @@ btfgen_mark_type(struct btfgen_info *info, unsigned int type_id, bool follow_poi
 		break;
 	/* tells if some other type needs to be handled */
 	default:
-		p_err("unsupported kind: %s (%d)", btf_kind_str(btf_type), type_id);
+		p_err("unsupported kind: %s (%u)", btf_kind_str(btf_type), type_id);
 		return -EINVAL;
 	}
 
@@ -2147,7 +2147,7 @@ static int btfgen_record_field_relo(struct btfgen_info *info, struct bpf_core_sp
 			btf_type = btf__type_by_id(btf, type_id);
 			break;
 		default:
-			p_err("unsupported kind: %s (%d)",
+			p_err("unsupported kind: %s (%u)",
 			      btf_kind_str(btf_type), btf_type->type);
 			return -EINVAL;
 		}
@@ -2246,7 +2246,7 @@ static int btfgen_mark_type_match(struct btfgen_info *info, __u32 type_id, bool
 	}
 	/* tells if some other type needs to be handled */
 	default:
-		p_err("unsupported kind: %s (%d)", btf_kind_str(btf_type), type_id);
+		p_err("unsupported kind: %s (%u)", btf_kind_str(btf_type), type_id);
 		return -EINVAL;
 	}
 
diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 5cd503b763d7..52fd2c9fac56 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -107,7 +107,7 @@ static int link_parse_fd(int *argc, char ***argv)
 
 		fd = bpf_link_get_fd_by_id(id);
 		if (fd < 0)
-			p_err("failed to get link with ID %d: %s", id, strerror(errno));
+			p_err("failed to get link with ID %u: %s", id, strerror(errno));
 		return fd;
 	} else if (is_prefix(**argv, "pinned")) {
 		char *path;
@@ -404,7 +404,7 @@ static char *perf_config_hw_cache_str(__u64 config)
 	if (hw_cache)
 		snprintf(str, PERF_HW_CACHE_LEN, "%s-", hw_cache);
 	else
-		snprintf(str, PERF_HW_CACHE_LEN, "%lld-", config & 0xff);
+		snprintf(str, PERF_HW_CACHE_LEN, "%llu-", config & 0xff);
 
 	op = perf_event_name(evsel__hw_cache_op, (config >> 8) & 0xff);
 	if (op)
@@ -412,7 +412,7 @@ static char *perf_config_hw_cache_str(__u64 config)
 			 "%s-", op);
 	else
 		snprintf(str + strlen(str), PERF_HW_CACHE_LEN - strlen(str),
-			 "%lld-", (config >> 8) & 0xff);
+			 "%llu-", (config >> 8) & 0xff);
 
 	result = perf_event_name(evsel__hw_cache_result, config >> 16);
 	if (result)
@@ -420,7 +420,7 @@ static char *perf_config_hw_cache_str(__u64 config)
 			 "%s", result);
 	else
 		snprintf(str + strlen(str), PERF_HW_CACHE_LEN - strlen(str),
-			 "%lld", config >> 16);
+			 "%llu", config >> 16);
 	return str;
 }
 
@@ -623,7 +623,7 @@ static void show_link_ifindex_plain(__u32 ifindex)
 	else
 		snprintf(devname, sizeof(devname), "(detached)");
 	if (ret)
-		snprintf(devname, sizeof(devname), "%s(%d)",
+		snprintf(devname, sizeof(devname), "%s(%u)",
 			 tmpname, ifindex);
 	printf("ifindex %s  ", devname);
 }
@@ -699,7 +699,7 @@ void netfilter_dump_plain(const struct bpf_link_info *info)
 	if (pfname)
 		printf("\n\t%s", pfname);
 	else
-		printf("\n\tpf: %d", pf);
+		printf("\n\tpf: %u", pf);
 
 	if (hookname)
 		printf(" %s", hookname);
@@ -773,7 +773,7 @@ static void show_uprobe_multi_plain(struct bpf_link_info *info)
 	printf("func_cnt %u  ", info->uprobe_multi.count);
 
 	if (info->uprobe_multi.pid)
-		printf("pid %d  ", info->uprobe_multi.pid);
+		printf("pid %u  ", info->uprobe_multi.pid);
 
 	printf("\n\t%-16s   %-16s   %-16s", "offset", "ref_ctr_offset", "cookies");
 	for (i = 0; i < info->uprobe_multi.count; i++) {
diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 08d0ac543c67..cd5963cb6058 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -152,7 +152,7 @@ static int do_version(int argc, char **argv)
 			     BPFTOOL_MINOR_VERSION, BPFTOOL_PATCH_VERSION);
 #endif
 		jsonw_name(json_wtr, "libbpf_version");
-		jsonw_printf(json_wtr, "\"%d.%d\"",
+		jsonw_printf(json_wtr, "\"%u.%u\"",
 			     libbpf_major_version(), libbpf_minor_version());
 
 		jsonw_name(json_wtr, "features");
@@ -370,7 +370,7 @@ static int do_batch(int argc, char **argv)
 		while ((cp = strstr(buf, "\\\n")) != NULL) {
 			if (!fgets(contline, sizeof(contline), fp) ||
 			    strlen(contline) == 0) {
-				p_err("missing continuation line on command %d",
+				p_err("missing continuation line on command %u",
 				      lines);
 				err = -1;
 				goto err_close;
@@ -381,7 +381,7 @@ static int do_batch(int argc, char **argv)
 				*cp = '\0';
 
 			if (strlen(buf) + strlen(contline) + 1 > sizeof(buf)) {
-				p_err("command %d is too long", lines);
+				p_err("command %u is too long", lines);
 				err = -1;
 				goto err_close;
 			}
@@ -423,7 +423,7 @@ static int do_batch(int argc, char **argv)
 		err = -1;
 	} else {
 		if (!json_output)
-			printf("processed %d commands\n", lines);
+			printf("processed %u commands\n", lines);
 	}
 err_close:
 	if (fp != stdin)
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index b89bd792c1d5..ed4a9bd82931 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -285,7 +285,7 @@ static void print_entry_plain(struct bpf_map_info *info, unsigned char *key,
 		}
 		if (info->value_size) {
 			for (i = 0; i < n; i++) {
-				printf("value (CPU %02d):%c",
+				printf("value (CPU %02u):%c",
 				       i, info->value_size > 16 ? '\n' : ' ');
 				fprint_hex(stdout, value + i * step,
 					   info->value_size, " ");
@@ -316,7 +316,7 @@ static char **parse_bytes(char **argv, const char *name, unsigned char *val,
 	}
 
 	if (i != n) {
-		p_err("%s expected %d bytes got %d", name, n, i);
+		p_err("%s expected %u bytes got %u", name, n, i);
 		return NULL;
 	}
 
@@ -462,7 +462,7 @@ static void show_map_header_json(struct bpf_map_info *info, json_writer_t *wtr)
 		jsonw_string_field(wtr, "name", info->name);
 
 	jsonw_name(wtr, "flags");
-	jsonw_printf(wtr, "%d", info->map_flags);
+	jsonw_printf(wtr, "%u", info->map_flags);
 }
 
 static int show_map_close_json(int fd, struct bpf_map_info *info)
@@ -588,7 +588,7 @@ static int show_map_close_plain(int fd, struct bpf_map_info *info)
 			if (prog_type_str)
 				printf("owner_prog_type %s  ", prog_type_str);
 			else
-				printf("owner_prog_type %d  ", prog_type);
+				printf("owner_prog_type %u  ", prog_type);
 		}
 		if (owner_jited)
 			printf("owner%s jited",
@@ -615,7 +615,7 @@ static int show_map_close_plain(int fd, struct bpf_map_info *info)
 		printf("\n\t");
 
 	if (info->btf_id)
-		printf("btf_id %d", info->btf_id);
+		printf("btf_id %u", info->btf_id);
 
 	if (frozen)
 		printf("%sfrozen", info->btf_id ? "  " : "");
-- 
2.43.5


