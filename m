Return-Path: <bpf+bounces-38533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D8D965A41
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 10:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F36D1F261B7
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 08:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7385316D4DE;
	Fri, 30 Aug 2024 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qKStLXdA"
X-Original-To: bpf@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F61216CD08;
	Fri, 30 Aug 2024 08:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725006359; cv=none; b=D/fDTHujqhhIHrQcJWzEb1cwBoBCTtzI4iK4IrMs6VoHzgeEEO7jrCxq+41UlLafFF+c6jXhuc1ml3hES4f4MMZ/2g7FgLyVrCso7CyT2kvGSO5+ECznHvM6PjZ0ErMS9HdjF6Lms0VqJFcHo/ym0yzGrtiwlO32nsc4Qo1vubI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725006359; c=relaxed/simple;
	bh=Yd0XiznABLIQYOVBnH34SvRq6Qx9nJT+kDBumBgr1cw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HmmJbsNhXcOhSNxsk3RtYM+/5rvik5h71hH2BlaXR/iLJmk5/5KNUXBNeVS5bCF9MgRV4KcqkK4jbwxR98oCCx8lGv/o0kk2kVqZUdMtFPJBFCYcfYYU7eI4O3nUQePTCOR3QQMt9HfnLZC96d3C3PCOXz+NLimJPfv+qyFJIVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=qKStLXdA; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 748adda466a911ef8593d301e5c8a9c0-20240830
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Sk5Sg+UsvXBabUWD0t2h9fPmHSQ3SzTGN9UHM5S6Mn4=;
	b=qKStLXdAB2VWE7UmGlnq7MvdYnbTX3F4V7V1lh7UW92Btr6PUimYjGpIU3cgS1uhW8x6UxADYCiWFGTFife0i4/MtboTio3gyJeuzP2c4M6PDtGA1KNXqHH+TL9lUW9NYegaFlqsaTGOJLz/Ym0/NSVFZJJJRW82EIihkszfhtQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:8a216d14-222f-4f34-85fe-a3eed666f14e,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6dc6a47,CLOUDID:734a2ebf-d7af-4351-93aa-42531abf0c7b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 748adda466a911ef8593d301e5c8a9c0-20240830
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <tze-nan.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 626687166; Fri, 30 Aug 2024 16:25:46 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 30 Aug 2024 01:25:47 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 30 Aug 2024 16:25:47 +0800
From: Tze-nan Wu <Tze-nan.Wu@mediatek.com>
To: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	<alexei.starovoitov@gmail.com>
CC: <bobule.chang@mediatek.com>, <wsd_upstream@mediatek.com>,
	<linux-kernel@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, <chen-yao.chang@mediatek.com>, Tze-nan
 Wu <Tze-nan.Wu@mediatek.com>, Yanghui Li <yanghui.li@mediatek.com>, Cheng-Jui
 Wang <cheng-jui.wang@mediatek.com>, Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH net v5] bpf, net: Fix a potential race in do_sock_getsockopt()
Date: Fri, 30 Aug 2024 16:25:17 +0800
Message-ID: <20240830082518.23243-1-Tze-nan.Wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

There's a potential race when `cgroup_bpf_enabled(CGROUP_GETSOCKOPT)` is
false during the execution of `BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN`, but
becomes true when `BPF_CGROUP_RUN_PROG_GETSOCKOPT` is called.
This inconsistency can lead to `BPF_CGROUP_RUN_PROG_GETSOCKOPT` receiving
an "-EFAULT" from `__cgroup_bpf_run_filter_getsockopt(max_optlen=0)`.
Scenario shown as below:

           `process A`                      `process B`
           -----------                      ------------
  BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN
                                            enable CGROUP_GETSOCKOPT
  BPF_CGROUP_RUN_PROG_GETSOCKOPT (-EFAULT)

To resolve this, remove the `BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN` macro and
directly uses `copy_from_sockptr` to ensure that `max_optlen` is always 
set before `BPF_CGROUP_RUN_PROG_GETSOCKOPT` is invoked.

Fixes: 0d01da6afc54 ("bpf: implement getsockopt and setsockopt hooks")
Co-developed-by: Yanghui Li <yanghui.li@mediatek.com>
Signed-off-by: Yanghui Li <yanghui.li@mediatek.com>
Co-developed-by: Cheng-Jui Wang <cheng-jui.wang@mediatek.com>
Signed-off-by: Cheng-Jui Wang <cheng-jui.wang@mediatek.com>
Signed-off-by: Tze-nan Wu <Tze-nan.Wu@mediatek.com>
---

Changes from v1 to v2: https://lore.kernel.org/all/20240819082513.27176-1-Tze-nan.Wu@mediatek.com/
  Instead of using cgroup_lock in the fastpath, invoke cgroup_bpf_enabled
  only once and cache the value in the newly added variable `enabled`.
  `BPF_CGROUP_*` macros in do_sock_getsockopt can then both check their
  condition with the new variable `enable`, ensuring that either they both
  passing the condition or both do not.

Changes from v2 to v3: https://lore.kernel.org/all/20240819155627.1367-1-Tze-nan.Wu@mediatek.com/
  Hide cgroup_bpf_enabled in the macro, and some modifications to adapt
  the coding style.

Changes from v3 to v4: https://lore.kernel.org/all/20240820092942.16654-1-Tze-nan.Wu@mediatek.com/
  Add bpf tag to subject, and add the Fixes tag in body.

Changes from v4 to v5: https://lore.kernel.org/all/20240821093016.2533-1-Tze-nan.Wu@mediatek.com/
  Change subject, and fix the race by unconditional `copy_from_sockptr`,
  instead of adding a new variable.

---
 include/linux/bpf-cgroup.h | 9 ---------
 net/socket.c               | 4 ++--
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index fb3c3e7181e6..ce91d9b2acb9 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -390,14 +390,6 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 	__ret;								       \
 })
 
-#define BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen)			       \
-({									       \
-	int __ret = 0;							       \
-	if (cgroup_bpf_enabled(CGROUP_GETSOCKOPT))			       \
-		copy_from_sockptr(&__ret, optlen, sizeof(int));		       \
-	__ret;								       \
-})
-
 #define BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock, level, optname, optval, optlen,   \
 				       max_optlen, retval)		       \
 ({									       \
@@ -518,7 +510,6 @@ static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
 #define BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(atype, major, minor, access) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_SYSCTL(head,table,write,buf,count,pos) ({ 0; })
-#define BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock, level, optname, optval, \
 				       optlen, max_optlen, retval) ({ retval; })
 #define BPF_CGROUP_RUN_PROG_GETSOCKOPT_KERN(sock, level, optname, optval, \
diff --git a/net/socket.c b/net/socket.c
index fcbdd5bc47ac..0a2bd22ec105 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2362,7 +2362,7 @@ INDIRECT_CALLABLE_DECLARE(bool tcp_bpf_bypass_getsockopt(int level,
 int do_sock_getsockopt(struct socket *sock, bool compat, int level,
 		       int optname, sockptr_t optval, sockptr_t optlen)
 {
-	int max_optlen __maybe_unused;
+	int max_optlen __maybe_unused = 0;
 	const struct proto_ops *ops;
 	int err;
 
@@ -2371,7 +2371,7 @@ int do_sock_getsockopt(struct socket *sock, bool compat, int level,
 		return err;
 
 	if (!compat)
-		max_optlen = BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);
+		copy_from_sockptr(&max_optlen, optlen, sizeof(int));
 
 	ops = READ_ONCE(sock->ops);
 	if (level == SOL_SOCKET) {
-- 
2.45.2


