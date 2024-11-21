Return-Path: <bpf+bounces-45414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E41259D54DA
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 22:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C2B4B21606
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 21:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8B41D9A6F;
	Thu, 21 Nov 2024 21:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="SeKIyC00"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653A31C9EA4;
	Thu, 21 Nov 2024 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732225231; cv=none; b=pyqkGQI4OkfdlcJTHqr8dnIZgrRJ0qux/xxh6v1rpTF79UCg9ZrVoBIjQFgy7afcqMY/SrMEn7T/FXh5HiJwH//t4qZYG0RAnqQBt3TB15jXg139ZRp0FkDKNWuT+RbSUbXjzhB/IbrRpeDOVTsdTBSqXLBOHanwBhhiMDVRj1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732225231; c=relaxed/simple;
	bh=IsgDyk4/Q/xsbX6x8oFtEMlXQv8eNbWUjUBFrSAjFBI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Z/BgMZQiIGEVGSqmRKCNTXoU4dtEa0vnIPFgeYBy0YAdQEvrSSr7IpXLbJBaX3nBUzE1k/dK5Pz/88Ymo4qRgZHV09p7htICt+sX/CQQibA982Fjp9mywz8RTuBa/gblnYlFGUc84VoyNI0Mz00mSzQnO5odQpCHy6LLCdFT0cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=SeKIyC00; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732225221; x=1732484421;
	bh=Cu2Bd3Ez7fOOVo2QM+nxuTvu5Mm47YD1/T4deHVsNtI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=SeKIyC00MRDfHSupsDl97N5KFVUujTUjWyspfwiwdSBYT/6Yn1VzUUZx9bcBYSSbm
	 tvgj7oERtM8m7Lx857c1LwJg1xKAYCvT0WcOMD9CSq5rFmOJXd4u+2nGwl+d6a0OpB
	 IcE/da3Mq3btlwK4C9hbc4QWE5/G1rH9kwA9Nj6lBobN9SBBJLces+DAnq3EflK3BD
	 c02IoyLjsV88by6wErgT0K+iQvMoCbywSmcfEAHYmkYwGLoUL1bpoWNF4iOYvH4Qin
	 RizNY0W6RVcCb34AFIgQB44JjhwpwSe9Laeu9u9Y72SOOC6yvWDQkK+WuZ7FhpVFqT
	 QqMJinpIZmY0g==
Date: Thu, 21 Nov 2024 21:40:17 +0000
To: tj@kernel.org, void@manifault.com
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, andrii@kernel.org, mykolal@fb.com
Subject: [PATCH] selftests/sched_ext: fix build after renames in sched_ext API
Message-ID: <20241121214014.3346203-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 5dd75cc029e2f21bb162659bb367d0ced252a70a
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The selftests are falining to build on current tip of bpf-next and
sched_ext [1]. This has broken BPF CI [2] after merge from upstream.

Use appropriate function names in the selftests according to the
recent changes in the sched_ext API [3].

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=
=3Dfc39fb56917bb3cb53e99560ca3612a84456ada2
[2] https://github.com/kernel-patches/bpf/actions/runs/11959327258/job/3334=
0923745
[3] https://lore.kernel.org/all/20241109194853.580310-1-tj@kernel.org/

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 .../testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c | 2 +-
 .../selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c        | 4 ++--
 tools/testing/selftests/sched_ext/dsp_local_on.bpf.c      | 2 +-
 .../selftests/sched_ext/enq_select_cpu_fails.bpf.c        | 2 +-
 tools/testing/selftests/sched_ext/exit.bpf.c              | 4 ++--
 tools/testing/selftests/sched_ext/maximal.bpf.c           | 4 ++--
 tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c    | 2 +-
 .../selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c   | 2 +-
 .../testing/selftests/sched_ext/select_cpu_dispatch.bpf.c | 2 +-
 .../selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c | 2 +-
 .../selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c | 4 ++--
 tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c  | 8 ++++----
 12 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c b/=
tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c
index 37d9bf6fb745..6f4c3f5a1c5d 100644
--- a/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c
+++ b/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c
@@ -20,7 +20,7 @@ s32 BPF_STRUCT_OPS(ddsp_bogus_dsq_fail_select_cpu, struct=
 task_struct *p,
 =09=09 * If we dispatch to a bogus DSQ that will fall back to the
 =09=09 * builtin global DSQ, we fail gracefully.
 =09=09 */
-=09=09scx_bpf_dispatch_vtime(p, 0xcafef00d, SCX_SLICE_DFL,
+=09=09scx_bpf_dsq_insert_vtime(p, 0xcafef00d, SCX_SLICE_DFL,
 =09=09=09=09       p->scx.dsq_vtime, 0);
 =09=09return cpu;
 =09}
diff --git a/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c b=
/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c
index dffc97d9cdf1..e4a55027778f 100644
--- a/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c
+++ b/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c
@@ -17,8 +17,8 @@ s32 BPF_STRUCT_OPS(ddsp_vtimelocal_fail_select_cpu, struc=
t task_struct *p,
=20
 =09if (cpu >=3D 0) {
 =09=09/* Shouldn't be allowed to vtime dispatch to a builtin DSQ. */
-=09=09scx_bpf_dispatch_vtime(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL,
-=09=09=09=09       p->scx.dsq_vtime, 0);
+=09=09scx_bpf_dsq_insert_vtime(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL,
+=09=09=09=09=09 p->scx.dsq_vtime, 0);
 =09=09return cpu;
 =09}
=20
diff --git a/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c b/tools/t=
esting/selftests/sched_ext/dsp_local_on.bpf.c
index 6a7db1502c29..6325bf76f47e 100644
--- a/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
+++ b/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
@@ -45,7 +45,7 @@ void BPF_STRUCT_OPS(dsp_local_on_dispatch, s32 cpu, struc=
t task_struct *prev)
=20
 =09target =3D bpf_get_prandom_u32() % nr_cpus;
=20
-=09scx_bpf_dispatch(p, SCX_DSQ_LOCAL_ON | target, SCX_SLICE_DFL, 0);
+=09scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | target, SCX_SLICE_DFL, 0);
 =09bpf_task_release(p);
 }
=20
diff --git a/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c b=
/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c
index 1efb50d61040..a7cf868d5e31 100644
--- a/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c
+++ b/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c
@@ -31,7 +31,7 @@ void BPF_STRUCT_OPS(enq_select_cpu_fails_enqueue, struct =
task_struct *p,
 =09/* Can only call from ops.select_cpu() */
 =09scx_bpf_select_cpu_dfl(p, 0, 0, &found);
=20
-=09scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+=09scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
 }
=20
 SEC(".struct_ops.link")
diff --git a/tools/testing/selftests/sched_ext/exit.bpf.c b/tools/testing/s=
elftests/sched_ext/exit.bpf.c
index d75d4faf07f6..4bc36182d3ff 100644
--- a/tools/testing/selftests/sched_ext/exit.bpf.c
+++ b/tools/testing/selftests/sched_ext/exit.bpf.c
@@ -33,7 +33,7 @@ void BPF_STRUCT_OPS(exit_enqueue, struct task_struct *p, =
u64 enq_flags)
 =09if (exit_point =3D=3D EXIT_ENQUEUE)
 =09=09EXIT_CLEANLY();
=20
-=09scx_bpf_dispatch(p, DSQ_ID, SCX_SLICE_DFL, enq_flags);
+=09scx_bpf_dsq_insert(p, DSQ_ID, SCX_SLICE_DFL, enq_flags);
 }
=20
 void BPF_STRUCT_OPS(exit_dispatch, s32 cpu, struct task_struct *p)
@@ -41,7 +41,7 @@ void BPF_STRUCT_OPS(exit_dispatch, s32 cpu, struct task_s=
truct *p)
 =09if (exit_point =3D=3D EXIT_DISPATCH)
 =09=09EXIT_CLEANLY();
=20
-=09scx_bpf_consume(DSQ_ID);
+=09scx_bpf_dsq_move_to_local(DSQ_ID);
 }
=20
 void BPF_STRUCT_OPS(exit_enable, struct task_struct *p)
diff --git a/tools/testing/selftests/sched_ext/maximal.bpf.c b/tools/testin=
g/selftests/sched_ext/maximal.bpf.c
index 4d4cd8d966db..4c005fa71810 100644
--- a/tools/testing/selftests/sched_ext/maximal.bpf.c
+++ b/tools/testing/selftests/sched_ext/maximal.bpf.c
@@ -20,7 +20,7 @@ s32 BPF_STRUCT_OPS(maximal_select_cpu, struct task_struct=
 *p, s32 prev_cpu,
=20
 void BPF_STRUCT_OPS(maximal_enqueue, struct task_struct *p, u64 enq_flags)
 {
-=09scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+=09scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
 }
=20
 void BPF_STRUCT_OPS(maximal_dequeue, struct task_struct *p, u64 deq_flags)
@@ -28,7 +28,7 @@ void BPF_STRUCT_OPS(maximal_dequeue, struct task_struct *=
p, u64 deq_flags)
=20
 void BPF_STRUCT_OPS(maximal_dispatch, s32 cpu, struct task_struct *prev)
 {
-=09scx_bpf_consume(SCX_DSQ_GLOBAL);
+=09scx_bpf_dsq_move_to_local(SCX_DSQ_GLOBAL);
 }
=20
 void BPF_STRUCT_OPS(maximal_runnable, struct task_struct *p, u64 enq_flags=
)
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c b/tools=
/testing/selftests/sched_ext/select_cpu_dfl.bpf.c
index f171ac470970..13d0f5be788d 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c
@@ -30,7 +30,7 @@ void BPF_STRUCT_OPS(select_cpu_dfl_enqueue, struct task_s=
truct *p,
 =09}
 =09scx_bpf_put_idle_cpumask(idle_mask);
=20
-=09scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+=09scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
 }
=20
 SEC(".struct_ops.link")
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bp=
f.c b/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c
index 9efdbb7da928..815f1d5d61ac 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c
@@ -67,7 +67,7 @@ void BPF_STRUCT_OPS(select_cpu_dfl_nodispatch_enqueue, st=
ruct task_struct *p,
 =09=09saw_local =3D true;
 =09}
=20
-=09scx_bpf_dispatch(p, dsq_id, SCX_SLICE_DFL, enq_flags);
+=09scx_bpf_dsq_insert(p, dsq_id, SCX_SLICE_DFL, enq_flags);
 }
=20
 s32 BPF_STRUCT_OPS(select_cpu_dfl_nodispatch_init_task,
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dispatch.bpf.c b/=
tools/testing/selftests/sched_ext/select_cpu_dispatch.bpf.c
index 59bfc4f36167..4bb99699e920 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dispatch.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dispatch.bpf.c
@@ -29,7 +29,7 @@ s32 BPF_STRUCT_OPS(select_cpu_dispatch_select_cpu, struct=
 task_struct *p,
 =09cpu =3D prev_cpu;
=20
 dispatch:
-=09scx_bpf_dispatch(p, dsq_id, SCX_SLICE_DFL, 0);
+=09scx_bpf_dsq_insert(p, dsq_id, SCX_SLICE_DFL, 0);
 =09return cpu;
 }
=20
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.=
bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c
index 3bbd5fcdfb18..2a75de11b2cf 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c
@@ -18,7 +18,7 @@ s32 BPF_STRUCT_OPS(select_cpu_dispatch_bad_dsq_select_cpu=
, struct task_struct *p
 =09=09   s32 prev_cpu, u64 wake_flags)
 {
 =09/* Dispatching to a random DSQ should fail. */
-=09scx_bpf_dispatch(p, 0xcafef00d, SCX_SLICE_DFL, 0);
+=09scx_bpf_dsq_insert(p, 0xcafef00d, SCX_SLICE_DFL, 0);
=20
 =09return prev_cpu;
 }
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.=
bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c
index 0fda57fe0ecf..99d075695c97 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c
@@ -18,8 +18,8 @@ s32 BPF_STRUCT_OPS(select_cpu_dispatch_dbl_dsp_select_cpu=
, struct task_struct *p
 =09=09   s32 prev_cpu, u64 wake_flags)
 {
 =09/* Dispatching twice in a row is disallowed. */
-=09scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
-=09scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
+=09scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
+=09scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
=20
 =09return prev_cpu;
 }
diff --git a/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c b/too=
ls/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
index e6c67bcf5e6e..bfcb96cd4954 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
@@ -2,8 +2,8 @@
 /*
  * A scheduler that validates that enqueue flags are properly stored and
  * applied at dispatch time when a task is directly dispatched from
- * ops.select_cpu(). We validate this by using scx_bpf_dispatch_vtime(), a=
nd
- * making the test a very basic vtime scheduler.
+ * ops.select_cpu(). We validate this by using scx_bpf_dsq_insert_vtime(),
+ * and making the test a very basic vtime scheduler.
  *
  * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
  * Copyright (c) 2024 David Vernet <dvernet@meta.com>
@@ -47,13 +47,13 @@ s32 BPF_STRUCT_OPS(select_cpu_vtime_select_cpu, struct =
task_struct *p,
 =09cpu =3D prev_cpu;
 =09scx_bpf_test_and_clear_cpu_idle(cpu);
 ddsp:
-=09scx_bpf_dispatch_vtime(p, VTIME_DSQ, SCX_SLICE_DFL, task_vtime(p), 0);
+=09scx_bpf_dsq_insert_vtime(p, VTIME_DSQ, SCX_SLICE_DFL, task_vtime(p), 0)=
;
 =09return cpu;
 }
=20
 void BPF_STRUCT_OPS(select_cpu_vtime_dispatch, s32 cpu, struct task_struct=
 *p)
 {
-=09if (scx_bpf_consume(VTIME_DSQ))
+=09if (scx_bpf_dsq_move_to_local(VTIME_DSQ))
 =09=09consumed =3D true;
 }
=20
--=20
2.47.0



