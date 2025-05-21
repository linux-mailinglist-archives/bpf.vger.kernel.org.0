Return-Path: <bpf+bounces-58687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B547ABFF61
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 00:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A8A1BA4D9C
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 22:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBFE239E80;
	Wed, 21 May 2025 22:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="PWsrlOKO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3552B9A9;
	Wed, 21 May 2025 22:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747866026; cv=none; b=hkr/pnOKS9gZjtFAWka4zlSum5QxsWlVPzZ1brEUH0pyN9IYr3TMoQssSt+ILD/qvj7JtT2SNS/be4S5GMLAkINkXDR06Vq4QMIFXwj1O3iJeX5o+M5Fn01yiqkuhKZTtj99x7U9z9tcQO15WC4trh6LRvP+41nMi3geO8OjB/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747866026; c=relaxed/simple;
	bh=gls+ZcFTEdOz3UEovmMZUR8naAEeaSWPKjBLlEoX8sE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2asQIQud0dPQs2a8lhmJBP6pSdCD4Y1p07z4BScOTKcKqjpHb4VmJ2JQUPrf8fQKk1m+BCe/LFS/qljhYZwBQWs/Bg3j1ZiBzPlyxY/u2xozgmcKN5jnCHFbwQRWeIg9hvC96uZ/ZM0BO9oLvgVjjnSpS4AE1NnrnsJFxZME2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=PWsrlOKO; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747866025; x=1779402025;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vf4hc+qK1z5O+lchWhOjyB1mxri2NnFe5ss13arccME=;
  b=PWsrlOKOsVY0loXuw5C7pnfCz78mSj0kzRigioa4ybfA5BdLTTH/JVkB
   jxMpbb/0nZgovHe2jYxe9IdD/hqBb0NOKO5RkxcpQsuD+aPEPY6SkgJfa
   dA9ar/CU28F4zjBf7bwkmg23Wa2iP5+F7QPghM87HYemFqKPQ7KDFFk6t
   VhPZ5TtJ3NaOXnU8TvJZL1dNE65pW/v/wVQqht0SiwochMxImvUMhjhFj
   gvplUTQBIUR2KOdAyvzaneILqSlErNivX08zR5bTFr8HTRBDj3K4ZJ7Ut
   0uEfJnL3hl0U9M+q0W43D9+S4u/h4aLJt16G8tGlZPNv+YG3HqbjKxgrP
   w==;
X-IronPort-AV: E=Sophos;i="6.15,304,1739836800"; 
   d="scan'208";a="52591237"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 22:20:22 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:45461]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.191:2525] with esmtp (Farcaster)
 id 7dc05fee-baff-4b98-9bf6-986dda3d4079; Wed, 21 May 2025 22:20:21 +0000 (UTC)
X-Farcaster-Flow-ID: 7dc05fee-baff-4b98-9bf6-986dda3d4079
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 22:20:21 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.52.104) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 22:20:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jordan@jrife.io>
CC: <alexei.starovoitov@gmail.com>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <kuniyu@amazon.com>, <martin.lau@linux.dev>,
	<netdev@vger.kernel.org>, <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v1 bpf-next 02/10] bpf: tcp: Make sure iter->batch always contains a full bucket snapshot
Date: Wed, 21 May 2025 15:20:06 -0700
Message-ID: <20250521222009.85628-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520145059.1773738-3-jordan@jrife.io>
References: <20250520145059.1773738-3-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jordan Rife <jordan@jrife.io>
Date: Tue, 20 May 2025 07:50:49 -0700
> Require that iter->batch always contains a full bucket snapshot. This
> invariant is important to avoid skipping or repeating sockets during
> iteration when combined with the next few patches. Before, there were
> two cases where a call to bpf_iter_tcp_batch may only capture part of a
> bucket:
> 
> 1. When bpf_iter_tcp_realloc_batch() returns -ENOMEM.
> 2. When more sockets are added to the bucket while calling
>    bpf_iter_tcp_realloc_batch(), making the updated batch size
>    insufficient.
> 
> In cases where the batch size only covers part of a bucket, it is
> possible to forget which sockets were already visited, especially if we
> have to process a bucket in more than two batches. This forces us to
> choose between repeating or skipping sockets, so don't allow this:
> 
> 1. Stop iteration and propagate -ENOMEM up to userspace if reallocation
>    fails instead of continuing with a partial batch.
> 2. Try bpf_iter_tcp_realloc_batch() with GFP_USER just as before, but if
>    we still aren't able to capture the full bucket, call
>    bpf_iter_tcp_realloc_batch() again while holding the bucket lock to
>    guarantee the bucket does not change. On the second attempt use
>    GFP_NOWAIT since we hold onto the spin lock.
> 
> I did some manual testing to exercise the code paths where GFP_NOWAIT is
> used and where ERR_PTR(err) is returned. I used the realloc test cases
> included later in this series to trigger a scenario where a realloc
> happens inside bpf_iter_tcp_batch and made a small code tweak to force
> the first realloc attempt to allocate a too-small batch, thus requiring
> another attempt with GFP_NOWAIT. Some printks showed both reallocs with
> the tests passing:
> 
> May 09 18:18:55 crow kernel: resize batch TCP_SEQ_STATE_LISTENING
> May 09 18:18:55 crow kernel: again GFP_USER
> May 09 18:18:55 crow kernel: resize batch TCP_SEQ_STATE_LISTENING
> May 09 18:18:55 crow kernel: again GFP_NOWAIT
> May 09 18:18:57 crow kernel: resize batch TCP_SEQ_STATE_ESTABLISHED
> May 09 18:18:57 crow kernel: again GFP_USER
> May 09 18:18:57 crow kernel: resize batch TCP_SEQ_STATE_ESTABLISHED
> May 09 18:18:57 crow kernel: again GFP_NOWAIT
> 
> With this setup, I also forced each of the bpf_iter_tcp_realloc_batch
> calls to return -ENOMEM to ensure that iteration ends and that the
> read() in userspace fails.
> 
> Signed-off-by: Jordan Rife <jordan@jrife.io>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

