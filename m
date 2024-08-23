Return-Path: <bpf+bounces-37999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8103A95D958
	for <lists+bpf@lfdr.de>; Sat, 24 Aug 2024 00:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF601F23C61
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 22:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9C11C9458;
	Fri, 23 Aug 2024 22:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZL+L7+Vv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74661C871E
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 22:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724453355; cv=none; b=AWfsCAX58808Nw4oJuqsn+nx/2oOA8siJIy1RKiQoJDE5NHiv/0eIBuDzFo+GN46Y1kNsaC7RCM0UNwMLFVgdJsDK2nb26B3Q9rsc29xjSLC+eM3Y9r0nTOSJz0zQ5XW1WVCwEbeds0OEPvNr2E5Uw2c6zQEOCUOiJiBqKxSkcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724453355; c=relaxed/simple;
	bh=SzDj+IkGBfuySC+NrBulaW1DN1GTdQvr1XyfZJPo5B8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=paCxEuFfrZ5+KZ4c1IdJAxrBPpwtRTmzOqLUaa8EM2E2/mUmgV0ppUocHCqfbPdvQt61NnaAZFaRGOKF1997yrNhSYri1DkWVQV47C0LedpIFn3a+jC+qT3eFbeEb8k0sQUV8kgmUxJ2tthk2PbHTEzYx8RtNuSeAIaULqvsiT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZL+L7+Vv; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5d5b22f97b7so2522025eaf.2
        for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 15:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724453352; x=1725058152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xSsxgZw8dqBytHdweXJL0wdTMnZGer2GW0z20BVV72A=;
        b=ZL+L7+VvZY6Ymkc5s6RmtLaF1IQYn7sKT6zJWWNoY18mumgBYGCptUqedrmOkCGY5o
         cGIdOU+1kPVUJKJVyed6WYAixayT5H6eGk79ZbtwqlJoMMjRBwHzi1yzLkxWrfq6yZlJ
         Dc4ij+Qhu6smrlgRb2LKQ0hs1UMyZ+cjV1o9LjW8U5u289qlT7Djrf/4xcgvOueeR3mj
         iagKgwxYxIojpXXFtr2QBCMHWPiKiUHwcYDN6gzvmz2e2m0qt9wgIh4iM4wsqScLyZwq
         01HR/+nvc+8IBF83RJ8a2fBoRG3fiYnm/Qwe9xLC2TtpooGqetDepq0PK7BfC6KvxQ4Z
         IWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724453352; x=1725058152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xSsxgZw8dqBytHdweXJL0wdTMnZGer2GW0z20BVV72A=;
        b=pRh4LPq9ZmoIS71TGEgCJlfu71t4afFz5yVhFXRTJydcfiV4kVIe0nMDaccb4KrsiY
         BEuUUQBEN9cKnOTkxozawEjbC8w0zf6aPPO21oZFh9SsE+ovzhV43t8puVIxIXl1yiLL
         5BsUUML5ka95/daNcKiJkulODbZlZiq3SljB+WrLLLfq/QCeMENXTBSpc1l38MvYQT9N
         rQbmcen/PYQ8f1UGnS+DCltci8ZL3OPDAWK98YCn73LYO/NLYHwrTbbHoN2oy86y9alj
         psyKo3sI0xDQq9Weat56wj3rii19lCtiM080kDq3ucxIUk6ctvk2dhx7USOgf/zoep8+
         7QjA==
X-Gm-Message-State: AOJu0YyMDQOP0W/RIy4AVIDvKCcAreqiKP612kIpU9hcmmsAw69Ov/ug
	4azJ0hKkKeuOP6zo/VmBFHrBld+LKWwppi01IV48oKNvGHRXPIfF5zy770wi45w=
X-Google-Smtp-Source: AGHT+IFz6X86N/Ecqrbxjnbu0qCSWogUBUFTiZGz2RkQB9Cbeov/xBFVFslHsqwORCGxaI62m7Tbvg==
X-Received: by 2002:a05:6358:720f:b0:1aa:c71e:2b5d with SMTP id e5c5f4694b2df-1b5c3b0f806mr438452555d.23.1724453352451;
        Fri, 23 Aug 2024 15:49:12 -0700 (PDT)
Received: from localhost ([130.44.212.122])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3fb45csm221505185a.114.2024.08.23.15.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 15:49:12 -0700 (PDT)
From: Yaxin Chen <yaxin.chen1@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Yaxin Chen <yaxin.chen1@bytedance.com>,
	Cong Wang <cong.wang@bytedance.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>
Subject: [Patch net-next] tcp_bpf: remove an unused parameter for bpf_tcp_ingress()
Date: Fri, 23 Aug 2024 15:48:43 -0700
Message-Id: <20240823224843.1985277-1-yaxin.chen1@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parameter flags is not used in bpf_tcp_ingress().

Reviewed-by: Cong Wang <cong.wang@bytedance.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Yaxin Chen <yaxin.chen1@bytedance.com>
---
 net/ipv4/tcp_bpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 53b0d62fd2c2..57a1614c55f9 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -30,7 +30,7 @@ void tcp_eat_skb(struct sock *sk, struct sk_buff *skb)
 }
 
 static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
-			   struct sk_msg *msg, u32 apply_bytes, int flags)
+			   struct sk_msg *msg, u32 apply_bytes)
 {
 	bool apply = apply_bytes;
 	struct scatterlist *sge;
@@ -167,7 +167,7 @@ int tcp_bpf_sendmsg_redir(struct sock *sk, bool ingress,
 	if (unlikely(!psock))
 		return -EPIPE;
 
-	ret = ingress ? bpf_tcp_ingress(sk, psock, msg, bytes, flags) :
+	ret = ingress ? bpf_tcp_ingress(sk, psock, msg, bytes) :
 			tcp_bpf_push_locked(sk, msg, bytes, flags, false);
 	sk_psock_put(sk, psock);
 	return ret;
-- 
2.20.1


