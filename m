Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33287342E7F
	for <lists+bpf@lfdr.de>; Sat, 20 Mar 2021 18:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhCTRCN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Mar 2021 13:02:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:2876 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229618AbhCTRCH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 20 Mar 2021 13:02:07 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12KGvl6A025572
        for <bpf@vger.kernel.org>; Sat, 20 Mar 2021 10:02:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=S7weahI+i2rE/R+LPnKN9rT3185OjicTtUXScXYdoQc=;
 b=g83q2ruK8NTflaVqXKSO/s49XykfJA/IqkPh3JEfa3doZe4GK2ktrZzDfmyAz+eMi24C
 +0m82a5eaMuWS9lYXOtuGPKjBkxer0TRwFLH6OMQsF+fl/QjpZky5JS0lTYKBssj2XZr
 gF1vfD1V4cGhe+MavzRrsOK4WvXvvf+V/UI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37devj1328-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 20 Mar 2021 10:02:06 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 20 Mar 2021 10:02:05 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 2CE5D88373A; Sat, 20 Mar 2021 10:02:01 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Jiri Olsa <jolsa@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH bpf-next v3] bpf: fix NULL pointer dereference in bpf_get_local_storage() helper
Date:   Sat, 20 Mar 2021 10:02:01 -0700
Message-ID: <20210320170201.698472-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-20_10:2021-03-19,2021-03-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103200134
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jiri Olsa reported a bug ([1]) in kernel where cgroup local
storage pointer may be NULL in bpf_get_local_storage() helper.
There are two issues uncovered by this bug:
  (1). kprobe or tracepoint prog incorrectly sets cgroup local storage
       before prog run,
  (2). due to change from preempt_disable to migrate_disable,
       preemption is possible and percpu storage might be overwritten
       by other tasks.

This issue (1) is fixed in [2]. This patch tried to address issue (2).
The following shows how things can go wrong:
  task 1:   bpf_cgroup_storage_set() for percpu local storage
         preemption happens
  task 2:   bpf_cgroup_storage_set() for percpu local storage
         preemption happens
  task 1:   run bpf program

task 1 will effectively use the percpu local storage setting by task 2
which will be either NULL or incorrect ones.

Instead of just one common local storage per cpu, this patch fixed
the issue by permitting 8 local storages per cpu and each local
storage is identified by a task_struct pointer. This way, we
allow at most 8 nested preemption between bpf_cgroup_storage_set()
and bpf_cgroup_storage_unset(). The percpu local storage slot
is released (calling bpf_cgroup_storage_unset()) by the same task
after bpf program finished running.
bpf_test_run() is also fixed to use the new bpf_cgroup_storage_set()
interface.

The patch is tested on top of [2] with reproducer in [1].
Without this patch, kernel will emit error in 2-3 minutes.
With this patch, after one hour, still no error.

 [1] https://lore.kernel.org/bpf/CAKH8qBuXCfUz=3Dw8L+Fj74OaUpbosO29niYwTki7=
e3Ag044_aww@mail.gmail.com/T
 [2] https://lore.kernel.org/bpf/CAKH8qBuXCfUz=3Dw8L+Fj74OaUpbosO29niYwTki7=
e3Ag044_aww@mail.gmail.com/T

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Roman Gushchin <guro@fb.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf-cgroup.h | 57 ++++++++++++++++++++++++++++++++------
 include/linux/bpf.h        | 22 ++++++++++++---
 kernel/bpf/helpers.c       | 15 +++++++---
 kernel/bpf/local_storage.c |  5 ++--
 net/bpf/test_run.c         |  6 +++-
 5 files changed, 86 insertions(+), 19 deletions(-)

Changelogs:
  v2 -> v3:
    . merge two patches as bpf_test_run() will have compilation error
      and may fail with other changes.
    . rewrite bpf_cgroup_storage_set() to be more inline with kernel
      coding style.
  v1 -> v2:
    . fix compilation issues when CONFIG_CGROUPS is off or
      CONFIG_CGROUP_BPF is off.

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index c42e02b4d84b..6a29fe11485d 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -20,14 +20,25 @@ struct bpf_sock_ops_kern;
 struct bpf_cgroup_storage;
 struct ctl_table;
 struct ctl_table_header;
+struct task_struct;
=20
 #ifdef CONFIG_CGROUP_BPF
=20
 extern struct static_key_false cgroup_bpf_enabled_key[MAX_BPF_ATTACH_TYPE];
 #define cgroup_bpf_enabled(type) static_branch_unlikely(&cgroup_bpf_enable=
d_key[type])
=20
-DECLARE_PER_CPU(struct bpf_cgroup_storage*,
-		bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
+#define BPF_CGROUP_STORAGE_NEST_MAX	8
+
+struct bpf_cgroup_storage_info {
+	struct task_struct *task;
+	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE];
+};
+
+/* For each cpu, permit maximum BPF_CGROUP_STORAGE_NEST_MAX number of tasks
+ * to use bpf cgroup storage simultaneously.
+ */
+DECLARE_PER_CPU(struct bpf_cgroup_storage_info,
+		bpf_cgroup_storage_info[BPF_CGROUP_STORAGE_NEST_MAX]);
=20
 #define for_each_cgroup_storage_type(stype) \
 	for (stype =3D 0; stype < MAX_BPF_CGROUP_STORAGE_TYPE; stype++)
@@ -161,13 +172,42 @@ static inline enum bpf_cgroup_storage_type cgroup_sto=
rage_type(
 	return BPF_CGROUP_STORAGE_SHARED;
 }
=20
-static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage
-					  *storage[MAX_BPF_CGROUP_STORAGE_TYPE])
+static inline int bpf_cgroup_storage_set(struct bpf_cgroup_storage
+					 *storage[MAX_BPF_CGROUP_STORAGE_TYPE])
 {
 	enum bpf_cgroup_storage_type stype;
+	int i, err =3D 0;
+
+	preempt_disable();
+	for (i =3D 0; i < BPF_CGROUP_STORAGE_NEST_MAX; i++) {
+		if (unlikely(this_cpu_read(bpf_cgroup_storage_info[i].task) !=3D NULL))
+			continue;
+
+		this_cpu_write(bpf_cgroup_storage_info[i].task, current);
+		for_each_cgroup_storage_type(stype)
+			this_cpu_write(bpf_cgroup_storage_info[i].storage[stype],
+				       storage[stype]);
+		goto out;
+	}
+	err =3D -EBUSY;
+	WARN_ON_ONCE(1);
+
+out:
+	preempt_enable();
+	return err;
+}
+
+static inline void bpf_cgroup_storage_unset(void)
+{
+	int i;
+
+	for (i =3D 0; i < BPF_CGROUP_STORAGE_NEST_MAX; i++) {
+		if (unlikely(this_cpu_read(bpf_cgroup_storage_info[i].task) !=3D current=
))
+			continue;
=20
-	for_each_cgroup_storage_type(stype)
-		this_cpu_write(bpf_cgroup_storage[stype], storage[stype]);
+		this_cpu_write(bpf_cgroup_storage_info[i].task, NULL);
+		return;
+	}
 }
=20
 struct bpf_cgroup_storage *
@@ -448,8 +488,9 @@ static inline int cgroup_bpf_prog_query(const union bpf=
_attr *attr,
 	return -EINVAL;
 }
=20
-static inline void bpf_cgroup_storage_set(
-	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE]) {}
+static inline int bpf_cgroup_storage_set(
+	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE]) { return=
 0; }
+static inline void bpf_cgroup_storage_unset(void) {}
 static inline int bpf_cgroup_storage_assign(struct bpf_prog_aux *aux,
 					    struct bpf_map *map) { return 0; }
 static inline struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a47285cd39c2..3a6ae69743ff 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1090,6 +1090,13 @@ int bpf_prog_array_copy(struct bpf_prog_array *old_a=
rray,
 /* BPF program asks to set CN on the packet. */
 #define BPF_RET_SET_CN						(1 << 0)
=20
+/* For BPF_PROG_RUN_ARRAY_FLAGS and __BPF_PROG_RUN_ARRAY,
+ * if bpf_cgroup_storage_set() failed, the rest of programs
+ * will not execute. This should be a really rare scenario
+ * as it requires BPF_CGROUP_STORAGE_NEST_MAX number of
+ * preemptions all between bpf_cgroup_storage_set() and
+ * bpf_cgroup_storage_unset() on the same cpu.
+ */
 #define BPF_PROG_RUN_ARRAY_FLAGS(array, ctx, func, ret_flags)		\
 	({								\
 		struct bpf_prog_array_item *_item;			\
@@ -1102,10 +1109,12 @@ int bpf_prog_array_copy(struct bpf_prog_array *old_=
array,
 		_array =3D rcu_dereference(array);			\
 		_item =3D &_array->items[0];				\
 		while ((_prog =3D READ_ONCE(_item->prog))) {		\
-			bpf_cgroup_storage_set(_item->cgroup_storage);	\
+			if (unlikely(bpf_cgroup_storage_set(_item->cgroup_storage)))	\
+				break;					\
 			func_ret =3D func(_prog, ctx);			\
 			_ret &=3D (func_ret & 1);				\
 			*(ret_flags) |=3D (func_ret >> 1);			\
+			bpf_cgroup_storage_unset();			\
 			_item++;					\
 		}							\
 		rcu_read_unlock();					\
@@ -1126,9 +1135,14 @@ int bpf_prog_array_copy(struct bpf_prog_array *old_a=
rray,
 			goto _out;			\
 		_item =3D &_array->items[0];		\
 		while ((_prog =3D READ_ONCE(_item->prog))) {		\
-			if (set_cg_storage)		\
-				bpf_cgroup_storage_set(_item->cgroup_storage);	\
-			_ret &=3D func(_prog, ctx);	\
+			if (!set_cg_storage) {			\
+				_ret &=3D func(_prog, ctx);	\
+			} else {				\
+				if (unlikely(bpf_cgroup_storage_set(_item->cgroup_storage)))	\
+					break;			\
+				_ret &=3D func(_prog, ctx);	\
+				bpf_cgroup_storage_unset();	\
+			}				\
 			_item++;			\
 		}					\
 _out:							\
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 074800226327..f306611c4ddf 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -382,8 +382,8 @@ const struct bpf_func_proto bpf_get_current_ancestor_cg=
roup_id_proto =3D {
 };
=20
 #ifdef CONFIG_CGROUP_BPF
-DECLARE_PER_CPU(struct bpf_cgroup_storage*,
-		bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
+DECLARE_PER_CPU(struct bpf_cgroup_storage_info,
+		bpf_cgroup_storage_info[BPF_CGROUP_STORAGE_NEST_MAX]);
=20
 BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
 {
@@ -392,10 +392,17 @@ BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, m=
ap, u64, flags)
 	 * verifier checks that its value is correct.
 	 */
 	enum bpf_cgroup_storage_type stype =3D cgroup_storage_type(map);
-	struct bpf_cgroup_storage *storage;
+	struct bpf_cgroup_storage *storage =3D NULL;
 	void *ptr;
+	int i;
=20
-	storage =3D this_cpu_read(bpf_cgroup_storage[stype]);
+	for (i =3D 0; i < BPF_CGROUP_STORAGE_NEST_MAX; i++) {
+		if (unlikely(this_cpu_read(bpf_cgroup_storage_info[i].task) !=3D current=
))
+			continue;
+
+		storage =3D this_cpu_read(bpf_cgroup_storage_info[i].storage[stype]);
+		break;
+	}
=20
 	if (stype =3D=3D BPF_CGROUP_STORAGE_SHARED)
 		ptr =3D &READ_ONCE(storage->buf)->data[0];
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 2d4f9ac12377..bd11db9774c3 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -9,10 +9,11 @@
 #include <linux/slab.h>
 #include <uapi/linux/btf.h>
=20
-DEFINE_PER_CPU(struct bpf_cgroup_storage*, bpf_cgroup_storage[MAX_BPF_CGRO=
UP_STORAGE_TYPE]);
-
 #ifdef CONFIG_CGROUP_BPF
=20
+DEFINE_PER_CPU(struct bpf_cgroup_storage_info,
+	       bpf_cgroup_storage_info[BPF_CGROUP_STORAGE_NEST_MAX]);
+
 #include "../cgroup/cgroup-internal.h"
=20
 #define LOCAL_STORAGE_CREATE_FLAG_MASK					\
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 0abdd67f44b1..4aabf71cd95d 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -106,12 +106,16 @@ static int bpf_test_run(struct bpf_prog *prog, void *=
ctx, u32 repeat,
=20
 	bpf_test_timer_enter(&t);
 	do {
-		bpf_cgroup_storage_set(storage);
+		ret =3D bpf_cgroup_storage_set(storage);
+		if (ret)
+			break;
=20
 		if (xdp)
 			*retval =3D bpf_prog_run_xdp(prog, ctx);
 		else
 			*retval =3D BPF_PROG_RUN(prog, ctx);
+
+		bpf_cgroup_storage_unset();
 	} while (bpf_test_timer_continue(&t, repeat, &ret, time));
 	bpf_test_timer_leave(&t);
=20
--=20
2.30.2

