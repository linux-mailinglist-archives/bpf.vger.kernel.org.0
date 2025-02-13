Return-Path: <bpf+bounces-51335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14498A3356E
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 03:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DDF47A31EE
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 02:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BD11F8EF5;
	Thu, 13 Feb 2025 02:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="E12cuycs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458A17082D;
	Thu, 13 Feb 2025 02:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739413200; cv=none; b=kdSO81/bPQJjOrQ6ozhNBVAZfXLBQu+BWgAQeeG/C8mBs0FChQpaWHFaOwcvvwMZ5CB+lakQ4R2tXzuSmp9Xy1XFr3of5fVchJXG9MOfc2yTqXr080DsVMCzdBC8qYFq086kmsjuzfAke04bcwtU0CsIebkotcIf4out9CkQM30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739413200; c=relaxed/simple;
	bh=8hQHPGBwM8ykZlLnOAFGLy6Dt4rACd+MLf1K9cIjhbk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S5QbPRY2zt5bzR/jngMXaRC6Tvv0u3efBvV1jn+BQp4BB2T6OxpOEcyYqWSz21AEtMj3sFYQv4Mhv+VvtTzSqFNI+RueiwOEwIiaLiufj0KWu/02bum2VogI9XwVPLuto1gB/XY/7ms7Dkr05WJoNhu3XEfhpcOvmq0KhLl0YyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=E12cuycs; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739413199; x=1770949199;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1tAdaYl6h5UzagCbijpe+UPVlz+j2lBzbjZnkgM8hyE=;
  b=E12cuycswfpke2kuA6m0zXHx/1F3EVGog8n5KQp0KusCxwRaePmGlAcA
   LHW+2wb6QPYkVvfzpH+ui5pSqGp1ioo97fs/4unk7JoI5UwBb+WJLgct5
   wF7oG7DFr/bxdTboWyZydL2D/+vWS1sRhF1YXZY7s4BGAed0AhOiL0rmJ
   U=;
X-IronPort-AV: E=Sophos;i="6.13,281,1732579200"; 
   d="scan'208";a="22128648"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 02:19:57 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:19491]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.187:2525] with esmtp (Farcaster)
 id 9554d1f6-9a6f-4182-bbea-84fa6ed14613; Thu, 13 Feb 2025 02:19:57 +0000 (UTC)
X-Farcaster-Flow-ID: 9554d1f6-9a6f-4182-bbea-84fa6ed14613
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 02:19:55 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Feb 2025 02:19:48 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<eddyz87@gmail.com>, <edumazet@google.com>, <haoluo@google.com>,
	<horms@kernel.org>, <john.fastabend@gmail.com>, <jolsa@kernel.org>,
	<kpsingh@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<martin.lau@linux.dev>, <ncardwell@google.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <sdf@fomichev.me>, <song@kernel.org>,
	<yonghong.song@linux.dev>
Subject: Re: [PATCH net-next 1/3] tcp: add TCP_RTO_MAX_MIN_SEC definition
Date: Thu, 13 Feb 2025 11:19:38 +0900
Message-ID: <20250213021938.75357-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250213004355.38918-2-kerneljasonxing@gmail.com>
References: <20250213004355.38918-2-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB003.ant.amazon.com (10.13.139.165) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 13 Feb 2025 08:43:52 +0800
> Add minimum value definition as the lower bound of RTO MAX
> set by users. In the next patch, bpf_sol_tcp_setsockopt()
> will use this in the test statement.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

