Return-Path: <bpf+bounces-9178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE44A7915B0
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 12:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 671F0280F21
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 10:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2791FC6;
	Mon,  4 Sep 2023 10:26:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA487E
	for <bpf@vger.kernel.org>; Mon,  4 Sep 2023 10:26:24 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45E06E6;
	Mon,  4 Sep 2023 03:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=1uNL0
	BPTOj1HVeuyaXcl4CbwoDH2iZ/vx7oaKm4Km+o=; b=YrIMSTPtaXjzn821oMoho
	tCU1ULmdLBu/5HvLXprvBDPxJFsv71WUja4leOXiYFqJCWIPmLKyqb4qknt7NQjG
	XCYvbA+mg+Ng2CI3ZyR0w/ud+dLONTRcUGYXiqPh7rHgmgMDJrR7OZT/RNJpuoyo
	eXjpN1zO1L8DofP6Cbldt8=
Received: from localhost.localdomain (unknown [111.35.184.199])
	by zwqz-smtp-mta-g1-0 (Coremail) with SMTP id _____wCXywR6sPVkc_CRBA--.63070S4;
	Mon, 04 Sep 2023 18:25:16 +0800 (CST)
From: David Wang <00107082@163.com>
To: fw@strlen.de
Cc: David Wang <00107082@163.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] samples/bpf: Add sample usage for BPF_PROG_TYPE_NETFILTER
Date: Mon,  4 Sep 2023 18:21:28 +0800
Message-Id: <20230904102128.11476-1-00107082@163.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXywR6sPVkc_CRBA--.63070S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3GrWxJFW3Zry7uFW5KFWkXrb_yoWxWr4rpF
	WrG345Gr48Xa9xJF95Gr4xCryagws5uF17CF93Gry7ArsrXr9xKa1rKrW0kF45trZrKr4a
	qFyYkayrCrs7X3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE8nYDUUUUU=
X-Originating-IP: [111.35.184.199]
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiTA7gqmI0azHP+AAAsz
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
	RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This sample code implements a simple ipv4
blacklist via the new bpf type BPF_PROG_TYPE_NETFILTER,
which was introduced in 6.4.

The bpf program drops package if destination ip address
hits a match in the map of type BPF_MAP_TYPE_LPM_TRIE,

The userspace code would load the bpf program,
attach it to netfilter's FORWARD/OUTPUT hook,
and then write ip patterns into the bpf map.

Signed-off-by: David Wang <00107082@163.com>
---
 samples/bpf/Makefile                      |  3 +
 samples/bpf/netfilter_ip4_blacklist.bpf.c | 62 +++++++++++++++
 samples/bpf/netfilter_ip4_blacklist.c     | 96 +++++++++++++++++++++++
 3 files changed, 161 insertions(+)
 create mode 100644 samples/bpf/netfilter_ip4_blacklist.bpf.c
 create mode 100644 samples/bpf/netfilter_ip4_blacklist.c

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 4ccf4236031c..ff027ea5ce24 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -46,6 +46,7 @@ tprogs-y += xdp_fwd
 tprogs-y += task_fd_query
 tprogs-y += ibumad
 tprogs-y += hbm
+tprogs-y += netfilter_ip4_blacklist
 
 # Libbpf dependencies
 LIBBPF_SRC = $(TOOLS_PATH)/lib/bpf
@@ -96,6 +97,7 @@ xdp_fwd-objs := xdp_fwd_user.o
 task_fd_query-objs := task_fd_query_user.o $(TRACE_HELPERS)
 ibumad-objs := ibumad_user.o
 hbm-objs := hbm.o $(CGROUP_HELPERS)
+netfilter_ip4_blacklist-objs := netfilter_ip4_blacklist.o
 
 xdp_router_ipv4-objs := xdp_router_ipv4_user.o $(XDP_SAMPLE)
 
@@ -149,6 +151,7 @@ always-y += task_fd_query_kern.o
 always-y += ibumad_kern.o
 always-y += hbm_out_kern.o
 always-y += hbm_edt_kern.o
+always-y += netfilter_ip4_blacklist.bpf.o
 
 ifeq ($(ARCH), arm)
 # Strip all except -D__LINUX_ARM_ARCH__ option needed to handle linux
diff --git a/samples/bpf/netfilter_ip4_blacklist.bpf.c b/samples/bpf/netfilter_ip4_blacklist.bpf.c
new file mode 100644
index 000000000000..d315d64fda7f
--- /dev/null
+++ b/samples/bpf/netfilter_ip4_blacklist.bpf.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+
+#define NF_DROP 0
+#define NF_ACCEPT 1
+
+int bpf_dynptr_from_skb(struct sk_buff *skb,
+		__u64 flags, struct bpf_dynptr *ptr__uninit) __ksym;
+void *bpf_dynptr_slice(const struct bpf_dynptr *ptr,
+		uint32_t offset, void *buffer, uint32_t buffer__sz) __ksym;
+
+
+struct ipv4_lpm_key {
+	__u32 prefixlen;
+	__u32 data;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_LPM_TRIE);
+	__type(key, struct ipv4_lpm_key);
+	__type(value, __u32);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__uint(max_entries, 200);
+} ipv4_lpm_map SEC(".maps");
+
+
+SEC("netfilter")
+int netfilter_ip4block(struct bpf_nf_ctx *ctx)
+{
+	struct sk_buff *skb = ctx->skb;
+	struct bpf_dynptr ptr;
+	struct iphdr *p, iph = {};
+	struct ipv4_lpm_key key;
+	__u32 *pvalue;
+
+	if (skb->len <= 20 || bpf_dynptr_from_skb(skb, 0, &ptr))
+		return NF_ACCEPT;
+	p = bpf_dynptr_slice(&ptr, 0, &iph, sizeof(iph));
+	if (!p)
+		return NF_ACCEPT;
+
+	/* ip4 only */
+	if (p->version != 4)
+		return NF_ACCEPT;
+
+	/* search p->daddr in trie */
+	key.prefixlen = 32;
+	key.data = p->daddr;
+	pvalue = bpf_map_lookup_elem(&ipv4_lpm_map, &key);
+	if (pvalue) {
+		/* cat /sys/kernel/debug/tracing/trace_pipe */
+		bpf_printk("rule matched with %d...\n", *pvalue);
+		return NF_DROP;
+	}
+	return NF_ACCEPT;
+}
+
+char _license[] SEC("license") = "GPL";
+
diff --git a/samples/bpf/netfilter_ip4_blacklist.c b/samples/bpf/netfilter_ip4_blacklist.c
new file mode 100644
index 000000000000..bb7b26e5e06d
--- /dev/null
+++ b/samples/bpf/netfilter_ip4_blacklist.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <unistd.h>
+#include <asm/unistd.h>
+#include <bpf/libbpf.h>
+#include <bpf/bpf.h>
+#include <linux/netfilter.h>
+
+
+static inline int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr, unsigned int size)
+{
+	return syscall(__NR_bpf, cmd, attr, size);
+}
+struct ipv4_lpm_key {
+	__u32 prefixlen;
+	__u32 data;
+};
+
+int main(int argc, char **argv)
+{
+	int prog_fd, map_fd;
+	int err;
+	struct bpf_object *obj;
+	struct bpf_program *prog;
+	union bpf_attr attr = { };
+
+	obj = bpf_object__open_file("./netfilter_ip4_blacklist.bpf.o", NULL);
+	if (libbpf_get_error(obj)) {
+		printf("fail to open bpf file\n");
+		return 1;
+	}
+	prog = bpf_object__find_program_by_name(obj, "netfilter_ip4block");
+	if (!prog) {
+		printf("fail to find bpf program\n");
+		return 1;
+	}
+	bpf_program__set_type(prog, BPF_PROG_TYPE_NETFILTER);
+	if (bpf_object__load(obj)) {
+		printf("loading BPF object file failed\n");
+		return 1;
+	}
+	map_fd = bpf_object__find_map_fd_by_name(obj, "ipv4_lpm_map");
+	if (map_fd < 0) {
+		printf("Fail to locate trie ipv4_lpm_map\n");
+		return 1;
+	}
+	/* attach to netfilter forward handler */
+	prog_fd = bpf_program__fd(prog);
+	attr.link_create.prog_fd = prog_fd;
+	attr.link_create.attach_type = BPF_NETFILTER;
+	attr.link_create.netfilter.pf = NFPROTO_IPV4;
+	attr.link_create.netfilter.hooknum = NF_INET_FORWARD;
+	attr.link_create.netfilter.priority = -128;
+	err = sys_bpf(BPF_LINK_CREATE, &attr, sizeof(attr));
+	if (err < 0) {
+		perror("Fail to link bpf program to netfilter forward hook\n");
+		return 1;
+	}
+	/* attach to netfilter output handler */
+	attr.link_create.netfilter.hooknum = NF_INET_LOCAL_OUT;
+	err = sys_bpf(BPF_LINK_CREATE, &attr, sizeof(attr));
+	if (err < 0) {
+		perror("Fail to link bpf program to netfilter output hook\n");
+		return 1;
+	}
+	printf("bpf program/map loaded....\n");
+	/* add rules */
+	{
+		struct ipv4_lpm_key key;
+		__u32 value = 0;
+		__u8 *p = (__u8 *) &key.data;
+		/* block 192.168.11.107/32 */
+		key.prefixlen = 32;
+		/* same as key.data = 0x6B0BA8C0; on a little-endian machine */
+		p[0] = 192;
+		p[1] = 168;
+		p[2] = 11;
+		p[3] = 107;
+		bpf_map_update_elem(map_fd, &key, &value, BPF_ANY);
+		/* block 192.168.11.107/24 */
+		key.prefixlen = 24;
+		value++;
+		bpf_map_update_elem(map_fd, &key, &value, BPF_ANY);
+		/* block 192.168.11.107/27 */
+		key.prefixlen = 27;
+		value++;
+		bpf_map_update_elem(map_fd, &key, &value, BPF_ANY);
+		/* remove rule */
+		/* bpf_map_delete_elem(map_fd, &key); */
+		printf("rules inserted, ready to work\n");
+	}
+	while (1)
+		sleep(600);
+	return 0;
+}
-- 
2.20.1


