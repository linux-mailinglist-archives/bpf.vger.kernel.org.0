Return-Path: <bpf+bounces-54063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 393E0A61948
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 19:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33F6319C5135
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 18:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C549204876;
	Fri, 14 Mar 2025 18:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ol8hJbbh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9836C2A8D0;
	Fri, 14 Mar 2025 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741976384; cv=none; b=hihD9PlZer4gXfeGDPPV5kmLVqd5/E2L6mMmE4MFjT/3BM+L6MaTRodZC4kGovivEAlocd4wuwIpr7RW1B0lvAa+R/2iN5eHMAXMUul+NStsvK2BLw/gHicHvy9zXY9j2Ds29WBlqZ8Ol5iJ8C9u63txXQOhOIDWkGowDBaitUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741976384; c=relaxed/simple;
	bh=AOYfO4ZZb0Tcg03UebkhFJQ4VfghZe4t2bFK6GitxSo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b3UFBXLwUJsN0/Jw5HxFJJ6hY/Zpvg0iv/D/rDCdAjvV49HI13pSXiy/bMQ2RIrsVG5KimFV4wfGpqqVJEXpp7NDD/r/oSSDERm5OGOrIIf+ujcO4u59ThIpkYTDz6HNyRBu863YG8AEoFuzPxlLsCg2CbRQ1DmakRhX9nfel0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ol8hJbbh; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741976383; x=1773512383;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ydZtQRvTydeU4Abeyx8VyHan8eAipND3FLIzwSP4EMs=;
  b=ol8hJbbhQYdMHYaGOdkwxj4o0pfW1Vh0cFE7EHJbJhgBtrGCWc+8nynD
   bhLHdJ0VvubiP4lhhVr0Fmj+crYi6djPiEarfsppN7rYvy3silOBcMonI
   v7g7d1g2AqtEyFrEkQ0HW3iFNbNu6lLWDASHBCZmgMA9pl7M2z4Izr6YD
   g=;
X-IronPort-AV: E=Sophos;i="6.14,246,1736812800"; 
   d="scan'208";a="386789117"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 18:19:41 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:31107]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.245:2525] with esmtp (Farcaster)
 id ddda351e-1bdf-4c43-80a6-1c4b19950bed; Fri, 14 Mar 2025 18:19:40 +0000 (UTC)
X-Farcaster-Flow-ID: ddda351e-1bdf-4c43-80a6-1c4b19950bed
Received: from EX19D003ANC003.ant.amazon.com (10.37.240.197) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 14 Mar 2025 18:19:39 +0000
Received: from b0be8375a521.amazon.com (10.119.2.177) by
 EX19D003ANC003.ant.amazon.com (10.37.240.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 14 Mar 2025 18:19:34 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <eddyz87@gmail.com>, <haoluo@google.com>,
	<iii@linux.ibm.com>, <john.fastabend@gmail.com>, <jolsa@kernel.org>,
	<kpsingh@kernel.org>, <linux-kernel@vger.kernel.org>, <martin.lau@linux.dev>,
	<netdev@vger.kernel.org>, <sdf@fomichev.me>, <song@kernel.org>,
	<syzkaller-bugs@googlegroups.com>, <yepeilin@google.com>,
	<yonghong.song@linux.dev>
Subject: Re: [syzbot] [bpf?] KASAN: slab-out-of-bounds Read in atomic_ptr_type_ok
Date: Sat, 15 Mar 2025 03:19:25 +0900
Message-ID: <20250314181925.69459-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67d30ef2.050a0220.14e108.0039.GAE@google.com>
References: <67d30ef2.050a0220.14e108.0039.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D003ANC003.ant.amazon.com (10.37.240.197)

> syzbot found the following issue on:
> 
> HEAD commit:    f28214603dc6 Merge branch 'selftests-bpf-move-test_lwt_seg..
> git tree:       bpf-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=15f84664580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b7bde34acd8f53b1
> dashboard link: https://syzkaller.appspot.com/bug?extid=a5964227adc0f904549c
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16450ba8580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f5fa54580000

#syz test

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7788,6 +7788,12 @@ static int check_atomic_rmw(struct bpf_verifier_env *env,
 static int check_atomic_load(struct bpf_verifier_env *env,
 			     struct bpf_insn *insn)
 {
+	int err;
+
+	err = check_reg_arg(env, insn->src_reg, SRC_OP);
+	if (err)
+		return err;
+
 	if (!atomic_ptr_type_ok(env, insn->src_reg, insn)) {
 		verbose(env, "BPF_ATOMIC loads from R%d %s is not allowed\n",
 			insn->src_reg,
@@ -7801,6 +7807,12 @@ static int check_atomic_load(struct bpf_verifier_env *env,
 static int check_atomic_store(struct bpf_verifier_env *env,
 			      struct bpf_insn *insn)
 {
+	int err;
+
+	err = check_reg_arg(env, insn->dst_reg, SRC_OP);
+	if (err)
+		return err;
+
 	if (!atomic_ptr_type_ok(env, insn->dst_reg, insn)) {
 		verbose(env, "BPF_ATOMIC stores into R%d %s is not allowed\n",
 			insn->dst_reg,

