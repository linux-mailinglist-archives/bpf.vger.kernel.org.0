Return-Path: <bpf+bounces-54565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19418A6C79A
	for <lists+bpf@lfdr.de>; Sat, 22 Mar 2025 05:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45FEC178174
	for <lists+bpf@lfdr.de>; Sat, 22 Mar 2025 04:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EA414901B;
	Sat, 22 Mar 2025 04:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hbpM0eCH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78852E339B;
	Sat, 22 Mar 2025 04:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742619243; cv=none; b=EpPg4Eydflb2jisbRblx5hOQ+AiC1uU1ZiSvIpnLC8Kmj+V+ny37aZAdZXqcsByy4wCN7FEl1LCrI2D6G19GfV/VCvDtDDUWdg6nvdocSo9sMrBZnBoCH0bTuCICEi4vQBcoIAMBUHfYe0N1QtgA5blGeBaeOcjbhrbur0D9L3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742619243; c=relaxed/simple;
	bh=ZJgQeKyxTTzfAeXRGE4wTBC+AL7c9MPzmPtv0+52ID8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a3dFETzZ3f1h8daJKDIjkQccZ6uHB4oNmrotRXtqq4xDmc1nV2Qb9U50GFimFzmKT0O4oI6YX5vLJ9bzvv+HJm50K39hIUpFd9qsFCmZHw5CahT4EX0k3AQiNPj9iT9OBFtIUm3t4J9MoChE3D9C7E6DSdMPQdGuKCM+JNYfYR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=hbpM0eCH; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742619241; x=1774155241;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mwMhIpOwdTY8b8egTfnClW+BLSI90Ie+Jj6s1J1nYAI=;
  b=hbpM0eCHidaD0+EjxbFLUPraZDHYPEAoxtG+x0QmbnQ+IJpHzIRKDI1C
   RpfHHlqKv+5XhsByGsKN6ncQdLyrHyE3DKfrgtF6emH+tzVNnu/2ms4nd
   RIcXh0RE52Q8qU1tBk4KQzRsNzt3jTBkkqANx8IsYlIgRVTqq9ytqgc1K
   M=;
X-IronPort-AV: E=Sophos;i="6.14,266,1736812800"; 
   d="scan'208";a="184158914"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2025 04:53:59 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:47781]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.45:2525] with esmtp (Farcaster)
 id 332547ea-fffb-4b5c-862c-c0278ae9cb70; Sat, 22 Mar 2025 04:53:59 +0000 (UTC)
X-Farcaster-Flow-ID: 332547ea-fffb-4b5c-862c-c0278ae9cb70
Received: from EX19D003ANC003.ant.amazon.com (10.37.240.197) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 22 Mar 2025 04:53:57 +0000
Received: from b0be8375a521.amazon.com (10.37.245.7) by
 EX19D003ANC003.ant.amazon.com (10.37.240.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 22 Mar 2025 04:53:51 +0000
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
Subject: [PATCH v3 bpf-next 0/2] bpf: Fix OOB read and add tests for load-acquire/store-release
Date: Sat, 22 Mar 2025 13:52:54 +0900
Message-ID: <20250322045340.18010-4-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC001.ant.amazon.com (10.13.139.223) To
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
  v3:
    - Change invalid register from R11 to R15 in new tests
  v2: https://lore.kernel.org/all/20250321110010.95217-4-enjuk@amazon.com/
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


