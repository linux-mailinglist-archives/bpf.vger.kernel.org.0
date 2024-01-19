Return-Path: <bpf+bounces-19894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DF8832856
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 12:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 960F01F229A4
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 11:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D7B4C61B;
	Fri, 19 Jan 2024 11:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwJlKKkq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F4F1D690
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 11:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705662411; cv=none; b=PprqzvRoOefMQUcAfFKOZOBBfKVd3gmVNmJNNRMeQN/Pvgcvkn8CNgReCkcqRNtyDsROXLOQ1Iy3PgyXZs5byHze0K2leWo2hWG41Q2ldAaVRaeVepZUPTeleFe2EvsE+eCKUIxihXqpBql2wQ5WZPJ7EeNy0EVs4GM6LogJ6nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705662411; c=relaxed/simple;
	bh=QcjXN5ma1jk5KLqNxgY7jFRgyUnmmin2gM1Wz2Ci52w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kt+zAaediOiXnrScAGs4dvfVjjOPolULFfxtbfkhLqoXWAHGAP9cbxx1mjY1qRPPFVlFsXilUzeJAr2WT9vwJbc1pMnDhDyZ7S03d0PoLeO4d17eltrdqk3jcDQE5K6e2V22mtA43yAKIvRtGrDQqN45B6+SLJHcD+EC1y2W2ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwJlKKkq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19AB7C433F1;
	Fri, 19 Jan 2024 11:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705662411;
	bh=QcjXN5ma1jk5KLqNxgY7jFRgyUnmmin2gM1Wz2Ci52w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KwJlKKkqUZDnI41idicYXicn7eehz6z2odPvf4FSYv7sHGFa8X1Mzy08irYskh+J6
	 K5BKQlhraZ83liqoMSVWb6sGox8EGw/G/MzUL7uBuIzG0vqyLknVLxDV2X73NAE7Wp
	 ew/w1SOs1t8/wDU9qmuJxpKLaN4nFKi70tQMXFH1xg+HeY5FHsenC/yvgT/aEGIPo7
	 Q2dQhoaTwhixIZUgU7mAUFvOKwG0Znv2kswn2gzbacjHCIPAy46xgatXNiTkO33beU
	 +ACz4Vof0uJR5VFLs7vyvI6EQkw4TS5MD3ZtMbKxc/zj3M9d7TI39eDg/t9ja/aSxO
	 +qOC4nokQFPRQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Quentin Monnet <quentin@isovalent.com>
Subject: [PATCHv2 bpf-next 8/8] bpftool: Display cookie for kprobe multi link
Date: Fri, 19 Jan 2024 12:05:05 +0100
Message-ID: <20240119110505.400573-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119110505.400573-1-jolsa@kernel.org>
References: <20240119110505.400573-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Displaying cookies for kprobe multi link, in plain mode:

  # bpftool link
  ...
  1397: kprobe_multi  prog 47532
          kretprobe.multi  func_cnt 3
          addr             cookie           func [module]
          ffffffff82b370c0 3                bpf_fentry_test1
          ffffffff82b39780 1                bpf_fentry_test2
          ffffffff82b397a0 2                bpf_fentry_test3

And in json mode:

  # bpftool link -j | jq
  ...
    {
      "id": 1397,
      "type": "kprobe_multi",
      "prog_id": 47532,
      "retprobe": true,
      "func_cnt": 3,
      "missed": 0,
      "funcs": [
        {
          "addr": 18446744071607382208,
          "func": "bpf_fentry_test1",
          "module": null,
          "cookie": 3
        },
        {
          "addr": 18446744071607392128,
          "func": "bpf_fentry_test2",
          "module": null,
          "cookie": 1
        },
        {
          "addr": 18446744071607392160,
          "func": "bpf_fentry_test3",
          "module": null,
          "cookie": 2
        }
      ]
    }

Cookie is attached to specific address, and because we sort addresses
before printing, we need to sort cookies the same way, hence adding
the struct addr_cookie to keep and sort them together.

Also adding missing dd.sym_count check to show_kprobe_multi_json.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/bpf/bpftool/link.c | 78 ++++++++++++++++++++++++++++++++--------
 1 file changed, 63 insertions(+), 15 deletions(-)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index b66a1598b87c..afde9d0c2ea1 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -249,18 +249,44 @@ static int get_prog_info(int prog_id, struct bpf_prog_info *info)
 	return err;
 }
 
-static int cmp_u64(const void *A, const void *B)
+struct addr_cookie {
+	__u64 addr;
+	__u64 cookie;
+};
+
+static int cmp_addr_cookie(const void *A, const void *B)
+{
+	const struct addr_cookie *a = A, *b = B;
+
+	if (a->addr == b->addr)
+		return 0;
+	return a->addr < b->addr ? -1 : 1;
+}
+
+static struct addr_cookie *
+get_addr_cookie_array(__u64 *addrs, __u64 *cookies, __u32 count)
 {
-	const __u64 *a = A, *b = B;
+	struct addr_cookie *data;
+	__u32 i;
 
-	return *a - *b;
+	data = calloc(count, sizeof(data[0]));
+	if (!data) {
+		p_err("mem alloc failed");
+		return NULL;
+	}
+	for (i = 0; i < count; i++) {
+		data[i].addr = addrs[i];
+		data[i].cookie = cookies[i];
+	}
+	qsort(data, count, sizeof(data[0]), cmp_addr_cookie);
+	return data;
 }
 
 static void
 show_kprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
 {
+	struct addr_cookie *data;
 	__u32 i, j = 0;
-	__u64 *addrs;
 
 	jsonw_bool_field(json_wtr, "retprobe",
 			 info->kprobe_multi.flags & BPF_F_KPROBE_MULTI_RETURN);
@@ -268,14 +294,20 @@ show_kprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
 	jsonw_uint_field(json_wtr, "missed", info->kprobe_multi.missed);
 	jsonw_name(json_wtr, "funcs");
 	jsonw_start_array(json_wtr);
-	addrs = u64_to_ptr(info->kprobe_multi.addrs);
-	qsort(addrs, info->kprobe_multi.count, sizeof(addrs[0]), cmp_u64);
+	data = get_addr_cookie_array(u64_to_ptr(info->kprobe_multi.addrs),
+				     u64_to_ptr(info->kprobe_multi.cookies),
+				     info->kprobe_multi.count);
+	if (!data)
+		return;
 
 	/* Load it once for all. */
 	if (!dd.sym_count)
 		kernel_syms_load(&dd);
+	if (!dd.sym_count)
+		goto error;
+
 	for (i = 0; i < dd.sym_count; i++) {
-		if (dd.sym_mapping[i].address != addrs[j])
+		if (dd.sym_mapping[i].address != data[j].addr)
 			continue;
 		jsonw_start_object(json_wtr);
 		jsonw_uint_field(json_wtr, "addr", dd.sym_mapping[i].address);
@@ -287,11 +319,14 @@ show_kprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
 		} else {
 			jsonw_string_field(json_wtr, "module", dd.sym_mapping[i].module);
 		}
+		jsonw_uint_field(json_wtr, "cookie", data[j].cookie);
 		jsonw_end_object(json_wtr);
 		if (j++ == info->kprobe_multi.count)
 			break;
 	}
 	jsonw_end_array(json_wtr);
+error:
+	free(data);
 }
 
 static __u64 *u64_to_arr(__u64 val)
@@ -675,8 +710,8 @@ void netfilter_dump_plain(const struct bpf_link_info *info)
 
 static void show_kprobe_multi_plain(struct bpf_link_info *info)
 {
+	struct addr_cookie *data;
 	__u32 i, j = 0;
-	__u64 *addrs;
 
 	if (!info->kprobe_multi.count)
 		return;
@@ -688,21 +723,24 @@ static void show_kprobe_multi_plain(struct bpf_link_info *info)
 	printf("func_cnt %u  ", info->kprobe_multi.count);
 	if (info->kprobe_multi.missed)
 		printf("missed %llu  ", info->kprobe_multi.missed);
-	addrs = (__u64 *)u64_to_ptr(info->kprobe_multi.addrs);
-	qsort(addrs, info->kprobe_multi.count, sizeof(__u64), cmp_u64);
+	data = get_addr_cookie_array(u64_to_ptr(info->kprobe_multi.addrs),
+				     u64_to_ptr(info->kprobe_multi.cookies),
+				     info->kprobe_multi.count);
+	if (!data)
+		return;
 
 	/* Load it once for all. */
 	if (!dd.sym_count)
 		kernel_syms_load(&dd);
 	if (!dd.sym_count)
-		return;
+		goto error;
 
-	printf("\n\t%-16s %s", "addr", "func [module]");
+	printf("\n\t%-16s %-16s %s", "addr", "cookie", "func [module]");
 	for (i = 0; i < dd.sym_count; i++) {
-		if (dd.sym_mapping[i].address != addrs[j])
+		if (dd.sym_mapping[i].address != data[j].addr)
 			continue;
-		printf("\n\t%016lx %s",
-		       dd.sym_mapping[i].address, dd.sym_mapping[i].name);
+		printf("\n\t%016lx %-16llx %s",
+		       dd.sym_mapping[i].address, data[j].cookie, dd.sym_mapping[i].name);
 		if (dd.sym_mapping[i].module[0] != '\0')
 			printf(" [%s]  ", dd.sym_mapping[i].module);
 		else
@@ -711,6 +749,8 @@ static void show_kprobe_multi_plain(struct bpf_link_info *info)
 		if (j++ == info->kprobe_multi.count)
 			break;
 	}
+error:
+	free(data);
 }
 
 static void show_uprobe_multi_plain(struct bpf_link_info *info)
@@ -966,6 +1006,14 @@ static int do_show_link(int fd)
 				return -ENOMEM;
 			}
 			info.kprobe_multi.addrs = ptr_to_u64(addrs);
+			cookies = calloc(count, sizeof(__u64));
+			if (!cookies) {
+				p_err("mem alloc failed");
+				free(addrs);
+				close(fd);
+				return -ENOMEM;
+			}
+			info.kprobe_multi.cookies = ptr_to_u64(cookies);
 			goto again;
 		}
 	}
-- 
2.43.0


