Return-Path: <bpf+bounces-28347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF288B8C9F
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 733101F2121E
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 15:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809E91332A7;
	Wed,  1 May 2024 15:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiuvHZVY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1578413249F;
	Wed,  1 May 2024 15:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576435; cv=none; b=qHHkl9rDDmCKnXnlRkjWSLyQa4K4DXdci9ChYcDzLcQW4GfyIBMtzqg5RgFqMKPg9MauGr8Mwgb5WiiYrhuQera8GOLlwxv8h6sPZGmNDQhrWZZ2ln6pK0DTZcjMHEE5Tow2Pq+uqU+TMgG/uZyUJiOUT8BC8DD+g8A3W5DFTto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576435; c=relaxed/simple;
	bh=2s6OYycevJuiOYBhNI98vjUVjUaG+483mKq5SyaSiU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rPJdrpgZPYjHqbvP1++94KtuSJ5932eGScbSs8ir9+QK9Mwfsxzw6nnz7Mu8XzwH+qJ1/msbmjYMSu1ETw2IDPZOHZ79icA7CPCaEtgWFGEuTSHKYJWIHAQCZBIJKCcLHVuF6x6KZml3jaI8rkIYfL8ftvJhepPoGM+lcqAj5aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OiuvHZVY; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e5c7d087e1so59297355ad.0;
        Wed, 01 May 2024 08:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714576427; x=1715181227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCRxUhZElSSIW+SJkBwK1HblVQS+twpPPXWrrGKz65g=;
        b=OiuvHZVYxsBGkuuKL7tBojbj+t1Uw/LMAAVgGyAz5G4zrNGPf49ewot7ofR8PPlk/7
         sE+S2188zwQKPQcMkOFtkh+6bF7SS1qI1xduE/0l+o2pLlgSDLeRh+xqq9EhdeE+mmI4
         +C2+uMd8sCld3Tz6OpcK9i5gjGaOenPf0CBe9sxCj0qDi/jX2ecRvqkZExjV2J/PGQri
         Hbjmn7BWRHG9DBOKdPxELUj+x7yrmH9EVNZLtvt2MX3dKLhosS9tdLqDUPoqNugSssZP
         C0Skn4++xiB6s1nHPrYi9gtqJ6xMY2iZfgRWPplNIjwUDLw0XB4WaH+zPjFqC6MCG8bt
         yAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714576427; x=1715181227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DCRxUhZElSSIW+SJkBwK1HblVQS+twpPPXWrrGKz65g=;
        b=aLt2NOtDu1GD0sUUA+8y9LhVVKJ798eyPDKJGNaI+gzvnyuCjAJxLdbTsV5j0ixjtr
         13Jn/+7vYi4sc/14DByLAi5yHb6zY1scwLng1CdvR2DrrIvd/96Lnsmkedd8SNtxETJn
         BnaLWmHcg8oxyR+s4+2KjBKEA/rDaReapvwXwEuUAeFNv2/8Bf7hIYedns/qrhdGzMbH
         lxvFyZc3w7U7rtt1VUPE5bDR6xrRNkx3okmDFaR2goCMK6sG39wOERkuRnddEFcRDXsP
         1V3caW06arQM7+gTRSU+YV5v9wm9b8D0sEFswGxDxNotijRc83zKig/6ClMfkewiRi3v
         R8mw==
X-Forwarded-Encrypted: i=1; AJvYcCUG9rCrAGyLQZ1oPA1P6xMqOJxnPbcYbmDJ7080m7gf0VFjDOVJQLsZmrr4feuY8DJ+kPWtUFgUsYjrLHVA7+V4Q2rh
X-Gm-Message-State: AOJu0Yz7itZeKMJOjPb3wnPSQClMEkTtlQ5zOgrgbrnUlGTf+J8U/Do9
	8LmLoSEhhm6tx6nNOFGQykoVrP2ZblLpyzVAzzvTvGtOh3Ca0+el
X-Google-Smtp-Source: AGHT+IGEuFKlYrucgD7flpWPa9epIorCLSYM0KbrZIjFIKmsO2q5TMNOu7w80i4eBI0AJgOZPbjyJQ==
X-Received: by 2002:a17:902:d54d:b0:1eb:dae:714f with SMTP id z13-20020a170902d54d00b001eb0dae714fmr3466411plf.9.1714576425594;
        Wed, 01 May 2024 08:13:45 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id kz16-20020a170902f9d000b001ecced64c9fsm121172plb.297.2024.05.01.08.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:13:45 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	joshdon@google.com,
	brho@google.com,
	pjt@google.com,
	derkling@google.com,
	haoluo@google.com,
	dvernet@meta.com,
	dschatzberg@meta.com,
	dskarlat@cs.cmu.edu,
	riel@surriel.com,
	changwoo@igalia.com,
	himadrics@inria.fr,
	memxor@gmail.com,
	andrea.righi@canonical.com,
	joel@joelfernandes.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 14/39] sched_ext: Implement BPF extensible scheduler class
Date: Wed,  1 May 2024 05:09:49 -1000
Message-ID: <20240501151312.635565-15-tj@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501151312.635565-1-tj@kernel.org>
References: <20240501151312.635565-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement a new scheduler class sched_ext (SCX), which allows scheduling
policies to be implemented as BPF programs to achieve the following:

1. Ease of experimentation and exploration: Enabling rapid iteration of new
   scheduling policies.

2. Customization: Building application-specific schedulers which implement
   policies that are not applicable to general-purpose schedulers.

3. Rapid scheduler deployments: Non-disruptive swap outs of scheduling
   policies in production environments.

sched_ext leverages BPF’s struct_ops feature to define a structure which
exports function callbacks and flags to BPF programs that wish to implement
scheduling policies. The struct_ops structure exported by sched_ext is
struct sched_ext_ops, and is conceptually similar to struct sched_class. The
role of sched_ext is to map the complex sched_class callbacks to the more
simple and ergonomic struct sched_ext_ops callbacks.

For more detailed discussion on the motivations and overview, please refer
to the cover letter.

Later patches will also add several example schedulers and documentation.

This patch implements the minimum core framework to enable implementation of
BPF schedulers. Subsequent patches will gradually add functionalities
including safety guarantee mechanisms, nohz and cgroup support.

include/linux/sched/ext.h defines struct sched_ext_ops. With the comment on
top, each operation should be self-explanatory. The followings are worth
noting:

- Both "sched_ext" and its shorthand "scx" are used. If the identifier
  already has "sched" in it, "ext" is used; otherwise, "scx".

- In sched_ext_ops, only .name is mandatory. Every operation is optional and
  if omitted a simple but functional default behavior is provided.

- A new policy constant SCHED_EXT is added and a task can select sched_ext
  by invoking sched_setscheduler(2) with the new policy constant. However,
  if the BPF scheduler is not loaded, SCHED_EXT is the same as SCHED_NORMAL
  and the task is scheduled by CFS. When the BPF scheduler is loaded, all
  tasks which have the SCHED_EXT policy are switched to sched_ext.

- To bridge the workflow imbalance between the scheduler core and
  sched_ext_ops callbacks, sched_ext uses simple FIFOs called dispatch
  queues (dsq's). By default, there is one global dsq (SCX_DSQ_GLOBAL), and
  one local per-CPU dsq (SCX_DSQ_LOCAL). SCX_DSQ_GLOBAL is provided for
  convenience and need not be used by a scheduler that doesn't require it.
  SCX_DSQ_LOCAL is the per-CPU FIFO that sched_ext pulls from when putting
  the next task on the CPU. The BPF scheduler can manage an arbitrary number
  of dsq's using scx_bpf_create_dsq() and scx_bpf_destroy_dsq().

- sched_ext guarantees system integrity no matter what the BPF scheduler
  does. To enable this, each task's ownership is tracked through
  p->scx.ops_state and all tasks are put on scx_tasks list. The disable path
  can always recover and revert all tasks back to CFS. See p->scx.ops_state
  and scx_tasks.

- A task is not tied to its rq while enqueued. This decouples CPU selection
  from queueing and allows sharing a scheduling queue across an arbitrary
  subset of CPUs. This adds some complexities as a task may need to be
  bounced between rq's right before it starts executing. See
  dispatch_to_local_dsq() and move_task_to_local_dsq().

- One complication that arises from the above weak association between task
  and rq is that synchronizing with dequeue() gets complicated as dequeue()
  may happen anytime while the task is enqueued and the dispatch path might
  need to release the rq lock to transfer the task. Solving this requires a
  bit of complexity. See the logic around p->scx.sticky_cpu and
  p->scx.ops_qseq.

- Both enable and disable paths are a bit complicated. The enable path
  switches all tasks without blocking to avoid issues which can arise from
  partially switched states (e.g. the switching task itself being starved).
  The disable path can't trust the BPF scheduler at all, so it also has to
  guarantee forward progress without blocking. See scx_ops_enable() and
  scx_ops_disable_workfn().

- When sched_ext is disabled, static_branches are used to shut down the
  entry points from hot paths.

v6: - SCX_NR_ONLINE_OPS replaced with SCX_OPI_*_BEGIN/END so that multiple
      groups can be expressed. Later CPU hotplug operations are put into
      their own group.

    - SCX_OPS_DISABLING state is replaced with the new bypass mechanism
      which allows temporarily putting the system into simple FIFO
      scheduling mode bypassing the BPF scheduler. In addition to the shut
      down path, this will also be used to isolate the BPF scheduler across
      PM events. Enabling and disabling the bypass mode requires iterating
      all runnable tasks. rq->scx.runnable_list addition is moved from the
      later watchdog patch.

    - ops.prep_enable() is replaced with ops.init_task() and
      ops.enable/disable() are now called whenever the task enters and
      leaves sched_ext instead of when the task becomes schedulable on
      sched_ext and stops being so. A new operation - ops.exit_task() - is
      called when the task stops being schedulable on sched_ext.

    - scx_bpf_dispatch() can now be called from ops.select_cpu() too. This
      removes the need for communicating local dispatch decision made by
      ops.select_cpu() to ops.enqueue() via per-task storage.
      SCX_KF_SELECT_CPU is added to support the change.

    - SCX_TASK_ENQ_LOCAL which told the BPF scheudler that
      scx_select_cpu_dfl() wants the task to be dispatched to the local DSQ
      was removed. Instead, scx_bpf_select_cpu_dfl() now dispatches directly
      if it finds a suitable idle CPU. If such behavior is not desired,
      users can use scx_bpf_select_cpu_dfl() which returns the verdict in a
      bool out param.

    - scx_select_cpu_dfl() was mishandling WAKE_SYNC and could end up
      queueing many tasks on a local DSQ which makes tasks to execute in
      order while other CPUs stay idle which made some hackbench numbers
      really bad. Fixed.

    - The current state of sched_ext can now be monitored through files
      under /sys/sched_ext instead of /sys/kernel/debug/sched/ext. This is
      to enable monitoring on kernels which don't enable debugfs.

    - sched_ext wasn't telling BPF that ops.dispatch()'s @prev argument may
      be NULL and a BPF scheduler which derefs the pointer without checking
      could crash the kernel. Tell BPF. This is currently a bit ugly. A
      better way to annotate this is expected in the future.

    - scx_exit_info updated to carry pointers to message buffers instead of
      embedding them directly. This decouples buffer sizes from API so that
      they can be changed without breaking compatibility.

    - exit_code added to scx_exit_info. This is used to indicate different
      exit conditions on non-error exits and will be used to handle e.g. CPU
      hotplugs.

    - The patch "sched_ext: Allow BPF schedulers to switch all eligible
      tasks into sched_ext" is folded in and the interface is changed so
      that partial switching is indicated with a new ops flag
      %SCX_OPS_SWITCH_PARTIAL. This makes scx_bpf_switch_all() unnecessasry
      and in turn SCX_KF_INIT. ops.init() is now called with
      SCX_KF_SLEEPABLE.

    - Code reorganized so that only the parts necessary to integrate with
      the rest of the kernel are in the header files.

    - Changes to reflect the BPF and other kernel changes including the
      addition of bpf_sched_ext_ops.cfi_stubs.

v5: - To accommodate 32bit configs, p->scx.ops_state is now atomic_long_t
      instead of atomic64_t and scx_dsp_buf_ent.qseq which uses
      load_acquire/store_release is now unsigned long instead of u64.

    - Fix the bug where bpf_scx_btf_struct_access() was allowing write
      access to arbitrary fields.

    - Distinguish kfuncs which can be called from any sched_ext ops and from
      anywhere. e.g. scx_bpf_pick_idle_cpu() can now be called only from
      sched_ext ops.

    - Rename "type" to "kind" in scx_exit_info to make it easier to use on
      languages in which "type" is a reserved keyword.

    - Since cff9b2332ab7 ("kernel/sched: Modify initial boot task idle
      setup"), PF_IDLE is not set on idle tasks which haven't been online
      yet which made scx_task_iter_next_filtered() include those idle tasks
      in iterations leading to oopses. Update scx_task_iter_next_filtered()
      to directly test p->sched_class against idle_sched_class instead of
      using is_idle_task() which tests PF_IDLE.

    - Other updates to match upstream changes such as adding const to
      set_cpumask() param and renaming check_preempt_curr() to
      wakeup_preempt().

v4: - SCHED_CHANGE_BLOCK replaced with the previous
      sched_deq_and_put_task()/sched_enq_and_set_tsak() pair. This is
      because upstream is adaopting a different generic cleanup mechanism.
      Once that lands, the code will be adapted accordingly.

    - task_on_scx() used to test whether a task should be switched into SCX,
      which is confusing. Renamed to task_should_scx(). task_on_scx() now
      tests whether a task is currently on SCX.

    - scx_has_idle_cpus is barely used anymore and replaced with direct
      check on the idle cpumask.

    - SCX_PICK_IDLE_CORE added and scx_pick_idle_cpu() improved to prefer
      fully idle cores.

    - ops.enable() now sees up-to-date p->scx.weight value.

    - ttwu_queue path is disabled for tasks on SCX to avoid confusing BPF
      schedulers expecting ->select_cpu() call.

    - Use cpu_smt_mask() instead of topology_sibling_cpumask() like the rest
      of the scheduler.

v3: - ops.set_weight() added to allow BPF schedulers to track weight changes
      without polling p->scx.weight.

    - move_task_to_local_dsq() was losing SCX-specific enq_flags when
      enqueueing the task on the target dsq because it goes through
      activate_task() which loses the upper 32bit of the flags. Carry the
      flags through rq->scx.extra_enq_flags.

    - scx_bpf_dispatch(), scx_bpf_pick_idle_cpu(), scx_bpf_task_running()
      and scx_bpf_task_cpu() now use the new KF_RCU instead of
      KF_TRUSTED_ARGS to make it easier for BPF schedulers to call them.

    - The kfunc helper access control mechanism implemented through
      sched_ext_entity.kf_mask is improved. Now SCX_CALL_OP*() is always
      used when invoking scx_ops operations.

v2: - balance_scx_on_up() is dropped. Instead, on UP, balance_scx() is
      called from put_prev_taks_scx() and pick_next_task_scx() as necessary.
      To determine whether balance_scx() should be called from
      put_prev_task_scx(), SCX_TASK_DEQD_FOR_SLEEP flag is added. See the
      comment in put_prev_task_scx() for details.

    - sched_deq_and_put_task() / sched_enq_and_set_task() sequences replaced
      with SCHED_CHANGE_BLOCK().

    - Unused all_dsqs list removed. This was a left-over from previous
      iterations.

    - p->scx.kf_mask is added to track and enforce which kfunc helpers are
      allowed. Also, init/exit sequences are updated to make some kfuncs
      always safe to call regardless of the current BPF scheduler state.
      Combined, this should make all the kfuncs safe.

    - BPF now supports sleepable struct_ops operations. Hacky workaround
      removed and operations and kfunc helpers are tagged appropriately.

    - BPF now supports bitmask / cpumask helpers. scx_bpf_get_idle_cpumask()
      and friends are added so that BPF schedulers can use the idle masks
      with the generic helpers. This replaces the hacky kfunc helpers added
      by a separate patch in V1.

    - CONFIG_SCHED_CLASS_EXT can no longer be enabled if SCHED_CORE is
      enabled. This restriction will be removed by a later patch which adds
      core-sched support.

    - Add MAINTAINERS entries and other misc changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
Co-authored-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
Cc: Andrea Righi <andrea.righi@canonical.com>
---
 MAINTAINERS                       |   13 +
 include/asm-generic/vmlinux.lds.h |    1 +
 include/linux/sched.h             |    5 +
 include/linux/sched/ext.h         |  141 +-
 include/uapi/linux/sched.h        |    1 +
 init/init_task.c                  |   11 +
 kernel/Kconfig.preempt            |   22 +-
 kernel/sched/build_policy.c       |    7 +
 kernel/sched/core.c               |   70 +-
 kernel/sched/debug.c              |    3 +
 kernel/sched/ext.c                | 4238 +++++++++++++++++++++++++++++
 kernel/sched/ext.h                |   82 +-
 kernel/sched/sched.h              |   17 +
 13 files changed, 4603 insertions(+), 8 deletions(-)
 create mode 100644 kernel/sched/ext.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c9f887fbb477..83f36314f675 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19635,6 +19635,19 @@ F:	include/linux/wait.h
 F:	include/uapi/linux/sched.h
 F:	kernel/sched/
 
+SCHEDULER - SCHED_EXT
+R:	Tejun Heo <tj@kernel.org>
+R:	David Vernet <void@manifault.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+W:	https://github.com/sched-ext/scx
+T:	git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git
+F:	include/linux/sched/ext.h
+F:	kernel/sched/ext.h
+F:	kernel/sched/ext.c
+F:	tools/sched_ext/
+F:	tools/testing/selftests/sched_ext
+
 SCSI LIBSAS SUBSYSTEM
 R:	John Garry <john.g.garry@oracle.com>
 R:	Jason Yan <yanaijie@huawei.com>
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index f7749d0f2562..05bfe4acba1d 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -131,6 +131,7 @@
 	*(__dl_sched_class)			\
 	*(__rt_sched_class)			\
 	*(__fair_sched_class)			\
+	*(__ext_sched_class)			\
 	*(__idle_sched_class)			\
 	__sched_class_lowest = .;
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3c2abbc587b4..dc07eb0d3290 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -80,6 +80,8 @@ struct task_group;
 struct task_struct;
 struct user_event_mm;
 
+#include <linux/sched/ext.h>
+
 /*
  * Task state bitmask. NOTE! These bits are also
  * encoded in fs/proc/array.c: get_task_state().
@@ -798,6 +800,9 @@ struct task_struct {
 	struct sched_rt_entity		rt;
 	struct sched_dl_entity		dl;
 	struct sched_dl_entity		*dl_server;
+#ifdef CONFIG_SCHED_CLASS_EXT
+	struct sched_ext_entity		scx;
+#endif
 	const struct sched_class	*sched_class;
 
 #ifdef CONFIG_SCHED_CORE
diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index a05dfcf533b0..65b1740a9a07 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -1,9 +1,148 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
 #ifndef _LINUX_SCHED_EXT_H
 #define _LINUX_SCHED_EXT_H
 
 #ifdef CONFIG_SCHED_CLASS_EXT
-#error "NOT IMPLEMENTED YET"
+
+#include <linux/rhashtable.h>
+#include <linux/llist.h>
+
+enum scx_public_consts {
+	SCX_OPS_NAME_LEN	= 128,
+
+	SCX_SLICE_DFL		= 20 * NSEC_PER_MSEC,
+};
+
+/*
+ * DSQ (dispatch queue) IDs are 64bit of the format:
+ *
+ *   Bits: [63] [62 ..  0]
+ *         [ B] [   ID   ]
+ *
+ *    B: 1 for IDs for built-in DSQs, 0 for ops-created user DSQs
+ *   ID: 63 bit ID
+ *
+ * Built-in IDs:
+ *
+ *   Bits: [63] [62] [61..32] [31 ..  0]
+ *         [ 1] [ L] [   R  ] [    V   ]
+ *
+ *    1: 1 for built-in DSQs.
+ *    L: 1 for LOCAL_ON DSQ IDs, 0 for others
+ *    V: For LOCAL_ON DSQ IDs, a CPU number. For others, a pre-defined value.
+ */
+enum scx_dsq_id_flags {
+	SCX_DSQ_FLAG_BUILTIN	= 1LLU << 63,
+	SCX_DSQ_FLAG_LOCAL_ON	= 1LLU << 62,
+
+	SCX_DSQ_INVALID		= SCX_DSQ_FLAG_BUILTIN | 0,
+	SCX_DSQ_GLOBAL		= SCX_DSQ_FLAG_BUILTIN | 1,
+	SCX_DSQ_LOCAL		= SCX_DSQ_FLAG_BUILTIN | 2,
+	SCX_DSQ_LOCAL_ON	= SCX_DSQ_FLAG_BUILTIN | SCX_DSQ_FLAG_LOCAL_ON,
+	SCX_DSQ_LOCAL_CPU_MASK	= 0xffffffffLLU,
+};
+
+/*
+ * Dispatch queue (dsq) is a simple FIFO which is used to buffer between the
+ * scheduler core and the BPF scheduler. See the documentation for more details.
+ */
+struct scx_dispatch_q {
+	raw_spinlock_t		lock;
+	struct list_head	list;	/* tasks in dispatch order */
+	u32			nr;
+	u64			id;
+	struct rhash_head	hash_node;
+	struct llist_node	free_node;
+	struct rcu_head		rcu;
+};
+
+/* scx_entity.flags */
+enum scx_ent_flags {
+	SCX_TASK_QUEUED		= 1 << 0, /* on ext runqueue */
+	SCX_TASK_BAL_KEEP	= 1 << 1, /* balance decided to keep current */
+	SCX_TASK_RESET_RUNNABLE_AT = 1 << 2, /* runnable_at should be reset */
+	SCX_TASK_DEQD_FOR_SLEEP	= 1 << 3, /* last dequeue was for SLEEP */
+
+	SCX_TASK_STATE_SHIFT	= 8,	  /* bit 8 and 9 are used to carry scx_task_state */
+	SCX_TASK_STATE_BITS	= 2,
+	SCX_TASK_STATE_MASK	= ((1 << SCX_TASK_STATE_BITS) - 1) << SCX_TASK_STATE_SHIFT,
+
+	SCX_TASK_CURSOR		= 1 << 31, /* iteration cursor, not a task */
+};
+
+/* scx_entity.flags & SCX_TASK_STATE_MASK */
+enum scx_task_state {
+	SCX_TASK_NONE,		/* ops.init_task() not called yet */
+	SCX_TASK_INIT,		/* ops.init_task() succeeded, but task can be cancelled */
+	SCX_TASK_READY,		/* fully initialized, but not in sched_ext */
+	SCX_TASK_ENABLED,	/* fully initialized and in sched_ext */
+
+	SCX_TASK_NR_STATES,
+};
+
+/*
+ * Mask bits for scx_entity.kf_mask. Not all kfuncs can be called from
+ * everywhere and the following bits track which kfunc sets are currently
+ * allowed for %current. This simple per-task tracking works because SCX ops
+ * nest in a limited way. BPF will likely implement a way to allow and disallow
+ * kfuncs depending on the calling context which will replace this manual
+ * mechanism. See scx_kf_allow().
+ */
+enum scx_kf_mask {
+	SCX_KF_UNLOCKED		= 0,	  /* not sleepable, not rq locked */
+	/* all non-sleepables may be nested inside SLEEPABLE */
+	SCX_KF_SLEEPABLE	= 1 << 0, /* sleepable init operations */
+	/* ops.dequeue (in REST) may be nested inside DISPATCH */
+	SCX_KF_DISPATCH		= 1 << 2, /* ops.dispatch() */
+	SCX_KF_ENQUEUE		= 1 << 3, /* ops.enqueue() and ops.select_cpu() */
+	SCX_KF_SELECT_CPU	= 1 << 4, /* ops.select_cpu() */
+	SCX_KF_REST		= 1 << 5, /* other rq-locked operations */
+
+	__SCX_KF_RQ_LOCKED	= SCX_KF_DISPATCH |
+				  SCX_KF_ENQUEUE | SCX_KF_SELECT_CPU | SCX_KF_REST,
+};
+
+/*
+ * The following is embedded in task_struct and contains all fields necessary
+ * for a task to be scheduled by SCX.
+ */
+struct sched_ext_entity {
+	struct scx_dispatch_q	*dsq;
+	struct list_head	dsq_node;
+	u32			flags;		/* protected by rq lock */
+	u32			weight;
+	s32			sticky_cpu;
+	s32			holding_cpu;
+	u32			kf_mask;	/* see scx_kf_mask above */
+	atomic_long_t		ops_state;
+
+	struct list_head	runnable_node;	/* rq->scx.runnable_list */
+
+	u64			ddsp_dsq_id;
+	u64			ddsp_enq_flags;
+
+	/* BPF scheduler modifiable fields */
+
+	/*
+	 * Runtime budget in nsecs. This is usually set through
+	 * scx_bpf_dispatch() but can also be modified directly by the BPF
+	 * scheduler. Automatically decreased by SCX as the task executes. On
+	 * depletion, a scheduling event is triggered.
+	 */
+	u64			slice;
+
+	/* cold fields */
+	/* must be the last field, see init_scx_entity() */
+	struct list_head	tasks_node;
+};
+
+void sched_ext_free(struct task_struct *p);
+
 #else	/* !CONFIG_SCHED_CLASS_EXT */
 
 static inline void sched_ext_free(struct task_struct *p) {}
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 3bac0a8ceab2..359a14cc76a4 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -118,6 +118,7 @@ struct clone_args {
 /* SCHED_ISO: reserved but not implemented yet */
 #define SCHED_IDLE		5
 #define SCHED_DEADLINE		6
+#define SCHED_EXT		7
 
 /* Can be ORed in to make sure the process is reverted back to SCHED_NORMAL on fork */
 #define SCHED_RESET_ON_FORK     0x40000000
diff --git a/init/init_task.c b/init/init_task.c
index 4daee6d761c8..ef349ebe52f8 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -6,6 +6,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/sched/rt.h>
 #include <linux/sched/task.h>
+#include <linux/sched/ext.h>
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
@@ -97,6 +98,16 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 #endif
 #ifdef CONFIG_CGROUP_SCHED
 	.sched_task_group = &root_task_group,
+#endif
+#ifdef CONFIG_SCHED_CLASS_EXT
+	.scx		= {
+		.dsq_node	= LIST_HEAD_INIT(init_task.scx.dsq_node),
+		.sticky_cpu	= -1,
+		.holding_cpu	= -1,
+		.runnable_node	= LIST_HEAD_INIT(init_task.scx.runnable_node),
+		.ddsp_dsq_id	= SCX_DSQ_INVALID,
+		.slice		= SCX_SLICE_DFL,
+	},
 #endif
 	.ptraced	= LIST_HEAD_INIT(init_task.ptraced),
 	.ptrace_entry	= LIST_HEAD_INIT(init_task.ptrace_entry),
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index c2f1fd95a821..0afcda19bc50 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -133,4 +133,24 @@ config SCHED_CORE
 	  which is the likely usage by Linux distributions, there should
 	  be no measurable impact on performance.
 
-
+config SCHED_CLASS_EXT
+	bool "Extensible Scheduling Class"
+	depends on BPF_SYSCALL && BPF_JIT && !SCHED_CORE
+	help
+	  This option enables a new scheduler class sched_ext (SCX), which
+	  allows scheduling policies to be implemented as BPF programs to
+	  achieve the following:
+
+	  - Ease of experimentation and exploration: Enabling rapid
+	    iteration of new scheduling policies.
+	  - Customization: Building application-specific schedulers which
+	    implement policies that are not applicable to general-purpose
+	    schedulers.
+	  - Rapid scheduler deployments: Non-disruptive swap outs of
+	    scheduling policies in production environments.
+
+	  sched_ext leverages BPF’s struct_ops feature to define a structure
+	  which exports function callbacks and flags to BPF programs that
+	  wish to implement scheduling policies. The struct_ops structure
+	  exported by sched_ext is struct sched_ext_ops, and is conceptually
+	  similar to struct sched_class.
diff --git a/kernel/sched/build_policy.c b/kernel/sched/build_policy.c
index d9dc9ab3773f..2a2f10367ceb 100644
--- a/kernel/sched/build_policy.c
+++ b/kernel/sched/build_policy.c
@@ -21,13 +21,17 @@
 
 #include <linux/cpuidle.h>
 #include <linux/jiffies.h>
+#include <linux/kobject.h>
 #include <linux/livepatch.h>
+#include <linux/pm.h>
 #include <linux/psi.h>
+#include <linux/seq_buf.h>
 #include <linux/seqlock_api.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
 #include <linux/tsacct_kern.h>
 #include <linux/vtime.h>
+#include <linux/percpu-rwsem.h>
 
 #include <uapi/linux/sched/types.h>
 
@@ -52,3 +56,6 @@
 #include "cputime.c"
 #include "deadline.c"
 
+#ifdef CONFIG_SCHED_CLASS_EXT
+# include "ext.c"
+#endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0231905ec827..ef8fa67c58de 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1259,7 +1259,7 @@ bool sched_can_stop_tick(struct rq *rq)
 	 * if there's more than one we need the tick for involuntary
 	 * preemption.
 	 */
-	if (rq->nr_running > 1)
+	if (!scx_switched_all() && rq->nr_running > 1)
 		return false;
 
 	/*
@@ -3997,6 +3997,15 @@ bool cpus_share_resources(int this_cpu, int that_cpu)
 
 static inline bool ttwu_queue_cond(struct task_struct *p, int cpu)
 {
+	/*
+	 * The BPF scheduler may depend on select_task_rq() being invoked during
+	 * wakeups. In addition, @p may end up executing on a different CPU
+	 * regardless of what happens in the wakeup path making the ttwu_queue
+	 * optimization less meaningful. Skip if on SCX.
+	 */
+	if (task_on_scx(p))
+		return false;
+
 	/*
 	 * Do not complicate things with the async wake_list while the CPU is
 	 * in hotplug state.
@@ -4564,6 +4573,10 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->rt.on_rq		= 0;
 	p->rt.on_list		= 0;
 
+#ifdef CONFIG_SCHED_CLASS_EXT
+	init_scx_entity(&p->scx);
+#endif
+
 #ifdef CONFIG_PREEMPT_NOTIFIERS
 	INIT_HLIST_HEAD(&p->preempt_notifiers);
 #endif
@@ -4812,6 +4825,10 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 		goto out_cancel;
 	} else if (rt_prio(p->prio)) {
 		p->sched_class = &rt_sched_class;
+#ifdef CONFIG_SCHED_CLASS_EXT
+	} else if (task_should_scx(p)) {
+		p->sched_class = &ext_sched_class;
+#endif
 	} else {
 		p->sched_class = &fair_sched_class;
 	}
@@ -5728,8 +5745,10 @@ void scheduler_tick(void)
 		wq_worker_tick(curr);
 
 #ifdef CONFIG_SMP
-	rq->idle_balance = idle_cpu(cpu);
-	trigger_load_balance(rq);
+	if (!scx_switched_all()) {
+		rq->idle_balance = idle_cpu(cpu);
+		trigger_load_balance(rq);
+	}
 #endif
 }
 
@@ -7119,6 +7138,10 @@ void __setscheduler_prio(struct task_struct *p, int prio)
 		p->sched_class = &dl_sched_class;
 	else if (rt_prio(prio))
 		p->sched_class = &rt_sched_class;
+#ifdef CONFIG_SCHED_CLASS_EXT
+	else if (task_should_scx(p))
+		p->sched_class = &ext_sched_class;
+#endif
 	else
 		p->sched_class = &fair_sched_class;
 
@@ -9120,6 +9143,7 @@ SYSCALL_DEFINE1(sched_get_priority_max, int, policy)
 	case SCHED_NORMAL:
 	case SCHED_BATCH:
 	case SCHED_IDLE:
+	case SCHED_EXT:
 		ret = 0;
 		break;
 	}
@@ -9147,6 +9171,7 @@ SYSCALL_DEFINE1(sched_get_priority_min, int, policy)
 	case SCHED_NORMAL:
 	case SCHED_BATCH:
 	case SCHED_IDLE:
+	case SCHED_EXT:
 		ret = 0;
 	}
 	return ret;
@@ -9983,6 +10008,10 @@ void __init sched_init(void)
 	BUG_ON(!sched_class_above(&dl_sched_class, &rt_sched_class));
 	BUG_ON(!sched_class_above(&rt_sched_class, &fair_sched_class));
 	BUG_ON(!sched_class_above(&fair_sched_class, &idle_sched_class));
+#ifdef CONFIG_SCHED_CLASS_EXT
+	BUG_ON(!sched_class_above(&fair_sched_class, &ext_sched_class));
+	BUG_ON(!sched_class_above(&ext_sched_class, &idle_sched_class));
+#endif
 
 	wait_bit_init();
 
@@ -12112,3 +12141,38 @@ void sched_mm_cid_fork(struct task_struct *t)
 	t->mm_cid_active = 1;
 }
 #endif
+
+#ifdef CONFIG_SCHED_CLASS_EXT
+void sched_deq_and_put_task(struct task_struct *p, int queue_flags,
+			    struct sched_enq_and_set_ctx *ctx)
+{
+	struct rq *rq = task_rq(p);
+
+	lockdep_assert_rq_held(rq);
+
+	*ctx = (struct sched_enq_and_set_ctx){
+		.p = p,
+		.queue_flags = queue_flags,
+		.queued = task_on_rq_queued(p),
+		.running = task_current(rq, p),
+	};
+
+	update_rq_clock(rq);
+	if (ctx->queued)
+		dequeue_task(rq, p, queue_flags | DEQUEUE_NOCLOCK);
+	if (ctx->running)
+		put_prev_task(rq, p);
+}
+
+void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx)
+{
+	struct rq *rq = task_rq(ctx->p);
+
+	lockdep_assert_rq_held(rq);
+
+	if (ctx->queued)
+		enqueue_task(rq, ctx->p, ctx->queue_flags | ENQUEUE_NOCLOCK);
+	if (ctx->running)
+		set_next_task(rq, ctx->p);
+}
+#endif	/* CONFIG_SCHED_CLASS_EXT */
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 8d5d98a5834d..6f306e1c9c3e 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1089,6 +1089,9 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 		P(dl.runtime);
 		P(dl.deadline);
 	}
+#ifdef CONFIG_SCHED_CLASS_EXT
+	__PS("ext.enabled", task_on_scx(p));
+#endif
 #undef PN_SCHEDSTAT
 #undef P_SCHEDSTAT
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
new file mode 100644
index 000000000000..d4f52209111f
--- /dev/null
+++ b/kernel/sched/ext.c
@@ -0,0 +1,4238 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#define SCX_OP_IDX(op)		(offsetof(struct sched_ext_ops, op) / sizeof(void (*)(void)))
+
+enum scx_consts {
+	SCX_DSP_DFL_MAX_BATCH		= 32,
+
+	SCX_EXIT_BT_LEN			= 64,
+	SCX_EXIT_MSG_LEN		= 1024,
+};
+
+enum scx_exit_kind {
+	SCX_EXIT_NONE,
+	SCX_EXIT_DONE,
+
+	SCX_EXIT_UNREG = 64,	/* user-space initiated unregistration */
+	SCX_EXIT_UNREG_BPF,	/* BPF-initiated unregistration */
+	SCX_EXIT_UNREG_KERN,	/* kernel-initiated unregistration */
+
+	SCX_EXIT_ERROR = 1024,	/* runtime error, error msg contains details */
+	SCX_EXIT_ERROR_BPF,	/* ERROR but triggered through scx_bpf_error() */
+};
+
+/*
+ * scx_exit_info is passed to ops.exit() to describe why the BPF scheduler is
+ * being disabled.
+ */
+struct scx_exit_info {
+	/* %SCX_EXIT_* - broad category of the exit reason */
+	enum scx_exit_kind	kind;
+
+	/* exit code if gracefully exiting */
+	s64			exit_code;
+
+	/* textual representation of the above */
+	const char		*reason;
+
+	/* backtrace if exiting due to an error */
+	unsigned long		*bt;
+	u32			bt_len;
+
+	/* informational message */
+	char			*msg;
+};
+
+/* sched_ext_ops.flags */
+enum scx_ops_flags {
+	/*
+	 * Keep built-in idle tracking even if ops.update_idle() is implemented.
+	 */
+	SCX_OPS_KEEP_BUILTIN_IDLE = 1LLU << 0,
+
+	/*
+	 * By default, if there are no other task to run on the CPU, ext core
+	 * keeps running the current task even after its slice expires. If this
+	 * flag is specified, such tasks are passed to ops.enqueue() with
+	 * %SCX_ENQ_LAST. See the comment above %SCX_ENQ_LAST for more info.
+	 */
+	SCX_OPS_ENQ_LAST	= 1LLU << 1,
+
+	/*
+	 * An exiting task may schedule after PF_EXITING is set. In such cases,
+	 * bpf_task_from_pid() may not be able to find the task and if the BPF
+	 * scheduler depends on pid lookup for dispatching, the task will be
+	 * lost leading to various issues including RCU grace period stalls.
+	 *
+	 * To mask this problem, by default, unhashed tasks are automatically
+	 * dispatched to the local DSQ on enqueue. If the BPF scheduler doesn't
+	 * depend on pid lookups and wants to handle these tasks directly, the
+	 * following flag can be used.
+	 */
+	SCX_OPS_ENQ_EXITING	= 1LLU << 2,
+
+	/*
+	 * If set, only tasks with policy set to SCHED_EXT are attached to
+	 * sched_ext. If clear, SCHED_NORMAL tasks are also included.
+	 */
+	SCX_OPS_SWITCH_PARTIAL	= 1LLU << 3,
+
+	SCX_OPS_ALL_FLAGS	= SCX_OPS_KEEP_BUILTIN_IDLE |
+				  SCX_OPS_ENQ_LAST |
+				  SCX_OPS_ENQ_EXITING |
+				  SCX_OPS_SWITCH_PARTIAL,
+};
+
+/* argument container for ops.init_task() */
+struct scx_init_task_args {
+	/*
+	 * Set if ops.init_task() is being invoked on the fork path, as opposed
+	 * to the scheduler transition path.
+	 */
+	bool			fork;
+};
+
+/* argument container for ops.exit_task() */
+struct scx_exit_task_args {
+	/* Whether the task exited before running on sched_ext. */
+	bool cancelled;
+};
+
+/**
+ * struct sched_ext_ops - Operation table for BPF scheduler implementation
+ *
+ * Userland can implement an arbitrary scheduling policy by implementing and
+ * loading operations in this table.
+ */
+struct sched_ext_ops {
+	/**
+	 * select_cpu - Pick the target CPU for a task which is being woken up
+	 * @p: task being woken up
+	 * @prev_cpu: the cpu @p was on before sleeping
+	 * @wake_flags: SCX_WAKE_*
+	 *
+	 * Decision made here isn't final. @p may be moved to any CPU while it
+	 * is getting dispatched for execution later. However, as @p is not on
+	 * the rq at this point, getting the eventual execution CPU right here
+	 * saves a small bit of overhead down the line.
+	 *
+	 * If an idle CPU is returned, the CPU is kicked and will try to
+	 * dispatch. While an explicit custom mechanism can be added,
+	 * select_cpu() serves as the default way to wake up idle CPUs.
+	 *
+	 * @p may be dispatched directly by calling scx_bpf_dispatch(). If @p
+	 * is dispatched, the ops.enqueue() callback will be skipped. Finally,
+	 * if @p is dispatched to SCX_DSQ_LOCAL, it will be dispatched to the
+	 * local DSQ of whatever CPU is returned by this callback.
+	 */
+	s32 (*select_cpu)(struct task_struct *p, s32 prev_cpu, u64 wake_flags);
+
+	/**
+	 * enqueue - Enqueue a task on the BPF scheduler
+	 * @p: task being enqueued
+	 * @enq_flags: %SCX_ENQ_*
+	 *
+	 * @p is ready to run. Dispatch directly by calling scx_bpf_dispatch()
+	 * or enqueue on the BPF scheduler. If not directly dispatched, the bpf
+	 * scheduler owns @p and if it fails to dispatch @p, the task will
+	 * stall.
+	 *
+	 * If @p was dispatched from ops.select_cpu(), this callback is
+	 * skipped.
+	 */
+	void (*enqueue)(struct task_struct *p, u64 enq_flags);
+
+	/**
+	 * dequeue - Remove a task from the BPF scheduler
+	 * @p: task being dequeued
+	 * @deq_flags: %SCX_DEQ_*
+	 *
+	 * Remove @p from the BPF scheduler. This is usually called to isolate
+	 * the task while updating its scheduling properties (e.g. priority).
+	 *
+	 * The ext core keeps track of whether the BPF side owns a given task or
+	 * not and can gracefully ignore spurious dispatches from BPF side,
+	 * which makes it safe to not implement this method. However, depending
+	 * on the scheduling logic, this can lead to confusing behaviors - e.g.
+	 * scheduling position not being updated across a priority change.
+	 */
+	void (*dequeue)(struct task_struct *p, u64 deq_flags);
+
+	/**
+	 * dispatch - Dispatch tasks from the BPF scheduler and/or consume DSQs
+	 * @cpu: CPU to dispatch tasks for
+	 * @prev: previous task being switched out
+	 *
+	 * Called when a CPU's local dsq is empty. The operation should dispatch
+	 * one or more tasks from the BPF scheduler into the DSQs using
+	 * scx_bpf_dispatch() and/or consume user DSQs into the local DSQ using
+	 * scx_bpf_consume().
+	 *
+	 * The maximum number of times scx_bpf_dispatch() can be called without
+	 * an intervening scx_bpf_consume() is specified by
+	 * ops.dispatch_max_batch. See the comments on top of the two functions
+	 * for more details.
+	 *
+	 * When not %NULL, @prev is an SCX task with its slice depleted. If
+	 * @prev is still runnable as indicated by set %SCX_TASK_QUEUED in
+	 * @prev->scx.flags, it is not enqueued yet and will be enqueued after
+	 * ops.dispatch() returns. To keep executing @prev, return without
+	 * dispatching or consuming any tasks. Also see %SCX_OPS_ENQ_LAST.
+	 */
+	void (*dispatch)(s32 cpu, struct task_struct *prev);
+
+	/**
+	 * tick - Periodic tick
+	 * @p: task running currently
+	 *
+	 * This operation is called every 1/HZ seconds on CPUs which are
+	 * executing an SCX task. Setting @p->scx.slice to 0 will trigger an
+	 * immediate dispatch cycle on the CPU.
+	 */
+	void (*tick)(struct task_struct *p);
+
+	/**
+	 * yield - Yield CPU
+	 * @from: yielding task
+	 * @to: optional yield target task
+	 *
+	 * If @to is NULL, @from is yielding the CPU to other runnable tasks.
+	 * The BPF scheduler should ensure that other available tasks are
+	 * dispatched before the yielding task. Return value is ignored in this
+	 * case.
+	 *
+	 * If @to is not-NULL, @from wants to yield the CPU to @to. If the bpf
+	 * scheduler can implement the request, return %true; otherwise, %false.
+	 */
+	bool (*yield)(struct task_struct *from, struct task_struct *to);
+
+	/**
+	 * set_weight - Set task weight
+	 * @p: task to set weight for
+	 * @weight: new eight [1..10000]
+	 *
+	 * Update @p's weight to @weight.
+	 */
+	void (*set_weight)(struct task_struct *p, u32 weight);
+
+	/**
+	 * set_cpumask - Set CPU affinity
+	 * @p: task to set CPU affinity for
+	 * @cpumask: cpumask of cpus that @p can run on
+	 *
+	 * Update @p's CPU affinity to @cpumask.
+	 */
+	void (*set_cpumask)(struct task_struct *p,
+			    const struct cpumask *cpumask);
+
+	/**
+	 * update_idle - Update the idle state of a CPU
+	 * @cpu: CPU to udpate the idle state for
+	 * @idle: whether entering or exiting the idle state
+	 *
+	 * This operation is called when @rq's CPU goes or leaves the idle
+	 * state. By default, implementing this operation disables the built-in
+	 * idle CPU tracking and the following helpers become unavailable:
+	 *
+	 * - scx_bpf_select_cpu_dfl()
+	 * - scx_bpf_test_and_clear_cpu_idle()
+	 * - scx_bpf_pick_idle_cpu()
+	 *
+	 * The user also must implement ops.select_cpu() as the default
+	 * implementation relies on scx_bpf_select_cpu_dfl().
+	 *
+	 * Specify the %SCX_OPS_KEEP_BUILTIN_IDLE flag to keep the built-in idle
+	 * tracking.
+	 */
+	void (*update_idle)(s32 cpu, bool idle);
+
+	/**
+	 * init_task - Initialize a task to run in a BPF scheduler
+	 * @p: task to initialize for BPF scheduling
+	 * @args: init arguments, see the struct definition
+	 *
+	 * Either we're loading a BPF scheduler or a new task is being forked.
+	 * Initialize @p for BPF scheduling. This operation may block and can
+	 * be used for allocations, and is called exactly once for a task.
+	 *
+	 * Return 0 for success, -errno for failure. An error return while
+	 * loading will abort loading of the BPF scheduler. During a fork, it
+	 * will abort that specific fork.
+	 */
+	s32 (*init_task)(struct task_struct *p, struct scx_init_task_args *args);
+
+	/**
+	 * exit_task - Exit a previously-running task from the system
+	 * @p: task to exit
+	 *
+	 * @p is exiting or the BPF scheduler is being unloaded. Perform any
+	 * necessary cleanup for @p.
+	 */
+	void (*exit_task)(struct task_struct *p, struct scx_exit_task_args *args);
+
+	/**
+	 * enable - Enable BPF scheduling for a task
+	 * @p: task to enable BPF scheduling for
+	 *
+	 * Enable @p for BPF scheduling. enable() is called on @p any time it
+	 * enters SCX, and is always paired with a matching disable().
+	 */
+	void (*enable)(struct task_struct *p);
+
+	/**
+	 * disable - Disable BPF scheduling for a task
+	 * @p: task to disable BPF scheduling for
+	 *
+	 * @p is exiting, leaving SCX or the BPF scheduler is being unloaded.
+	 * Disable BPF scheduling for @p. A disable() call is always matched
+	 * with a prior enable() call.
+	 */
+	void (*disable)(struct task_struct *p);
+
+	/*
+	 * All online ops must come before ops.init().
+	 */
+
+	/**
+	 * init - Initialize the BPF scheduler
+	 */
+	s32 (*init)(void);
+
+	/**
+	 * exit - Clean up after the BPF scheduler
+	 * @info: Exit info
+	 */
+	void (*exit)(struct scx_exit_info *info);
+
+	/**
+	 * dispatch_max_batch - Max nr of tasks that dispatch() can dispatch
+	 */
+	u32 dispatch_max_batch;
+
+	/**
+	 * flags - %SCX_OPS_* flags
+	 */
+	u64 flags;
+
+	/**
+	 * name - BPF scheduler's name
+	 *
+	 * Must be a non-zero valid BPF object name including only isalnum(),
+	 * '_' and '.' chars. Shows up in kernel.sched_ext_ops sysctl while the
+	 * BPF scheduler is enabled.
+	 */
+	char name[SCX_OPS_NAME_LEN];
+};
+
+enum scx_opi {
+	SCX_OPI_BEGIN			= 0,
+	SCX_OPI_NORMAL_BEGIN		= 0,
+	SCX_OPI_NORMAL_END		= SCX_OP_IDX(init),
+	SCX_OPI_END			= SCX_OP_IDX(init),
+};
+
+enum scx_wake_flags {
+	/* expose select WF_* flags as enums */
+	SCX_WAKE_FORK		= WF_FORK,
+	SCX_WAKE_TTWU		= WF_TTWU,
+	SCX_WAKE_SYNC		= WF_SYNC,
+};
+
+enum scx_enq_flags {
+	/* expose select ENQUEUE_* flags as enums */
+	SCX_ENQ_WAKEUP		= ENQUEUE_WAKEUP,
+	SCX_ENQ_HEAD		= ENQUEUE_HEAD,
+
+	/* high 32bits are SCX specific */
+
+	/*
+	 * The task being enqueued is the only task available for the cpu. By
+	 * default, ext core keeps executing such tasks but when
+	 * %SCX_OPS_ENQ_LAST is specified, they're ops.enqueue()'d with the
+	 * %SCX_ENQ_LAST flag set.
+	 *
+	 * If the BPF scheduler wants to continue executing the task,
+	 * ops.enqueue() should dispatch the task to %SCX_DSQ_LOCAL immediately.
+	 * If the task gets queued on a different dsq or the BPF side, the BPF
+	 * scheduler is responsible for triggering a follow-up scheduling event.
+	 * Otherwise, Execution may stall.
+	 */
+	SCX_ENQ_LAST		= 1LLU << 41,
+
+	/* high 8 bits are internal */
+	__SCX_ENQ_INTERNAL_MASK	= 0xffLLU << 56,
+
+	SCX_ENQ_CLEAR_OPSS	= 1LLU << 56,
+};
+
+enum scx_deq_flags {
+	/* expose select DEQUEUE_* flags as enums */
+	SCX_DEQ_SLEEP		= DEQUEUE_SLEEP,
+};
+
+enum scx_pick_idle_cpu_flags {
+	SCX_PICK_IDLE_CORE	= 1LLU << 0,	/* pick a CPU whose SMT siblings are also idle */
+};
+
+enum scx_ops_enable_state {
+	SCX_OPS_PREPPING,
+	SCX_OPS_ENABLING,
+	SCX_OPS_ENABLED,
+	SCX_OPS_DISABLING,
+	SCX_OPS_DISABLED,
+};
+
+static const char *scx_ops_enable_state_str[] = {
+	[SCX_OPS_PREPPING]	= "prepping",
+	[SCX_OPS_ENABLING]	= "enabling",
+	[SCX_OPS_ENABLED]	= "enabled",
+	[SCX_OPS_DISABLING]	= "disabling",
+	[SCX_OPS_DISABLED]	= "disabled",
+};
+
+/*
+ * sched_ext_entity->ops_state
+ *
+ * Used to track the task ownership between the SCX core and the BPF scheduler.
+ * State transitions look as follows:
+ *
+ * NONE -> QUEUEING -> QUEUED -> DISPATCHING
+ *   ^              |                 |
+ *   |              v                 v
+ *   \-------------------------------/
+ *
+ * QUEUEING and DISPATCHING states can be waited upon. See wait_ops_state() call
+ * sites for explanations on the conditions being waited upon and why they are
+ * safe. Transitions out of them into NONE or QUEUED must store_release and the
+ * waiters should load_acquire.
+ *
+ * Tracking scx_ops_state enables sched_ext core to reliably determine whether
+ * any given task can be dispatched by the BPF scheduler at all times and thus
+ * relaxes the requirements on the BPF scheduler. This allows the BPF scheduler
+ * to try to dispatch any task anytime regardless of its state as the SCX core
+ * can safely reject invalid dispatches.
+ */
+enum scx_ops_state {
+	SCX_OPSS_NONE,		/* owned by the SCX core */
+	SCX_OPSS_QUEUEING,	/* in transit to the BPF scheduler */
+	SCX_OPSS_QUEUED,	/* owned by the BPF scheduler */
+	SCX_OPSS_DISPATCHING,	/* in transit back to the SCX core */
+
+	/*
+	 * QSEQ brands each QUEUED instance so that, when dispatch races
+	 * dequeue/requeue, the dispatcher can tell whether it still has a claim
+	 * on the task being dispatched.
+	 *
+	 * As some 32bit archs can't do 64bit store_release/load_acquire,
+	 * p->scx.ops_state is atomic_long_t which leaves 30 bits for QSEQ on
+	 * 32bit machines. The dispatch race window QSEQ protects is very narrow
+	 * and runs with IRQ disabled. 30 bits should be sufficient.
+	 */
+	SCX_OPSS_QSEQ_SHIFT	= 2,
+};
+
+/* Use macros to ensure that the type is unsigned long for the masks */
+#define SCX_OPSS_STATE_MASK	((1LU << SCX_OPSS_QSEQ_SHIFT) - 1)
+#define SCX_OPSS_QSEQ_MASK	(~SCX_OPSS_STATE_MASK)
+
+/*
+ * During exit, a task may schedule after losing its PIDs. When disabling the
+ * BPF scheduler, we need to be able to iterate tasks in every state to
+ * guarantee system safety. Maintain a dedicated task list which contains every
+ * task between its fork and eventual free.
+ */
+static DEFINE_SPINLOCK(scx_tasks_lock);
+static LIST_HEAD(scx_tasks);
+
+/* ops enable/disable */
+static struct kthread_worker *scx_ops_helper;
+static DEFINE_MUTEX(scx_ops_enable_mutex);
+DEFINE_STATIC_KEY_FALSE(__scx_ops_enabled);
+DEFINE_STATIC_PERCPU_RWSEM(scx_fork_rwsem);
+static atomic_t scx_ops_enable_state_var = ATOMIC_INIT(SCX_OPS_DISABLED);
+static atomic_t scx_ops_bypass_depth = ATOMIC_INIT(0);
+static bool scx_switching_all;
+DEFINE_STATIC_KEY_FALSE(__scx_switched_all);
+
+static struct sched_ext_ops scx_ops;
+static bool scx_warned_zero_slice;
+
+static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_last);
+static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_exiting);
+static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
+
+struct static_key_false scx_has_op[SCX_OPI_END] =
+	{ [0 ... SCX_OPI_END-1] = STATIC_KEY_FALSE_INIT };
+
+static atomic_t scx_exit_kind = ATOMIC_INIT(SCX_EXIT_DONE);
+static struct scx_exit_info *scx_exit_info;
+
+/* idle tracking */
+#ifdef CONFIG_SMP
+#ifdef CONFIG_CPUMASK_OFFSTACK
+#define CL_ALIGNED_IF_ONSTACK
+#else
+#define CL_ALIGNED_IF_ONSTACK __cacheline_aligned_in_smp
+#endif
+
+static struct {
+	cpumask_var_t cpu;
+	cpumask_var_t smt;
+} idle_masks CL_ALIGNED_IF_ONSTACK;
+
+#endif	/* CONFIG_SMP */
+
+/*
+ * Direct dispatch marker.
+ *
+ * Non-NULL values are used for direct dispatch from enqueue path. A valid
+ * pointer points to the task currently being enqueued. An ERR_PTR value is used
+ * to indicate that direct dispatch has already happened.
+ */
+static DEFINE_PER_CPU(struct task_struct *, direct_dispatch_task);
+
+/* dispatch queues */
+static struct scx_dispatch_q __cacheline_aligned_in_smp scx_dsq_global;
+
+static const struct rhashtable_params dsq_hash_params = {
+	.key_len		= 8,
+	.key_offset		= offsetof(struct scx_dispatch_q, id),
+	.head_offset		= offsetof(struct scx_dispatch_q, hash_node),
+};
+
+static struct rhashtable dsq_hash;
+static LLIST_HEAD(dsqs_to_free);
+
+/* dispatch buf */
+struct scx_dsp_buf_ent {
+	struct task_struct	*task;
+	unsigned long		qseq;
+	u64			dsq_id;
+	u64			enq_flags;
+};
+
+static u32 scx_dsp_max_batch;
+static struct scx_dsp_buf_ent __percpu *scx_dsp_buf;
+
+struct scx_dsp_ctx {
+	struct rq		*rq;
+	struct rq_flags		*rf;
+	u32			buf_cursor;
+	u32			nr_tasks;
+};
+
+static DEFINE_PER_CPU(struct scx_dsp_ctx, scx_dsp_ctx);
+
+/* /sys/kernel/sched_ext interface */
+static struct kset *scx_kset;
+static struct kobject *scx_root_kobj;
+
+static __printf(3, 4) void scx_ops_exit_kind(enum scx_exit_kind kind,
+					     s64 exit_code,
+					     const char *fmt, ...);
+
+#define scx_ops_error_kind(err, fmt, args...)					\
+	scx_ops_exit_kind((err), 0, fmt, ##args)
+
+#define scx_ops_exit(code, fmt, args...)					\
+	scx_ops_exit_kind(SCX_EXIT_UNREG_KERN, (code), fmt, ##args)
+
+#define scx_ops_error(fmt, args...)						\
+	scx_ops_error_kind(SCX_EXIT_ERROR, fmt, ##args)
+
+#define SCX_HAS_OP(op)	static_branch_likely(&scx_has_op[SCX_OP_IDX(op)])
+
+/* if the highest set bit is N, return a mask with bits [N+1, 31] set */
+static u32 higher_bits(u32 flags)
+{
+	return ~((1 << fls(flags)) - 1);
+}
+
+/* return the mask with only the highest bit set */
+static u32 highest_bit(u32 flags)
+{
+	int bit = fls(flags);
+	return bit ? 1 << (bit - 1) : 0;
+}
+
+/*
+ * scx_kf_mask enforcement. Some kfuncs can only be called from specific SCX
+ * ops. When invoking SCX ops, SCX_CALL_OP[_RET]() should be used to indicate
+ * the allowed kfuncs and those kfuncs should use scx_kf_allowed() to check
+ * whether it's running from an allowed context.
+ *
+ * @mask is constant, always inline to cull the mask calculations.
+ */
+static __always_inline void scx_kf_allow(u32 mask)
+{
+	/* nesting is allowed only in increasing scx_kf_mask order */
+	WARN_ONCE((mask | higher_bits(mask)) & current->scx.kf_mask,
+		  "invalid nesting current->scx.kf_mask=0x%x mask=0x%x\n",
+		  current->scx.kf_mask, mask);
+	current->scx.kf_mask |= mask;
+	barrier();
+}
+
+static void scx_kf_disallow(u32 mask)
+{
+	barrier();
+	current->scx.kf_mask &= ~mask;
+}
+
+#define SCX_CALL_OP(mask, op, args...)						\
+do {										\
+	if (mask) {								\
+		scx_kf_allow(mask);						\
+		scx_ops.op(args);						\
+		scx_kf_disallow(mask);						\
+	} else {								\
+		scx_ops.op(args);						\
+	}									\
+} while (0)
+
+#define SCX_CALL_OP_RET(mask, op, args...)					\
+({										\
+	__typeof__(scx_ops.op(args)) __ret;					\
+	if (mask) {								\
+		scx_kf_allow(mask);						\
+		__ret = scx_ops.op(args);					\
+		scx_kf_disallow(mask);						\
+	} else {								\
+		__ret = scx_ops.op(args);					\
+	}									\
+	__ret;									\
+})
+
+/* @mask is constant, always inline to cull unnecessary branches */
+static __always_inline bool scx_kf_allowed(u32 mask)
+{
+	if (unlikely(!(current->scx.kf_mask & mask))) {
+		scx_ops_error("kfunc with mask 0x%x called from an operation only allowing 0x%x",
+			      mask, current->scx.kf_mask);
+		return false;
+	}
+
+	if (unlikely((mask & SCX_KF_SLEEPABLE) && in_interrupt())) {
+		scx_ops_error("sleepable kfunc called from non-sleepable context");
+		return false;
+	}
+
+	/*
+	 * Enforce nesting boundaries. e.g. A kfunc which can be called from
+	 * DISPATCH must not be called if we're running DEQUEUE which is nested
+	 * inside ops.dispatch(). We don't need to check the SCX_KF_SLEEPABLE
+	 * boundary thanks to the above in_interrupt() check.
+	 */
+	if (unlikely(highest_bit(mask) == SCX_KF_DISPATCH &&
+		     (current->scx.kf_mask & higher_bits(SCX_KF_DISPATCH)))) {
+		scx_ops_error("dispatch kfunc called from a nested operation");
+		return false;
+	}
+
+	return true;
+}
+
+
+/*
+ * SCX task iterator.
+ */
+struct scx_task_iter {
+	struct sched_ext_entity		cursor;
+	struct task_struct		*locked;
+	struct rq			*rq;
+	struct rq_flags			rf;
+};
+
+/**
+ * scx_task_iter_init - Initialize a task iterator
+ * @iter: iterator to init
+ *
+ * Initialize @iter. Must be called with scx_tasks_lock held. Once initialized,
+ * @iter must eventually be exited with scx_task_iter_exit().
+ *
+ * scx_tasks_lock may be released between this and the first next() call or
+ * between any two next() calls. If scx_tasks_lock is released between two
+ * next() calls, the caller is responsible for ensuring that the task being
+ * iterated remains accessible either through RCU read lock or obtaining a
+ * reference count.
+ *
+ * All tasks which existed when the iteration started are guaranteed to be
+ * visited as long as they still exist.
+ */
+static void scx_task_iter_init(struct scx_task_iter *iter)
+{
+	lockdep_assert_held(&scx_tasks_lock);
+
+	iter->cursor = (struct sched_ext_entity){ .flags = SCX_TASK_CURSOR };
+	list_add(&iter->cursor.tasks_node, &scx_tasks);
+	iter->locked = NULL;
+}
+
+/**
+ * scx_task_iter_exit - Exit a task iterator
+ * @iter: iterator to exit
+ *
+ * Exit a previously initialized @iter. Must be called with scx_tasks_lock held.
+ * If the iterator holds a task's rq lock, that rq lock is released. See
+ * scx_task_iter_init() for details.
+ */
+static void scx_task_iter_exit(struct scx_task_iter *iter)
+{
+	struct list_head *cursor = &iter->cursor.tasks_node;
+
+	lockdep_assert_held(&scx_tasks_lock);
+
+	if (iter->locked) {
+		task_rq_unlock(iter->rq, iter->locked, &iter->rf);
+		iter->locked = NULL;
+	}
+
+	if (list_empty(cursor))
+		return;
+
+	list_del_init(cursor);
+}
+
+/**
+ * scx_task_iter_next - Next task
+ * @iter: iterator to walk
+ *
+ * Visit the next task. See scx_task_iter_init() for details.
+ */
+static struct task_struct *scx_task_iter_next(struct scx_task_iter *iter)
+{
+	struct list_head *cursor = &iter->cursor.tasks_node;
+	struct sched_ext_entity *pos;
+
+	lockdep_assert_held(&scx_tasks_lock);
+
+	list_for_each_entry(pos, cursor, tasks_node) {
+		if (&pos->tasks_node == &scx_tasks)
+			return NULL;
+		if (!(pos->flags & SCX_TASK_CURSOR)) {
+			list_move(cursor, &pos->tasks_node);
+			return container_of(pos, struct task_struct, scx);
+		}
+	}
+
+	/* can't happen, should always terminate at scx_tasks above */
+	BUG();
+}
+
+/**
+ * scx_task_iter_next_filtered - Next non-idle task
+ * @iter: iterator to walk
+ *
+ * Visit the next non-idle task. See scx_task_iter_init() for details.
+ */
+static struct task_struct *
+scx_task_iter_next_filtered(struct scx_task_iter *iter)
+{
+	struct task_struct *p;
+
+	while ((p = scx_task_iter_next(iter))) {
+		/*
+		 * is_idle_task() tests %PF_IDLE which may not be set for CPUs
+		 * which haven't yet been onlined. Test sched_class directly.
+		 */
+		if (p->sched_class != &idle_sched_class)
+			return p;
+	}
+	return NULL;
+}
+
+/**
+ * scx_task_iter_next_filtered_locked - Next non-idle task with its rq locked
+ * @iter: iterator to walk
+ *
+ * Visit the next non-idle task with its rq lock held. See scx_task_iter_init()
+ * for details.
+ */
+static struct task_struct *
+scx_task_iter_next_filtered_locked(struct scx_task_iter *iter)
+{
+	struct task_struct *p;
+
+	if (iter->locked) {
+		task_rq_unlock(iter->rq, iter->locked, &iter->rf);
+		iter->locked = NULL;
+	}
+
+	p = scx_task_iter_next_filtered(iter);
+	if (!p)
+		return NULL;
+
+	iter->rq = task_rq_lock(p, &iter->rf);
+	iter->locked = p;
+	return p;
+}
+
+static enum scx_ops_enable_state scx_ops_enable_state(void)
+{
+	return atomic_read(&scx_ops_enable_state_var);
+}
+
+static enum scx_ops_enable_state
+scx_ops_set_enable_state(enum scx_ops_enable_state to)
+{
+	return atomic_xchg(&scx_ops_enable_state_var, to);
+}
+
+static bool scx_ops_tryset_enable_state(enum scx_ops_enable_state to,
+					enum scx_ops_enable_state from)
+{
+	int from_v = from;
+
+	return atomic_try_cmpxchg(&scx_ops_enable_state_var, &from_v, to);
+}
+
+static bool scx_ops_bypassing(void)
+{
+	return unlikely(atomic_read(&scx_ops_bypass_depth));
+}
+
+/**
+ * wait_ops_state - Busy-wait the specified ops state to end
+ * @p: target task
+ * @opss: state to wait the end of
+ *
+ * Busy-wait for @p to transition out of @opss. This can only be used when the
+ * state part of @opss is %SCX_QUEUEING or %SCX_DISPATCHING. This function also
+ * has load_acquire semantics to ensure that the caller can see the updates made
+ * in the enqueueing and dispatching paths.
+ */
+static void wait_ops_state(struct task_struct *p, unsigned long opss)
+{
+	do {
+		cpu_relax();
+	} while (atomic_long_read_acquire(&p->scx.ops_state) == opss);
+}
+
+/**
+ * ops_cpu_valid - Verify a cpu number
+ * @cpu: cpu number which came from a BPF ops
+ * @where: extra information reported on error
+ *
+ * @cpu is a cpu number which came from the BPF scheduler and can be any value.
+ * Verify that it is in range and one of the possible cpus. If invalid, trigger
+ * an ops error.
+ */
+static bool ops_cpu_valid(s32 cpu, const char *where)
+{
+	if (likely(cpu >= 0 && cpu < nr_cpu_ids && cpu_possible(cpu))) {
+		return true;
+	} else {
+		scx_ops_error("invalid CPU %d%s%s", cpu,
+			      where ? " " : "", where ?: "");
+		return false;
+	}
+}
+
+/**
+ * ops_sanitize_err - Sanitize a -errno value
+ * @ops_name: operation to blame on failure
+ * @err: -errno value to sanitize
+ *
+ * Verify @err is a valid -errno. If not, trigger scx_ops_error() and return
+ * -%EPROTO. This is necessary because returning a rogue -errno up the chain can
+ * cause misbehaviors. For an example, a large negative return from
+ * ops.init_task() triggers an oops when passed up the call chain because the
+ * value fails IS_ERR() test after being encoded with ERR_PTR() and then is
+ * handled as a pointer.
+ */
+static int ops_sanitize_err(const char *ops_name, s32 err)
+{
+	if (err < 0 && err >= -MAX_ERRNO)
+		return err;
+
+	scx_ops_error("ops.%s() returned an invalid errno %d", ops_name, err);
+	return -EPROTO;
+}
+
+static void update_curr_scx(struct rq *rq)
+{
+	struct task_struct *curr = rq->curr;
+	u64 now = rq_clock_task(rq);
+	u64 delta_exec;
+
+	if (time_before_eq64(now, curr->se.exec_start))
+		return;
+
+	delta_exec = now - curr->se.exec_start;
+	curr->se.exec_start = now;
+	curr->se.sum_exec_runtime += delta_exec;
+	account_group_exec_runtime(curr, delta_exec);
+	cgroup_account_cputime(curr, delta_exec);
+
+	curr->scx.slice -= min(curr->scx.slice, delta_exec);
+}
+
+static void dsq_mod_nr(struct scx_dispatch_q *dsq, s32 delta)
+{
+	/* scx_bpf_dsq_nr_queued() reads ->nr without locking, use WRITE_ONCE() */
+	WRITE_ONCE(dsq->nr, dsq->nr + delta);
+}
+
+static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
+			     u64 enq_flags)
+{
+	bool is_local = dsq->id == SCX_DSQ_LOCAL;
+
+	WARN_ON_ONCE(p->scx.dsq || !list_empty(&p->scx.dsq_node));
+
+	if (!is_local) {
+		raw_spin_lock(&dsq->lock);
+		if (unlikely(dsq->id == SCX_DSQ_INVALID)) {
+			scx_ops_error("attempting to dispatch to a destroyed dsq");
+			/* fall back to the global dsq */
+			raw_spin_unlock(&dsq->lock);
+			dsq = &scx_dsq_global;
+			raw_spin_lock(&dsq->lock);
+		}
+	}
+
+	if (enq_flags & SCX_ENQ_HEAD)
+		list_add(&p->scx.dsq_node, &dsq->list);
+	else
+		list_add_tail(&p->scx.dsq_node, &dsq->list);
+
+	dsq_mod_nr(dsq, 1);
+	p->scx.dsq = dsq;
+
+	/*
+	 * scx.ddsp_dsq_id and scx.ddsp_enq_flags are only relevant on the
+	 * direct dispatch path, but we clear them here because the direct
+	 * dispatch verdict may be overridden on the enqueue path during e.g.
+	 * bypass.
+	 */
+	p->scx.ddsp_dsq_id = SCX_DSQ_INVALID;
+	p->scx.ddsp_enq_flags = 0;
+
+	/*
+	 * We're transitioning out of QUEUEING or DISPATCHING. store_release to
+	 * match waiters' load_acquire.
+	 */
+	if (enq_flags & SCX_ENQ_CLEAR_OPSS)
+		atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_NONE);
+
+	if (is_local) {
+		struct rq *rq = container_of(dsq, struct rq, scx.local_dsq);
+
+		if (sched_class_above(&ext_sched_class, rq->curr->sched_class))
+			resched_curr(rq);
+	} else {
+		raw_spin_unlock(&dsq->lock);
+	}
+}
+
+static void dispatch_dequeue(struct scx_rq *scx_rq, struct task_struct *p)
+{
+	struct scx_dispatch_q *dsq = p->scx.dsq;
+	bool is_local = dsq == &scx_rq->local_dsq;
+
+	if (!dsq) {
+		WARN_ON_ONCE(!list_empty(&p->scx.dsq_node));
+		/*
+		 * When dispatching directly from the BPF scheduler to a local
+		 * DSQ, the task isn't associated with any DSQ but
+		 * @p->scx.holding_cpu may be set under the protection of
+		 * %SCX_OPSS_DISPATCHING.
+		 */
+		if (p->scx.holding_cpu >= 0)
+			p->scx.holding_cpu = -1;
+		return;
+	}
+
+	if (!is_local)
+		raw_spin_lock(&dsq->lock);
+
+	/*
+	 * Now that we hold @dsq->lock, @p->holding_cpu and @p->scx.dsq_node
+	 * can't change underneath us.
+	*/
+	if (p->scx.holding_cpu < 0) {
+		/* @p must still be on @dsq, dequeue */
+		WARN_ON_ONCE(list_empty(&p->scx.dsq_node));
+		list_del_init(&p->scx.dsq_node);
+		dsq_mod_nr(dsq, -1);
+	} else {
+		/*
+		 * We're racing against dispatch_to_local_dsq() which already
+		 * removed @p from @dsq and set @p->scx.holding_cpu. Clear the
+		 * holding_cpu which tells dispatch_to_local_dsq() that it lost
+		 * the race.
+		 */
+		WARN_ON_ONCE(!list_empty(&p->scx.dsq_node));
+		p->scx.holding_cpu = -1;
+	}
+	p->scx.dsq = NULL;
+
+	if (!is_local)
+		raw_spin_unlock(&dsq->lock);
+}
+
+static struct scx_dispatch_q *find_user_dsq(u64 dsq_id)
+{
+	return rhashtable_lookup_fast(&dsq_hash, &dsq_id, dsq_hash_params);
+}
+
+static struct scx_dispatch_q *find_non_local_dsq(u64 dsq_id)
+{
+	lockdep_assert(rcu_read_lock_any_held());
+
+	if (dsq_id == SCX_DSQ_GLOBAL)
+		return &scx_dsq_global;
+	else
+		return find_user_dsq(dsq_id);
+}
+
+static struct scx_dispatch_q *find_dsq_for_dispatch(struct rq *rq, u64 dsq_id,
+						    struct task_struct *p)
+{
+	struct scx_dispatch_q *dsq;
+
+	if (dsq_id == SCX_DSQ_LOCAL)
+		return &rq->scx.local_dsq;
+
+	dsq = find_non_local_dsq(dsq_id);
+	if (unlikely(!dsq)) {
+		scx_ops_error("non-existent DSQ 0x%llx for %s[%d]",
+			      dsq_id, p->comm, p->pid);
+		return &scx_dsq_global;
+	}
+
+	return dsq;
+}
+
+static void mark_direct_dispatch(struct task_struct *ddsp_task,
+				 struct task_struct *p, u64 dsq_id,
+				 u64 enq_flags)
+{
+	/*
+	 * Mark that dispatch already happened from ops.select_cpu() or
+	 * ops.enqueue() by spoiling direct_dispatch_task with a non-NULL value
+	 * which can never match a valid task pointer.
+	 */
+	__this_cpu_write(direct_dispatch_task, ERR_PTR(-ESRCH));
+
+	/* @p must match the task on the enqueue path */
+	if (unlikely(p != ddsp_task)) {
+		if (IS_ERR(ddsp_task))
+			scx_ops_error("%s[%d] already direct-dispatched",
+				      p->comm, p->pid);
+		else
+			scx_ops_error("scheduling for %s[%d] but trying to direct-dispatch %s[%d]",
+				      ddsp_task->comm, ddsp_task->pid,
+				      p->comm, p->pid);
+		return;
+	}
+
+	/*
+	 * %SCX_DSQ_LOCAL_ON is not supported during direct dispatch because
+	 * dispatching to the local DSQ of a different CPU requires unlocking
+	 * the current rq which isn't allowed in the enqueue path. Use
+	 * ops.select_cpu() to be on the target CPU and then %SCX_DSQ_LOCAL.
+	 */
+	if (unlikely((dsq_id & SCX_DSQ_LOCAL_ON) == SCX_DSQ_LOCAL_ON)) {
+		scx_ops_error("SCX_DSQ_LOCAL_ON can't be used for direct-dispatch");
+		return;
+	}
+
+	WARN_ON_ONCE(p->scx.ddsp_dsq_id != SCX_DSQ_INVALID);
+	WARN_ON_ONCE(p->scx.ddsp_enq_flags);
+
+	p->scx.ddsp_dsq_id = dsq_id;
+	p->scx.ddsp_enq_flags = enq_flags;
+}
+
+static void direct_dispatch(struct task_struct *p, u64 enq_flags)
+{
+	struct scx_dispatch_q *dsq;
+
+	enq_flags |= (p->scx.ddsp_enq_flags | SCX_ENQ_CLEAR_OPSS);
+	dsq = find_dsq_for_dispatch(task_rq(p), p->scx.ddsp_dsq_id, p);
+	dispatch_enqueue(dsq, p, enq_flags);
+}
+
+static bool test_rq_online(struct rq *rq)
+{
+#ifdef CONFIG_SMP
+	return rq->online;
+#else
+	return true;
+#endif
+}
+
+static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
+			    int sticky_cpu)
+{
+	struct task_struct **ddsp_taskp;
+	unsigned long qseq;
+
+	WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_QUEUED));
+
+	/* rq migration */
+	if (sticky_cpu == cpu_of(rq))
+		goto local_norefill;
+
+	/*
+	 * If !rq->online, we already told the BPF scheduler that the CPU is
+	 * offline. We're just trying to on/offline the CPU. Don't bother the
+	 * BPF scheduler.
+	 */
+	if (unlikely(!test_rq_online(rq)))
+		goto local;
+
+	if (scx_ops_bypassing()) {
+		if (enq_flags & SCX_ENQ_LAST)
+			goto local;
+		else
+			goto global;
+	}
+
+	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
+		goto direct;
+
+	/* see %SCX_OPS_ENQ_EXITING */
+	if (!static_branch_unlikely(&scx_ops_enq_exiting) &&
+	    unlikely(p->flags & PF_EXITING))
+		goto local;
+
+	/* see %SCX_OPS_ENQ_LAST */
+	if (!static_branch_unlikely(&scx_ops_enq_last) &&
+	    (enq_flags & SCX_ENQ_LAST))
+		goto local;
+
+	if (!SCX_HAS_OP(enqueue))
+		goto global;
+
+	/* DSQ bypass didn't trigger, enqueue on the BPF scheduler */
+	qseq = rq->scx.ops_qseq++ << SCX_OPSS_QSEQ_SHIFT;
+
+	WARN_ON_ONCE(atomic_long_read(&p->scx.ops_state) != SCX_OPSS_NONE);
+	atomic_long_set(&p->scx.ops_state, SCX_OPSS_QUEUEING | qseq);
+
+	ddsp_taskp = this_cpu_ptr(&direct_dispatch_task);
+	WARN_ON_ONCE(*ddsp_taskp);
+	*ddsp_taskp = p;
+
+	SCX_CALL_OP(SCX_KF_ENQUEUE, enqueue, p, enq_flags);
+
+	*ddsp_taskp = NULL;
+	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
+		goto direct;
+
+	/*
+	 * If not directly dispatched, QUEUEING isn't clear yet and dispatch or
+	 * dequeue may be waiting. The store_release matches their load_acquire.
+	 */
+	atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_QUEUED | qseq);
+	return;
+
+direct:
+	direct_dispatch(p, enq_flags);
+	return;
+
+local:
+	p->scx.slice = SCX_SLICE_DFL;
+local_norefill:
+	dispatch_enqueue(&rq->scx.local_dsq, p, enq_flags);
+	return;
+
+global:
+	p->scx.slice = SCX_SLICE_DFL;
+	dispatch_enqueue(&scx_dsq_global, p, enq_flags);
+}
+
+static bool task_runnable(const struct task_struct *p)
+{
+	return !list_empty(&p->scx.runnable_node);
+}
+
+static void set_task_runnable(struct rq *rq, struct task_struct *p)
+{
+	lockdep_assert_rq_held(rq);
+
+	/*
+	 * list_add_tail() must be used. scx_ops_bypass() depends on tasks being
+	 * appened to the runnable_list.
+	 */
+	list_add_tail(&p->scx.runnable_node, &rq->scx.runnable_list);
+}
+
+static void clr_task_runnable(struct task_struct *p)
+{
+	list_del_init(&p->scx.runnable_node);
+}
+
+static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags)
+{
+	int sticky_cpu = p->scx.sticky_cpu;
+
+	enq_flags |= rq->scx.extra_enq_flags;
+
+	if (sticky_cpu >= 0)
+		p->scx.sticky_cpu = -1;
+
+	/*
+	 * Restoring a running task will be immediately followed by
+	 * set_next_task_scx() which expects the task to not be on the BPF
+	 * scheduler as tasks can only start running through local DSQs. Force
+	 * direct-dispatch into the local DSQ by setting the sticky_cpu.
+	 */
+	if (unlikely(enq_flags & ENQUEUE_RESTORE) && task_current(rq, p))
+		sticky_cpu = cpu_of(rq);
+
+	if (p->scx.flags & SCX_TASK_QUEUED) {
+		WARN_ON_ONCE(!task_runnable(p));
+		return;
+	}
+
+	set_task_runnable(rq, p);
+	p->scx.flags |= SCX_TASK_QUEUED;
+	rq->scx.nr_running++;
+	add_nr_running(rq, 1);
+
+	do_enqueue_task(rq, p, enq_flags, sticky_cpu);
+}
+
+static void ops_dequeue(struct task_struct *p, u64 deq_flags)
+{
+	unsigned long opss;
+
+	clr_task_runnable(p);
+
+	/* acquire ensures that we see the preceding updates on QUEUED */
+	opss = atomic_long_read_acquire(&p->scx.ops_state);
+
+	switch (opss & SCX_OPSS_STATE_MASK) {
+	case SCX_OPSS_NONE:
+		break;
+	case SCX_OPSS_QUEUEING:
+		/*
+		 * QUEUEING is started and finished while holding @p's rq lock.
+		 * As we're holding the rq lock now, we shouldn't see QUEUEING.
+		 */
+		BUG();
+	case SCX_OPSS_QUEUED:
+		if (SCX_HAS_OP(dequeue))
+			SCX_CALL_OP(SCX_KF_REST, dequeue, p, deq_flags);
+
+		if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
+					    SCX_OPSS_NONE))
+			break;
+		fallthrough;
+	case SCX_OPSS_DISPATCHING:
+		/*
+		 * If @p is being dispatched from the BPF scheduler to a DSQ,
+		 * wait for the transfer to complete so that @p doesn't get
+		 * added to its DSQ after dequeueing is complete.
+		 *
+		 * As we're waiting on DISPATCHING with the rq locked, the
+		 * dispatching side shouldn't try to lock the rq while
+		 * DISPATCHING is set. See dispatch_to_local_dsq().
+		 *
+		 * DISPATCHING shouldn't have qseq set and control can reach
+		 * here with NONE @opss from the above QUEUED case block.
+		 * Explicitly wait on %SCX_OPSS_DISPATCHING instead of @opss.
+		 */
+		wait_ops_state(p, SCX_OPSS_DISPATCHING);
+		BUG_ON(atomic_long_read(&p->scx.ops_state) != SCX_OPSS_NONE);
+		break;
+	}
+}
+
+static void dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags)
+{
+	struct scx_rq *scx_rq = &rq->scx;
+
+	if (!(p->scx.flags & SCX_TASK_QUEUED)) {
+		WARN_ON_ONCE(task_runnable(p));
+		return;
+	}
+
+	ops_dequeue(p, deq_flags);
+
+	if (deq_flags & SCX_DEQ_SLEEP)
+		p->scx.flags |= SCX_TASK_DEQD_FOR_SLEEP;
+	else
+		p->scx.flags &= ~SCX_TASK_DEQD_FOR_SLEEP;
+
+	p->scx.flags &= ~SCX_TASK_QUEUED;
+	scx_rq->nr_running--;
+	sub_nr_running(rq, 1);
+
+	dispatch_dequeue(scx_rq, p);
+}
+
+static void yield_task_scx(struct rq *rq)
+{
+	struct task_struct *p = rq->curr;
+
+	if (SCX_HAS_OP(yield))
+		SCX_CALL_OP_RET(SCX_KF_REST, yield, p, NULL);
+	else
+		p->scx.slice = 0;
+}
+
+static bool yield_to_task_scx(struct rq *rq, struct task_struct *to)
+{
+	struct task_struct *from = rq->curr;
+
+	if (SCX_HAS_OP(yield))
+		return SCX_CALL_OP_RET(SCX_KF_REST, yield, from, to);
+	else
+		return false;
+}
+
+#ifdef CONFIG_SMP
+/**
+ * move_task_to_local_dsq - Move a task from a different rq to a local DSQ
+ * @rq: rq to move the task into, currently locked
+ * @p: task to move
+ * @enq_flags: %SCX_ENQ_*
+ *
+ * Move @p which is currently on a different rq to @rq's local DSQ. The caller
+ * must:
+ *
+ * 1. Start with exclusive access to @p either through its DSQ lock or
+ *    %SCX_OPSS_DISPATCHING flag.
+ *
+ * 2. Set @p->scx.holding_cpu to raw_smp_processor_id().
+ *
+ * 3. Remember task_rq(@p). Release the exclusive access so that we don't
+ *    deadlock with dequeue.
+ *
+ * 4. Lock @rq and the task_rq from #3.
+ *
+ * 5. Call this function.
+ *
+ * Returns %true if @p was successfully moved. %false after racing dequeue and
+ * losing.
+ */
+static bool move_task_to_local_dsq(struct rq *rq, struct task_struct *p,
+				   u64 enq_flags)
+{
+	struct rq *task_rq;
+
+	lockdep_assert_rq_held(rq);
+
+	/*
+	 * If dequeue got to @p while we were trying to lock both rq's, it'd
+	 * have cleared @p->scx.holding_cpu to -1. While other cpus may have
+	 * updated it to different values afterwards, as this operation can't be
+	 * preempted or recurse, @p->scx.holding_cpu can never become
+	 * raw_smp_processor_id() again before we're done. Thus, we can tell
+	 * whether we lost to dequeue by testing whether @p->scx.holding_cpu is
+	 * still raw_smp_processor_id().
+	 *
+	 * See dispatch_dequeue() for the counterpart.
+	 */
+	if (unlikely(p->scx.holding_cpu != raw_smp_processor_id()))
+		return false;
+
+	/* @p->rq couldn't have changed if we're still the holding cpu */
+	task_rq = task_rq(p);
+	lockdep_assert_rq_held(task_rq);
+
+	WARN_ON_ONCE(!cpumask_test_cpu(cpu_of(rq), p->cpus_ptr));
+	deactivate_task(task_rq, p, 0);
+	set_task_cpu(p, cpu_of(rq));
+	p->scx.sticky_cpu = cpu_of(rq);
+
+	/*
+	 * We want to pass scx-specific enq_flags but activate_task() will
+	 * truncate the upper 32 bit. As we own @rq, we can pass them through
+	 * @rq->scx.extra_enq_flags instead.
+	 */
+	WARN_ON_ONCE(rq->scx.extra_enq_flags);
+	rq->scx.extra_enq_flags = enq_flags;
+	activate_task(rq, p, 0);
+	rq->scx.extra_enq_flags = 0;
+
+	return true;
+}
+
+/**
+ * dispatch_to_local_dsq_lock - Ensure source and desitnation rq's are locked
+ * @rq: current rq which is locked
+ * @rf: rq_flags to use when unlocking @rq
+ * @src_rq: rq to move task from
+ * @dst_rq: rq to move task to
+ *
+ * We're holding @rq lock and trying to dispatch a task from @src_rq to
+ * @dst_rq's local DSQ and thus need to lock both @src_rq and @dst_rq. Whether
+ * @rq stays locked isn't important as long as the state is restored after
+ * dispatch_to_local_dsq_unlock().
+ */
+static void dispatch_to_local_dsq_lock(struct rq *rq, struct rq_flags *rf,
+				       struct rq *src_rq, struct rq *dst_rq)
+{
+	rq_unpin_lock(rq, rf);
+
+	if (src_rq == dst_rq) {
+		raw_spin_rq_unlock(rq);
+		raw_spin_rq_lock(dst_rq);
+	} else if (rq == src_rq) {
+		double_lock_balance(rq, dst_rq);
+		rq_repin_lock(rq, rf);
+	} else if (rq == dst_rq) {
+		double_lock_balance(rq, src_rq);
+		rq_repin_lock(rq, rf);
+	} else {
+		raw_spin_rq_unlock(rq);
+		double_rq_lock(src_rq, dst_rq);
+	}
+}
+
+/**
+ * dispatch_to_local_dsq_unlock - Undo dispatch_to_local_dsq_lock()
+ * @rq: current rq which is locked
+ * @rf: rq_flags to use when unlocking @rq
+ * @src_rq: rq to move task from
+ * @dst_rq: rq to move task to
+ *
+ * Unlock @src_rq and @dst_rq and ensure that @rq is locked on return.
+ */
+static void dispatch_to_local_dsq_unlock(struct rq *rq, struct rq_flags *rf,
+					 struct rq *src_rq, struct rq *dst_rq)
+{
+	if (src_rq == dst_rq) {
+		raw_spin_rq_unlock(dst_rq);
+		raw_spin_rq_lock(rq);
+		rq_repin_lock(rq, rf);
+	} else if (rq == src_rq) {
+		double_unlock_balance(rq, dst_rq);
+	} else if (rq == dst_rq) {
+		double_unlock_balance(rq, src_rq);
+	} else {
+		double_rq_unlock(src_rq, dst_rq);
+		raw_spin_rq_lock(rq);
+		rq_repin_lock(rq, rf);
+	}
+}
+#endif	/* CONFIG_SMP */
+
+static void consume_local_task(struct rq *rq, struct scx_dispatch_q *dsq,
+			       struct task_struct *p)
+{
+	struct scx_rq *scx_rq = &rq->scx;
+
+	lockdep_assert_held(&dsq->lock);	/* released on return */
+
+	/* @dsq is locked and @p is on this rq */
+	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
+	list_move_tail(&p->scx.dsq_node, &scx_rq->local_dsq.list);
+	dsq_mod_nr(dsq, -1);
+	dsq_mod_nr(&scx_rq->local_dsq, 1);
+	p->scx.dsq = &scx_rq->local_dsq;
+	raw_spin_unlock(&dsq->lock);
+}
+
+#ifdef CONFIG_SMP
+/*
+ * Similar to kernel/sched/core.c::is_cpu_allowed() but we're testing whether @p
+ * can be pulled to @rq.
+ */
+static bool task_can_run_on_remote_rq(struct task_struct *p, struct rq *rq)
+{
+	int cpu = cpu_of(rq);
+
+	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
+		return false;
+	if (unlikely(is_migration_disabled(p)))
+		return false;
+	if (!(p->flags & PF_KTHREAD) && unlikely(!task_cpu_possible(cpu, p)))
+		return false;
+	if (unlikely(!test_rq_online(rq)))
+		return false;
+	return true;
+}
+
+static bool consume_remote_task(struct rq *rq, struct rq_flags *rf,
+				struct scx_dispatch_q *dsq,
+				struct task_struct *p, struct rq *task_rq)
+{
+	bool moved = false;
+
+	lockdep_assert_held(&dsq->lock);	/* released on return */
+
+	/*
+	 * @dsq is locked and @p is on a remote rq. @p is currently protected by
+	 * @dsq->lock. We want to pull @p to @rq but may deadlock if we grab
+	 * @task_rq while holding @dsq and @rq locks. As dequeue can't drop the
+	 * rq lock or fail, do a little dancing from our side. See
+	 * move_task_to_local_dsq().
+	 */
+	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
+	list_del_init(&p->scx.dsq_node);
+	dsq_mod_nr(dsq, -1);
+	p->scx.holding_cpu = raw_smp_processor_id();
+	raw_spin_unlock(&dsq->lock);
+
+	rq_unpin_lock(rq, rf);
+	double_lock_balance(rq, task_rq);
+	rq_repin_lock(rq, rf);
+
+	moved = move_task_to_local_dsq(rq, p, 0);
+
+	double_unlock_balance(rq, task_rq);
+
+	return moved;
+}
+#else	/* CONFIG_SMP */
+static bool task_can_run_on_remote_rq(struct task_struct *p, struct rq *rq) { return false; }
+static bool consume_remote_task(struct rq *rq, struct rq_flags *rf,
+				struct scx_dispatch_q *dsq,
+				struct task_struct *p, struct rq *task_rq) { return false; }
+#endif	/* CONFIG_SMP */
+
+static bool consume_dispatch_q(struct rq *rq, struct rq_flags *rf,
+			       struct scx_dispatch_q *dsq)
+{
+	struct task_struct *p;
+retry:
+	if (list_empty(&dsq->list))
+		return false;
+
+	raw_spin_lock(&dsq->lock);
+
+	list_for_each_entry(p, &dsq->list, scx.dsq_node) {
+		struct rq *task_rq = task_rq(p);
+
+		if (rq == task_rq) {
+			consume_local_task(rq, dsq, p);
+			return true;
+		}
+
+		if (task_can_run_on_remote_rq(p, rq)) {
+			if (likely(consume_remote_task(rq, rf, dsq, p, task_rq)))
+				return true;
+			goto retry;
+		}
+	}
+
+	raw_spin_unlock(&dsq->lock);
+	return false;
+}
+
+enum dispatch_to_local_dsq_ret {
+	DTL_DISPATCHED,		/* successfully dispatched */
+	DTL_LOST,		/* lost race to dequeue */
+	DTL_NOT_LOCAL,		/* destination is not a local DSQ */
+	DTL_INVALID,		/* invalid local dsq_id */
+};
+
+/**
+ * dispatch_to_local_dsq - Dispatch a task to a local dsq
+ * @rq: current rq which is locked
+ * @rf: rq_flags to use when unlocking @rq
+ * @dsq_id: destination dsq ID
+ * @p: task to dispatch
+ * @enq_flags: %SCX_ENQ_*
+ *
+ * We're holding @rq lock and want to dispatch @p to the local DSQ identified by
+ * @dsq_id. This function performs all the synchronization dancing needed
+ * because local DSQs are protected with rq locks.
+ *
+ * The caller must have exclusive ownership of @p (e.g. through
+ * %SCX_OPSS_DISPATCHING).
+ */
+static enum dispatch_to_local_dsq_ret
+dispatch_to_local_dsq(struct rq *rq, struct rq_flags *rf, u64 dsq_id,
+		      struct task_struct *p, u64 enq_flags)
+{
+	struct rq *src_rq = task_rq(p);
+	struct rq *dst_rq;
+
+	/*
+	 * We're synchronized against dequeue through DISPATCHING. As @p can't
+	 * be dequeued, its task_rq and cpus_allowed are stable too.
+	 */
+	if (dsq_id == SCX_DSQ_LOCAL) {
+		dst_rq = rq;
+	} else if ((dsq_id & SCX_DSQ_LOCAL_ON) == SCX_DSQ_LOCAL_ON) {
+		s32 cpu = dsq_id & SCX_DSQ_LOCAL_CPU_MASK;
+
+		if (!ops_cpu_valid(cpu, "in SCX_DSQ_LOCAL_ON dispatch verdict"))
+			return DTL_INVALID;
+		dst_rq = cpu_rq(cpu);
+	} else {
+		return DTL_NOT_LOCAL;
+	}
+
+	/* if dispatching to @rq that @p is already on, no lock dancing needed */
+	if (rq == src_rq && rq == dst_rq) {
+		dispatch_enqueue(&dst_rq->scx.local_dsq, p,
+				 enq_flags | SCX_ENQ_CLEAR_OPSS);
+		return DTL_DISPATCHED;
+	}
+
+#ifdef CONFIG_SMP
+	if (cpumask_test_cpu(cpu_of(dst_rq), p->cpus_ptr)) {
+		struct rq *locked_dst_rq = dst_rq;
+		bool dsp;
+
+		/*
+		 * @p is on a possibly remote @src_rq which we need to lock to
+		 * move the task. If dequeue is in progress, it'd be locking
+		 * @src_rq and waiting on DISPATCHING, so we can't grab @src_rq
+		 * lock while holding DISPATCHING.
+		 *
+		 * As DISPATCHING guarantees that @p is wholly ours, we can
+		 * pretend that we're moving from a DSQ and use the same
+		 * mechanism - mark the task under transfer with holding_cpu,
+		 * release DISPATCHING and then follow the same protocol.
+		 */
+		p->scx.holding_cpu = raw_smp_processor_id();
+
+		/* store_release ensures that dequeue sees the above */
+		atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_NONE);
+
+		dispatch_to_local_dsq_lock(rq, rf, src_rq, locked_dst_rq);
+
+		/*
+		 * We don't require the BPF scheduler to avoid dispatching to
+		 * offline CPUs mostly for convenience but also because CPUs can
+		 * go offline between scx_bpf_dispatch() calls and here. If @p
+		 * is destined to an offline CPU, queue it on its current CPU
+		 * instead, which should always be safe. As this is an allowed
+		 * behavior, don't trigger an ops error.
+		 */
+		if (unlikely(!test_rq_online(dst_rq)))
+			dst_rq = src_rq;
+
+		if (src_rq == dst_rq) {
+			/*
+			 * As @p is staying on the same rq, there's no need to
+			 * go through the full deactivate/activate cycle.
+			 * Optimize by abbreviating the operations in
+			 * move_task_to_local_dsq().
+			 */
+			dsp = p->scx.holding_cpu == raw_smp_processor_id();
+			if (likely(dsp)) {
+				p->scx.holding_cpu = -1;
+				dispatch_enqueue(&dst_rq->scx.local_dsq, p,
+						 enq_flags);
+			}
+		} else {
+			dsp = move_task_to_local_dsq(dst_rq, p, enq_flags);
+		}
+
+		/* if the destination CPU is idle, wake it up */
+		if (dsp && p->sched_class > dst_rq->curr->sched_class)
+			resched_curr(dst_rq);
+
+		dispatch_to_local_dsq_unlock(rq, rf, src_rq, locked_dst_rq);
+
+		return dsp ? DTL_DISPATCHED : DTL_LOST;
+	}
+#endif	/* CONFIG_SMP */
+
+	scx_ops_error("SCX_DSQ_LOCAL[_ON] verdict target cpu %d not allowed for %s[%d]",
+		      cpu_of(dst_rq), p->comm, p->pid);
+	return DTL_INVALID;
+}
+
+/**
+ * finish_dispatch - Asynchronously finish dispatching a task
+ * @rq: current rq which is locked
+ * @rf: rq_flags to use when unlocking @rq
+ * @p: task to finish dispatching
+ * @qseq_at_dispatch: qseq when @p started getting dispatched
+ * @dsq_id: destination DSQ ID
+ * @enq_flags: %SCX_ENQ_*
+ *
+ * Dispatching to local DSQs may need to wait for queueing to complete or
+ * require rq lock dancing. As we don't wanna do either while inside
+ * ops.dispatch() to avoid locking order inversion, we split dispatching into
+ * two parts. scx_bpf_dispatch() which is called by ops.dispatch() records the
+ * task and its qseq. Once ops.dispatch() returns, this function is called to
+ * finish up.
+ *
+ * There is no guarantee that @p is still valid for dispatching or even that it
+ * was valid in the first place. Make sure that the task is still owned by the
+ * BPF scheduler and claim the ownership before dispatching.
+ */
+static void finish_dispatch(struct rq *rq, struct rq_flags *rf,
+			    struct task_struct *p,
+			    unsigned long qseq_at_dispatch,
+			    u64 dsq_id, u64 enq_flags)
+{
+	struct scx_dispatch_q *dsq;
+	unsigned long opss;
+
+retry:
+	/*
+	 * No need for _acquire here. @p is accessed only after a successful
+	 * try_cmpxchg to DISPATCHING.
+	 */
+	opss = atomic_long_read(&p->scx.ops_state);
+
+	switch (opss & SCX_OPSS_STATE_MASK) {
+	case SCX_OPSS_DISPATCHING:
+	case SCX_OPSS_NONE:
+		/* someone else already got to it */
+		return;
+	case SCX_OPSS_QUEUED:
+		/*
+		 * If qseq doesn't match, @p has gone through at least one
+		 * dispatch/dequeue and re-enqueue cycle between
+		 * scx_bpf_dispatch() and here and we have no claim on it.
+		 */
+		if ((opss & SCX_OPSS_QSEQ_MASK) != qseq_at_dispatch)
+			return;
+
+		/*
+		 * While we know @p is accessible, we don't yet have a claim on
+		 * it - the BPF scheduler is allowed to dispatch tasks
+		 * spuriously and there can be a racing dequeue attempt. Let's
+		 * claim @p by atomically transitioning it from QUEUED to
+		 * DISPATCHING.
+		 */
+		if (likely(atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
+						   SCX_OPSS_DISPATCHING)))
+			break;
+		goto retry;
+	case SCX_OPSS_QUEUEING:
+		/*
+		 * do_enqueue_task() is in the process of transferring the task
+		 * to the BPF scheduler while holding @p's rq lock. As we aren't
+		 * holding any kernel or BPF resource that the enqueue path may
+		 * depend upon, it's safe to wait.
+		 */
+		wait_ops_state(p, opss);
+		goto retry;
+	}
+
+	BUG_ON(!(p->scx.flags & SCX_TASK_QUEUED));
+
+	switch (dispatch_to_local_dsq(rq, rf, dsq_id, p, enq_flags)) {
+	case DTL_DISPATCHED:
+		break;
+	case DTL_LOST:
+		break;
+	case DTL_INVALID:
+		dsq_id = SCX_DSQ_GLOBAL;
+		fallthrough;
+	case DTL_NOT_LOCAL:
+		dsq = find_dsq_for_dispatch(cpu_rq(raw_smp_processor_id()),
+					    dsq_id, p);
+		dispatch_enqueue(dsq, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
+		break;
+	}
+}
+
+static void flush_dispatch_buf(struct rq *rq, struct rq_flags *rf)
+{
+	struct scx_dsp_ctx *dspc = this_cpu_ptr(&scx_dsp_ctx);
+	u32 u;
+
+	for (u = 0; u < dspc->buf_cursor; u++) {
+		struct scx_dsp_buf_ent *ent = &this_cpu_ptr(scx_dsp_buf)[u];
+
+		finish_dispatch(rq, rf, ent->task, ent->qseq, ent->dsq_id,
+				ent->enq_flags);
+	}
+
+	dspc->nr_tasks += dspc->buf_cursor;
+	dspc->buf_cursor = 0;
+}
+
+static int balance_scx(struct rq *rq, struct task_struct *prev,
+		       struct rq_flags *rf)
+{
+	struct scx_rq *scx_rq = &rq->scx;
+	struct scx_dsp_ctx *dspc = this_cpu_ptr(&scx_dsp_ctx);
+	bool prev_on_scx = prev->sched_class == &ext_sched_class;
+
+	lockdep_assert_rq_held(rq);
+
+	if (prev_on_scx) {
+		WARN_ON_ONCE(prev->scx.flags & SCX_TASK_BAL_KEEP);
+		update_curr_scx(rq);
+
+		/*
+		 * If @prev is runnable & has slice left, it has priority and
+		 * fetching more just increases latency for the fetched tasks.
+		 * Tell put_prev_task_scx() to put @prev on local_dsq.
+		 *
+		 * See scx_ops_disable_workfn() for the explanation on the
+		 * bypassing test.
+		 */
+		if ((prev->scx.flags & SCX_TASK_QUEUED) &&
+		    prev->scx.slice && !scx_ops_bypassing()) {
+			prev->scx.flags |= SCX_TASK_BAL_KEEP;
+			return 1;
+		}
+	}
+
+	/* if there already are tasks to run, nothing to do */
+	if (scx_rq->local_dsq.nr)
+		return 1;
+
+	if (consume_dispatch_q(rq, rf, &scx_dsq_global))
+		return 1;
+
+	if (!SCX_HAS_OP(dispatch) || scx_ops_bypassing())
+		return 0;
+
+	dspc->rq = rq;
+	dspc->rf = rf;
+
+	/*
+	 * The dispatch loop. Because flush_dispatch_buf() may drop the rq lock,
+	 * the local DSQ might still end up empty after a successful
+	 * ops.dispatch(). If the local DSQ is empty even after ops.dispatch()
+	 * produced some tasks, retry. The BPF scheduler may depend on this
+	 * looping behavior to simplify its implementation.
+	 */
+	do {
+		dspc->nr_tasks = 0;
+
+		SCX_CALL_OP(SCX_KF_DISPATCH, dispatch, cpu_of(rq),
+			    prev_on_scx ? prev : NULL);
+
+		flush_dispatch_buf(rq, rf);
+
+		if (scx_rq->local_dsq.nr)
+			return 1;
+		if (consume_dispatch_q(rq, rf, &scx_dsq_global))
+			return 1;
+	} while (dspc->nr_tasks);
+
+	return 0;
+}
+
+static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
+{
+	if (p->scx.flags & SCX_TASK_QUEUED) {
+		WARN_ON_ONCE(atomic_long_read(&p->scx.ops_state) != SCX_OPSS_NONE);
+		dispatch_dequeue(&rq->scx, p);
+	}
+
+	p->se.exec_start = rq_clock_task(rq);
+
+	clr_task_runnable(p);
+}
+
+static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
+{
+#ifndef CONFIG_SMP
+	/*
+	 * UP workaround.
+	 *
+	 * Because SCX may transfer tasks across CPUs during dispatch, dispatch
+	 * is performed from its balance operation which isn't called in UP.
+	 * Let's work around by calling it from the operations which come right
+	 * after.
+	 *
+	 * 1. If the prev task is on SCX, pick_next_task() calls
+	 *    .put_prev_task() right after. As .put_prev_task() is also called
+	 *    from other places, we need to distinguish the calls which can be
+	 *    done by looking at the previous task's state - if still queued or
+	 *    dequeued with %SCX_DEQ_SLEEP, the caller must be pick_next_task().
+	 *    This case is handled here.
+	 *
+	 * 2. If the prev task is not on SCX, the first following call into SCX
+	 *    will be .pick_next_task(), which is covered by calling
+	 *    balance_scx() from pick_next_task_scx().
+	 *
+	 * Note that we can't merge the first case into the second as
+	 * balance_scx() must be called before the previous SCX task goes
+	 * through put_prev_task_scx().
+	 *
+	 * As UP doesn't transfer tasks around, balance_scx() doesn't need @rf.
+	 * Pass in %NULL.
+	 */
+	if (p->scx.flags & (SCX_TASK_QUEUED | SCX_TASK_DEQD_FOR_SLEEP))
+		balance_scx(rq, p, NULL);
+#endif
+
+	update_curr_scx(rq);
+
+	/*
+	 * If we're being called from put_prev_task_balance(), balance_scx() may
+	 * have decided that @p should keep running.
+	 */
+	if (p->scx.flags & SCX_TASK_BAL_KEEP) {
+		p->scx.flags &= ~SCX_TASK_BAL_KEEP;
+		set_task_runnable(rq, p);
+		dispatch_enqueue(&rq->scx.local_dsq, p, SCX_ENQ_HEAD);
+		return;
+	}
+
+	if (p->scx.flags & SCX_TASK_QUEUED) {
+		set_task_runnable(rq, p);
+
+		/*
+		 * If @p has slice left and balance_scx() didn't tag it for
+		 * keeping, @p is getting preempted by a higher priority
+		 * scheduler class. Leave it at the head of the local DSQ.
+		 */
+		if (p->scx.slice && !scx_ops_bypassing()) {
+			dispatch_enqueue(&rq->scx.local_dsq, p, SCX_ENQ_HEAD);
+			return;
+		}
+
+		/*
+		 * If we're in the pick_next_task path, balance_scx() should
+		 * have already populated the local DSQ if there are any other
+		 * available tasks. If empty, tell ops.enqueue() that @p is the
+		 * only one available for this cpu. ops.enqueue() should put it
+		 * on the local DSQ so that the subsequent pick_next_task_scx()
+		 * can find the task unless it wants to trigger a separate
+		 * follow-up scheduling event.
+		 */
+		if (list_empty(&rq->scx.local_dsq.list))
+			do_enqueue_task(rq, p, SCX_ENQ_LAST, -1);
+		else
+			do_enqueue_task(rq, p, 0, -1);
+	}
+}
+
+static struct task_struct *first_local_task(struct rq *rq)
+{
+	return list_first_entry_or_null(&rq->scx.local_dsq.list,
+					struct task_struct, scx.dsq_node);
+}
+
+static struct task_struct *pick_next_task_scx(struct rq *rq)
+{
+	struct task_struct *p;
+
+#ifndef CONFIG_SMP
+	/* UP workaround - see the comment at the head of put_prev_task_scx() */
+	if (unlikely(rq->curr->sched_class != &ext_sched_class))
+		balance_scx(rq, rq->curr, NULL);
+#endif
+
+	p = first_local_task(rq);
+	if (!p)
+		return NULL;
+
+	set_next_task_scx(rq, p, true);
+
+	if (unlikely(!p->scx.slice)) {
+		if (!scx_ops_bypassing() && !scx_warned_zero_slice) {
+			printk_deferred(KERN_WARNING "sched_ext: %s[%d] has zero slice in pick_next_task_scx()\n",
+					p->comm, p->pid);
+			scx_warned_zero_slice = true;
+		}
+		p->scx.slice = SCX_SLICE_DFL;
+	}
+
+	return p;
+}
+
+#ifdef CONFIG_SMP
+
+static bool test_and_clear_cpu_idle(int cpu)
+{
+#ifdef CONFIG_SCHED_SMT
+	/*
+	 * SMT mask should be cleared whether we can claim @cpu or not. The SMT
+	 * cluster is not wholly idle either way. This also prevents
+	 * scx_pick_idle_cpu() from getting caught in an infinite loop.
+	 */
+	if (sched_smt_active()) {
+		const struct cpumask *smt = cpu_smt_mask(cpu);
+
+		/*
+		 * If offline, @cpu is not its own sibling and
+		 * scx_pick_idle_cpu() can get caught in an infinite loop as
+		 * @cpu is never cleared from idle_masks.smt. Ensure that @cpu
+		 * is eventually cleared.
+		 */
+		if (cpumask_intersects(smt, idle_masks.smt))
+			cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
+		else if (cpumask_test_cpu(cpu, idle_masks.smt))
+			__cpumask_clear_cpu(cpu, idle_masks.smt);
+	}
+#endif
+	return cpumask_test_and_clear_cpu(cpu, idle_masks.cpu);
+}
+
+static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
+{
+	int cpu;
+
+retry:
+	if (sched_smt_active()) {
+		cpu = cpumask_any_and_distribute(idle_masks.smt, cpus_allowed);
+		if (cpu < nr_cpu_ids)
+			goto found;
+
+		if (flags & SCX_PICK_IDLE_CORE)
+			return -EBUSY;
+	}
+
+	cpu = cpumask_any_and_distribute(idle_masks.cpu, cpus_allowed);
+	if (cpu >= nr_cpu_ids)
+		return -EBUSY;
+
+found:
+	if (test_and_clear_cpu_idle(cpu))
+		return cpu;
+	else
+		goto retry;
+}
+
+static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
+			      u64 wake_flags, bool *found)
+{
+	s32 cpu;
+
+	*found = false;
+
+	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
+		scx_ops_error("built-in idle tracking is disabled");
+		return prev_cpu;
+	}
+
+	/*
+	 * If WAKE_SYNC, the waker's local DSQ is empty, and the system is
+	 * under utilized, wake up @p to the local DSQ of the waker. Checking
+	 * only for an empty local DSQ is insufficient as it could give the
+	 * wakee an unfair advantage when the system is oversaturated.
+	 * Checking only for the presence of idle CPUs is also insufficient as
+	 * the local DSQ of the waker could have tasks piled up on it even if
+	 * there is an idle core elsewhere on the system.
+	 */
+	cpu = smp_processor_id();
+	if ((wake_flags & SCX_WAKE_SYNC) && p->nr_cpus_allowed > 1 &&
+	    !cpumask_empty(idle_masks.cpu) && !(current->flags & PF_EXITING) &&
+	    cpu_rq(cpu)->scx.local_dsq.nr == 0) {
+		if (cpumask_test_cpu(cpu, p->cpus_ptr))
+			goto cpu_found;
+	}
+
+	if (p->nr_cpus_allowed == 1) {
+		if (test_and_clear_cpu_idle(prev_cpu)) {
+			cpu = prev_cpu;
+			goto cpu_found;
+		} else {
+			return prev_cpu;
+		}
+	}
+
+	/*
+	 * If CPU has SMT, any wholly idle CPU is likely a better pick than
+	 * partially idle @prev_cpu.
+	 */
+	if (sched_smt_active()) {
+		if (cpumask_test_cpu(prev_cpu, idle_masks.smt) &&
+		    test_and_clear_cpu_idle(prev_cpu)) {
+			cpu = prev_cpu;
+			goto cpu_found;
+		}
+
+		cpu = scx_pick_idle_cpu(p->cpus_ptr, SCX_PICK_IDLE_CORE);
+		if (cpu >= 0)
+			goto cpu_found;
+	}
+
+	if (test_and_clear_cpu_idle(prev_cpu)) {
+		cpu = prev_cpu;
+		goto cpu_found;
+	}
+
+	cpu = scx_pick_idle_cpu(p->cpus_ptr, 0);
+	if (cpu >= 0)
+		goto cpu_found;
+
+	return prev_cpu;
+
+cpu_found:
+	*found = true;
+	return cpu;
+}
+
+static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flags)
+{
+	/*
+	 * sched_exec() calls with %WF_EXEC when @p is about to exec(2) as it
+	 * can be a good migration opportunity with low cache and memory
+	 * footprint. Returning a CPU different than @prev_cpu triggers
+	 * immediate rq migration. However, for SCX, as the current rq
+	 * association doesn't dictate where the task is going to run, this
+	 * doesn't fit well. If necessary, we can later add a dedicated method
+	 * which can decide to preempt self to force it through the regular
+	 * scheduling path.
+	 */
+	if (unlikely(wake_flags & WF_EXEC))
+		return prev_cpu;
+
+	if (SCX_HAS_OP(select_cpu)) {
+		s32 cpu;
+		struct task_struct **ddsp_taskp;
+
+		ddsp_taskp = this_cpu_ptr(&direct_dispatch_task);
+		WARN_ON_ONCE(*ddsp_taskp);
+		*ddsp_taskp = p;
+
+		cpu = SCX_CALL_OP_RET(SCX_KF_ENQUEUE | SCX_KF_SELECT_CPU,
+				      select_cpu, p, prev_cpu, wake_flags);
+		*ddsp_taskp = NULL;
+		if (ops_cpu_valid(cpu, "from ops.select_cpu()"))
+			return cpu;
+		else
+			return prev_cpu;
+	} else {
+		bool found;
+		s32 cpu;
+
+		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, &found);
+		if (found) {
+			p->scx.slice = SCX_SLICE_DFL;
+			p->scx.ddsp_dsq_id = SCX_DSQ_LOCAL;
+		}
+		return cpu;
+	}
+}
+
+static void set_cpus_allowed_scx(struct task_struct *p,
+				 struct affinity_context *ac)
+{
+	set_cpus_allowed_common(p, ac);
+
+	/*
+	 * The effective cpumask is stored in @p->cpus_ptr which may temporarily
+	 * differ from the configured one in @p->cpus_mask. Always tell the bpf
+	 * scheduler the effective one.
+	 *
+	 * Fine-grained memory write control is enforced by BPF making the const
+	 * designation pointless. Cast it away when calling the operation.
+	 */
+	if (SCX_HAS_OP(set_cpumask))
+		SCX_CALL_OP(SCX_KF_REST, set_cpumask, p,
+			    (struct cpumask *)p->cpus_ptr);
+}
+
+static void reset_idle_masks(void)
+{
+	/*
+	 * Consider all online cpus idle. Should converge to the actual state
+	 * quickly.
+	 */
+	cpumask_copy(idle_masks.cpu, cpu_online_mask);
+	cpumask_copy(idle_masks.smt, cpu_online_mask);
+}
+
+void __scx_update_idle(struct rq *rq, bool idle)
+{
+	int cpu = cpu_of(rq);
+
+	if (SCX_HAS_OP(update_idle)) {
+		SCX_CALL_OP(SCX_KF_REST, update_idle, cpu_of(rq), idle);
+		if (!static_branch_unlikely(&scx_builtin_idle_enabled))
+			return;
+	}
+
+	if (idle)
+		cpumask_set_cpu(cpu, idle_masks.cpu);
+	else
+		cpumask_clear_cpu(cpu, idle_masks.cpu);
+
+#ifdef CONFIG_SCHED_SMT
+	if (sched_smt_active()) {
+		const struct cpumask *smt = cpu_smt_mask(cpu);
+
+		if (idle) {
+			/*
+			 * idle_masks.smt handling is racy but that's fine as
+			 * it's only for optimization and self-correcting.
+			 */
+			for_each_cpu(cpu, smt) {
+				if (!cpumask_test_cpu(cpu, idle_masks.cpu))
+					return;
+			}
+			cpumask_or(idle_masks.smt, idle_masks.smt, smt);
+		} else {
+			cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
+		}
+	}
+#endif
+}
+
+#else	/* CONFIG_SMP */
+
+static bool test_and_clear_cpu_idle(int cpu) { return false; }
+static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags) { return -EBUSY; }
+static void reset_idle_masks(void) {}
+
+#endif	/* CONFIG_SMP */
+
+static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
+{
+	update_other_load_avgs(rq);
+	update_curr_scx(rq);
+
+	/*
+	 * While bypassing, always resched as we can't trust the slice
+	 * management.
+	 */
+	if (scx_ops_bypassing())
+		curr->scx.slice = 0;
+	else if (SCX_HAS_OP(tick))
+		SCX_CALL_OP(SCX_KF_REST, tick, curr);
+
+	if (!curr->scx.slice)
+		resched_curr(rq);
+}
+
+static enum scx_task_state scx_get_task_state(const struct task_struct *p)
+{
+	return (p->scx.flags & SCX_TASK_STATE_MASK) >> SCX_TASK_STATE_SHIFT;
+}
+
+static void scx_set_task_state(struct task_struct *p, enum scx_task_state state)
+{
+	enum scx_task_state prev_state = scx_get_task_state(p);
+	bool warn = false;
+
+	BUILD_BUG_ON(SCX_TASK_NR_STATES > (1 << SCX_TASK_STATE_BITS));
+
+	switch (state) {
+	case SCX_TASK_NONE:
+		break;
+	case SCX_TASK_INIT:
+		warn = prev_state != SCX_TASK_NONE;
+		break;
+	case SCX_TASK_READY:
+		warn = prev_state == SCX_TASK_NONE;
+		break;
+	case SCX_TASK_ENABLED:
+		warn = prev_state != SCX_TASK_READY;
+		break;
+	default:
+		warn = true;
+		return;
+	}
+
+	WARN_ONCE(warn, "sched_ext: Invalid task state transition %d -> %d for %s[%d]",
+		  prev_state, state, p->comm, p->pid);
+
+	p->scx.flags &= ~SCX_TASK_STATE_MASK;
+	p->scx.flags |= state << SCX_TASK_STATE_SHIFT;
+}
+
+static int scx_ops_init_task(struct task_struct *p, struct task_group *tg, bool fork)
+{
+	int ret;
+
+	if (SCX_HAS_OP(init_task)) {
+		struct scx_init_task_args args = {
+			.fork = fork,
+		};
+
+		ret = SCX_CALL_OP_RET(SCX_KF_SLEEPABLE, init_task, p, &args);
+		if (unlikely(ret)) {
+			ret = ops_sanitize_err("init_task", ret);
+			return ret;
+		}
+	}
+
+	scx_set_task_state(p, SCX_TASK_INIT);
+
+	return 0;
+}
+
+static void set_task_scx_weight(struct task_struct *p)
+{
+	u32 weight = sched_prio_to_weight[p->static_prio - MAX_RT_PRIO];
+
+	p->scx.weight = sched_weight_to_cgroup(weight);
+}
+
+static void scx_ops_enable_task(struct task_struct *p)
+{
+	lockdep_assert_rq_held(task_rq(p));
+
+	/*
+	 * Set the weight before calling ops.enable() so that the scheduler
+	 * doesn't see a stale value if they inspect the task struct.
+	 */
+	set_task_scx_weight(p);
+	if (SCX_HAS_OP(enable))
+		SCX_CALL_OP(SCX_KF_REST, enable, p);
+	scx_set_task_state(p, SCX_TASK_ENABLED);
+
+	if (SCX_HAS_OP(set_weight))
+		SCX_CALL_OP(SCX_KF_REST, set_weight, p, p->scx.weight);
+}
+
+static void scx_ops_disable_task(struct task_struct *p)
+{
+	lockdep_assert_rq_held(task_rq(p));
+	WARN_ON_ONCE(scx_get_task_state(p) != SCX_TASK_ENABLED);
+
+	if (SCX_HAS_OP(disable))
+		SCX_CALL_OP(SCX_KF_REST, disable, p);
+	scx_set_task_state(p, SCX_TASK_READY);
+}
+
+static void scx_ops_exit_task(struct task_struct *p)
+{
+	struct scx_exit_task_args args = {
+		.cancelled = false,
+	};
+
+	lockdep_assert_rq_held(task_rq(p));
+
+	switch (scx_get_task_state(p)) {
+	case SCX_TASK_NONE:
+		return;
+	case SCX_TASK_INIT:
+		args.cancelled = true;
+		break;
+	case SCX_TASK_READY:
+		break;
+	case SCX_TASK_ENABLED:
+		scx_ops_disable_task(p);
+		break;
+	default:
+		WARN_ON_ONCE(true);
+		return;
+	}
+
+	if (SCX_HAS_OP(exit_task))
+		SCX_CALL_OP(SCX_KF_REST, exit_task, p, &args);
+	scx_set_task_state(p, SCX_TASK_NONE);
+}
+
+void init_scx_entity(struct sched_ext_entity *scx)
+{
+	/*
+	 * init_idle() calls this function again after fork sequence is
+	 * complete. Don't touch ->tasks_node as it's already linked.
+	 */
+	memset(scx, 0, offsetof(struct sched_ext_entity, tasks_node));
+
+	INIT_LIST_HEAD(&scx->dsq_node);
+	scx->sticky_cpu = -1;
+	scx->holding_cpu = -1;
+	INIT_LIST_HEAD(&scx->runnable_node);
+	scx->ddsp_dsq_id = SCX_DSQ_INVALID;
+	scx->slice = SCX_SLICE_DFL;
+}
+
+void scx_pre_fork(struct task_struct *p)
+{
+	/*
+	 * BPF scheduler enable/disable paths want to be able to iterate and
+	 * update all tasks which can become complex when racing forks. As
+	 * enable/disable are very cold paths, let's use a percpu_rwsem to
+	 * exclude forks.
+	 */
+	percpu_down_read(&scx_fork_rwsem);
+}
+
+int scx_fork(struct task_struct *p)
+{
+	percpu_rwsem_assert_held(&scx_fork_rwsem);
+
+	if (scx_enabled())
+		return scx_ops_init_task(p, task_group(p), true);
+	else
+		return 0;
+}
+
+void scx_post_fork(struct task_struct *p)
+{
+	if (scx_enabled()) {
+		scx_set_task_state(p, SCX_TASK_READY);
+
+		/*
+		 * Enable the task immediately if it's running on sched_ext.
+		 * Otherwise, it'll be enabled in switching_to_scx() if and
+		 * when it's ever configured to run with a SCHED_EXT policy.
+		 */
+		if (p->sched_class == &ext_sched_class) {
+			struct rq_flags rf;
+			struct rq *rq;
+
+			rq = task_rq_lock(p, &rf);
+			scx_ops_enable_task(p);
+			task_rq_unlock(rq, p, &rf);
+		}
+	}
+
+	spin_lock_irq(&scx_tasks_lock);
+	list_add_tail(&p->scx.tasks_node, &scx_tasks);
+	spin_unlock_irq(&scx_tasks_lock);
+
+	percpu_up_read(&scx_fork_rwsem);
+}
+
+void scx_cancel_fork(struct task_struct *p)
+{
+	if (scx_enabled()) {
+		struct rq *rq;
+		struct rq_flags rf;
+
+		rq = task_rq_lock(p, &rf);
+		WARN_ON_ONCE(scx_get_task_state(p) >= SCX_TASK_READY);
+		scx_ops_exit_task(p);
+		task_rq_unlock(rq, p, &rf);
+	}
+
+	percpu_up_read(&scx_fork_rwsem);
+}
+
+void sched_ext_free(struct task_struct *p)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&scx_tasks_lock, flags);
+	list_del_init(&p->scx.tasks_node);
+	spin_unlock_irqrestore(&scx_tasks_lock, flags);
+
+	/*
+	 * @p is off scx_tasks and wholly ours. scx_ops_enable()'s READY ->
+	 * ENABLED transitions can't race us. Disable ops for @p.
+	 */
+	if (scx_get_task_state(p) != SCX_TASK_NONE) {
+		struct rq_flags rf;
+		struct rq *rq;
+
+		rq = task_rq_lock(p, &rf);
+		scx_ops_exit_task(p);
+		task_rq_unlock(rq, p, &rf);
+	}
+}
+
+static void reweight_task_scx(struct rq *rq, struct task_struct *p, int newprio)
+{
+	lockdep_assert_rq_held(task_rq(p));
+
+	set_task_scx_weight(p);
+	if (SCX_HAS_OP(set_weight))
+		SCX_CALL_OP(SCX_KF_REST, set_weight, p, p->scx.weight);
+}
+
+static void prio_changed_scx(struct rq *rq, struct task_struct *p, int oldprio)
+{
+}
+
+static void switching_to_scx(struct rq *rq, struct task_struct *p)
+{
+	scx_ops_enable_task(p);
+
+	/*
+	 * set_cpus_allowed_scx() is not called while @p is associated with a
+	 * different scheduler class. Keep the BPF scheduler up-to-date.
+	 */
+	if (SCX_HAS_OP(set_cpumask))
+		SCX_CALL_OP(SCX_KF_REST, set_cpumask, p,
+			    (struct cpumask *)p->cpus_ptr);
+}
+
+static void switched_from_scx(struct rq *rq, struct task_struct *p)
+{
+	scx_ops_disable_task(p);
+}
+
+static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p,int wake_flags) {}
+static void switched_to_scx(struct rq *rq, struct task_struct *p) {}
+
+/*
+ * Omitted operations:
+ *
+ * - wakeup_preempt: NOOP as it isn't useful in the wakeup path because the task
+ *   isn't tied to the CPU at that point.
+ *
+ * - migrate_task_rq: Unncessary as task to cpu mapping is transient.
+ *
+ * - task_fork/dead: We need fork/dead notifications for all tasks regardless of
+ *   their current sched_class. Call them directly from sched core instead.
+ *
+ * - task_woken: Unnecessary.
+ */
+DEFINE_SCHED_CLASS(ext) = {
+	.enqueue_task		= enqueue_task_scx,
+	.dequeue_task		= dequeue_task_scx,
+	.yield_task		= yield_task_scx,
+	.yield_to_task		= yield_to_task_scx,
+
+	.wakeup_preempt		= wakeup_preempt_scx,
+
+	.pick_next_task		= pick_next_task_scx,
+
+	.put_prev_task		= put_prev_task_scx,
+	.set_next_task		= set_next_task_scx,
+
+#ifdef CONFIG_SMP
+	.balance		= balance_scx,
+	.select_task_rq		= select_task_rq_scx,
+	.set_cpus_allowed	= set_cpus_allowed_scx,
+#endif
+
+	.task_tick		= task_tick_scx,
+
+	.switching_to		= switching_to_scx,
+	.switched_from		= switched_from_scx,
+	.switched_to		= switched_to_scx,
+	.reweight_task		= reweight_task_scx,
+	.prio_changed		= prio_changed_scx,
+
+	.update_curr		= update_curr_scx,
+
+#ifdef CONFIG_UCLAMP_TASK
+	.uclamp_enabled		= 0,
+#endif
+};
+
+static void init_dsq(struct scx_dispatch_q *dsq, u64 dsq_id)
+{
+	memset(dsq, 0, sizeof(*dsq));
+
+	raw_spin_lock_init(&dsq->lock);
+	INIT_LIST_HEAD(&dsq->list);
+	dsq->id = dsq_id;
+}
+
+static struct scx_dispatch_q *create_dsq(u64 dsq_id, int node)
+{
+	struct scx_dispatch_q *dsq;
+	int ret;
+
+	if (dsq_id & SCX_DSQ_FLAG_BUILTIN)
+		return ERR_PTR(-EINVAL);
+
+	dsq = kmalloc_node(sizeof(*dsq), GFP_KERNEL, node);
+	if (!dsq)
+		return ERR_PTR(-ENOMEM);
+
+	init_dsq(dsq, dsq_id);
+
+	ret = rhashtable_insert_fast(&dsq_hash, &dsq->hash_node,
+				     dsq_hash_params);
+	if (ret) {
+		kfree(dsq);
+		return ERR_PTR(ret);
+	}
+	return dsq;
+}
+
+static void free_dsq_irq_workfn(struct irq_work *irq_work)
+{
+	struct llist_node *to_free = llist_del_all(&dsqs_to_free);
+	struct scx_dispatch_q *dsq, *tmp_dsq;
+
+	llist_for_each_entry_safe(dsq, tmp_dsq, to_free, free_node)
+		kfree_rcu(dsq, rcu);
+}
+
+static DEFINE_IRQ_WORK(free_dsq_irq_work, free_dsq_irq_workfn);
+
+static void destroy_dsq(u64 dsq_id)
+{
+	struct scx_dispatch_q *dsq;
+	unsigned long flags;
+
+	rcu_read_lock();
+
+	dsq = find_user_dsq(dsq_id);
+	if (!dsq)
+		goto out_unlock_rcu;
+
+	raw_spin_lock_irqsave(&dsq->lock, flags);
+
+	if (dsq->nr) {
+		scx_ops_error("attempting to destroy in-use dsq 0x%016llx (nr=%u)",
+			      dsq->id, dsq->nr);
+		goto out_unlock_dsq;
+	}
+
+	if (rhashtable_remove_fast(&dsq_hash, &dsq->hash_node, dsq_hash_params))
+		goto out_unlock_dsq;
+
+	/*
+	 * Mark dead by invalidating ->id to prevent dispatch_enqueue() from
+	 * queueing more tasks. As this function can be called from anywhere,
+	 * freeing is bounced through an irq work to avoid nesting RCU
+	 * operations inside scheduler locks.
+	 */
+	dsq->id = SCX_DSQ_INVALID;
+	llist_add(&dsq->free_node, &dsqs_to_free);
+	irq_work_queue(&free_dsq_irq_work);
+
+out_unlock_dsq:
+	raw_spin_unlock_irqrestore(&dsq->lock, flags);
+out_unlock_rcu:
+	rcu_read_unlock();
+}
+
+
+/********************************************************************************
+ * Sysfs interface and ops enable/disable.
+ */
+
+#define SCX_ATTR(_name)								\
+	static struct kobj_attribute scx_attr_##_name = {			\
+		.attr = { .name = __stringify(_name), .mode = 0444 },		\
+		.show = scx_attr_##_name##_show,				\
+	}
+
+static ssize_t scx_attr_state_show(struct kobject *kobj,
+				   struct kobj_attribute *ka, char *buf)
+{
+	return sysfs_emit(buf, "%s\n",
+			  scx_ops_enable_state_str[scx_ops_enable_state()]);
+}
+SCX_ATTR(state);
+
+static ssize_t scx_attr_switch_all_show(struct kobject *kobj,
+					struct kobj_attribute *ka, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", READ_ONCE(scx_switching_all));
+}
+SCX_ATTR(switch_all);
+
+static struct attribute *scx_global_attrs[] = {
+	&scx_attr_state.attr,
+	&scx_attr_switch_all.attr,
+	NULL,
+};
+
+static const struct attribute_group scx_global_attr_group = {
+	.attrs = scx_global_attrs,
+};
+
+static void scx_kobj_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
+static ssize_t scx_attr_ops_show(struct kobject *kobj,
+				 struct kobj_attribute *ka, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", scx_ops.name);
+}
+SCX_ATTR(ops);
+
+static struct attribute *scx_sched_attrs[] = {
+	&scx_attr_ops.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(scx_sched);
+
+static const struct kobj_type scx_ktype = {
+	.release = scx_kobj_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = scx_sched_groups,
+};
+
+static int scx_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
+{
+	return add_uevent_var(env, "SCXOPS=%s", scx_ops.name);
+}
+
+static const struct kset_uevent_ops scx_uevent_ops = {
+	.uevent = scx_uevent,
+};
+
+/*
+ * Used by sched_fork() and __setscheduler_prio() to pick the matching
+ * sched_class. dl/rt are already handled.
+ */
+bool task_should_scx(struct task_struct *p)
+{
+	if (!scx_enabled() ||
+	    unlikely(scx_ops_enable_state() == SCX_OPS_DISABLING))
+		return false;
+	if (READ_ONCE(scx_switching_all))
+		return true;
+	return p->policy == SCHED_EXT;
+}
+
+/**
+ * scx_ops_bypass - [Un]bypass scx_ops and guarantee forward progress
+ *
+ * Bypassing guarantees that all runnable tasks make forward progress without
+ * trusting the BPF scheduler. We can't grab any mutexes or rwsems as they might
+ * be held by tasks that the BPF scheduler is forgetting to run, which
+ * unfortunately also excludes toggling the static branches.
+ *
+ * Let's work around by overriding a couple ops and modifying behaviors based on
+ * the DISABLING state and then cycling the queued tasks through dequeue/enqueue
+ * to force global FIFO scheduling.
+ *
+ * a. ops.enqueue() is ignored and tasks are queued in simple global FIFO order.
+ *
+ * b. ops.dispatch() is ignored.
+ *
+ * c. balance_scx() never sets %SCX_TASK_BAL_KEEP as the slice value can't be
+ *    trusted. Whenever a tick triggers, the running task is rotated to the tail
+ *    of the queue.
+ *
+ * d. pick_next_task() suppresses zero slice warning.
+ */
+static void scx_ops_bypass(bool bypass)
+{
+	int depth, cpu;
+
+	if (bypass) {
+		depth = atomic_inc_return(&scx_ops_bypass_depth);
+		WARN_ON_ONCE(depth <= 0);
+		if (depth != 1)
+			return;
+	} else {
+		depth = atomic_dec_return(&scx_ops_bypass_depth);
+		WARN_ON_ONCE(depth < 0);
+		if (depth != 0)
+			return;
+	}
+
+	mutex_lock(&scx_ops_enable_mutex);
+	if (!scx_enabled())
+		goto out_unlock;
+
+	/*
+	 * No task property is changing. We just need to make sure all currently
+	 * queued tasks are re-queued according to the new scx_ops_bypassing()
+	 * state. As an optimization, walk each rq's runnable_list instead of
+	 * the scx_tasks list.
+	 *
+	 * This function can't trust the scheduler and thus can't use
+	 * cpus_read_lock(). Walk all possible CPUs instead of online.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct rq *rq = cpu_rq(cpu);
+		struct rq_flags rf;
+		struct task_struct *p, *n;
+
+		rq_lock_irqsave(rq, &rf);
+
+		/*
+		 * The use of list_for_each_entry_safe_reverse() is required
+		 * because each task is going to be removed from and added back
+		 * to the runnable_list during iteration. Because they're added
+		 * to the tail of the list, safe reverse iteration can still
+		 * visit all nodes.
+		 */
+		list_for_each_entry_safe_reverse(p, n, &rq->scx.runnable_list,
+						 scx.runnable_node) {
+			struct sched_enq_and_set_ctx ctx;
+
+			/* cycling deq/enq is enough, see the function comment */
+			sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
+			sched_enq_and_set_task(&ctx);
+		}
+
+		rq_unlock_irqrestore(rq, &rf);
+	}
+
+out_unlock:
+	mutex_unlock(&scx_ops_enable_mutex);
+}
+
+static void free_exit_info(struct scx_exit_info *ei)
+{
+	kfree(ei->msg);
+	kfree(ei->bt);
+	kfree(ei);
+}
+
+static struct scx_exit_info *alloc_exit_info(void)
+{
+	struct scx_exit_info *ei;
+
+	ei = kzalloc(sizeof(*ei), GFP_KERNEL);
+	if (!ei)
+		return NULL;
+
+	ei->bt = kcalloc(sizeof(ei->bt[0]), SCX_EXIT_BT_LEN, GFP_KERNEL);
+	ei->msg = kzalloc(SCX_EXIT_MSG_LEN, GFP_KERNEL);
+
+	if (!ei->bt || !ei->msg) {
+		free_exit_info(ei);
+		return NULL;
+	}
+
+	return ei;
+}
+
+static const char *scx_exit_reason(enum scx_exit_kind kind)
+{
+	switch (kind) {
+	case SCX_EXIT_UNREG:
+		return "Scheduler unregistered from user space";
+	case SCX_EXIT_UNREG_BPF:
+		return "Scheduler unregistered from BPF";
+	case SCX_EXIT_UNREG_KERN:
+		return "Scheduler unregistered from the main kernel";
+	case SCX_EXIT_ERROR:
+		return "runtime error";
+	case SCX_EXIT_ERROR_BPF:
+		return "scx_bpf_error";
+	default:
+		return "<UNKNOWN>";
+	}
+}
+
+static void scx_ops_disable_workfn(struct kthread_work *work)
+{
+	struct scx_exit_info *ei = scx_exit_info;
+	struct scx_task_iter sti;
+	struct task_struct *p;
+	struct rhashtable_iter rht_iter;
+	struct scx_dispatch_q *dsq;
+	int i, kind;
+
+	kind = atomic_read(&scx_exit_kind);
+	while (true) {
+		/*
+		 * NONE indicates that a new scx_ops has been registered since
+		 * disable was scheduled - don't kill the new ops. DONE
+		 * indicates that the ops has already been disabled.
+		 */
+		if (kind == SCX_EXIT_NONE || kind == SCX_EXIT_DONE)
+			return;
+		if (atomic_try_cmpxchg(&scx_exit_kind, &kind, SCX_EXIT_DONE))
+			break;
+	}
+	ei->kind = kind;
+	ei->reason = scx_exit_reason(ei->kind);
+
+	/* guarantee forward progress by bypassing scx_ops */
+	scx_ops_bypass(true);
+
+	switch (scx_ops_set_enable_state(SCX_OPS_DISABLING)) {
+	case SCX_OPS_DISABLING:
+		WARN_ONCE(true, "sched_ext: duplicate disabling instance?");
+		break;
+	case SCX_OPS_DISABLED:
+		pr_warn("sched_ext: ops error detected without ops (%s)\n",
+			scx_exit_info->msg);
+		WARN_ON_ONCE(scx_ops_set_enable_state(SCX_OPS_DISABLED) !=
+			     SCX_OPS_DISABLING);
+		goto done;
+	default:
+		break;
+	}
+
+	/*
+	 * Here, every runnable task is guaranteed to make forward progress and
+	 * we can safely use blocking synchronization constructs. Actually
+	 * disable ops.
+	 */
+	mutex_lock(&scx_ops_enable_mutex);
+
+	static_branch_disable(&__scx_switched_all);
+	WRITE_ONCE(scx_switching_all, false);
+
+	/*
+	 * Avoid racing against fork. See scx_ops_enable() for explanation on
+	 * the locking order.
+	 */
+	percpu_down_write(&scx_fork_rwsem);
+	cpus_read_lock();
+
+	spin_lock_irq(&scx_tasks_lock);
+	scx_task_iter_init(&sti);
+	while ((p = scx_task_iter_next_filtered_locked(&sti))) {
+		const struct sched_class *old_class = p->sched_class;
+		struct sched_enq_and_set_ctx ctx;
+
+		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
+
+		p->scx.slice = min_t(u64, p->scx.slice, SCX_SLICE_DFL);
+		__setscheduler_prio(p, p->prio);
+		check_class_changing(task_rq(p), p, old_class);
+
+		sched_enq_and_set_task(&ctx);
+
+		check_class_changed(task_rq(p), p, old_class, p->prio);
+		scx_ops_exit_task(p);
+	}
+	scx_task_iter_exit(&sti);
+	spin_unlock_irq(&scx_tasks_lock);
+
+	/* no task is on scx, turn off all the switches and flush in-progress calls */
+	static_branch_disable_cpuslocked(&__scx_ops_enabled);
+	for (i = SCX_OPI_BEGIN; i < SCX_OPI_END; i++)
+		static_branch_disable_cpuslocked(&scx_has_op[i]);
+	static_branch_disable_cpuslocked(&scx_ops_enq_last);
+	static_branch_disable_cpuslocked(&scx_ops_enq_exiting);
+	static_branch_disable_cpuslocked(&scx_builtin_idle_enabled);
+	synchronize_rcu();
+
+	cpus_read_unlock();
+	percpu_up_write(&scx_fork_rwsem);
+
+	if (ei->kind >= SCX_EXIT_ERROR) {
+		printk(KERN_ERR "sched_ext: BPF scheduler \"%s\" errored, disabling\n", scx_ops.name);
+
+		if (ei->msg[0] == '\0')
+			printk(KERN_ERR "sched_ext: %s\n", ei->reason);
+		else
+			printk(KERN_ERR "sched_ext: %s (%s)\n", ei->reason, ei->msg);
+
+		stack_trace_print(ei->bt, ei->bt_len, 2);
+	}
+
+	if (scx_ops.exit)
+		SCX_CALL_OP(SCX_KF_UNLOCKED, exit, ei);
+
+	/*
+	 * Delete the kobject from the hierarchy eagerly in addition to just
+	 * dropping a reference. Otherwise, if the object is deleted
+	 * asynchronously, sysfs could observe an object of the same name still
+	 * in the hierarchy when another scheduler is loaded.
+	 */
+	kobject_del(scx_root_kobj);
+	kobject_put(scx_root_kobj);
+	scx_root_kobj = NULL;
+
+	memset(&scx_ops, 0, sizeof(scx_ops));
+
+	rhashtable_walk_enter(&dsq_hash, &rht_iter);
+	do {
+		rhashtable_walk_start(&rht_iter);
+
+		while ((dsq = rhashtable_walk_next(&rht_iter)) && !IS_ERR(dsq))
+			destroy_dsq(dsq->id);
+
+		rhashtable_walk_stop(&rht_iter);
+	} while (dsq == ERR_PTR(-EAGAIN));
+	rhashtable_walk_exit(&rht_iter);
+
+	free_percpu(scx_dsp_buf);
+	scx_dsp_buf = NULL;
+	scx_dsp_max_batch = 0;
+
+	free_exit_info(scx_exit_info);
+	scx_exit_info = NULL;
+
+	mutex_unlock(&scx_ops_enable_mutex);
+
+	WARN_ON_ONCE(scx_ops_set_enable_state(SCX_OPS_DISABLED) !=
+		     SCX_OPS_DISABLING);
+done:
+	scx_ops_bypass(false);
+}
+
+static DEFINE_KTHREAD_WORK(scx_ops_disable_work, scx_ops_disable_workfn);
+
+static void schedule_scx_ops_disable_work(void)
+{
+	struct kthread_worker *helper = READ_ONCE(scx_ops_helper);
+
+	/*
+	 * We may be called spuriously before the first bpf_sched_ext_reg(). If
+	 * scx_ops_helper isn't set up yet, there's nothing to do.
+	 */
+	if (helper)
+		kthread_queue_work(helper, &scx_ops_disable_work);
+}
+
+static void scx_ops_disable(enum scx_exit_kind kind)
+{
+	int none = SCX_EXIT_NONE;
+
+	if (WARN_ON_ONCE(kind == SCX_EXIT_NONE || kind == SCX_EXIT_DONE))
+		kind = SCX_EXIT_ERROR;
+
+	atomic_try_cmpxchg(&scx_exit_kind, &none, kind);
+
+	schedule_scx_ops_disable_work();
+}
+
+static void scx_ops_error_irq_workfn(struct irq_work *irq_work)
+{
+	schedule_scx_ops_disable_work();
+}
+
+static DEFINE_IRQ_WORK(scx_ops_error_irq_work, scx_ops_error_irq_workfn);
+
+static __printf(3, 4) void scx_ops_exit_kind(enum scx_exit_kind kind,
+					     s64 exit_code,
+					     const char *fmt, ...)
+{
+	struct scx_exit_info *ei = scx_exit_info;
+	int none = SCX_EXIT_NONE;
+	va_list args;
+
+	if (!atomic_try_cmpxchg(&scx_exit_kind, &none, kind))
+		return;
+
+	ei->exit_code = exit_code;
+
+	if (kind >= SCX_EXIT_ERROR)
+		ei->bt_len = stack_trace_save(ei->bt, SCX_EXIT_BT_LEN, 1);
+
+	va_start(args, fmt);
+	vscnprintf(ei->msg, SCX_EXIT_MSG_LEN, fmt, args);
+	va_end(args);
+
+	irq_work_queue(&scx_ops_error_irq_work);
+}
+
+static struct kthread_worker *scx_create_rt_helper(const char *name)
+{
+	struct kthread_worker *helper;
+
+	helper = kthread_create_worker(0, name);
+	if (helper)
+		sched_set_fifo(helper->task);
+	return helper;
+}
+
+static int validate_ops(const struct sched_ext_ops *ops)
+{
+	/*
+	 * It doesn't make sense to specify the SCX_OPS_ENQ_LAST flag if the
+	 * ops.enqueue() callback isn't implemented.
+	 */
+	if ((ops->flags & SCX_OPS_ENQ_LAST) && !ops->enqueue) {
+		scx_ops_error("SCX_OPS_ENQ_LAST requires ops.enqueue() to be implemented");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int scx_ops_enable(struct sched_ext_ops *ops)
+{
+	struct scx_task_iter sti;
+	struct task_struct *p;
+	int i, ret;
+
+	mutex_lock(&scx_ops_enable_mutex);
+
+	if (!scx_ops_helper) {
+		WRITE_ONCE(scx_ops_helper,
+			   scx_create_rt_helper("sched_ext_ops_helper"));
+		if (!scx_ops_helper) {
+			ret = -ENOMEM;
+			goto err_unlock;
+		}
+	}
+
+	if (scx_ops_enable_state() != SCX_OPS_DISABLED) {
+		ret = -EBUSY;
+		goto err_unlock;
+	}
+
+	scx_root_kobj = kzalloc(sizeof(*scx_root_kobj), GFP_KERNEL);
+	if (!scx_root_kobj) {
+		ret = -ENOMEM;
+		goto err_unlock;
+	}
+
+	scx_root_kobj->kset = scx_kset;
+	ret = kobject_init_and_add(scx_root_kobj, &scx_ktype, NULL, "root");
+	if (ret < 0)
+		goto err;
+
+	scx_exit_info = alloc_exit_info();
+	if (!scx_exit_info) {
+		ret = -ENOMEM;
+		goto err_del;
+	}
+
+	/*
+	 * Set scx_ops, transition to PREPPING and clear exit info to arm the
+	 * disable path. Failure triggers full disabling from here on.
+	 */
+	scx_ops = *ops;
+
+	WARN_ON_ONCE(scx_ops_set_enable_state(SCX_OPS_PREPPING) !=
+		     SCX_OPS_DISABLED);
+
+	atomic_set(&scx_exit_kind, SCX_EXIT_NONE);
+	scx_warned_zero_slice = false;
+
+	/*
+	 * Keep CPUs stable during enable so that the BPF scheduler can track
+	 * online CPUs by watching ->on/offline_cpu() after ->init().
+	 */
+	cpus_read_lock();
+
+	if (scx_ops.init) {
+		ret = SCX_CALL_OP_RET(SCX_KF_SLEEPABLE, init);
+		if (ret) {
+			ret = ops_sanitize_err("init", ret);
+			goto err_disable_unlock_cpus;
+		}
+	}
+
+	cpus_read_unlock();
+
+	ret = validate_ops(ops);
+	if (ret)
+		goto err_disable;
+
+	WARN_ON_ONCE(scx_dsp_buf);
+	scx_dsp_max_batch = ops->dispatch_max_batch ?: SCX_DSP_DFL_MAX_BATCH;
+	scx_dsp_buf = __alloc_percpu(sizeof(scx_dsp_buf[0]) * scx_dsp_max_batch,
+				     __alignof__(scx_dsp_buf[0]));
+	if (!scx_dsp_buf) {
+		ret = -ENOMEM;
+		goto err_disable;
+	}
+
+	/*
+	 * Lock out forks before opening the floodgate so that they don't wander
+	 * into the operations prematurely.
+	 *
+	 * We don't need to keep the CPUs stable but grab cpus_read_lock() to
+	 * ease future locking changes for cgroup suport.
+	 *
+	 * Note that cpu_hotplug_lock must nest inside scx_fork_rwsem due to the
+	 * following dependency chain:
+	 *
+	 *   scx_fork_rwsem --> pernet_ops_rwsem --> cpu_hotplug_lock
+	 */
+	percpu_down_write(&scx_fork_rwsem);
+	cpus_read_lock();
+
+	for (i = SCX_OPI_NORMAL_BEGIN; i < SCX_OPI_NORMAL_END; i++)
+		if (((void (**)(void))ops)[i])
+			static_branch_enable_cpuslocked(&scx_has_op[i]);
+
+	if (ops->flags & SCX_OPS_ENQ_LAST)
+		static_branch_enable_cpuslocked(&scx_ops_enq_last);
+
+	if (ops->flags & SCX_OPS_ENQ_EXITING)
+		static_branch_enable_cpuslocked(&scx_ops_enq_exiting);
+
+	if (!ops->update_idle || (ops->flags & SCX_OPS_KEEP_BUILTIN_IDLE)) {
+		reset_idle_masks();
+		static_branch_enable_cpuslocked(&scx_builtin_idle_enabled);
+	} else {
+		static_branch_disable_cpuslocked(&scx_builtin_idle_enabled);
+	}
+
+	static_branch_enable_cpuslocked(&__scx_ops_enabled);
+
+	/*
+	 * Enable ops for every task. Fork is excluded by scx_fork_rwsem
+	 * preventing new tasks from being added. No need to exclude tasks
+	 * leaving as sched_ext_free() can handle both prepped and enabled
+	 * tasks. Prep all tasks first and then enable them with preemption
+	 * disabled.
+	 */
+	spin_lock_irq(&scx_tasks_lock);
+
+	scx_task_iter_init(&sti);
+	while ((p = scx_task_iter_next_filtered(&sti))) {
+		get_task_struct(p);
+		spin_unlock_irq(&scx_tasks_lock);
+
+		ret = scx_ops_init_task(p, task_group(p), false);
+		if (ret) {
+			put_task_struct(p);
+			spin_lock_irq(&scx_tasks_lock);
+			scx_task_iter_exit(&sti);
+			spin_unlock_irq(&scx_tasks_lock);
+			pr_err("sched_ext: ops.init_task() failed (%d) for %s[%d] while loading\n",
+			       ret, p->comm, p->pid);
+			goto err_disable_unlock_all;
+		}
+
+		put_task_struct(p);
+		spin_lock_irq(&scx_tasks_lock);
+	}
+	scx_task_iter_exit(&sti);
+
+	/*
+	 * All tasks are prepped but are still ops-disabled. Ensure that
+	 * %current can't be scheduled out and switch everyone.
+	 * preempt_disable() is necessary because we can't guarantee that
+	 * %current won't be starved if scheduled out while switching.
+	 */
+	preempt_disable();
+
+	/*
+	 * From here on, the disable path must assume that tasks have ops
+	 * enabled and need to be recovered.
+	 *
+	 * Transition to ENABLING fails iff the BPF scheduler has already
+	 * triggered scx_bpf_error(). Returning an error code here would lose
+	 * the recorded error information. Exit indicating success so that the
+	 * error is notified through ops.exit() with all the details.
+	 */
+	if (!scx_ops_tryset_enable_state(SCX_OPS_ENABLING, SCX_OPS_PREPPING)) {
+		preempt_enable();
+		spin_unlock_irq(&scx_tasks_lock);
+		WARN_ON_ONCE(atomic_read(&scx_exit_kind) == SCX_EXIT_NONE);
+		ret = 0;
+		goto err_disable_unlock_all;
+	}
+
+	/*
+	 * We're fully committed and can't fail. The PREPPED -> ENABLED
+	 * transitions here are synchronized against sched_ext_free() through
+	 * scx_tasks_lock.
+	 */
+	WRITE_ONCE(scx_switching_all, !(ops->flags & SCX_OPS_SWITCH_PARTIAL));
+
+	scx_task_iter_init(&sti);
+	while ((p = scx_task_iter_next_filtered_locked(&sti))) {
+		const struct sched_class *old_class = p->sched_class;
+		struct sched_enq_and_set_ctx ctx;
+
+		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
+
+		scx_set_task_state(p, SCX_TASK_READY);
+		__setscheduler_prio(p, p->prio);
+		check_class_changing(task_rq(p), p, old_class);
+
+		sched_enq_and_set_task(&ctx);
+
+		check_class_changed(task_rq(p), p, old_class, p->prio);
+	}
+	scx_task_iter_exit(&sti);
+
+	spin_unlock_irq(&scx_tasks_lock);
+	preempt_enable();
+	cpus_read_unlock();
+	percpu_up_write(&scx_fork_rwsem);
+
+	/* see above ENABLING transition for the explanation on exiting with 0 */
+	if (!scx_ops_tryset_enable_state(SCX_OPS_ENABLED, SCX_OPS_ENABLING)) {
+		WARN_ON_ONCE(atomic_read(&scx_exit_kind) == SCX_EXIT_NONE);
+		ret = 0;
+		goto err_disable;
+	}
+
+	if (!(ops->flags & SCX_OPS_SWITCH_PARTIAL))
+		static_branch_enable(&__scx_switched_all);
+
+	kobject_uevent(scx_root_kobj, KOBJ_ADD);
+	mutex_unlock(&scx_ops_enable_mutex);
+
+	return 0;
+
+err_del:
+	kobject_del(scx_root_kobj);
+err:
+	kobject_put(scx_root_kobj);
+	scx_root_kobj = NULL;
+	if (scx_exit_info) {
+		free_exit_info(scx_exit_info);
+		scx_exit_info = NULL;
+	}
+err_unlock:
+	mutex_unlock(&scx_ops_enable_mutex);
+	return ret;
+
+err_disable_unlock_all:
+	percpu_up_write(&scx_fork_rwsem);
+err_disable_unlock_cpus:
+	cpus_read_unlock();
+err_disable:
+	mutex_unlock(&scx_ops_enable_mutex);
+	/* must be fully disabled before returning */
+	scx_ops_disable(SCX_EXIT_ERROR);
+	kthread_flush_work(&scx_ops_disable_work);
+	return ret;
+}
+
+
+/********************************************************************************
+ * bpf_struct_ops plumbing.
+ */
+#include <linux/bpf_verifier.h>
+#include <linux/bpf.h>
+#include <linux/btf.h>
+
+extern struct btf *btf_vmlinux;
+static const struct btf_type *task_struct_type;
+static u32 task_struct_type_id;
+
+/* Make the 2nd argument of .dispatch a pointer that can be NULL. */
+static bool promote_dispatch_2nd_arg(int off, int size,
+				     enum bpf_access_type type,
+				     const struct bpf_prog *prog,
+				     struct bpf_insn_access_aux *info)
+{
+	struct btf *btf = bpf_get_btf_vmlinux();
+	const struct bpf_struct_ops_desc *st_ops_desc;
+	const struct btf_member *member;
+	const struct btf_type *t;
+	u32 btf_id, member_idx;
+	const char *mname;
+
+	/* btf_id should be the type id of struct sched_ext_ops */
+	btf_id = prog->aux->attach_btf_id;
+	st_ops_desc = bpf_struct_ops_find(btf, btf_id);
+	if (!st_ops_desc)
+		return false;
+
+	/* BTF type of struct sched_ext_ops */
+	t = st_ops_desc->type;
+
+	member_idx = prog->expected_attach_type;
+	if (member_idx >= btf_type_vlen(t))
+		return false;
+
+	/*
+	 * Get the member name of this struct_ops program, which corresponds to
+	 * a field in struct sched_ext_ops. For example, the member name of the
+	 * dispatch struct_ops program (callback) is "dispatch".
+	 */
+	member = &btf_type_member(t)[member_idx];
+	mname = btf_name_by_offset(btf_vmlinux, member->name_off);
+
+	/*
+	 * Check if it is the second argument of the function pointer at
+	 * "dispatch" in struct sched_ext_ops. The arguments of struct_ops
+	 * operators are sequential and 64-bit, so the second argument is at
+	 * offset sizeof(__u64).
+	 */
+	if (strcmp(mname, "dispatch") == 0 &&
+	    off == sizeof(__u64)) {
+		/*
+		 * The value is a pointer to a type (struct task_struct) given
+		 * by a BTF ID (PTR_TO_BTF_ID). It is trusted (PTR_TRUSTED),
+		 * however, can be a NULL (PTR_MAYBE_NULL). The BPF program
+		 * should check the pointer to make sure it is not NULL before
+		 * using it, or the verifier will reject the program.
+		 *
+		 * Longer term, this is something that should be addressed by
+		 * BTF, and be fully contained within the verifier.
+		 */
+		info->reg_type = PTR_MAYBE_NULL | PTR_TO_BTF_ID | PTR_TRUSTED;
+		info->btf = btf_vmlinux;
+		info->btf_id = task_struct_type_id;
+
+		return true;
+	}
+
+	return false;
+}
+
+static bool bpf_scx_is_valid_access(int off, int size,
+				    enum bpf_access_type type,
+				    const struct bpf_prog *prog,
+				    struct bpf_insn_access_aux *info)
+{
+	if (type != BPF_READ)
+		return false;
+	if (promote_dispatch_2nd_arg(off, size, type, prog, info))
+		return true;
+	if (off < 0 || off >= sizeof(__u64) * MAX_BPF_FUNC_ARGS)
+		return false;
+	if (off % size != 0)
+		return false;
+
+	return btf_ctx_access(off, size, type, prog, info);
+}
+
+static int bpf_scx_btf_struct_access(struct bpf_verifier_log *log,
+				     const struct bpf_reg_state *reg, int off,
+				     int size)
+{
+	const struct btf_type *t;
+
+	t = btf_type_by_id(reg->btf, reg->btf_id);
+	if (t == task_struct_type) {
+		if (off >= offsetof(struct task_struct, scx.slice) &&
+		    off + size <= offsetofend(struct task_struct, scx.slice))
+			return SCALAR_VALUE;
+	}
+
+	return -EACCES;
+}
+
+static const struct bpf_func_proto *
+bpf_scx_get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	switch (func_id) {
+	case BPF_FUNC_task_storage_get:
+		return &bpf_task_storage_get_proto;
+	case BPF_FUNC_task_storage_delete:
+		return &bpf_task_storage_delete_proto;
+	default:
+		return bpf_base_func_proto(func_id, prog);
+	}
+}
+
+static const struct bpf_verifier_ops bpf_scx_verifier_ops = {
+	.get_func_proto = bpf_scx_get_func_proto,
+	.is_valid_access = bpf_scx_is_valid_access,
+	.btf_struct_access = bpf_scx_btf_struct_access,
+};
+
+static int bpf_scx_init_member(const struct btf_type *t,
+			       const struct btf_member *member,
+			       void *kdata, const void *udata)
+{
+	const struct sched_ext_ops *uops = udata;
+	struct sched_ext_ops *ops = kdata;
+	u32 moff = __btf_member_bit_offset(t, member) / 8;
+	int ret;
+
+	switch (moff) {
+	case offsetof(struct sched_ext_ops, dispatch_max_batch):
+		if (*(u32 *)(udata + moff) > INT_MAX)
+			return -E2BIG;
+		ops->dispatch_max_batch = *(u32 *)(udata + moff);
+		return 1;
+	case offsetof(struct sched_ext_ops, flags):
+		if (*(u64 *)(udata + moff) & ~SCX_OPS_ALL_FLAGS)
+			return -EINVAL;
+		ops->flags = *(u64 *)(udata + moff);
+		return 1;
+	case offsetof(struct sched_ext_ops, name):
+		ret = bpf_obj_name_cpy(ops->name, uops->name,
+				       sizeof(ops->name));
+		if (ret < 0)
+			return ret;
+		if (ret == 0)
+			return -EINVAL;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int bpf_scx_check_member(const struct btf_type *t,
+				const struct btf_member *member,
+				const struct bpf_prog *prog)
+{
+	u32 moff = __btf_member_bit_offset(t, member) / 8;
+
+	switch (moff) {
+	case offsetof(struct sched_ext_ops, init_task):
+	case offsetof(struct sched_ext_ops, init):
+	case offsetof(struct sched_ext_ops, exit):
+		break;
+	default:
+		if (prog->sleepable)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int bpf_scx_reg(void *kdata)
+{
+	return scx_ops_enable(kdata);
+}
+
+static void bpf_scx_unreg(void *kdata)
+{
+	scx_ops_disable(SCX_EXIT_UNREG);
+	kthread_flush_work(&scx_ops_disable_work);
+}
+
+static int bpf_scx_init(struct btf *btf)
+{
+	u32 type_id;
+
+	type_id = btf_find_by_name_kind(btf, "task_struct", BTF_KIND_STRUCT);
+	if (type_id < 0)
+		return -EINVAL;
+	task_struct_type = btf_type_by_id(btf, type_id);
+	task_struct_type_id = type_id;
+
+	return 0;
+}
+
+static int bpf_scx_update(void *kdata, void *old_kdata)
+{
+	/*
+	 * sched_ext does not support updating the actively-loaded BPF
+	 * scheduler, as registering a BPF scheduler can always fail if the
+	 * scheduler returns an error code for e.g. ops.init(), ops.init_task(),
+	 * etc. Similarly, we can always race with unregistration happening
+	 * elsewhere, such as with sysrq.
+	 */
+	return -EOPNOTSUPP;
+}
+
+static int bpf_scx_validate(void *kdata)
+{
+	return 0;
+}
+
+static s32 select_cpu_stub(struct task_struct *p, s32 prev_cpu, u64 wake_flags) { return -EINVAL; }
+static void enqueue_stub(struct task_struct *p, u64 enq_flags) {}
+static void dequeue_stub(struct task_struct *p, u64 enq_flags) {}
+static void dispatch_stub(s32 prev_cpu, struct task_struct *p) {}
+static bool yield_stub(struct task_struct *from, struct task_struct *to) { return false; }
+static void set_weight_stub(struct task_struct *p, u32 weight) {}
+static void set_cpumask_stub(struct task_struct *p, const struct cpumask *mask) {}
+static void update_idle_stub(s32 cpu, bool idle) {}
+static s32 init_task_stub(struct task_struct *p, struct scx_init_task_args *args) { return -EINVAL; }
+static void exit_task_stub(struct task_struct *p, struct scx_exit_task_args *args) {}
+static void enable_stub(struct task_struct *p) {}
+static void disable_stub(struct task_struct *p) {}
+static s32 init_stub(void) { return -EINVAL; }
+static void exit_stub(struct scx_exit_info *info) {}
+
+static struct sched_ext_ops __bpf_ops_sched_ext_ops = {
+	.select_cpu = select_cpu_stub,
+	.enqueue = enqueue_stub,
+	.dequeue = dequeue_stub,
+	.dispatch = dispatch_stub,
+	.yield = yield_stub,
+	.set_weight = set_weight_stub,
+	.set_cpumask = set_cpumask_stub,
+	.update_idle = update_idle_stub,
+	.init_task = init_task_stub,
+	.exit_task = exit_task_stub,
+	.enable = enable_stub,
+	.disable = disable_stub,
+	.init = init_stub,
+	.exit = exit_stub,
+};
+
+static struct bpf_struct_ops bpf_sched_ext_ops = {
+	.verifier_ops = &bpf_scx_verifier_ops,
+	.reg = bpf_scx_reg,
+	.unreg = bpf_scx_unreg,
+	.check_member = bpf_scx_check_member,
+	.init_member = bpf_scx_init_member,
+	.init = bpf_scx_init,
+	.update = bpf_scx_update,
+	.validate = bpf_scx_validate,
+	.name = "sched_ext_ops",
+	.owner = THIS_MODULE,
+	.cfi_stubs = &__bpf_ops_sched_ext_ops
+};
+
+
+/********************************************************************************
+ * System integration and init.
+ */
+
+void __init init_sched_ext_class(void)
+{
+	s32 cpu, v;
+
+	/*
+	 * The following is to prevent the compiler from optimizing out the enum
+	 * definitions so that BPF scheduler implementations can use them
+	 * through the generated vmlinux.h.
+	 */
+	WRITE_ONCE(v, SCX_ENQ_WAKEUP | SCX_DEQ_SLEEP);
+
+	BUG_ON(rhashtable_init(&dsq_hash, &dsq_hash_params));
+	init_dsq(&scx_dsq_global, SCX_DSQ_GLOBAL);
+#ifdef CONFIG_SMP
+	BUG_ON(!alloc_cpumask_var(&idle_masks.cpu, GFP_KERNEL));
+	BUG_ON(!alloc_cpumask_var(&idle_masks.smt, GFP_KERNEL));
+#endif
+	for_each_possible_cpu(cpu) {
+		struct rq *rq = cpu_rq(cpu);
+
+		init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL);
+		INIT_LIST_HEAD(&rq->scx.runnable_list);
+	}
+}
+
+
+/********************************************************************************
+ * Helpers that can be called from the BPF scheduler.
+ */
+#include <linux/btf_ids.h>
+
+__bpf_kfunc_start_defs();
+
+/**
+ * scx_bpf_create_dsq - Create a custom DSQ
+ * @dsq_id: DSQ to create
+ * @node: NUMA node to allocate from
+ *
+ * Create a custom DSQ identified by @dsq_id. Can be called from ops.init() and
+ * ops.init_task().
+ */
+__bpf_kfunc s32 scx_bpf_create_dsq(u64 dsq_id, s32 node)
+{
+	if (!scx_kf_allowed(SCX_KF_SLEEPABLE))
+		return -EINVAL;
+
+	if (unlikely(node >= (int)nr_node_ids ||
+		     (node < 0 && node != NUMA_NO_NODE)))
+		return -EINVAL;
+	return PTR_ERR_OR_ZERO(create_dsq(dsq_id, node));
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(scx_kfunc_ids_sleepable)
+BTF_ID_FLAGS(func, scx_bpf_create_dsq, KF_SLEEPABLE)
+BTF_KFUNCS_END(scx_kfunc_ids_sleepable)
+
+static const struct btf_kfunc_id_set scx_kfunc_set_sleepable = {
+	.owner			= THIS_MODULE,
+	.set			= &scx_kfunc_ids_sleepable,
+};
+
+__bpf_kfunc_start_defs();
+
+/**
+ * scx_bpf_select_cpu_dfl - The default implementation of ops.select_cpu()
+ * @p: task_struct to select a CPU for
+ * @prev_cpu: CPU @p was on previously
+ * @wake_flags: %SCX_WAKE_* flags
+ * @is_idle: out parameter indicating whether the returned CPU is idle
+ *
+ * Can only be called from ops.select_cpu() if the built-in CPU selection is
+ * enabled - ops.update_idle() is missing or %SCX_OPS_KEEP_BUILTIN_IDLE is set.
+ * @p, @prev_cpu and @wake_flags match ops.select_cpu().
+ *
+ * Returns the picked CPU with *@is_idle indicating whether the picked CPU is
+ * currently idle and thus a good candidate for direct dispatching.
+ */
+__bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
+				       u64 wake_flags, bool *is_idle)
+{
+	if (!scx_kf_allowed(SCX_KF_SELECT_CPU)) {
+		*is_idle = false;
+		return prev_cpu;
+	}
+#ifdef CONFIG_SMP
+	return scx_select_cpu_dfl(p, prev_cpu, wake_flags, is_idle);
+#else
+	*is_idle = false;
+	return prev_cpu;
+#endif
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(scx_kfunc_ids_select_cpu)
+BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_RCU)
+BTF_KFUNCS_END(scx_kfunc_ids_select_cpu)
+
+static const struct btf_kfunc_id_set scx_kfunc_set_select_cpu = {
+	.owner			= THIS_MODULE,
+	.set			= &scx_kfunc_ids_select_cpu,
+};
+
+static bool scx_dispatch_preamble(struct task_struct *p, u64 enq_flags)
+{
+	if (!scx_kf_allowed(SCX_KF_ENQUEUE | SCX_KF_DISPATCH))
+		return false;
+
+	lockdep_assert_irqs_disabled();
+
+	if (unlikely(!p)) {
+		scx_ops_error("called with NULL task");
+		return false;
+	}
+
+	if (unlikely(enq_flags & __SCX_ENQ_INTERNAL_MASK)) {
+		scx_ops_error("invalid enq_flags 0x%llx", enq_flags);
+		return false;
+	}
+
+	return true;
+}
+
+static void scx_dispatch_commit(struct task_struct *p, u64 dsq_id, u64 enq_flags)
+{
+	struct task_struct *ddsp_task;
+	int idx;
+
+	ddsp_task = __this_cpu_read(direct_dispatch_task);
+	if (ddsp_task) {
+		mark_direct_dispatch(ddsp_task, p, dsq_id, enq_flags);
+		return;
+	}
+
+	idx = __this_cpu_read(scx_dsp_ctx.buf_cursor);
+	if (unlikely(idx >= scx_dsp_max_batch)) {
+		scx_ops_error("dispatch buffer overflow");
+		return;
+	}
+
+	this_cpu_ptr(scx_dsp_buf)[idx] = (struct scx_dsp_buf_ent){
+		.task = p,
+		.qseq = atomic_long_read(&p->scx.ops_state) & SCX_OPSS_QSEQ_MASK,
+		.dsq_id = dsq_id,
+		.enq_flags = enq_flags,
+	};
+	__this_cpu_inc(scx_dsp_ctx.buf_cursor);
+}
+
+__bpf_kfunc_start_defs();
+
+/**
+ * scx_bpf_dispatch - Dispatch a task into the FIFO queue of a DSQ
+ * @p: task_struct to dispatch
+ * @dsq_id: DSQ to dispatch to
+ * @slice: duration @p can run for in nsecs
+ * @enq_flags: SCX_ENQ_*
+ *
+ * Dispatch @p into the FIFO queue of the DSQ identified by @dsq_id. It is safe
+ * to call this function spuriously. Can be called from ops.enqueue(),
+ * ops.select_cpu(), and ops.dispatch().
+ *
+ * When called from ops.select_cpu() or ops.enqueue(), it's for direct dispatch
+ * and @p must match the task being enqueued. Also, %SCX_DSQ_LOCAL_ON can't be
+ * used to target the local DSQ of a CPU other than the enqueueing one. Use
+ * ops.select_cpu() to be on the target CPU in the first place.
+ *
+ * When called from ops.select_cpu(), @enq_flags and @dsp_id are stored, and @p
+ * will be directly dispatched to the corresponding dispatch queue after
+ * ops.select_cpu() returns. If @p is dispatched to SCX_DSQ_LOCAL, it will be
+ * dispatched to the local DSQ of the CPU returned by ops.select_cpu().
+ * @enq_flags are OR'd with the enqueue flags on the enqueue path before the
+ * task is dispatched.
+ *
+ * When called from ops.dispatch(), there are no restrictions on @p or @dsq_id
+ * and this function can be called upto ops.dispatch_max_batch times to dispatch
+ * multiple tasks. scx_bpf_dispatch_nr_slots() returns the number of the
+ * remaining slots. scx_bpf_consume() flushes the batch and resets the counter.
+ *
+ * This function doesn't have any locking restrictions and may be called under
+ * BPF locks (in the future when BPF introduces more flexible locking).
+ *
+ * @p is allowed to run for @slice. The scheduling path is triggered on slice
+ * exhaustion. If zero, the current residual slice is maintained.
+ */
+__bpf_kfunc void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice,
+				  u64 enq_flags)
+{
+	if (!scx_dispatch_preamble(p, enq_flags))
+		return;
+
+	if (slice)
+		p->scx.slice = slice;
+	else
+		p->scx.slice = p->scx.slice ?: 1;
+
+	scx_dispatch_commit(p, dsq_id, enq_flags);
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(scx_kfunc_ids_enqueue_dispatch)
+BTF_ID_FLAGS(func, scx_bpf_dispatch, KF_RCU)
+BTF_KFUNCS_END(scx_kfunc_ids_enqueue_dispatch)
+
+static const struct btf_kfunc_id_set scx_kfunc_set_enqueue_dispatch = {
+	.owner			= THIS_MODULE,
+	.set			= &scx_kfunc_ids_enqueue_dispatch,
+};
+
+__bpf_kfunc_start_defs();
+
+/**
+ * scx_bpf_dispatch_nr_slots - Return the number of remaining dispatch slots
+ *
+ * Can only be called from ops.dispatch().
+ */
+__bpf_kfunc u32 scx_bpf_dispatch_nr_slots(void)
+{
+	if (!scx_kf_allowed(SCX_KF_DISPATCH))
+		return 0;
+
+	return scx_dsp_max_batch - __this_cpu_read(scx_dsp_ctx.buf_cursor);
+}
+
+/**
+ * scx_bpf_dispatch_cancel - Cancel the latest dispatch
+ *
+ * Cancel the latest dispatch. Can be called multiple times to cancel further
+ * dispatches. Can only be called from ops.dispatch().
+ */
+__bpf_kfunc void scx_bpf_dispatch_cancel(void)
+{
+	struct scx_dsp_ctx *dspc = this_cpu_ptr(&scx_dsp_ctx);
+
+	if (!scx_kf_allowed(SCX_KF_DISPATCH))
+		return;
+
+	if (dspc->buf_cursor > 0)
+		dspc->buf_cursor--;
+	else
+		scx_ops_error("dispatch buffer underflow");
+}
+
+/**
+ * scx_bpf_consume - Transfer a task from a DSQ to the current CPU's local DSQ
+ * @dsq_id: DSQ to consume
+ *
+ * Consume a task from the non-local DSQ identified by @dsq_id and transfer it
+ * to the current CPU's local DSQ for execution. Can only be called from
+ * ops.dispatch().
+ *
+ * This function flushes the in-flight dispatches from scx_bpf_dispatch() before
+ * trying to consume the specified DSQ. It may also grab rq locks and thus can't
+ * be called under any BPF locks.
+ *
+ * Returns %true if a task has been consumed, %false if there isn't any task to
+ * consume.
+ */
+__bpf_kfunc bool scx_bpf_consume(u64 dsq_id)
+{
+	struct scx_dsp_ctx *dspc = this_cpu_ptr(&scx_dsp_ctx);
+	struct scx_dispatch_q *dsq;
+
+	if (!scx_kf_allowed(SCX_KF_DISPATCH))
+		return false;
+
+	flush_dispatch_buf(dspc->rq, dspc->rf);
+
+	dsq = find_non_local_dsq(dsq_id);
+	if (unlikely(!dsq)) {
+		scx_ops_error("invalid DSQ ID 0x%016llx", dsq_id);
+		return false;
+	}
+
+	if (consume_dispatch_q(dspc->rq, dspc->rf, dsq)) {
+		/*
+		 * A successfully consumed task can be dequeued before it starts
+		 * running while the CPU is trying to migrate other dispatched
+		 * tasks. Bump nr_tasks to tell balance_scx() to retry on empty
+		 * local DSQ.
+		 */
+		dspc->nr_tasks++;
+		return true;
+	} else {
+		return false;
+	}
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(scx_kfunc_ids_dispatch)
+BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_slots)
+BTF_ID_FLAGS(func, scx_bpf_dispatch_cancel)
+BTF_ID_FLAGS(func, scx_bpf_consume)
+BTF_KFUNCS_END(scx_kfunc_ids_dispatch)
+
+static const struct btf_kfunc_id_set scx_kfunc_set_dispatch = {
+	.owner			= THIS_MODULE,
+	.set			= &scx_kfunc_ids_dispatch,
+};
+
+__bpf_kfunc_start_defs();
+
+/**
+ * scx_bpf_dsq_nr_queued - Return the number of queued tasks
+ * @dsq_id: id of the DSQ
+ *
+ * Return the number of tasks in the DSQ matching @dsq_id. If not found,
+ * -%ENOENT is returned.
+ */
+__bpf_kfunc s32 scx_bpf_dsq_nr_queued(u64 dsq_id)
+{
+	struct scx_dispatch_q *dsq;
+	s32 ret;
+
+	preempt_disable();
+
+	if (dsq_id == SCX_DSQ_LOCAL) {
+		ret = READ_ONCE(this_rq()->scx.local_dsq.nr);
+		goto out;
+	} else if ((dsq_id & SCX_DSQ_LOCAL_ON) == SCX_DSQ_LOCAL_ON) {
+		s32 cpu = dsq_id & SCX_DSQ_LOCAL_CPU_MASK;
+
+		if (ops_cpu_valid(cpu, NULL)) {
+			ret = READ_ONCE(cpu_rq(cpu)->scx.local_dsq.nr);
+			goto out;
+		}
+	} else {
+		dsq = find_non_local_dsq(dsq_id);
+		if (dsq) {
+			ret = READ_ONCE(dsq->nr);
+			goto out;
+		}
+	}
+	ret = -ENOENT;
+out:
+	preempt_enable();
+	return ret;
+}
+
+/**
+ * scx_bpf_destroy_dsq - Destroy a custom DSQ
+ * @dsq_id: DSQ to destroy
+ *
+ * Destroy the custom DSQ identified by @dsq_id. Only DSQs created with
+ * scx_bpf_create_dsq() can be destroyed. The caller must ensure that the DSQ is
+ * empty and no further tasks are dispatched to it. Ignored if called on a DSQ
+ * which doesn't exist. Can be called from any online scx_ops operations.
+ */
+__bpf_kfunc void scx_bpf_destroy_dsq(u64 dsq_id)
+{
+	destroy_dsq(dsq_id);
+}
+
+__bpf_kfunc_end_defs();
+
+struct scx_bpf_error_bstr_bufs {
+	u64			data[MAX_BPRINTF_VARARGS];
+	char			msg[SCX_EXIT_MSG_LEN];
+};
+
+static DEFINE_PER_CPU(struct scx_bpf_error_bstr_bufs, scx_bpf_error_bstr_bufs);
+
+static void bpf_exit_bstr_common(enum scx_exit_kind kind, s64 exit_code,
+				 char *fmt, unsigned long long *data,
+				 u32 data__sz)
+{
+	struct bpf_bprintf_data bprintf_data = { .get_bin_args = true };
+	struct scx_bpf_error_bstr_bufs *bufs;
+	unsigned long flags;
+	int ret;
+
+	local_irq_save(flags);
+	bufs = this_cpu_ptr(&scx_bpf_error_bstr_bufs);
+
+	if (data__sz % 8 || data__sz > MAX_BPRINTF_VARARGS * 8 ||
+	    (data__sz && !data)) {
+		scx_ops_error("invalid data=%p and data__sz=%u",
+			      (void *)data, data__sz);
+		goto out_restore;
+	}
+
+	ret = copy_from_kernel_nofault(bufs->data, data, data__sz);
+	if (ret) {
+		scx_ops_error("failed to read data fields (%d)", ret);
+		goto out_restore;
+	}
+
+	ret = bpf_bprintf_prepare(fmt, UINT_MAX, bufs->data, data__sz / 8,
+				  &bprintf_data);
+	if (ret < 0) {
+		scx_ops_error("failed to format prepration (%d)", ret);
+		goto out_restore;
+	}
+
+	ret = bstr_printf(bufs->msg, sizeof(bufs->msg), fmt,
+			  bprintf_data.bin_args);
+	bpf_bprintf_cleanup(&bprintf_data);
+	if (ret < 0) {
+		scx_ops_error("scx_ops_error(\"%s\", %p, %u) failed to format",
+			      fmt, data, data__sz);
+		goto out_restore;
+	}
+
+	scx_ops_exit_kind(kind, exit_code, "%s", bufs->msg);
+out_restore:
+	local_irq_restore(flags);
+
+}
+
+__bpf_kfunc_start_defs();
+
+/**
+ * scx_bpf_exit_bstr - Gracefully exit the BPF scheduler.
+ * @exit_code: Exit value to pass to user space via struct scx_exit_info.
+ * @fmt: error message format string
+ * @data: format string parameters packaged using ___bpf_fill() macro
+ * @data__sz: @data len, must end in '__sz' for the verifier
+ *
+ * Indicate that the BPF scheduler wants to exit gracefully, and initiate ops
+ * disabling.
+ */
+__bpf_kfunc void scx_bpf_exit_bstr(s64 exit_code, char *fmt,
+				   unsigned long long *data, u32 data__sz)
+{
+	bpf_exit_bstr_common(SCX_EXIT_UNREG_BPF, exit_code, fmt, data,
+			     data__sz);
+}
+
+/**
+ * scx_bpf_error_bstr - Indicate fatal error
+ * @fmt: error message format string
+ * @data: format string parameters packaged using ___bpf_fill() macro
+ * @data__sz: @data len, must end in '__sz' for the verifier
+ *
+ * Indicate that the BPF scheduler encountered a fatal error and initiate ops
+ * disabling.
+ */
+__bpf_kfunc void scx_bpf_error_bstr(char *fmt, unsigned long long *data,
+				    u32 data__sz)
+{
+
+	bpf_exit_bstr_common(SCX_EXIT_ERROR_BPF, 0, fmt, data,
+			     data__sz);
+}
+
+/**
+ * scx_bpf_nr_cpu_ids - Return the number of possible CPU IDs
+ *
+ * All valid CPU IDs in the system are smaller than the returned value.
+ */
+__bpf_kfunc u32 scx_bpf_nr_cpu_ids(void)
+{
+	return nr_cpu_ids;
+}
+
+/**
+ * scx_bpf_get_possible_cpumask - Get a referenced kptr to cpu_possible_mask
+ */
+__bpf_kfunc const struct cpumask *scx_bpf_get_possible_cpumask(void)
+{
+	return cpu_possible_mask;
+}
+
+/**
+ * scx_bpf_get_online_cpumask - Get a referenced kptr to cpu_online_mask
+ */
+__bpf_kfunc const struct cpumask *scx_bpf_get_online_cpumask(void)
+{
+	return cpu_online_mask;
+}
+
+/**
+ * scx_bpf_put_cpumask - Release a possible/online cpumask
+ * @cpumask: cpumask to release
+ */
+__bpf_kfunc void scx_bpf_put_cpumask(const struct cpumask *cpumask)
+{
+	/*
+	 * Empty function body because we aren't actually acquiring or releasing
+	 * a reference to a global cpumask, which is read-only in the caller and
+	 * is never released. The acquire / release semantics here are just used
+	 * to make the cpumask is a trusted pointer in the caller.
+	 */
+}
+
+/**
+ * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
+ * per-CPU cpumask.
+ *
+ * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
+ */
+__bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
+{
+	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
+		scx_ops_error("built-in idle tracking is disabled");
+		return cpu_none_mask;
+	}
+
+#ifdef CONFIG_SMP
+	return idle_masks.cpu;
+#else
+	return cpu_none_mask;
+#endif
+}
+
+/**
+ * scx_bpf_get_idle_smtmask - Get a referenced kptr to the idle-tracking,
+ * per-physical-core cpumask. Can be used to determine if an entire physical
+ * core is free.
+ *
+ * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
+ */
+__bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask(void)
+{
+	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
+		scx_ops_error("built-in idle tracking is disabled");
+		return cpu_none_mask;
+	}
+
+#ifdef CONFIG_SMP
+	if (sched_smt_active())
+		return idle_masks.smt;
+	else
+		return idle_masks.cpu;
+#else
+	return cpu_none_mask;
+#endif
+}
+
+/**
+ * scx_bpf_put_idle_cpumask - Release a previously acquired referenced kptr to
+ * either the percpu, or SMT idle-tracking cpumask.
+ */
+__bpf_kfunc void scx_bpf_put_idle_cpumask(const struct cpumask *idle_mask)
+{
+	/*
+	 * Empty function body because we aren't actually acquiring or releasing
+	 * a reference to a global idle cpumask, which is read-only in the
+	 * caller and is never released. The acquire / release semantics here
+	 * are just used to make the cpumask a trusted pointer in the caller.
+	 */
+}
+
+/**
+ * scx_bpf_test_and_clear_cpu_idle - Test and clear @cpu's idle state
+ * @cpu: cpu to test and clear idle for
+ *
+ * Returns %true if @cpu was idle and its idle state was successfully cleared.
+ * %false otherwise.
+ *
+ * Unavailable if ops.update_idle() is implemented and
+ * %SCX_OPS_KEEP_BUILTIN_IDLE is not set.
+ */
+__bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
+{
+	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
+		scx_ops_error("built-in idle tracking is disabled");
+		return false;
+	}
+
+	if (ops_cpu_valid(cpu, NULL))
+		return test_and_clear_cpu_idle(cpu);
+	else
+		return false;
+}
+
+/**
+ * scx_bpf_pick_idle_cpu - Pick and claim an idle cpu
+ * @cpus_allowed: Allowed cpumask
+ * @flags: %SCX_PICK_IDLE_CPU_* flags
+ *
+ * Pick and claim an idle cpu in @cpus_allowed. Returns the picked idle cpu
+ * number on success. -%EBUSY if no matching cpu was found.
+ *
+ * Idle CPU tracking may race against CPU scheduling state transitions. For
+ * example, this function may return -%EBUSY as CPUs are transitioning into the
+ * idle state. If the caller then assumes that there will be dispatch events on
+ * the CPUs as they were all busy, the scheduler may end up stalling with CPUs
+ * idling while there are pending tasks. Use scx_bpf_pick_any_cpu() and
+ * scx_bpf_kick_cpu() to guarantee that there will be at least one dispatch
+ * event in the near future.
+ *
+ * Unavailable if ops.update_idle() is implemented and
+ * %SCX_OPS_KEEP_BUILTIN_IDLE is not set.
+ */
+__bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
+				      u64 flags)
+{
+	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
+		scx_ops_error("built-in idle tracking is disabled");
+		return -EBUSY;
+	}
+
+	return scx_pick_idle_cpu(cpus_allowed, flags);
+}
+
+/**
+ * scx_bpf_pick_any_cpu - Pick and claim an idle cpu if available or pick any CPU
+ * @cpus_allowed: Allowed cpumask
+ * @flags: %SCX_PICK_IDLE_CPU_* flags
+ *
+ * Pick and claim an idle cpu in @cpus_allowed. If none is available, pick any
+ * CPU in @cpus_allowed. Guaranteed to succeed and returns the picked idle cpu
+ * number if @cpus_allowed is not empty. -%EBUSY is returned if @cpus_allowed is
+ * empty.
+ *
+ * If ops.update_idle() is implemented and %SCX_OPS_KEEP_BUILTIN_IDLE is not
+ * set, this function can't tell which CPUs are idle and will always pick any
+ * CPU.
+ */
+__bpf_kfunc s32 scx_bpf_pick_any_cpu(const struct cpumask *cpus_allowed,
+				     u64 flags)
+{
+	s32 cpu;
+
+	if (static_branch_likely(&scx_builtin_idle_enabled)) {
+		cpu = scx_pick_idle_cpu(cpus_allowed, flags);
+		if (cpu >= 0)
+			return cpu;
+	}
+
+	cpu = cpumask_any_distribute(cpus_allowed);
+	if (cpu < nr_cpu_ids)
+		return cpu;
+	else
+		return -EBUSY;
+}
+
+/**
+ * scx_bpf_task_running - Is task currently running?
+ * @p: task of interest
+ */
+__bpf_kfunc bool scx_bpf_task_running(const struct task_struct *p)
+{
+	return task_rq(p)->curr == p;
+}
+
+/**
+ * scx_bpf_task_cpu - CPU a task is currently associated with
+ * @p: task of interest
+ */
+__bpf_kfunc s32 scx_bpf_task_cpu(const struct task_struct *p)
+{
+	return task_cpu(p);
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(scx_kfunc_ids_any)
+BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
+BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
+BTF_ID_FLAGS(func, scx_bpf_exit_bstr, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_error_bstr, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_nr_cpu_ids)
+BTF_ID_FLAGS(func, scx_bpf_get_possible_cpumask, KF_ACQUIRE)
+BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask, KF_ACQUIRE)
+BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask, KF_ACQUIRE)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask, KF_ACQUIRE)
+BTF_ID_FLAGS(func, scx_bpf_put_idle_cpumask, KF_RELEASE)
+BTF_ID_FLAGS(func, scx_bpf_test_and_clear_cpu_idle)
+BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
+BTF_KFUNCS_END(scx_kfunc_ids_any)
+
+static const struct btf_kfunc_id_set scx_kfunc_set_any = {
+	.owner			= THIS_MODULE,
+	.set			= &scx_kfunc_ids_any,
+};
+
+static int __init scx_init(void)
+{
+	int ret;
+
+	/*
+	 * kfunc registration can't be done from init_sched_ext_class() as
+	 * register_btf_kfunc_id_set() needs most of the system to be up.
+	 *
+	 * Some kfuncs are context-sensitive and can only be called from
+	 * specific SCX ops. They are grouped into BTF sets accordingly.
+	 * Unfortunately, BPF currently doesn't have a way of enforcing such
+	 * restrictions. Eventually, the verifier should be able to enforce
+	 * them. For now, register them the same and make each kfunc explicitly
+	 * check using scx_kf_allowed().
+	 */
+	if ((ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					     &scx_kfunc_set_sleepable)) ||
+	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					     &scx_kfunc_set_select_cpu)) ||
+	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					     &scx_kfunc_set_enqueue_dispatch)) ||
+	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					     &scx_kfunc_set_dispatch)) ||
+	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					     &scx_kfunc_set_any)) ||
+	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
+					     &scx_kfunc_set_any)) ||
+	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
+					     &scx_kfunc_set_any))) {
+		pr_err("sched_ext: Failed to register kfunc sets (%d)\n", ret);
+		return ret;
+	}
+
+	ret = register_bpf_struct_ops(&bpf_sched_ext_ops, sched_ext_ops);
+	if (ret) {
+		pr_err("sched_ext: Failed to register struct_ops (%d)\n", ret);
+		return ret;
+	}
+
+	scx_kset = kset_create_and_add("sched_ext", &scx_uevent_ops, kernel_kobj);
+	if (!scx_kset) {
+		pr_err("sched_ext: Failed to create /sys/kernel/sched_ext\n");
+		return -ENOMEM;
+	}
+
+	ret = sysfs_create_group(&scx_kset->kobj, &scx_global_attr_group);
+	if (ret < 0) {
+		pr_err("sched_ext: Failed to add global attributes\n");
+		return ret;
+	}
+
+	return 0;
+}
+__initcall(scx_init);
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 42bd1e47b304..328abf5445b1 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -1,15 +1,85 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-
+/*
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
 #ifdef CONFIG_SCHED_CLASS_EXT
-#error "NOT IMPLEMENTED YET"
+
+struct sched_enq_and_set_ctx {
+	struct task_struct	*p;
+	int			queue_flags;
+	bool			queued;
+	bool			running;
+};
+
+void sched_deq_and_put_task(struct task_struct *p, int queue_flags,
+			    struct sched_enq_and_set_ctx *ctx);
+void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx);
+
+extern const struct sched_class ext_sched_class;
+
+DECLARE_STATIC_KEY_FALSE(__scx_ops_enabled);
+DECLARE_STATIC_KEY_FALSE(__scx_switched_all);
+#define scx_enabled()		static_branch_unlikely(&__scx_ops_enabled)
+#define scx_switched_all()	static_branch_unlikely(&__scx_switched_all)
+
+static inline bool task_on_scx(const struct task_struct *p)
+{
+	return scx_enabled() && p->sched_class == &ext_sched_class;
+}
+
+void init_scx_entity(struct sched_ext_entity *scx);
+void scx_pre_fork(struct task_struct *p);
+int scx_fork(struct task_struct *p);
+void scx_post_fork(struct task_struct *p);
+void scx_cancel_fork(struct task_struct *p);
+bool task_should_scx(struct task_struct *p);
+void init_sched_ext_class(void);
+
+static inline u32 scx_cpuperf_target(s32 cpu)
+{
+	/* for now, peg cpus at max performance while enabled */
+	if (scx_enabled())
+		return SCHED_CAPACITY_SCALE;
+	else
+		return 0;
+}
+
+static inline const struct sched_class *next_active_class(const struct sched_class *class)
+{
+	class++;
+	if (scx_switched_all() && class == &fair_sched_class)
+		class++;
+	if (!scx_enabled() && class == &ext_sched_class)
+		class++;
+	return class;
+}
+
+#define for_active_class_range(class, _from, _to)				\
+	for (class = (_from); class != (_to); class = next_active_class(class))
+
+#define for_each_active_class(class)						\
+	for_active_class_range(class, __sched_class_highest, __sched_class_lowest)
+
+/*
+ * SCX requires a balance() call before every pick_next_task() call including
+ * when waking up from idle.
+ */
+#define for_balance_class_range(class, prev_class, end_class)			\
+	for_active_class_range(class, (prev_class) > &ext_sched_class ?		\
+			       &ext_sched_class : (prev_class), (end_class))
+
 #else	/* CONFIG_SCHED_CLASS_EXT */
 
 #define scx_enabled()		false
+#define scx_switched_all()	false
 
 static inline void scx_pre_fork(struct task_struct *p) {}
 static inline int scx_fork(struct task_struct *p) { return 0; }
 static inline void scx_post_fork(struct task_struct *p) {}
 static inline void scx_cancel_fork(struct task_struct *p) {}
+static inline bool task_on_scx(const struct task_struct *p) { return false; }
 static inline void init_sched_ext_class(void) {}
 static inline u32 scx_cpuperf_target(s32 cpu) { return 0; }
 
@@ -19,7 +89,13 @@ static inline u32 scx_cpuperf_target(s32 cpu) { return 0; }
 #endif	/* CONFIG_SCHED_CLASS_EXT */
 
 #if defined(CONFIG_SCHED_CLASS_EXT) && defined(CONFIG_SMP)
-#error "NOT IMPLEMENTED YET"
+void __scx_update_idle(struct rq *rq, bool idle);
+
+static inline void scx_update_idle(struct rq *rq, bool idle)
+{
+	if (scx_enabled())
+		__scx_update_idle(rq, idle);
+}
 #else
 static inline void scx_update_idle(struct rq *rq, bool idle) {}
 #endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index fbd1e9ea8b18..4a55a31250ab 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -174,6 +174,10 @@ static inline int idle_policy(int policy)
 
 static inline int normal_policy(int policy)
 {
+#ifdef CONFIG_SCHED_CLASS_EXT
+	if (policy == SCHED_EXT)
+		return true;
+#endif
 	return policy == SCHED_NORMAL;
 }
 
@@ -704,6 +708,16 @@ struct cfs_rq {
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 };
 
+#ifdef CONFIG_SCHED_CLASS_EXT
+struct scx_rq {
+	struct scx_dispatch_q	local_dsq;
+	struct list_head	runnable_list;		/* runnable tasks on this rq */
+	unsigned long		ops_qseq;
+	u64			extra_enq_flags;	/* see move_task_to_local_dsq() */
+	u32			nr_running;
+};
+#endif /* CONFIG_SCHED_CLASS_EXT */
+
 static inline int rt_bandwidth_enabled(void)
 {
 	return sysctl_sched_rt_runtime >= 0;
@@ -1044,6 +1058,9 @@ struct rq {
 	struct cfs_rq		cfs;
 	struct rt_rq		rt;
 	struct dl_rq		dl;
+#ifdef CONFIG_SCHED_CLASS_EXT
+	struct scx_rq		scx;
+#endif
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* list of leaf cfs_rq on this CPU: */
-- 
2.44.0


