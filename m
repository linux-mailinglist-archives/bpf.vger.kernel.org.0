Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584D42ECEB2
	for <lists+bpf@lfdr.de>; Thu,  7 Jan 2021 12:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbhAGLYe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jan 2021 06:24:34 -0500
Received: from foss.arm.com ([217.140.110.172]:58242 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbhAGLYe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jan 2021 06:24:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F3131FB;
        Thu,  7 Jan 2021 03:23:48 -0800 (PST)
Received: from e107158-lin (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81F4A3F719;
        Thu,  7 Jan 2021 03:23:46 -0800 (PST)
Date:   Thu, 7 Jan 2021 11:23:44 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
Subject: Re: [PATCH v2] sched/debug: Add new tracepoint to track cpu_capacity
Message-ID: <20210107112344.y73hmx3bg7cjkp53@e107158-lin>
References: <58f5d2e8-493b-7ce1-6abd-57705e5ab437@arm.com>
 <20200902135423.GB93959@lorien.usersys.redhat.com>
 <20200907110223.gtdgqod2iv2w7xmg@e107158-lin.cambridge.arm.com>
 <20200908131954.GA147026@lorien.usersys.redhat.com>
 <20210104182642.xglderapsfrop6pi@e107158-lin>
 <CAADnVQ+1BNO577iz+05M4nNk+DB2n9ffwr4KrktWxO+2mP1b-Q@mail.gmail.com>
 <20210105113857.gzqaiuhxsxdtu474@e107158-lin>
 <CAADnVQ+GH9DfaRJ3CCDYL8o9UUH-eAuBq6EhjVLbicY_XWbySw@mail.gmail.com>
 <20210106112712.6ec7yejhidauo432@e107158-lin>
 <CAEf4BzaL8788pNdk4A9_EGTZF52MikCPJX1-fh3JO2uca6x9FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4BzaL8788pNdk4A9_EGTZF52MikCPJX1-fh3JO2uca6x9FQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 01/06/21 15:42, Andrii Nakryiko wrote:
> On Wed, Jan 6, 2021 at 3:27 AM Qais Yousef <qais.yousef@arm.com> wrote:
> >
> > On 01/05/21 08:44, Alexei Starovoitov wrote:
> > > > Any pointer to an example test I could base this on?
> > >
> > > selftests/bpf/
> >
> > I was hoping for something more elaborate. I thought there's something already
> > there that do some verification for raw tracepoint that I could either extend
> > or replicate. Otherwise this could end up being a time sink for me and I'm not
> > keen on jumping down this rabbit hole.
> 
> One way would be to add either another custom tracepoint definition to
> a test module or modify the existing one to be a bare tracepoint. See
> links below.
> 
> If it's easy to trigger those tracepoints from user-space on demand,
> writing a similar (to module_attach) selftest for in-kernel tracepoint
> is trivial.
> 
>   [0] https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
>   [1] https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/progs/test_module_attach.c#L12-L18
>   [2] https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/prog_tests/module_attach.c

Thanks a lot Andrii. That will make it much easier to figure out something.

Cheers

--
Qais Yousef
