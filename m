Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69C82EBD26
	for <lists+bpf@lfdr.de>; Wed,  6 Jan 2021 12:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbhAFL2C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jan 2021 06:28:02 -0500
Received: from foss.arm.com ([217.140.110.172]:39612 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbhAFL2C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jan 2021 06:28:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 974F1106F;
        Wed,  6 Jan 2021 03:27:16 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1337B3F719;
        Wed,  6 Jan 2021 03:27:14 -0800 (PST)
Date:   Wed, 6 Jan 2021 11:27:12 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Phil Auld <pauld@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        vincent.donnefort@arm.com, Ingo Molnar <mingo@redhat.com>,
        vincent.guittot@linaro.org, LKML <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH v2] sched/debug: Add new tracepoint to track cpu_capacity
Message-ID: <20210106112712.6ec7yejhidauo432@e107158-lin>
References: <1e806d48-fd54-fd86-5b3a-372d9876f360@arm.com>
 <20200828172658.dxygk7j672gho4ax@e107158-lin.cambridge.arm.com>
 <58f5d2e8-493b-7ce1-6abd-57705e5ab437@arm.com>
 <20200902135423.GB93959@lorien.usersys.redhat.com>
 <20200907110223.gtdgqod2iv2w7xmg@e107158-lin.cambridge.arm.com>
 <20200908131954.GA147026@lorien.usersys.redhat.com>
 <20210104182642.xglderapsfrop6pi@e107158-lin>
 <CAADnVQ+1BNO577iz+05M4nNk+DB2n9ffwr4KrktWxO+2mP1b-Q@mail.gmail.com>
 <20210105113857.gzqaiuhxsxdtu474@e107158-lin>
 <CAADnVQ+GH9DfaRJ3CCDYL8o9UUH-eAuBq6EhjVLbicY_XWbySw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAADnVQ+GH9DfaRJ3CCDYL8o9UUH-eAuBq6EhjVLbicY_XWbySw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 01/05/21 08:44, Alexei Starovoitov wrote:
> > Any pointer to an example test I could base this on?
> 
> selftests/bpf/

I was hoping for something more elaborate. I thought there's something already
there that do some verification for raw tracepoint that I could either extend
or replicate. Otherwise this could end up being a time sink for me and I'm not
keen on jumping down this rabbit hole.

> > > - add a doc with contents from commit log.
> >
> > You're referring to the ABI part of the changelog, right?
> >
> > > The "Does bpf make things into an abi ?" question keeps coming back
> > > over and over again.
> > > Everytime we have the same answer that No, bpf cannot bake things into abi.
> > > I think once it's spelled out somewhere in Documentation/ it would be easier to
> > > repeat this message.
> >
> > How about a new Documentation/bpf/ABI.rst? I can write something up initially
> > for us to discuss in detail when I post.
> 
> There is Documentation/bpf/bpf_design_QA.rst
> and we already have this text in there that was added back in 2017:
> 
> Q: Does BPF have a stable ABI?
> ------------------------------
> A: YES. BPF instructions, arguments to BPF programs, set of helper
> functions and their arguments, recognized return codes are all part
> of ABI. However there is one specific exception to tracing programs
> which are using helpers like bpf_probe_read() to walk kernel internal
> data structures and compile with kernel internal headers. Both of these
> kernel internals are subject to change and can break with newer kernels
> such that the program needs to be adapted accordingly.
> 
> I'm suggesting to add an additional section to this Q/A doc to include
> more or less
> the same text you had in the commit log.

Works for me.

Thanks

--
Qais Yousef
