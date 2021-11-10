Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4D144C695
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 19:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbhKJSEG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 13:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhKJSEF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Nov 2021 13:04:05 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE04C061764
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 10:01:17 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1mkruN-0000Aa-4Y; Wed, 10 Nov 2021 19:01:15 +0100
Message-ID: <7e7f180c-6cf6-ba86-e8fd-49b3b291e81e@leemhuis.info>
Date:   Wed, 10 Nov 2021 19:01:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-BW
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        bpf <bpf@vger.kernel.org>, regressions@lists.linux.dev,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <CACAyw99hVEJFoiBH_ZGyy=+oO-jyydoz6v1DeKPKs2HVsUH28w@mail.gmail.com>
 <CAADnVQKsK_2HHfOLs4XK7h_LC4+b7tfFw9261Psy5St8P+GWFA@mail.gmail.com>
 <CACAyw9_GmNotSyG0g1OOt648y9kx5Bd72f58TtS-QQD9FaV06w@mail.gmail.com>
 <20211105194952.xve6u6lgh2oy46dy@ast-mbp.dhcp.thefacebook.com>
 <CACAyw99KGdTAz+G3aU8G3eqC926YYpgD57q-A+NFNVqqiJPY3g@mail.gmail.com>
 <20211110042530.6ye65mpspre7au5f@ast-mbp.dhcp.thefacebook.com>
 <CACAyw9-s0ahY8m7WtMd1OK=ZF9w5gS9gktQ6S8Kak2pznXgw0w@mail.gmail.com>
 <20211110165044.kkjqrjpmnz7hkmq3@ast-mbp.dhcp.thefacebook.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: Verifier rejects previously accepted program
In-Reply-To: <20211110165044.kkjqrjpmnz7hkmq3@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1636567278;27cefafd;
X-HE-SMSGID: 1mkruN-0000Aa-4Y
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10.11.21 17:50, Alexei Starovoitov wrote:
> On Wed, Nov 10, 2021 at 11:41:09AM +0000, Lorenz Bauer wrote:
>>
>> uid changes on every invocation, and therefore regsafe() returns false?
> 
> That's correct.
> Could you please try the following fix.
> I think it's less risky and more accurate than what I've tried before.
> 
>>From be7736582945b56e88d385ddd4a05e13e4bc6784 Mon Sep 17 00:00:00 2001
> From: Alexei Starovoitov <ast@kernel.org>
> Date: Wed, 10 Nov 2021 08:47:52 -0800
> Subject: [PATCH] bpf: Fix inner map state pruning regression.
> 
> Fixes: 3e8ce29850f1 ("bpf: Prevent pointer mismatch in bpf_timer_init.")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Thanks for working on a fix for this regression. There is one small
detail that afaics could be improved (maybe you left that for later, if
that's the case please simply stop reading and ignore this mail):

The commit message would benefit from a link to the regression report.
This is explained in Documentation/process/submitting-patches.rst, which
recently was changed slightly to make this aspect clearer:
https://git.kernel.org/linus/1f57bd42b77c

E.g. add something like this

Link:
https://linux-regtracking.leemhuis.info/regzbot/regression/CACAyw99hVEJFoiBH_ZGyy=%2BoO-jyydoz6v1DeKPKs2HVsUH28w@mail.gmail.com/

Thanks in advance.

FWIW, in case anyone wonders why I'm asking for this: yes, that link is
not really crucial; but it's good to have if someone needs to look into
the backstory of this change sometime in the future. But I care for a
different reason. I'm tracking this regression (and others) with
regzbot, my relative new Linux kernel regression tracking bot. The entry
for this regression can be found at:
https://linux-regtracking.leemhuis.info/regzbot/regression/CACAyw99hVEJFoiBH_ZGyy=%2BoO-jyydoz6v1DeKPKs2HVsUH28w@mail.gmail.com/

This bot will notice if a patch with a Link: tag to a tracked regression
gets posted. It will record that and show a link in the web-interface,
which allows anyone looking into a regression to quickly gasp the
current status. The bot will also notice if a commit with a Link: tag to
a regression report is applied by Linus and then automatically mark the
regression as resolved then.

IOW: this tag makes my life easier, as I otherwise have to tell regzbot
manually about each and every fix for a regression manually. ;-)

Ciao, your Linux kernel regression tracker (Thorsten)
