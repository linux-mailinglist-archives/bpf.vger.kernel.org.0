Return-Path: <bpf+bounces-13962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93637DF742
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 17:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBB191C20F80
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 16:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1F41D55A;
	Thu,  2 Nov 2023 16:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718071D531
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 16:00:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A4E7186;
	Thu,  2 Nov 2023 09:00:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41DEC2F4;
	Thu,  2 Nov 2023 09:00:42 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.27.166])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45F3B3F738;
	Thu,  2 Nov 2023 08:59:58 -0700 (PDT)
Date: Thu, 2 Nov 2023 15:59:52 +0000
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
Message-ID: <ZUPHeEe1eJjHkhsg@FVFF77S0Q05N.cambridge.arm.com>
References: <20230626085811.3192402-1-puranjay12@gmail.com>
 <7e05efe1-0af0-1896-6f6f-dcb02ed8ca27@iogearbox.net>
 <ZKMCFtlfJA1LfGNJ@FVFF77S0Q05N>
 <CANk7y0gTXPBj5U-vFK0cEvVe83tP1FqyD=MuLXT_amWO=EssOA@mail.gmail.com>
 <CANk7y0hRYzpsYoqcU1tHyZThAgg-cx46C4-n2JYZTa7sDwEk-w@mail.gmail.com>
 <CAADnVQJJHiSZPZFpu1n-oQLEsUptacSzF7FdOKfO6OEoKz-jXg@mail.gmail.com>
 <ZMuLvKRbPfOK0IpN@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMuLvKRbPfOK0IpN@FVFF77S0Q05N>

On Thu, Aug 03, 2023 at 12:13:00PM +0100, Mark Rutland wrote:
[...]

> However, in looking at it I think
> there may me a wider potential isssue w.r.t. the way instruction memory gets
> reused, because as writtten today the architecture doesn't seem to have a
> guarantee on when instruction fetches are completed and therefore when it's
> safe to modify instruction memory. Usually we're saved by TLB maintenance,
> which this series avoids by design.

Just to confirm on this point specifically, per discussions with our
architects, the (architectural) execution of an instruction ensures that there
are no outstanding fetches for prior instructions. IIUC that will be clarified 
the next release of the ARM ARM.

So as long as we're certain all threads have left the old code (e.g. via a
flag, RCU tasks rude synchronization, whatever) before we overwrite slots in
the shared buffer, we should be good.

We will need to be very careful with the maintenance when installing new code
into the shared buffer (e.g. we will require an IPI to all other CPUs), but
that should be relatively simple.

I'll go review the latest patches with that in mind.

Thanks,
Mark.

