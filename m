Return-Path: <bpf+bounces-37694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0712E9598DA
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 13:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774451F2281E
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 11:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C901C93A0;
	Wed, 21 Aug 2024 09:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dY4mfA5S"
X-Original-To: bpf@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA731EED07;
	Wed, 21 Aug 2024 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724232642; cv=none; b=QrdwBXnu3t3+bfGLkV8KpgZ0UEt6H+RtTkZZMjtlexX295OFoG8/07n9SyB41E0lVjMK3C2Zj9yIL8h6UJXvKaiyhWqdye7GcRoKjgZepTcl1SBSLy/cjEf6KsnbmfCQUJEkCGyO/1n7dk+DY1E84m3at9ukR2ieuvIm6mfExdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724232642; c=relaxed/simple;
	bh=SdO128jSaf+sYa64CYea8M0yL/ZkVkv914YMWqYQWc4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jJekv3ut2Y2AGrxPNU/f4dJRpdszXIeIupLJH43Paq3ZSheOCKLbv7R+VG6CmxsFK9ykBRenEFMrvzjMVP48xDQnOWdlgI/P+PgJ5vS4ycesoIaeQ0WTSP9jYc8/fQREnyOZ4COa7gqQE4wz6S72P5+Ng0YvzWqAFWO0NBK+o7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=dY4mfA5S; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 01494d905fa011ef8593d301e5c8a9c0-20240821
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=7E84GIHXbOx7jBLbf+I8NSxdpVEuRrIuEkSs5jTJbGg=;
	b=dY4mfA5SAWAH1wA7HHE+KmF880YigIByq+AX4F1np4lfA3bpf+gSbf11fNcfx215c6vJxHdoC8uv5eFPA1j4MzA+/WvrYxq4SBAm2wdgYZ1Zs+gVr/fFwRu++q6EjAEXG/cl6etgXNI089BuaSd2jEO6qso88nUFKgUh2NeMn+U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:3e2c2a9e-953b-4784-a01d-20cce319686e,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6dc6a47,CLOUDID:74eeb3be-d7af-4351-93aa-42531abf0c7b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 01494d905fa011ef8593d301e5c8a9c0-20240821
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <tze-nan.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1073799371; Wed, 21 Aug 2024 17:30:29 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 21 Aug 2024 02:30:31 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 21 Aug 2024 17:30:31 +0800
From: Tze-nan Wu <Tze-nan.Wu@mediatek.com>
To: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Stanislav Fomichev
	<sdf@fomichev.me>
CC: <bobule.chang@mediatek.com>, <wsd_upstream@mediatek.com>,
	<linux-kernel@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Tze-nan Wu <Tze-nan.Wu@mediatek.com>,
	Yanghui Li <yanghui.li@mediatek.com>, Cheng-Jui Wang
	<cheng-jui.wang@mediatek.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH net v4] bpf, net: Check cgroup_bpf_enabled() only once in do_sock_getsockopt()
Date: Wed, 21 Aug 2024 17:30:16 +0800
Message-ID: <20240821093016.2533-1-Tze-nan.Wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The return value from `cgroup_bpf_enabled(CGROUP_GETSOCKOPT)` can change
between the invocations of `BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN` and
`BPF_CGROUP_RUN_PROG_GETSOCKOPT`.

If `cgroup_bpf_enabled(CGROUP_GETSOCKOPT)` changes from "false" to
"true" between the invocations of `BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN` and
`BPF_CGROUP_RUN_PROG_GETSOCKOPT`, `BPF_CGROUP_RUN_PROG_GETSOCKOPT` will
receive an -EFAULT from `__cgroup_bpf_run_filter_getsockopt(max_optlen=0)`
due to `get_user()` was not reached in `BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN`.

Scenario shown as below:

           `process A`                      `process B`
           -----------                      ------------
  BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN
                                            enable CGROUP_GETSOCKOPT
  BPF_CGROUP_RUN_PROG_GETSOCKOPT (-EFAULT)

To prevent this, invoke `cgroup_bpf_enabled()` only once and cache the
result in a newly added local variable `enabled`.
Both `BPF_CGROUP_*` macros in `do_sock_getsockopt` will then check their
condition using the same `enabled` variable as the condition variable,
instead of using the return values from `cgroup_bpf_enabled` called by
themselves as the condition variable(which could yield different results).
This ensures that either both `BPF_CGROUP_*` macros pass the condition
or neither does.

Fixes: 0d01da6afc54 ("bpf: implement getsockopt and setsockopt hooks")
Co-developed-by: Yanghui Li <yanghui.li@mediatek.com>
Signed-off-by: Yanghui Li <yanghui.li@mediatek.com>
Co-developed-by: Cheng-Jui Wang <cheng-jui.wang@mediatek.com>
Signed-off-by: Cheng-Jui Wang <cheng-jui.wang@mediatek.com>
Signed-off-by: Tze-nan Wu <Tze-nan.Wu@mediatek.com>
---

Chagnes from v1 to v2: https://lore.kernel.org/all/20240819082513.27176-1-Tze-nan.Wu@mediatek.com/
  Instead of using cgroup_lock in the fastpath, invoke cgroup_bpf_enabled
  only once and cache the value in the newly added variable `enabled`.
  `BPF_CGROUP_*` macros in do_sock_getsockopt can then both check their
  condition with the new variable `enable`, ensuring that either they both
  passing the condition or both do not.

Chagnes from v2 to v3: https://lore.kernel.org/all/20240819155627.1367-1-Tze-nan.Wu@mediatek.com/
  Hide cgroup_bpf_enabled in the macro, and some modifications to adapt
  the coding style.

Chagnes from v3 to v4: https://lore.kernel.org/all/20240820092942.16654-1-Tze-nan.Wu@mediatek.com/
  Add bpf tag to subject, and Fixes tag in body.

---
 include/linux/bpf-cgroup.h | 15 ++++++++-------
 net/socket.c               |  5 +++--
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index fb3c3e7181e6..5afa2ac76aae 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -390,20 +390,20 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 	__ret;								       \
 })
 
-#define BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen)			       \
+#define BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen, enabled)		       \
 ({									       \
 	int __ret = 0;							       \
-	if (cgroup_bpf_enabled(CGROUP_GETSOCKOPT))			       \
+	enabled = cgroup_bpf_enabled(CGROUP_GETSOCKOPT);		       \
+	if (enabled)							       \
 		copy_from_sockptr(&__ret, optlen, sizeof(int));		       \
 	__ret;								       \
 })
 
 #define BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock, level, optname, optval, optlen,   \
-				       max_optlen, retval)		       \
+				       max_optlen, retval, enabled)	       \
 ({									       \
 	int __ret = retval;						       \
-	if (cgroup_bpf_enabled(CGROUP_GETSOCKOPT) &&			       \
-	    cgroup_bpf_sock_enabled(sock, CGROUP_GETSOCKOPT))		       \
+	if (enabled && cgroup_bpf_sock_enabled(sock, CGROUP_GETSOCKOPT))       \
 		if (!(sock)->sk_prot->bpf_bypass_getsockopt ||		       \
 		    !INDIRECT_CALL_INET_1((sock)->sk_prot->bpf_bypass_getsockopt, \
 					tcp_bpf_bypass_getsockopt,	       \
@@ -518,9 +518,10 @@ static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
 #define BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(atype, major, minor, access) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_SYSCTL(head,table,write,buf,count,pos) ({ 0; })
-#define BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen) ({ 0; })
+#define BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen, enabled) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock, level, optname, optval, \
-				       optlen, max_optlen, retval) ({ retval; })
+				       optlen, max_optlen, retval, \
+				       enabled) ({ retval; })
 #define BPF_CGROUP_RUN_PROG_GETSOCKOPT_KERN(sock, level, optname, optval, \
 					    optlen, retval) ({ retval; })
 #define BPF_CGROUP_RUN_PROG_SETSOCKOPT(sock, level, optname, optval, optlen, \
diff --git a/net/socket.c b/net/socket.c
index fcbdd5bc47ac..0b465dc8a789 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2363,6 +2363,7 @@ int do_sock_getsockopt(struct socket *sock, bool compat, int level,
 		       int optname, sockptr_t optval, sockptr_t optlen)
 {
 	int max_optlen __maybe_unused;
+	bool enabled __maybe_unused;
 	const struct proto_ops *ops;
 	int err;
 
@@ -2371,7 +2372,7 @@ int do_sock_getsockopt(struct socket *sock, bool compat, int level,
 		return err;
 
 	if (!compat)
-		max_optlen = BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);
+		max_optlen = BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen, enabled);
 
 	ops = READ_ONCE(sock->ops);
 	if (level == SOL_SOCKET) {
@@ -2390,7 +2391,7 @@ int do_sock_getsockopt(struct socket *sock, bool compat, int level,
 	if (!compat)
 		err = BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock->sk, level, optname,
 						     optval, optlen, max_optlen,
-						     err);
+						     err, enabled);
 
 	return err;
 }
-- 
2.45.2


