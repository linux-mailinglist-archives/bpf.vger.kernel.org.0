Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B74644C97B
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 20:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbhKJTwt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 14:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbhKJTws (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Nov 2021 14:52:48 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE0BC061766
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 11:50:00 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1mktba-0006uQ-AI; Wed, 10 Nov 2021 20:49:58 +0100
Message-ID: <b1b8bf55-1db5-3343-29da-d284a33d10d4@leemhuis.info>
Date:   Wed, 10 Nov 2021 20:49:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: Verifier rejects previously accepted program
Content-Language: en-BW
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
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
 <7e7f180c-6cf6-ba86-e8fd-49b3b291e81e@leemhuis.info>
 <CAADnVQ+1xY2fGKH2=VxeukSwBUc0D=+6ChqCgwEMPGMPKeKiOA@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CAADnVQ+1xY2fGKH2=VxeukSwBUc0D=+6ChqCgwEMPGMPKeKiOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1636573800;0421b2f7;
X-HE-SMSGID: 1mktba-0006uQ-AI
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10.11.21 20:16, Alexei Starovoitov wrote:
> On Wed, Nov 10, 2021 at 10:01 AM Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
>> On 10.11.21 17:50, Alexei Starovoitov wrote:
>>> On Wed, Nov 10, 2021 at 11:41:09AM +0000, Lorenz Bauer wrote:
>>>>
>>>> uid changes on every invocation, and therefore regsafe() returns false?
>>>
>>> That's correct.
>>> Could you please try the following fix.
>>> I think it's less risky and more accurate than what I've tried before.
>>>
>>> >From be7736582945b56e88d385ddd4a05e13e4bc6784 Mon Sep 17 00:00:00 2001
>>> From: Alexei Starovoitov <ast@kernel.org>
>>> Date: Wed, 10 Nov 2021 08:47:52 -0800
>>> Subject: [PATCH] bpf: Fix inner map state pruning regression.
>>>
>>> Fixes: 3e8ce29850f1 ("bpf: Prevent pointer mismatch in bpf_timer_init.")
>>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>>
>> Thanks for working on a fix for this regression. There is one small
>> detail that afaics could be improved (maybe you left that for later, if
>> that's the case please simply stop reading and ignore this mail):
>>
>> The commit message would benefit from a link to the regression report.
>> This is explained in Documentation/process/submitting-patches.rst, which
>> recently was changed slightly to make this aspect clearer:
>> https://git.kernel.org/linus/1f57bd42b77c
> 
> I don't think you're familiar with bpf process of applying patches.

That's totally correct, but why should someone working as a regression
tracker for all of the Linux kernel has to know the exact inner workings
of all the various subsystems?

> Please take a look at bpf tree. The 'Link:' exists for every commit.

One of us is missing something. I might be wrong, but you afaics mean
that every commit has a 'Link:' to the latest review posting added when
a patch is committed. Many thx for that, I really like that, as it made
my life easier a few times in the past already.

But that was not what I was asking got. I was asking for a 'Link:' to
the *regression report*. To quote myself again from above:

>> The commit message would benefit from a link to the regression report.
>> [...] https://git.kernel.org/linus/1f57bd42b77c

To quote from there:
```
In case your patch fixes a bug, for example, add a tag with a URL
referencing the report in the mailing list archives or a bug tracker
````

Or what am I missing? Ciao, Thorsten
