Return-Path: <bpf+bounces-4462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A5574B5D3
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 19:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2FD7280C48
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 17:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0341C1774B;
	Fri,  7 Jul 2023 17:26:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF331772D;
	Fri,  7 Jul 2023 17:26:04 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF41A269A;
	Fri,  7 Jul 2023 10:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=laAMZhRKOOyye11GEPeKSO0s1WF7amF25EtYifoxIr4=; b=ODWcbGSB/BHe/KjT2bbTdUE+2x
	3vn28ibYnIG8lRiFoc3a3dLJ4A4PdTnCRLo5QRNbx+I13YjgXomsO0fX3mjbqJ6E+CHaeQG6SkUmB
	VO5AigdlyGDoqoqbiEW+h89/UoBj8iXuNNjvVadn4xW2WtJzK1jc2bHvxJmUQ4I89EPea7J/IjIcN
	kqhPHI7vOv0+A8xTG7mM+ZfX/adtHoyrQ6VZx9BfPEO/ylTH+mzjAbCatDhgdUYUL4PX/0cGJ3npN
	hUQSyViX8eQLlYv678Gc4ubRnPTaC4mFmihVWtGwafuDBePX4eFzpSthLYJgC/SjfJ4uPh0JKCoBH
	ON7vSQ2A==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qHpCd-000AwW-Bp; Fri, 07 Jul 2023 19:25:07 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: andrii@kernel.org,
	martin.lau@linux.dev,
	razor@blackwall.org,
	sdf@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	dxu@dxuuu.xyz,
	joe@cilium.io,
	toke@kernel.org,
	davem@davemloft.net,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v3 1/8] bpf: Add generic attach/detach/query API for multi-progs
Date: Fri,  7 Jul 2023 19:24:48 +0200
Message-Id: <20230707172455.7634-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230707172455.7634-1-daniel@iogearbox.net>
References: <20230707172455.7634-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26962/Fri Jul  7 09:29:02 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This adds a generic layer called bpf_mprog which can be reused by different
attachment layers to enable multi-program attachment and dependency resolution.
In-kernel users of the bpf_mprog don't need to care about the dependency
resolution internals, they can just consume it with few API calls.

The initial idea of having a generic API sparked out of discussion [0] from an
earlier revision of this work where tc's priority was reused and exposed via
BPF uapi as a way to coordinate dependencies among tc BPF programs, similar
as-is for classic tc BPF. The feedback was that priority provides a bad user
experience and is hard to use [1], e.g.:

  I cannot help but feel that priority logic copy-paste from old tc, netfilter
  and friends is done because "that's how things were done in the past". [...]
  Priority gets exposed everywhere in uapi all the way to bpftool when it's
  right there for users to understand. And that's the main problem with it.

  The user don't want to and don't need to be aware of it, but uapi forces them
  to pick the priority. [...] Your cover letter [0] example proves that in
  real life different service pick the same priority. They simply don't know
  any better. Priority is an unnecessary magic that apps _have_ to pick, so
  they just copy-paste and everyone ends up using the same.

The course of the discussion showed more and more the need for a generic,
reusable API where the "same look and feel" can be applied for various other
program types beyond just tc BPF, for example XDP today does not have multi-
program support in kernel, but also there was interest around this API for
improving management of cgroup program types. Such common multi-program
management concept is useful for BPF management daemons or user space BPF
applications coordinating internally about their attachments.

Both from Cilium and Meta side [2], we've collected the following requirements
for a generic attach/detach/query API for multi-progs which has been implemented
as part of this work:

  - Support prog-based attach/detach and link API
  - Dependency directives (can also be combined):
    - BPF_F_{BEFORE,AFTER} with relative_{fd,id} which can be {prog,link,none}
      - BPF_F_ID flag as {fd,id} toggle; the rationale for id is so that user
        space application does not need CAP_SYS_ADMIN to retrieve foreign fds
        via bpf_*_get_fd_by_id()
      - BPF_F_LINK flag as {prog,link} toggle
      - If relative_{fd,id} is none, then BPF_F_BEFORE will just prepend, and
        BPF_F_AFTER will just append for attaching
      - Enforced only at attach time
    - BPF_F_REPLACE with replace_bpf_fd which can be prog, links have their
      own infra for replacing their internal prog
    - If no flags are set, then it's default append behavior for attaching
  - Internal revision counter and optionally being able to pass expected_revision
  - User space application can query current state with revision, and pass it
    along for attachment to assert current state before doing updates
  - Query also gets extension for link_ids array and link_attach_flags:
    - prog_ids are always filled with program IDs
    - link_ids are filled with link IDs when link was used, otherwise 0
    - {prog,link}_attach_flags for holding {prog,link}-specific flags
  - Must be easy to integrate/reuse for in-kernel users

The uapi-side changes needed for supporting bpf_mprog are rather minimal,
consisting of the additions of the attachment flags, revision counter, and
expanding existing union with relative_{fd,id} member.

The bpf_mprog framework consists of an bpf_mprog_entry object which holds
an array of bpf_mprog_fp (fast-path structure). The bpf_mprog_cp (control-path
structure) is part of bpf_mprog_bundle. Both have been separated, so that
fast-path gets efficient packing of bpf_prog pointers for maximum cache
efficiency. Also, array has been chosen instead of linked list or other
structures to remove unnecessary indirections for a fast point-to-entry in
tc for BPF.

The bpf_mprog_entry comes as a pair via bpf_mprog_bundle so that in case of
updates the peer bpf_mprog_entry is populated and then just swapped which
avoids additional allocations that could otherwise fail, for example, in
detach case. bpf_mprog_{fp,cp} arrays are currently static, but they could
be converted to dynamic allocation if necessary at a point in future.
Locking is deferred to the in-kernel user of bpf_mprog, for example, in case
of tcx which uses this API in the next patch, it piggybacks on rtnl.

An extensive test suite for checking all aspects of this API for prog-based
attach/detach and link API comes as BPF selftests in this series.

Kudos also to Andrii Nakryiko for API discussions wrt Meta's BPF management.

  [0] https://lore.kernel.org/bpf/20221004231143.19190-1-daniel@iogearbox.net
  [1] https://lore.kernel.org/bpf/CAADnVQ+gEY3FjCR=+DmjDR4gp5bOYZUFJQXj4agKFHT9CQPZBw@mail.gmail.com
  [2] http://vger.kernel.org/bpfconf2023_material/tcx_meta_netdev_borkmann.pdf

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 MAINTAINERS                    |   1 +
 include/linux/bpf_mprog.h      | 233 ++++++++++++++++++
 include/uapi/linux/bpf.h       |  36 ++-
 kernel/bpf/Makefile            |   2 +-
 kernel/bpf/mprog.c             | 429 +++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  36 ++-
 6 files changed, 720 insertions(+), 17 deletions(-)
 create mode 100644 include/linux/bpf_mprog.h
 create mode 100644 kernel/bpf/mprog.c

diff --git a/MAINTAINERS b/MAINTAINERS
index acbe54087d1c..7e5ba799d1c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3736,6 +3736,7 @@ F:	include/linux/filter.h
 F:	include/linux/tnum.h
 F:	kernel/bpf/core.c
 F:	kernel/bpf/dispatcher.c
+F:	kernel/bpf/mprog.c
 F:	kernel/bpf/syscall.c
 F:	kernel/bpf/tnum.c
 F:	kernel/bpf/trampoline.c
diff --git a/include/linux/bpf_mprog.h b/include/linux/bpf_mprog.h
new file mode 100644
index 000000000000..a7a9b98df1ef
--- /dev/null
+++ b/include/linux/bpf_mprog.h
@@ -0,0 +1,233 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2023 Isovalent */
+#ifndef __BPF_MPROG_H
+#define __BPF_MPROG_H
+
+#include <linux/bpf.h>
+
+#define BPF_MPROG_KEEP	0
+#define BPF_MPROG_SWAP	1
+#define BPF_MPROG_FREE	2
+
+#define BPF_MPROG_MAX	64
+
+#define bpf_mprog_foreach_tuple(entry, fp, cp, t)			\
+	for (fp = &entry->fp_items[0], cp = &entry->parent->cp_items[0];\
+	     ({								\
+		t.prog = READ_ONCE(fp->prog);				\
+		t.link = cp->link;					\
+		t.prog;							\
+	      });							\
+	     fp++, cp++)
+
+#define bpf_mprog_foreach_prog(entry, fp, p)				\
+	for (fp = &entry->fp_items[0];					\
+	     (p = READ_ONCE(fp->prog));					\
+	     fp++)
+
+struct bpf_mprog_fp {
+	struct bpf_prog *prog;
+};
+
+struct bpf_mprog_cp {
+	struct bpf_link *link;
+};
+
+struct bpf_mprog_entry {
+	struct bpf_mprog_fp fp_items[BPF_MPROG_MAX];
+	struct bpf_mprog_bundle *parent;
+};
+
+struct bpf_mprog_bundle {
+	struct bpf_mprog_entry a;
+	struct bpf_mprog_entry b;
+	struct bpf_mprog_cp cp_items[BPF_MPROG_MAX];
+	struct rcu_head rcu;
+	struct bpf_prog *ref;
+	atomic64_t revision;
+	off_t off;
+	u32 count;
+};
+
+struct bpf_tuple {
+	struct bpf_prog *prog;
+	struct bpf_link *link;
+};
+
+static inline struct bpf_mprog_entry *
+bpf_mprog_peer(const struct bpf_mprog_entry *entry)
+{
+	if (entry == &entry->parent->a)
+		return &entry->parent->b;
+	else
+		return &entry->parent->a;
+}
+
+static inline struct bpf_mprog_entry *
+bpf_mprog_create(const size_t size, const off_t off)
+{
+	struct bpf_mprog_bundle *bundle;
+	void *ptr;
+
+	BUILD_BUG_ON(size < sizeof(*bundle) + off);
+	BUILD_BUG_ON(sizeof(bundle->a.fp_items[0]) > sizeof(u64));
+	BUILD_BUG_ON(ARRAY_SIZE(bundle->a.fp_items) !=
+		     ARRAY_SIZE(bundle->cp_items));
+
+	ptr = kzalloc(size, GFP_KERNEL);
+	if (ptr) {
+		bundle = ptr + off;
+		atomic64_set(&bundle->revision, 1);
+		bundle->off = off;
+		bundle->a.parent = bundle;
+		bundle->b.parent = bundle;
+		return &bundle->a;
+	}
+	return NULL;
+}
+
+void bpf_mprog_free_rcu(struct rcu_head *rcu);
+
+static inline void bpf_mprog_free(struct bpf_mprog_entry *entry)
+{
+	struct bpf_mprog_bundle *bundle = entry->parent;
+
+	call_rcu(&bundle->rcu, bpf_mprog_free_rcu);
+}
+
+static inline void bpf_mprog_mark_ref(struct bpf_mprog_entry *entry,
+				      struct bpf_tuple *tuple)
+{
+	WARN_ON_ONCE(entry->parent->ref);
+	if (!tuple->link)
+		entry->parent->ref = tuple->prog;
+}
+
+static inline void bpf_mprog_inc(struct bpf_mprog_entry *entry)
+{
+	entry->parent->count++;
+}
+
+static inline void bpf_mprog_dec(struct bpf_mprog_entry *entry)
+{
+	entry->parent->count--;
+}
+
+static inline int bpf_mprog_max(void)
+{
+	return ARRAY_SIZE(((struct bpf_mprog_entry *)NULL)->fp_items) - 1;
+}
+
+static inline int bpf_mprog_total(struct bpf_mprog_entry *entry)
+{
+	int total = entry->parent->count;
+
+	WARN_ON_ONCE(total > bpf_mprog_max());
+	return total;
+}
+
+static inline bool bpf_mprog_exists(struct bpf_mprog_entry *entry,
+				    struct bpf_prog *prog)
+{
+	const struct bpf_mprog_fp *fp;
+	const struct bpf_prog *tmp;
+
+	bpf_mprog_foreach_prog(entry, fp, tmp) {
+		if (tmp == prog)
+			return true;
+	}
+	return false;
+}
+
+static inline bool bpf_mprog_swap_entries(const int code)
+{
+	return code == BPF_MPROG_SWAP ||
+	       code == BPF_MPROG_FREE;
+}
+
+static inline void bpf_mprog_commit(struct bpf_mprog_entry *entry)
+{
+	atomic64_inc(&entry->parent->revision);
+	synchronize_rcu();
+	if (entry->parent->ref) {
+		bpf_prog_put(entry->parent->ref);
+		entry->parent->ref = NULL;
+	}
+}
+
+static inline u64 bpf_mprog_revision(struct bpf_mprog_entry *entry)
+{
+	return atomic64_read(&entry->parent->revision);
+}
+
+static inline void bpf_mprog_entry_clear(struct bpf_mprog_entry *entry)
+{
+	memset(entry->fp_items, 0, sizeof(entry->fp_items));
+}
+
+static inline void bpf_mprog_commit_cp(struct bpf_mprog_entry *entry,
+				       struct bpf_mprog_cp *cp_items)
+{
+	memcpy(entry->parent->cp_items, cp_items,
+	       sizeof(entry->parent->cp_items));
+}
+
+static inline void bpf_mprog_read_fp(struct bpf_mprog_entry *entry, u32 idx,
+				     struct bpf_mprog_fp **fp)
+{
+	*fp = &entry->fp_items[idx];
+}
+
+static inline void bpf_mprog_read_cp(struct bpf_mprog_entry *entry, u32 idx,
+				     struct bpf_mprog_cp **cp)
+{
+	*cp = &entry->parent->cp_items[idx];
+}
+
+static inline void bpf_mprog_read(struct bpf_mprog_entry *entry, u32 idx,
+				  struct bpf_mprog_fp **fp,
+				  struct bpf_mprog_cp **cp)
+{
+	bpf_mprog_read_fp(entry, idx, fp);
+	bpf_mprog_read_cp(entry, idx, cp);
+}
+
+static inline void bpf_mprog_write_fp(struct bpf_mprog_fp *fp,
+				      struct bpf_tuple *tuple)
+{
+	WRITE_ONCE(fp->prog, tuple->prog);
+}
+
+static inline void bpf_mprog_write_cp(struct bpf_mprog_cp *cp,
+				      struct bpf_tuple *tuple)
+{
+	cp->link = tuple->link;
+}
+
+static inline void bpf_mprog_write(struct bpf_mprog_fp *fp,
+				   struct bpf_mprog_cp *cp,
+				   struct bpf_tuple *tuple)
+{
+	bpf_mprog_write_fp(fp, tuple);
+	bpf_mprog_write_cp(cp, tuple);
+}
+
+static inline void bpf_mprog_copy(struct bpf_mprog_fp *fp_dst,
+				  struct bpf_mprog_cp *cp_dst,
+				  struct bpf_mprog_fp *fp_src,
+				  struct bpf_mprog_cp *cp_src)
+{
+	WRITE_ONCE(fp_dst->prog, READ_ONCE(fp_src->prog));
+	memcpy(cp_dst, cp_src, sizeof(*cp_src));
+}
+
+int bpf_mprog_attach(struct bpf_mprog_entry *entry, struct bpf_prog *prog_new,
+		     struct bpf_link *link, struct bpf_prog *prog_old,
+		     u32 flags, u32 object, u64 revision);
+int bpf_mprog_detach(struct bpf_mprog_entry *entry, struct bpf_prog *prog,
+		     struct bpf_link *link, u32 flags, u32 object, u64 revision);
+
+int bpf_mprog_query(const union bpf_attr *attr, union bpf_attr __user *uattr,
+		    struct bpf_mprog_entry *entry);
+
+#endif /* __BPF_MPROG_H */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 60a9d59beeab..74879c538f2b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1103,7 +1103,12 @@ enum bpf_link_type {
  */
 #define BPF_F_ALLOW_OVERRIDE	(1U << 0)
 #define BPF_F_ALLOW_MULTI	(1U << 1)
+/* Generic attachment flags. */
 #define BPF_F_REPLACE		(1U << 2)
+#define BPF_F_BEFORE		(1U << 3)
+#define BPF_F_AFTER		(1U << 4)
+#define BPF_F_ID		(1U << 5)
+#define BPF_F_LINK		BPF_F_LINK /* 1 << 13 */
 
 /* If BPF_F_STRICT_ALIGNMENT is used in BPF_PROG_LOAD command, the
  * verifier will perform strict alignment checking as if the kernel
@@ -1434,14 +1439,19 @@ union bpf_attr {
 	};
 
 	struct { /* anonymous struct used by BPF_PROG_ATTACH/DETACH commands */
-		__u32		target_fd;	/* container object to attach to */
-		__u32		attach_bpf_fd;	/* eBPF program to attach */
+		union {
+			__u32	target_fd;	/* target object to attach to or ... */
+			__u32	target_ifindex;	/* target ifindex */
+		};
+		__u32		attach_bpf_fd;
 		__u32		attach_type;
 		__u32		attach_flags;
-		__u32		replace_bpf_fd;	/* previously attached eBPF
-						 * program to replace if
-						 * BPF_F_REPLACE is used
-						 */
+		__u32		replace_bpf_fd;
+		union {
+			__u32	relative_fd;
+			__u32	relative_id;
+		};
+		__u64		expected_revision;
 	};
 
 	struct { /* anonymous struct used by BPF_PROG_TEST_RUN command */
@@ -1487,16 +1497,26 @@ union bpf_attr {
 	} info;
 
 	struct { /* anonymous struct used by BPF_PROG_QUERY command */
-		__u32		target_fd;	/* container object to query */
+		union {
+			__u32	target_fd;	/* target object to query or ... */
+			__u32	target_ifindex;	/* target ifindex */
+		};
 		__u32		attach_type;
 		__u32		query_flags;
 		__u32		attach_flags;
 		__aligned_u64	prog_ids;
-		__u32		prog_cnt;
+		union {
+			__u32	prog_cnt;
+			__u32	count;
+		};
+		__u32		:32;
 		/* output: per-program attach_flags.
 		 * not allowed to be set during effective query.
 		 */
 		__aligned_u64	prog_attach_flags;
+		__aligned_u64	link_ids;
+		__aligned_u64	link_attach_flags;
+		__u64		revision;
 	} query;
 
 	struct { /* anonymous struct used by BPF_RAW_TRACEPOINT_OPEN command */
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 1d3892168d32..1bea2eb912cd 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
-obj-$(CONFIG_BPF_SYSCALL) += disasm.o
+obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
 obj-$(CONFIG_BPF_JIT) += trampoline.o
 obj-$(CONFIG_BPF_SYSCALL) += btf.o memalloc.o
 obj-$(CONFIG_BPF_JIT) += dispatcher.o
diff --git a/kernel/bpf/mprog.c b/kernel/bpf/mprog.c
new file mode 100644
index 000000000000..8795dab5237a
--- /dev/null
+++ b/kernel/bpf/mprog.c
@@ -0,0 +1,429 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Isovalent */
+
+#include <linux/bpf.h>
+#include <linux/bpf_mprog.h>
+
+static int bpf_mprog_link(struct bpf_tuple *tuple,
+			  u32 object, u32 flags,
+			  enum bpf_prog_type type)
+{
+	bool id = flags & BPF_F_ID;
+	struct bpf_link *link;
+
+	if (id)
+		link = bpf_link_by_id(object);
+	else
+		link = bpf_link_get_from_fd(object);
+	if (IS_ERR(link))
+		return PTR_ERR(link);
+	if (type && link->prog->type != type) {
+		bpf_link_put(link);
+		return -EINVAL;
+	}
+
+	tuple->link = link;
+	tuple->prog = link->prog;
+	return 0;
+}
+
+static int bpf_mprog_prog(struct bpf_tuple *tuple,
+			  u32 object, u32 flags,
+			  enum bpf_prog_type type)
+{
+	bool id = flags & BPF_F_ID;
+	struct bpf_prog *prog;
+
+	if (id)
+		prog = bpf_prog_by_id(object);
+	else
+		prog = bpf_prog_get(object);
+	if (IS_ERR(prog)) {
+		if (!object && !id)
+			return 0;
+		return PTR_ERR(prog);
+	}
+	if (type && prog->type != type) {
+		bpf_prog_put(prog);
+		return -EINVAL;
+	}
+
+	tuple->link = NULL;
+	tuple->prog = prog;
+	return 0;
+}
+
+static int bpf_mprog_tuple_relative(struct bpf_tuple *tuple,
+				    u32 object, u32 flags,
+				    enum bpf_prog_type type)
+{
+	memset(tuple, 0, sizeof(*tuple));
+	if (flags & BPF_F_LINK)
+		return bpf_mprog_link(tuple, object, flags, type);
+	return bpf_mprog_prog(tuple, object, flags, type);
+}
+
+static void bpf_mprog_tuple_put(struct bpf_tuple *tuple)
+{
+	if (tuple->link)
+		bpf_link_put(tuple->link);
+	else if (tuple->prog)
+		bpf_prog_put(tuple->prog);
+}
+
+static int bpf_mprog_replace(struct bpf_mprog_entry *entry,
+			     struct bpf_tuple *ntuple, int idx)
+{
+	struct bpf_mprog_fp *fp;
+	struct bpf_mprog_cp *cp;
+	struct bpf_prog *oprog;
+
+	bpf_mprog_read(entry, idx, &fp, &cp);
+	oprog = READ_ONCE(fp->prog);
+	bpf_mprog_write(fp, cp, ntuple);
+	if (!ntuple->link) {
+		WARN_ON_ONCE(cp->link);
+		bpf_prog_put(oprog);
+	}
+	return BPF_MPROG_KEEP;
+}
+
+static int bpf_mprog_insert(struct bpf_mprog_entry *entry,
+			    struct bpf_tuple *ntuple, int idx, u32 flags)
+{
+	int i, j = 0, total = bpf_mprog_total(entry);
+	struct bpf_mprog_cp *cp, cpp[BPF_MPROG_MAX] = {};
+	struct bpf_mprog_fp *fp, *fpp;
+	struct bpf_mprog_entry *peer;
+
+	peer = bpf_mprog_peer(entry);
+	bpf_mprog_entry_clear(peer);
+	if (idx < 0) {
+		bpf_mprog_read_fp(peer, j, &fpp);
+		bpf_mprog_write_fp(fpp, ntuple);
+		bpf_mprog_write_cp(&cpp[j], ntuple);
+		j++;
+	}
+	for (i = 0; i <= total; i++) {
+		bpf_mprog_read_fp(peer, j, &fpp);
+		if (idx == i && (flags & BPF_F_AFTER)) {
+			bpf_mprog_write(fpp, &cpp[j], ntuple);
+			j++;
+			bpf_mprog_read_fp(peer, j, &fpp);
+		}
+		if (i < total) {
+			bpf_mprog_read(entry, i, &fp, &cp);
+			bpf_mprog_copy(fpp, &cpp[j], fp, cp);
+			j++;
+		}
+		if (idx == i && (flags & BPF_F_BEFORE)) {
+			bpf_mprog_read_fp(peer, j, &fpp);
+			bpf_mprog_write(fpp, &cpp[j], ntuple);
+			j++;
+		}
+	}
+	bpf_mprog_commit_cp(peer, cpp);
+	bpf_mprog_inc(peer);
+	return BPF_MPROG_SWAP;
+}
+
+static int bpf_mprog_tuple_confirm(struct bpf_mprog_entry *entry,
+				   struct bpf_tuple *dtuple, int idx)
+{
+	int first = 0, last = bpf_mprog_total(entry) - 1;
+	struct bpf_mprog_cp *cp;
+	struct bpf_mprog_fp *fp;
+	struct bpf_prog *prog;
+	struct bpf_link *link;
+
+	if (idx <= first)
+		bpf_mprog_read(entry, first, &fp, &cp);
+	else if (idx >= last)
+		bpf_mprog_read(entry, last, &fp, &cp);
+	else
+		bpf_mprog_read(entry, idx, &fp, &cp);
+
+	prog = READ_ONCE(fp->prog);
+	link = cp->link;
+	if (!dtuple->link && link)
+		return -EBUSY;
+
+	WARN_ON_ONCE(dtuple->prog && dtuple->prog != prog);
+	WARN_ON_ONCE(dtuple->link && dtuple->link != link);
+
+	dtuple->prog = prog;
+	dtuple->link = link;
+	return 0;
+}
+
+static int bpf_mprog_delete(struct bpf_mprog_entry *entry,
+			    struct bpf_tuple *dtuple, int idx)
+{
+	int i = 0, j, ret, total = bpf_mprog_total(entry);
+	struct bpf_mprog_cp *cp, cpp[BPF_MPROG_MAX] = {};
+	struct bpf_mprog_fp *fp, *fpp;
+	struct bpf_mprog_entry *peer;
+
+	ret = bpf_mprog_tuple_confirm(entry, dtuple, idx);
+	if (ret)
+		return ret;
+	peer = bpf_mprog_peer(entry);
+	bpf_mprog_entry_clear(peer);
+	if (idx < 0)
+		i++;
+	if (idx == total)
+		total--;
+	for (j = 0; i < total; i++) {
+		if (idx == i)
+			continue;
+		bpf_mprog_read_fp(peer, j, &fpp);
+		bpf_mprog_read(entry, i, &fp, &cp);
+		bpf_mprog_copy(fpp, &cpp[j], fp, cp);
+		j++;
+	}
+	bpf_mprog_commit_cp(peer, cpp);
+	bpf_mprog_dec(peer);
+	bpf_mprog_mark_ref(peer, dtuple);
+	return bpf_mprog_total(peer) ?
+	       BPF_MPROG_SWAP : BPF_MPROG_FREE;
+}
+
+static int bpf_mprog_pos_exact(struct bpf_mprog_entry *entry,
+			       struct bpf_tuple *tuple)
+{
+	struct bpf_mprog_fp *fp;
+	struct bpf_mprog_cp *cp;
+	int i;
+
+	for (i = 0; i < bpf_mprog_total(entry); i++) {
+		bpf_mprog_read(entry, i, &fp, &cp);
+		if (tuple->prog == READ_ONCE(fp->prog))
+			return tuple->link == cp->link ? i : -EBUSY;
+	}
+	return -ENOENT;
+}
+
+static int bpf_mprog_pos_before(struct bpf_mprog_entry *entry,
+				struct bpf_tuple *tuple)
+{
+	struct bpf_mprog_fp *fp;
+	struct bpf_mprog_cp *cp;
+	int i;
+
+	for (i = 0; i < bpf_mprog_total(entry); i++) {
+		bpf_mprog_read(entry, i, &fp, &cp);
+		if (tuple->prog == READ_ONCE(fp->prog) &&
+		    (!tuple->link || tuple->link == cp->link))
+			return i - 1;
+	}
+	return tuple->prog ? -ENOENT : -1;
+}
+
+static int bpf_mprog_pos_after(struct bpf_mprog_entry *entry,
+			       struct bpf_tuple *tuple)
+{
+	struct bpf_mprog_fp *fp;
+	struct bpf_mprog_cp *cp;
+	int i;
+
+	for (i = 0; i < bpf_mprog_total(entry); i++) {
+		bpf_mprog_read(entry, i, &fp, &cp);
+		if (tuple->prog == READ_ONCE(fp->prog) &&
+		    (!tuple->link || tuple->link == cp->link))
+			return i + 1;
+	}
+	return tuple->prog ? -ENOENT : bpf_mprog_total(entry);
+}
+
+int bpf_mprog_attach(struct bpf_mprog_entry *entry, struct bpf_prog *prog_new,
+		     struct bpf_link *link, struct bpf_prog *prog_old,
+		     u32 flags, u32 object, u64 revision)
+{
+	struct bpf_tuple rtuple, ntuple = {
+		.prog = prog_new,
+		.link = link,
+	}, otuple = {
+		.prog = prog_old,
+		.link = link,
+	};
+	int ret, idx = -2, tidx;
+
+	if (revision && revision != bpf_mprog_revision(entry))
+		return -ESTALE;
+	if (bpf_mprog_exists(entry, prog_new))
+		return -EEXIST;
+	ret = bpf_mprog_tuple_relative(&rtuple, object,
+				       flags & ~BPF_F_REPLACE,
+				       prog_new->type);
+	if (ret)
+		return ret;
+	if (flags & BPF_F_REPLACE) {
+		tidx = bpf_mprog_pos_exact(entry, &otuple);
+		if (tidx < 0) {
+			ret = tidx;
+			goto out;
+		}
+		idx = tidx;
+	}
+	if (flags & BPF_F_BEFORE) {
+		tidx = bpf_mprog_pos_before(entry, &rtuple);
+		if (tidx < -1 || (idx >= -1 && tidx != idx)) {
+			ret = tidx < -1 ? tidx : -EDOM;
+			goto out;
+		}
+		idx = tidx;
+	}
+	if (flags & BPF_F_AFTER) {
+		tidx = bpf_mprog_pos_after(entry, &rtuple);
+		if (tidx < 0 || (idx >= -1 && tidx != idx)) {
+			ret = tidx < 0 ? tidx : -EDOM;
+			goto out;
+		}
+		idx = tidx;
+	}
+	if (idx < -1) {
+		if (rtuple.prog || flags) {
+			ret = -EINVAL;
+			goto out;
+		}
+		idx = bpf_mprog_total(entry);
+		flags = BPF_F_AFTER;
+	}
+	if (idx >= bpf_mprog_max()) {
+		ret = -EDOM;
+		goto out;
+	}
+	if (flags & BPF_F_REPLACE)
+		ret = bpf_mprog_replace(entry, &ntuple, idx);
+	else
+		ret = bpf_mprog_insert(entry, &ntuple, idx, flags);
+out:
+	bpf_mprog_tuple_put(&rtuple);
+	return ret;
+}
+
+int bpf_mprog_detach(struct bpf_mprog_entry *entry, struct bpf_prog *prog,
+		     struct bpf_link *link, u32 flags, u32 object, u64 revision)
+{
+	struct bpf_tuple rtuple, dtuple = {
+		.prog = prog,
+		.link = link,
+	};
+	int ret, idx = -2, tidx;
+
+	if (flags & BPF_F_REPLACE)
+		return -EINVAL;
+	if (revision && revision != bpf_mprog_revision(entry))
+		return -ESTALE;
+	ret = bpf_mprog_tuple_relative(&rtuple, object, flags,
+				       prog ? prog->type :
+				       BPF_PROG_TYPE_UNSPEC);
+	if (ret)
+		return ret;
+	if (dtuple.prog) {
+		tidx = bpf_mprog_pos_exact(entry, &dtuple);
+		if (tidx < 0) {
+			ret = tidx;
+			goto out;
+		}
+		idx = tidx;
+	}
+	if (flags & BPF_F_BEFORE) {
+		tidx = bpf_mprog_pos_before(entry, &rtuple);
+		if (tidx < -1 || (idx >= -1 && tidx != idx)) {
+			ret = tidx < -1 ? tidx : -EDOM;
+			goto out;
+		}
+		idx = tidx;
+	}
+	if (flags & BPF_F_AFTER) {
+		tidx = bpf_mprog_pos_after(entry, &rtuple);
+		if (tidx < 0 || (idx >= -1 && tidx != idx)) {
+			ret = tidx < 0 ? tidx : -EDOM;
+			goto out;
+		}
+		idx = tidx;
+	}
+	if (idx < -1) {
+		if (rtuple.prog || flags) {
+			ret = -EINVAL;
+			goto out;
+		}
+		idx = bpf_mprog_total(entry);
+		flags = BPF_F_AFTER;
+	}
+	if (idx >= bpf_mprog_max()) {
+		ret = -EDOM;
+		goto out;
+	}
+	ret = bpf_mprog_delete(entry, &dtuple, idx);
+out:
+	bpf_mprog_tuple_put(&rtuple);
+	return ret;
+}
+
+int bpf_mprog_query(const union bpf_attr *attr, union bpf_attr __user *uattr,
+		    struct bpf_mprog_entry *entry)
+{
+	u32 __user *uprog_flags, *ulink_flags;
+	u32 __user *uprog_id, *ulink_id;
+	struct bpf_mprog_fp *fp;
+	struct bpf_mprog_cp *cp;
+	struct bpf_prog *prog;
+	const u32 flags = 0;
+	int i, ret = 0;
+	u32 id, count;
+	u64 revision;
+
+	if (attr->query.query_flags || attr->query.attach_flags)
+		return -EINVAL;
+	revision = bpf_mprog_revision(entry);
+	count = bpf_mprog_total(entry);
+	if (copy_to_user(&uattr->query.attach_flags, &flags, sizeof(flags)))
+		return -EFAULT;
+	if (copy_to_user(&uattr->query.revision, &revision, sizeof(revision)))
+		return -EFAULT;
+	if (copy_to_user(&uattr->query.count, &count, sizeof(count)))
+		return -EFAULT;
+	uprog_id = u64_to_user_ptr(attr->query.prog_ids);
+	uprog_flags = u64_to_user_ptr(attr->query.prog_attach_flags);
+	ulink_id = u64_to_user_ptr(attr->query.link_ids);
+	ulink_flags = u64_to_user_ptr(attr->query.link_attach_flags);
+	if (attr->query.count == 0 || !uprog_id || !count)
+		return 0;
+	if (attr->query.count < count) {
+		count = attr->query.count;
+		ret = -ENOSPC;
+	}
+	for (i = 0; i < bpf_mprog_max(); i++) {
+		bpf_mprog_read(entry, i, &fp, &cp);
+		prog = READ_ONCE(fp->prog);
+		if (!prog)
+			break;
+		id = prog->aux->id;
+		if (copy_to_user(uprog_id + i, &id, sizeof(id)))
+			return -EFAULT;
+		if (uprog_flags &&
+		    copy_to_user(uprog_flags + i, &flags, sizeof(flags)))
+			return -EFAULT;
+		id = cp->link ? cp->link->id : 0;
+		if (ulink_id &&
+		    copy_to_user(ulink_id + i, &id, sizeof(id)))
+			return -EFAULT;
+		if (ulink_flags &&
+		    copy_to_user(ulink_flags + i, &flags, sizeof(flags)))
+			return -EFAULT;
+		if (i + 1 == count)
+			break;
+	}
+	return ret;
+}
+
+void bpf_mprog_free_rcu(struct rcu_head *rcu)
+{
+	struct bpf_mprog_bundle *bundle =
+		container_of(rcu, struct bpf_mprog_bundle, rcu);
+	void *ptr = (void *)bundle - bundle->off;
+
+	kfree(ptr);
+}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 60a9d59beeab..74879c538f2b 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1103,7 +1103,12 @@ enum bpf_link_type {
  */
 #define BPF_F_ALLOW_OVERRIDE	(1U << 0)
 #define BPF_F_ALLOW_MULTI	(1U << 1)
+/* Generic attachment flags. */
 #define BPF_F_REPLACE		(1U << 2)
+#define BPF_F_BEFORE		(1U << 3)
+#define BPF_F_AFTER		(1U << 4)
+#define BPF_F_ID		(1U << 5)
+#define BPF_F_LINK		BPF_F_LINK /* 1 << 13 */
 
 /* If BPF_F_STRICT_ALIGNMENT is used in BPF_PROG_LOAD command, the
  * verifier will perform strict alignment checking as if the kernel
@@ -1434,14 +1439,19 @@ union bpf_attr {
 	};
 
 	struct { /* anonymous struct used by BPF_PROG_ATTACH/DETACH commands */
-		__u32		target_fd;	/* container object to attach to */
-		__u32		attach_bpf_fd;	/* eBPF program to attach */
+		union {
+			__u32	target_fd;	/* target object to attach to or ... */
+			__u32	target_ifindex;	/* target ifindex */
+		};
+		__u32		attach_bpf_fd;
 		__u32		attach_type;
 		__u32		attach_flags;
-		__u32		replace_bpf_fd;	/* previously attached eBPF
-						 * program to replace if
-						 * BPF_F_REPLACE is used
-						 */
+		__u32		replace_bpf_fd;
+		union {
+			__u32	relative_fd;
+			__u32	relative_id;
+		};
+		__u64		expected_revision;
 	};
 
 	struct { /* anonymous struct used by BPF_PROG_TEST_RUN command */
@@ -1487,16 +1497,26 @@ union bpf_attr {
 	} info;
 
 	struct { /* anonymous struct used by BPF_PROG_QUERY command */
-		__u32		target_fd;	/* container object to query */
+		union {
+			__u32	target_fd;	/* target object to query or ... */
+			__u32	target_ifindex;	/* target ifindex */
+		};
 		__u32		attach_type;
 		__u32		query_flags;
 		__u32		attach_flags;
 		__aligned_u64	prog_ids;
-		__u32		prog_cnt;
+		union {
+			__u32	prog_cnt;
+			__u32	count;
+		};
+		__u32		:32;
 		/* output: per-program attach_flags.
 		 * not allowed to be set during effective query.
 		 */
 		__aligned_u64	prog_attach_flags;
+		__aligned_u64	link_ids;
+		__aligned_u64	link_attach_flags;
+		__u64		revision;
 	} query;
 
 	struct { /* anonymous struct used by BPF_RAW_TRACEPOINT_OPEN command */
-- 
2.34.1


