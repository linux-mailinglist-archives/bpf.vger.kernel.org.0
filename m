Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEEFA135817
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2020 12:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgAILhB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jan 2020 06:37:01 -0500
Received: from mga01.intel.com ([192.55.52.88]:55961 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbgAILhA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jan 2020 06:37:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 03:37:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,413,1571727600"; 
   d="scan'208";a="216275607"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 09 Jan 2020 03:36:59 -0800
Received: from [10.125.253.127] (abudanko-mobl.ccr.corp.intel.com [10.125.253.127])
        by linux.intel.com (Postfix) with ESMTP id 2707C58043A;
        Thu,  9 Jan 2020 03:36:50 -0800 (PST)
Subject: Re: [PATCH v4 2/9] perf/core: open access for CAP_SYS_PERFMON
 privileged process
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "james.bottomley@hansenpartnership.com" 
        <james.bottomley@hansenpartnership.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Robert Richter <rric@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        Song Liu <songliubraving@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, oprofile-list@lists.sf.net
References: <c0460c78-b1a6-b5f7-7119-d97e5998f308@linux.intel.com>
 <c93309dc-b920-f5fa-f997-e8b2faf47b88@linux.intel.com>
 <20200108160713.GI2844@hirez.programming.kicks-ass.net>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <cc239899-5c52-2fd0-286d-4bff18877937@linux.intel.com>
Date:   Thu, 9 Jan 2020 14:36:50 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200108160713.GI2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 08.01.2020 19:07, Peter Zijlstra wrote:
> On Wed, Dec 18, 2019 at 12:25:35PM +0300, Alexey Budankov wrote:
>>
>> Open access to perf_events monitoring for CAP_SYS_PERFMON privileged
>> processes. For backward compatibility reasons access to perf_events
>> subsystem remains open for CAP_SYS_ADMIN privileged processes but
>> CAP_SYS_ADMIN usage for secure perf_events monitoring is discouraged
>> with respect to CAP_SYS_PERFMON capability.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  include/linux/perf_event.h | 6 +++---
>>  kernel/events/core.c       | 6 +++---
>>  2 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index 34c7c6910026..f46acd69425f 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -1285,7 +1285,7 @@ static inline int perf_is_paranoid(void)
>>  
>>  static inline int perf_allow_kernel(struct perf_event_attr *attr)
>>  {
>> -	if (sysctl_perf_event_paranoid > 1 && !capable(CAP_SYS_ADMIN))
>> +	if (sysctl_perf_event_paranoid > 1 && !perfmon_capable())
>>  		return -EACCES;
>>  
>>  	return security_perf_event_open(attr, PERF_SECURITY_KERNEL);
>> @@ -1293,7 +1293,7 @@ static inline int perf_allow_kernel(struct perf_event_attr *attr)
>>  
>>  static inline int perf_allow_cpu(struct perf_event_attr *attr)
>>  {
>> -	if (sysctl_perf_event_paranoid > 0 && !capable(CAP_SYS_ADMIN))
>> +	if (sysctl_perf_event_paranoid > 0 && !perfmon_capable())
>>  		return -EACCES;
>>  
>>  	return security_perf_event_open(attr, PERF_SECURITY_CPU);
>> @@ -1301,7 +1301,7 @@ static inline int perf_allow_cpu(struct perf_event_attr *attr)
>>  
>>  static inline int perf_allow_tracepoint(struct perf_event_attr *attr)
>>  {
>> -	if (sysctl_perf_event_paranoid > -1 && !capable(CAP_SYS_ADMIN))
>> +	if (sysctl_perf_event_paranoid > -1 && !perfmon_capable())
>>  		return -EPERM;
>>  
>>  	return security_perf_event_open(attr, PERF_SECURITY_TRACEPOINT);
> 
> These are OK I suppose.
> 
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 059ee7116008..d9db414f2197 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -9056,7 +9056,7 @@ static int perf_kprobe_event_init(struct perf_event *event)
>>  	if (event->attr.type != perf_kprobe.type)
>>  		return -ENOENT;
>>  
>> -	if (!capable(CAP_SYS_ADMIN))
>> +	if (!perfmon_capable())
>>  		return -EACCES;
>>  
>>  	/*
> 
> This one only allows attaching to already extant kprobes, right? It does
> not allow creation of kprobes.

This unblocks creation of local trace kprobes and uprobes by CAP_SYS_PERFMON 
privileged process, exactly the same as for CAP_SYS_ADMIN privileged process.

> 
>> @@ -9116,7 +9116,7 @@ static int perf_uprobe_event_init(struct perf_event *event)
>>  	if (event->attr.type != perf_uprobe.type)
>>  		return -ENOENT;
>>  
>> -	if (!capable(CAP_SYS_ADMIN))
>> +	if (!perfmon_capable())
>>  		return -EACCES;
>>  
>>  	/*
> 
> Idem, I presume.
> 
>> @@ -11157,7 +11157,7 @@ SYSCALL_DEFINE5(perf_event_open,
>>  	}
>>  
>>  	if (attr.namespaces) {
>> -		if (!capable(CAP_SYS_ADMIN))
>> +		if (!perfmon_capable())
>>  			return -EACCES;
>>  	}
> 
> And given we basically make the entire kernel observable with this CAP,
> busting namespaces shoulnd't be a problem either.
> 
> So yeah, I suppose that works.
> 
