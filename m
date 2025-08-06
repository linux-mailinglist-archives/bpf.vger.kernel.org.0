Return-Path: <bpf+bounces-65103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FDCB1C25A
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 10:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8868C3BF97D
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 08:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5055288CBE;
	Wed,  6 Aug 2025 08:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlrfdGG1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BB61F5846;
	Wed,  6 Aug 2025 08:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754469874; cv=none; b=TzZKIC0YcDyAAKcDLnzcK0Deo66/UmjCaZa+OcfjJgM/r5rSlxDvxDgo7BClUZ892WmoKZJuG6ja/4Z/BaYc51fT/x6pszvHnKMGEToHHPfbZCznL25gxlrtZYANfakdKM8x9hjsnuTG6nFG+RLzr5SzOqlloKyaP0GxVIdttd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754469874; c=relaxed/simple;
	bh=z0nYp2ynv+46q5YCYRH6FXCchkPPDlyJqmIHrSGtAHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MFRd5Sufb1y6jWUddBP5eGADI/zycMrPiK3BW/muVTyxmo7YP0eWLqoqiQVAQ9greeMAMPBLRfFqz+MRZp+9s36do/qeEvth6LYThWzSBM5yKy36uJli/dmpi6qbYmtTqj4Jd1eYk0ai6ffom48m26fq4G3vbKk16Df7lXZMEzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlrfdGG1; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-71a3f7f0addso61128657b3.2;
        Wed, 06 Aug 2025 01:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754469871; x=1755074671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFpqh2chXhDlExohuSG9ndPKdKo15kCv0QZEVsMWgrM=;
        b=SlrfdGG1WbUKIR0od8rxx006kg7JzJ1AMBvBuf/h7GfBozeMC9RvngO07OAEyIUD9Y
         uZjnRawoho3JERDt2uhWV9A8YnnwSIAPaWPGLdK3AK9il4Aajqsse3CFJuMnaVDBYMvp
         vY4OCJYS4TnxrVl4HYhjgF8LPU70e8Zp93f/m/jiJCPqKzJ/XU/vY9cRYlPL5kZml1Nm
         0IagHvtRMhzJHddRSsO7Yq9JrIhzRXAHicXn9u7gRwYMVlwKuuzhnYVIPR4ZxhKZcQL+
         +V5ihKW8ZRhBPxj0J6gkOl8EnoAD7ObnkM0w7TCsWmXEuicfVjAaOF3vozhJOMhbpmvT
         VO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754469871; x=1755074671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFpqh2chXhDlExohuSG9ndPKdKo15kCv0QZEVsMWgrM=;
        b=eNNQHnza0fc//DDZpFkCqVK8oysqOP4WM2aFelE6cUjAnicjya5+Q0xex41FpDbY0D
         LrKrQtpKBtVtDFmhYpEXuZ5VSu9WFIQI6tNRF1RjqF17ELuCZgP+6LBhTfqtaXUC7951
         ufANupByd2jYfGA3824/UGnc8A+6zBn7eg1I2iQT/sbEMHbAuxdZxmju2M2dT0A1XgYK
         QaD5R3NWvEz2PpI8By+QquViUEciTrCiKZHkXUeAw73FbSoSrP1hXGUsMoBaFmsDFMMR
         jyrb0bj5qQwUDS3wrqvlGR8Uy07IkbAX/Hw5Nx7wsDqbWet9oWeA/xBQggU8+9z0PqW5
         LScg==
X-Forwarded-Encrypted: i=1; AJvYcCUihMto2pym7+U+4DF6cM9ZcoRCz+HLtL8iHh+qVYIccVkQ02Y+zKwNNljKIXyfsbd56OlSLN/7j41jzlvQ@vger.kernel.org, AJvYcCVUK3FvFqHb3TOLspi97pz0QXnny0wZs5ERsXqx3WOpthwlrIenimEbL0iw56fYDoqblqM=@vger.kernel.org, AJvYcCXAsuHAVVT0Vt1O6AJCzJ/kfoqBNPt2tDHhxLXI2+SVcVekojeGg6yg7mQWSGfUz/kU9eVa/v95@vger.kernel.org
X-Gm-Message-State: AOJu0YwDhEgR4uMF1ROf+tijA/fBUUQhP74dHD7GLAvJ/miHCa48/2oy
	0AMYeGcPVm0ez9QVAu8xxDF3ZAI7I6G7oMK5mCOKPhnByFd4m1WKZ7eCGdHRxGq/QX75Wednbv5
	9a6auz8QCfXzZHFyLR+Sn0/l0knXmwrs=
X-Gm-Gg: ASbGnctF6Uis1CT1QBXs0VctvNhCPOWHhOHnaiqVHEwdOYZHGohZfhhEsiqa3QedB4P
	YlxKZzsnNN1DAC7pvMK9Jm5QdZmNtCY5QK/sld4a8/geNUAXQ4kV6IAIOcNC2GO8PiqYSJrw5aG
	Uz25SLEOLU7kES3z2OXHWeqr0KneQnu2MblHLSL8vB/RKT+plvalh3t3+I1dHzuMyiB/XIvnymz
	eVpiVM=
X-Google-Smtp-Source: AGHT+IGgR6GhwXLvgOF2yVJwvOE/E4NCzM2m5yQKgCurVKrmC5bYVw4s3ZKrxb4ts8ouaYRD8dgM1qhujT48oEYAOLk=
X-Received: by 2002:a05:690c:62c9:b0:71b:7043:21af with SMTP id
 00721157ae682-71bc991ce10mr24872517b3.42.1754469870490; Wed, 06 Aug 2025
 01:44:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-3-dongml2@chinatelecom.cn> <CAADnVQKP1-gdmq1xkogFeRM6o3j2zf0Q8Atz=aCEkB0PkVx++A@mail.gmail.com>
 <45f4d349-7b08-45d3-9bec-3ab75217f9b6@linux.dev> <3bccb986-bea1-4df0-a4fe-1e668498d5d5@linux.dev>
 <CAADnVQ+Afov4E=9t=3M=zZmO9z4ZqT6imWD5xijDHshTf3J=RA@mail.gmail.com>
 <20250716182414.GI4105545@noisy.programming.kicks-ass.net>
 <CAADnVQ+5sEDKHdsJY5ZsfGDO_1SEhhQWHrt2SMBG5SYyQ+jt7w@mail.gmail.com>
 <CADxym3Za-zShEUyoVE7OoODKYXc1nghD63q2xv_wtHAyT2-Z-Q@mail.gmail.com> <CAADnVQ+XGYp=ORtA730u7WQKqSGGH6R4=9CtYOPP_uHuJrYAkQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+XGYp=ORtA730u7WQKqSGGH6R4=9CtYOPP_uHuJrYAkQ@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 6 Aug 2025 16:44:19 +0800
X-Gm-Features: Ac12FXz1Sp5dol1iJOqCEx-nm5gYH-njhT7BiiRh8qcZST6usRSRk82M9Lp_Tzk
Message-ID: <CADxym3YMaz8_YkOidJVbKYAXiFLKp4KvYopR3rJRYkiYJvenWw@mail.gmail.com>
Subject: Re: Inlining migrate_disable/enable. Was: [PATCH bpf-next v2 02/18]
 x86,bpf: add bpf_global_caller for global trampoline
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Menglong Dong <menglong.dong@linux.dev>, 
	Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 12:15=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jul 28, 2025 at 2:20=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > On Thu, Jul 17, 2025 at 6:35=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Jul 16, 2025 at 11:24=E2=80=AFAM Peter Zijlstra <peterz@infra=
dead.org> wrote:
> > > >
> > > > On Wed, Jul 16, 2025 at 09:56:11AM -0700, Alexei Starovoitov wrote:
> > > >
> > > > > Maybe Peter has better ideas ?
> > > >
> > > > Is it possible to express runqueues::nr_pinned as an alias?
> > > >
> > > > extern unsigned int __attribute__((alias("runqueues.nr_pinned"))) t=
his_nr_pinned;
> > > >
> > > > And use:
> > > >
> > > >         __this_cpu_inc(&this_nr_pinned);
> > > >
> > > >
> > > > This syntax doesn't actually seem to work; but can we construct
> > > > something like that?
> > >
> > > Yeah. Iant is right. It's a string and not a pointer dereference.
> > > It never worked.
> > >
> > > Few options:
> > >
> > > 1.
> > >  struct rq {
> > > +#ifdef CONFIG_SMP
> > > +       unsigned int            nr_pinned;
> > > +#endif
> > >         /* runqueue lock: */
> > >         raw_spinlock_t          __lock;
> > >
> > > @@ -1271,9 +1274,6 @@ struct rq {
> > >         struct cpuidle_state    *idle_state;
> > >  #endif
> > >
> > > -#ifdef CONFIG_SMP
> > > -       unsigned int            nr_pinned;
> > > -#endif
> > >
> > > but ugly...
> > >
> > > 2.
> > > static unsigned int nr_pinned_offset __ro_after_init __used;
> > > RUNTIME_CONST(nr_pinned_offset, nr_pinned_offset)
> > >
> > > overkill for what's needed
> > >
> > > 3.
> > > OFFSET(RQ_nr_pinned, rq, nr_pinned);
> > > then
> > > #include <generated/asm-offsets.h>
> > >
> > > imo the best.
> >
> > I had a try. The struct rq is not visible to asm-offsets.c, so we
> > can't define it in arch/xx/kernel/asm-offsets.c. Do you mean
> > to define a similar rq-offsets.c in kernel/sched/ ? It will be more
> > complex than the way 2, and I think the second way 2 is
> > easier :/
>
> 2 maybe easier, but it's an overkill.
> I still think asm-offset is cleaner.
> arch/xx shouldn't be used, of course, since this nr_pinned should
> be generic for all archs.
> We can do something similar to drivers/memory/emif-asm-offsets.c
> and do that within kernel/sched/.
> rq-offsets.c as you said.
> It will generate rq-offsets.h in a build dir that can be #include-d.
>
> I thought about another alternative (as a derivative of 1):
> split nr_pinned from 'struct rq' into its own per-cpu variable,
> but I don't think that will work, since rq_has_pinned_tasks()
> doesn't always operate on this_rq().
> So the acceptable choices are realistically 1 and 3 and
> rq-offsets.c seems cleaner.
> Pls give it another try.

Generally speaking, the way 3 works. The only problem is how
we handle this_rq(). I introduced following code in
include/linux/sched.h:

struct rq;
DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
#define this_rq_ptr() arch_raw_cpu_ptr(&runqueues)

The this_rq_ptr() is used in migrate_enable(). I have to use the
arch_raw_cpu_ptr() for it. this_cpu_ptr() can't be used here, as
it will fail on this_cpu_ptr -> raw_cpu_ptr -> __verify_pcpu_ptr:

#define __verify_pcpu_ptr(ptr)                        \
do {                                    \
    const void __percpu *__vpp_verify =3D (typeof((ptr) + 0))NULL;    \
    (void)__vpp_verify;                        \
} while (0)

The struct rq is not available here, which makes the typeof((ptr) + 0)
fail during compiling. What can we do here?

According to my testing, the performance of fentry increased from
111M/s to 121M/s with migrate_enable/disable inlined.

Following is the whole patch:
---------------------------------------------------------------------------=
----------------
diff --git a/Kbuild b/Kbuild
index f327ca86990c..13324b4bbe23 100644
--- a/Kbuild
+++ b/Kbuild
@@ -34,13 +34,24 @@ arch/$(SRCARCH)/kernel/asm-offsets.s:
$(timeconst-file) $(bounds-file)
 $(offsets-file): arch/$(SRCARCH)/kernel/asm-offsets.s FORCE
     $(call filechk,offsets,__ASM_OFFSETS_H__)

+# Generate rq-offsets.h
+
+rq-offsets-file :=3D include/generated/rq-offsets.h
+
+targets +=3D kernel/sched/rq-offsets.s
+
+kernel/sched/rq-offsets.s: $(offsets-file)
+
+$(rq-offsets-file): kernel/sched/rq-offsets.s FORCE
+    $(call filechk,offsets,__RQ_OFFSETS_H__)
+
 # Check for missing system calls

 quiet_cmd_syscalls =3D CALL    $<
       cmd_syscalls =3D $(CONFIG_SHELL) $< $(CC) $(c_flags)
$(missing_syscalls_flags)

 PHONY +=3D missing-syscalls
-missing-syscalls: scripts/checksyscalls.sh $(offsets-file)
+missing-syscalls: scripts/checksyscalls.sh $(rq-offsets-file)
     $(call cmd,syscalls)

 # Check the manual modification of atomic headers
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 1fad1c8a4c76..3a1c08a75c09 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -369,64 +369,6 @@ static inline void preempt_notifier_init(struct
preempt_notifier *notifier,

 #endif

-/*
- * Migrate-Disable and why it is undesired.
- *
- * When a preempted task becomes elegible to run under the ideal model (IO=
W it
- * becomes one of the M highest priority tasks), it might still have to wa=
it
- * for the preemptee's migrate_disable() section to complete. Thereby suff=
ering
- * a reduction in bandwidth in the exact duration of the migrate_disable()
- * section.
- *
- * Per this argument, the change from preempt_disable() to migrate_disable=
()
- * gets us:
- *
- * - a higher priority tasks gains reduced wake-up latency; with
preempt_disable()
- *   it would have had to wait for the lower priority task.
- *
- * - a lower priority tasks; which under preempt_disable() could've instan=
tly
- *   migrated away when another CPU becomes available, is now constrained
- *   by the ability to push the higher priority task away, which
might itself be
- *   in a migrate_disable() section, reducing it's available bandwidth.
- *
- * IOW it trades latency / moves the interference term, but it stays in th=
e
- * system, and as long as it remains unbounded, the system is not fully
- * deterministic.
- *
- *
- * The reason we have it anyway.
- *
- * PREEMPT_RT breaks a number of assumptions traditionally held. By forcin=
g a
- * number of primitives into becoming preemptible, they would also allow
- * migration. This turns out to break a bunch of per-cpu usage. To this en=
d,
- * all these primitives employ migirate_disable() to restore this implicit
- * assumption.
- *
- * This is a 'temporary' work-around at best. The correct solution is gett=
ing
- * rid of the above assumptions and reworking the code to employ explicit
- * per-cpu locking or short preempt-disable regions.
- *
- * The end goal must be to get rid of migrate_disable(), alternatively we =
need
- * a schedulability theory that does not depend on abritrary migration.
- *
- *
- * Notes on the implementation.
- *
- * The implementation is particularly tricky since existing code patterns
- * dictate neither migrate_disable() nor migrate_enable() is allowed to bl=
ock.
- * This means that it cannot use cpus_read_lock() to serialize against hot=
plug,
- * nor can it easily migrate itself into a pending affinity mask change on
- * migrate_enable().
- *
- *
- * Note: even non-work-conserving schedulers like semi-partitioned depends=
 on
- *       migration, so migrate_disable() is not only a problem for
- *       work-conserving schedulers.
- *
- */
-extern void migrate_disable(void);
-extern void migrate_enable(void);
-
 /**
  * preempt_disable_nested - Disable preemption inside a normally
preempt disabled section
  *
@@ -471,7 +413,6 @@ static __always_inline void preempt_enable_nested(void)

 DEFINE_LOCK_GUARD_0(preempt, preempt_disable(), preempt_enable())
 DEFINE_LOCK_GUARD_0(preempt_notrace, preempt_disable_notrace(),
preempt_enable_notrace())
-DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())

 #ifdef CONFIG_PREEMPT_DYNAMIC

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 40d2fa90df42..365ac6d17504 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -48,6 +48,9 @@
 #include <linux/uidgid_types.h>
 #include <linux/tracepoint-defs.h>
 #include <asm/kmap_size.h>
+#ifndef COMPILE_OFFSETS
+#include <generated/rq-offsets.h>
+#endif

 /* task_struct member predeclarations (sorted alphabetically): */
 struct audit_context;
@@ -2299,4 +2302,127 @@ static __always_inline void
alloc_tag_restore(struct alloc_tag *tag, struct allo
 #define alloc_tag_restore(_tag, _old)        do {} while (0)
 #endif

+#if defined(CONFIG_SMP) && !defined(COMPILE_OFFSETS)
+
+extern void __migrate_enable(void);
+
+struct rq;
+DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+#define this_rq_ptr() arch_raw_cpu_ptr(&runqueues)
+
+/*
+ * Migrate-Disable and why it is undesired.
+ *
+ * When a preempted task becomes elegible to run under the ideal model (IO=
W it
+ * becomes one of the M highest priority tasks), it might still have to wa=
it
+ * for the preemptee's migrate_disable() section to complete. Thereby suff=
ering
+ * a reduction in bandwidth in the exact duration of the migrate_disable()
+ * section.
+ *
+ * Per this argument, the change from preempt_disable() to migrate_disable=
()
+ * gets us:
+ *
+ * - a higher priority tasks gains reduced wake-up latency; with
preempt_disable()
+ *   it would have had to wait for the lower priority task.
+ *
+ * - a lower priority tasks; which under preempt_disable() could've instan=
tly
+ *   migrated away when another CPU becomes available, is now constrained
+ *   by the ability to push the higher priority task away, which
might itself be
+ *   in a migrate_disable() section, reducing it's available bandwidth.
+ *
+ * IOW it trades latency / moves the interference term, but it stays in th=
e
+ * system, and as long as it remains unbounded, the system is not fully
+ * deterministic.
+ *
+ *
+ * The reason we have it anyway.
+ *
+ * PREEMPT_RT breaks a number of assumptions traditionally held. By forcin=
g a
+ * number of primitives into becoming preemptible, they would also allow
+ * migration. This turns out to break a bunch of per-cpu usage. To this en=
d,
+ * all these primitives employ migirate_disable() to restore this implicit
+ * assumption.
+ *
+ * This is a 'temporary' work-around at best. The correct solution is gett=
ing
+ * rid of the above assumptions and reworking the code to employ explicit
+ * per-cpu locking or short preempt-disable regions.
+ *
+ * The end goal must be to get rid of migrate_disable(), alternatively we =
need
+ * a schedulability theory that does not depend on abritrary migration.
+ *
+ *
+ * Notes on the implementation.
+ *
+ * The implementation is particularly tricky since existing code patterns
+ * dictate neither migrate_disable() nor migrate_enable() is allowed to bl=
ock.
+ * This means that it cannot use cpus_read_lock() to serialize against hot=
plug,
+ * nor can it easily migrate itself into a pending affinity mask change on
+ * migrate_enable().
+ *
+ *
+ * Note: even non-work-conserving schedulers like semi-partitioned depends=
 on
+ *       migration, so migrate_disable() is not only a problem for
+ *       work-conserving schedulers.
+ *
+ */
+static inline void migrate_enable(void)
+{
+    struct task_struct *p =3D current;
+
+#ifdef CONFIG_DEBUG_PREEMPT
+    /*
+     * Check both overflow from migrate_disable() and superfluous
+     * migrate_enable().
+     */
+    if (WARN_ON_ONCE((s16)p->migration_disabled <=3D 0))
+        return;
+#endif
+
+    if (p->migration_disabled > 1) {
+        p->migration_disabled--;
+        return;
+    }
+
+    /*
+     * Ensure stop_task runs either before or after this, and that
+     * __set_cpus_allowed_ptr(SCA_MIGRATE_ENABLE) doesn't schedule().
+     */
+    guard(preempt)();
+    __migrate_enable();
+    /*
+     * Mustn't clear migration_disabled() until cpus_ptr points back at th=
e
+     * regular cpus_mask, otherwise things that race (eg.
+     * select_fallback_rq) get confused.
+     */
+    barrier();
+    p->migration_disabled =3D 0;
+    (*(unsigned int *)((void *)this_rq_ptr() + RQ_nr_pinned))--;
+}
+
+static inline void migrate_disable(void)
+{
+    struct task_struct *p =3D current;
+
+    if (p->migration_disabled) {
+#ifdef CONFIG_DEBUG_PREEMPT
+        /*
+         *Warn about overflow half-way through the range.
+         */
+        WARN_ON_ONCE((s16)p->migration_disabled < 0);
+#endif
+        p->migration_disabled++;
+        return;
+    }
+
+    guard(preempt)();
+    (*(unsigned int *)((void *)this_rq_ptr() + RQ_nr_pinned))++;
+    p->migration_disabled =3D 1;
+}
+#else
+static inline void migrate_disable(void) { }
+static inline void migrate_enable(void) { }
+#endif
+
+DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
+
 #endif
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 399f03e62508..75d5f145ca60 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23853,8 +23853,7 @@ int bpf_check_attach_target(struct
bpf_verifier_log *log,
 BTF_SET_START(btf_id_deny)
 BTF_ID_UNUSED
 #ifdef CONFIG_SMP
-BTF_ID(func, migrate_disable)
-BTF_ID(func, migrate_enable)
+BTF_ID(func, __migrate_enable)
 #endif
 #if !defined CONFIG_PREEMPT_RCU && !defined CONFIG_TINY_RCU
 BTF_ID(func, rcu_read_unlock_strict)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3ec00d08d46a..b521024c99ed 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -119,6 +119,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp=
);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);

 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+EXPORT_SYMBOL_GPL(runqueues);

 #ifdef CONFIG_SCHED_PROXY_EXEC
 DEFINE_STATIC_KEY_TRUE(__sched_proxy_exec);
@@ -2375,28 +2376,7 @@ static void migrate_disable_switch(struct rq
*rq, struct task_struct *p)
     __do_set_cpus_allowed(p, &ac);
 }

-void migrate_disable(void)
-{
-    struct task_struct *p =3D current;
-
-    if (p->migration_disabled) {
-#ifdef CONFIG_DEBUG_PREEMPT
-        /*
-         *Warn about overflow half-way through the range.
-         */
-        WARN_ON_ONCE((s16)p->migration_disabled < 0);
-#endif
-        p->migration_disabled++;
-        return;
-    }
-
-    guard(preempt)();
-    this_rq()->nr_pinned++;
-    p->migration_disabled =3D 1;
-}
-EXPORT_SYMBOL_GPL(migrate_disable);
-
-void migrate_enable(void)
+void __migrate_enable(void)
 {
     struct task_struct *p =3D current;
     struct affinity_context ac =3D {
@@ -2404,37 +2384,10 @@ void migrate_enable(void)
         .flags     =3D SCA_MIGRATE_ENABLE,
     };

-#ifdef CONFIG_DEBUG_PREEMPT
-    /*
-     * Check both overflow from migrate_disable() and superfluous
-     * migrate_enable().
-     */
-    if (WARN_ON_ONCE((s16)p->migration_disabled <=3D 0))
-        return;
-#endif
-
-    if (p->migration_disabled > 1) {
-        p->migration_disabled--;
-        return;
-    }
-
-    /*
-     * Ensure stop_task runs either before or after this, and that
-     * __set_cpus_allowed_ptr(SCA_MIGRATE_ENABLE) doesn't schedule().
-     */
-    guard(preempt)();
     if (p->cpus_ptr !=3D &p->cpus_mask)
         __set_cpus_allowed_ptr(p, &ac);
-    /*
-     * Mustn't clear migration_disabled() until cpus_ptr points back at th=
e
-     * regular cpus_mask, otherwise things that race (eg.
-     * select_fallback_rq) get confused.
-     */
-    barrier();
-    p->migration_disabled =3D 0;
-    this_rq()->nr_pinned--;
 }
-EXPORT_SYMBOL_GPL(migrate_enable);
+EXPORT_SYMBOL_GPL(__migrate_enable);

 static inline bool rq_has_pinned_tasks(struct rq *rq)
 {
diff --git a/kernel/sched/rq-offsets.c b/kernel/sched/rq-offsets.c
new file mode 100644
index 000000000000..a23747bbe25b
--- /dev/null
+++ b/kernel/sched/rq-offsets.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+#define COMPILE_OFFSETS
+#include <linux/kbuild.h>
+#include <linux/types.h>
+#include "sched.h"
+
+int main(void)
+{
+    DEFINE(RQ_nr_pinned, offsetof(struct rq, nr_pinned));
+
+    return 0;
+}

