Return-Path: <bpf+bounces-60014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59839AD1306
	for <lists+bpf@lfdr.de>; Sun,  8 Jun 2025 17:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A68B8188B4E3
	for <lists+bpf@lfdr.de>; Sun,  8 Jun 2025 15:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0268152E02;
	Sun,  8 Jun 2025 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b="LkOSeTj/"
X-Original-To: bpf@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CAE4502A
	for <bpf@vger.kernel.org>; Sun,  8 Jun 2025 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749396921; cv=none; b=X7ismhuCsR3pkkRDxSQV/RSizX7Z5a3LZi4EaXJF3HzeRjl3t6SwaiQIp5x1TyBXX6xD6HoyRDFJoyKbvMKS7C2+Hxz1CGe+lA8RUhc2ZQnwSUDGpg3Ve+8EIu5lw0yl1XodnxkCzWETkd5/N0viSL0rfA0wfJTcG2hKxIqjMMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749396921; c=relaxed/simple;
	bh=+7FrqGD94iVWcdbGz2+uCljqiSBoVQtmboCi9o5L1VE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XYVkEPESpK0uD948l5LnBu7sbwDkFpJeujtNitnYWmebJJJ8ld6PWhBZGQw8eQQZfE8JBfvoUdyFYUmat9PMdaev1dQFu9eL0msaFL1ZPkcFDxRLJSxukbOYGY17aFQODKx9TZYjK7fukcfthSvABJ7lA9rX3n4/ef1atpakHQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b=LkOSeTj/; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 4A84D240029
	for <bpf@vger.kernel.org>; Sun,  8 Jun 2025 17:35:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net;
	s=1984.ea087b; t=1749396917;
	bh=+7FrqGD94iVWcdbGz2+uCljqiSBoVQtmboCi9o5L1VE=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:From;
	b=LkOSeTj/YHKtLcJ/mB8whXDh7KtNkhjkCAzn9WTjlG7gvMEsLWqiJA+opAt++/fI5
	 YXKcTfP0QBufkq826TnL9qHarKSp9acOTKh7wjBMTfqI3TC3pEJZbqV168sAB/xjzq
	 01bz2j13nxIqMdKH/nn8tj2IVrvmJaM8lrKb9ZLCRBet9cs9cQh/pYwSOct29t5VeK
	 v+1T6AgY8Rm5MU57aHOSYNihJKgt49FmXQBKQ2iCNrOcyEU3c3e+i+pfNdcfgcPb0K
	 mtWat8/c6Fg99C9XXN4IreikGmzcZk0/hGVGI5j8GhkpArLEvqi5UyH8RGK4n+nK/P
	 nHHJOd0a+bRX+7JwF0nx03OPpMl8fFDFNIbBc4lG3uzKCVHZ23CPukwmmJMQwtGkKz
	 mU4u0BJn/aBVPtulV0dW2REvUpxln3KGidTT+Qg3TsyJ97Iv5ZKMWxdiUeQvM/C4qt
	 fRzMDeWIPUH3tEjOg47ZKEaIZCR+8RyP7kx8hBJrlJgx2/h21DD
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4bFfJK1d0pz6tvc;
	Sun,  8 Jun 2025 17:35:13 +0200 (CEST)
From: Charalampos Mitrodimas <charmitro@posteo.net>
Date: Sun, 08 Jun 2025 15:34:55 +0000
Subject: [PATCH bpf-next] bpf: Fix RCU usage in bpf_get_cgroup_classid_curr
 helper
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250608-rcu-fix-task_cls_state-v1-1-2a2025b4603b@posteo.net>
X-B4-Tracking: v=1; b=H4sIAJ6tRWgC/x2M7QpAQBAAX0X729ZxvvIqkq67xUbo9kjJu7v8n
 JqZB4Q8k0CbPODpYuF9i5ClCdjZbBMhu8iQq7xUlWrQ2xNHvjEYWQa7yiDBBEJFrtZjoWuXEcT
 48BStf9z17/sBBQ7m8GgAAAA=
X-Change-ID: 20250608-rcu-fix-task_cls_state-0ed73f437d1e
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Feng Yang <yangfeng@kylinos.cn>, 
 Tejun Heo <tj@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, syzbot+b4169a1cfb945d2ed0ec@syzkaller.appspotmail.com, 
 Charalampos Mitrodimas <charmitro@posteo.net>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749396896; l=1811;
 i=charmitro@posteo.net; s=20250526; h=from:subject:message-id;
 bh=+7FrqGD94iVWcdbGz2+uCljqiSBoVQtmboCi9o5L1VE=;
 b=YnnNXup1gwqyVg+Q760GVOdLmszHN8jeFOIQHKavcH7xBLebR+ekaAPuUS7md/qk9y1was3qj
 QLScmUeznjwCQec6DbpYC67nuAyHEyCP5kpLdrgSBwV/9ZPGoq2Zxve
X-Developer-Key: i=charmitro@posteo.net; a=ed25519;
 pk=PNHEh5o1dcr5kfKoZhfwdsfm3CxVfRje7vFYKIW0Mp4=

The commit ee971630f20f ("bpf: Allow some trace helpers for all prog
types") made bpf_get_cgroup_classid_curr helper available to all BPF
program types.  This helper used __task_get_classid() which calls
task_cls_state() that requires rcu_read_lock_bh_held().

This triggers an RCU warning when called from BPF syscall programs
which run under rcu_read_lock_trace():

  WARNING: suspicious RCU usage
  6.15.0-rc4-syzkaller-g079e5c56a5c4 #0 Not tainted
  -----------------------------
  net/core/netclassid_cgroup.c:24 suspicious rcu_dereference_check() usage!

Fix this by replacing __task_get_classid() with task_cls_classid()
which handles RCU locking internally using regular rcu_read_lock() and
is safe to call from any context.

Reported-by: syzbot+b4169a1cfb945d2ed0ec@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b4169a1cfb945d2ed0ec
Fixes: ee971630f20f ("bpf: Allow some trace helpers for all prog types")
Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 30e7d36790883b29174654315738e93237e21dd0..3b3f81cf674dde7d2bd83488450edad4e129bdac 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3083,7 +3083,7 @@ static const struct bpf_func_proto bpf_msg_pop_data_proto = {
 #ifdef CONFIG_CGROUP_NET_CLASSID
 BPF_CALL_0(bpf_get_cgroup_classid_curr)
 {
-	return __task_get_classid(current);
+	return task_cls_classid(current);
 }
 
 const struct bpf_func_proto bpf_get_cgroup_classid_curr_proto = {

---
base-commit: 079e5c56a5c41d285068939ff7b0041ab10386fa
change-id: 20250608-rcu-fix-task_cls_state-0ed73f437d1e

Best regards,
-- 
Charalampos Mitrodimas <charmitro@posteo.net>


