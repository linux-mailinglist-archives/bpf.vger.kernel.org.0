Return-Path: <bpf+bounces-60358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDE6AD5D36
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 19:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90201188D547
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 17:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF202248BF;
	Wed, 11 Jun 2025 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b="A5Md52u3"
X-Original-To: bpf@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACDA222561
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 17:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749662471; cv=none; b=qnOH5IEg/mKwGuevTWBRHpoZXI8EjsMxKdNg7Nw1sWc7U3KWQDEpi18dlZ2vuKm6ZWfrIy+qBjG2SXrX95fTYD7cEtSX6fMkdC4+0SX86tU6HV4FqEWWVR8JH3G3shzOpvYCHwPcvHhoRS8zvNc+aevrTlNeG/92bMyjgp9zysw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749662471; c=relaxed/simple;
	bh=u5Kk1jfvzFrOwlCXwYxoep/9dBDPOwrOQVQdE3Geobw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=C9Woqk2GWImZm18X++r/v4f+Tz/54iG9LqN25UikQcgsMFIukmRLqJQg90gSjQ5bUQV24yO0UtWDI+MiwtjV3dnD+OC1F71HTTF8tTGm2zDTuPFor1ACjLJQc6FeXKuHNgKT/hyt7Ku/CbRtHN+FLzcARj1WeYpRKAn8t6xKGBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b=A5Md52u3; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 5B212240101
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 19:21:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net;
	s=1984.ea087b; t=1749662467;
	bh=u5Kk1jfvzFrOwlCXwYxoep/9dBDPOwrOQVQdE3Geobw=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:From;
	b=A5Md52u3STlkO+A8jTT+13k1GA3nD1EBgT6khcCenX/tpCDQSURx9JPPCVEBBHfXb
	 eZzOT1HsHBVaGUqYPzH02x4srcEGZer2OgO0WGiv6/dueoIu4mcT8Pu6NXpP2Ndhxq
	 yq5/9d83/1d0Qz5W58Oqj7yjbCwIcjq3oL1yaIx28k1hClgRVafa/GdYJVtb2nmOhJ
	 GlPPnpmIArGpb0ls3pFhioBSjphuortNfRRXyibVYOozphg/KxuQ5k+8OXh0QMWoOC
	 TjYVvv62gb/mCO8W+dpH3oPPUOcGi2Mx++WS/ldb4SLfBDidrseF7OVhgYMvi5pFAp
	 xQRM30E1zv/K7YuEcXOb+nQr8jaHLir+p64PvyIH3QZN0B8nfE7Gpf8QoupLV+wDNb
	 V8c4lRb+/aLqXNaqd8oAMP45JlSvR6nfEtEyHEinPQMeJB5aemwbxl1SgZYFLDjoYD
	 kWR2mzs87p7pGq9RKP419oYEJ8aMqwSALe52YeKvIpFpxcxQUOP
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4bHXW323xjz9rxQ;
	Wed, 11 Jun 2025 19:21:03 +0200 (CEST)
From: Charalampos Mitrodimas <charmitro@posteo.net>
Date: Wed, 11 Jun 2025 17:20:43 +0000
Subject: [PATCH bpf-next v3] net: Fix RCU usage in task_cls_state() for BPF
 programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-rcu-fix-task_cls_state-v3-1-3d30e1de753f@posteo.net>
X-B4-Tracking: v=1; b=H4sIAOq6SWgC/4XNQQ6CMBAF0KuQrq1ppxWIK+9hDCllkEZDSac2G
 sLdLax0YVz+yf9vZkYYHBI7FjMLmBw5P+agdgWzgxmvyF2XMwMBB1GKmgf74L178mjo1tg7NRR
 NRC6wq1SvVdVJZHk8BcytDT5fch4cRR9e258k1+tfMkkuOZi11upSqPY0eYro9yNGtpoJPhwpf
 zqQHWmq3oKuQYH5cpZleQNGtF7QBQEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749662443; l=2729;
 i=charmitro@posteo.net; s=20250526; h=from:subject:message-id;
 bh=u5Kk1jfvzFrOwlCXwYxoep/9dBDPOwrOQVQdE3Geobw=;
 b=cOJU/Y97B/mIsiD6ycUzLbHOj+hDqh9honeXQ3bF5ZN1FpCw/P9xFzMlBjxDgS6XhO9jdIj0R
 BW5omZ1EtlGBMPPQfoVetlQvPuxjKIUWGThuj0Mz8r5uXn4WqXjI4A4
X-Developer-Key: i=charmitro@posteo.net; a=ed25519;
 pk=PNHEh5o1dcr5kfKoZhfwdsfm3CxVfRje7vFYKIW0Mp4=

The commit ee971630f20f ("bpf: Allow some trace helpers for all prog
types") made bpf_get_cgroup_classid_curr helper available to all BPF
program types, not just networking programs.

This helper calls __task_get_classid() which internally calls
task_cls_state() requiring rcu_read_lock_bh_held(). This works in
networking/tc context where RCU BH is held, but triggers an RCU
warning when called from other contexts like BPF syscall programs that
run under rcu_read_lock_trace():

  WARNING: suspicious RCU usage
  6.15.0-rc4-syzkaller-g079e5c56a5c4 #0 Not tainted
  -----------------------------
  net/core/netclassid_cgroup.c:24 suspicious rcu_dereference_check() usage!

Fix this by also accepting rcu_read_lock_held() and
rcu_read_lock_trace_held() as valid RCU contexts in the
task_cls_state() function. This ensures the helper works correctly in
all RCU contexts where it might be called, regular RCU, RCU BH (for
networking), and RCU trace (for BPF syscall programs).

Reported-by: syzbot+b4169a1cfb945d2ed0ec@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b4169a1cfb945d2ed0ec
Fixes: ee971630f20f ("bpf: Allow some trace helpers for all prog types")
Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
---
Changes in v3:
- Add rcu_read_lock_held() check as well 
- Link to v2: https://lore.kernel.org/r/20250611-rcu-fix-task_cls_state-v2-1-1a7fc248232a@posteo.net

Changes in v2:
- Fix RCU usage in task_cls_state() instead of BPF helper
- Add rcu_read_lock_trace_held() check to accept trace RCU as valid
  context
- Drop the approach of using task_cls_classid() which has in_interrupt()
  check
- Link to v1: https://lore.kernel.org/r/20250608-rcu-fix-task_cls_state-v1-1-2a2025b4603b@posteo.net
---
 net/core/netclassid_cgroup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/netclassid_cgroup.c b/net/core/netclassid_cgroup.c
index d22f0919821e931fbdedf5a8a7a2998d59d73978..dff66d8fb325d28bb15f42641b9ec738b0022353 100644
--- a/net/core/netclassid_cgroup.c
+++ b/net/core/netclassid_cgroup.c
@@ -21,7 +21,9 @@ static inline struct cgroup_cls_state *css_cls_state(struct cgroup_subsys_state
 struct cgroup_cls_state *task_cls_state(struct task_struct *p)
 {
 	return css_cls_state(task_css_check(p, net_cls_cgrp_id,
-					    rcu_read_lock_bh_held()));
+					    rcu_read_lock_held() ||
+					    rcu_read_lock_bh_held() ||
+					    rcu_read_lock_trace_held()));
 }
 EXPORT_SYMBOL_GPL(task_cls_state);
 

---
base-commit: 079e5c56a5c41d285068939ff7b0041ab10386fa
change-id: 20250608-rcu-fix-task_cls_state-0ed73f437d1e

Best regards,
-- 
Charalampos Mitrodimas <charmitro@posteo.net>


