Return-Path: <bpf+bounces-54093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E24C0A626DB
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 07:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B0FA8815C9
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 05:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C1A1946B1;
	Sat, 15 Mar 2025 06:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="veJqE6dH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37197193402;
	Sat, 15 Mar 2025 06:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742018403; cv=none; b=CRdEu/Ps2eM2/FyDtDo1RN8Ub4KWWlk3zXkaLEjqy+KNjWhM8JQFPctNZnEdM29iaHbiGzj+I1zHKnk8pwuuKlnxcTeqUeqdyoUvqsE2bUZJ/L+1URVEKQacuh4GGm/fsBbrUzo424XQrV5AdXi40rC8NYFf6ZPdkkNSm9mNdTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742018403; c=relaxed/simple;
	bh=ryJGWDuUDRwXa8qdcev1UD3SLAbz7to/QUTh+YXVg98=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V89s1nqCeIeeJv86IZ0j2VWkJonJ9cNReFfxK4p2GHdh7PteN02akZ950eTbfe1ybXioEg4h1Sl4+mVP5QCZiiUzz6MB8v3Dd2qc2w8F1AU+QOQ4vCqBxW55v1gL+uhNzj28XDcauURwlGLChEdFsyMr4amwFLNZeS7VQBFAEQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=veJqE6dH; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742018402; x=1773554402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vv/VRE0LYhUW8Flr0gIv0j5jFwRlGze9RKBLm6vaAlo=;
  b=veJqE6dHKdHyZ3K31qBF69Zc2u6jF5Nuvv8e/eWj7gnHhCPG8TLCpvNU
   b9n6uGA3e6N7tUPzuXKGRnbXlgCu5IwcJ8zz2ACVBhw7X7EsBC3HE+o/v
   RZf02KnuJofVjpUeru8SUwiik8X404FypWkt0tou6HAi3uARY8qZmRwbs
   A=;
X-IronPort-AV: E=Sophos;i="6.14,249,1736812800"; 
   d="scan'208";a="32116866"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2025 06:00:00 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:24538]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.34:2525] with esmtp (Farcaster)
 id 399d2c3d-ff63-4df3-9920-f5b60fd27ed1; Sat, 15 Mar 2025 06:00:00 +0000 (UTC)
X-Farcaster-Flow-ID: 399d2c3d-ff63-4df3-9920-f5b60fd27ed1
Received: from EX19D003ANC003.ant.amazon.com (10.37.240.197) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 15 Mar 2025 05:59:56 +0000
Received: from b0be8375a521.amazon.com (10.118.246.93) by
 EX19D003ANC003.ant.amazon.com (10.37.240.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 15 Mar 2025 05:59:50 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <eddyz87@gmail.com>, <enjuk@amazon.com>,
	<haoluo@google.com>, <iii@linux.ibm.com>, <john.fastabend@gmail.com>,
	<jolsa@kernel.org>, <kpsingh@kernel.org>, <linux-kernel@vger.kernel.org>,
	<martin.lau@linux.dev>, <netdev@vger.kernel.org>, <sdf@fomichev.me>,
	<song@kernel.org>, <syzkaller-bugs@googlegroups.com>, <yepeilin@google.com>,
	<yonghong.song@linux.dev>
Subject: [syzbot] [bpf?] KASAN: slab-out-of-bounds Read in atomic_ptr_type_ok
Date: Sat, 15 Mar 2025 14:59:33 +0900
Message-ID: <20250315055941.10487-2-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67d51240.050a0220.14e108.0050.GAE@google.com>
References: <67d51240.050a0220.14e108.0050.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
 EX19D003ANC003.ant.amazon.com (10.37.240.197)

> syzbot tried to test the proposed patch but the build/boot failed:
> 
> failed to apply patch:
> checking file kernel/bpf/verifier.c
> patch: **** unexpected end of file in patch

Oh, something wrong with format, such as trailing space...?

#syz test

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3303a3605ee8..0120cc325078 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7788,6 +7788,12 @@ static int check_atomic_rmw(struct bpf_verifier_env *env,
 static int check_atomic_load(struct bpf_verifier_env *env,
 			     struct bpf_insn *insn)
 {
+	int err;
+
+	err = check_load_mem(env, insn, true, false, false, "atomic_load");
+	if (err)
+		return err;
+
 	if (!atomic_ptr_type_ok(env, insn->src_reg, insn)) {
 		verbose(env, "BPF_ATOMIC loads from R%d %s is not allowed\n",
 			insn->src_reg,
@@ -7795,12 +7801,18 @@ static int check_atomic_load(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	return check_load_mem(env, insn, true, false, false, "atomic_load");
+	return 0;
 }
 
 static int check_atomic_store(struct bpf_verifier_env *env,
 			      struct bpf_insn *insn)
 {
+	int err;
+
+	err = check_store_reg(env, insn, true);
+	if (err)
+		return err;
+
 	if (!atomic_ptr_type_ok(env, insn->dst_reg, insn)) {
 		verbose(env, "BPF_ATOMIC stores into R%d %s is not allowed\n",
 			insn->dst_reg,
@@ -7808,7 +7820,7 @@ static int check_atomic_store(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	return check_store_reg(env, insn, true);
+	return 0;
 }
 
 static int check_atomic(struct bpf_verifier_env *env, struct bpf_insn *insn)
-- 
2.48.1


