Return-Path: <bpf+bounces-42256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 961839A164E
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 01:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41A471F21C58
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 23:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5D71D54F7;
	Wed, 16 Oct 2024 23:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M7Htt7as"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766371D517A
	for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 23:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729123039; cv=none; b=pMQ3Kxw5k0DUoZj+nVO2qfY87w0+ey3u6EhWHBElosJXGj2RShWLTetne0xKgc1hQsBvbw/73MeQgolB26cEov0ITxpyWgImfovEyJbHdGZI2NK2lSFqnb25sZTpkFU4kqhs4pQnDv67fi8GIwqXxgq4S3xIAX0nJE6X2eYDIug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729123039; c=relaxed/simple;
	bh=4KT0Jlxix9rctqaUMq8AVmFXlsPVkE/K+UJyTR+LU2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahAjRuFskNIBufcsY4v4qrQkxekw3KCjdCGrOsUnTogEdpvXP5/+UIrxRQG1vbJB51w9FIPQE6UyOuYzn3f1n2pr0bUCXo5N6ai/3cKUwLE0DfTwRzMWDMSe+XMGdZlvTC+BkNkBzdh1/o7BhEVAor0WoV26VxNdSKAg+KU7XAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M7Htt7as; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 16 Oct 2024 16:57:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729123035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0quICheMGqqTTZPr/l7yyzcjrUta9SY0tjGFEid3K14=;
	b=M7Htt7asSO+L9B+lbivHqkLsXi2fjqqUGUrtusfPpH1djNIt2CcX9E1STHXaukEqiDPMhG
	o3b0Jov1Q0ulbPV7VPFlpL3TEMCs9MkK0Z07E+vrIyC+cOE9/jVw3yanXBjp5mq3ExllX8
	zm9kZtA2XD5HcCGMRo/rqWekunCI87o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, linux-mm@kvack.org, linux-perf-users@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, rppt@kernel.org, david@redhat.com, yosryahmed@google.com, 
	Yi Lai <yi1.lai@intel.com>
Subject: Re: [PATCH v2 bpf] lib/buildid: handle memfd_secret() files in
 build_id_parse()
Message-ID: <qaxxl3zcb3jgd6mnx72ftbvha3kheh4trf4ihz4kgs3mwicfuw@egleekcxsz3r>
References: <20241016221629.1043883-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016221629.1043883-1-andrii@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 16, 2024 at 03:16:29PM GMT, Andrii Nakryiko wrote:
> From memfd_secret(2) manpage:
> 
>   The memory areas backing the file created with memfd_secret(2) are
>   visible only to the processes that have access to the file descriptor.
>   The memory region is removed from the kernel page tables and only the
>   page tables of the processes holding the file descriptor map the
>   corresponding physical memory. (Thus, the pages in the region can't be
>   accessed by the kernel itself, so that, for example, pointers to the
>   region can't be passed to system calls.)
> 
> So folios backed by such secretmem files are not mapped into kernel
> address space and shouldn't be accessed, in general.
> 
> To make this a bit more generic of a fix and prevent regression in the
> future for similar special mappings, do a generic check of whether the
> folio we got is mapped with kernel_page_present(), as suggested in [1].
> This will handle secretmem, and any future special cases that use
> a similar approach.
> 
> Original report and repro can be found in [0].
> 
>   [0] https://lore.kernel.org/bpf/ZwyG8Uro%2FSyTXAni@ly-workstation/
>   [1] https://lore.kernel.org/bpf/CAJD7tkbpEMx-eC4A-z8Jm1ikrY_KJVjWO+mhhz1_fni4x+COKw@mail.gmail.com/
> 
> Reported-by: Yi Lai <yi1.lai@intel.com>
> Suggested-by: Yosry Ahmed <yosryahmed@google.com>
> Fixes: de3ec364c3c3 ("lib/buildid: add single folio-based file reader abstraction")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

