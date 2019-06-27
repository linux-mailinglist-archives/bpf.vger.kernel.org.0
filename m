Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E411558B85
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2019 22:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfF0UTt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jun 2019 16:19:49 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:8752 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726622AbfF0UTs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 27 Jun 2019 16:19:48 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RKJTW4008892
        for <bpf@vger.kernel.org>; Thu, 27 Jun 2019 13:19:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=eSjXJUSGA9JRPj7CwYQTgXNWFMgJcxgXWwLGVWh0pyc=;
 b=FLLH/KWT3An1USKQzvhMU6FAqvCoqqTEeDhx+7gjK9HLZSm7kpG9Rq5HXJNXQEVdmIdH
 XV1BHSHPPyTk2T8Dcg3jUz5poUyQwCaEI9bjHLPVp57WQoA6dPQQNOGsR/wVmbC9FbGa
 +GFf0Er8+OWiPRmVS8vuvec0AprLDHeqlHg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2td0y511h0-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 27 Jun 2019 13:19:46 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 27 Jun 2019 13:19:36 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id D87E362E2BE1; Thu, 27 Jun 2019 13:19:34 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <lmb@cloudflare.com>, <jannh@google.com>,
        <gregkh@linuxfoundation.org>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 1/4] bpf: unprivileged BPF access via /dev/bpf
Date:   Thu, 27 Jun 2019 13:19:20 -0700
Message-ID: <20190627201923.2589391-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190627201923.2589391-1-songliubraving@fb.com>
References: <20190627201923.2589391-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906270233
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch introduce unprivileged BPF access. The access control is
achieved via device /dev/bpf. Users with write access to /dev/bpf are able
to call sys_bpf().

Two ioctl command are added to /dev/bpf:

The two commands enable/disable permission to call sys_bpf() for current
task. This permission is noted by bpf_permitted in task_struct. This
permission is inherited during clone(CLONE_THREAD).

Helper function bpf_capable() is added to check whether the task has got
permission via /dev/bpf.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 Documentation/ioctl/ioctl-number.txt |  1 +
 include/linux/bpf.h                  | 11 +++++
 include/linux/sched.h                |  3 ++
 include/uapi/linux/bpf.h             |  6 +++
 kernel/bpf/arraymap.c                |  2 +-
 kernel/bpf/cgroup.c                  |  2 +-
 kernel/bpf/core.c                    |  4 +-
 kernel/bpf/cpumap.c                  |  2 +-
 kernel/bpf/devmap.c                  |  2 +-
 kernel/bpf/hashtab.c                 |  4 +-
 kernel/bpf/lpm_trie.c                |  2 +-
 kernel/bpf/offload.c                 |  2 +-
 kernel/bpf/queue_stack_maps.c        |  2 +-
 kernel/bpf/reuseport_array.c         |  2 +-
 kernel/bpf/stackmap.c                |  2 +-
 kernel/bpf/syscall.c                 | 71 +++++++++++++++++++++-------
 kernel/bpf/verifier.c                |  2 +-
 kernel/bpf/xskmap.c                  |  2 +-
 kernel/fork.c                        |  5 ++
 net/core/filter.c                    |  6 +--
 20 files changed, 99 insertions(+), 34 deletions(-)

diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
index c9558146ac58..19998b99d603 100644
--- a/Documentation/ioctl/ioctl-number.txt
+++ b/Documentation/ioctl/ioctl-number.txt
@@ -327,6 +327,7 @@ Code  Seq#(hex)	Include File		Comments
 0xB4	00-0F	linux/gpio.h		<mailto:linux-gpio@vger.kernel.org>
 0xB5	00-0F	uapi/linux/rpmsg.h	<mailto:linux-remoteproc@vger.kernel.org>
 0xB6	all	linux/fpga-dfl.h
+0xBP	01-02	uapi/linux/bpf.h	<mailto:bpf@vger.kernel.org>
 0xC0	00-0F	linux/usb/iowarrior.h
 0xCA	00-0F	uapi/misc/cxl.h
 0xCA	10-2F	uapi/misc/ocxl.h
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a62e7889b0b6..d17d57dff467 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -14,6 +14,10 @@
 #include <linux/numa.h>
 #include <linux/wait.h>
 #include <linux/u64_stats_sync.h>
+#include <linux/sched.h>
+#include <linux/capability.h>
+
+#include <asm/current.h>
 
 struct bpf_verifier_env;
 struct perf_event;
@@ -742,6 +746,11 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 				     const union bpf_attr *kattr,
 				     union bpf_attr __user *uattr);
+
+static inline bool bpf_capable(int cap)
+{
+	return current->bpf_permitted || capable(cap);
+}
 #else /* !CONFIG_BPF_SYSCALL */
 static inline struct bpf_prog *bpf_prog_get(u32 ufd)
 {
@@ -874,6 +883,8 @@ static inline int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 {
 	return -ENOTSUPP;
 }
+
+#define bpf_capable(cap) capable((cap))
 #endif /* CONFIG_BPF_SYSCALL */
 
 static inline struct bpf_prog *bpf_prog_get_type(u32 ufd,
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 11837410690f..e03ee4779c9e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -732,6 +732,9 @@ struct task_struct {
 	/* to be used once the psi infrastructure lands upstream. */
 	unsigned			use_memdelay:1;
 #endif
+#ifdef CONFIG_BPF_SYSCALL
+	unsigned			bpf_permitted:1;
+#endif
 
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index b077507efa3f..13e148bd6c7c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3541,4 +3541,10 @@ struct bpf_sysctl {
 				 */
 };
 
+#define BPF_IOCTL	0xBF
+
+/* enable/disable sys_bpf() for current */
+#define BPF_DEV_IOCTL_ENABLE_SYS_BPF	_IO(BPF_IOCTL, 0x01)
+#define BPF_DEV_IOCTL_DISABLE_SYS_BPF	_IO(BPF_IOCTL, 0x02)
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 1c65ce0098a9..9ae668fa9185 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -73,7 +73,7 @@ static struct bpf_map *array_map_alloc(union bpf_attr *attr)
 	bool percpu = attr->map_type == BPF_MAP_TYPE_PERCPU_ARRAY;
 	int ret, numa_node = bpf_map_attr_numa_node(attr);
 	u32 elem_size, index_mask, max_entries;
-	bool unpriv = !capable(CAP_SYS_ADMIN);
+	bool unpriv = !bpf_capable(CAP_SYS_ADMIN);
 	u64 cost, array_size, mask64;
 	struct bpf_map_memory mem;
 	struct bpf_array *array;
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 077ed3a19848..cf9c6a95e4d2 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -794,7 +794,7 @@ cgroup_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_get_current_cgroup_id:
 		return &bpf_get_current_cgroup_id_proto;
 	case BPF_FUNC_trace_printk:
-		if (capable(CAP_SYS_ADMIN))
+		if (bpf_capable(CAP_SYS_ADMIN))
 			return bpf_get_trace_printk_proto();
 		/* fall through */
 	default:
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 561ed07d3007..762a855404d2 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -646,7 +646,7 @@ static bool bpf_prog_kallsyms_verify_off(const struct bpf_prog *fp)
 void bpf_prog_kallsyms_add(struct bpf_prog *fp)
 {
 	if (!bpf_prog_kallsyms_candidate(fp) ||
-	    !capable(CAP_SYS_ADMIN))
+	    !bpf_capable(CAP_SYS_ADMIN))
 		return;
 
 	spin_lock_bh(&bpf_lock);
@@ -768,7 +768,7 @@ static int bpf_jit_charge_modmem(u32 pages)
 {
 	if (atomic_long_add_return(pages, &bpf_jit_current) >
 	    (bpf_jit_limit >> PAGE_SHIFT)) {
-		if (!capable(CAP_SYS_ADMIN)) {
+		if (!bpf_capable(CAP_SYS_ADMIN)) {
 			atomic_long_sub(pages, &bpf_jit_current);
 			return -EPERM;
 		}
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 8dff08768087..4c6054626b4f 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -83,7 +83,7 @@ static struct bpf_map *cpu_map_alloc(union bpf_attr *attr)
 	u64 cost;
 	int ret;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!bpf_capable(CAP_SYS_ADMIN))
 		return ERR_PTR(-EPERM);
 
 	/* check sanity of attributes */
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 40e86a7e0ef0..b7c3785be289 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -83,7 +83,7 @@ static struct bpf_map *dev_map_alloc(union bpf_attr *attr)
 	u64 cost;
 	int err;
 
-	if (!capable(CAP_NET_ADMIN))
+	if (!bpf_capable(CAP_NET_ADMIN))
 		return ERR_PTR(-EPERM);
 
 	/* check sanity of attributes */
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 22066a62c8c9..461a75c311a4 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -244,13 +244,13 @@ static int htab_map_alloc_check(union bpf_attr *attr)
 	BUILD_BUG_ON(offsetof(struct htab_elem, fnode.next) !=
 		     offsetof(struct htab_elem, hash_node.pprev));
 
-	if (lru && !capable(CAP_SYS_ADMIN))
+	if (lru && !bpf_capable(CAP_SYS_ADMIN))
 		/* LRU implementation is much complicated than other
 		 * maps.  Hence, limit to CAP_SYS_ADMIN for now.
 		 */
 		return -EPERM;
 
-	if (zero_seed && !capable(CAP_SYS_ADMIN))
+	if (zero_seed && !bpf_capable(CAP_SYS_ADMIN))
 		/* Guard against local DoS, and discourage production use. */
 		return -EPERM;
 
diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 56e6c75d354d..571962022fdf 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -543,7 +543,7 @@ static struct bpf_map *trie_alloc(union bpf_attr *attr)
 	u64 cost = sizeof(*trie), cost_per_node;
 	int ret;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!bpf_capable(CAP_SYS_ADMIN))
 		return ERR_PTR(-EPERM);
 
 	/* check sanity of attributes */
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index ba635209ae9a..d3e5378c5a15 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -366,7 +366,7 @@ struct bpf_map *bpf_map_offload_map_alloc(union bpf_attr *attr)
 	struct bpf_offloaded_map *offmap;
 	int err;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!bpf_capable(CAP_SYS_ADMIN))
 		return ERR_PTR(-EPERM);
 	if (attr->map_type != BPF_MAP_TYPE_ARRAY &&
 	    attr->map_type != BPF_MAP_TYPE_HASH)
diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
index f697647ceb54..01d848f1a783 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -45,7 +45,7 @@ static bool queue_stack_map_is_full(struct bpf_queue_stack *qs)
 /* Called from syscall */
 static int queue_stack_map_alloc_check(union bpf_attr *attr)
 {
-	if (!capable(CAP_SYS_ADMIN))
+	if (!bpf_capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
 	/* check sanity of attributes */
diff --git a/kernel/bpf/reuseport_array.c b/kernel/bpf/reuseport_array.c
index 50c083ba978c..840f38a58c7d 100644
--- a/kernel/bpf/reuseport_array.c
+++ b/kernel/bpf/reuseport_array.c
@@ -154,7 +154,7 @@ static struct bpf_map *reuseport_array_alloc(union bpf_attr *attr)
 	struct bpf_map_memory mem;
 	u64 array_size;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!bpf_capable(CAP_SYS_ADMIN))
 		return ERR_PTR(-EPERM);
 
 	array_size = sizeof(*array);
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 052580c33d26..1eab27b0bc17 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -90,7 +90,7 @@ static struct bpf_map *stack_map_alloc(union bpf_attr *attr)
 	u64 cost, n_buckets;
 	int err;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!bpf_capable(CAP_SYS_ADMIN))
 		return ERR_PTR(-EPERM);
 
 	if (attr->map_flags & ~STACK_CREATE_FLAG_MASK)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7713cf39795a..13a3ba59d509 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -23,6 +23,8 @@
 #include <linux/timekeeping.h>
 #include <linux/ctype.h>
 #include <linux/nospec.h>
+#include <linux/miscdevice.h>
+#include <linux/resource.h>
 
 #define IS_FD_ARRAY(map) ((map)->map_type == BPF_MAP_TYPE_PROG_ARRAY || \
 			   (map)->map_type == BPF_MAP_TYPE_PERF_EVENT_ARRAY || \
@@ -1166,7 +1168,7 @@ static int map_freeze(const union bpf_attr *attr)
 		err = -EBUSY;
 		goto err_put;
 	}
-	if (!capable(CAP_SYS_ADMIN)) {
+	if (!bpf_capable(CAP_SYS_ADMIN)) {
 		err = -EPERM;
 		goto err_put;
 	}
@@ -1616,7 +1618,7 @@ static int bpf_prog_load(union bpf_attr *attr, union bpf_attr __user *uattr)
 
 	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&
 	    (attr->prog_flags & BPF_F_ANY_ALIGNMENT) &&
-	    !capable(CAP_SYS_ADMIN))
+	    !bpf_capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
 	/* copy eBPF program license from user space */
@@ -1629,11 +1631,12 @@ static int bpf_prog_load(union bpf_attr *attr, union bpf_attr __user *uattr)
 	is_gpl = license_is_gpl_compatible(license);
 
 	if (attr->insn_cnt == 0 ||
-	    attr->insn_cnt > (capable(CAP_SYS_ADMIN) ? BPF_COMPLEXITY_LIMIT_INSNS : BPF_MAXINSNS))
+	    attr->insn_cnt > (bpf_capable(CAP_SYS_ADMIN) ?
+			      BPF_COMPLEXITY_LIMIT_INSNS : BPF_MAXINSNS))
 		return -E2BIG;
 	if (type != BPF_PROG_TYPE_SOCKET_FILTER &&
 	    type != BPF_PROG_TYPE_CGROUP_SKB &&
-	    !capable(CAP_SYS_ADMIN))
+	    !bpf_capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
 	bpf_prog_load_fixup_attach_type(attr);
@@ -1861,7 +1864,7 @@ static int bpf_prog_attach(const union bpf_attr *attr)
 	struct bpf_prog *prog;
 	int ret;
 
-	if (!capable(CAP_NET_ADMIN))
+	if (!bpf_capable(CAP_NET_ADMIN))
 		return -EPERM;
 
 	if (CHECK_ATTR(BPF_PROG_ATTACH))
@@ -1951,7 +1954,7 @@ static int bpf_prog_detach(const union bpf_attr *attr)
 {
 	enum bpf_prog_type ptype;
 
-	if (!capable(CAP_NET_ADMIN))
+	if (!bpf_capable(CAP_NET_ADMIN))
 		return -EPERM;
 
 	if (CHECK_ATTR(BPF_PROG_DETACH))
@@ -2007,7 +2010,7 @@ static int bpf_prog_detach(const union bpf_attr *attr)
 static int bpf_prog_query(const union bpf_attr *attr,
 			  union bpf_attr __user *uattr)
 {
-	if (!capable(CAP_NET_ADMIN))
+	if (!bpf_capable(CAP_NET_ADMIN))
 		return -EPERM;
 	if (CHECK_ATTR(BPF_PROG_QUERY))
 		return -EINVAL;
@@ -2051,7 +2054,7 @@ static int bpf_prog_test_run(const union bpf_attr *attr,
 	struct bpf_prog *prog;
 	int ret = -ENOTSUPP;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!bpf_capable(CAP_SYS_ADMIN))
 		return -EPERM;
 	if (CHECK_ATTR(BPF_PROG_TEST_RUN))
 		return -EINVAL;
@@ -2088,7 +2091,7 @@ static int bpf_obj_get_next_id(const union bpf_attr *attr,
 	if (CHECK_ATTR(BPF_OBJ_GET_NEXT_ID) || next_id >= INT_MAX)
 		return -EINVAL;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!bpf_capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
 	next_id++;
@@ -2114,7 +2117,7 @@ static int bpf_prog_get_fd_by_id(const union bpf_attr *attr)
 	if (CHECK_ATTR(BPF_PROG_GET_FD_BY_ID))
 		return -EINVAL;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!bpf_capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
 	spin_lock_bh(&prog_idr_lock);
@@ -2148,7 +2151,7 @@ static int bpf_map_get_fd_by_id(const union bpf_attr *attr)
 	    attr->open_flags & ~BPF_OBJ_FLAG_MASK)
 		return -EINVAL;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!bpf_capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
 	f_flags = bpf_get_file_flag(attr->open_flags);
@@ -2323,7 +2326,7 @@ static int bpf_prog_get_info_by_fd(struct bpf_prog *prog,
 	info.run_time_ns = stats.nsecs;
 	info.run_cnt = stats.cnt;
 
-	if (!capable(CAP_SYS_ADMIN)) {
+	if (!bpf_capable(CAP_SYS_ADMIN)) {
 		info.jited_prog_len = 0;
 		info.xlated_prog_len = 0;
 		info.nr_jited_ksyms = 0;
@@ -2641,7 +2644,7 @@ static int bpf_btf_load(const union bpf_attr *attr)
 	if (CHECK_ATTR(BPF_BTF_LOAD))
 		return -EINVAL;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!bpf_capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
 	return btf_new_fd(attr);
@@ -2654,7 +2657,7 @@ static int bpf_btf_get_fd_by_id(const union bpf_attr *attr)
 	if (CHECK_ATTR(BPF_BTF_GET_FD_BY_ID))
 		return -EINVAL;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!bpf_capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
 	return btf_get_fd_by_id(attr->btf_id);
@@ -2723,7 +2726,7 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
 	if (CHECK_ATTR(BPF_TASK_FD_QUERY))
 		return -EINVAL;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!bpf_capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
 	if (attr->task_fd_query.flags != 0)
@@ -2791,7 +2794,7 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
 	union bpf_attr attr = {};
 	int err;
 
-	if (sysctl_unprivileged_bpf_disabled && !capable(CAP_SYS_ADMIN))
+	if (sysctl_unprivileged_bpf_disabled && !bpf_capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
 	err = bpf_check_uarg_tail_zero(uattr, sizeof(attr), size);
@@ -2886,3 +2889,39 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
 
 	return err;
 }
+
+static long bpf_dev_ioctl(struct file *filp,
+			  unsigned int ioctl, unsigned long arg)
+{
+	switch (ioctl) {
+	case BPF_DEV_IOCTL_ENABLE_SYS_BPF:
+		current->bpf_permitted = 1;
+		break;
+	case BPF_DEV_IOCTL_DISABLE_SYS_BPF:
+		current->bpf_permitted = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static const struct file_operations bpf_chardev_ops = {
+	.unlocked_ioctl = bpf_dev_ioctl,
+};
+
+static struct miscdevice bpf_dev = {
+	.minor		= MISC_DYNAMIC_MINOR,
+	.name		= "bpf",
+	.fops		= &bpf_chardev_ops,
+	.mode		= 0220,
+};
+
+static int __init bpf_dev_init(void)
+{
+	if (misc_register(&bpf_dev))
+		pr_warn("BPF: Failed to create /dev/bpf. Continue without it...\n");
+
+	return 0;
+}
+device_initcall(bpf_dev_init);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0e079b2298f8..79dc4d641cf3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9134,7 +9134,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr,
 		env->insn_aux_data[i].orig_idx = i;
 	env->prog = *prog;
 	env->ops = bpf_verifier_ops[env->prog->type];
-	is_priv = capable(CAP_SYS_ADMIN);
+	is_priv = bpf_capable(CAP_SYS_ADMIN);
 
 	/* grab the mutex to protect few globals used by verifier */
 	if (!is_priv)
diff --git a/kernel/bpf/xskmap.c b/kernel/bpf/xskmap.c
index ef7338cebd18..06063679c27a 100644
--- a/kernel/bpf/xskmap.c
+++ b/kernel/bpf/xskmap.c
@@ -21,7 +21,7 @@ static struct bpf_map *xsk_map_alloc(union bpf_attr *attr)
 	int cpu, err;
 	u64 cost;
 
-	if (!capable(CAP_NET_ADMIN))
+	if (!bpf_capable(CAP_NET_ADMIN))
 		return ERR_PTR(-EPERM);
 
 	if (attr->max_entries == 0 || attr->key_size != 4 ||
diff --git a/kernel/fork.c b/kernel/fork.c
index 75675b9bf6df..b312562c1523 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1998,6 +1998,11 @@ static __latent_entropy struct task_struct *copy_process(
 	p->sequential_io_avg	= 0;
 #endif
 
+#ifdef CONFIG_BPF_SYSCALL
+	if ((clone_flags & CLONE_THREAD) == 0)
+		p->bpf_permitted = 0;
+#endif
+
 	/* Perform scheduler related setup. Assign this task to a CPU. */
 	retval = sched_fork(clone_flags, p);
 	if (retval)
diff --git a/net/core/filter.c b/net/core/filter.c
index 2014d76e0d2a..01ccf031849c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5875,7 +5875,7 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		break;
 	}
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!bpf_capable(CAP_SYS_ADMIN))
 		return NULL;
 
 	switch (func_id) {
@@ -6438,7 +6438,7 @@ static bool cg_skb_is_valid_access(int off, int size,
 		return false;
 	case bpf_ctx_range(struct __sk_buff, data):
 	case bpf_ctx_range(struct __sk_buff, data_end):
-		if (!capable(CAP_SYS_ADMIN))
+		if (!bpf_capable(CAP_SYS_ADMIN))
 			return false;
 		break;
 	}
@@ -6450,7 +6450,7 @@ static bool cg_skb_is_valid_access(int off, int size,
 		case bpf_ctx_range_till(struct __sk_buff, cb[0], cb[4]):
 			break;
 		case bpf_ctx_range(struct __sk_buff, tstamp):
-			if (!capable(CAP_SYS_ADMIN))
+			if (!bpf_capable(CAP_SYS_ADMIN))
 				return false;
 			break;
 		default:
-- 
2.17.1

