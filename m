Return-Path: <bpf+bounces-40772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 594E398E006
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 18:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F841C230D4
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 16:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E0C1D0B97;
	Wed,  2 Oct 2024 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/dDn2e0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89CF79F5
	for <bpf@vger.kernel.org>; Wed,  2 Oct 2024 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884892; cv=none; b=pU5gibWHSlTs1Am+P/S2bRBcoDHpKJWawkd0SURLmUL7vWaoK/8Z+BHk7sEh0HGAwOVClE3zvMbPRHUc6Qp7fXCPAW4PUPFaXVcVI0TvevP8fL0axucXgDu1uu9mYOyJxwr96+d5U8WNNOo0Xe8vaSvxvM0OieEu0Ku4OSKExss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884892; c=relaxed/simple;
	bh=b6KvePfffFEKiu1M2rqJgK1IsIos6O71hpMN9iIyrUo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MaapPa+0S/CMWy1ag9UiN3dvdgJyKtzsacV4KO8AonxVdsapY2r1BV0CVZVkX2VXdW2jHX1hmNe+xJ7mfbsU3YXktcUSFmJICtjMN34tlrRpfMuRWTIs9I1puHxVYxzkzB/R6Gh35F6MqcgCj1bY5XQaGZxBRBrTyZCwtZqX9qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/dDn2e0; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37cea34cb57so2177833f8f.0
        for <bpf@vger.kernel.org>; Wed, 02 Oct 2024 09:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727884889; x=1728489689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h7mWAMXxlBASlbTkvKyCIwAQyyzMjvxLrTr0mAC83f0=;
        b=I/dDn2e0XI5ZFuc758zGcCPg4s6T7Dve/V5N7ySVfArSJIRcihqSXzawKJUd8phfll
         FJNFkUa3WHhZfyVlvu4woZ15fnKI4gy+n5f7/a2smc6Xqxe3bTWdvR/xyFifWvryjoTL
         n7fActvOQSl/s7yTS0jOpEW/p1DVin6jp9VNVWv/kJ2rtQ2xTQsTYHoOGbE1l1rtEBs3
         Cu5BPYxuOyE/gUIWZgoF3qpXgYOtDKQ26oXo3NsHea5Qq0AJuQ37WeMnaHRt94V1Tw6Y
         HSxTK+FdI3/FBFpsRyu0+9rT7/x9qwp4KNclDmwNqqgm2U+R16AE5BAVGYSLB0X5qXSZ
         uZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727884889; x=1728489689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7mWAMXxlBASlbTkvKyCIwAQyyzMjvxLrTr0mAC83f0=;
        b=ww8VDJUH0ryM54RJLu2OQ/nI0KIFkeolZJXc9msAzMcndDMq1h5siQd1fjQ3PM6GLq
         4xKD1CET/2VxyTgsWQ+ATlvbBT5+yA5HXj1sF3/TV7UJBmcLH605dlWSKBCyP7x2cuut
         Szhie7At5wkg23KJhPJjfv8uazI62py/6fGVhwJsBxIjtazH1Z4GyaSUHbWvf3HczwFe
         uz7pwObtfT9kQEm5jP/VIkjtPQ+18ah57KbsnZodlsedzSIxjbtXizQq00pjWwal8JpL
         sLNsXvENtw93QXS9sbwKGewHPQwwNadhG5DD6fJbjREMspO0hLUArLm8/iW4nXbRFnn5
         1uXw==
X-Gm-Message-State: AOJu0YwFiuLrawcSN4wSSM/ncFxRGhxxxfTYeOAtI+MntdP+T5PuhIXB
	RtN+0xVoF+HN8eEFuVPrxuuR3MhROcYS/qMBTWuWrQBawJmy8+0XT1qYBs5+g5qQmw==
X-Google-Smtp-Source: AGHT+IEsTrvkIYp2s+z27+zfKgeee1eb2O/eGLDXG06qWBxsVrm9zlji5rEnOslIaziEeASG0EO91Q==
X-Received: by 2002:adf:f70c:0:b0:378:8dea:4bee with SMTP id ffacd0b85a97d-37cfb8d0a68mr2173249f8f.33.1727884888394;
        Wed, 02 Oct 2024 09:01:28 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.c.cilium-dev.internal (114.73.211.130.bc.googleusercontent.com. [130.211.73.114])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37cd56e65c3sm14193982f8f.60.2024.10.02.09.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 09:01:28 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: add get_netns_cookie helper to tc programs
Date: Wed,  2 Oct 2024 16:01:21 +0000
Message-Id: <20241002160122.148980-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
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


