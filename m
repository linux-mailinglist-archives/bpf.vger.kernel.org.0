Return-Path: <bpf+bounces-55896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 677B6A88DB0
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 23:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1829C1770BA
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 21:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51C51EA7DE;
	Mon, 14 Apr 2025 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Q6i7exG5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD691D63E4
	for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 21:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744665749; cv=none; b=fjLamex3zlkRYO4VN/my8eAtOUf0XjIaobEQ2pSY8xkz6zhviBq30DGrNQS5kv78FQsO/IvaA8HdIB1XwvJWjBiAFcAtNTBNMoyXzH38sJuuOr5+izaATp5712PXG2STQU0IUUUTn10soITsQgXFkqt4z76kW/avJHPfM8XXOv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744665749; c=relaxed/simple;
	bh=bDAKE910/56Ziie0LPNOMfumr8NUuJDWuK6jSDv9RkA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iQZl8x4B/zyjmR9HrVzvf0ThD/2fBAIYOSTQdWWd6UP/Ybbhr+/mXWyIth1CRBnU91kiBSFiA5Po+DeCk09Ime++VlqHNZ7Pbrm2eBugWyDn/H/Ghin7/eVCS3woBav8TnGQXZWKaiTsNmpVToQ6ElgexRAfcktathihxsaVd08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Q6i7exG5; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744665747; x=1776201747;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2D/jWCliOGGnsd2BR3edt4HF3mzJ8wLVnJ5y//w1DMU=;
  b=Q6i7exG555H8DaVmROSfvoR+BQ0XLz7Rf5BRM9uXjaJKKJSZcrw+7zJ+
   +HBG0zCRkmjOMr/c3g8Bq4JjMzVekj+R2UPWBxA8SxJmbf2hI+Dbar5bW
   bBe9eYRTpuVAZyj2632JzruAFg+QqABdddRYn+eiQcRMLnwAPUbT2Zrty
   8=;
X-IronPort-AV: E=Sophos;i="6.15,212,1739836800"; 
   d="scan'208";a="480345669"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 21:22:22 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:6451]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.159:2525] with esmtp (Farcaster)
 id 93bdadb1-625c-43a6-b96a-5c06232cb7e4; Mon, 14 Apr 2025 21:22:22 +0000 (UTC)
X-Farcaster-Flow-ID: 93bdadb1-625c-43a6-b96a-5c06232cb7e4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 21:22:21 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 21:22:16 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
CC: Shahab Vahedi <list+bpf@vahedi.org>, Russell King <linux@armlinux.org.uk>,
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>, Johan Almbladh
	<johan.almbladh@anyfinetworks.com>, Paul Burton <paulburton@kernel.org>,
	"Hari Bathini" <hbathini@linux.ibm.com>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=
	<bjorn@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>, Xi Wang
	<xi.wang@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens
	<hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, "David S. Miller"
	<davem@davemloft.net>, Wang YanQing <udknight@gmail.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<bpf@vger.kernel.org>
Subject: [PATCH v1 bpf 0/2] bpf: Don't trigger __bpf_prog_ret0_warn() for -ENOMEM.
Date: Mon, 14 Apr 2025 14:21:48 -0700
Message-ID: <20250414212207.63163-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

syzkaller reported a splat in __bpf_prog_ret0_warn() with a
sane bpf prog, which was triggered by fault injection.

This series suppresses the warning in such a case.


Kuniyuki Iwashima (2):
  bpf: Allow bpf_int_jit_compile() to set errno.
  bpf: Set -ENOMEM to err in bpf_int_jit_compile().

 arch/arc/net/bpf_jit_core.c      | 21 +++++++++++++--------
 arch/arm/net/bpf_jit_32.c        | 10 ++++++++--
 arch/arm64/net/bpf_jit_comp.c    | 10 ++++++++--
 arch/loongarch/net/bpf_jit.c     | 10 ++++++++--
 arch/mips/net/bpf_jit_comp.c     | 15 +++++++++++----
 arch/parisc/net/bpf_jit_core.c   | 10 ++++++++--
 arch/powerpc/net/bpf_jit_comp.c  | 10 ++++++++--
 arch/riscv/net/bpf_jit_core.c    | 10 ++++++++--
 arch/s390/net/bpf_jit_comp.c     |  9 +++++++--
 arch/sparc/net/bpf_jit_comp_64.c | 10 ++++++++--
 arch/x86/net/bpf_jit_comp.c      | 11 +++++++++--
 arch/x86/net/bpf_jit_comp32.c    |  9 +++++++--
 include/linux/filter.h           |  2 +-
 kernel/bpf/core.c                |  6 ++++--
 kernel/bpf/verifier.c            | 21 +++++++++++++++------
 15 files changed, 123 insertions(+), 41 deletions(-)

-- 
2.49.0


