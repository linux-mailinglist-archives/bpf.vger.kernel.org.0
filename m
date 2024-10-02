Return-Path: <bpf+bounces-40778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 987B298E1F8
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 19:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A803282903
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 17:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DA31D1E86;
	Wed,  2 Oct 2024 17:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsRi/526"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395F41D1E73
	for <bpf@vger.kernel.org>; Wed,  2 Oct 2024 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727891890; cv=none; b=FUv3OXT4yBEq0+B19XQRlIJKTZVsvYz9ndGNux5BQV3IOiGt74AiDqNBlVRD0RbLO9zgH6noMw0sAgjnEAnrK6Xl2X5lZxb/ytpw+O1Mfb7KVw53cW243Mi/eqDJ8IK25IdKFZ/C7MCe3YHHIfn5QXdLCgBElg1zNJU2Qp56Mg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727891890; c=relaxed/simple;
	bh=b6KvePfffFEKiu1M2rqJgK1IsIos6O71hpMN9iIyrUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dz2/LZJ9PrHrBIU1ms6VN14Ml9qYvNLukjWPKD2yGPbYtHbq/cKqrSQPrGdTqab6G7dU0SxI0fDxlSX8XmX8UGgcwbpS3jMVbg9nD7MoCmUrrn5YUfcGy8dS/R+nN6/qFw8TlNzMYDAFQGcEcgngM5ueTlHQlWc0VQ1IH8gZ7G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsRi/526; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42e7b7bef42so94155e9.3
        for <bpf@vger.kernel.org>; Wed, 02 Oct 2024 10:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727891887; x=1728496687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7mWAMXxlBASlbTkvKyCIwAQyyzMjvxLrTr0mAC83f0=;
        b=JsRi/526weWxhH24GO21jkd981i6+mycmNHLOD6XH6hX/b2iqW0AqK1HDqfPOa5boq
         H0rX+imvBeWXicZV9sdqcRGzfFvLXVo7eDb8H5bZwxssmqKWgT1Kx09yYxXCrqehxZtE
         Qze9q9H/Ism4Q3sVeb3SZttrhNDLl144Q6M8XF3mfkKrcuWwvowRrDLZYBzP1urzYRPD
         Yj/eM4KvMv97PkzjS131KjfOIafw2BhGh96PAn5tAJgbped6i8d1jyx57y9zvSZ2XnNu
         +ihmktYQv/vUO/seT8yw9eS0J/PNGgoHJ8xnqm8iWitDCTEbpbInb+QWZ7qAaXb6EBkp
         73rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727891887; x=1728496687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7mWAMXxlBASlbTkvKyCIwAQyyzMjvxLrTr0mAC83f0=;
        b=EaJL8izRxoJ7as/FwGu20WFz8XUjEwbedMdXfy2NIs53rzzxm4pcl+y9MfzYtabqnG
         p0oC7BNd13FFtZSURREU7G9TNfVeTq+1cf8je1aWLE31Uyrwz0KZcymDCPQqT3WWb/A+
         V+/0RQfpccLxbU/jdQ61ztUYDKxwTMyKlTx/EfZjInIgAlzjbnKogqXfZR/LhLaLWt9X
         vjoBCkMkUgB4D0CqNU8uNuCQcCM5R59jcDODC8eLXtsQNWUIKxm0HBBfAER8hFkB/jWC
         E7MTXmd9SgpHJpSX/IrCkWAv5I52lltivpSaeRnfX1k0/HYtpjFi2fo15oIW87TPFoHL
         LDZQ==
X-Gm-Message-State: AOJu0YyEDZEgbRt49fYSjrON1QUv1ucbNIQx9DpyVxSvodNyUMWi5kuC
	omi/RWedm6wFf9VFDmfLFK2EeNK5+VNaY+nDi3y+cjBJNIgltk76Vvjp5jQlDqhm6g==
X-Google-Smtp-Source: AGHT+IFpL8yB3pBsNMk6iByKyIPqQxTPZ21qoAAhNhRbbf7KD2L29RGScTTgR1KWFDRd3WguVkEAsw==
X-Received: by 2002:a05:600c:3504:b0:42c:a802:a8cd with SMTP id 5b1f17b1804b1-42f777b72e1mr30435635e9.11.1727891887176;
        Wed, 02 Oct 2024 10:58:07 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.c.cilium-dev.internal (114.73.211.130.bc.googleusercontent.com. [130.211.73.114])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42f7a00bc5csm25616495e9.45.2024.10.02.10.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 10:58:06 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v2 1/2] bpf: add get_netns_cookie helper to tc programs
Date: Wed,  2 Oct 2024 17:57:25 +0000
Message-Id: <20241002175726.304608-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <f05e5f07-467d-441a-8113-0a7c4cb2c842@iogearbox.net>
References: <f05e5f07-467d-441a-8113-0a7c4cb2c842@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is needed in the context of Cilium and Tetragon to retrieve netns
cookie from hostns when traffic leaves Pod, so that we can correlate
skb->sk's netns cookie.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 net/core/filter.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index cd3524cb326b..6e80991125ba 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5138,6 +5138,17 @@ static u64 __bpf_get_netns_cookie(struct sock *sk)
 	return net->net_cookie;
 }

+BPF_CALL_1(bpf_get_netns_cookie, struct sk_buff *, skb)
+{
+	return __bpf_get_netns_cookie(skb->sk ? skb->sk : NULL);
+}
+
+static const struct bpf_func_proto bpf_get_netns_cookie_proto = {
+	.func           = bpf_get_netns_cookie,
+	.ret_type       = RET_INTEGER,
+	.arg1_type      = ARG_PTR_TO_CTX_OR_NULL,
+};
+
 BPF_CALL_1(bpf_get_netns_cookie_sock, struct sock *, ctx)
 {
 	return __bpf_get_netns_cookie(ctx);
@@ -8209,6 +8220,8 @@ tc_cls_act_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_skb_under_cgroup_proto;
 	case BPF_FUNC_get_socket_cookie:
 		return &bpf_get_socket_cookie_proto;
+	case BPF_FUNC_get_netns_cookie:
+		return &bpf_get_netns_cookie_proto;
 	case BPF_FUNC_get_socket_uid:
 		return &bpf_get_socket_uid_proto;
 	case BPF_FUNC_fib_lookup:
--
2.34.1


