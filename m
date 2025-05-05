Return-Path: <bpf+bounces-57392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2459CAAA152
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 00:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6C3C178F54
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 22:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C46929E05A;
	Mon,  5 May 2025 22:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmxgVc9P"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9990127E7FA;
	Mon,  5 May 2025 22:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483583; cv=none; b=YboMp69fpxQnyWfE64TCqSWXHOSRfnQZolwC8ahUpNnQAxozgOjZCSlYMaBuaCicxhlHiN7o8+LtNcFJ7VYp4kRvXkFzjXtwGq/5itzVwyhBbYvPW7VeOuNOCVPy41K6Z8buXBW7FaHTwiPBkF6lfgM6D9OuGXZQWYaZAU8ZUjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483583; c=relaxed/simple;
	bh=P0JGJq2ClTAH0t6FAJfezwpo9gFgMRfvgyRmPJaiuRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vCr53Ah1MNf8SPuXGmhtk92mTpF0XtFtnY9OurnXCuhR+it4CxROvLGSY8fRg3qRR3C3EKw/iaQArJEmJYIBEpiOvut0cpb36bS0fAMwkeHhM8wPSFxvezPrgg1R9YATPtytrdD4+n40jFTW++Dl0yS88Ml8fbfrRytZtgSkqhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmxgVc9P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB55C4CEE4;
	Mon,  5 May 2025 22:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483583;
	bh=P0JGJq2ClTAH0t6FAJfezwpo9gFgMRfvgyRmPJaiuRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KmxgVc9PDDWoCEPeMXWc2raa9YZTTwtohrElmqVC0AW/J/gqINNuNIW0A8alnZafL
	 HRZOHwir1myXxBp9sz5SQEiJXFoLSiGaJfzdN/dn95CfQnHrLE/pz5YxAjnGL413u2
	 4MLTYPh12n8GCVGYIbO1DG1DXbSJevAqXpaBDQWXmMUAoPeCJRLzrFAEecSn/S65V2
	 uc1V1p9Ytad4dADTYNDjMEXZJN7s6jD219B8nh+v3cw0G5RFysMqWWhcSFThc5H/ik
	 67sYhEwAvjnWgF+DaS/LsfetDFsDAiPNBbYqF64+C4vyjH47mA8/S78+K7Y71smcE4
	 EH6ag4k/xV23w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 125/642] bpftool: Using the right format specifiers
Date: Mon,  5 May 2025 18:05:41 -0400
Message-Id: <20250505221419.2672473-125-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Jiayuan Chen <jiayuan.chen@linux.dev>

[ Upstream commit 3775be3417cc3243b0df0492bd308559dcf0560b ]

Fixed some formatting specifiers errors, such as using %d for int and %u
for unsigned int, as well as other byte-length types.

Perform type cast using the type derived from the data type itself, for
example, if it's originally an int, it will be cast to unsigned int if
forced to unsigned.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20250311112809.81901-3-jiayuan.chen@linux.dev
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/disasm.c                |  4 ++--
 tools/bpf/bpftool/btf.c            | 14 +++++++-------
 tools/bpf/bpftool/btf_dumper.c     |  2 +-
 tools/bpf/bpftool/cgroup.c         |  2 +-
 tools/bpf/bpftool/common.c         |  4 ++--
 tools/bpf/bpftool/jit_disasm.c     |  3 ++-
 tools/bpf/bpftool/map_perf_ring.c  |  6 +++---
 tools/bpf/bpftool/net.c            |  4 ++--
 tools/bpf/bpftool/netlink_dumper.c |  6 +++---
 tools/bpf/bpftool/prog.c           | 12 ++++++------
 tools/bpf/bpftool/tracelog.c       |  2 +-
 tools/bpf/bpftool/xlated_dumper.c  |  6 +++---
 12 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 309c4aa1b026a..c235acbd65095 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -202,7 +202,7 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				insn->dst_reg, class == BPF_ALU ? 'w' : 'r',
 				insn->dst_reg);
 		} else if (is_addr_space_cast(insn)) {
-			verbose(cbs->private_data, "(%02x) r%d = addr_space_cast(r%d, %d, %d)\n",
+			verbose(cbs->private_data, "(%02x) r%d = addr_space_cast(r%d, %u, %u)\n",
 				insn->code, insn->dst_reg,
 				insn->src_reg, ((u32)insn->imm) >> 16, (u16)insn->imm);
 		} else if (is_mov_percpu_addr(insn)) {
@@ -369,7 +369,7 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				insn->code, class == BPF_JMP32 ? 'w' : 'r',
 				insn->dst_reg,
 				bpf_jmp_string[BPF_OP(insn->code) >> 4],
-				insn->imm, insn->off);
+				(u32)insn->imm, insn->off);
 		}
 	} else {
 		verbose(cbs->private_data, "(%02x) %s\n",
diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 2636655ac1808..6b14cbfa58aa2 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -253,7 +253,7 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
 				if (btf_kflag(t))
 					printf("\n\t'%s' val=%d", name, v->val);
 				else
-					printf("\n\t'%s' val=%u", name, v->val);
+					printf("\n\t'%s' val=%u", name, (__u32)v->val);
 			}
 		}
 		if (json_output)
@@ -1022,7 +1022,7 @@ static int do_dump(int argc, char **argv)
 			for (i = 0; i < root_type_cnt; i++) {
 				if (root_type_ids[i] == root_id) {
 					err = -EINVAL;
-					p_err("duplicate root_id %d supplied", root_id);
+					p_err("duplicate root_id %u supplied", root_id);
 					goto done;
 				}
 			}
@@ -1132,7 +1132,7 @@ build_btf_type_table(struct hashmap *tab, enum bpf_obj_type type,
 			break;
 		default:
 			err = -1;
-			p_err("unexpected object type: %d", type);
+			p_err("unexpected object type: %u", type);
 			goto err_free;
 		}
 		if (err) {
@@ -1155,7 +1155,7 @@ build_btf_type_table(struct hashmap *tab, enum bpf_obj_type type,
 			break;
 		default:
 			err = -1;
-			p_err("unexpected object type: %d", type);
+			p_err("unexpected object type: %u", type);
 			goto err_free;
 		}
 		if (fd < 0) {
@@ -1188,7 +1188,7 @@ build_btf_type_table(struct hashmap *tab, enum bpf_obj_type type,
 			break;
 		default:
 			err = -1;
-			p_err("unexpected object type: %d", type);
+			p_err("unexpected object type: %u", type);
 			goto err_free;
 		}
 		if (!btf_id)
@@ -1254,12 +1254,12 @@ show_btf_plain(struct bpf_btf_info *info, int fd,
 
 	n = 0;
 	hashmap__for_each_key_entry(btf_prog_table, entry, info->id) {
-		printf("%s%lu", n++ == 0 ? "  prog_ids " : ",", entry->value);
+		printf("%s%lu", n++ == 0 ? "  prog_ids " : ",", (unsigned long)entry->value);
 	}
 
 	n = 0;
 	hashmap__for_each_key_entry(btf_map_table, entry, info->id) {
-		printf("%s%lu", n++ == 0 ? "  map_ids " : ",", entry->value);
+		printf("%s%lu", n++ == 0 ? "  map_ids " : ",", (unsigned long)entry->value);
 	}
 
 	emit_obj_refs_plain(refs_table, info->id, "\n\tpids ");
diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index 527fe867a8fbd..4e896d8a2416e 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -653,7 +653,7 @@ static int __btf_dumper_type_only(const struct btf *btf, __u32 type_id,
 	case BTF_KIND_ARRAY:
 		array = (struct btf_array *)(t + 1);
 		BTF_PRINT_TYPE(array->type);
-		BTF_PRINT_ARG("[%d]", array->nelems);
+		BTF_PRINT_ARG("[%u]", array->nelems);
 		break;
 	case BTF_KIND_PTR:
 		BTF_PRINT_TYPE(t->type);
diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index 9af426d432993..93b139bfb9880 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -191,7 +191,7 @@ static int show_bpf_prog(int id, enum bpf_attach_type attach_type,
 		if (attach_btf_name)
 			printf(" %-15s", attach_btf_name);
 		else if (info.attach_btf_id)
-			printf(" attach_btf_obj_id=%d attach_btf_id=%d",
+			printf(" attach_btf_obj_id=%u attach_btf_id=%u",
 			       info.attach_btf_obj_id, info.attach_btf_id);
 		printf("\n");
 	}
diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 9b75639434b81..b921231d602e4 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -713,7 +713,7 @@ ifindex_to_arch(__u32 ifindex, __u64 ns_dev, __u64 ns_ino, const char **opt)
 	int vendor_id;
 
 	if (!ifindex_to_name_ns(ifindex, ns_dev, ns_ino, devname)) {
-		p_err("Can't get net device name for ifindex %d: %s", ifindex,
+		p_err("Can't get net device name for ifindex %u: %s", ifindex,
 		      strerror(errno));
 		return NULL;
 	}
@@ -738,7 +738,7 @@ ifindex_to_arch(__u32 ifindex, __u64 ns_dev, __u64 ns_ino, const char **opt)
 	/* No NFP support in LLVM, we have no valid triple to return. */
 	default:
 		p_err("Can't get arch name for device vendor id 0x%04x",
-		      vendor_id);
+		      (unsigned int)vendor_id);
 		return NULL;
 	}
 }
diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
index c032d2c6ab6d5..8895b4e1f6903 100644
--- a/tools/bpf/bpftool/jit_disasm.c
+++ b/tools/bpf/bpftool/jit_disasm.c
@@ -343,7 +343,8 @@ int disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
 {
 	const struct bpf_line_info *linfo = NULL;
 	unsigned int nr_skip = 0;
-	int count, i, pc = 0;
+	int count, i;
+	unsigned int pc = 0;
 	disasm_ctx_t ctx;
 
 	if (!len)
diff --git a/tools/bpf/bpftool/map_perf_ring.c b/tools/bpf/bpftool/map_perf_ring.c
index 21d7d447e1f3b..552b4ca40c27c 100644
--- a/tools/bpf/bpftool/map_perf_ring.c
+++ b/tools/bpf/bpftool/map_perf_ring.c
@@ -91,15 +91,15 @@ print_bpf_output(void *private_data, int cpu, struct perf_event_header *event)
 		jsonw_end_object(json_wtr);
 	} else {
 		if (e->header.type == PERF_RECORD_SAMPLE) {
-			printf("== @%lld.%09lld CPU: %d index: %d =====\n",
+			printf("== @%llu.%09llu CPU: %d index: %d =====\n",
 			       e->time / 1000000000ULL, e->time % 1000000000ULL,
 			       cpu, idx);
 			fprint_hex(stdout, e->data, e->size, " ");
 			printf("\n");
 		} else if (e->header.type == PERF_RECORD_LOST) {
-			printf("lost %lld events\n", lost->lost);
+			printf("lost %llu events\n", lost->lost);
 		} else {
-			printf("unknown event type=%d size=%d\n",
+			printf("unknown event type=%u size=%u\n",
 			       e->header.type, e->header.size);
 		}
 	}
diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index d2242d9f84411..64f958f437b01 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -476,7 +476,7 @@ static void __show_dev_tc_bpf(const struct ip_devname_ifindex *dev,
 	for (i = 0; i < optq.count; i++) {
 		NET_START_OBJECT;
 		NET_DUMP_STR("devname", "%s", dev->devname);
-		NET_DUMP_UINT("ifindex", "(%u)", dev->ifindex);
+		NET_DUMP_UINT("ifindex", "(%u)", (unsigned int)dev->ifindex);
 		NET_DUMP_STR("kind", " %s", attach_loc_strings[loc]);
 		ret = __show_dev_tc_bpf_name(prog_ids[i], prog_name,
 					     sizeof(prog_name));
@@ -831,7 +831,7 @@ static void show_link_netfilter(void)
 		if (err) {
 			if (errno == ENOENT)
 				break;
-			p_err("can't get next link: %s (id %d)", strerror(errno), id);
+			p_err("can't get next link: %s (id %u)", strerror(errno), id);
 			break;
 		}
 
diff --git a/tools/bpf/bpftool/netlink_dumper.c b/tools/bpf/bpftool/netlink_dumper.c
index 5f65140b003b2..0a3c7e96c797a 100644
--- a/tools/bpf/bpftool/netlink_dumper.c
+++ b/tools/bpf/bpftool/netlink_dumper.c
@@ -45,7 +45,7 @@ static int do_xdp_dump_one(struct nlattr *attr, unsigned int ifindex,
 	NET_START_OBJECT;
 	if (name)
 		NET_DUMP_STR("devname", "%s", name);
-	NET_DUMP_UINT("ifindex", "(%d)", ifindex);
+	NET_DUMP_UINT("ifindex", "(%u)", ifindex);
 
 	if (mode == XDP_ATTACHED_MULTI) {
 		if (json_output) {
@@ -74,7 +74,7 @@ int do_xdp_dump(struct ifinfomsg *ifinfo, struct nlattr **tb)
 	if (!tb[IFLA_XDP])
 		return 0;
 
-	return do_xdp_dump_one(tb[IFLA_XDP], ifinfo->ifi_index,
+	return do_xdp_dump_one(tb[IFLA_XDP], (unsigned int)ifinfo->ifi_index,
 			       libbpf_nla_getattr_str(tb[IFLA_IFNAME]));
 }
 
@@ -168,7 +168,7 @@ int do_filter_dump(struct tcmsg *info, struct nlattr **tb, const char *kind,
 		NET_START_OBJECT;
 		if (devname[0] != '\0')
 			NET_DUMP_STR("devname", "%s", devname);
-		NET_DUMP_UINT("ifindex", "(%u)", ifindex);
+		NET_DUMP_UINT("ifindex", "(%u)", (unsigned int)ifindex);
 		NET_DUMP_STR("kind", " %s", kind);
 		ret = do_bpf_filter_dump(tb[TCA_OPTIONS]);
 		NET_END_OBJECT_FINAL;
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 52ffb74ae4e89..f010295350be5 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -521,10 +521,10 @@ static void print_prog_header_plain(struct bpf_prog_info *info, int fd)
 	print_dev_plain(info->ifindex, info->netns_dev, info->netns_ino);
 	printf("%s", info->gpl_compatible ? "  gpl" : "");
 	if (info->run_time_ns)
-		printf(" run_time_ns %lld run_cnt %lld",
+		printf(" run_time_ns %llu run_cnt %llu",
 		       info->run_time_ns, info->run_cnt);
 	if (info->recursion_misses)
-		printf(" recursion_misses %lld", info->recursion_misses);
+		printf(" recursion_misses %llu", info->recursion_misses);
 	printf("\n");
 }
 
@@ -569,7 +569,7 @@ static void print_prog_plain(struct bpf_prog_info *info, int fd, bool orphaned)
 	}
 
 	if (info->btf_id)
-		printf("\n\tbtf_id %d", info->btf_id);
+		printf("\n\tbtf_id %u", info->btf_id);
 
 	emit_obj_refs_plain(refs_table, info->id, "\n\tpids ");
 
@@ -1164,7 +1164,7 @@ static int get_run_data(const char *fname, void **data_ptr, unsigned int *size)
 		}
 		if (nb_read > buf_size - block_size) {
 			if (buf_size == UINT32_MAX) {
-				p_err("data_in/ctx_in is too long (max: %d)",
+				p_err("data_in/ctx_in is too long (max: %u)",
 				      UINT32_MAX);
 				goto err_free;
 			}
@@ -2252,7 +2252,7 @@ static char *profile_target_name(int tgt_fd)
 
 	t = btf__type_by_id(btf, func_info.type_id);
 	if (!t) {
-		p_err("btf %d doesn't have type %d",
+		p_err("btf %u doesn't have type %u",
 		      info.btf_id, func_info.type_id);
 		goto out;
 	}
@@ -2330,7 +2330,7 @@ static int profile_open_perf_events(struct profiler_bpf *obj)
 			continue;
 		for (cpu = 0; cpu < obj->rodata->num_cpu; cpu++) {
 			if (profile_open_perf_event(m, cpu, map_fd)) {
-				p_err("failed to create event %s on cpu %d",
+				p_err("failed to create event %s on cpu %u",
 				      metrics[m].name, cpu);
 				return -1;
 			}
diff --git a/tools/bpf/bpftool/tracelog.c b/tools/bpf/bpftool/tracelog.c
index bf1f022127972..31d806e3bdaaa 100644
--- a/tools/bpf/bpftool/tracelog.c
+++ b/tools/bpf/bpftool/tracelog.c
@@ -78,7 +78,7 @@ static bool get_tracefs_pipe(char *mnt)
 		return false;
 
 	/* Allow room for NULL terminating byte and pipe file name */
-	snprintf(format, sizeof(format), "%%*s %%%zds %%99s %%*s %%*d %%*d\\n",
+	snprintf(format, sizeof(format), "%%*s %%%zus %%99s %%*s %%*d %%*d\\n",
 		 PATH_MAX - strlen(pipe_name) - 1);
 	while (fscanf(fp, format, mnt, type) == 2)
 		if (strcmp(type, fstype) == 0) {
diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
index d0094345fb2bc..5e7cb8b36fef2 100644
--- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -199,13 +199,13 @@ static const char *print_imm(void *private_data,
 
 	if (insn->src_reg == BPF_PSEUDO_MAP_FD)
 		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
-			 "map[id:%u]", insn->imm);
+			 "map[id:%d]", insn->imm);
 	else if (insn->src_reg == BPF_PSEUDO_MAP_VALUE)
 		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
-			 "map[id:%u][0]+%u", insn->imm, (insn + 1)->imm);
+			 "map[id:%d][0]+%d", insn->imm, (insn + 1)->imm);
 	else if (insn->src_reg == BPF_PSEUDO_MAP_IDX_VALUE)
 		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
-			 "map[idx:%u]+%u", insn->imm, (insn + 1)->imm);
+			 "map[idx:%d]+%d", insn->imm, (insn + 1)->imm);
 	else if (insn->src_reg == BPF_PSEUDO_FUNC)
 		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
 			 "subprog[%+d]", insn->imm);
-- 
2.39.5


