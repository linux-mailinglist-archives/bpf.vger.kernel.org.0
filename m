Return-Path: <bpf+bounces-57551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FEDAACCF6
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 20:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54101C40802
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 18:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518B128640F;
	Tue,  6 May 2025 18:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="u5Vi2P8C"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD5B225A47;
	Tue,  6 May 2025 18:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746555409; cv=none; b=BfGsFGy0ZIZ+dWCerSimvVk6ZoC8zgl29ca/erihiklL5IHe4MQNsSy5X4saU5ZmBtA6cAvlRN7sBug+HFzn8TtP9WSMklcupNrZfhu3CdcTXRHx9lzJD0klnEK1cs95i4NCYhDcWFH1WkguYf7JpxEZgiUMV/oLtnm5f7qghXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746555409; c=relaxed/simple;
	bh=bSUCBmlNsYf88bLYvfLSHg7pJ1ObvwhDHQRTr5xoGwE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OlQm00d2iRcywRSrR8f+2tyRUc/LDs1wuHzqTOmIBLw+tAfKYmS3uCKxsb2OlmhLKrxAsRtNmuQYgNgbk2GOuktoe2PzeycmfbQAJg0gyZxIp1KuUAuFOrtlRGTBumpLkqB9kHB4waCPN+NGGXowX2qeh4DbzKNL4p125lSW3nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=u5Vi2P8C; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746555408; x=1778091408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bSUCBmlNsYf88bLYvfLSHg7pJ1ObvwhDHQRTr5xoGwE=;
  b=u5Vi2P8C4uTTof+SJly9CKJb9Mo0tVv3gseCvvwiQfakmWpqSWVdmeUb
   8wthiyOe5Fa6c4meTHNCn+CYy2OYMgcie/QSDToX29yyLmKtPDFQZ3fDq
   0ai3TOYpfM4uvwHMSqV18mWTch/WWHfqYKynaePg9/MkfMDE5PyWhpyEI
   k=;
X-IronPort-AV: E=Sophos;i="6.15,267,1739836800"; 
   d="scan'208";a="487306728"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 18:16:43 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:18315]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.105:2525] with esmtp (Farcaster)
 id 9a05c608-6fb1-4b6b-ab84-b3ff1d996523; Tue, 6 May 2025 18:16:42 +0000 (UTC)
X-Farcaster-Flow-ID: 9a05c608-6fb1-4b6b-ab84-b3ff1d996523
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 6 May 2025 18:16:42 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 6 May 2025 18:16:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <memxor@gmail.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<brauner@kernel.org>, <casey@schaufler-ca.com>, <daniel@iogearbox.net>,
	<eddyz87@gmail.com>, <gnoack@google.com>, <haoluo@google.com>,
	<jmorris@namei.org>, <john.fastabend@gmail.com>, <jolsa@kernel.org>,
	<kpsingh@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<linux-security-module@vger.kernel.org>, <martin.lau@linux.dev>,
	<mic@digikod.net>, <netdev@vger.kernel.org>, <omosnace@redhat.com>,
	<paul@paul-moore.com>, <sdf@fomichev.me>, <selinux@vger.kernel.org>,
	<serge@hallyn.com>, <song@kernel.org>, <stephen.smalley.work@gmail.com>,
	<yonghong.song@linux.dev>
Subject: Re: [PATCH v1 bpf-next 0/5] af_unix: Allow BPF LSM to scrub SCM_RIGHTS at sendmsg().
Date: Tue, 6 May 2025 11:16:24 -0700
Message-ID: <20250506181630.8665-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CAP01T74osG0y2LPY1uhmZtf4ag==RZ1OjLU3wQu_c-z5Wr2ZbA@mail.gmail.com>
References: <CAP01T74osG0y2LPY1uhmZtf4ag==RZ1OjLU3wQu_c-z5Wr2ZbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB003.ant.amazon.com (10.13.139.168) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 6 May 2025 18:25:14 +0200
> Given you're probably going to drop scrubbing, all you'd need is to
> pass the pointer to file to inspect is f = bpf_core_cast(&fpl->fp[i],
> struct file).

Ah, I totally forgot bpf_core_cast().


> Then just find out the type of file using f->f_ops == something and if
> a disallowed file type is seen, return the verdict.

I'll change selftest as such.

Thanks!

