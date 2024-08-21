Return-Path: <bpf+bounces-37668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBEC95932A
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 05:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068901F241B6
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 03:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB2E1547D6;
	Wed, 21 Aug 2024 03:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdM4VeE6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9668D3FF1;
	Wed, 21 Aug 2024 03:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724209691; cv=none; b=gpRV/uaiNnXCe5d7x06QM5tnrzuhEVeKXLnmYORXYQsxvhEOvIwKI3HLHr1iXcH2TlLc+Sltm+t8jNzJlQD2yGzy0Xe7caKjG0z957j0L3Uzfy8Gmzv0hrGLdLbDRJHo2Zl7xW7CQJ0YyOiMaAsyfiBGCTeZMnFyN4sh782CDuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724209691; c=relaxed/simple;
	bh=bVNwORlRdJmHiJxBuirTCV/r+gzCqkmi/3IrtQSQvmo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u9LV6EsZK5s7KqEr0kcWjj6HOq2mVdHX87jw5QOs2vsf5R6uiC7Qmo1W2iAPfZ/Bi5R97vAd7ZB4j3kyWEZjbvfnCxWu0m8hLzXwmv99j711u9I6AKsf+xqzfV+GeflW4rwcBPRSKha8IpRkyVCosNWjYCAYI0hBLDUVfIRmMdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdM4VeE6; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70f5ef740b7so5582142b3a.2;
        Tue, 20 Aug 2024 20:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724209688; x=1724814488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ysc84ktuJkruKkhoctNQyWbQyN7dUXlVIHB4wrqTpuU=;
        b=hdM4VeE6kO9RJHx1IUgS1bfUY/rsU7aEAQiTzUOmed+6iDzUC13EOAk01ArazwyaVU
         8WU8K27Tn2VyEQWDVKyh6k8Y5mEjT+2RGgfidM7gPOhkbW9+ypPhyWe4xTD2okBbptAQ
         pR71UQzydZ/k+G+qxDLhkMKKEmYdkQQ21TnCKBnNQWFGPYrW3OQ3X9D/TEHLRnMJ2vnj
         1erONoyKLye23Ps28BXc0ON72CZ98KrXQWRmryZiFclKb/zyheFYXgCIRU0ybZqMJtCD
         fzVO8nC5yCDL+gldcDYwEgi6WYzI4SVWmsvoZyGaLZFrHYtqJHQMH0Q66FdYJnocErqm
         PISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724209688; x=1724814488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ysc84ktuJkruKkhoctNQyWbQyN7dUXlVIHB4wrqTpuU=;
        b=CDjMcujHRKyI9Q5RZKgamG2t8la1uZMStUMBzcRyLxd47tCG9fYz7dDXLLVpPigY43
         0OOMuTaGFVky++AtKu6lu3lxc8Rorf4h79aJlZSltmPgMzEo/jZ0/+wpYtVHEf5iWddC
         arzOXv5MggM74frjkisBzELSy5rOWrX3oAMF106cF0UbPoIa8Q8nllclNzMojDnboiMI
         HcyLIzYywRvFKzNJOTR4xyEqMWC1SSxOl+/iKBhnAR88xpSlO1AXFqwgBz39XDa2EiFp
         AnGGGXp82zkbm1bVpg21Q0TFMDwZzKlVQahQMjLuR58jQmls3nNKLccnHSYGeWHjDJrf
         Zi3w==
X-Gm-Message-State: AOJu0YzZMmSTuzMojmVKWvcSXBAme0nj5Rrl7MrbZ7h3lK6AxqaBXjhg
	AerVCl/MLQS4sGAHncMU+3gxJdZygtYFGEC8SWQmmbQbPvZ3lDMPSNrI7g==
X-Google-Smtp-Source: AGHT+IGQ8e3HdvHRNyrZ1Dxk82HHFf5ab2en8P9N824Mu+UsDhLL8veJqUKKh9fCqo6dXs1N6IHPdA==
X-Received: by 2002:a05:6a20:841e:b0:1c4:818c:299d with SMTP id adf61e73a8af0-1cad7f72934mr1838306637.11.1724209688479;
        Tue, 20 Aug 2024 20:08:08 -0700 (PDT)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:a83:7ca8:f92a:b089])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f02fb470sm84603105ad.9.2024.08.20.20.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 20:08:07 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>,
	syzbot+58c03971700330ce14d8@syzkaller.appspotmail.com,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>
Subject: [Patch bpf] tcp_bpf: fix return value of tcp_bpf_sendmsg()
Date: Tue, 20 Aug 2024 20:07:44 -0700
Message-Id: <20240821030744.320934-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

When we cork messages in psock->cork, the last message triggers the
flushing will result in sending a sk_msg larger than the current
message size. In this case, in tcp_bpf_send_verdict(), 'copied' becomes
negative at least in the following case:

468         case __SK_DROP:
469         default:
470                 sk_msg_free_partial(sk, msg, tosend);
471                 sk_msg_apply_bytes(psock, tosend);
472                 *copied -= (tosend + delta); // <==== HERE
473                 return -EACCES;

Therefore, it could lead to the following BUG with a proper value of
'copied' (thanks to syzbot). We should not use negative 'copied' as a
return value here.

  ------------[ cut here ]------------
  kernel BUG at net/socket.c:733!
  Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
  Modules linked in:
  CPU: 0 UID: 0 PID: 3265 Comm: syz-executor510 Not tainted 6.11.0-rc3-syzkaller-00060-gd07b43284ab3 #0
  Hardware name: linux,dummy-virt (DT)
  pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
  pc : sock_sendmsg_nosec net/socket.c:733 [inline]
  pc : sock_sendmsg_nosec net/socket.c:728 [inline]
  pc : __sock_sendmsg+0x5c/0x60 net/socket.c:745
  lr : sock_sendmsg_nosec net/socket.c:730 [inline]
  lr : __sock_sendmsg+0x54/0x60 net/socket.c:745
  sp : ffff800088ea3b30
  x29: ffff800088ea3b30 x28: fbf00000062bc900 x27: 0000000000000000
  x26: ffff800088ea3bc0 x25: ffff800088ea3bc0 x24: 0000000000000000
  x23: f9f00000048dc000 x22: 0000000000000000 x21: ffff800088ea3d90
  x20: f9f00000048dc000 x19: ffff800088ea3d90 x18: 0000000000000001
  x17: 0000000000000000 x16: 0000000000000000 x15: 000000002002ffaf
  x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
  x11: 0000000000000000 x10: ffff8000815849c0 x9 : ffff8000815b49c0
  x8 : 0000000000000000 x7 : 000000000000003f x6 : 0000000000000000
  x5 : 00000000000007e0 x4 : fff07ffffd239000 x3 : fbf00000062bc900
  x2 : 0000000000000000 x1 : 0000000000000000 x0 : 00000000fffffdef
  Call trace:
   sock_sendmsg_nosec net/socket.c:733 [inline]
   __sock_sendmsg+0x5c/0x60 net/socket.c:745
   ____sys_sendmsg+0x274/0x2ac net/socket.c:2597
   ___sys_sendmsg+0xac/0x100 net/socket.c:2651
   __sys_sendmsg+0x84/0xe0 net/socket.c:2680
   __do_sys_sendmsg net/socket.c:2689 [inline]
   __se_sys_sendmsg net/socket.c:2687 [inline]
   __arm64_sys_sendmsg+0x24/0x30 net/socket.c:2687
   __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
   invoke_syscall+0x48/0x110 arch/arm64/kernel/syscall.c:49
   el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:132
   do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:151
   el0_svc+0x34/0xec arch/arm64/kernel/entry-common.c:712
   el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
   el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
  Code: f9404463 d63f0060 3108441f 54fffe81 (d4210000)
  ---[ end trace 0000000000000000 ]---

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Reported-by: syzbot+58c03971700330ce14d8@syzkaller.appspotmail.com
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 net/ipv4/tcp_bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 53b0d62fd2c2..fe6178715ba0 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -577,7 +577,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 		err = sk_stream_error(sk, msg->msg_flags, err);
 	release_sock(sk);
 	sk_psock_put(sk, psock);
-	return copied ? copied : err;
+	return copied > 0 ? copied : err;
 }
 
 enum {
-- 
2.34.1


