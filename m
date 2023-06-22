Return-Path: <bpf+bounces-3121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 146C1739962
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 10:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45BD91C21059
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 08:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6A215AFE;
	Thu, 22 Jun 2023 08:23:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0F913ADF
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 08:23:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2E6E2102;
	Thu, 22 Jun 2023 01:23:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18E791042;
	Thu, 22 Jun 2023 01:24:08 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.25.249])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67F413F663;
	Thu, 22 Jun 2023 01:23:22 -0700 (PDT)
Date: Thu, 22 Jun 2023 09:23:16 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, song@kernel.org, catalin.marinas@arm.com,
	bpf@vger.kernel.org, kpsingh@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 3/3] bpf, arm64: use bpf_jit_binary_pack_alloc
Message-ID: <ZJQE9PIjxuA3Q8Sm@FVFF77S0Q05N>
References: <20230619100121.27534-1-puranjay12@gmail.com>
 <20230619100121.27534-4-puranjay12@gmail.com>
 <ZJMXqTffB22LSOkd@FVFF77S0Q05N>
 <CANk7y0h5ucxmMz4K8sGx7qogFyx6PRxYxmFtwTRO7=0Y=B4ugw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANk7y0h5ucxmMz4K8sGx7qogFyx6PRxYxmFtwTRO7=0Y=B4ugw@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 10:57:20PM +0200, Puranjay Mohan wrote:
> On Wed, Jun 21, 2023 at 5:31 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > On Mon, Jun 19, 2023 at 10:01:21AM +0000, Puranjay Mohan wrote:
> > > @@ -1562,34 +1610,39 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> > >
> > >       /* 3. Extra pass to validate JITed code. */
> > >       if (validate_ctx(&ctx)) {
> > > -             bpf_jit_binary_free(header);
> > >               prog = orig_prog;
> > > -             goto out_off;
> > > +             goto out_free_hdr;
> > >       }
> > >
> > >       /* And we're done. */
> > >       if (bpf_jit_enable > 1)
> > >               bpf_jit_dump(prog->len, prog_size, 2, ctx.image);
> > >
> > > -     bpf_flush_icache(header, ctx.image + ctx.idx);
> > > +     bpf_flush_icache(ro_header, ctx.ro_image + ctx.idx);
> >
> > I think this is too early; we haven't copied the instructions into the
> > ro_header yet, so that still contains stale instructions.
> >
> > IIUC at the whole point of this is to pack multiple programs into shared ROX
> > pages, and so there can be an executable mapping of the RO page at this point,
> > and the CPU can fetch stale instructions throught that.
> >
> > Note that *regardless* of whether there is an executeable mapping at this point
> > (and even if no executable mapping exists until after the copy), we at least
> > need a data cache clean to the PoU *after* the copy (so fetches don't get a
> > stale value from the PoU), and the I-cache maintenance has to happeon the VA
> > the instrutions will be executed from (or VIPT I-caches can still contain stale
> > instructions).
> 
> Thanks for catching this, It is a big miss from my side.
> 
> I was able to reproduce the boot issue in the other thread on my
> raspberry pi. I think it is connected to the
> wrong I-cache handling done by me.
> 
> As you rightly pointed out: We need to do bpf_flush_icache() after
> copying the instructions to the ro_header or the CPU can run
> incorrect instructions.
> 
> When I move the call to bpf_flush_icache() after
> bpf_jit_binary_pack_finalize() (this does the copy to ro_header), the
> boot issue
> is fixed. Would this change be enough to make this work or I would
> need to do more with the data cache as well to catch other
> edge cases?

AFAICT, bpf_flush_icache() calls flush_icache_range(). Despite its name,
flush_icache_range() has d-cache maintenance, i-cache maintenance, and context
synchronization (i.e. it does everything necessary).

As long as you call that with the VAs the code will be executed from, that
should be sufficient, and you don't need to do any other work.

Thanks,
Mark.

