Return-Path: <bpf+bounces-58698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2330AC003F
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 01:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845AF1BC6428
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 23:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D8323BCEF;
	Wed, 21 May 2025 22:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="nyLUs/n3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD31423A9BD;
	Wed, 21 May 2025 22:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747868396; cv=none; b=BRCih11fMVZY4cI8kmQMIIb93Dij6BPI7lC/MB95G+cwe3CqcPROmGjQ38853wxqo9oS9xySzvkiPBAC1DSLeBrsRLmg81PmBfc0wEL71xzaiVsLSaESvzRUAhBg+QLgEB+Sph5jDNmnNkTr3ap4/idQSE2OS85Qpzlec2jepms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747868396; c=relaxed/simple;
	bh=jyD9GMzVNZ4FbSOCjoqmU2eBzTRRI0nj4dvZ5Vy+YGk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OLo7FNcNmKVVuGIRuzTYOyUcuNKC+TwXrb27sRegJnURmq/OnzaGYMMzPZ9lhZLsLV2m/kBUbi7M1VRQuyBqrR4YLyn552e25YJ5kTZVs7egP6rk+JAtPxA8gQC/iKQou76dFb5GPailZB1BbA0dXzCBsWvuhalwDkOiZ9nhMVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=nyLUs/n3; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747868395; x=1779404395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vKsNmBvl97GjPL7novWt4bTHnLcFVtaylsqKvT02Uok=;
  b=nyLUs/n3c3TI40wsVwPCQjYJkY0C9VEqd6oM50SicW2Cqo645QgHIxxJ
   RSnw6rcMcXA0CegW5VsfBVaIW7dxYKUJKlUOcdgn5KaTQLeyyezlwVU3/
   IlTpsxvU73XqA462xOeK00L4Z5Xn9Cg4nfuNQ31BeJPWO+R+NTJMJn5dj
   rVnw5B38FnNNDOSxnAk/3eqTyYV6V0eOBAlyClM7hiQHnrZ3E+BtbzFwa
   Mu3Q2U+3XSOs3GfloH/GaiSzn0SjMo/qxP/obaQpunKyxQDonEgAxTx3N
   2Z1lk2SujmiqTBZRwzGFCxHxfS15M0AtOa2YJU4yPYiafToxvKzEY1a8v
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,304,1739836800"; 
   d="scan'208";a="523019442"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 22:59:49 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:21652]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.29:2525] with esmtp (Farcaster)
 id e4c43713-aff6-4edb-823f-91f0b80a1c1f; Wed, 21 May 2025 22:59:48 +0000 (UTC)
X-Farcaster-Flow-ID: e4c43713-aff6-4edb-823f-91f0b80a1c1f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 22:59:48 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.52.104) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 22:59:45 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jordan@jrife.io>
CC: <alexei.starovoitov@gmail.com>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <kuniyu@amazon.com>, <martin.lau@linux.dev>,
	<netdev@vger.kernel.org>, <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v1 bpf-next 04/10] bpf: tcp: Use bpf_tcp_iter_batch_item for bpf_tcp_iter_state batch items
Date: Wed, 21 May 2025 15:59:36 -0700
Message-ID: <20250521225937.89396-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520145059.1773738-5-jordan@jrife.io>
References: <20250520145059.1773738-5-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jordan Rife <jordan@jrife.io>
Date: Tue, 20 May 2025 07:50:51 -0700
> Prepare for the next patch that tracks cookies between iterations by
> converting struct sock **batch to union bpf_tcp_iter_batch_item *batch
> inside struct bpf_tcp_iter_state.
> 
> Signed-off-by: Jordan Rife <jordan@jrife.io>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

