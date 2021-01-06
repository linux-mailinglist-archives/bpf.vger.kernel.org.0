Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D3C2EC707
	for <lists+bpf@lfdr.de>; Thu,  7 Jan 2021 00:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbhAFXnF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jan 2021 18:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbhAFXnF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jan 2021 18:43:05 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28F7C061786;
        Wed,  6 Jan 2021 15:42:24 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id d37so4469427ybi.4;
        Wed, 06 Jan 2021 15:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZPW74S8PzIlFk41Z9RviD5za69Jyj385qTRgrriyRfQ=;
        b=S0kMVmMOEkQuiA3qikpKc4BMjBTXdDJdlK4bFcFIkkYzMyXw4OGfqMK/L508rfLHN+
         d07j69i0GzAyIlulGof/vefhHNdMSYnOExlI7aFxmzXjUyC7J+rmfDFhBelv5EM1I0JB
         KfcxUapS1h9X79msPZZP5HGqO9iEbFoO8Kt40Hllj08b07DHHgHmjNbGKhkZOmgpz/az
         +oXjzK85Rh9TqNw8m/rds/5oaAFe0X2j12Dx9ppDNqS8whTRpkihI5RFO+0sZuferHLu
         XYy5fHr7ET8CcjiP76AcCv/7c3/OKmM5ICR1T+lrp7XYxGgw4BRHluICdgOFqlqCUxPC
         HK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZPW74S8PzIlFk41Z9RviD5za69Jyj385qTRgrriyRfQ=;
        b=ch0PLpwJGeUt/X/7VhjM4/M2ASIGg457leN6AZsQzPUsJMTdEo3af/rQerrrYUIRyf
         fnDhX7AIvR/MXn0F3KLzcPoVM1NzsMex6liCRX5dhL08nwSyPP8T9QA2M1NMBR5yNngY
         STocRqzYsISqlTCnOYxCC2Bm4jRM0cEl5YRKCHvIm2iDcRAiKWo9BPBZwNR60cMi02Wi
         /iejnahN9oiBfO9dkZ8SGPdBS6sBMaTwTn6ZF2m1SmtV2UMmNh654wN31za3bqge7oTE
         PUU6HAwQl+8zRBJiyBMJOtwpOC4iTCHyxfJ+O0lMuQWJMwkd82fSTZvFTkY/M1aSNTeP
         VeOA==
X-Gm-Message-State: AOAM531KbbZz67simAB4B687Zi3Xw0ha/MLKNv0eN14UzD7LXcoW35OU
        ovaTSpc0VZPcgiepZ8879OvHkE+ZBXaMIJQH7n8=
X-Google-Smtp-Source: ABdhPJxVTeXuACDNbhp+4/Qf0sV9wAp5WcMb5z/EiaVR+M1N+WTuS1/M6QqTnsmwZM9Kw3DRLLUJrQQjBTyXWMtMCZ8=
X-Received: by 2002:a25:854a:: with SMTP id f10mr9115524ybn.510.1609976544040;
 Wed, 06 Jan 2021 15:42:24 -0800 (PST)
MIME-Version: 1.0
References: <1e806d48-fd54-fd86-5b3a-372d9876f360@arm.com> <20200828172658.dxygk7j672gho4ax@e107158-lin.cambridge.arm.com>
 <58f5d2e8-493b-7ce1-6abd-57705e5ab437@arm.com> <20200902135423.GB93959@lorien.usersys.redhat.com>
 <20200907110223.gtdgqod2iv2w7xmg@e107158-lin.cambridge.arm.com>
 <20200908131954.GA147026@lorien.usersys.redhat.com> <20210104182642.xglderapsfrop6pi@e107158-lin>
 <CAADnVQ+1BNO577iz+05M4nNk+DB2n9ffwr4KrktWxO+2mP1b-Q@mail.gmail.com>
 <20210105113857.gzqaiuhxsxdtu474@e107158-lin> <CAADnVQ+GH9DfaRJ3CCDYL8o9UUH-eAuBq6EhjVLbicY_XWbySw@mail.gmail.com>
 <20210106112712.6ec7yejhidauo432@e107158-lin>
In-Reply-To: <20210106112712.6ec7yejhidauo432@e107158-lin>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 6 Jan 2021 15:42:13 -0800
Message-ID: <CAEf4BzaL8788pNdk4A9_EGTZF52MikCPJX1-fh3JO2uca6x9FQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched/debug: Add new tracepoint to track cpu_capacity
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Phil Auld <pauld@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        vincent.donnefort@arm.com, Ingo Molnar <mingo@redhat.com>,
        vincent.guittot@linaro.org, LKML <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 6, 2021 at 3:27 AM Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 01/05/21 08:44, Alexei Starovoitov wrote:
> > > Any pointer to an example test I could base this on?
> >
> > selftests/bpf/
>
> I was hoping for something more elaborate. I thought there's something already
> there that do some verification for raw tracepoint that I could either extend
> or replicate. Otherwise this could end up being a time sink for me and I'm not
> keen on jumping down this rabbit hole.

One way would be to add either another custom tracepoint definition to
a test module or modify the existing one to be a bare tracepoint. See
links below.

If it's easy to trigger those tracepoints from user-space on demand,
writing a similar (to module_attach) selftest for in-kernel tracepoint
is trivial.

  [0] https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
  [1] https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/progs/test_module_attach.c#L12-L18
  [2] https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/prog_tests/module_attach.c

>
> > > > - add a doc with contents from commit log.
> > >
> > > You're referring to the ABI part of the changelog, right?
> > >
> > > > The "Does bpf make things into an abi ?" question keeps coming back
> > > > over and over again.
> > > > Everytime we have the same answer that No, bpf cannot bake things into abi.
> > > > I think once it's spelled out somewhere in Documentation/ it would be easier to
> > > > repeat this message.
> > >
> > > How about a new Documentation/bpf/ABI.rst? I can write something up initially
> > > for us to discuss in detail when I post.
> >
> > There is Documentation/bpf/bpf_design_QA.rst
> > and we already have this text in there that was added back in 2017:
> >
> > Q: Does BPF have a stable ABI?
> > ------------------------------
> > A: YES. BPF instructions, arguments to BPF programs, set of helper
> > functions and their arguments, recognized return codes are all part
> > of ABI. However there is one specific exception to tracing programs
> > which are using helpers like bpf_probe_read() to walk kernel internal
> > data structures and compile with kernel internal headers. Both of these
> > kernel internals are subject to change and can break with newer kernels
> > such that the program needs to be adapted accordingly.
> >
> > I'm suggesting to add an additional section to this Q/A doc to include
> > more or less
> > the same text you had in the commit log.
>
> Works for me.
>
> Thanks
>
> --
> Qais Yousef
