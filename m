Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC69144034C
	for <lists+bpf@lfdr.de>; Fri, 29 Oct 2021 21:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhJ2TiV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Oct 2021 15:38:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:51902 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231245AbhJ2TiT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Oct 2021 15:38:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10152"; a="316929805"
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="316929805"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 12:12:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="448215526"
Received: from gupta-dev2.jf.intel.com (HELO gupta-dev2.localdomain) ([10.54.74.119])
  by orsmga006.jf.intel.com with ESMTP; 29 Oct 2021 12:12:43 -0700
Date:   Fri, 29 Oct 2021 12:15:01 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
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
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arch/Kconfig: Make CONFIG_CPU_SPECTRE available
 for all architectures
Message-ID: <20211029191501.aqoqquexhrxcgsyg@gupta-dev2.localdomain>
References: <cover.1635383031.git.pawan.kumar.gupta@linux.intel.com>
 <232b692cd79e4f6e4c3ee7055b5f02792a28d2c4.1635383031.git.pawan.kumar.gupta@linux.intel.com>
 <20211028134918.GB48435@lakrids.cambridge.arm.com>
 <20211028193658.7n2oehp6yogyqbwq@gupta-dev2.localdomain>
 <20211029092248.GA24060@lakrids.cambridge.arm.com>
 <6130e55f-4d84-5ada-4e86-5b678e3eaf5e@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <6130e55f-4d84-5ada-4e86-5b678e3eaf5e@iogearbox.net>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 29.10.2021 18:05, Daniel Borkmann wrote:
>On 10/29/21 11:22 AM, Mark Rutland wrote:
>>On Thu, Oct 28, 2021 at 12:36:58PM -0700, Pawan Gupta wrote:
>>>On 28.10.2021 14:49, Mark Rutland wrote:
>>>>On Wed, Oct 27, 2021 at 06:33:22PM -0700, Pawan Gupta wrote:
>>>>>Borrow CONFIG_CPU_SPECTRE from ARM to be available for all
>>>>>architectures. This will help in configuration of features that depend
>>>>>on CPU being affected by spectre class of vulnerabilities.
>>>>>
>>>>>Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
>>>>
>>>>Given that spectre isn't one specific issue, biut rather a blanket term
>>>>for a bunch of things that can have variable overlap, I don't think this
>>>>makes much sense unless we're going to add finer-grained options for all
>>>>the variants, and IMO it'd make more sene for the architectures to
>>>>directly select the things that'd otherwise be dependent on this.
>>>
>>>Isn't ARM already using CPU_SPECTRE for selecting things:
>>>
>>>	config HARDEN_BRANCH_PREDICTOR
>>>	     bool "Harden the branch predictor against aliasing attacks" if EXPERT
>>>	     depends on CPU_SPECTRE
>>
>>It's true that arch/arm does, but that's not true for other
>>architectures, e.g. powerpc or arm64, and and as above I don't think it
>>makes sense to make this generic in its current form because "spectre"
>>is a somewhat vague generic term.
>>
>>>This was the whole motivation for doing the same for x86.
>>>
>>>Adding a condition for all architectures is also okay, but its going to
>>>a little messier:
>>>
>>>	 config BPF_UNPRIV_DEFAULT_OFF
>>>	        default y if X86 || ARM || ...
>>>
>>>This approach would make sense if architectures wants to explicitly
>>>select the defaults irrespective of architecture being affected by
>>>spectre.
>>
>>If we're going to change the default for some architectures, I think
>>it'd make much more sense to just do that for all, without any
>>arch-specific conditionality, i.e.
>>
>>	config BPF_UNPRIV_DEFAULT_OFF
>>		default y
>
>Lets just go with 'default y'. The main rationale for this change was motivated
>by spectre, so would have been good to indicate this also with an explicit
>dependency for broken HW, not just help description. Pretty much agreeing with
>Greg here [0]. Eventually, we might need some arch generic way to determine arch-
>common spectre type bugs, so that for unaffected HW we don't need to apply some
>of them from verifier, but that's still tbd.

I will send a patch soon with 'default y'.

Thanks,
Pawan
