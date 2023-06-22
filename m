Return-Path: <bpf+bounces-3127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC53739D8C
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 11:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0E981C21046
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 09:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2005246;
	Thu, 22 Jun 2023 09:38:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AF03AA91
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 09:38:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id A20763583;
	Thu, 22 Jun 2023 02:37:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 841161042;
	Thu, 22 Jun 2023 02:37:34 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.25.249])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CEE3F3F663;
	Thu, 22 Jun 2023 02:36:48 -0700 (PDT)
Date: Thu, 22 Jun 2023 10:36:45 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, song@kernel.org, catalin.marinas@arm.com,
	bpf@vger.kernel.org, kpsingh@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 3/3] bpf, arm64: use bpf_jit_binary_pack_alloc
Message-ID: <ZJQWLRq2zxyMXR4N@FVFF77S0Q05N>
References: <20230619100121.27534-1-puranjay12@gmail.com>
 <20230619100121.27534-4-puranjay12@gmail.com>
 <ZJMXqTffB22LSOkd@FVFF77S0Q05N>
 <CANk7y0h5ucxmMz4K8sGx7qogFyx6PRxYxmFtwTRO7=0Y=B4ugw@mail.gmail.com>
 <ZJQE9PIjxuA3Q8Sm@FVFF77S0Q05N>
 <CANk7y0jtm9yYobPLsMEHAem+R-wKjVOLWo=EeU-bojYks9tetQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANk7y0jtm9yYobPLsMEHAem+R-wKjVOLWo=EeU-bojYks9tetQ@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 10:47:08AM +0200, Puranjay Mohan wrote:
> On Thu, Jun 22, 2023 at 10:23 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > On Wed, Jun 21, 2023 at 10:57:20PM +0200, Puranjay Mohan wrote:

> > > When I move the call to bpf_flush_icache() after
> > > bpf_jit_binary_pack_finalize() (this does the copy to ro_header), the
> > > boot issue is fixed. Would this change be enough to make this work or I
> > > would need to do more with the data cache as well to catch other edge
> > > cases?
> >
> > AFAICT, bpf_flush_icache() calls flush_icache_range(). Despite its name,
> > flush_icache_range() has d-cache maintenance, i-cache maintenance, and context
> > synchronization (i.e. it does everything necessary).
> >
> > As long as you call that with the VAs the code will be executed from, that
> > should be sufficient, and you don't need to do any other work.
> 
> Thanks for explaining this.
> After reading your explanation, I feel this should work.
> 
> bpf_jit_binary_pack_finalize() will copy the instructions from
> rw_header to ro_header.
> After the copy, calling bpf_flush_icache(ro_header, ctx.ro_image +
> ctx.idx); will invalidate the caches
> for the VAs in the ro_header, this is where the code will be executed from.
> 
> I will send the v4 patchset with this change.

Sure -- I'll be happy to review that.

Mark.

