Return-Path: <bpf+bounces-1350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 380F37132DD
	for <lists+bpf@lfdr.de>; Sat, 27 May 2023 09:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45BF928199B
	for <lists+bpf@lfdr.de>; Sat, 27 May 2023 07:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350F0137D;
	Sat, 27 May 2023 07:04:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BAF7E
	for <bpf@vger.kernel.org>; Sat, 27 May 2023 07:04:53 +0000 (UTC)
Received: from out-26.mta1.migadu.com (out-26.mta1.migadu.com [IPv6:2001:41d0:203:375::1a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1260AFB
	for <bpf@vger.kernel.org>; Sat, 27 May 2023 00:04:51 -0700 (PDT)
Date: Sat, 27 May 2023 03:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1685171090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iou0GTPq4Ljp/eKRqegKeRywXowmKecKWFtCM8AzuyE=;
	b=vaqBn89cvOB6cMJpgVHg8c9LyrFKdkyl6wiaHAmBzmvw/5hJ3K7b2CFzuKlroi18Gt2y87
	9A5XRCQIl6o2dJEOPbDlTOqFs3MkIgYM/WKORNr10fKe9m7Inp7yE3R8RsDuDj518bJBPj
	ymlbbkFW7ZnF6yfDkkv8vgKc5h9Z7SQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Song Liu <song@kernel.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, mcgrof@kernel.org,
	peterz@infradead.org, tglx@linutronix.de, x86@kernel.org,
	rppt@kernel.org
Subject: Re: [PATCH 0/3] Type aware module allocator
Message-ID: <ZHGrjJ8PqAGN9OZK@moria.home.lan>
References: <20230526051529.3387103-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526051529.3387103-1-song@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 25, 2023 at 10:15:26PM -0700, Song Liu wrote:
> This set implements the second part of module type aware allocator
> (module_alloc_type), which was discussed in [1]. This part contains the
> interface of the new allocator, as well as changes in x86 code to use the
> new allocator (modules, BPF, ftrace, kprobe).
> 
> The set does not contain a binpack allocator to enable sharing huge pages
> among different allocations. But this set defines the interface used by
> the binpack allocator. [2] has some discussion on different options of the
> binpack allocator.

I'm afraid the more I look at this patchset the more it appears to be
complete nonsense.

The exposed interface appears to be both for specifying architecture
dependent options (which should be hidden inside the allocator
internals!) _and_ a general purpose interface for module/bpf/kprobes -
but it's not very clear, and the rational appears to be completely
missing.

I think this needs to back to the drawing board and we need something
simpler just targeted at executable memory; architecture specific
options should definitely _not_ be part of the exposed interface.

The memory protection interface also needs to go, we've got a better
interface to model after (text_poke(), although that code needs work
too!). And the instruction fill features need a thorough justification
if they're to be included.

