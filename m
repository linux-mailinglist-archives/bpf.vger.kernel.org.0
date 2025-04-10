Return-Path: <bpf+bounces-55690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE2DA84E09
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 22:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 739AD4A322E
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 20:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F72B28D849;
	Thu, 10 Apr 2025 20:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Pa6vGg2U"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6251149C64;
	Thu, 10 Apr 2025 20:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744316549; cv=none; b=CG+Q/vU9dDkQc096hptnDhjQmByg8cwCjzmacp/YEMFraJYMzgW3c7Zon3uDb6liggS6UKWdz0tZ4jfvCfqSu1HluY6OGquA3kn//leQQnqHQqhMKMxLW6iDoUBkkCOuzY5to9vNzS9P2l1Q5g+bCQg/7rJ5adNpMYyTFqKkYI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744316549; c=relaxed/simple;
	bh=gX8EX80S6a3yeduLhPH2Qe6/s1ZNT5LtkB/JBoIipO8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iwAf3VwwMwZity/IdtG8ln5u7KXQ7pl7AW+i1jHqf7SaoZD94aR6pOKmqo4svjHvipJAUMif7X1icK5i/2l4VQUR/cfHgJpk6bkd2vtjNDQe7NQqP7BE20VFlEaO3kZUNXaJskd9hRnhPx3Jjw1dAQuDvtAR0mrrsnjfbVsuHY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Pa6vGg2U; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744316548; x=1775852548;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dmvp2WGCbCiTgKF8lQKzXJKeQhBRReifwMWOGzkGP+A=;
  b=Pa6vGg2UXRHK0NkSt1gcvRylOA/u7jhB/AtZX4RSVM5pGyWKsfx+a2yh
   WkXE0adIsJSlHAe2uPinaCVhgjvLvVcZ8W3rNPppxtS686BsKmhzBDW4B
   jbc8B3aBSMQ2BCkCqgmrOu0hF12oOMspcUCmdZdnDfb8NbCWJKxlNOf0d
   U=;
X-IronPort-AV: E=Sophos;i="6.15,203,1739836800"; 
   d="scan'208";a="186403464"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 20:22:26 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:43626]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.57:2525] with esmtp (Farcaster)
 id e2c535d9-c422-41b0-aa8b-45079d12221d; Thu, 10 Apr 2025 20:22:25 +0000 (UTC)
X-Farcaster-Flow-ID: e2c535d9-c422-41b0-aa8b-45079d12221d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 20:22:25 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.21) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 20:22:22 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jordan@jrife.io>
CC: <aditi.ghag@isovalent.com>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
	<kuniyu@amazon.com>, <martin.lau@linux.dev>, <netdev@vger.kernel.org>,
	<willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v1 bpf-next 2/5] bpf: udp: Avoid socket skips and repeats during iteration
Date: Thu, 10 Apr 2025 13:21:07 -0700
Message-ID: <20250410202214.7061-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409182237.441532-3-jordan@jrife.io>
References: <20250409182237.441532-3-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jordan Rife <jordan@jrife.io>
Date: Wed,  9 Apr 2025 11:22:31 -0700
> @@ -3839,6 +3876,11 @@ static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
>  		return -ENOMEM;
>  
>  	bpf_iter_udp_put_batch(iter);
> +	WARN_ON_ONCE(new_batch_sz < iter->max_sk);

I'd put this before kvmalloc_array() or remove as it's obvious.


> +	/* Make sure the new batch has the cookies of the sockets we haven't
> +	 * visited yet.
> +	 */
> +	memcpy(new_batch, iter->batch, iter->end_sk);

The 3rd arg is missing sizeof(*iter->batch) * ?

