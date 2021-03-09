Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC30332E88
	for <lists+bpf@lfdr.de>; Tue,  9 Mar 2021 19:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhCISum (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Mar 2021 13:50:42 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48292 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230431AbhCISud (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Mar 2021 13:50:33 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 129IPGHf013011
        for <bpf@vger.kernel.org>; Tue, 9 Mar 2021 10:50:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=Bu37K8V0vJK/FoA1TdkuXDOnObsTkm2+L3vvR6XjXvI=;
 b=jf/fpmym0ksuC67qgY3zTeKrsOFMKB4lYkyNZ/cIHGxtAonwQx4L7M51did7ak6QEso0
 GMd6YD7Q3Bbnuh3ZQCakpycEMOdMnQUISowPiieTcsdGeooupHiRdl7ThB/UnSTiEMnw
 xQfuYdMR0FUdkAruvYNBX9ztNyybhdPyGzU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 376c07h3ww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 09 Mar 2021 10:50:33 -0800
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Mar 2021 10:50:32 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 7623E24D735; Tue,  9 Mar 2021 10:50:28 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH bpf v2] bpf: don't do bpf_cgroup_storage_set() for kuprobe/tp programs
Date:   Tue, 9 Mar 2021 10:50:28 -0800
Message-ID: <20210309185028.3763817-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-09_14:2021-03-09,2021-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=915
 mlxscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103090088
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For kuprobe and tracepoint bpf programs, kernel calls
trace_call_bpf() which calls BPF_PROG_RUN_ARRAY_CHECK()
to run the program array. Currently, BPF_PROG_RUN_ARRAY_CHECK()
also calls bpf_cgroup_storage_set() to set percpu
cgroup local storage with NULL value. This is
due to Commit 394e40a29788 ("bpf: extend bpf_prog_array to store
pointers to the cgroup storage") which modified
__BPF_PROG_RUN_ARRAY() to call bpf_cgroup_storage_set()
and this macro is also used by BPF_PROG_RUN_ARRAY_CHECK().

kuprobe and tracepoint programs are not allowed to call
bpf_get_local_storage() helper hence does not
access percpu cgroup local storage. Let us
change BPF_PROG_RUN_ARRAY_CHECK() not to
modify percpu cgroup local storage.

The issue is observed when I tried to debug [1] where
percpu data is overwritten due to
  preempt_disable -> migration_disable
change. This patch does not completely fix the above issue,
which will be addressed separately, e.g., multiple cgroup
prog runs may preempt each other. But it does fix
any potential issue caused by tracing program
overwriting percpu cgroup storage:
 - in a busy system, a tracing program is to run between
   bpf_cgroup_storage_set() and the cgroup prog run.
 - a kprobe program is triggered by a helper in cgroup prog
   before bpf_get_local_storage() is called.

 [1] https://lore.kernel.org/bpf/CAKH8qBuXCfUz=3Dw8L+Fj74OaUpbosO29niYwTki7=
e3Ag044_aww@mail.gmail.com/T

Cc: Roman Gushchin <guro@fb.com>
Fixes: 394e40a29788 ("bpf: extend bpf_prog_array to store pointers to the c=
group storage")
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c931bc97019d..b037cb698fa6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1110,7 +1110,7 @@ int bpf_prog_array_copy(struct bpf_prog_array *old_ar=
ray,
 		_ret;							\
 	 })
=20
-#define __BPF_PROG_RUN_ARRAY(array, ctx, func, check_non_null)	\
+#define __BPF_PROG_RUN_ARRAY(array, ctx, func, check_non_null, set_cg_stor=
age)	\
 	({						\
 		struct bpf_prog_array_item *_item;	\
 		struct bpf_prog *_prog;			\
@@ -1123,7 +1123,9 @@ int bpf_prog_array_copy(struct bpf_prog_array *old_ar=
ray,
 			goto _out;			\
 		_item =3D &_array->items[0];		\
 		while ((_prog =3D READ_ONCE(_item->prog))) {		\
-			bpf_cgroup_storage_set(_item->cgroup_storage);	\
+			if (set_cg_storage) {		\
+				bpf_cgroup_storage_set(_item->cgroup_storage);	\
+			}				\
 			_ret &=3D func(_prog, ctx);	\
 			_item++;			\
 		}					\
@@ -1170,10 +1172,10 @@ _out:							\
 	})
=20
 #define BPF_PROG_RUN_ARRAY(array, ctx, func)		\
-	__BPF_PROG_RUN_ARRAY(array, ctx, func, false)
+	__BPF_PROG_RUN_ARRAY(array, ctx, func, false, true)
=20
 #define BPF_PROG_RUN_ARRAY_CHECK(array, ctx, func)	\
-	__BPF_PROG_RUN_ARRAY(array, ctx, func, true)
+	__BPF_PROG_RUN_ARRAY(array, ctx, func, true, false)
=20
 #ifdef CONFIG_BPF_SYSCALL
 DECLARE_PER_CPU(int, bpf_prog_active);
--=20
2.24.1

