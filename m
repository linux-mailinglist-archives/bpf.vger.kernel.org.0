Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8738B440006
	for <lists+bpf@lfdr.de>; Fri, 29 Oct 2021 18:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhJ2QJC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Oct 2021 12:09:02 -0400
Received: from www62.your-server.de ([213.133.104.62]:35914 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhJ2QJB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Oct 2021 12:09:01 -0400
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mgUNm-0000k3-R8; Fri, 29 Oct 2021 18:05:30 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mgUNm-000NUT-9w; Fri, 29 Oct 2021 18:05:30 +0200
Subject: Re: [PATCH v2 1/2] arch/Kconfig: Make CONFIG_CPU_SPECTRE available
 for all architectures
To:     Mark Rutland <mark.rutland@arm.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
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
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org
References: <cover.1635383031.git.pawan.kumar.gupta@linux.intel.com>
 <232b692cd79e4f6e4c3ee7055b5f02792a28d2c4.1635383031.git.pawan.kumar.gupta@linux.intel.com>
 <20211028134918.GB48435@lakrids.cambridge.arm.com>
 <20211028193658.7n2oehp6yogyqbwq@gupta-dev2.localdomain>
 <20211029092248.GA24060@lakrids.cambridge.arm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6130e55f-4d84-5ada-4e86-5b678e3eaf5e@iogearbox.net>
Date:   Fri, 29 Oct 2021 18:05:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20211029092248.GA24060@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26337/Fri Oct 29 10:19:12 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/29/21 11:22 AM, Mark Rutland wrote:
> On Thu, Oct 28, 2021 at 12:36:58PM -0700, Pawan Gupta wrote:
>> On 28.10.2021 14:49, Mark Rutland wrote:
>>> On Wed, Oct 27, 2021 at 06:33:22PM -0700, Pawan Gupta wrote:
>>>> Borrow CONFIG_CPU_SPECTRE from ARM to be available for all
>>>> architectures. This will help in configuration of features that depend
>>>> on CPU being affected by spectre class of vulnerabilities.
>>>>
>>>> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
>>>
>>> Given that spectre isn't one specific issue, biut rather a blanket term
>>> for a bunch of things that can have variable overlap, I don't think this
>>> makes much sense unless we're going to add finer-grained options for all
>>> the variants, and IMO it'd make more sene for the architectures to
>>> directly select the things that'd otherwise be dependent on this.
>>
>> Isn't ARM already using CPU_SPECTRE for selecting things:
>>
>> 	config HARDEN_BRANCH_PREDICTOR
>> 	     bool "Harden the branch predictor against aliasing attacks" if EXPERT
>> 	     depends on CPU_SPECTRE
> 
> It's true that arch/arm does, but that's not true for other
> architectures, e.g. powerpc or arm64, and and as above I don't think it
> makes sense to make this generic in its current form because "spectre"
> is a somewhat vague generic term.
> 
>> This was the whole motivation for doing the same for x86.
>>
>> Adding a condition for all architectures is also okay, but its going to
>> a little messier:
>>
>> 	 config BPF_UNPRIV_DEFAULT_OFF
>> 	        default y if X86 || ARM || ...
>>
>> This approach would make sense if architectures wants to explicitly
>> select the defaults irrespective of architecture being affected by
>> spectre.
> 
> If we're going to change the default for some architectures, I think
> it'd make much more sense to just do that for all, without any
> arch-specific conditionality, i.e.
> 
> 	config BPF_UNPRIV_DEFAULT_OFF
> 		default y

Lets just go with 'default y'. The main rationale for this change was motivated
by spectre, so would have been good to indicate this also with an explicit
dependency for broken HW, not just help description. Pretty much agreeing with
Greg here [0]. Eventually, we might need some arch generic way to determine arch-
common spectre type bugs, so that for unaffected HW we don't need to apply some
of them from verifier, but that's still tbd.

Thanks,
Daniel

   [0] https://lore.kernel.org/bpf/YXrTev6WMXry9pFI@kroah.com/
