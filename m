Return-Path: <bpf+bounces-54091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63276A6265F
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 06:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C9319C3F5A
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 05:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B6E190678;
	Sat, 15 Mar 2025 05:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="aswVEg7H"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FF42E3387;
	Sat, 15 Mar 2025 05:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742015476; cv=none; b=FOHP4H+HV70au7osKRroj/55FoeF5A00SwIHLN75a3dH6lmhrHXKXh0ZzyVxL7Exk71y5rZSv9AQchCSy+/DY+RpUI4DeyEnh5Svx004Y3zAgQhicSYXcoSTNa2e+UstkMuyJiC1bh3hiArkZmUYD7Da1p4OKNV/xXrfG3uHFY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742015476; c=relaxed/simple;
	bh=NqKwFgpKi816zRiQPxPI7LUxFYDCz/3da+AyDCXBcLs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJ07qkNpYdfDIsR+YkLuXOwxqQ20i4zaBU5TiVNpEs0rLMo66JLJnbp4SV0lHQHsaa4f4YmbHXa+o6NmqBGSusWWp8QwhXCSY2IILE97AH+HE8DtU9dklmnTVGY7giQnCwgY2zEhU7iPe881I3lctBev8IcWv/mnTwf5np35u8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=aswVEg7H; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742015475; x=1773551475;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JfjgqpY7tQ6WrFEhDQ4MyqDUhRzWEFQO9NC3rzmEyLY=;
  b=aswVEg7HQ6MgV1K6R2SiC2MAUo2xnIJVchH5SPWTk26jK3kxXQIMDldY
   GDsupGLtS6Gf3m5hTY9vAIm7JJnH8zXk+xTOLX7tBhUuG7aVSuchUgCkA
   Oveq/n2PbH/XYaeSCWW2ed80VSl2fAPBukGFZYlNnT7rD9cKoFyXEZiDe
   A=;
X-IronPort-AV: E=Sophos;i="6.14,249,1736812800"; 
   d="scan'208";a="503000956"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2025 05:11:09 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:52533]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.235:2525] with esmtp (Farcaster)
 id 4fc01230-8a0c-43d5-8f2c-450cbf6d679e; Sat, 15 Mar 2025 05:11:08 +0000 (UTC)
X-Farcaster-Flow-ID: 4fc01230-8a0c-43d5-8f2c-450cbf6d679e
Received: from EX19D003ANC003.ant.amazon.com (10.37.240.197) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 15 Mar 2025 05:11:06 +0000
Received: from b0be8375a521.amazon.com (10.118.246.93) by
 EX19D003ANC003.ant.amazon.com (10.37.240.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 15 Mar 2025 05:11:00 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <eddyz87@gmail.com>, <enjuk@amazon.com>,
	<haoluo@google.com>, <iii@linux.ibm.com>, <john.fastabend@gmail.com>,
	<jolsa@kernel.org>, <kpsingh@kernel.org>, <linux-kernel@vger.kernel.org>,
	<martin.lau@linux.dev>, <netdev@vger.kernel.org>, <sdf@fomichev.me>,
	<song@kernel.org>, <syzkaller-bugs@googlegroups.com>, <yepeilin@google.com>,
	<yonghong.song@linux.dev>
Subject: Re: [syzbot] [bpf?] KASAN: slab-out-of-bounds Read in atomic_ptr_type_ok
Date: Sat, 15 Mar 2025 14:10:21 +0900
Message-ID: <20250315051051.1532-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67d479a8.050a0220.1939a6.004e.GAE@google.com>
References: <67d479a8.050a0220.1939a6.004e.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB003.ant.amazon.com (10.13.139.165) To
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
+       int err;
+
+       err = check_load_mem(env, insn, true, false, false, "atomic_load");
+       if (err)
+               return err;
+
        if (!atomic_ptr_type_ok(env, insn->src_reg, insn)) {
                verbose(env, "BPF_ATOMIC loads from R%d %s is not allowed\n",
                        insn->src_reg,
@@ -7795,12 +7801,18 @@ static int check_atomic_load(struct bpf_verifier_env *env,
                return -EACCES;
        }

-       return check_load_mem(env, insn, true, false, false, "atomic_load");
+       return 0;
 }

 static int check_atomic_store(struct bpf_verifier_env *env,
                              struct bpf_insn *insn)
 {
+       int err;
+
+       err = check_store_reg(env, insn, true);
+       if (err)
+               return err;
+
        if (!atomic_ptr_type_ok(env, insn->dst_reg, insn)) {
                verbose(env, "BPF_ATOMIC stores into R%d %s is not allowed\n",
                        insn->dst_reg,
@@ -7808,7 +7820,7 @@ static int check_atomic_store(struct bpf_verifier_env *env,
                return -EACCES;
        }

-       return check_store_reg(env, insn, true);
+       return 0;
 }

 static int check_atomic(struct bpf_verifier_env *env, struct bpf_insn *insn)

