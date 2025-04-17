Return-Path: <bpf+bounces-56168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37A7A92D5E
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 00:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 827AC7A82F9
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 22:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24BC21ABC9;
	Thu, 17 Apr 2025 22:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="V63aA7D4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7E92153DA;
	Thu, 17 Apr 2025 22:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744929759; cv=none; b=MJT5RknZ5vu9ICgMoCyuv47gc1L9BUZ2kw4aNTszW/aI7YB1zUHxPSaO+zOy6MTnG1Q/3bLDscPwjxH4W6Qenok/6Y94p5zsmOfqrlToNcY6zTkbI7JZ+Qb63Ywty0pDJlQb8p6zDL37LUwPhoAoh4FGYEJWry7CzxZhmx4EdMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744929759; c=relaxed/simple;
	bh=QdV+tOnzkifghnNjkAqsqt+Ara8JdbkdTNCZR1Zb9L8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WA2Ytf32vJYL/iu+0AEsqjyTsYUtkGc6mKaqFCdcwwHvdK+enIqaYib/kvOqKyWFK+AKe48oQ1WMpqzlNFVMecZvq7CYnYwtEISTv/bhZyipjeog5LBQLvDxivlWI3iBQg0QbCoaPd61/m5XQCC+JR8toSucOksFm9TSvQ3U+Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=V63aA7D4; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744929758; x=1776465758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dxOtun6d4VkDycCzxB2Fm4IX16lPOKdGFPLBnUL5PS4=;
  b=V63aA7D4hVn9Q+sbQYN2QTx+ZBIEEEZLRtKWX8mIF0Z/y3fy2Ab1BPeM
   9zV1/hqtI+xLuM1Z1mnR7dzI+5jyBx9YRKHxtV8inCsHEwkshmVeeLAY/
   F1M85OYxu1kPOnyyGA+5LqIKgP2lKL4lHvd55FNAbYB9/C6z24mTmEWGp
   w=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="512487416"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 22:42:31 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:7878]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.54:2525] with esmtp (Farcaster)
 id db11a32d-a0e1-4389-9eb0-2f719602d617; Thu, 17 Apr 2025 22:42:31 +0000 (UTC)
X-Farcaster-Flow-ID: db11a32d-a0e1-4389-9eb0-2f719602d617
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 17 Apr 2025 22:42:29 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 17 Apr 2025 22:42:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jordan@jrife.io>
CC: <aditi.ghag@isovalent.com>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
	<kuniyu@amazon.com>, <martin.lau@linux.dev>, <netdev@vger.kernel.org>,
	<willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/6] bpf: udp: Make sure iter->batch always contains a full bucket snapshot
Date: Thu, 17 Apr 2025 15:41:48 -0700
Message-ID: <20250417224219.29946-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416233622.1212256-3-jordan@jrife.io>
References: <20250416233622.1212256-3-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB001.ant.amazon.com (10.13.139.148) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jordan Rife <jordan@jrife.io>
Date: Wed, 16 Apr 2025 16:36:17 -0700
> Require that iter->batch always contains a full bucket snapshot. This
> invariant is important to avoid skipping or repeating sockets during
> iteration when combined with the next few patches. Before, there were
> two cases where a call to bpf_iter_udp_batch may only capture part of a
> bucket:
> 
> 1. When bpf_iter_udp_realloc_batch() returns -ENOMEM [1].
> 2. When more sockets are added to the bucket while calling
>    bpf_iter_udp_realloc_batch(), making the updated batch size
>    insufficient [2].
> 
> In cases where the batch size only covers part of a bucket, it is
> possible to forget which sockets were already visited, especially if we
> have to process a bucket in more than two batches. This forces us to
> choose between repeating or skipping sockets, so don't allow this:
> 
> 1. Stop iteration and propagate -ENOMEM up to userspace if reallocation
>    fails instead of continuing with a partial batch.
> 2. Retry bpf_iter_udp_realloc_batch() up to two times if we fail to
>    capture the full bucket. On the third attempt, hold onto the bucket
>    lock (hslot2->lock) through bpf_iter_udp_realloc_batch() with
>    GFP_ATOMIC to guarantee that the bucket size doesn't change before
>    our next attempt. Try with GFP_USER first to improve the chances
>    that memory allocation succeeds; only use GFP_ATOMIC as a last
>    resort.

kvmalloc() tries the kmalloc path, 1. slab and 2. page allocator, and
if both of them fails, then tries 3. vmalloc().  But, vmalloc() does not
support GFP_ATOMIC, __kvmalloc_node_noprof() returns at
!gfpflags_allow_blocking().

So, falling back to GFP_ATOMIC is most unlikely to work as the last resort.

GFP_ATOMIC first and falling back to GFP_USER few more times, or not using
GFP_ATOMIC makes more sense to me.



