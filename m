Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22625440594
	for <lists+bpf@lfdr.de>; Sat, 30 Oct 2021 00:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhJ2WvX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Oct 2021 18:51:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:5762 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhJ2WvW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Oct 2021 18:51:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10152"; a="217951556"
X-IronPort-AV: E=Sophos;i="5.87,194,1631602800"; 
   d="scan'208";a="217951556"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 15:48:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,194,1631602800"; 
   d="scan'208";a="448274950"
Received: from gupta-dev2.jf.intel.com (HELO gupta-dev2.localdomain) ([10.54.74.119])
  by orsmga006.jf.intel.com with ESMTP; 29 Oct 2021 15:48:50 -0700
Date:   Fri, 29 Oct 2021 15:51:09 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Colin Ian King <colin.king@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Wang Kefeng <wangkefeng.wang@huawei.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arch/Kconfig: Make CONFIG_CPU_SPECTRE available
 for all architectures
Message-ID: <20211029225109.d3m2q4kuuzhzs2cv@gupta-dev2.localdomain>
References: <cover.1635383031.git.pawan.kumar.gupta@linux.intel.com>
 <232b692cd79e4f6e4c3ee7055b5f02792a28d2c4.1635383031.git.pawan.kumar.gupta@linux.intel.com>
 <20211028134918.GB48435@lakrids.cambridge.arm.com>
 <20211028193658.7n2oehp6yogyqbwq@gupta-dev2.localdomain>
 <YXvIIwkfYcXEBf97@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <YXvIIwkfYcXEBf97@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 29.10.2021 11:08, Russell King (Oracle) wrote:
>On Thu, Oct 28, 2021 at 12:36:58PM -0700, Pawan Gupta wrote:
>> Isn't ARM already using CPU_SPECTRE for selecting things:
>>
>> 	config HARDEN_BRANCH_PREDICTOR
>> 	     bool "Harden the branch predictor against aliasing attacks" if EXPERT
>> 	     depends on CPU_SPECTRE
>>
>> This was the whole motivation for doing the same for x86.
>>
>> Adding a condition for all architectures is also okay, but its going to
>> a little messier:
>>
>> 	 config BPF_UNPRIV_DEFAULT_OFF
>> 	        default y if X86 || ARM || ...
>
>It doesn't have to be (but sadly we end up repeating "DEFAULT"):
>
>config BPF_UNPRIV_DEFAULT_OFF_DEFAULT
>	bool
>
>config BPF_UNPRIV_DEFAULT_OFF
>	bool "Disable unprivileged BPF by default"
>	default BPF_UNPRIV_DEFAULT_OFF_DEFAULT
>
>Then architectures can select BPF_UNPRIV_DEFAULT_OFF_DEFAULT if they
>wish this to be defaulted to "yes".

Looks like we are settling on unconditional 'default y' for now [1].
I have sent a v3 with 'default y' [2].

>However, please note that this has limited use given that the
>BPF_UNPRIV_DEFAULT_OFF option has been around for a while now. Any
>existing configuration that mentions this symbol will override any
>default specified in the Kconfig files if the option is user-visible.

Yes, existing configurations will have to toggle this manually. However,
many distros already have BPF_UNPRIV_DEFAULT_OFF=y in their
configuration.

>So, IMHO, defaults need to be set correctly from the point in time
>that the option is introduced.

Agree.

[1] https://lore.kernel.org/lkml/6130e55f-4d84-5ada-4e86-5b678e3eaf5e@iogearbox.net/
[2] https://lore.kernel.org/lkml/0ace9ce3f97656d5f62d11093ad7ee81190c3c25.1635535215.git.pawan.kumar.gupta@linux.intel.com/
