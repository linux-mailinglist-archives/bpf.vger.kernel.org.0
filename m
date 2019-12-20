Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C394F127F6E
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2019 16:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfLTPgw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Dec 2019 10:36:52 -0500
Received: from gentwo.org ([3.19.106.255]:47830 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727384AbfLTPgv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Dec 2019 10:36:51 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 22ECC3F872; Fri, 20 Dec 2019 15:36:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 222233EBB9;
        Fri, 20 Dec 2019 15:36:51 +0000 (UTC)
Date:   Fri, 20 Dec 2019 15:36:51 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Tejun Heo <tj@kernel.org>
cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        =?ISO-8859-15?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Dennis Zhou <dennis@kernel.org>
Subject: Re: Percpu variables, benchmarking, and performance weirdness
In-Reply-To: <20191220151239.GE2914998@devbig004.ftw2.facebook.com>
Message-ID: <alpine.DEB.2.21.1912201536120.16819@www.lameter.com>
References: <CAJ+HfNgNAzvdBw7gBJTCDQsne-HnWm90H50zNvXBSp4izbwFTA@mail.gmail.com> <20191220103420.6f9304ab@carbon> <20191220151239.GE2914998@devbig004.ftw2.facebook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 20 Dec 2019, Tejun Heo wrote:

> On Fri, Dec 20, 2019 at 10:34:20AM +0100, Jesper Dangaard Brouer wrote:
> > > So, my question to the uarch/percpu folks out there: Why are percpu
> > > accesses (%gs segment register) more expensive than regular global
> > > variables in this scenario.
> >
> > I'm also VERY interested in knowing the answer to above question!?
> > (Adding LKML to reach more people)
>
> No idea.  One difference is that percpu accesses are through vmap area
> which is mapped using 4k pages while global variable would be accessed
> through the fault linear mapping.  Maybe you're getting hit by tlb
> pressure?

And there are some accesses from remote processors to per cpu ares of
other cpus. If those are in the same cacheline then those will cause
additional latencies.

