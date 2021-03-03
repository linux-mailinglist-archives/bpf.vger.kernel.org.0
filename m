Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3590632C1D1
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449647AbhCCWxG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:53:06 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:39057 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235508AbhCCSWC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Mar 2021 13:22:02 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4DF44580272;
        Wed,  3 Mar 2021 13:11:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 03 Mar 2021 13:11:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm2; bh=R
        G1V6+KyPgUrPQt1cGsfMCiGS9LQ7Gy572gXAWOD3F8=; b=FWLUkYNoPVnGT1uBS
        Q3vfTpPFcjRBP0ItlmpKPA7FEh2gInJdu0TbIonUpyBtc64tirRusc7bv1XyQZFi
        kNNvCKiKSTdyc3Y+baURuAFiNHUQxJZVnOSnDO1nuAkeHKkiOcWf4DnrkBkAdAiE
        y3Wyroh1jJ94Mqnmu8baQbNnos+4xvv45z7oQmDipuFFKFPNjEoRGB6U2+O0q77P
        n7Uth6nrgqKcUYpJg0Jxc+xFgxWdjC5Q4h0F+q4Pb1X48e0amgv4C5kfanxgv32H
        WQMWMp8dUiKROFVJ6cv67skRILo3gs53OSofLwWccQ8PGPl+JAiVqYNoGOv+cGGA
        zuObg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=RG1V6+KyPgUrPQt1cGsfMCiGS9LQ7Gy572gXAWOD3
        F8=; b=TgJYGJRGC+y4SQqYI8rB5HkySq+ErerVbjcW5YoIuIC4fSewqtwiX2wxp
        du6hCIMBgmUWjrxU1pogdcCSLvHRnPmCfSa6CiDSo962LNmhwi3GPqBBVFLSK9si
        IPB3GdCHAg9Oxc0OzqDgbjguFzzzm1YeaiUu3RTqWVfUK1tfbdXsGVwkHtACkjmg
        Y4ynUUOoyfgbhGEm/fbUdV+FEWF7USqpUflHaQxZKXzzK/1DlI8bGiZ525+4vrcf
        h7l9Ccd83qEOzQV5KPTuFsyNK8+8Jc3e7k33qv198fuxPRGYG25FrddtUe0Y1evd
        edV1V8f5z1wp+nQJ3u+iZGDger53Q==
X-ME-Sender: <xms:QtE_YKD2F2vaegFiJAOXxwPurULnQx7zZdkM6G8VN_dtbkPzZEbpHw>
    <xme:QtE_YEdDvaQ4UB-L-8e024WDyX2hCk_wthmECD_uOyf24o4kpxkSZ44SU_5HDMMIl
    5B2ACDZheEJ1BrQbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddtvddguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculddujedmnecujfgurhepfffhvffukfhfgggtugfgjgesthekredt
    tddtjeenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpedtjeefvefhgedutdfghfeiudfhvddvveegvdejhedvhfeg
    tdelleeltdfgffeljeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeeile
    drudekuddruddthedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:QtE_YKdkoGcM5AvREP5dWZGqRrUMtvTqrv0idJ6s2Weq6re9ZCq7bw>
    <xmx:QtE_YAjSV5e5YC0yFpcGhvKmNB4pqu1GT5Z0zsV2jhBnreLjsBEiyA>
    <xmx:QtE_YOSmdvX3q1LkRDQ-VK7Q34YSnOGz7uS8kI_SwEWEe-rC4rBHOA>
    <xmx:Q9E_YKPj7fFWFASGS4YmdB3xiYjr6CCfuKnhP4SMRg_vFk_pfCVJfQ>
Received: from maharaja.localdomain (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id EB391240065;
        Wed,  3 Mar 2021 13:11:12 -0500 (EST)
Date:   Wed, 3 Mar 2021 10:11:11 -0800
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>, bpf <bpf@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: Why do kprobes and uprobes singlestep?
Message-ID: <20210303181111.th5ukrfzrmyuvk5x@maharaja.localdomain>
References: <CAADnVQJtpvB8wDFv46O0GEaHkwmT1Ea70BJfgS36kDX0u4uZ-g@mail.gmail.com>
 <968E85AE-75B8-42D7-844A-0D61B32063B3@amacapital.net>
 <CAADnVQJoTMqWK=kNFyTbjhoo22QD81KXnPxUjiCXhQaNhbK+8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJoTMqWK=kNFyTbjhoo22QD81KXnPxUjiCXhQaNhbK+8A@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 02, 2021 at 06:18:23PM -0800, Alexei Starovoitov wrote:
> On Tue, Mar 2, 2021 at 5:46 PM Andy Lutomirski <luto@amacapital.net> wrote:
> >
> >
> > > On Mar 2, 2021, at 5:22 PM, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > >
> > > ﻿On Tue, Mar 2, 2021 at 1:02 PM Andy Lutomirski <luto@amacapital.net> wrote:
> > >>
> > >>
> > >>>> On Mar 2, 2021, at 12:24 PM, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > >>>
> > >>> ﻿On Tue, Mar 2, 2021 at 10:38 AM Andy Lutomirski <luto@kernel.org> wrote:
> > >>>>
> > >>>> Is there something like a uprobe test suite?  How maintained /
> > >>>> actively used is uprobe?
> > >>>
> > >>> uprobe+bpf is heavily used in production.
> > >>> selftests/bpf has only one test for it though.
> > >>>
> > >>> Why are you asking?
> > >>
> > >> Because the integration with the x86 entry code is a mess, and I want to know whether to mark it BROKEN or how to make sure the any cleanups actually work.
> > >
> > > Any test case to repro the issue you found?
> > > Is it a bug or just messy code?
> >
> > Just messy code.
> >
> > > Nowadays a good chunk of popular applications (python, mysql, etc) has
> > > USDTs in them.
> > > Issues reported with bcc:
> > > https://github.com/iovisor/bcc/issues?q=is%3Aissue+USDT
> > > Similar thing with bpftrace.
> > > Both standard USDT and semaphore based are used in the wild.
> > > uprobe for containers has been a long standing feature request.
> > > If you can improve uprobe performance that would be awesome.
> > > That's another thing that people report often. We optimized it a bit.
> > > More can be done.
> >
> >
> > Wait... USDT is much easier to implement well.  Are we talking just USDT or are we talking about general uprobes in which almost any instruction can get probed?  If the only users that care about uprobes are doing USDT, we could vastly simplify the implementation and probably make it faster, too.
> 
> USDTs are driving the majority of uprobe usage.

I'd say 50/50 in my experience. Larger userspace applications using bpf
for production monitoring tend to use USDT for stability and ABI reasons
(hard for bpf to read C++ classes). Bare uprobes (ie not USDT) are used
quite often for ad-hoc production debugging.

> If they can get faster it will increase their adoption even more.
> There are certainly cases of normal uprobes.
> They are at the start of the function 99% of the time.
> Like the following:
> "uprobe:/lib64/libc.so:malloc(u64 size):size:size,_ret",
> "uprobe:/lib64/libc.so:free(void *ptr)::ptr",
> is common despite its overhead.
> 
> Here is the most interesting and practical usage of uprobes:
> https://github.com/iovisor/bcc/blob/master/tools/sslsniff.py
> and the manpage for the tool:
> https://github.com/iovisor/bcc/blob/master/tools/sslsniff_example.txt
> 
> uprobe in the middle of the function is very rare.
> If the kernel starts rejecting uprobes on some weird instructions
> I suspect no one will complain.

I think it would be great if the kernel could reject mid-instruction
uprobes. Unlike with kprobes, you can place uprobes on immediate
operands which can cause silent data corruption. See
https://github.com/iovisor/bpftrace/pull/803#issuecomment-507693933
for a funny example.

To prevent accidental (and silent) data corruption, bpftrace uses a
disassembler to ensure uprobes are placed on instruction boundaries.

<...>

Daniel
