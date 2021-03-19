Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C73341167
	for <lists+bpf@lfdr.de>; Fri, 19 Mar 2021 01:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhCSASh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Mar 2021 20:18:37 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56440 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230477AbhCSASL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Mar 2021 20:18:11 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 12J0HanI024957
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 17:18:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=/FUDafLeVp6wAQl7kmeSF8ZhTR3wRm+utDH/Qnu57fo=;
 b=kTwJ5c3vuHPgWwu07fwNwyEhpV9O9oaVKu4Kkmx74VCbdoN7sbWVCIZO5+gvcPbO717/
 iO7FDBW4tuquJ2rMQLoMwfYZaKfUgqw53QO8FLWx/vMVv6ud0aeyukhgMf2pSTSDoU3z
 OaCcFJ/6/8B2SXIQa6pCwgH31SNaUPab38I= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 37bs26qsf6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 17:18:10 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 18 Mar 2021 17:18:09 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 2584D790872; Thu, 18 Mar 2021 17:18:05 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Jiri Olsa <jolsa@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH bpf-next 1/2] bpf: fix NULL pointer dereference in bpf_get_local_storage() helper
Date:   Thu, 18 Mar 2021 17:18:05 -0700
Message-ID: <20210319001805.2166526-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210319001759.2165191-1-yhs@fb.com>
References: <20210319001759.2165191-1-yhs@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-18_19:2021-03-17,2021-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=911 impostorscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103190000
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
 include/linux/bpf-cgroup.h | 53 +++++++++++++++++++++++++++++++++-----
 include/linux/bpf.h        | 22 +++++++++++++---
 kernel/bpf/helpers.c       | 15 ++++++++---
 kernel/bpf/local_storage.c |  3 ++-
 4 files changed, 78 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index c42e02b4d84b..96fe26509489 100644
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
@@ -161,13 +172,43 @@ static inline enum bpf_cgroup_storage_type cgroup_sto=
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
+	int i;
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
+		break;
+	}
+	preempt_enable();
+
+	if (i =3D=3D BPF_CGROUP_STORAGE_NEST_MAX) {
+		WARN_ON_ONCE(1);
+		return -EBUSY;
+	}
+	return 0;
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
index 2d4f9ac12377..174350524577 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -9,7 +9,8 @@
 #include <linux/slab.h>
 #include <uapi/linux/btf.h>
=20
-DEFINE_PER_CPU(struct bpf_cgroup_storage*, bpf_cgroup_storage[MAX_BPF_CGRO=
UP_STORAGE_TYPE]);
+DEFINE_PER_CPU(struct bpf_cgroup_storage_info,
+	       bpf_cgroup_storage_info[BPF_CGROUP_STORAGE_NEST_MAX]);
=20
 #ifdef CONFIG_CGROUP_BPF
=20
--=20
2.30.2

