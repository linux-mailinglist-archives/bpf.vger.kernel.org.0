Return-Path: <bpf+bounces-49588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25134A1A8CE
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 18:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31544164D11
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 17:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1D113DDD3;
	Thu, 23 Jan 2025 17:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JcZBawQ9"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD69113D891;
	Thu, 23 Jan 2025 17:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737652758; cv=none; b=BSnCnMMqK4OkSgPOO2fWNG/dOs4JS8RYIe+xlnr2omlXTCD2CctnuyI8xRKAs6iamOASLquM43sFalZIM/x4+hIAs74GdIkTq2V0qEoj1/erWKpUrPylg+PokWqAnlaXDqVZ7ND676qAIxkKs82ocuRD7zqlfTRysok0C1dPeN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737652758; c=relaxed/simple;
	bh=7G0svEXwM2aJqyw7IR/e+A3gpubl36pVvmL6I2PJDKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omtTGHMN4E5OFnGTrLBBzcNVVY00Su9lWB4ob6lLTFe8ODghj5/hKUyW8FRzN1Uq6RCkndD0IMlnX7SU1K3yWb64AN8WClfG+0l+KUZGLfZ+DIra4LLwKtr2WKvmc9i8fG5K9WdDXRK7JAWzy4bhOGv5AK76OrnEqGhFa9rIuJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JcZBawQ9; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=qOvJI
	XGT0GAs+bC3xHveezTTFrL6aDnNMlj1p1lKZ6o=; b=JcZBawQ9rKS/V0rA96uDx
	rBWiULkcs6p9dLZ66NYQshLijgNS9lVndbMrqGiTx9stGpWCUqbYoUBmnmYmLVgf
	GwQSnZdKJwoXVqmAdugIw2CfOD8CJdq68FK35x0pLOsyyPDA+Ky+10vE1eT8IPKk
	Bz5pNUYWTGPqRuS3Yj55iY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBnjmFKeZJnNajlHw--.26171S3;
	Fri, 24 Jan 2025 01:16:11 +0800 (CST)
From: Jiayuan Chen <mrpre@163.com>
To: bpf@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	Jiayuan Chen <mrpre@163.com>
Subject: [PATCH bpf v1 1/2] bpf: fix ktls panic
Date: Fri, 24 Jan 2025 01:15:51 +0800
Message-ID: <20250123171552.57345-2-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250123171552.57345-1-mrpre@163.com>
References: <20250123171552.57345-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnjmFKeZJnNajlHw--.26171S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxWF4rAr17Gw4xKFWkKryfJFb_yoW5uw17pF
	1FgrZrAryDX34UtrWFvF4kua4Fqa9aqFyUWFWIyw1rArZxC3WjqFyUKr18KFZ5urZ7uF9I
	qa1DZw15ur1UurDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piWCJdUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiDwHdp2eSak6uTAAAsH

[ 2172.936997] ------------[ cut here ]------------
[ 2172.936999] kernel BUG at lib/iov_iter.c:629!
......
[ 2172.944996] PKRU: 55555554
[ 2172.945155] Call Trace:
[ 2172.945299]  <TASK>
[ 2172.945428]  ? die+0x36/0x90
[ 2172.945601]  ? do_trap+0xdd/0x100
[ 2172.945795]  ? iov_iter_revert+0x178/0x180
[ 2172.946031]  ? iov_iter_revert+0x178/0x180
[ 2172.946267]  ? do_error_trap+0x7d/0x110
[ 2172.946499]  ? iov_iter_revert+0x178/0x180
[ 2172.946736]  ? exc_invalid_op+0x50/0x70
[ 2172.946961]  ? iov_iter_revert+0x178/0x180
[ 2172.947197]  ? asm_exc_invalid_op+0x1a/0x20
[ 2172.947446]  ? iov_iter_revert+0x178/0x180
[ 2172.947683]  ? iov_iter_revert+0x5c/0x180
[ 2172.947913]  tls_sw_sendmsg_locked.isra.0+0x794/0x840
[ 2172.948206]  tls_sw_sendmsg+0x52/0x80
[ 2172.948420]  ? inet_sendmsg+0x1f/0x70
[ 2172.948634]  __sys_sendto+0x1cd/0x200
[ 2172.948848]  ? find_held_lock+0x2b/0x80
[ 2172.949072]  ? syscall_trace_enter+0x140/0x270
[ 2172.949330]  ? __lock_release.isra.0+0x5e/0x170
[ 2172.949595]  ? find_held_lock+0x2b/0x80
[ 2172.949817]  ? syscall_trace_enter+0x140/0x270
[ 2172.950211]  ? lockdep_hardirqs_on_prepare+0xda/0x190
[ 2172.950632]  ? ktime_get_coarse_real_ts64+0xc2/0xd0
[ 2172.951036]  __x64_sys_sendto+0x24/0x30
[ 2172.951382]  do_syscall_64+0x90/0x170
......

After calling bpf_exec_tx_verdict(), the size of msg_pl->sg may increase,
e.g., when the BPF program executes bpf_msg_push_data().

If the BPF program sets cork_bytes and sg.size is smaller than cork_bytes,
it will return -ENOSPC and attempt to roll back to the non-zero copy
logic. However, during rollback, msg->msg_iter is reset, but since
msg_pl->sg.size has been increased, subsequent executions will exceed the
actual size of msg_iter.
'''
iov_iter_revert(&msg->msg_iter, msg_pl->sg.size - orig_size);
'''

The changes in this commit are based on the following considerations:

1. When cork_bytes is set, rolling back to non-zero copy logic is
pointless and can directly go to zero-copy logic.

2. Suppose sg.size is initially 5, and we push it to 100, setting
apply_bytes to 7. Then, 98 bytes of data are sent out, leaving 2 bytes to
be processed. The rollback logic cannot determine which data has been
processed and which hasn't.

This current change is based on the principle of minimal modification,
which won't make things worse. If we still encounter similar panic
further, we can consider a more comprehensive solution.

Fixes: fcb14cb1bdac ("new iov_iter flavour - ITER_UBUF")
Fixes: d3b18ad31f93 ("tls: add bpf support to sk_msg handling")
Signed-off-by: Jiayuan Chen <mrpre@163.com>
---
 net/tls/tls_sw.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 7bcc9b4408a2..b3cae4dd4f49 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1120,9 +1120,13 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 					num_async++;
 				else if (ret == -ENOMEM)
 					goto wait_for_memory;
-				else if (ctx->open_rec && ret == -ENOSPC)
+				else if (ctx->open_rec && ret == -ENOSPC) {
+					if (msg_pl->cork_bytes) {
+						ret = 0;
+						goto send_end;
+					}
 					goto rollback_iter;
-				else if (ret != -EAGAIN)
+				} else if (ret != -EAGAIN)
 					goto send_end;
 			}
 			continue;
-- 
2.43.5


