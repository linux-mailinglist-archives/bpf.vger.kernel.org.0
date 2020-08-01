Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFA52353A7
	for <lists+bpf@lfdr.de>; Sat,  1 Aug 2020 19:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgHAREH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 1 Aug 2020 13:04:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46438 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727991AbgHAREH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 1 Aug 2020 13:04:07 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-YfhKI0EKPnCkBUiZjeaNYA-1; Sat, 01 Aug 2020 13:04:00 -0400
X-MC-Unique: YfhKI0EKPnCkBUiZjeaNYA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B5A610059A2;
        Sat,  1 Aug 2020 17:03:58 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 528E15F7D8;
        Sat,  1 Aug 2020 17:03:55 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        David Miller <davem@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Wenbo Zhang <ethercflow@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Florent Revest <revest@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v9 bpf-next 09/14] bpf: Add BTF_SET_START/END macros
Date:   Sat,  1 Aug 2020 19:03:17 +0200
Message-Id: <20200801170322.75218-10-jolsa@kernel.org>
In-Reply-To: <20200801170322.75218-1-jolsa@kernel.org>
References: <20200801170322.75218-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding support to define sorted set of BTF ID values.

Following defines sorted set of BTF ID values:

  BTF_SET_START(btf_allowlist_d_path)
  BTF_ID(func, vfs_truncate)
  BTF_ID(func, vfs_fallocate)
  BTF_ID(func, dentry_open)
  BTF_ID(func, vfs_getattr)
  BTF_ID(func, filp_close)
  BTF_SET_END(btf_allowlist_d_path)

It defines following 'struct btf_id_set' variable to access
values and count:

  struct btf_id_set btf_allowlist_d_path;

Adding 'allowed' callback to struct bpf_func_proto, to allow
verifier the check on allowed callers.

Adding btf_id_set_contains function, which will be used by
allowed callbacks to verify the caller's BTF ID value is
within allowed set.

Also removing extra '\' in __BTF_ID_LIST macro.

Added BTF_SET_START_GLOBAL macro for global sets.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h           |  4 +++
 include/linux/btf_ids.h       | 51 ++++++++++++++++++++++++++++++++++-
 kernel/bpf/btf.c              | 14 ++++++++++
 kernel/bpf/verifier.c         |  5 ++++
 tools/include/linux/btf_ids.h | 51 ++++++++++++++++++++++++++++++++++-
 5 files changed, 123 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8206d5e324be..865860d80d39 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -309,6 +309,7 @@ struct bpf_func_proto {
 						    * for this argument.
 						    */
 	int *ret_btf_id; /* return value btf_id */
+	bool (*allowed)(const struct bpf_prog *prog);
 };
 
 /* bpf_context is intentionally undefined structure. Pointer to bpf_context is
@@ -1849,4 +1850,7 @@ enum bpf_text_poke_type {
 int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 		       void *addr1, void *addr2);
 
+struct btf_id_set;
+bool btf_id_set_contains(struct btf_id_set *set, u32 id);
+
 #endif /* _LINUX_BPF_H */
diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 4867d549e3c1..210b086188a3 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -3,6 +3,11 @@
 #ifndef _LINUX_BTF_IDS_H
 #define _LINUX_BTF_IDS_H
 
+struct btf_id_set {
+	u32 cnt;
+	u32 ids[];
+};
+
 #ifdef CONFIG_DEBUG_INFO_BTF
 
 #include <linux/compiler.h> /* for __PASTE */
@@ -62,7 +67,7 @@ asm(							\
 ".pushsection " BTF_IDS_SECTION ",\"a\";       \n"	\
 "." #scope " " #name ";                        \n"	\
 #name ":;                                      \n"	\
-".popsection;                                  \n");	\
+".popsection;                                  \n");
 
 #define BTF_ID_LIST(name)				\
 __BTF_ID_LIST(name, local)				\
@@ -88,12 +93,56 @@ asm(							\
 ".zero 4                                       \n"	\
 ".popsection;                                  \n");
 
+/*
+ * The BTF_SET_START/END macros pair defines sorted list of
+ * BTF IDs plus its members count, with following layout:
+ *
+ * BTF_SET_START(list)
+ * BTF_ID(type1, name1)
+ * BTF_ID(type2, name2)
+ * BTF_SET_END(list)
+ *
+ * __BTF_ID__set__list:
+ * .zero 4
+ * list:
+ * __BTF_ID__type1__name1__3:
+ * .zero 4
+ * __BTF_ID__type2__name2__4:
+ * .zero 4
+ *
+ */
+#define __BTF_SET_START(name, scope)			\
+asm(							\
+".pushsection " BTF_IDS_SECTION ",\"a\";       \n"	\
+"." #scope " __BTF_ID__set__" #name ";         \n"	\
+"__BTF_ID__set__" #name ":;                    \n"	\
+".zero 4                                       \n"	\
+".popsection;                                  \n");
+
+#define BTF_SET_START(name)				\
+__BTF_ID_LIST(name, local)				\
+__BTF_SET_START(name, local)
+
+#define BTF_SET_START_GLOBAL(name)			\
+__BTF_ID_LIST(name, globl)				\
+__BTF_SET_START(name, globl)
+
+#define BTF_SET_END(name)				\
+asm(							\
+".pushsection " BTF_IDS_SECTION ",\"a\";      \n"	\
+".size __BTF_ID__set__" #name ", .-" #name "  \n"	\
+".popsection;                                 \n");	\
+extern struct btf_id_set name;
+
 #else
 
 #define BTF_ID_LIST(name) static u32 name[5];
 #define BTF_ID(prefix, name)
 #define BTF_ID_UNUSED
 #define BTF_ID_LIST_GLOBAL(name) u32 name[1];
+#define BTF_SET_START(name) static struct btf_id_set name = { 0 };
+#define BTF_SET_START_GLOBAL(name) static struct btf_id_set name = { 0 };
+#define BTF_SET_END(name)
 
 #endif /* CONFIG_DEBUG_INFO_BTF */
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index ba05b15ad599..c51caf508d3d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -21,6 +21,8 @@
 #include <linux/btf_ids.h>
 #include <linux/skmsg.h>
 #include <linux/perf_event.h>
+#include <linux/bsearch.h>
+#include <linux/btf_ids.h>
 #include <net/sock.h>
 
 /* BTF (BPF Type Format) is the meta data format which describes
@@ -4762,3 +4764,15 @@ u32 btf_id(const struct btf *btf)
 {
 	return btf->id;
 }
+
+static int btf_id_cmp_func(const void *a, const void *b)
+{
+	const int *pa = a, *pb = b;
+
+	return *pa - *pb;
+}
+
+bool btf_id_set_contains(struct btf_id_set *set, u32 id)
+{
+	return bsearch(&id, set->ids, set->cnt, sizeof(u32), btf_id_cmp_func) != NULL;
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb6ca19f282d..523c5ecc79dd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4781,6 +4781,11 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
 		return -EINVAL;
 	}
 
+	if (fn->allowed && !fn->allowed(env->prog)) {
+		verbose(env, "helper call is not allowed in probe\n");
+		return -EINVAL;
+	}
+
 	/* With LD_ABS/IND some JITs save/restore skb from r1. */
 	changes_data = bpf_helper_changes_pkt_data(fn->func);
 	if (changes_data && fn->arg1_type != ARG_PTR_TO_CTX) {
diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
index 4867d549e3c1..210b086188a3 100644
--- a/tools/include/linux/btf_ids.h
+++ b/tools/include/linux/btf_ids.h
@@ -3,6 +3,11 @@
 #ifndef _LINUX_BTF_IDS_H
 #define _LINUX_BTF_IDS_H
 
+struct btf_id_set {
+	u32 cnt;
+	u32 ids[];
+};
+
 #ifdef CONFIG_DEBUG_INFO_BTF
 
 #include <linux/compiler.h> /* for __PASTE */
@@ -62,7 +67,7 @@ asm(							\
 ".pushsection " BTF_IDS_SECTION ",\"a\";       \n"	\
 "." #scope " " #name ";                        \n"	\
 #name ":;                                      \n"	\
-".popsection;                                  \n");	\
+".popsection;                                  \n");
 
 #define BTF_ID_LIST(name)				\
 __BTF_ID_LIST(name, local)				\
@@ -88,12 +93,56 @@ asm(							\
 ".zero 4                                       \n"	\
 ".popsection;                                  \n");
 
+/*
+ * The BTF_SET_START/END macros pair defines sorted list of
+ * BTF IDs plus its members count, with following layout:
+ *
+ * BTF_SET_START(list)
+ * BTF_ID(type1, name1)
+ * BTF_ID(type2, name2)
+ * BTF_SET_END(list)
+ *
+ * __BTF_ID__set__list:
+ * .zero 4
+ * list:
+ * __BTF_ID__type1__name1__3:
+ * .zero 4
+ * __BTF_ID__type2__name2__4:
+ * .zero 4
+ *
+ */
+#define __BTF_SET_START(name, scope)			\
+asm(							\
+".pushsection " BTF_IDS_SECTION ",\"a\";       \n"	\
+"." #scope " __BTF_ID__set__" #name ";         \n"	\
+"__BTF_ID__set__" #name ":;                    \n"	\
+".zero 4                                       \n"	\
+".popsection;                                  \n");
+
+#define BTF_SET_START(name)				\
+__BTF_ID_LIST(name, local)				\
+__BTF_SET_START(name, local)
+
+#define BTF_SET_START_GLOBAL(name)			\
+__BTF_ID_LIST(name, globl)				\
+__BTF_SET_START(name, globl)
+
+#define BTF_SET_END(name)				\
+asm(							\
+".pushsection " BTF_IDS_SECTION ",\"a\";      \n"	\
+".size __BTF_ID__set__" #name ", .-" #name "  \n"	\
+".popsection;                                 \n");	\
+extern struct btf_id_set name;
+
 #else
 
 #define BTF_ID_LIST(name) static u32 name[5];
 #define BTF_ID(prefix, name)
 #define BTF_ID_UNUSED
 #define BTF_ID_LIST_GLOBAL(name) u32 name[1];
+#define BTF_SET_START(name) static struct btf_id_set name = { 0 };
+#define BTF_SET_START_GLOBAL(name) static struct btf_id_set name = { 0 };
+#define BTF_SET_END(name)
 
 #endif /* CONFIG_DEBUG_INFO_BTF */
 
-- 
2.25.4

