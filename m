Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66F9FD78EA
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2019 16:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732712AbfJOOm2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Oct 2019 10:42:28 -0400
Received: from USAT19PA20.eemsg.mail.mil ([214.24.22.194]:53110 "EHLO
        USAT19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732636AbfJOOm2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Oct 2019 10:42:28 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Oct 2019 10:42:26 EDT
X-EEMSG-check-017: 39111568|USAT19PA20_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,300,1566864000"; 
   d="scan'208";a="39111568"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Oct 2019 14:35:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1571150117; x=1602686117;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=TE2vSTVyej6pQOFkOfcPCMawe4aREVdzFocqPE0zzX0=;
  b=rAbzi0WboU2dbENAMV/1DtB+kqkMGHa1m/wclKGXKDR0WoY/8w1DwTt6
   ojq/jBiS2DzPkgd17FKH2D6f3mAuK4LfJmocCwa+XZthvEHFrlDWFOShl
   UmLeVzTpe3ANNYXRMgB76hi1iDkqNIcIndWL4KIw2syT8wt+idVUULwje
   MLIMKNe6XsbP5RcOU6NibE7zO/GSgCL2ulkwT52+7Q4rwRSquND0eHSaK
   qeRNLYNNXV+08O502JLzqsYevnH5h1MoWJ7zgrsVsWpXd+VYwM9Rjwbt0
   tJxgPdx6W/Z6932IWpnaP8aCP0A0Tcp+cGuQGhY8yzNp5ASG8MVjwrPIt
   A==;
X-IronPort-AV: E=Sophos;i="5.67,300,1566864000"; 
   d="scan'208";a="34165388"
IronPort-PHdr: =?us-ascii?q?9a23=3ANy74Vhzq0rZkL2jXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0eofLPad9pjvdHbS+e9qxAeQG9mCsLQb0KGJ7ujJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVijexe7F/IRu5oQjTtsQdnJdvJLs2xh?=
 =?us-ascii?q?bVuHVDZv5YxXlvJVKdnhb84tm/8Zt++ClOuPwv6tBNX7zic6s3UbJXAjImM3?=
 =?us-ascii?q?so5MLwrhnMURGP5noHXWoIlBdDHhXI4wv7Xpf1tSv6q/Z91SyHNsD4Ubw4RT?=
 =?us-ascii?q?Kv5LpwRRT2lCkIKSI28GDPisxxkq1bpg6hpwdiyILQeY2ZKeZycr/Ycd4cS2?=
 =?us-ascii?q?VBRMJRXDFfDI26YYUEEu4NMf9Go4TzolcDqwa1CwuxC+P10jJGm2H43aM63e?=
 =?us-ascii?q?oiHw/J0gMvENASv3rbt9j1KKUfXPqpwKXUwzjObfVb0ir95ojSdRAhpOmBU6?=
 =?us-ascii?q?9sccXP0UkvFx3KjlONooL4OjOazOANs2yF4OtgSOmijHUnpBxqojW02sctip?=
 =?us-ascii?q?XGhoISylze8yV525w6Kce3SE58f96pCZ1dvDyUOYtxR8MtWWBouCAix70Ct5?=
 =?us-ascii?q?+7ejIGyJI5yB7DbfGMbouG4gr7WeqMLjp1i2hpdbKiixqo70StxfPwWtOp3F?=
 =?us-ascii?q?tMsyFLiMPDtmoX2BzW8sWHT/x98Vq/1juXzADT7/1EIVgzlarGN54t2r4wmY?=
 =?us-ascii?q?QXsUTEBiL2hF/5jLWXdkU54eik8fjnY7X6qZ+cMI94kAf+Pbg1msOjG+g4Nw?=
 =?us-ascii?q?kOX2yD9eS90r3s41H5Ta1XgvA5naTVqpDXKdkBqqKnDAJZzJwv5wunAzejyt?=
 =?us-ascii?q?sYnH0HLFxfeBKAiojkI0rOL+3jDfqkn1StkCtkx/DBPrH7BJXNNWLMnK3ufb?=
 =?us-ascii?q?Z69U5Q0BAzwsxH55JIFrEBJ+r+Wk32tNPGCh80KA60w+H5B9V52IMRR3iPAq?=
 =?us-ascii?q?mDP6PUrFCH+PkvL/OLZI8Ptzb3M+Il6OL2jX8lhV8derGk3Z8WaHC+A/RnLF?=
 =?us-ascii?q?yVYXnyjdcbF2cFoA4+Qff0iF2NTzFTfWy+X6Ei6TEhDoKpE4PDSpqqgLyb0y?=
 =?us-ascii?q?exBodWaXxeClCQDXfocJ2JW+8SZyKOPMBhiD0FWKOgS48n2xGurhX1xKd5Ie?=
 =?us-ascii?q?XO5yIUr5Xj1MJ65+fLjxE96SR0D9iB02GKV2x0hGQIRyQq3K9hvEN91kyO0a?=
 =?us-ascii?q?d/g/xfCNNT4vJJUhwgOZ7b1ex6BMj4WhjdcdeRVFamXtKmDCkpTtIrwt8OZk?=
 =?us-ascii?q?d9FM+kjhDExCeqDLgVl7uEBJww7K3QxWT+J8F4y3zezqkuk0EmQtdTNW2hnq?=
 =?us-ascii?q?N/7RPTCJTXk0WYi6aqbqcc3C/W+WeMymqOu05YUApuXqnfQX8fYU7Wp8zj5k?=
 =?us-ascii?q?zeV7+uFagnMgxZxM6ANKRKZNPpjUtdSffsP9TeZG2xm2OuChqS2ryMa4/qcX?=
 =?us-ascii?q?0H3CrBEEgEjxwT/XGeOAg9GCihuWTeAyJqFV72f0Pj7/NxqHagQ0AuyQGFcl?=
 =?us-ascii?q?dh1720+hEIn/CTV/QT3rccsic7tzp0BEq9387RC9eYpQpheaJcYckn4FdGzm?=
 =?us-ascii?q?LUrAp9MYalL698h14SaQN3v1nh1x9vEIVPjdAqrG82zAp1Ma+XykhBdy+D0J?=
 =?us-ascii?q?DzJLLXMG/y8w6ra6LM3VHeytmW8L8V6Psks1XjoB2pFk06/np9z9ZV1mWT64?=
 =?us-ascii?q?7JDAUMS5LxVFg49xxgq7HdeCk96Jve1WdwPqmsrj/Cx9UpCfM+xRa4cddSK7?=
 =?us-ascii?q?2EFADsHM0AHcSuK/Ilm0Kvbh0aOOBe7qk0P9mpd/Gewq6kIP5gnC66jWRA+I?=
 =?us-ascii?q?1yz1iD9yx9SuHW25YI2PCY3gyIVzjillihqNv4mYdLZD0IGGqw1zTkDpZLZq?=
 =?us-ascii?q?JuZYYLFXuuI8qvy9V7hp7tXXFY9Fm4ClMcxsCmZBqSYEbh3QFKyUsXpnmnkz?=
 =?us-ascii?q?OizzNoizEpsraf3CvWzuTgcxoHPnVLS3N5gFf2P4e7ktAaU1K0bwQziBSl4k?=
 =?us-ascii?q?P6zbBBpKtjN2nTXVtIfy/uImFhTKS/qKGCbNJI6JMvsiVaS/izYVCASr76ph?=
 =?us-ascii?q?sa0j7jH25EyDA8bTGqtY3znwZmh2KFMHZzsH3ZdNl0xRfe4tzcWPFQ0iMdRC?=
 =?us-ascii?q?ZmlTbXG0K8P9i1/dSUjpvDt+e+WH+8Vp1Xbybm1p2AtCSl6m1wGxG/nO68ms?=
 =?us-ascii?q?fhEQck1S/3zd5qVT/HrBzkeInky7y6Mf57fklvHFL87tB1Gp1ikoswmp4R13?=
 =?us-ascii?q?caiY+P/Xodj2jzLclb1LnxbHoKQj4LzNrV7xb/1EJ/KXKJwprzVm+Bzct5e9?=
 =?us-ascii?q?m6fmQW1zo7789QDaeU7LxFnTZzolq3tg/RYuZyni0byfQw7H4WmeYJuBAizi?=
 =?us-ascii?q?+FGLAdAVFYPTDwlxSP992+t7tYZGKucbi2yUp/ksusDK+Nog5CQnb1YJQiEj?=
 =?us-ascii?q?Fq7sV5Ll3M1Gf/6ob+eNnfddgTrAGbkw/cj+hJL5I8juEKhS1hOWLyuX0lyv?=
 =?us-ascii?q?M7ggd03Z6gooiHKmNt/K2iDx5WLTL5fd8c+jbojaxGhMaZw5ivHol9GjUMRJ?=
 =?us-ascii?q?bpQvGlHTMJuPTkKQmOCjs8pWmfGbbFGg+f8khmpWrVE5+3L3GXOGUZzdJ6SR?=
 =?us-ascii?q?idJExfmxsZXDshkZIjCg+qw8nhIw9F4WVbxFn1rlNix/huPh/zX3yX5CivbT?=
 =?us-ascii?q?gwRdnVZE5U6QxGz0XSPMiQ4/h1FidU84bnqxaCfCjTYwVOEHFMWUGeAV3nFq?=
 =?us-ascii?q?eh6MOG8OWCAOe6afzUbuags+tbAsyUyIqv340uxDOFMsGCLzE2FPEg8lZSVn?=
 =?us-ascii?q?B+XcLCknMATDJBxHGFVNKSuBrpon4/lcu46vm+HVu1voY=3D?=
X-IPAS-Result: =?us-ascii?q?A2C2CAAD16Vd/wHyM5BeCBwBAQEBAQcBAREBBAQBAYF7g?=
 =?us-ascii?q?XQsbFMBMiqEJY5gTQEBAQEBAQaBNol4kFgDVAkBAQEBAQEBAQEnDQECAQGEQ?=
 =?us-ascii?q?AKCbiQ4EwIMAQEBBAEBAQEBBQMBAWyFLQyCOikBgmgBBRoJBBEvEhALGAICJ?=
 =?us-ascii?q?gICVwYBDAQCAgEBglMMPwGCUiWvQH8zhDgBCwGBCIMxgUIGgQwoilqBNBh4g?=
 =?us-ascii?q?QeBESeCPS4+gmEBA4E4AQGDM4JeBI0tB4IChnWBNJVrgiyCMYRZjgsGG4I6i?=
 =?us-ascii?q?3uLDC2OBIgjjh6FCyI3gSErCAIYCCEPgycfMRAUHoE9F4gphhYlAwQsgQYBA?=
 =?us-ascii?q?Y1tASWCLgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 15 Oct 2019 14:35:15 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9FEZ9k8020323;
        Tue, 15 Oct 2019 10:35:10 -0400
Subject: Re: [PATCH v2] perf_event: Add support for LSM and SELinux checks
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, rostedt@goodmis.org,
        primiano@google.com, rsavitski@google.com, jeffv@google.com,
        kernel-team@android.com, James Morris <jmorris@namei.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Namhyung Kim <namhyung@kernel.org>, selinux@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Yonghong Song <yhs@fb.com>
References: <20191014170308.70668-1-joel@joelfernandes.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <c5bd06a4-54a4-b56e-457c-df36f05d2e3f@tycho.nsa.gov>
Date:   Tue, 15 Oct 2019 10:35:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191014170308.70668-1-joel@joelfernandes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/14/19 1:03 PM, Joel Fernandes (Google) wrote:
> In current mainline, the degree of access to perf_event_open(2) system
> call depends on the perf_event_paranoid sysctl.  This has a number of
> limitations:
> 
> 1. The sysctl is only a single value. Many types of accesses are controlled
>     based on the single value thus making the control very limited and
>     coarse grained.
> 2. The sysctl is global, so if the sysctl is changed, then that means
>     all processes get access to perf_event_open(2) opening the door to
>     security issues.
> 
> This patch adds LSM and SELinux access checking which will be used in
> Android to access perf_event_open(2) for the purposes of attaching BPF
> programs to tracepoints, perf profiling and other operations from
> userspace. These operations are intended for production systems.
> 
> 5 new LSM hooks are added:
> 1. perf_event_open: This controls access during the perf_event_open(2)
>     syscall itself. The hook is called from all the places that the
>     perf_event_paranoid sysctl is checked to keep it consistent with the
>     systctl. The hook gets passed a 'type' argument which controls CPU,
>     kernel and tracepoint accesses (in this context, CPU, kernel and
>     tracepoint have the same semantics as the perf_event_paranoid sysctl).
>     Additionally, I added an 'open' type which is similar to
>     perf_event_paranoid sysctl == 3 patch carried in Android and several other
>     distros but was rejected in mainline [1] in 2016.
> 
> 2. perf_event_alloc: This allocates a new security object for the event
>     which stores the current SID within the event. It will be useful when
>     the perf event's FD is passed through IPC to another process which may
>     try to read the FD. Appropriate security checks will limit access.
> 
> 3. perf_event_free: Called when the event is closed.
> 
> 4. perf_event_read: Called from the read(2) and mmap(2) syscalls for the event.
> 
> 5. perf_event_write: Called from the ioctl(2) syscalls for the event.
> 
> [1] https://lwn.net/Articles/696240/
> 
> Since Peter had suggest LSM hooks in 2016 [1], I am adding his
> Suggested-by tag below.
> 
> To use this patch, we set the perf_event_paranoid sysctl to -1 and then
> apply selinux checking as appropriate (default deny everything, and then
> add policy rules to give access to domains that need it). In the future
> we can remove the perf_event_paranoid sysctl altogether.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: rostedt@goodmis.org
> Cc: primiano@google.com
> Cc: rsavitski@google.com
> Cc: jeffv@google.com
> Cc: kernel-team@android.com
> Acked-by: James Morris <jmorris@namei.org>
> Co-developed-by: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
> 
> Changes since v1:
>   o Fixes from Peter Ziljstra.
>   o Added Ack from James Morris and Co-developed-by tag for Peter.
> Changes since RFC:
>   o Small nits, style changes (James Morris).
>   o Consolidation of code (Peter Zijlstra).
> 
> 
>   arch/x86/events/intel/bts.c         |  8 ++--
>   arch/x86/events/intel/core.c        |  5 ++-
>   arch/x86/events/intel/p4.c          |  5 ++-
>   include/linux/lsm_hooks.h           | 15 +++++++
>   include/linux/perf_event.h          | 28 +++++++++---
>   include/linux/security.h            | 39 +++++++++++++++-
>   include/uapi/linux/perf_event.h     |  9 ++++
>   kernel/events/core.c                | 57 +++++++++++++++++++-----
>   kernel/trace/trace_event_perf.c     | 15 ++++---
>   security/security.c                 | 27 +++++++++++
>   security/selinux/hooks.c            | 69 +++++++++++++++++++++++++++++
>   security/selinux/include/classmap.h |  2 +
>   security/selinux/include/objsec.h   |  6 ++-
>   13 files changed, 255 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
> index 5ee3fed881d3..38de4a7f6752 100644
> --- a/arch/x86/events/intel/bts.c
> +++ b/arch/x86/events/intel/bts.c
> @@ -549,9 +549,11 @@ static int bts_event_init(struct perf_event *event)
>   	 * Note that the default paranoia setting permits unprivileged
>   	 * users to profile the kernel.
>   	 */
> -	if (event->attr.exclude_kernel && perf_paranoid_kernel() &&
> -	    !capable(CAP_SYS_ADMIN))
> -		return -EACCES;
> +	if (event->attr.exclude_kernel) {
> +		ret = perf_allow_kernel(&event->attr);
> +		if (ret)
> +			return ret;
> +	}
>   
>   	if (x86_add_exclusive(x86_lbr_exclusive_bts))
>   		return -EBUSY;
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 27ee47a7be66..32967a9e9962 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3315,8 +3315,9 @@ static int intel_pmu_hw_config(struct perf_event *event)
>   	if (x86_pmu.version < 3)
>   		return -EINVAL;
>   
> -	if (perf_paranoid_cpu() && !capable(CAP_SYS_ADMIN))
> -		return -EACCES;
> +	ret = perf_allow_cpu(&event->attr);
> +	if (ret)
> +		return ret;
>   
>   	event->hw.config |= ARCH_PERFMON_EVENTSEL_ANY;
>   
> diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
> index dee579efb2b2..a4cc66005ce8 100644
> --- a/arch/x86/events/intel/p4.c
> +++ b/arch/x86/events/intel/p4.c
> @@ -776,8 +776,9 @@ static int p4_validate_raw_event(struct perf_event *event)
>   	 * the user needs special permissions to be able to use it
>   	 */
>   	if (p4_ht_active() && p4_event_bind_map[v].shared) {
> -		if (perf_paranoid_cpu() && !capable(CAP_SYS_ADMIN))
> -			return -EACCES;
> +		v = perf_allow_cpu(&event->attr);
> +		if (v)
> +			return v;
>   	}
>   
>   	/* ESCR EventMask bits may be invalid */
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index a3763247547c..20d8cf194fb7 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1818,6 +1818,14 @@ union security_list_options {
>   	void (*bpf_prog_free_security)(struct bpf_prog_aux *aux);
>   #endif /* CONFIG_BPF_SYSCALL */
>   	int (*locked_down)(enum lockdown_reason what);
> +#ifdef CONFIG_PERF_EVENTS
> +	int (*perf_event_open)(struct perf_event_attr *attr, int type);
> +	int (*perf_event_alloc)(struct perf_event *event);
> +	void (*perf_event_free)(struct perf_event *event);
> +	int (*perf_event_read)(struct perf_event *event);
> +	int (*perf_event_write)(struct perf_event *event);
> +
> +#endif
>   };
>   
>   struct security_hook_heads {
> @@ -2060,6 +2068,13 @@ struct security_hook_heads {
>   	struct hlist_head bpf_prog_free_security;
>   #endif /* CONFIG_BPF_SYSCALL */
>   	struct hlist_head locked_down;
> +#ifdef CONFIG_PERF_EVENTS
> +	struct hlist_head perf_event_open;
> +	struct hlist_head perf_event_alloc;
> +	struct hlist_head perf_event_free;
> +	struct hlist_head perf_event_read;
> +	struct hlist_head perf_event_write;
> +#endif
>   } __randomize_layout;
>   
>   /*
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 61448c19a132..664bb7f99c46 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -56,6 +56,7 @@ struct perf_guest_info_callbacks {
>   #include <linux/perf_regs.h>
>   #include <linux/cgroup.h>
>   #include <linux/refcount.h>
> +#include <linux/security.h>
>   #include <asm/local.h>
>   
>   struct perf_callchain_entry {
> @@ -721,6 +722,9 @@ struct perf_event {
>   	struct perf_cgroup		*cgrp; /* cgroup event is attach to */
>   #endif
>   
> +#ifdef CONFIG_SECURITY
> +	void *security;
> +#endif
>   	struct list_head		sb_list;
>   #endif /* CONFIG_PERF_EVENTS */
>   };
> @@ -1241,19 +1245,33 @@ extern int perf_cpu_time_max_percent_handler(struct ctl_table *table, int write,
>   int perf_event_max_stack_handler(struct ctl_table *table, int write,
>   				 void __user *buffer, size_t *lenp, loff_t *ppos);
>   
> -static inline bool perf_paranoid_tracepoint_raw(void)
> +static inline int perf_is_paranoid(void)
>   {
>   	return sysctl_perf_event_paranoid > -1;
>   }
>   
> -static inline bool perf_paranoid_cpu(void)
> +static inline int perf_allow_kernel(struct perf_event_attr *attr)
>   {
> -	return sysctl_perf_event_paranoid > 0;
> +	if (sysctl_perf_event_paranoid > 1 && !capable(CAP_SYS_ADMIN))
> +		return -EACCES;
> +
> +	return security_perf_event_open(attr, PERF_SECURITY_KERNEL);
>   }
>   
> -static inline bool perf_paranoid_kernel(void)
> +static inline int perf_allow_cpu(struct perf_event_attr *attr)
>   {
> -	return sysctl_perf_event_paranoid > 1;
> +	if (sysctl_perf_event_paranoid > 0 && !capable(CAP_SYS_ADMIN))
> +		return -EACCES;
> +
> +	return security_perf_event_open(attr, PERF_SECURITY_CPU);
> +}
> +
> +static inline int perf_allow_tracepoint(struct perf_event_attr *attr)
> +{
> +	if (sysctl_perf_event_paranoid > -1 && !capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	return security_perf_event_open(attr, PERF_SECURITY_TRACEPOINT);
>   }
>   
>   extern void perf_event_init(void);
> diff --git a/include/linux/security.h b/include/linux/security.h
> index a8d59d612d27..273e11c66ed7 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1894,5 +1894,42 @@ static inline void security_bpf_prog_free(struct bpf_prog_aux *aux)
>   #endif /* CONFIG_SECURITY */
>   #endif /* CONFIG_BPF_SYSCALL */
>   
> -#endif /* ! __LINUX_SECURITY_H */
> +#ifdef CONFIG_PERF_EVENTS
> +struct perf_event_attr;
> +
> +#ifdef CONFIG_SECURITY
> +extern int security_perf_event_open(struct perf_event_attr *attr, int type);
> +extern int security_perf_event_alloc(struct perf_event *event);
> +extern void security_perf_event_free(struct perf_event *event);
> +extern int security_perf_event_read(struct perf_event *event);
> +extern int security_perf_event_write(struct perf_event *event);
> +#else
> +static inline int security_perf_event_open(struct perf_event_attr *attr,
> +					   int type)
> +{
> +	return 0;
> +}
>   
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
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index bb7b271397a6..2af95f937a5b 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -427,6 +427,15 @@ struct perf_event_attr {
>   	__u16	__reserved_2;	/* align to __u64 */
>   };
>   
> +
> +/* Access to perf_event_open(2) syscall. */
> +#define PERF_SECURITY_OPEN		0
> +
> +/* Finer grained perf_event_open(2) access control. */
> +#define PERF_SECURITY_CPU		1
> +#define PERF_SECURITY_KERNEL		2
> +#define PERF_SECURITY_TRACEPOINT	3
> +

Why are these definitions part of the uapi header and not private to the 
kernel?  You map them to SELinux permissions in the kernel, and the 
SELinux permissions are mapped to policy values at policy load time (so 
the values need not be identical).  We also have mechanisms in SELinux 
to permit evolution of the permissions over time in a 
backward-compatible manner.

>   /*
>    * Structure used by below PERF_EVENT_IOC_QUERY_BPF command
>    * to query bpf programs attached to the same perf tracepoint
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 4655adbbae10..8ad597fae5f4 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4217,8 +4217,9 @@ find_get_context(struct pmu *pmu, struct task_struct *task,
>   
>   	if (!task) {
>   		/* Must be root to operate on a CPU event: */
> -		if (perf_paranoid_cpu() && !capable(CAP_SYS_ADMIN))
> -			return ERR_PTR(-EACCES);
> +		err = perf_allow_cpu(&event->attr);
> +		if (err)
> +			return ERR_PTR(err);
>   
>   		cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
>   		ctx = &cpuctx->ctx;
> @@ -4527,6 +4528,8 @@ static void _free_event(struct perf_event *event)
>   
>   	unaccount_event(event);
>   
> +	security_perf_event_free(event);
> +
>   	if (event->rb) {
>   		/*
>   		 * Can happen when we close an event with re-directed output.
> @@ -4980,6 +4983,10 @@ perf_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>   	struct perf_event_context *ctx;
>   	int ret;
>   
> +	ret = security_perf_event_read(event);
> +	if (ret)
> +		return ret;
> +
>   	ctx = perf_event_ctx_lock(event);
>   	ret = __perf_read(event, buf, count);
>   	perf_event_ctx_unlock(event, ctx);
> @@ -5244,6 +5251,11 @@ static long perf_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>   	struct perf_event_context *ctx;
>   	long ret;
>   
> +	/* Treat ioctl like writes as it is likely a mutating operation. */
> +	ret = security_perf_event_write(event);
> +	if (ret)
> +		return ret;
> +
>   	ctx = perf_event_ctx_lock(event);
>   	ret = _perf_ioctl(event, cmd, arg);
>   	perf_event_ctx_unlock(event, ctx);
> @@ -5706,6 +5718,10 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
>   	if (!(vma->vm_flags & VM_SHARED))
>   		return -EINVAL;
>   
> +	ret = security_perf_event_read(event);
> +	if (ret)
> +		return ret;
> +
>   	vma_size = vma->vm_end - vma->vm_start;
>   
>   	if (vma->vm_pgoff == 0) {
> @@ -5819,7 +5835,7 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
>   	lock_limit >>= PAGE_SHIFT;
>   	locked = atomic64_read(&vma->vm_mm->pinned_vm) + extra;
>   
> -	if ((locked > lock_limit) && perf_paranoid_tracepoint_raw() &&
> +	if ((locked > lock_limit) && perf_is_paranoid() &&
>   		!capable(CAP_IPC_LOCK)) {
>   		ret = -EPERM;
>   		goto unlock;
> @@ -10553,11 +10569,20 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>   		}
>   	}
>   
> +	err = security_perf_event_alloc(event);
> +	if (err)
> +		goto err_callchain_buffer;
> +
>   	/* symmetric to unaccount_event() in _free_event() */
>   	account_event(event);
>   
>   	return event;
>   
> +err_callchain_buffer:
> +	if (!event->parent) {
> +		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
> +			put_callchain_buffers();
> +	}
>   err_addr_filters:
>   	kfree(event->addr_filter_ranges);
>   
> @@ -10675,9 +10700,11 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
>   			attr->branch_sample_type = mask;
>   		}
>   		/* privileged levels capture (kernel, hv): check permissions */
> -		if ((mask & PERF_SAMPLE_BRANCH_PERM_PLM)
> -		    && perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
> -			return -EACCES;
> +		if (mask & PERF_SAMPLE_BRANCH_PERM_PLM) {
> +			ret = perf_allow_kernel(attr);
> +			if (ret)
> +				return ret;
> +		}
>   	}
>   
>   	if (attr->sample_type & PERF_SAMPLE_REGS_USER) {
> @@ -10890,13 +10917,19 @@ SYSCALL_DEFINE5(perf_event_open,
>   	if (flags & ~PERF_FLAG_ALL)
>   		return -EINVAL;
>   
> +	/* Do we allow access to perf_event_open(2) ? */
> +	err = security_perf_event_open(&attr, PERF_SECURITY_OPEN);
> +	if (err)
> +		return err;
> +
>   	err = perf_copy_attr(attr_uptr, &attr);
>   	if (err)
>   		return err;
>   
>   	if (!attr.exclude_kernel) {
> -		if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
> -			return -EACCES;
> +		err = perf_allow_kernel(&attr);
> +		if (err)
> +			return err;
>   	}
>   
>   	if (attr.namespaces) {
> @@ -10913,9 +10946,11 @@ SYSCALL_DEFINE5(perf_event_open,
>   	}
>   
>   	/* Only privileged users can get physical addresses */
> -	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR) &&
> -	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
> -		return -EACCES;
> +	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR)) {
> +		err = perf_allow_kernel(&attr);
> +		if (err)
> +			return err;
> +	}
>   
>   	err = security_locked_down(LOCKDOWN_PERF);
>   	if (err && (attr.sample_type & PERF_SAMPLE_REGS_INTR))
> diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
> index 0892e38ed6fb..0917fee6ee7c 100644
> --- a/kernel/trace/trace_event_perf.c
> +++ b/kernel/trace/trace_event_perf.c
> @@ -8,6 +8,7 @@
>   
>   #include <linux/module.h>
>   #include <linux/kprobes.h>
> +#include <linux/security.h>
>   #include "trace.h"
>   #include "trace_probe.h"
>   
> @@ -26,8 +27,10 @@ static int	total_ref_count;
>   static int perf_trace_event_perm(struct trace_event_call *tp_event,
>   				 struct perf_event *p_event)
>   {
> +	int ret;
> +
>   	if (tp_event->perf_perm) {
> -		int ret = tp_event->perf_perm(tp_event, p_event);
> +		ret = tp_event->perf_perm(tp_event, p_event);
>   		if (ret)
>   			return ret;
>   	}
> @@ -46,8 +49,9 @@ static int perf_trace_event_perm(struct trace_event_call *tp_event,
>   
>   	/* The ftrace function trace is allowed only for root. */
>   	if (ftrace_event_is_function(tp_event)) {
> -		if (perf_paranoid_tracepoint_raw() && !capable(CAP_SYS_ADMIN))
> -			return -EPERM;
> +		ret = perf_allow_tracepoint(&p_event->attr);
> +		if (ret)
> +			return ret;
>   
>   		if (!is_sampling_event(p_event))
>   			return 0;
> @@ -82,8 +86,9 @@ static int perf_trace_event_perm(struct trace_event_call *tp_event,
>   	 * ...otherwise raw tracepoint data can be a severe data leak,
>   	 * only allow root to have these.
>   	 */
> -	if (perf_paranoid_tracepoint_raw() && !capable(CAP_SYS_ADMIN))
> -		return -EPERM;
> +	ret = perf_allow_tracepoint(&p_event->attr);
> +	if (ret)
> +		return ret;
>   
>   	return 0;
>   }
> diff --git a/security/security.c b/security/security.c
> index 1bc000f834e2..cd2d18d2d279 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2404,3 +2404,30 @@ int security_locked_down(enum lockdown_reason what)
>   	return call_int_hook(locked_down, 0, what);
>   }
>   EXPORT_SYMBOL(security_locked_down);
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
> @@ -6795,6 +6795,67 @@ struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
>   	.lbs_msg_msg = sizeof(struct msg_security_struct),
>   };
>   
> +#ifdef CONFIG_PERF_EVENTS
> +static int selinux_perf_event_open(struct perf_event_attr *attr, int type)
> +{
> +	u32 requested, sid = current_sid();
> +
> +	if (type == PERF_SECURITY_OPEN)
> +		requested = PERF_EVENT__OPEN;
> +	else if (type == PERF_SECURITY_CPU)
> +		requested = PERF_EVENT__CPU;
> +	else if (type == PERF_SECURITY_KERNEL)
> +		requested = PERF_EVENT__KERNEL;
> +	else if (type == PERF_SECURITY_TRACEPOINT)
> +		requested = PERF_EVENT__TRACEPOINT;
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
> +	perfsec = kzalloc(sizeof(*perfsec), GFP_KERNEL);
> +	if (!perfsec)
> +		return -ENOMEM;
> +
> +	perfsec->sid = current_sid();
> +	event->security = perfsec;
> +
> +	return 0;
> +}
> +
> +static void selinux_perf_event_free(struct perf_event *event)
> +{
> +	struct perf_event_security_struct *perfsec = event->security;
> +
> +	event->security = NULL;
> +	kfree(perfsec);
> +}
> +
> +static int selinux_perf_event_read(struct perf_event *event)
> +{
> +	struct perf_event_security_struct *perfsec = event->security;
> +	u32 sid = current_sid();
> +
> +	return avc_has_perm(&selinux_state, sid, perfsec->sid,
> +			    SECCLASS_PERF_EVENT, PERF_EVENT__READ, NULL);
> +}
> +
> +static int selinux_perf_event_write(struct perf_event *event)
> +{
> +	struct perf_event_security_struct *perfsec = event->security;
> +	u32 sid = current_sid();
> +
> +	return avc_has_perm(&selinux_state, sid, perfsec->sid,
> +			    SECCLASS_PERF_EVENT, PERF_EVENT__WRITE, NULL);
> +}
> +#endif
> +
>   static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
>   	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
> @@ -7030,6 +7091,14 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(bpf_map_free_security, selinux_bpf_map_free),
>   	LSM_HOOK_INIT(bpf_prog_free_security, selinux_bpf_prog_free),
>   #endif
> +
> +#ifdef CONFIG_PERF_EVENTS
> +	LSM_HOOK_INIT(perf_event_open, selinux_perf_event_open),
> +	LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
> +	LSM_HOOK_INIT(perf_event_free, selinux_perf_event_free),
> +	LSM_HOOK_INIT(perf_event_read, selinux_perf_event_read),
> +	LSM_HOOK_INIT(perf_event_write, selinux_perf_event_write),
> +#endif
>   };
>   
>   static __init int selinux_init(void)
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index 32e9b03be3dd..7db24855e12d 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -244,6 +244,8 @@ struct security_class_mapping secclass_map[] = {
>   	  {"map_create", "map_read", "map_write", "prog_load", "prog_run"} },
>   	{ "xdp_socket",
>   	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "perf_event",
> +	  {"open", "cpu", "kernel", "tracepoint", "read", "write"} },
>   	{ NULL }
>     };
>   
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
> index 586b7abd0aa7..a4a86cbcfb0a 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -141,7 +141,11 @@ struct pkey_security_struct {
>   };
>   
>   struct bpf_security_struct {
> -	u32 sid;  /*SID of bpf obj creater*/
> +	u32 sid;  /* SID of bpf obj creator */
> +};
> +
> +struct perf_event_security_struct {
> +	u32 sid;  /* SID of perf_event obj creator */
>   };
>   
>   extern struct lsm_blob_sizes selinux_blob_sizes;
> 

