Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2A943F9BC
	for <lists+bpf@lfdr.de>; Fri, 29 Oct 2021 11:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhJ2JZ2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Oct 2021 05:25:28 -0400
Received: from foss.arm.com ([217.140.110.172]:36244 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbhJ2JZ0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Oct 2021 05:25:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15AEA1FB;
        Fri, 29 Oct 2021 02:22:58 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F9153F5A1;
        Fri, 29 Oct 2021 02:22:54 -0700 (PDT)
Date:   Fri, 29 Oct 2021 10:22:49 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
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
Message-ID: <20211029092248.GA24060@lakrids.cambridge.arm.com>
References: <cover.1635383031.git.pawan.kumar.gupta@linux.intel.com>
 <232b692cd79e4f6e4c3ee7055b5f02792a28d2c4.1635383031.git.pawan.kumar.gupta@linux.intel.com>
 <20211028134918.GB48435@lakrids.cambridge.arm.com>
 <20211028193658.7n2oehp6yogyqbwq@gupta-dev2.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028193658.7n2oehp6yogyqbwq@gupta-dev2.localdomain>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 28, 2021 at 12:36:58PM -0700, Pawan Gupta wrote:
> On 28.10.2021 14:49, Mark Rutland wrote:
> > On Wed, Oct 27, 2021 at 06:33:22PM -0700, Pawan Gupta wrote:
> > > Borrow CONFIG_CPU_SPECTRE from ARM to be available for all
> > > architectures. This will help in configuration of features that depend
> > > on CPU being affected by spectre class of vulnerabilities.
> > > 
> > > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > 
> > Given that spectre isn't one specific issue, biut rather a blanket term
> > for a bunch of things that can have variable overlap, I don't think this
> > makes much sense unless we're going to add finer-grained options for all
> > the variants, and IMO it'd make more sene for the architectures to
> > directly select the things that'd otherwise be dependent on this.
> 
> Isn't ARM already using CPU_SPECTRE for selecting things:
> 
> 	config HARDEN_BRANCH_PREDICTOR
> 	     bool "Harden the branch predictor against aliasing attacks" if EXPERT
> 	     depends on CPU_SPECTRE

It's true that arch/arm does, but that's not true for other
architectures, e.g. powerpc or arm64, and and as above I don't think it
makes sense to make this generic in its current form because "spectre"
is a somewhat vague generic term.

> This was the whole motivation for doing the same for x86.
> 
> Adding a condition for all architectures is also okay, but its going to
> a little messier:
> 
> 	 config BPF_UNPRIV_DEFAULT_OFF
> 	        default y if X86 || ARM || ...
> 
> This approach would make sense if architectures wants to explicitly
> select the defaults irrespective of architecture being affected by
> spectre.

If we're going to change the default for some architectures, I think
it'd make much more sense to just do that for all, without any
arch-specific conditionality, i.e.

	config BPF_UNPRIV_DEFAULT_OFF
		default y

... so that the behaviour is consistent across all architectures, and we
don't have to play a whack-a-mole game as/when we realise architectures
are affected by some variant of an issue relating to speculation.

Thanks,
Mark.
