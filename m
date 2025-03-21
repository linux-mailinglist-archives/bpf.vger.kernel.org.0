Return-Path: <bpf+bounces-54538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB82BA6B969
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 12:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44EDF19C0D9C
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 11:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACBD221578;
	Fri, 21 Mar 2025 11:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="OlqUSf95"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FDE1EFF93;
	Fri, 21 Mar 2025 11:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742554846; cv=none; b=trT785JwcNiivPoTjNEapasQwzfBum+l9uW8jDJgkcVENzeNGriOds6Ni6FEeMdTi+bdKOtlCArdNmswE0Hg1Q8PM8fI7KRH4ZfpqX4txqEGmv9R2aajTZVa5tACsgOWTFQCNaJLdXKavpsiHqP6kaz3wN3jJt22+3Rv5si4c54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742554846; c=relaxed/simple;
	bh=6uAh4DyA5uukHlSVeiMOu2AM5c0+OP6b6mRrd4u9TSc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IwAFuVYzw6yIAcyMw3VfB8mlyidHiWQAPB7pCEJZzL+DkglEsckNw64iVPIl0aQZmOd0jG2pCXKmU1NgIMsfJ/qZldvFHyHc7thQtvqM1iVWjf8EHjI6WcgKxEc1aLqCV90d7C0XRj+k9Hy/jJW/dEZsRWwpIWoej3YPwJOzwWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=OlqUSf95; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742554844; x=1774090844;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CTNB5uKYjZrRcQPF588LU6kSYhvG/6lODUqFhdJSlYA=;
  b=OlqUSf95qltghDWT8Dnhwyz5jokZpkS5Am0Swa3WK8U7T3edZBqorIjd
   VXAvZSEtgfa7yyDpTJB/jykYNefaQA/SCvE3OyQ0EppUR4DsUfA6eipCi
   WYf8AphHhGcp/DeAXQ2JA76Y+GjjvsZ+Dd8ElKAwHVuufsmKlR9tr5v+m
   M=;
X-IronPort-AV: E=Sophos;i="6.14,264,1736812800"; 
   d="scan'208";a="76445985"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 11:00:35 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:21421]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.45:2525] with esmtp (Farcaster)
 id fd6e5c18-c6d0-4c15-95d3-d7e47153aa11; Fri, 21 Mar 2025 11:00:33 +0000 (UTC)
X-Farcaster-Flow-ID: fd6e5c18-c6d0-4c15-95d3-d7e47153aa11
Received: from EX19D003ANC003.ant.amazon.com (10.37.240.197) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Mar 2025 11:00:32 +0000
Received: from b0be8375a521.amazon.com (10.37.244.8) by
 EX19D003ANC003.ant.amazon.com (10.37.240.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Mar 2025 11:00:26 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, Peilin Ye <yepeilin@google.com>, Ilya Leoshkevich
	<iii@linux.ibm.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	<kohei.enju@gmail.com>, Kohei Enju <enjuk@amazon.com>,
	<syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com>
Subject: [PATCH v2 bpf-next 0/2] bpf: Fix OOB read and add tests for load-acquire/store-release
Date: Fri, 21 Mar 2025 19:59:00 +0900
Message-ID: <20250321110010.95217-4-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC003.ant.amazon.com (10.13.139.240) To
 EX19D003ANC003.ant.amazon.com (10.37.240.197)

This patch series addresses an out-of-bounds read issue in 
check_atomic_load/store() reported by syzkaller when an invalid register 
number (MAX_BPF_REG or greater) is used.

The first patch fixes the actual bug by changing the order of validity 
checks, ensuring register validity is checked before atomic_ptr_type_ok() 
is called.
It also updates some tests that were assuming the previous order of checks.

The second patch adds new tests specifically for the invalid register 
number case to prevent regression in the future.

Changes:
  v2: 
    - Just swap atomic_ptr_type_ok() and check_load_mem()/check_store_reg()
    - Update some tests that were assuming the previous order of checks
    - Add new tests specifically for the invalid register number
  v1: https://lore.kernel.org/bpf/20250314195619.23772-2-enjuk@amazon.com/

Reported-by: syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a5964227adc0f904549c

Kohei Enju (2):
  bpf: Fix out-of-bounds read in check_atomic_load/store()
  selftests/bpf: Add selftests for load-acquire/store-release when
    register number is invalid

 kernel/bpf/verifier.c                         | 16 +++++++++--
 .../bpf/progs/verifier_load_acquire.c         | 26 +++++++++++++++--
 .../bpf/progs/verifier_store_release.c        | 28 +++++++++++++++++--
 3 files changed, 63 insertions(+), 7 deletions(-)

-- 
2.49.0


