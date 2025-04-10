Return-Path: <bpf+bounces-55689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB20EA84CF5
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 21:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46C301895AAD
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 19:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AD328FFD8;
	Thu, 10 Apr 2025 19:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="u9dgxLfF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5074D70830;
	Thu, 10 Apr 2025 19:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744313163; cv=none; b=euPKyo/nb99jAs1q6KCNLTUp+bYqUhmeE8kgSFwZ5hWWOoC12rL6M5T12zQH93JegLpP8Ked9IgS5Pmqs8Xgux0dYgJflh6q1KPOSUMS/1zDPD08LMKHm7Lt9L/oxrgDvWPcEN6ZkB1J3me6FtOOb2K0T+cfAKMdfjPMJEjbqds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744313163; c=relaxed/simple;
	bh=k8RFiI/x6UxupfW1UUmtnhPewcoXjLqm7EjG3qPoxxo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHmKS598PDDz8sY272J02o9lA1NKc9hOJNjWzG31LHqKdXo+uoGk7oSnwTiZoOHiigRW23Yk7Xyo+pFiwIxl/e5S8OCGV7HSQC3FQGmPYWGWznX2eQLolt1cCqU90iFyguc0UV6GsZ9Zuc+WOgAS0drvq9hJeDxN8OlKWCU3kbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=u9dgxLfF; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744313163; x=1775849163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0l1LQFW7fzsNRJ7rHIC6JfuWXS1d6idcutFACZv5Txw=;
  b=u9dgxLfFqj8A9vhJ0DrNQt2d5iTRAO/rVVaSdDsb4MZGBJJx9JWUGC8r
   DzRWI/MLs3zwgeTGeqyQJTkPqxwPzuFVGr+Uh8xLL9vSd4d7nhhnzTgp0
   m7+kaXA/MXJVI3biip1Gd/lbB2ssKWxI0g1IbCou5rkLnmbHXWdJhdc2m
   A=;
X-IronPort-AV: E=Sophos;i="6.15,203,1739836800"; 
   d="scan'208";a="510568203"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 19:25:57 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:43177]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.120:2525] with esmtp (Farcaster)
 id c8f9aa91-2435-413f-a495-a915702a0546; Thu, 10 Apr 2025 19:25:56 +0000 (UTC)
X-Farcaster-Flow-ID: c8f9aa91-2435-413f-a495-a915702a0546
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 19:25:55 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.21) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 19:25:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jordan@jrife.io>
CC: <aditi.ghag@isovalent.com>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
	<kuniyu@amazon.com>, <martin.lau@linux.dev>, <netdev@vger.kernel.org>,
	<willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v1 bpf-next 1/5] bpf: udp: Use bpf_udp_iter_batch_item for bpf_udp_iter_state batch items
Date: Thu, 10 Apr 2025 12:25:40 -0700
Message-ID: <20250410192543.99383-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409182237.441532-2-jordan@jrife.io>
References: <20250409182237.441532-2-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jordan Rife <jordan@jrife.io>
Date: Wed,  9 Apr 2025 11:22:30 -0700
> Prepare for the next commit that tracks cookies between iterations by
> converting struct sock **batch to union bpf_udp_iter_batch_item *batch
> inside struct bpf_udp_iter_state.
> 
> Signed-off-by: Jordan Rife <jordan@jrife.io>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

