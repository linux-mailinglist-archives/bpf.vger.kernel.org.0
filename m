Return-Path: <bpf+bounces-74674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FEBC6172B
	for <lists+bpf@lfdr.de>; Sun, 16 Nov 2025 15:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D3394ECE4B
	for <lists+bpf@lfdr.de>; Sun, 16 Nov 2025 14:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F9730B52A;
	Sun, 16 Nov 2025 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="EbyHrP1l"
X-Original-To: bpf@vger.kernel.org
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDD92F39AF
	for <bpf@vger.kernel.org>; Sun, 16 Nov 2025 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763305108; cv=none; b=XSimNaLCK0EQXEEPKe1PrVx3n//ib1IzGSIxbevELgWJOsoAMOoN9TN4V9BAfZVpzn2VzXgG9vAax0qmQXGsNOcZBge09dqEpqYHmce/z54AjlFjzRT6UmlLDiq0lQ8kDHmwrV9RF+5FSN4cUkS9377BpxBF+1LCN9sSCRlJHdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763305108; c=relaxed/simple;
	bh=sDLWQB1chOnQ+OXFkW8rsNT/cW1nZdopWnWP4PoVKB4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=snt/KbRXkKf7F/j2zpyuIozsD21WRsvQ+h1zb9RYfMXnCn/KkqsXhX6J4RJR/TURbZAppw0cn9nrunQl/iFC96OZxgL45aydoonAv1+KnGXVCMuZOHmK8pxxQlze4iHMUnNxNLDwg0XZCk9GZcaNlC6jyKmIA5hxPkmq6LQX3pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=EbyHrP1l; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1763305096; bh=UClAcNxcWUrwNakyC1v8MBC40xhrBlUFaVXLPYMUnr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EbyHrP1lrmvTIQWcRGStqqN7I4Wv95OJA1hjcQD/tbaIH2x+HeM+zs1U5d6SMZ68S
	 kdxOQJvewDrf558V6YeozJBWZOgz+Bu4zQ1nJAvPKOuzbSI7UJEQEhANGYgbCoea4i
	 hlBB3+cprUueu/kj7bhSRcBzJkCrl030Cb9OAH1Q=
Received: from lxu-ped-host.. ([111.201.7.117])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id E8C9BCB4; Sun, 16 Nov 2025 22:58:12 +0800
X-QQ-mid: xmsmtpt1763305092tbh6zvk9v
Message-ID: <tencent_3F226F882CE56DCC94ACE90EED1ECCFC780A@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoemJsVEB6ryQkkB0ir3RrhBULE99wMSjaQGh8vIT4I4eUB+BBI7E
	 gr9+BBcrYUX+uSKVU/4PN6PFpQBMirC3+L1lUsTVX+3M0SsPGknh3220KSlzxuXy3wVn+acaAKdL
	 ydnZYkiW2+RnFxFYEcXvkHuA2IPljBJAKfS2YXUMXleWwdSWeozShccoOmszokuZpA79ue2mbOgj
	 /f2hMO9o9fh90m+HCdJdMyQ5KmOn1Xhfz2ZlInT/uK6NrMwttkXrDzqhR1vpnBkkGM3MAbs25BX2
	 3zDMa/MJSRAr18bKe1D95mJR78ZEH9WEzx4BEvHVOWfy9NGqWmKOnnhrVxlFfG2IClE+WW5Gi07V
	 /X6Dj8XFC2AdxYiHYr0DoxNZKin4yrQ2TWhxFKzCk0v/J13Po3/62Ud22BYS8fXsQjC/ts1Vsw6R
	 OcC8/G1Zje60fc2BgmfRht8UeQ1Ly0ZsH7eWLqpT43Cb6eXG7SFv9blZ+duw1xwmDo+3a7suA9jK
	 dSNhiuh9UY136aY2eClOEL20gqXzAw7SIQlk+VBlC0J0Tl1qzJH0h9VP1gQsl9dAtEnqcyd8tNAy
	 cKdwHA5h1WATqDXDx2KGr4vMoDTJOyJpmqAvhq1gKbXWRFNuGE5Bd/aSlyUKAh56Scao3xTVMuna
	 PDEWj2x9ywHMk2tIkEYnx54Ktm99alZktG+8ICHiDfAfXSUv8PtbIOM0ucRyfiv0FCQyAlAICQSS
	 z1Z3FvyINsLAl9rH/sb1qDDaQOC4rYRpxklvfdOHsjWUfbwAMTvDXCjZ9mqh4dIWxB9DGQdJ7GPu
	 hfSafXIBZPJdQTnaOhrPga10IxoG2O4cnSzuD6aN4WUKwnX6mUeYK1KZjl8msmEOW2lwUvtOwcaZ
	 BgxS1Rtpj1CWNggiW4IeGMwVx1EHhbXxWkbTZbTccSmWL32J9jPeDMvcc5PcqJautjOGxFCkje3/
	 +r8qty0K9dkfjlxTZ19TqS4AI8vV3DRXwFx1kw/CmOBWjUm7FIJ/QuPGy4fymHc6mY3DzLffH8rw
	 oi7sltsw==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+cf08c551fecea9fd1320@syzkaller.appspotmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	song@kernel.org,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: [PATCH] bpf: Plug a potential exclusive map memory leak
Date: Sun, 16 Nov 2025 22:58:13 +0800
X-OQ-MSGID: <20251116145812.64225-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6919bd8f.a70a0220.3124cb.007d.GAE@google.com>
References: <6919bd8f.a70a0220.3124cb.007d.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When excl_prog_hash is 0 and excl_prog_hash_size is non-zero, the map also
needs to be freed. Otherwise, the map memory will not be reclaimed, just
like the memory leak problem reported by syzbot [1]. 

syzbot reported:
BUG: memory leak
  backtrace (crc 7b9fb9b4):
    map_create+0x322/0x11e0 kernel/bpf/syscall.c:1512
    __sys_bpf+0x3556/0x3610 kernel/bpf/syscall.c:6131

Fixes: baefdbdf6812 ("bpf: Implement exclusive map creation")
Reported-by: syzbot+cf08c551fecea9fd1320@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=cf08c551fecea9fd1320
Tested-by: syzbot+cf08c551fecea9fd1320@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 kernel/bpf/syscall.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8a129746bd6c..aa0979e8de15 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1585,7 +1585,8 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 			goto free_map;
 		}
 	} else if (attr->excl_prog_hash_size) {
-		return -EINVAL;
+		err = -EINVAL;
+		goto free_map;
 	}
 
 	err = security_bpf_map_create(map, attr, token, uattr.is_kernel);
-- 
2.43.0


