Return-Path: <bpf+bounces-56207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52819A92E66
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 01:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C552C1B63989
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 23:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A7D2236F3;
	Thu, 17 Apr 2025 23:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LccHDcfx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430E21FE469;
	Thu, 17 Apr 2025 23:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744932801; cv=none; b=YeqnnbB2QijhbAz9+9Vz85ILQtABKqOh/WPym3Plh0aCwJf4o94gl6h6i4LleQeXoFcLLipgIVF0wylYFPFpyCGsA8GH4/ExFuWae9+F0yWzlERmSJRz70pT6i3vd68mok8rnHYDvuh1izIqkeoE8wsHlwANN7ayZUBt/AzCzqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744932801; c=relaxed/simple;
	bh=PNcS4OktNUzJQHhYYTR8s0KcGGGXgMTsOEXLBrHSHVQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IBAJlQqDm0h/bHGgCOT62LwOhSKpid2SM3psEYWGPPINEHNUd4ry5Vw+1XjxaF1BknIX2EwfdKXS7PY1fL+dYfJDXWtoeUtCnpaVMj0643JU+7IcAvHJfcBRHxveLIc7BW7fv44gz2cwiHjpDVii8bYsbQ6FAzOwkTkYeDFSDzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LccHDcfx; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744932800; x=1776468800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vvxGc27pMUzJMulB6gfAsVWmeeF9586431nvR7Tc9n0=;
  b=LccHDcfxkA36WruU2zRKqgyjpf4RDvLsfA8Kfr/t73etsF2gW4nT4Tmv
   GFKCN7VFE3NmTb5n0dxBjSdX0FurGX17z3bHPvJo8/vfGsfh0OF72Jpi4
   xsjtpmWCjjWc/KKne+O78Zve+4daYqjVS9cp/jUHmv1hmrMSAYHnMwpDs
   o=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="396866074"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 23:33:15 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:38572]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.80:2525] with esmtp (Farcaster)
 id f176e287-2996-458a-9fa0-a755033ab102; Thu, 17 Apr 2025 23:33:14 +0000 (UTC)
X-Farcaster-Flow-ID: f176e287-2996-458a-9fa0-a755033ab102
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 17 Apr 2025 23:33:14 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 17 Apr 2025 23:33:11 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <martin.lau@linux.dev>
CC: <aditi.ghag@isovalent.com>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
	<jordan@jrife.io>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/6] bpf: udp: Make sure iter->batch always contains a full bucket snapshot
Date: Thu, 17 Apr 2025 16:32:58 -0700
Message-ID: <20250417233303.37489-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <42b84ea3-b3c1-4839-acfc-bd182e7af313@linux.dev>
References: <42b84ea3-b3c1-4839-acfc-bd182e7af313@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Martin KaFai Lau <martin.lau@linux.dev>
Date: Thu, 17 Apr 2025 16:12:57 -0700
> On 4/17/25 3:41 PM, Kuniyuki Iwashima wrote:
> > From: Jordan Rife <jordan@jrife.io>
> > Date: Wed, 16 Apr 2025 16:36:17 -0700
> >> Require that iter->batch always contains a full bucket snapshot. This
> >> invariant is important to avoid skipping or repeating sockets during
> >> iteration when combined with the next few patches. Before, there were
> >> two cases where a call to bpf_iter_udp_batch may only capture part of a
> >> bucket:
> >>
> >> 1. When bpf_iter_udp_realloc_batch() returns -ENOMEM [1].
> >> 2. When more sockets are added to the bucket while calling
> >>     bpf_iter_udp_realloc_batch(), making the updated batch size
> >>     insufficient [2].
> >>
> >> In cases where the batch size only covers part of a bucket, it is
> >> possible to forget which sockets were already visited, especially if we
> >> have to process a bucket in more than two batches. This forces us to
> >> choose between repeating or skipping sockets, so don't allow this:
> >>
> >> 1. Stop iteration and propagate -ENOMEM up to userspace if reallocation
> >>     fails instead of continuing with a partial batch.
> >> 2. Retry bpf_iter_udp_realloc_batch() up to two times if we fail to
> >>     capture the full bucket. On the third attempt, hold onto the bucket
> >>     lock (hslot2->lock) through bpf_iter_udp_realloc_batch() with
> >>     GFP_ATOMIC to guarantee that the bucket size doesn't change before
> >>     our next attempt. Try with GFP_USER first to improve the chances
> >>     that memory allocation succeeds; only use GFP_ATOMIC as a last
> >>     resort.
> > 
> > kvmalloc() tries the kmalloc path, 1. slab and 2. page allocator, and
> > if both of them fails, then tries 3. vmalloc().  But, vmalloc() does not
> > support GFP_ATOMIC, __kvmalloc_node_noprof() returns at
> > !gfpflags_allow_blocking().
> > 
> > So, falling back to GFP_ATOMIC is most unlikely to work as the last resort.
> > 
> > GFP_ATOMIC first and falling back to GFP_USER few more times, or not using
> > GFP_ATOMIC makes more sense to me.
> 
> If I read it correctly, the last retry with GFP_ATOMIC is not because of the 
> earlier GFP_USER allocation failure but the size of the bucket has changed a lot 
> that it is doing one final attempt to get the whole bucket and this requires to 
> hold the bucket lock to ensure the size stays the same which then must use 
> GFP_ATOMIC.

Ah exactly, when allocation fails, it always returned an error.

Sorry, I should've read code first.

