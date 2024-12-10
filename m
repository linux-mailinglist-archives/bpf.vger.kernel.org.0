Return-Path: <bpf+bounces-46444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEFF9EA431
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 02:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45DC5188A77F
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 01:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FE87082B;
	Tue, 10 Dec 2024 01:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iZbi2U3h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAE770806
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 01:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733793648; cv=none; b=JK5fbyjzcOguaDPA5ggXKiH3LWY3KyLzo+Nfjxz5SivoERm8/S/VVFQn4nGejuxjTws6V0CHjmoAsN7i18sMIPUXh5dETkW4beNyXX+W5rGDGAfCnSgNmBXivQVlghh7ot0Fki6Mmul8ggoViqFAe1ah5mJx99cGPfM6ll/HTnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733793648; c=relaxed/simple;
	bh=vEUd0YwkL2bHlHo9bTCIdcaC/JGuoRWcZEmofKMiVGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QtinIWTqtjuEAP7V8oppRXm0s3BmblrdcAgLTAR0E2LueoXF8gETZYghGjqYlz1AeDqK5uoj1CtZYxOTbjviKmxTFFIWeC5Fqj26tCGHxe7j/5OFzPNLepC6H+1jL5MveYEvfp1aMRJjsOrWFqDAkIPJMgtTB0HusdUgLJZP1EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iZbi2U3h; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-467540980c9so28203731cf.2
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2024 17:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733793645; x=1734398445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPQePnGmxZLFdqSftS1QGw2B4wNUl4Xt9WYqUIVlY/w=;
        b=iZbi2U3hjxX6ZdxFvEqr0YZ9OOVAqFf36/ItT8Rxf2o9EbS9RvqTbXcCn/vQ8J2Fo+
         K8GSq9WOXKm6wPFKS0YdkIyjnRNa9JcugCpsGDAX4Vqn+HcWsMIzQE6UXXEqN21w1IIr
         UMErU/mSOnl/4h5RbYeq/B1HTJOeXyor6NeRyGHuos+sTxyULW76TBOwrUbpUV8DnW32
         0pWlE/BIHigeOZYEZ5Qw9XijWG1pd3kzv5EDpTcxMNahtbPI5rJCnmNpIgbDO9GEb/z7
         yeYw+Ezqy7+BEbGy2VNwjCAoDgw+Mi3Pgf1wBCZ5JELpteuqhAsptr1+2NT7uygR5/Dr
         84ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733793645; x=1734398445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPQePnGmxZLFdqSftS1QGw2B4wNUl4Xt9WYqUIVlY/w=;
        b=SDGz4428TnnCa7HOsPjH5PYqigiPsoJucBXbj+46rEDY8eBt8ZM1Z9WVSjLY/7OE0T
         Px3iCvmoe86DTFQ2Uk3riqoOLiIURz2dwJAE2lzKRbYEv7y6GbxRUpqBJpitrdOE5TyS
         JDjjxMErv5YF126Awn2jUN1rKJzL49aDOeYJi/HnXZyva+oh5TSX9WdqUwgUJ0P+aNz+
         Jy9VlX0jSoQpTEQJEL3Ur/WOqPYX7IQ1tVOUrfNxIw2wVHkIqvwxaACpW/9cQGmki26Y
         rdBGjx7FpPf/7y+GleDtMT/RdOH6DnVSwGPnih3VZDKkGRBLVYo6yZoge4AhYeCP/xha
         p7DA==
X-Gm-Message-State: AOJu0YxxtEXOKCz05oHzqm5cChj+MBMnRQ5IPtTbYKO14Olp2KMbFiv2
	jPgddxYcHOUE+RzMQt/aHyZIvMtNFi0iXkgjP3wiMxaDC090nPKmfi7U8ClDSmLN8lBqxpZurz0
	G
X-Gm-Gg: ASbGncv7n++g90utXfvAnPzUSi4th146i2SwQ+Qpea7NQ4Z70Q/UrcQpA+q1hdIOoxI
	8x0V/McwsQS9VoDCq01n3AvGA7JOvtQb3Fv9KUWAAIKxWYhQ0q5gS5991RRb8GFpLhWv5Naydtk
	xU9H/0cGKnyYcekhZuOdxfsdk7yR6NKlPpVbE8PCc5Mz19wXwgjMQfAI+9rhTiGYjKCQuXJXk3T
	cVRWSALNlF/QTWs7Is9ZUBWeGhe3m58jOBM0w/t3XOcgcQbKLSMKaxCualHEAdWMBoiRbg+UVxt
	6eM=
X-Google-Smtp-Source: AGHT+IFuk2gSsYsNdvw2Al86O3XxUmuHFbVzcrCJK5DKwqewhln70ZLJf81eA4FHE18IAlnlHjhdoA==
X-Received: by 2002:a05:622a:4810:b0:467:672a:abb8 with SMTP id d75a77b69052e-467672ac577mr91366821cf.5.1733793645045;
        Mon, 09 Dec 2024 17:20:45 -0800 (PST)
Received: from n191-036-066.byted.org ([139.177.233.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4677006d143sm8116521cf.19.2024.12.09.17.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 17:20:44 -0800 (PST)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: john.fastabend@gmail.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>
Subject: [PATCH v2 bpf 1/2] tcp_bpf: charge receive socket buffer in bpf_tcp_ingress()
Date: Tue, 10 Dec 2024 01:20:38 +0000
Message-Id: <20241210012039.1669389-2-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241210012039.1669389-1-zijianzhang@bytedance.com>
References: <20241210012039.1669389-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

When bpf_tcp_ingress() is called, the skmsg is being redirected to the
ingress of the destination socket. Therefore, we should charge its
receive socket buffer, instead of sending socket buffer.

Because sk_rmem_schedule() tests pfmemalloc of skb, we need to
introduce a wrapper and call it for skmsg.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 include/net/sock.h | 10 ++++++++--
 net/ipv4/tcp_bpf.c |  2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 7464e9f9f47c..c383126f691d 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1527,7 +1527,7 @@ static inline bool sk_wmem_schedule(struct sock *sk, int size)
 }
 
 static inline bool
-sk_rmem_schedule(struct sock *sk, struct sk_buff *skb, int size)
+__sk_rmem_schedule(struct sock *sk, int size, bool pfmemalloc)
 {
 	int delta;
 
@@ -1535,7 +1535,13 @@ sk_rmem_schedule(struct sock *sk, struct sk_buff *skb, int size)
 		return true;
 	delta = size - sk->sk_forward_alloc;
 	return delta <= 0 || __sk_mem_schedule(sk, delta, SK_MEM_RECV) ||
-		skb_pfmemalloc(skb);
+	       pfmemalloc;
+}
+
+static inline bool
+sk_rmem_schedule(struct sock *sk, struct sk_buff *skb, int size)
+{
+	return __sk_rmem_schedule(sk, size, skb_pfmemalloc(skb));
 }
 
 static inline int sk_unused_reserved_mem(const struct sock *sk)
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 99cef92e6290..b21ea634909c 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -49,7 +49,7 @@ static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
 		sge = sk_msg_elem(msg, i);
 		size = (apply && apply_bytes < sge->length) ?
 			apply_bytes : sge->length;
-		if (!sk_wmem_schedule(sk, size)) {
+		if (!__sk_rmem_schedule(sk, size, false)) {
 			if (!copied)
 				ret = -ENOMEM;
 			break;
-- 
2.20.1


