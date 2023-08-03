Return-Path: <bpf+bounces-6838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5175A76E67B
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 13:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE78282017
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 11:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A44182B8;
	Thu,  3 Aug 2023 11:13:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A999156FB
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 11:13:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB69DE7D;
	Thu,  3 Aug 2023 04:13:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69F02113E;
	Thu,  3 Aug 2023 04:13:51 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.1.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FCAD3F6C4;
	Thu,  3 Aug 2023 04:13:06 -0700 (PDT)
Date: Thu, 3 Aug 2023 12:13:00 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Puranjay Mohan <puranjay12@gmail.com>,
	Florent Revest <revest@chromium.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	bpf <bpf@vger.kernel.org>, KP Singh <kpsingh@kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 0/3] bpf, arm64: use BPF prog pack allocator
 in BPF JIT
Message-ID: <ZMuLvKRbPfOK0IpN@FVFF77S0Q05N>
References: <20230626085811.3192402-1-puranjay12@gmail.com>
 <7e05efe1-0af0-1896-6f6f-dcb02ed8ca27@iogearbox.net>
 <ZKMCFtlfJA1LfGNJ@FVFF77S0Q05N>
 <CANk7y0gTXPBj5U-vFK0cEvVe83tP1FqyD=MuLXT_amWO=EssOA@mail.gmail.com>
 <CANk7y0hRYzpsYoqcU1tHyZThAgg-cx46C4-n2JYZTa7sDwEk-w@mail.gmail.com>
 <CAADnVQJJHiSZPZFpu1n-oQLEsUptacSzF7FdOKfO6OEoKz-jXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJJHiSZPZFpu1n-oQLEsUptacSzF7FdOKfO6OEoKz-jXg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Alexei,

On Wed, Aug 02, 2023 at 02:02:39PM -0700, Alexei Starovoitov wrote:
> On Sun, Jul 30, 2023 at 10:22 AM Puranjay Mohan <puranjay12@gmail.com> wrote:
> >
> > Hi Mark,
> > I am really looking forward to your feedback on this series.
> >
> > On Mon, Jul 17, 2023 at 9:50 AM Puranjay Mohan <puranjay12@gmail.com> wrote:
> > >
> > > Hi Mark,
> > >
> > > On Mon, Jul 3, 2023 at 7:15 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > > >
> > > > On Mon, Jul 03, 2023 at 06:40:21PM +0200, Daniel Borkmann wrote:
> > > > > Hi Mark,
> > > >
> > > > Hi Daniel,
> > > >
> > > > > On 6/26/23 10:58 AM, Puranjay Mohan wrote:
> > > > > > BPF programs currently consume a page each on ARM64. For systems with many BPF
> > > > > > programs, this adds significant pressure to instruction TLB. High iTLB pressure
> > > > > > usually causes slow down for the whole system.
> > > > > >
> > > > > > Song Liu introduced the BPF prog pack allocator[1] to mitigate the above issue.
> > > > > > It packs multiple BPF programs into a single huge page. It is currently only
> > > > > > enabled for the x86_64 BPF JIT.
> > > > > >
> > > > > > This patch series enables the BPF prog pack allocator for the ARM64 BPF JIT.
> > > >
> > > > > If you get a chance to take another look at the v4 changes from Puranjay and
> > > > > in case they look good to you reply with an Ack, that would be great.
> > > >
> > > > Sure -- this is on my queue of things to look at; it might just take me a few
> > > > days to get the time to give this a proper look.
> > > >
> > > > Thanks,
> > > > Mark.
> > >
> > > I am eagerly looking forward to your feedback on this series.
> 
> Mark, Catalin, Florent, KP,
> 
> This patch set was submitted on June 26 !

I appreciate this was sent a while ago, but I have been stuck on some urgent
bug-fixing for the last few weeks, and my review bandwidth is therfore very
limited.

Given Puranjay had previously told me he was doing this as a side project for
fun, and given no-one had told me this was urgent, I assumed that this wasn't a
major blocker and could wait.

I should have sent a holding reply to that effect; sorry.

The series addresses my original concern. However, in looking at it I think
there may me a wider potential isssue w.r.t. the way instruction memory gets
reused, because as writtten today the architecture doesn't seem to have a
guarantee on when instruction fetches are completed and therefore when it's
safe to modify instruction memory. Usually we're saved by TLB maintenance,
which this series avoids by design.

I unfortunately haven't had the time to dig into that, poke our architects,
etc.

So how urgent is this?

Thanks,
Mark.

