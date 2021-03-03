Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1F832B31A
	for <lists+bpf@lfdr.de>; Wed,  3 Mar 2021 04:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352556AbhCCDvX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 22:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbhCCCT0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 21:19:26 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC32C061756;
        Tue,  2 Mar 2021 18:18:36 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id n16so17635560lfb.4;
        Tue, 02 Mar 2021 18:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=egtW1xEkho3A0fHJs4T8Q3wqHZlHR2dIYNNBBCYiUac=;
        b=FUobsg7wBOcBHpapI84qYH9yKjxBf+uks2hqvfBzmbOzTNLZauAnZH8TbCmq1gahSK
         PR813mcbuOrMZv21tKfS4H0e3eZRWIktyVMZuMDHVHRAW/3+rRK0T9eP/EKce/61IA0e
         dMNgmW7r0PdIiKrtsooF0o2bJV6cSnI2yY4TWuMRDyQo1lyE6HMq7S48ejGkpKEujwM+
         DugXmlfCxNwh3EtlM8479V7nY+6dkLPhcDl1kK+68SyMeuhpGn/x4X5cRQy1BJ9bACO9
         28tknljA4Uxbc1voQ5u9M/qV6y83Fw2Ej3w4OqT6bb83ydRJoPr/Pez5PRkD0ik0LZ8R
         8bAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=egtW1xEkho3A0fHJs4T8Q3wqHZlHR2dIYNNBBCYiUac=;
        b=PAdbJ5x/zxPK7Ggk+hkytw4RxT7V/mv1gOH902ujl3Vd3S4d6YKW43OhXqIsCkik0+
         GCIhDy0b969u/YeefjXIjJze/piKuzi2qEwGG+sJoJ4vne6+gMr+tIKpkW+NrLCwsEjV
         qZKzzBH4QaF0rQreIsT7etyt1u4PBAywowcmwo4WxQQv8keO+SeI0Q8kGSdXwCPakIlj
         AYJTnWh/ShCe7PhN0TDAEDPDP5rQ/61TyBiP+2pMLZO5f82Rls7V5xxHYg1Bk3Fnbl4R
         s+5giJ2Hb3K15W8WIuXlnFsI0sJRtaKtLjqt/+rt3KOV8h39xYJusDdV2aok9OrA1d1X
         9iJQ==
X-Gm-Message-State: AOAM5304Q90QBNLbdnPZWtMKPqI7CNml4OX2wiDcvOzsAChO33saBc1R
        69GP/EBiEW4wAQfwPjoo3UHWAj8fTNJMLAAZZJd/wXvOiJc=
X-Google-Smtp-Source: ABdhPJxtav+vNkC2v0WvMCSBlXNyeV8AMCNvCZrnDeD2KXzQvYyYPY6G9FTxdfGOJRIHyuJmnoVeAIkwIAEriqYHA40=
X-Received: by 2002:a05:6512:2254:: with SMTP id i20mr14195241lfu.534.1614737914729;
 Tue, 02 Mar 2021 18:18:34 -0800 (PST)
MIME-Version: 1.0
References: <CAADnVQJtpvB8wDFv46O0GEaHkwmT1Ea70BJfgS36kDX0u4uZ-g@mail.gmail.com>
 <968E85AE-75B8-42D7-844A-0D61B32063B3@amacapital.net>
In-Reply-To: <968E85AE-75B8-42D7-844A-0D61B32063B3@amacapital.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 2 Mar 2021 18:18:23 -0800
Message-ID: <CAADnVQJoTMqWK=kNFyTbjhoo22QD81KXnPxUjiCXhQaNhbK+8A@mail.gmail.com>
Subject: Re: Why do kprobes and uprobes singlestep?
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>, bpf <bpf@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 2, 2021 at 5:46 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
>
> > On Mar 2, 2021, at 5:22 PM, Alexei Starovoitov <alexei.starovoitov@gmai=
l.com> wrote:
> >
> > =EF=BB=BFOn Tue, Mar 2, 2021 at 1:02 PM Andy Lutomirski <luto@amacapita=
l.net> wrote:
> >>
> >>
> >>>> On Mar 2, 2021, at 12:24 PM, Alexei Starovoitov <alexei.starovoitov@=
gmail.com> wrote:
> >>>
> >>> =EF=BB=BFOn Tue, Mar 2, 2021 at 10:38 AM Andy Lutomirski <luto@kernel=
.org> wrote:
> >>>>
> >>>> Is there something like a uprobe test suite?  How maintained /
> >>>> actively used is uprobe?
> >>>
> >>> uprobe+bpf is heavily used in production.
> >>> selftests/bpf has only one test for it though.
> >>>
> >>> Why are you asking?
> >>
> >> Because the integration with the x86 entry code is a mess, and I want =
to know whether to mark it BROKEN or how to make sure the any cleanups actu=
ally work.
> >
> > Any test case to repro the issue you found?
> > Is it a bug or just messy code?
>
> Just messy code.
>
> > Nowadays a good chunk of popular applications (python, mysql, etc) has
> > USDTs in them.
> > Issues reported with bcc:
> > https://github.com/iovisor/bcc/issues?q=3Dis%3Aissue+USDT
> > Similar thing with bpftrace.
> > Both standard USDT and semaphore based are used in the wild.
> > uprobe for containers has been a long standing feature request.
> > If you can improve uprobe performance that would be awesome.
> > That's another thing that people report often. We optimized it a bit.
> > More can be done.
>
>
> Wait... USDT is much easier to implement well.  Are we talking just USDT =
or are we talking about general uprobes in which almost any instruction can=
 get probed?  If the only users that care about uprobes are doing USDT, we =
could vastly simplify the implementation and probably make it faster, too.

USDTs are driving the majority of uprobe usage.
If they can get faster it will increase their adoption even more.
There are certainly cases of normal uprobes.
They are at the start of the function 99% of the time.
Like the following:
"uprobe:/lib64/libc.so:malloc(u64 size):size:size,_ret",
"uprobe:/lib64/libc.so:free(void *ptr)::ptr",
is common despite its overhead.

Here is the most interesting and practical usage of uprobes:
https://github.com/iovisor/bcc/blob/master/tools/sslsniff.py
and the manpage for the tool:
https://github.com/iovisor/bcc/blob/master/tools/sslsniff_example.txt

uprobe in the middle of the function is very rare.
If the kernel starts rejecting uprobes on some weird instructions
I suspect no one will complain.
Especially if such tightening will come with performance boost for
uprobe on a nop and unprobe at the start (which is typically push or
alu on %sp).
That would be a great step forward.
