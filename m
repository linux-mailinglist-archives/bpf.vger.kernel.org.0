Return-Path: <bpf+bounces-295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DDE6FE17F
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 17:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B853A1C20DDA
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 15:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DB316426;
	Wed, 10 May 2023 15:23:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B48A14A83
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 15:23:38 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0AF2D4A
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 08:23:36 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BD07B3F4A6
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 15:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1683732214;
	bh=nxt1AjdlyoqIrH6J1U3hreWGYLSAQKMD95fnrL6guHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=Wwpzi5ltnPGzZCeZv8CUgPo4l7Xkbz5K2HP80PDBYNRBc8mqbjrPx8+gZi6+NIg62
	 tX+xQ940WGIMYJWVb0OG2CFN5Qo+xTO4S+BiyYAOvM20QhYf8F099tRUMYBnREC07f
	 Ue/hoM2IGd8PUHr9cnL51a1YaoGBJJ94mc2+IG7haUnxXaGRUlXmunzL7ApjgTyhik
	 hcSe6J+YqPDeb+ItnI7n8Ue5rB4fDIBM26BQ5Ff5i8lc3MaHcyKsAramzIZUp58OGP
	 91FO/dT9ekJ9JJ4OwNHRlpQWLTC9nir1dL4L2O6U8P0nYCfE4UTNObLO/E3wEl5iLu
	 qqWkbvvTER9Cw==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-94a34a0b75eso682407766b.1
        for <bpf@vger.kernel.org>; Wed, 10 May 2023 08:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683732213; x=1686324213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nxt1AjdlyoqIrH6J1U3hreWGYLSAQKMD95fnrL6guHQ=;
        b=WxmM6mZ3O6lp4ugv08Fc73Y6q8kgCbYONlOVusIdF78mdtDWAii/hm1uKxbXrPznQE
         zpWEVjBECM4MeB7L60GwGv3WYEm6ffBVAQR2NxQXXSqPWby3aF6ZFacTy7Phyx/yEBy2
         r5y17bcIzr2rLRkzYF3wGGp8LkX+0FiS0HKqD1Cx5oZV0Ti5m7MNTABSAEx0Uc4H2Lgp
         QV6TfhfZNApHklmd5Q78HSwgVC4ScqQiFteAWnZKUgi5so0+E0uzetSmKCA+DtcCxY17
         D9wywaC3A8GGEUdRRb0FSZhcQCV/EEvdKsqPZnPu/mbo/BPa0R5xr/lBSw3hOVp6ojh0
         3SMg==
X-Gm-Message-State: AC+VfDwF7+w22ScqNisqRrwnqHFGcHB7UOCpt6AmiU81ln2QujmVDb1k
	0nAGTfo9HRQttU553+oWX4NoLzr+CiPdtiR4I3WGVNvWfiVj6PP8Xnjfq8qxJ21e6wYdUH9tj1b
	fYnsVKjbUZSKn2QIvv2/l9d6JRWkOWg==
X-Received: by 2002:a17:907:6295:b0:94e:cbfb:5fab with SMTP id nd21-20020a170907629500b0094ecbfb5fabmr16778392ejc.75.1683732213536;
        Wed, 10 May 2023 08:23:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7wVCdAKwUlJ8V9lcgbWEAiwFeSNH6AK2FonknQiPTYHWcs8YvzVYyw9uHkDEkxON4bz52OSg==
X-Received: by 2002:a17:907:6295:b0:94e:cbfb:5fab with SMTP id nd21-20020a170907629500b0094ecbfb5fabmr16778362ejc.75.1683732213215;
        Wed, 10 May 2023 08:23:33 -0700 (PDT)
Received: from amikhalitsyn.. (ip5f5bf3d5.dynamic.kabel-deutschland.de. [95.91.243.213])
        by smtp.gmail.com with ESMTPSA id kn3-20020a1709079b0300b0096a27dbb5b2sm902755ejc.209.2023.05.10.08.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 08:23:32 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: davem@davemloft.net
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Christian Brauner <brauner@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next] net: core: add SOL_SOCKET filter for bpf getsockopt hook
Date: Wed, 10 May 2023 17:22:16 +0200
Message-Id: <20230510152216.1392682-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We have per struct proto ->bpf_bypass_getsockopt callback
to filter out bpf socket cgroup getsockopt hook from being called.

It seems worthwhile to add analogical helper for SOL_SOCKET
level socket options. First user will be SO_PEERPIDFD.

This patch was born as a result of discussion around a new SCM_PIDFD interface:
https://lore.kernel.org/all/20230413133355.350571-3-aleksandr.mikhalitsyn@canonical.com/

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 include/linux/bpf-cgroup.h | 8 +++++---
 include/net/sock.h         | 1 +
 net/core/sock.c            | 5 +++++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 57e9e109257e..97d8a49b35bf 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -387,10 +387,12 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 	int __ret = retval;						       \
 	if (cgroup_bpf_enabled(CGROUP_GETSOCKOPT) &&			       \
 	    cgroup_bpf_sock_enabled(sock, CGROUP_GETSOCKOPT))		       \
-		if (!(sock)->sk_prot->bpf_bypass_getsockopt ||		       \
-		    !INDIRECT_CALL_INET_1((sock)->sk_prot->bpf_bypass_getsockopt, \
+		if (((level != SOL_SOCKET) ||				       \
+		     !sock_bpf_bypass_getsockopt(level, optname)) &&	       \
+		    (!(sock)->sk_prot->bpf_bypass_getsockopt ||		       \
+		     !INDIRECT_CALL_INET_1((sock)->sk_prot->bpf_bypass_getsockopt, \
 					tcp_bpf_bypass_getsockopt,	       \
-					level, optname))		       \
+					level, optname)))		       \
 			__ret = __cgroup_bpf_run_filter_getsockopt(	       \
 				sock, level, optname, optval, optlen,	       \
 				max_optlen, retval);			       \
diff --git a/include/net/sock.h b/include/net/sock.h
index 8b7ed7167243..530d6d22f42d 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1847,6 +1847,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		  sockptr_t optval, sockptr_t optlen);
 int sock_getsockopt(struct socket *sock, int level, int op,
 		    char __user *optval, int __user *optlen);
+bool sock_bpf_bypass_getsockopt(int level, int optname);
 int sock_gettstamp(struct socket *sock, void __user *userstamp,
 		   bool timeval, bool time32);
 struct sk_buff *sock_alloc_send_pskb(struct sock *sk, unsigned long header_len,
diff --git a/net/core/sock.c b/net/core/sock.c
index 5440e67bcfe3..194a423eb6e5 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1963,6 +1963,11 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 			     USER_SOCKPTR(optlen));
 }
 
+bool sock_bpf_bypass_getsockopt(int level, int optname)
+{
+	return false;
+}
+
 /*
  * Initialize an sk_lock.
  *
-- 
2.34.1


