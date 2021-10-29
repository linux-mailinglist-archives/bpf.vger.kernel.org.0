Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755B343FA7D
	for <lists+bpf@lfdr.de>; Fri, 29 Oct 2021 12:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhJ2KLo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Oct 2021 06:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbhJ2KLn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Oct 2021 06:11:43 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E6CC061570;
        Fri, 29 Oct 2021 03:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ICtj6ogNyiHAyDVvU5WU0rRuxqqKqIKm4Rfph+OeZJI=; b=I2+F69JKN1g+B2lCz2qi+ZBdAz
        mcu/a60RI7RC6xmkiKqcChhPQRiKwIj0H0sNvSgwDNRMh0a/QlVo+Kni8FwOuAXPOehg9lzZYNZOr
        FHmp4uRSL62a7onzZsbZkaRBi/FhyjyatvHZFYbg3N+IzR6vnrlRxjvJyDQNCKOGSsaL1e2C5rAuG
        awSm1bd+Jx1i7T5iyAz9MaT551akL5h9suGc7W56mlQTsQHYRd8vYElvrpuGG5YPc8pLUPtWAbTfg
        ioYrClf4s73ZwTLuRgF0XeCjfzzUIfeqQ84Jl87pLlmU8qgTPK/0y5mzqO1xwvhDIo3BJJ8Br9DY/
        NIDObfJA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55380)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mgOoV-0008UB-0L; Fri, 29 Oct 2021 11:08:43 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mgOoN-0001W3-TQ; Fri, 29 Oct 2021 11:08:35 +0100
Date:   Fri, 29 Oct 2021 11:08:35 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
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
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arch/Kconfig: Make CONFIG_CPU_SPECTRE available
 for all architectures
Message-ID: <YXvIIwkfYcXEBf97@shell.armlinux.org.uk>
References: <cover.1635383031.git.pawan.kumar.gupta@linux.intel.com>
 <232b692cd79e4f6e4c3ee7055b5f02792a28d2c4.1635383031.git.pawan.kumar.gupta@linux.intel.com>
 <20211028134918.GB48435@lakrids.cambridge.arm.com>
 <20211028193658.7n2oehp6yogyqbwq@gupta-dev2.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028193658.7n2oehp6yogyqbwq@gupta-dev2.localdomain>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 28, 2021 at 12:36:58PM -0700, Pawan Gupta wrote:
> Isn't ARM already using CPU_SPECTRE for selecting things:
> 
> 	config HARDEN_BRANCH_PREDICTOR
> 	     bool "Harden the branch predictor against aliasing attacks" if EXPERT
> 	     depends on CPU_SPECTRE
> 
> This was the whole motivation for doing the same for x86.
> 
> Adding a condition for all architectures is also okay, but its going to
> a little messier:
> 
> 	 config BPF_UNPRIV_DEFAULT_OFF
> 	        default y if X86 || ARM || ...

It doesn't have to be (but sadly we end up repeating "DEFAULT"):

config BPF_UNPRIV_DEFAULT_OFF_DEFAULT
	bool

config BPF_UNPRIV_DEFAULT_OFF
	bool "Disable unprivileged BPF by default"
	default BPF_UNPRIV_DEFAULT_OFF_DEFAULT

Then architectures can select BPF_UNPRIV_DEFAULT_OFF_DEFAULT if they
wish this to be defaulted to "yes".

However, please note that this has limited use given that the
BPF_UNPRIV_DEFAULT_OFF option has been around for a while now. Any
existing configuration that mentions this symbol will override any
default specified in the Kconfig files if the option is user-visible.

So, IMHO, defaults need to be set correctly from the point in time
that the option is introduced.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
