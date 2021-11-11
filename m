Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD9044DB2A
	for <lists+bpf@lfdr.de>; Thu, 11 Nov 2021 18:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbhKKRgj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 12:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbhKKRgj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Nov 2021 12:36:39 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B574C061766
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 09:33:50 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1mlDxM-0001JY-7v; Thu, 11 Nov 2021 18:33:48 +0100
Message-ID: <8de74135-f272-ea06-fed6-730937f348d1@leemhuis.info>
Date:   Thu, 11 Nov 2021 18:33:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: Verifier rejects previously accepted program
Content-Language: en-BW
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>
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
 <b1b8bf55-1db5-3343-29da-d284a33d10d4@leemhuis.info>
 <CACAyw9-=JM9OeabH-xSaa00SzXUTzXkSN6A4nBY5Te8TD7RK3A@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CACAyw9-=JM9OeabH-xSaa00SzXUTzXkSN6A4nBY5Te8TD7RK3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1636652030;6f9a21e8;
X-HE-SMSGID: 1mlDxM-0001JY-7v
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11.11.21 18:10, Lorenz Bauer wrote:
> On Wed, 10 Nov 2021 at 19:50, Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
>>
>>>
>>> I don't think you're familiar with bpf process of applying patches.
>>
>> That's totally correct, but why should someone working as a regression
>> tracker for all of the Linux kernel has to know the exact inner workings
>> of all the various subsystems?
> 
> I think I'm responsible for a misunderstanding between you and Alexei,
> sorry. I saw your regression tracker mentioned, and wanted to give it
> a try.

Many thx for that. You were the first person besides me to give it a try
since it ran for real (and everything worked as it was supposed to),
that's why I on twitter already promised to get you a beer or other
beverage of choice should we ever meet on a conference. :-)

> Alexei wasn't aware of this and therefore lacked context when
> you replied.

Well, I think the mail explained it, but I guess it was a bit too long,
complicated, or something like that. Whatever, no worries. :-D

> For the purpose of this report I'll send an email to regzbot when the
> commit has made its way into the bpf tree. I hope this works for you
> and Alexei.

Sure it does, many thx!

Ciao, Thorsten
