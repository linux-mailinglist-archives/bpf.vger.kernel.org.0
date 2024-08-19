Return-Path: <bpf+bounces-37483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C74956596
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 10:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E071F2385F
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 08:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAEA15B125;
	Mon, 19 Aug 2024 08:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oIj0YSW9"
X-Original-To: bpf@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA40F13C8E8;
	Mon, 19 Aug 2024 08:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724056039; cv=none; b=PmhOd2cbK9VDgTlAetFWhPdIasYUgIOD3Gffd9e6MPNg9r2F8U9Aj57csAtxyS3JHWb4It+2nj4yzzB88XL6F79p8cXnhohrg9bBZqx8wKgIYIoArrhDGAApO8RapTKx81RT6aaluT26Mvs2JuWxuUafGC8uoNCw0+R4d6LUQ9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724056039; c=relaxed/simple;
	bh=/Hlpjr6PGF/ZP6Ap64n14/RLbP2iWefmb8Cxbg5fcAk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oaRVDJyRJdBYach9rkGjkjXxE40GxCBKfEJHWFmsSs1aMJaVu8gW7tRkIAjeAQJln+S/qG2WNV8bBRgz2usPz3BEiUJ5dVs2JQl50wxQYrTVyGUx1cSpP9nEntSTwmnobqzYpMsUaEHu92YjEJSYl5kZzIO/WZcF24iGU7Njhko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=oIj0YSW9; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d427515a5e0411ef8593d301e5c8a9c0-20240819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Ei/MZnWMSf5WRtVHkVpfjkH2hPuZFQGSKj5kRjWhNkE=;
	b=oIj0YSW9KpY3E+aC5y5tAK5bGTZd5OML4Q3xSA8pEG2XAylg1PYkmV8bSWBJC6vhxPrtqbLWteOOdcMEfJpjDBFyeCIAQ6LWL5DAkDHsvT4SBajJswgesydEIvwDPQMFT0I5m9RQMm5uQap89PAruQ3h3EtJb9qh6gRB6BjR6tA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:a70dacea-0b3d-40ff-b295-c4cd7cc0887a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:2966d2ce-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: d427515a5e0411ef8593d301e5c8a9c0-20240819
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <tze-nan.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1526812794; Mon, 19 Aug 2024 16:27:10 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 19 Aug 2024 01:27:11 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 19 Aug 2024 16:27:11 +0800
From: Tze-nan Wu <Tze-nan.Wu@mediatek.com>
To: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <bobule.chang@mediatek.com>, <wsd_upstream@mediatek.com>, Tze-nan Wu
	<Tze-nan.Wu@mediatek.com>, Yanghui Li <yanghui.li@mediatek.com>, Cheng-Jui
 Wang <cheng-jui.wang@mediatek.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<bpf@vger.kernel.org>
Subject: [PATCH] net/socket: Acquire cgroup_lock in do_sock_getsockopt
Date: Mon, 19 Aug 2024 16:25:12 +0800
Message-ID: <20240819082513.27176-1-Tze-nan.Wu@mediatek.com>
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
"true"
between the invocations of `BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN` and
`BPF_CGROUP_RUN_PROG_GETSOCKOPT`,
`BPF_CGROUP_RUN_PROG_GETSOCKOPT` will receive an -EFAULT from
`__cgroup_bpf_run_filter_getsockopt(max_optlen=0)` due to `get_user()`
had not reached in `BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN`.

Scenario shown as below:

           `process A`                      `process B`
           -----------                      ------------
  BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN
                                            enable CGROUP_GETSOCKOPT
  BPF_CGROUP_RUN_PROG_GETSOCKOPT (-EFAULT)

Prevent `cgroup_bpf_enabled(CGROUP_GETSOCKOPT)` change between
`BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN` and `BPF_CGROUP_RUN_PROG_GETSOCKOPT`
by acquiring cgroup_lock.

Co-developed-by: Yanghui Li <yanghui.li@mediatek.com>
Signed-off-by: Yanghui Li <yanghui.li@mediatek.com>
Co-developed-by: Cheng-Jui Wang <cheng-jui.wang@mediatek.com>
Signed-off-by: Cheng-Jui Wang <cheng-jui.wang@mediatek.com>
Signed-off-by: Tze-nan Wu <Tze-nan.Wu@mediatek.com>

---

We have encountered this issue by observing that process A could sometimes
get an -EFAULT from getsockopt() during our device boot-up, while another
process B triggers the race condition by enabling CGROUP_GETSOCKOPT
through bpf syscall at the same time.

The race condition is shown below:

           `process A`                        `process B`
           -----------                        ------------
  BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN
         
                                              bpf syscall 
                                        (CGROUP_GETSOCKOPT enabled)

  BPF_CGROUP_RUN_PROG_GETSOCKOPT
  -> __cgroup_bpf_run_filter_getsockopt
    (-EFAULT)

__cgroup_bpf_run_filter_getsockopt return -EFAULT at the line shown below:
	if (optval && (ctx.optlen > max_optlen || ctx.optlen < 0)) {
		if (orig_optlen > PAGE_SIZE && ctx.optlen >= 0) {
			pr_info_once("bpf getsockopt: ignoring program buffer with optlen=%d (max_optlen=%d)\n",
				     ctx.optlen, max_optlen);
			ret = retval;
			goto out;
		}
		ret = -EFAULT; <== return EFAULT here
		goto out;
	}

This patch should fix the race but not sure if it introduces any potential
side effects or regression.

And we wondering if this is a real issue in do_sock_getsockopt or if
getsockopt() is designed to expect such race conditions.
Should the userspace caller always anticipate an -EFAULT from getsockopt()
if another process enables CGROUP_GETSOCKOPT at the same time?

Any comment will be appreciated!

BTW, I added Chengjui and Yanghui to Co-developed due to we have several
discussions on this issue. And we both spend some time on this issue.

---
 net/socket.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index fcbdd5bc47ac..e0b2b16fd238 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2370,8 +2370,10 @@ int do_sock_getsockopt(struct socket *sock, bool compat, int level,
 	if (err)
 		return err;
 
-	if (!compat)
+	if (!compat) {
+		cgroup_lock();
 		max_optlen = BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);
+	}
 
 	ops = READ_ONCE(sock->ops);
 	if (level == SOL_SOCKET) {
@@ -2387,10 +2389,12 @@ int do_sock_getsockopt(struct socket *sock, bool compat, int level,
 				      optlen.user);
 	}
 
-	if (!compat)
+	if (!compat) {
 		err = BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock->sk, level, optname,
 						     optval, optlen, max_optlen,
 						     err);
+		cgroup_unlock();
+	}
 
 	return err;
 }
-- 
2.45.2


