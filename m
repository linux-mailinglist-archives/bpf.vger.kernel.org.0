Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1AC132B31C
	for <lists+bpf@lfdr.de>; Wed,  3 Mar 2021 04:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352554AbhCCDvW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 22:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbhCCBXY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 20:23:24 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F17EC061794;
        Tue,  2 Mar 2021 17:22:43 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id u4so26494759ljh.6;
        Tue, 02 Mar 2021 17:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7vpxjdzLC35rO+JFayl4Y64pj7Iqa9C/mCMrzz7lHgk=;
        b=sFWqjyHdBwGvkKfUQ5i/8pSgB5aexxVlxIXA1/VUFSEnCPAOF4wk9XWWU75j0MeloQ
         ZsYVGBCEGmKNXG2VpVFMrflK9S4IQoGklTKmrznsrrXlzEZSY0OCe5xrR7bCH1ju8tiZ
         K80hyQJmWtroAevAgItdUVYc3ZLwPfE6NqeWcktCkJ0hOrDSGpcVZzpQxOA/ZkvRain3
         dnRIy7r1NcDxZ4DB69NWsR4QWxSjj9nrfeADfAqcc2MQ13UDkpEuGnfmf6/y/6VV06Vd
         NwK4uutAqeq3JmlD/H6oD06hrl33ZMj1SkogoaLC03pAz4L2B9YLM1wvy+jKN8PMOUcI
         Hj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7vpxjdzLC35rO+JFayl4Y64pj7Iqa9C/mCMrzz7lHgk=;
        b=g9xsDXSSAke0D9Hx0TS94hzqSL1MqAbBvXuvwXTSZyIPtnCgStqYVYU1QebwoOeor1
         xwT+yf38GkxfIv4ZVhsLTe+ZF5KooZlnEPTr8N+pavrlECHcTwIIkKg04ny91qacfCY7
         WiRazqCq4AZUYQq3BKfndVPigUnQ9M9ZjdbTwP4y8g0bqNCeus/TPOKMawv5ILxyeJad
         rl6S4LiS/3rpbLa5w//WPDYr3/tlNWLZUOwwSdUB7IbE6rlNW1V1zdTWg/GAuPfQIdBZ
         AJg21LSbJ8BqnxdPziYwnGDu0p7df/NdnbGPKXpQHCWVXfFzQLDt7zXVJBmJfrYaEvvz
         HhiA==
X-Gm-Message-State: AOAM530fMmwiassX51nKK45FlTVHUirogS+sFsKxNwsE8txdXBVOw2Lb
        CtNAOOt50ZJ8j3xfzgGZMu141IhUhEYbz4nWJPs=
X-Google-Smtp-Source: ABdhPJxrVUWH1j0C/T4fF8i6oqMI0C10dnbwznUUzx7+j4ufVOZ+cgRjqOKU0xGoatY6KXdfo78YHPlAe1AXdvoppT0=
X-Received: by 2002:a2e:9704:: with SMTP id r4mr13232071lji.486.1614734561822;
 Tue, 02 Mar 2021 17:22:41 -0800 (PST)
MIME-Version: 1.0
References: <CAADnVQ+czV6u4CM-A+o5U+WhApkocunZXiCMJBB_Zbs0mvNSwQ@mail.gmail.com>
 <EECBE373-7CA1-4ED8-9F03-406BBED607FD@amacapital.net>
In-Reply-To: <EECBE373-7CA1-4ED8-9F03-406BBED607FD@amacapital.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 2 Mar 2021 17:22:30 -0800
Message-ID: <CAADnVQJtpvB8wDFv46O0GEaHkwmT1Ea70BJfgS36kDX0u4uZ-g@mail.gmail.com>
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

On Tue, Mar 2, 2021 at 1:02 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
>
> > On Mar 2, 2021, at 12:24 PM, Alexei Starovoitov <alexei.starovoitov@gma=
il.com> wrote:
> >
> > =EF=BB=BFOn Tue, Mar 2, 2021 at 10:38 AM Andy Lutomirski <luto@kernel.o=
rg> wrote:
> >>
> >> Is there something like a uprobe test suite?  How maintained /
> >> actively used is uprobe?
> >
> > uprobe+bpf is heavily used in production.
> > selftests/bpf has only one test for it though.
> >
> > Why are you asking?
>
> Because the integration with the x86 entry code is a mess, and I want to =
know whether to mark it BROKEN or how to make sure the any cleanups actuall=
y work.

Any test case to repro the issue you found?
Is it a bug or just messy code?
Nowadays a good chunk of popular applications (python, mysql, etc) has
USDTs in them.
Issues reported with bcc:
https://github.com/iovisor/bcc/issues?q=3Dis%3Aissue+USDT
Similar thing with bpftrace.
Both standard USDT and semaphore based are used in the wild.
uprobe for containers has been a long standing feature request.
If you can improve uprobe performance that would be awesome.
That's another thing that people report often. We optimized it a bit.
More can be done.
