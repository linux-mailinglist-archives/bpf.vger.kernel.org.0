Return-Path: <bpf+bounces-49587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4B5A1A8D5
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 18:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED5103A35D4
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 17:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE8D146593;
	Thu, 23 Jan 2025 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="N07qLtFV"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311C2142E6F;
	Thu, 23 Jan 2025 17:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737652756; cv=none; b=muf0+TeQmRizfbZ51tqF1IgdAkO629+uM48/rTBDt6jjDz8sPfSce3o3IV3tSayXPSW/Z6Vc47QBrc6cwkoTxTZs3FIa/LlQeZwjn28G5OCukDJws5GU0O5l7/l7191pMzPnuEiXNOAMFWVdXJbdXqEx4Q0DoZa3LpUZjIhgeow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737652756; c=relaxed/simple;
	bh=YD3cfXPS7uj8iKkK+NGgmRGEclSxSJbhk58dSFRbX8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kV6FvP/Ph7JMzaE05LpbvnaYNI17Niqpkup231CFt9uxqII7Sae5f1pSlsQOHDXXHcvCQI+VN9uG4r/KkN/JwOXgRue2R8SxjOP07R2MShNIjcKlo81L+gkr5DSk/ihOdlkdIUQNd5gtbSHYqMpze8E6jHZKenfrJxQcai6qcgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=N07qLtFV; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=XKiwJ
	jFGTOM1fwCeJkho73TOTX/XyzSyxZlNbugFbq4=; b=N07qLtFVUaUnt4mefX3CJ
	ZnA1lCq7n3LFzM7XgCC5HF4Z1Hz2IWsYidJtRJBTxQUI4eQUHgnJDwpwYRU7mUQs
	/znw3hXX7uKg82ybgfX0q+EJXIt3Qy0sbpn0Y37zOc1wu3fYyrLnVTIb8j/dMcBb
	AJihReLF/5Ntsbqtz+EyFg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBnjmFKeZJnNajlHw--.26171S2;
	Fri, 24 Jan 2025 01:16:03 +0800 (CST)
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
Subject: [PATCH bpf v1 0/2] bpf: fix ktls panic and add tests
Date: Fri, 24 Jan 2025 01:15:50 +0800
Message-ID: <20250123171552.57345-1-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnjmFKeZJnNajlHw--.26171S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF18ZFy7tF4rtry3Aw1rXrb_yoW8tFWfpa
	4rtr9xAryUJ34UXrWSvF4kuFyFqa1vqFy8WFn7tw1rAFZ8A3W5JFyxKr18GrZ3W34xWF9x
	Za4vyw4rWr1UZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi5ku7UUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbBDwjdp2eSaCq93gABso


We can reproduce the issue using the existing test program:
'test_sockmap --ktls'
Or use the selftest I provided, which will cause a panic:

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

1. It looks like the issue started occurring after I bounding ktls and bpf
together, and the addition of assertions to iov_iter has caused a panic.
If my fix tag is incorrect, please assist me in correcting the fix tag.

2. I make minimal changes for now, and if there are other reasons that
cause similar panics, we can revisit later. For now, this fix should be
sufficient.

Jiayuan Chen (2):
  bpf: fix ktls panic
  selftests/bpf: add ktls selftest

 net/tls/tls_sw.c                              |   8 +-
 .../selftests/bpf/prog_tests/sockmap_ktls.c   | 175 +++++++++++++++++-
 .../selftests/bpf/progs/test_sockmap_ktls.c   |  26 +++
 3 files changed, 205 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_ktls.c

-- 
2.43.5


