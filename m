Return-Path: <bpf+bounces-58243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D898AB775F
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 22:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7531BA4BC5
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 20:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D936329616A;
	Wed, 14 May 2025 20:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ton4bTVz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2094EBE;
	Wed, 14 May 2025 20:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747256045; cv=none; b=B7QE41VsOYt6/UAa6VpsI5D9BcKX4ZVpDOYNUEmId3xWtEgqBkcwOQW6cjA2K41nj3G0TVtQbxXoGxWvAOYNnkft3hp+mbRjYYTQ0fyYxvSdmOXiPQzlzES8PVXaCOi02Zgbqpgic/4ryo9q79My1KiB5SYEoHuXaS2BHQLmWlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747256045; c=relaxed/simple;
	bh=OgvTAnToodXrbkk+luxVq7qzf+SV6riaQuSHxXFXsyY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=elgTOP4cWrYaAh+mztNIUz7lYFavgyBlP/wU9jKoV2kClhwbNc78bmTQCZmlyhPemfHnsjucKlhRaKk+FjjkKYp/FDU5KpUmm7Aio1M5mHm1A7vSHZEKsnpvXzUKqexRyY/hjLIwm8j5XbghqqRmYWMjox+NT9SC/LUgz9lBnWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Ton4bTVz; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747256044; x=1778792044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lpjnct4m/uQSVmHA+Sg9hZodDW5ZslWSP4blJlaPXCs=;
  b=Ton4bTVzQ/ikUJCWQuRjKkT3uzwfsBAK2cYdXi8KPzP+6FWypHNlp+Pn
   sU1OxWcC4CKkAaRDExdaX/vt21k7zTYRbI7HpCKihR2ru2Yj4KQEXQuDN
   aXgZ+ISjNcJCqcp/hCWjV2WGfRX929tXATW8VmolNkQv+hcH4YDq2IFvc
   yekKFe959nrhhd2ooA76WZPG1zNOxXhmTOLVCuTM/JO9sDmbxn6IR4lAS
   3XifDEQhC6s/djGeJ07g6+zOtj7w9RQPsxmhlC5V+bnvpZzO5+ocaHBGe
   XoXatT7SXTVWUXMkSOKBiXTg+thUnLrz9/4+gp7ucX11SY2mT6KCfS/to
   A==;
X-IronPort-AV: E=Sophos;i="6.15,289,1739836800"; 
   d="scan'208";a="93291435"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 20:54:00 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:5803]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.52:2525] with esmtp (Farcaster)
 id 48c7ad1c-9ae7-448f-879b-f66afc2dbc9c; Wed, 14 May 2025 20:53:59 +0000 (UTC)
X-Farcaster-Flow-ID: 48c7ad1c-9ae7-448f-879b-f66afc2dbc9c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 20:53:59 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 20:53:56 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <bpf@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<eric.dumazet@gmail.com>, <horms@kernel.org>, <jonesrick@google.com>,
	<kuniyu@amazon.com>, <ncardwell@google.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <weiwan@google.com>
Subject: Re: [PATCH net-next 11/11] tcp: increase tcp_rmem[2] to 32 MB
Date: Wed, 14 May 2025 13:53:39 -0700
Message-ID: <20250514205348.78733-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514132422.2eefdbf1@kernel.org>
References: <20250514132422.2eefdbf1@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 14 May 2025 13:24:22 -0700
> On Tue, 13 May 2025 19:39:19 +0000 Eric Dumazet wrote:
> > Last change to tcp_rmem[2] happened in 2012, in commit b49960a05e32
> > ("tcp: change tcp_adv_win_scale and tcp_rmem[2]")
> > 
> > TCP performance on WAN is mostly limited by tcp_rmem[2] for receivers.
> > 
> > After this series improvements, it is time to increase the default.
> 
> I think this breaks the BPF syncookie test, Kuniyuki any idea why?
> 
> https://github.com/kernel-patches/bpf/actions/runs/15016644781/job/42196471693

It seems ACK was not handled by BPF at tc hook on lo.

ACK was not sent or tcp_load_headers() failed to parse it ?
both sounds unlikely though.

Will try to reproduce it.

