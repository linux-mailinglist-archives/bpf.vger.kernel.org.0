Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD743122A46
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2019 12:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfLQLjH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Dec 2019 06:39:07 -0500
Received: from mga14.intel.com ([192.55.52.115]:17567 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbfLQLjH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Dec 2019 06:39:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 03:39:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,325,1571727600"; 
   d="scan'208";a="209664859"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 17 Dec 2019 03:39:04 -0800
Received: from [10.125.252.241] (abudanko-mobl.ccr.corp.intel.com [10.125.252.241])
        by linux.intel.com (Postfix) with ESMTP id 48BEC580458;
        Tue, 17 Dec 2019 03:38:57 -0800 (PST)
Subject: Re: [Intel-gfx] [PATCH v3 4/7] drm/i915/perf: open access for
 CAP_SYS_PERFMON privileged process
To:     Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     songliubraving@fb.com, Andi Kleen <ak@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        intel-gfx@lists.freedesktop.org,
        Igor Lubashev <ilubashe@akamai.com>,
        linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Brendan Gregg <bgregg@netflix.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <b175f283-d256-e37e-f447-6ba4ab4f3d3a@linux.intel.com>
 <bc5b2a0d-a185-91b6-5deb-a4b6e1dc3d3e@linux.intel.com>
 <503ad40c-d94e-df1d-1541-730c002ad3b7@intel.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <d71943f5-9c2d-7d08-5c45-2be1be98eb73@linux.intel.com>
Date:   Tue, 17 Dec 2019 14:38:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <503ad40c-d94e-df1d-1541-730c002ad3b7@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 17.12.2019 12:45, Lionel Landwerlin wrote:
> On 16/12/2019 22:03, Alexey Budankov wrote:
>> Open access to i915_perf monitoring for CAP_SYS_PERFMON privileged processes.
>> For backward compatibility reasons access to i915_perf subsystem remains open
>> for CAP_SYS_ADMIN privileged processes but CAP_SYS_ADMIN usage for secure
>> i915_perf monitoring is discouraged with respect to CAP_SYS_PERFMON capability.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> 
> 
> Assuming people are fine with this new cap, I like this idea of a lighter privilege for i915-perf.

Lionel, thanks for your meaningful input!
Appreciate your collaboration.

Regards,
Alexey

> 
> 
> -Lionel
> 
> 
> 
