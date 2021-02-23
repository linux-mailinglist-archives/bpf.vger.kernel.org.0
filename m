Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B13322399
	for <lists+bpf@lfdr.de>; Tue, 23 Feb 2021 02:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhBWBXE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Feb 2021 20:23:04 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21370 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230422AbhBWBWU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Feb 2021 20:22:20 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11N17gJQ003549
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 17:21:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=9MXKxqv+SncBnz5OqxIZYK7jmff9BGIDVI3Ly/9d+n0=;
 b=hGSAyFGwK6LRlm6od2lR/8KUbvApOfe1hX05YbDsYwyx1vbFKkFxq0/gK9bKOXP5qInU
 uBEbvqlUkx/B4PVeTyLw3xdALihdNTjUJw1cumhAVH40wNpuvaslUeuUTmv4ZkD8GA4G
 6l8rJsqC7naSr+ApHM5Umt5oi3XliWnZcWE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36uk0n0m00-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 17:21:39 -0800
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 22 Feb 2021 17:21:23 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id DB65562E0887; Mon, 22 Feb 2021 17:21:21 -0800 (PST)
From:   Song Liu <songliubraving@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>, Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v4 bpf-next 6/6] bpf: runqslower: use task local storage
Date:   Mon, 22 Feb 2021 17:20:14 -0800
Message-ID: <20210223012014.2087583-7-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210223012014.2087583-1-songliubraving@fb.com>
References: <20210223012014.2087583-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-22_08:2021-02-22,2021-02-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0
 adultscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230006
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Replace hashtab with task local storage in runqslower. This improves the
performance of these BPF programs. The following table summarizes average
runtime of these programs, in nanoseconds:

                          task-local   hash-prealloc   hash-no-prealloc
handle__sched_wakeup             125             340               3124
handle__sched_wakeup_new        2812            1510               2998
handle__sched_switch             151             208                991

Note that, task local storage gives better performance than hashtab for
handle__sched_wakeup and handle__sched_switch. On the other hand, for
handle__sched_wakeup_new, task local storage is slower than hashtab with
prealloc. This is because handle__sched_wakeup_new accesses the data for
the first time, so it has to allocate the data for task local storage.
Once the initial allocation is done, subsequent accesses, as those in
handle__sched_wakeup, are much faster with task local storage. If we
disable hashtab prealloc, task local storage is much faster for all 3
functions.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/bpf/runqslower/runqslower.bpf.c | 33 +++++++++++++++++----------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/tools/bpf/runqslower/runqslower.bpf.c b/tools/bpf/runqslower=
/runqslower.bpf.c
index 1f18a409f0443..645530ca7e985 100644
--- a/tools/bpf/runqslower/runqslower.bpf.c
+++ b/tools/bpf/runqslower/runqslower.bpf.c
@@ -11,9 +11,9 @@ const volatile __u64 min_us =3D 0;
 const volatile pid_t targ_pid =3D 0;
=20
 struct {
-	__uint(type, BPF_MAP_TYPE_HASH);
-	__uint(max_entries, 10240);
-	__type(key, u32);
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
 	__type(value, u64);
 } start SEC(".maps");
=20
@@ -25,15 +25,20 @@ struct {
=20
 /* record enqueue timestamp */
 __always_inline
-static int trace_enqueue(u32 tgid, u32 pid)
+static int trace_enqueue(struct task_struct *t)
 {
-	u64 ts;
+	u32 pid =3D t->pid;
+	u64 *ptr;
=20
 	if (!pid || (targ_pid && targ_pid !=3D pid))
 		return 0;
=20
-	ts =3D bpf_ktime_get_ns();
-	bpf_map_update_elem(&start, &pid, &ts, 0);
+	ptr =3D bpf_task_storage_get(&start, t, 0,
+				   BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!ptr)
+		return 0;
+
+	*ptr =3D bpf_ktime_get_ns();
 	return 0;
 }
=20
@@ -43,7 +48,7 @@ int handle__sched_wakeup(u64 *ctx)
 	/* TP_PROTO(struct task_struct *p) */
 	struct task_struct *p =3D (void *)ctx[0];
=20
-	return trace_enqueue(p->tgid, p->pid);
+	return trace_enqueue(p);
 }
=20
 SEC("tp_btf/sched_wakeup_new")
@@ -52,7 +57,7 @@ int handle__sched_wakeup_new(u64 *ctx)
 	/* TP_PROTO(struct task_struct *p) */
 	struct task_struct *p =3D (void *)ctx[0];
=20
-	return trace_enqueue(p->tgid, p->pid);
+	return trace_enqueue(p);
 }
=20
 SEC("tp_btf/sched_switch")
@@ -70,12 +75,16 @@ int handle__sched_switch(u64 *ctx)
=20
 	/* ivcsw: treat like an enqueue event and store timestamp */
 	if (prev->state =3D=3D TASK_RUNNING)
-		trace_enqueue(prev->tgid, prev->pid);
+		trace_enqueue(prev);
=20
 	pid =3D next->pid;
=20
+	/* For pid mismatch, save a bpf_task_storage_get */
+	if (!pid || (targ_pid && targ_pid !=3D pid))
+		return 0;
+
 	/* fetch timestamp and calculate delta */
-	tsp =3D bpf_map_lookup_elem(&start, &pid);
+	tsp =3D bpf_task_storage_get(&start, next, 0, 0);
 	if (!tsp)
 		return 0;   /* missed enqueue */
=20
@@ -91,7 +100,7 @@ int handle__sched_switch(u64 *ctx)
 	bpf_perf_event_output(ctx, &events, BPF_F_CURRENT_CPU,
 			      &event, sizeof(event));
=20
-	bpf_map_delete_elem(&start, &pid);
+	bpf_task_storage_delete(&start, next);
 	return 0;
 }
=20
--=20
2.24.1

