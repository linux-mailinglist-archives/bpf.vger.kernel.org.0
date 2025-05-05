Return-Path: <bpf+bounces-57390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A8AAA9EA2
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 00:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC8F5A0D37
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 22:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99209274FF8;
	Mon,  5 May 2025 22:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FasTKodH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD1A2750E0;
	Mon,  5 May 2025 22:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746482414; cv=none; b=B0GT0tQ2FccEByiFAPJAtqf4ghPiHP5aAHho0nK8Q7za77u8j+cvyHaOMkkc2mUolfAfAAtPlhNqaH3jLSAJHXZsk49WwistY2v7/L+EDZ2qmabmqn0WBnEE5yb4h/dXY13zSNSKnjUtgWYTtKa8VEBJalufY2DGpBPp9/DGrT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746482414; c=relaxed/simple;
	bh=dIG1lFkZH1VQRRMcBsApKEzI7KytVO8tC1HzPbDi1iw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJ1Z4XWGzd9d62vNOpocTgXncbQpEHvz7xNy6HyE/2itO8spVnfk2gKfa7wVl17dMac8bQKHpTgaSCEH0Sm7DaAXZnUfzTWcladg3lOQ9hc2yi3qicQ0n/FD2NlZZxWaaNFFvb9Xn7q9Z+c/WYTNSIMElwamB3zznsv4TDmF9+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=FasTKodH; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746482412; x=1778018412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ScYdW67L2XR5HVeiblIKyx3fz8lNqUnjqziFN00NBU4=;
  b=FasTKodHu2TMNeZpXjlQsQUnagxp/2+pMWcz2BmF8np77iDLitOZwbif
   VXCWpSP+Of4ebYyHLbqkU3We3sNIr5tVl2F3VndlixWU4xlutjjnh5ZiY
   Va4QA8ben4N+yWZYYFrLC2oGh85UdRN9JHEBEZkWgDeehDHNQCg76HbZO
   0=;
X-IronPort-AV: E=Sophos;i="6.15,264,1739836800"; 
   d="scan'208";a="719980188"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 22:00:07 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:62154]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.32:2525] with esmtp (Farcaster)
 id b68b5096-9918-4ccc-b1a9-3fe5fd6b477c; Mon, 5 May 2025 22:00:06 +0000 (UTC)
X-Farcaster-Flow-ID: b68b5096-9918-4ccc-b1a9-3fe5fd6b477c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 5 May 2025 22:00:03 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 5 May 2025 21:59:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
CC: Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
	"Stanislav Fomichev" <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri
 Olsa <jolsa@kernel.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=
	<mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Paul
 Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>,
	"Ondrej Mosnacek" <omosnace@redhat.com>, Casey Schaufler
	<casey@schaufler-ca.com>, Christian Brauner <brauner@kernel.org>, Kuniyuki
 Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <selinux@vger.kernel.org>
Subject: [PATCH v1 bpf-next 4/5] bpf: Add kfunc to scrub SCM_RIGHTS at security_unix_may_send().
Date: Mon, 5 May 2025 14:56:49 -0700
Message-ID: <20250505215802.48449-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505215802.48449-1-kuniyu@amazon.com>
References: <20250505215802.48449-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB004.ant.amazon.com (10.13.138.104) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

As Christian Brauner said [0], systemd calls cmsg_close_all() [1] after
each recvmsg() to close() unwanted file descriptors sent via SCM_RIGHTS.

However, this cannot work around the issue that close() for unwanted file
descriptors could block longer because the last fput() could occur on
the receiver side once sendmsg() with SCM_RIGHTS succeeds.

Also, even filtering by LSM at recvmsg() does not work for the same reason.

Thus, we need a better way to filter SCM_RIGHTS on the sender side.

Let's add a new kfunc to scrub all file descriptors from skb in
sendmsg().

This allows the receiver to keep recv()ing the bare data and disallows
the sender to impose the potential slowness of the last fput().

If necessary, we can add more granular filtering per file descriptor
after refactoring GC code and adding some fd-to-file helpers for BPF.

Sample:

SEC("lsm/unix_may_send")
int BPF_PROG(unix_scrub_scm_rights,
             struct socket *sock, struct socket *other, struct sk_buff *skb)
{
        struct unix_skb_parms *cb;

        if (skb && bpf_unix_scrub_fds(skb))
                return -EPERM;

        return 0;
}

Link: https://lore.kernel.org/netdev/20250502-fanden-unbeschadet-89973225255f@brauner/ #[0]
Link: https://github.com/systemd/systemd/blob/v257.5/src/basic/fd-util.c#L612-L628 #[1]
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h |  1 +
 net/core/filter.c     | 19 +++++++++++++++++--
 net/unix/af_unix.c    | 15 +++++++++++++++
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 1af1841b7601..109f92df2de2 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -58,4 +58,5 @@ struct unix_sock {
 #define unix_state_lock(s)	spin_lock(&unix_sk(s)->lock)
 #define unix_state_unlock(s)	spin_unlock(&unix_sk(s)->lock)
 
+int unix_scrub_fds(struct sk_buff *skb);
 #endif
diff --git a/net/core/filter.c b/net/core/filter.c
index 79cab4d78dc3..a9c46584da10 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -82,7 +82,7 @@
 #include <net/mptcp.h>
 #include <net/netfilter/nf_conntrack_bpf.h>
 #include <net/netkit.h>
-#include <linux/un.h>
+#include <net/af_unix.h>
 #include <net/xdp_sock_drv.h>
 #include <net/inet_dscp.h>
 
@@ -12153,6 +12153,11 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
 	return 0;
 }
 
+__bpf_kfunc int bpf_unix_scrub_fds(struct sk_buff *skb)
+{
+	return unix_scrub_fds(skb);
+}
+
 __bpf_kfunc_end_defs();
 
 int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
@@ -12190,6 +12195,10 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
 BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)
 
+BTF_KFUNCS_START(bpf_kfunc_check_set_scm_rights)
+BTF_ID_FLAGS(func, bpf_unix_scrub_fds, KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(bpf_kfunc_check_set_scm_rights)
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_skb,
@@ -12215,6 +12224,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_sock_ops = {
 	.set = &bpf_kfunc_check_set_sock_ops,
 };
 
+static const struct btf_kfunc_id_set bpf_kfunc_set_scm_rights = {
+	.owner = THIS_MODULE,
+	.set = &bpf_kfunc_check_set_scm_rights,
+};
+
 static int __init bpf_kfunc_init(void)
 {
 	int ret;
@@ -12234,7 +12248,8 @@ static int __init bpf_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
 					       &bpf_kfunc_set_sock_addr);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
-	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &bpf_kfunc_set_sock_ops);
+	ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &bpf_kfunc_set_sock_ops);
+	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_kfunc_set_scm_rights);
 }
 late_initcall(bpf_kfunc_init);
 
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 692cce579c89..4c088316dfb7 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1885,6 +1885,21 @@ static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool sen
 	return err;
 }
 
+int unix_scrub_fds(struct sk_buff *skb)
+{
+	struct scm_cookie scm = {};
+
+	if (skb->destructor != unix_destruct_scm)
+		return -EINVAL;
+
+	if (UNIXCB(skb).fp) {
+		unix_detach_fds(&scm, skb);
+		scm_fp_destroy(&scm);
+	}
+
+	return 0;
+}
+
 static bool unix_passcred_enabled(const struct socket *sock,
 				  const struct sock *other)
 {
-- 
2.49.0


