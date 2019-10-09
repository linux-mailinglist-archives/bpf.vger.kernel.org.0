Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89E34D1B42
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2019 23:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbfJIVzm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Oct 2019 17:55:42 -0400
Received: from sonic316-20.consmr.mail.bf2.yahoo.com ([74.6.130.194]:41966
        "EHLO sonic316-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731150AbfJIVzl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Oct 2019 17:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1570658137; bh=TpGxYXGcB1Ifkyd4KlbpPYc7sPABvADZm8ZQD5axyKU=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=I37HVd7u2P6v1aJOiNc0hBGcu/APgBEjZLYc6we+rKiBVisLOq5mzjbN9F5pbD+3cGOI+FyUMaV4Om/vZh3j8epGsojP95eZp+UEsenvSZWeco6uJwdLZGwrfaP5caO86+9K9Vvu98ll9Mdkiy4KBbvTlUPyxxC80FoEW2Y08P2nhJ2Kq0r2Iyy2OMLQYOLF1m2OS1My5s4MUxgNM72mXazj1IhnbekvbgzJ1XB1UMs4jPA9M1Ua/Qz4uNTPmxvSGIAETKWsZgZ4IzYrwj+SBozuoxMSBbp3n1Z8VrrSi2MqpLdzrERMiNHfRFkR/PsVgWWhs9S5SRNLXmnorydWkw==
X-YMail-OSG: ni.c1TUVM1m3x4F2i8jbywxPla.PKGsaCsvA.g8MzZvYPyNxY_n5tOMm2O4rqn3
 3wtsjx9LspqdlUiuuV7V0oEqWY8paiUdlsz7l0So7aR4r.sdjtuZFTUQ0WVUUwEwgK6qokWHStzJ
 .v6ZUx4d4PckolusD8kHrbelhDj5Q9usOZ27FKgiPjj3FsPLcTvjCTxWyA7n5TU5TzWbBaZPjkG4
 OXbH61bp6ks3RwSNiD2qA20sgJyvcfUiU3FDBTSGvr0YiEOV3VHqYhKoTnSXIaZReJ4zB32g_R41
 6hjn.GoK2tGrcLzvrvf7EaZiEI0jYeQ6fDwu.dRL4CvM8_Qx.R5ot_86itpqku3CBBFT01aatIhM
 VpDMYjfPakBhaD3ZdoramknTDJaNPMYGoFQ8Q1wGwhmhWE5y5ObuUXlv.U58KfkeWcUIgRaA9GIZ
 PxDZByRegrIs6WySbe2.j1kSjyZOOfgZS3MnTE4aTXpxzGKAQwqdhx3m40icsM94VgeEVEp3nic0
 UUAL.vA1k7pmBz3b25kbLYbfiue54umJsrRk.rN2GoJaPXA4iWxJLa2VVUm.x.0MYEH2NAVy1ge2
 N3hD71IMXXz2T8Ek7E58qJwF53LPXj6JUtM6Uk3IQTq5ewLQbxKY6tWLmrqONJ2Ixvp_XPS5E.wJ
 NzxEkQehgdpJcE23IIfMD2XZEcDdHGezXiJzOlnVUHqjwK_yMGHfoLiyjs2bjG1VgzfTTQmIm245
 suD.MwdoMG7m9YssalFwCfxcA6zl5p3U4lsC6Ov_RNujWxNAaebU80.3C6Lu8V5M.BipgWt0HCAo
 OPD5gzls7O8NymomN9nB.Ik1wptH__SWaYm5ojHue4LA1sSAEqjUMcoojN_1mzFJ3p_fvtbjoCnz
 DjRvPA4atE7HV37Bv.LSQFw42065N8lPon9nJH9pVyssNduuJXLatv.Gm6z9J_hF5w_RvGWgCBtW
 Sfu2aBbhl.2oOiArZY_YajznXqTe2EZ2lWbHcRW9_zbpQQrdsAhEIHF_5ijqsUi4vUzx.rEQ3LHz
 0JPCxqKbNPFJwzmrRVO.k6iWCDyMn8rdRxYJCJNeJxZo9qnVUinX3bNGKB7GHooHU3gjUF5taP34
 crON1mhJz7Y3CqEtDNnVQaHsg61ckrqd2SMUarB3PyVaUQARBodNj0IuYJZnOn0D.lIEGIdArKIL
 jj.2_3psdB.qtFKbPXZmm87YiQ159h43EEmemva.RLLeGodp3pxzjKkjUfwZ4tQfFW8wWIbRhg0F
 wK0WsUkwQnmSfNW.mLiURQ7XjXHpwgBxv0KULVKGL2TpzSobyeHyAq8ooheDyU9HmS961ms2TgAM
 Eus2Fh2nNWO3ROnCZNX1qPNBTG96VUHKsSeFmpA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Wed, 9 Oct 2019 21:55:36 +0000
Received: by smtp427.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID db80fb5743c02f6399c338dc0392b7da;
          Wed, 09 Oct 2019 21:55:35 +0000 (UTC)
Subject: Re: [PATCH RFC] perf_event: Add support for LSM and SELinux checks
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, rostedt@goodmis.org,
        primiano@google.com, rsavitski@google.com, jeffv@google.com,
        kernel-team@android.com, Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Ingo Molnar <mingo@redhat.com>,
        James Morris <jmorris@namei.org>, Jiri Olsa <jolsa@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Namhyung Kim <namhyung@kernel.org>, selinux@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Yonghong Song <yhs@fb.com>, casey@schaufler-ca.com
References: <20191009203657.6070-1-joel@joelfernandes.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <710c5bc0-deca-2649-8351-678e177214e9@schaufler-ca.com>
Date:   Wed, 9 Oct 2019 14:55:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191009203657.6070-1-joel@joelfernandes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/9/2019 1:36 PM, Joel Fernandes (Google) wrote:
> In currentl mainline, the degree of access to perf_event_open(2) system=

> call depends on the perf_event_paranoid sysctl.  This has a number of
> limitations:
>
> 1. The sysctl is only a single value. Many types of accesses are contro=
lled
>    based on the single value thus making the control very limited and
>    coarse grained.
> 2. The sysctl is global, so if the sysctl is changed, then that means
>    all processes get access to perf_event_open(2) opening the door to
>    security issues.
>
> This patch adds LSM and SELinux access checking which will be used in
> Android to access perf_event_open(2) for the purposes of attaching BPF
> programs to tracepoints, perf profiling and other operations from
> userspace. These operations are intended for production systems.
>
> 5 new LSM hooks are added:
> 1. perf_event_open: This controls access during the perf_event_open(2)
>    syscall itself. The hook is called from all the places that the
>    perf_event_paranoid sysctl is checked to keep it consistent with the=

>    systctl. The hook gets passed a 'type' argument which controls CPU,
>    kernel and tracepoint accesses (in this context, CPU, kernel and
>    tracepoint have the same semantics as the perf_event_paranoid sysctl=
).
>    Additionally, I added an 'open' type which is similar to
>    perf_event_paranoid sysctl =3D=3D 3 patch carried in Android and sev=
eral other
>    distros but was rejected in mainline [1] in 2016.
>
> 2. perf_event_alloc: This allocates a new security object for the event=

>    which stores the current SID within the event. It will be useful whe=
n
>    the perf event's FD is passed through IPC to another process which m=
ay
>    try to read the FD. Appropriate security checks will limit access.

s/which stores the current SID within the event//

While it may be true for SELinux, the data stored is up to the
security modules and may not include a SID.

Please consider making the perf_alloc security blob maintained
by the infrastructure rather than the individual modules. This
will save it having to be changed later.

> 3. perf_event_free: Called when the event is closed.
>
> 4. perf_event_read: Called from the read(2) system call path for the ev=
ent.
>
> 5. perf_event_write: Called from the read(2) system call path for the e=
vent.
>
> [1] https://lwn.net/Articles/696240/
>
> Since Peter had suggest LSM hooks in 2016 [1], I am adding his
> Suggested-by tag below.
>
> To use this patch, we set the perf_event_paranoid sysctl to -1 and then=

> apply selinux checking as appropriate (default deny everything, and the=
n
> add policy rules to give access to domains that need it). In the future=

> we can remove the perf_event_paranoid sysctl altogether.
>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: rostedt@goodmis.org
> Cc: primiano@google.com
> Cc: rsavitski@google.com
> Cc: jeffv@google.com
> Cc: kernel-team@android.com
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> ---
>  arch/x86/events/intel/bts.c         |  5 +++
>  arch/x86/events/intel/core.c        |  5 +++
>  arch/x86/events/intel/p4.c          |  5 +++
>  include/linux/lsm_hooks.h           | 15 +++++++
>  include/linux/perf_event.h          |  3 ++
>  include/linux/security.h            | 39 +++++++++++++++-
>  include/uapi/linux/perf_event.h     | 13 ++++++
>  kernel/events/core.c                | 59 +++++++++++++++++++++---
>  kernel/trace/trace_event_perf.c     | 15 ++++++-
>  security/security.c                 | 33 ++++++++++++++
>  security/selinux/hooks.c            | 69 +++++++++++++++++++++++++++++=

>  security/selinux/include/classmap.h |  2 +
>  security/selinux/include/objsec.h   |  6 ++-
>  13 files changed, 259 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
> index 5ee3fed881d3..9796fc094dad 100644
> --- a/arch/x86/events/intel/bts.c
> +++ b/arch/x86/events/intel/bts.c
> @@ -14,6 +14,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/device.h>
>  #include <linux/coredump.h>
> +#include <linux/security.h>
> =20
>  #include <linux/sizes.h>
>  #include <asm/perf_event.h>
> @@ -553,6 +554,10 @@ static int bts_event_init(struct perf_event *event=
)
>  	    !capable(CAP_SYS_ADMIN))
>  		return -EACCES;
> =20
> +	ret =3D security_perf_event_open(&event->attr, PERF_SECURITY_KERNEL);=

> +	if (ret)
> +		return ret;
> +
>  	if (x86_add_exclusive(x86_lbr_exclusive_bts))
>  		return -EBUSY;
> =20
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.=
c
> index 27ee47a7be66..75b6b9b239ae 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -11,6 +11,7 @@
>  #include <linux/stddef.h>
>  #include <linux/types.h>
>  #include <linux/init.h>
> +#include <linux/security.h>
>  #include <linux/slab.h>
>  #include <linux/export.h>
>  #include <linux/nmi.h>
> @@ -3318,6 +3319,10 @@ static int intel_pmu_hw_config(struct perf_event=
 *event)
>  	if (perf_paranoid_cpu() && !capable(CAP_SYS_ADMIN))
>  		return -EACCES;
> =20
> +	ret =3D security_perf_event_open(&event->attr, PERF_SECURITY_CPU);
> +	if (ret)
> +		return ret;
> +
>  	event->hw.config |=3D ARCH_PERFMON_EVENTSEL_ANY;
> =20
>  	return 0;
> diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
> index dee579efb2b2..6ac1a0328710 100644
> --- a/arch/x86/events/intel/p4.c
> +++ b/arch/x86/events/intel/p4.c
> @@ -8,6 +8,7 @@
>   */
> =20
>  #include <linux/perf_event.h>
> +#include <linux/security.h>
> =20
>  #include <asm/perf_event_p4.h>
>  #include <asm/hardirq.h>
> @@ -778,6 +779,10 @@ static int p4_validate_raw_event(struct perf_event=
 *event)
>  	if (p4_ht_active() && p4_event_bind_map[v].shared) {
>  		if (perf_paranoid_cpu() && !capable(CAP_SYS_ADMIN))
>  			return -EACCES;
> +
> +		v =3D security_perf_event_open(&event->attr, PERF_SECURITY_CPU);
> +		if (v)
> +			return v;
>  	}
> =20
>  	/* ESCR EventMask bits may be invalid */
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index a3763247547c..20d8cf194fb7 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1818,6 +1818,14 @@ union security_list_options {
>  	void (*bpf_prog_free_security)(struct bpf_prog_aux *aux);
>  #endif /* CONFIG_BPF_SYSCALL */
>  	int (*locked_down)(enum lockdown_reason what);
> +#ifdef CONFIG_PERF_EVENTS
> +	int (*perf_event_open)(struct perf_event_attr *attr, int type);
> +	int (*perf_event_alloc)(struct perf_event *event);
> +	void (*perf_event_free)(struct perf_event *event);
> +	int (*perf_event_read)(struct perf_event *event);
> +	int (*perf_event_write)(struct perf_event *event);
> +
> +#endif
>  };
> =20
>  struct security_hook_heads {
> @@ -2060,6 +2068,13 @@ struct security_hook_heads {
>  	struct hlist_head bpf_prog_free_security;
>  #endif /* CONFIG_BPF_SYSCALL */
>  	struct hlist_head locked_down;
> +#ifdef CONFIG_PERF_EVENTS
> +	struct hlist_head perf_event_open;
> +	struct hlist_head perf_event_alloc;
> +	struct hlist_head perf_event_free;
> +	struct hlist_head perf_event_read;
> +	struct hlist_head perf_event_write;
> +#endif
>  } __randomize_layout;
> =20
>  /*
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 61448c19a132..f074bb937800 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -721,6 +721,9 @@ struct perf_event {
>  	struct perf_cgroup		*cgrp; /* cgroup event is attach to */
>  #endif
> =20
> +#ifdef CONFIG_SECURITY
> +	void *security;
> +#endif
>  	struct list_head		sb_list;
>  #endif /* CONFIG_PERF_EVENTS */
>  };
> diff --git a/include/linux/security.h b/include/linux/security.h
> index a8d59d612d27..273e11c66ed7 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1894,5 +1894,42 @@ static inline void security_bpf_prog_free(struct=
 bpf_prog_aux *aux)
>  #endif /* CONFIG_SECURITY */
>  #endif /* CONFIG_BPF_SYSCALL */
> =20
> -#endif /* ! __LINUX_SECURITY_H */
> +#ifdef CONFIG_PERF_EVENTS
> +struct perf_event_attr;
> +
> +#ifdef CONFIG_SECURITY
> +extern int security_perf_event_open(struct perf_event_attr *attr, int =
type);
> +extern int security_perf_event_alloc(struct perf_event *event);
> +extern void security_perf_event_free(struct perf_event *event);
> +extern int security_perf_event_read(struct perf_event *event);
> +extern int security_perf_event_write(struct perf_event *event);
> +#else
> +static inline int security_perf_event_open(struct perf_event_attr *att=
r,
> +					   int type)
> +{
> +	return 0;
> +}
> =20
> +static inline int security_perf_event_alloc(struct perf_event *event)
> +{
> +	return 0;
> +}
> +
> +static inline void security_perf_event_free(struct perf_event *event)
> +{
> +	return 0;
> +}
> +
> +static inline int security_perf_event_read(struct perf_event *event)
> +{
> +	return 0;
> +}
> +
> +static inline int security_perf_event_write(struct perf_event *event)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_SECURITY */
> +#endif /* CONFIG_PERF_EVENTS */
> +
> +#endif /* ! __LINUX_SECURITY_H */
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_=
event.h
> index bb7b271397a6..5fc904c17dd8 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -427,6 +427,19 @@ struct perf_event_attr {
>  	__u16	__reserved_2;	/* align to __u64 */
>  };
> =20
> +
> +/* Access to perf_event_open(2) syscall. */
> +#define PERF_SECURITY_OPEN		0
> +
> +/* Finer grained perf_event_open(2) access control. */
> +#define PERF_SECURITY_CPU		1
> +#define PERF_SECURITY_KERNEL		2
> +#define PERF_SECURITY_TRACEPOINT	3
> +
> +/* VFS access. */
> +#define PERF_SECURITY_READ		4
> +#define PERF_SECURITY_WRITE		5
> +
>  /*
>   * Structure used by below PERF_EVENT_IOC_QUERY_BPF command
>   * to query bpf programs attached to the same perf tracepoint
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 4655adbbae10..05915af9d215 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4220,6 +4220,10 @@ find_get_context(struct pmu *pmu, struct task_st=
ruct *task,
>  		if (perf_paranoid_cpu() && !capable(CAP_SYS_ADMIN))
>  			return ERR_PTR(-EACCES);
> =20
> +		err =3D security_perf_event_open(&event->attr, PERF_SECURITY_CPU);
> +		if (err)
> +			return ERR_PTR(err);
> +
>  		cpuctx =3D per_cpu_ptr(pmu->pmu_cpu_context, cpu);
>  		ctx =3D &cpuctx->ctx;
>  		get_ctx(ctx);
> @@ -4761,6 +4765,7 @@ int perf_event_release_kernel(struct perf_event *=
event)
>  	}
> =20
>  no_ctx:
> +	security_perf_event_free(event);
>  	put_event(event); /* Must be the 'last' reference */
>  	return 0;
>  }
> @@ -4980,6 +4985,10 @@ perf_read(struct file *file, char __user *buf, s=
ize_t count, loff_t *ppos)
>  	struct perf_event_context *ctx;
>  	int ret;
> =20
> +	ret =3D security_perf_event_read(event);
> +	if (ret)
> +		return ret;
> +
>  	ctx =3D perf_event_ctx_lock(event);
>  	ret =3D __perf_read(event, buf, count);
>  	perf_event_ctx_unlock(event, ctx);
> @@ -5244,6 +5253,11 @@ static long perf_ioctl(struct file *file, unsign=
ed int cmd, unsigned long arg)
>  	struct perf_event_context *ctx;
>  	long ret;
> =20
> +	/* Treat ioctl like writes as it is likely a mutating operation. */
> +	ret =3D security_perf_event_write(event);
> +	if (ret)
> +		return ret;
> +
>  	ctx =3D perf_event_ctx_lock(event);
>  	ret =3D _perf_ioctl(event, cmd, arg);
>  	perf_event_ctx_unlock(event, ctx);
> @@ -5706,6 +5720,10 @@ static int perf_mmap(struct file *file, struct v=
m_area_struct *vma)
>  	if (!(vma->vm_flags & VM_SHARED))
>  		return -EINVAL;
> =20
> +	ret =3D security_perf_event_read(event);
> +	if (ret)
> +		return ret;
> +
>  	vma_size =3D vma->vm_end - vma->vm_start;
> =20
>  	if (vma->vm_pgoff =3D=3D 0) {
> @@ -5819,10 +5837,16 @@ static int perf_mmap(struct file *file, struct =
vm_area_struct *vma)
>  	lock_limit >>=3D PAGE_SHIFT;
>  	locked =3D atomic64_read(&vma->vm_mm->pinned_vm) + extra;
> =20
> -	if ((locked > lock_limit) && perf_paranoid_tracepoint_raw() &&
> -		!capable(CAP_IPC_LOCK)) {
> -		ret =3D -EPERM;
> -		goto unlock;
> +	if (locked > lock_limit) {
> +		if (perf_paranoid_tracepoint_raw() && !capable(CAP_IPC_LOCK)) {
> +			ret =3D -EPERM;
> +			goto unlock;
> +		}
> +
> +		ret =3D security_perf_event_open(&event->attr,
> +					       PERF_SECURITY_TRACEPOINT);
> +		if (ret)
> +			goto unlock;
>  	}
> =20
>  	WARN_ON(!rb && event->rb);
> @@ -10553,11 +10577,17 @@ perf_event_alloc(struct perf_event_attr *attr=
, int cpu,
>  		}
>  	}
> =20
> +#ifdef CONFIG_SECURITY
> +	err =3D security_perf_event_alloc(event);
> +	if (err)
> +		goto err_security;
> +#endif
>  	/* symmetric to unaccount_event() in _free_event() */
>  	account_event(event);
> =20
>  	return event;
> =20
> +err_security:
>  err_addr_filters:
>  	kfree(event->addr_filter_ranges);
> =20
> @@ -10675,9 +10705,15 @@ static int perf_copy_attr(struct perf_event_at=
tr __user *uattr,
>  			attr->branch_sample_type =3D mask;
>  		}
>  		/* privileged levels capture (kernel, hv): check permissions */
> -		if ((mask & PERF_SAMPLE_BRANCH_PERM_PLM)
> -		    && perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
> -			return -EACCES;
> +		if (mask & PERF_SAMPLE_BRANCH_PERM_PLM) {
> +			if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
> +				return -EACCES;
> +
> +			ret =3D security_perf_event_open(attr,
> +						       PERF_SECURITY_KERNEL);
> +			if (ret)
> +				return ret;
> +		}
>  	}
> =20
>  	if (attr->sample_type & PERF_SAMPLE_REGS_USER) {
> @@ -10890,6 +10926,11 @@ SYSCALL_DEFINE5(perf_event_open,
>  	if (flags & ~PERF_FLAG_ALL)
>  		return -EINVAL;
> =20
> +	/* Do we allow access to perf_event_open(2) ? */
> +	err =3D security_perf_event_open(&attr, PERF_SECURITY_OPEN);
> +	if (err)
> +		return err;
> +
>  	err =3D perf_copy_attr(attr_uptr, &attr);
>  	if (err)
>  		return err;
> @@ -10897,6 +10938,10 @@ SYSCALL_DEFINE5(perf_event_open,
>  	if (!attr.exclude_kernel) {
>  		if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
>  			return -EACCES;
> +
> +		err =3D security_perf_event_open(&attr, PERF_SECURITY_KERNEL);
> +		if (err)
> +			return err;
>  	}
> =20
>  	if (attr.namespaces) {
> diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event=
_perf.c
> index 0892e38ed6fb..7053a47ba344 100644
> --- a/kernel/trace/trace_event_perf.c
> +++ b/kernel/trace/trace_event_perf.c
> @@ -8,6 +8,7 @@
> =20
>  #include <linux/module.h>
>  #include <linux/kprobes.h>
> +#include <linux/security.h>
>  #include "trace.h"
>  #include "trace_probe.h"
> =20
> @@ -26,8 +27,10 @@ static int	total_ref_count;
>  static int perf_trace_event_perm(struct trace_event_call *tp_event,
>  				 struct perf_event *p_event)
>  {
> +	int ret;
> +
>  	if (tp_event->perf_perm) {
> -		int ret =3D tp_event->perf_perm(tp_event, p_event);
> +		ret =3D tp_event->perf_perm(tp_event, p_event);
>  		if (ret)
>  			return ret;
>  	}
> @@ -49,6 +52,11 @@ static int perf_trace_event_perm(struct trace_event_=
call *tp_event,
>  		if (perf_paranoid_tracepoint_raw() && !capable(CAP_SYS_ADMIN))
>  			return -EPERM;
> =20
> +		ret =3D security_perf_event_open(&p_event->attr,
> +					       PERF_SECURITY_TRACEPOINT);
> +		if (ret)
> +			return ret;
> +
>  		if (!is_sampling_event(p_event))
>  			return 0;
> =20
> @@ -85,6 +93,11 @@ static int perf_trace_event_perm(struct trace_event_=
call *tp_event,
>  	if (perf_paranoid_tracepoint_raw() && !capable(CAP_SYS_ADMIN))
>  		return -EPERM;
> =20
> +	ret =3D security_perf_event_open(&p_event->attr,
> +				       PERF_SECURITY_TRACEPOINT);
> +	if (ret)
> +		return ret;
> +
>  	return 0;
>  }
> =20
> diff --git a/security/security.c b/security/security.c
> index 1bc000f834e2..7639bca1db59 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2373,26 +2373,32 @@ int security_bpf(int cmd, union bpf_attr *attr,=
 unsigned int size)
>  {
>  	return call_int_hook(bpf, 0, cmd, attr, size);
>  }
> +
>  int security_bpf_map(struct bpf_map *map, fmode_t fmode)
>  {
>  	return call_int_hook(bpf_map, 0, map, fmode);
>  }
> +
>  int security_bpf_prog(struct bpf_prog *prog)
>  {
>  	return call_int_hook(bpf_prog, 0, prog);
>  }
> +
>  int security_bpf_map_alloc(struct bpf_map *map)
>  {
>  	return call_int_hook(bpf_map_alloc_security, 0, map);
>  }
> +
>  int security_bpf_prog_alloc(struct bpf_prog_aux *aux)
>  {
>  	return call_int_hook(bpf_prog_alloc_security, 0, aux);
>  }
> +
>  void security_bpf_map_free(struct bpf_map *map)
>  {
>  	call_void_hook(bpf_map_free_security, map);
>  }
> +
>  void security_bpf_prog_free(struct bpf_prog_aux *aux)
>  {
>  	call_void_hook(bpf_prog_free_security, aux);

Do clean-up of unrelated code in a separate patch.

> @@ -2404,3 +2410,30 @@ int security_locked_down(enum lockdown_reason wh=
at)
>  	return call_int_hook(locked_down, 0, what);
>  }
>  EXPORT_SYMBOL(security_locked_down);
> +
> +#ifdef CONFIG_PERF_EVENTS
> +int security_perf_event_open(struct perf_event_attr *attr, int type)
> +{
> +	return call_int_hook(perf_event_open, 0, attr, type);
> +}
> +
> +int security_perf_event_alloc(struct perf_event *event)
> +{
> +	return call_int_hook(perf_event_alloc, 0, event);
> +}
> +
> +void security_perf_event_free(struct perf_event *event)
> +{
> +	call_void_hook(perf_event_free, event);
> +}
> +
> +int security_perf_event_read(struct perf_event *event)
> +{
> +	return call_int_hook(perf_event_read, 0, event);
> +}
> +
> +int security_perf_event_write(struct perf_event *event)
> +{
> +	return call_int_hook(perf_event_write, 0, event);
> +}
> +#endif /* CONFIG_PERF_EVENTS */
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 9625b99e677f..28eb05490d59 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6795,6 +6795,67 @@ struct lsm_blob_sizes selinux_blob_sizes __lsm_r=
o_after_init =3D {
>  	.lbs_msg_msg =3D sizeof(struct msg_security_struct),
>  };
> =20
> +#ifdef CONFIG_PERF_EVENTS
> +static int selinux_perf_event_open(struct perf_event_attr *attr, int t=
ype)
> +{
> +	u32 requested, sid =3D current_sid();
> +
> +	if (type =3D=3D PERF_SECURITY_OPEN)
> +		requested =3D PERF_EVENT__OPEN;
> +	else if (type =3D=3D PERF_SECURITY_CPU)
> +		requested =3D PERF_EVENT__CPU;
> +	else if (type =3D=3D PERF_SECURITY_KERNEL)
> +		requested =3D PERF_EVENT__KERNEL;
> +	else if (type =3D=3D PERF_SECURITY_TRACEPOINT)
> +		requested =3D PERF_EVENT__TRACEPOINT;
> +	else
> +		return -EINVAL;
> +
> +	return avc_has_perm(&selinux_state, sid, sid, SECCLASS_PERF_EVENT,
> +			    requested, NULL);
> +}
> +
> +static int selinux_perf_event_alloc(struct perf_event *event)
> +{
> +	struct perf_event_security_struct *perfsec;
> +
> +	perfsec =3D kzalloc(sizeof(*perfsec), GFP_KERNEL);
> +	if (!perfsec)
> +		return -ENOMEM;
> +
> +	perfsec->sid =3D current_sid();
> +	event->security =3D perfsec;
> +
> +	return 0;
> +}
> +
> +static void selinux_perf_event_free(struct perf_event *event)
> +{
> +	struct perf_event_security_struct *perfsec =3D event->security;
> +
> +	event->security =3D NULL;
> +	kfree(perfsec);
> +}
> +
> +static int selinux_perf_event_read(struct perf_event *event)
> +{
> +	struct perf_event_security_struct *perfsec =3D event->security;
> +	u32 sid =3D current_sid();
> +
> +	return avc_has_perm(&selinux_state, sid, perfsec->sid,
> +			    SECCLASS_PERF_EVENT, PERF_EVENT__READ, NULL);
> +}
> +
> +static int selinux_perf_event_write(struct perf_event *event)
> +{
> +	struct perf_event_security_struct *perfsec =3D event->security;
> +	u32 sid =3D current_sid();
> +
> +	return avc_has_perm(&selinux_state, sid, perfsec->sid,
> +			    SECCLASS_PERF_EVENT, PERF_EVENT__WRITE, NULL);
> +}
> +#endif
> +
>  static struct security_hook_list selinux_hooks[] __lsm_ro_after_init =3D=
 {
>  	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr)=
,
>  	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
> @@ -7030,6 +7091,14 @@ static struct security_hook_list selinux_hooks[]=
 __lsm_ro_after_init =3D {
>  	LSM_HOOK_INIT(bpf_map_free_security, selinux_bpf_map_free),
>  	LSM_HOOK_INIT(bpf_prog_free_security, selinux_bpf_prog_free),
>  #endif
> +
> +#ifdef CONFIG_PERF_EVENTS
> +	LSM_HOOK_INIT(perf_event_open, selinux_perf_event_open),
> +	LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
> +	LSM_HOOK_INIT(perf_event_free, selinux_perf_event_free),
> +	LSM_HOOK_INIT(perf_event_read, selinux_perf_event_read),
> +	LSM_HOOK_INIT(perf_event_write, selinux_perf_event_write),
> +#endif
>  };
> =20
>  static __init int selinux_init(void)
> diff --git a/security/selinux/include/classmap.h b/security/selinux/inc=
lude/classmap.h
> index 32e9b03be3dd..7db24855e12d 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -244,6 +244,8 @@ struct security_class_mapping secclass_map[] =3D {
>  	  {"map_create", "map_read", "map_write", "prog_load", "prog_run"} },=

>  	{ "xdp_socket",
>  	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "perf_event",
> +	  {"open", "cpu", "kernel", "tracepoint", "read", "write"} },
>  	{ NULL }
>    };
> =20
> diff --git a/security/selinux/include/objsec.h b/security/selinux/inclu=
de/objsec.h
> index 586b7abd0aa7..a4a86cbcfb0a 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -141,7 +141,11 @@ struct pkey_security_struct {
>  };
> =20
>  struct bpf_security_struct {
> -	u32 sid;  /*SID of bpf obj creater*/
> +	u32 sid;  /* SID of bpf obj creator */
> +};
> +
> +struct perf_event_security_struct {
> +	u32 sid;  /* SID of perf_event obj creator */
>  };
> =20
>  extern struct lsm_blob_sizes selinux_blob_sizes;

