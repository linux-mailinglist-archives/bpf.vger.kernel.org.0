Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFBA43E904
	for <lists+bpf@lfdr.de>; Thu, 28 Oct 2021 21:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhJ1ThK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Oct 2021 15:37:10 -0400
Received: from mga07.intel.com ([134.134.136.100]:11785 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230412AbhJ1ThJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Oct 2021 15:37:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="293958002"
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="293958002"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 12:34:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="498541872"
Received: from gupta-dev2.jf.intel.com (HELO gupta-dev2.localdomain) ([10.54.74.119])
  by orsmga008.jf.intel.com with ESMTP; 28 Oct 2021 12:34:41 -0700
Date:   Thu, 28 Oct 2021 12:36:58 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Russell King <linux@armlinux.org.uk>,
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
Message-ID: <20211028193658.7n2oehp6yogyqbwq@gupta-dev2.localdomain>
References: <cover.1635383031.git.pawan.kumar.gupta@linux.intel.com>
 <232b692cd79e4f6e4c3ee7055b5f02792a28d2c4.1635383031.git.pawan.kumar.gupta@linux.intel.com>
 <20211028134918.GB48435@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20211028134918.GB48435@lakrids.cambridge.arm.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 28.10.2021 14:49, Mark Rutland wrote:
>On Wed, Oct 27, 2021 at 06:33:22PM -0700, Pawan Gupta wrote:
>> Borrow CONFIG_CPU_SPECTRE from ARM to be available for all
>> architectures. This will help in configuration of features that depend
>> on CPU being affected by spectre class of vulnerabilities.
>>
>> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
>
>Given that spectre isn't one specific issue, biut rather a blanket term
>for a bunch of things that can have variable overlap, I don't think this
>makes much sense unless we're going to add finer-grained options for all
>the variants, and IMO it'd make more sene for the architectures to
>directly select the things that'd otherwise be dependent on this.

Isn't ARM already using CPU_SPECTRE for selecting things: 

	config HARDEN_BRANCH_PREDICTOR
	     bool "Harden the branch predictor against aliasing attacks" if EXPERT
	     depends on CPU_SPECTRE

This was the whole motivation for doing the same for x86.

Adding a condition for all architectures is also okay, but its going to
a little messier:

	 config BPF_UNPRIV_DEFAULT_OFF
	        default y if X86 || ARM || ... 

This approach would make sense if architectures wants to explicitly
select the defaults irrespective of architecture being affected by
spectre.

If that's the case I will change the BPF_UNPRIV_DEFAULT_OFF default to
depend on architecture. I hope BPF maintainer, Daniel is okay with it?

Pawan

Added BPF maintainers and bpf@vger to cc.
