Return-Path: <bpf+bounces-3887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E8E74613C
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 19:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D939A1C209F4
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 17:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAECF101E1;
	Mon,  3 Jul 2023 17:15:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE77D101C0
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 17:15:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9C89B2;
	Mon,  3 Jul 2023 10:15:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A1662F4;
	Mon,  3 Jul 2023 10:15:53 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.27.109])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D85E3F663;
	Mon,  3 Jul 2023 10:15:08 -0700 (PDT)
Date: Mon, 3 Jul 2023 18:15:02 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Puranjay Mohan <puranjay12@gmail.com>, ast@kernel.org,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	catalin.marinas@arm.com, bpf@vger.kernel.org, kpsingh@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 0/3] bpf, arm64: use BPF prog pack allocator
 in BPF JIT
Message-ID: <ZKMCFtlfJA1LfGNJ@FVFF77S0Q05N>
References: <20230626085811.3192402-1-puranjay12@gmail.com>
 <7e05efe1-0af0-1896-6f6f-dcb02ed8ca27@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e05efe1-0af0-1896-6f6f-dcb02ed8ca27@iogearbox.net>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 03, 2023 at 06:40:21PM +0200, Daniel Borkmann wrote:
> Hi Mark,

Hi Daniel,

> On 6/26/23 10:58 AM, Puranjay Mohan wrote:
> > BPF programs currently consume a page each on ARM64. For systems with many BPF
> > programs, this adds significant pressure to instruction TLB. High iTLB pressure
> > usually causes slow down for the whole system.
> > 
> > Song Liu introduced the BPF prog pack allocator[1] to mitigate the above issue.
> > It packs multiple BPF programs into a single huge page. It is currently only
> > enabled for the x86_64 BPF JIT.
> > 
> > This patch series enables the BPF prog pack allocator for the ARM64 BPF JIT.

> If you get a chance to take another look at the v4 changes from Puranjay and
> in case they look good to you reply with an Ack, that would be great.

Sure -- this is on my queue of things to look at; it might just take me a few
days to get the time to give this a proper look.

Thanks,
Mark.

