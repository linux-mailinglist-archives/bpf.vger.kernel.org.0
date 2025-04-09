Return-Path: <bpf+bounces-55586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C9DA831C9
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 22:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AAE919E5E7E
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 20:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8FE211479;
	Wed,  9 Apr 2025 20:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DQFNj3bj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F6D1DE884;
	Wed,  9 Apr 2025 20:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744230048; cv=none; b=hWa7T35xKrA1BfK0dicfYGmbyllMARv523NzB+c5NNpQCm3DPaBmzoNCYDZJeaGTR7l20U5WSBQLHEksjCo+aeUFb+QhpB/BtdmLR3cHsJuH+2szxhZa0Wy66FF4/3ChbR6d9P9YZnjjxT2G8+008X9in+CsptXUCltpnVb8y+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744230048; c=relaxed/simple;
	bh=1WrEWfpFHEmFTxy1AVRfKmrCHZ+R+S8KOv66hp8ygFk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qaNmtwM1TRg9NyypphN3ATXwMS2sNXT2btxwEqmL5nXgrHTzRko/+po8n5PXtJozZq/ndxF4YlOhJUeUn1AgtlUQnGG6hfUO0afhsJF0wnXiW/9KASHz0iQpZDsy0oFe257gWIxhGyTZn08YIal0uiS48d7gFe1CKC8gLUHONiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=DQFNj3bj; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744230044; x=1775766044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BFKlNYVEHNJdeCxI8d7yxB4qk1YN6ZpSI2mPtyL+/tk=;
  b=DQFNj3bjP9XFoC18ZRzauNe4f3Js7loUt3djd9rXbN/1wM4DfyDoTvdv
   ybutBoQY2MrNBhubGzbvdfK/g7gZ60eKdgThm0+1CcfLEu18VDxciA7/6
   Eh/PyrAfEAK+22eNEAQR3FuYmNhsAZDpEDMiyienz/3aw3+R5gZFoF1+9
   I=;
X-IronPort-AV: E=Sophos;i="6.15,201,1739836800"; 
   d="scan'208";a="510240796"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 20:20:36 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:21857]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.147:2525] with esmtp (Farcaster)
 id 8d194daa-eab1-490c-b425-30f481a950b4; Wed, 9 Apr 2025 20:20:35 +0000 (UTC)
X-Farcaster-Flow-ID: 8d194daa-eab1-490c-b425-30f481a950b4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 20:20:34 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 20:20:32 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <mhal@rbox.co>
CC: <bpf@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next] af_unix: Remove unix_unhash()
Date: Wed, 9 Apr 2025 13:20:15 -0700
Message-ID: <20250409202018.54638-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409-cleanup-drop-unix-unhash-v1-1-1659e5b8ee84@rbox.co>
References: <20250409-cleanup-drop-unix-unhash-v1-1-1659e5b8ee84@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB003.ant.amazon.com (10.13.138.8) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 09 Apr 2025 14:50:58 +0200
> Dummy unix_unhash() was introduced for sockmap in commit 94531cfcbe79
> ("af_unix: Add unix_stream_proto for sockmap"), but there's no need to
> implement it anymore.
> 
> ->unhash() is only called conditionally: in unix_shutdown() since commit
> d359902d5c35 ("af_unix: Fix NULL pointer bug in unix_shutdown"), and in BPF
> proto's sock_map_unhash() since commit 5b4a79ba65a1 ("bpf, sockmap: Don't
> let sock_map_{close,destroy,unhash} call itself").
> 
> Remove it.
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>



