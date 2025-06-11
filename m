Return-Path: <bpf+bounces-60308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8028AD4F55
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 11:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885BA3A9B70
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 09:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32034255F25;
	Wed, 11 Jun 2025 09:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b="TLTRiRSr"
X-Original-To: bpf@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BA2253937
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 09:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749632678; cv=none; b=QDac7VJnjIoeF/3/LAAy+/XF0XVRtOkAOkiznAeeY6Wty34DlAxcI/FVYSABlk6cOQDniMyyblg+0pg5dTgA9GhvUdj/8hrcG5wnijEnfcpeEkQefg1ZStt6+6rAySx6casW/vRwFHcEvI+AsSsZUyGDKqoQp6pZWBefaWt/FsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749632678; c=relaxed/simple;
	bh=jLq8TQOAMhHdsylHL7FElHZIu/bvuM8qtmokE4WqBTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aZDs++23vkB4sBX1DIsITFudrofPow+8qEL5dUvre9dtNAkBMaOtZhht7af0MzKI+mb38Gvvjr8MRSjKyYuGtTUwW/nB0F7FNHdJuo2WkBX4utnWbh2na6mmhRI7jNWVJTOKRAd1SAGice1XPCoZ8WlnP2wNYr74LClaoOHdby8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b=TLTRiRSr; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 69C7324002B
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 11:04:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net;
	s=1984.ea087b; t=1749632674;
	bh=jLq8TQOAMhHdsylHL7FElHZIu/bvuM8qtmokE4WqBTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:From;
	b=TLTRiRSralZsGm3Chv0w46FoF9yz05ZenISNsjEbDf1uAv57sSKGwfxX5t39QR7tY
	 6OdFvRBFohyAo8lqz3dbBh2kKYnZWmrGcJ6ElmMeJ2n6lvCl39S9Uoe+TizkYSN+cm
	 kfPuRcaEWToQKHP85flDWDLB9qMtdChPMUHnBIGXCp4fEjL6sSq/dXeoDdJmoNFqJA
	 xOa4RlWzmmiFEGgkUb5RJXOQtYI8PM47xnxzf5bqMnSZscL7BhaMZ7kHQzj9MEeo1G
	 vDX7kz0yBJT66DqbnQwPzlj/iomKdjzaFSme88s2k8PR7cf71zEoqTCzs+EQzvtNT0
	 hMPKDKYlFIzmlE0BGMrwRICgF31FdjK4+GLE8X8txDXRB8ir+s476XCFx01VYBtapw
	 KFBPqbtoJ+eLnr8xUHXcbOqTeYc0LJUdCOp7OH1xP/qrjvhOKPcZNpASFUzVPnfPFK
	 0CXk/6CgSd7q0TpGWzOvtvWXApDDUIKtvaMaZ+0wJxL7Q5n5mVa
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4bHKV61lB6z9rxD;
	Wed, 11 Jun 2025 11:04:30 +0200 (CEST)
From: Charalampos Mitrodimas <charmitro@posteo.net>
Date: Wed, 11 Jun 2025 09:04:06 +0000
Subject: [PATCH bpf-next v2] net: Fix RCU usage in task_cls_state() for BPF
 programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-rcu-fix-task_cls_state-v2-1-1a7fc248232a@posteo.net>
X-B4-Tracking: v=1; b=H4sIAIVGSWgC/4WNXQ6CMBCEr0L22TX9QTA+cQ9DSKGLNBpKupVoS
 O9u4QI+fpOZbzZgCo4YbsUGgVbHzs8Z1KmAYTLzg9DZzKCEuohKXDEMbxzdB6PhZze8uONoIqE
 gW+ux1LWVBHm8BMqtQ3xvM0+Oow/f42eVe/pXuUqUqMxe68tK6L5ZPEfy55kitCmlHwADJY29A
 AAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749632650; l=2465;
 i=charmitro@posteo.net; s=20250526; h=from:subject:message-id;
 bh=jLq8TQOAMhHdsylHL7FElHZIu/bvuM8qtmokE4WqBTs=;
 b=ut6ePDZlYIfJ1ZYNH55TQtCyEKaPR4TU6r3rukgknfjavYlrrn/IkxJBy746Ht37XV5aI87Ex
 oBOn6hKvQS4C7IH8VFFYisxJPoXcJkH3SO1bxjld9hRyPF4Iq2fnFUw
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

Fix this by also accepting rcu_read_lock_trace_held() as a valid RCU
context in the task_cls_state() function. This is safe because BPF
programs are non-sleepable and task_cls_state() is only doing an RCU
dereference to get the classid.

Reported-by: syzbot+b4169a1cfb945d2ed0ec@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b4169a1cfb945d2ed0ec
Fixes: ee971630f20f ("bpf: Allow some trace helpers for all prog types")
Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
---
Changes in v2:
- Fix RCU usage in task_cls_state() instead of BPF helper
- Add rcu_read_lock_trace_held() check to accept trace RCU as valdi
  context
- Drop the approach of using task_cls_classid() which has in_interrupt()
  check
- Link to v1: https://lore.kernel.org/r/20250608-rcu-fix-task_cls_state-v1-1-2a2025b4603b@posteo.net
---
 net/core/netclassid_cgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/netclassid_cgroup.c b/net/core/netclassid_cgroup.c
index d22f0919821e931fbdedf5a8a7a2998d59d73978..df86f82d747ac40e99597d6f2d921e8cc2834e64 100644
--- a/net/core/netclassid_cgroup.c
+++ b/net/core/netclassid_cgroup.c
@@ -21,7 +21,8 @@ static inline struct cgroup_cls_state *css_cls_state(struct cgroup_subsys_state
 struct cgroup_cls_state *task_cls_state(struct task_struct *p)
 {
 	return css_cls_state(task_css_check(p, net_cls_cgrp_id,
-					    rcu_read_lock_bh_held()));
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


