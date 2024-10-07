Return-Path: <bpf+bounces-41099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 258A1992895
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 12:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 323C61C22DE3
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 10:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BA12261D;
	Mon,  7 Oct 2024 10:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMcBQjT9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5827718A6C3
	for <bpf@vger.kernel.org>; Mon,  7 Oct 2024 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728295218; cv=none; b=EKpD+6c8yIYHEstlrOUkodlovNUyY+3sB3EHBafgdY642NDfbq9EheKOBXO5Th8zfhH8l7XGj0eSQ9R2oV3PIvb03+zCRvXkB819MSmIYhNw2Q3tIXEtVdwqeZtQfiLiNE7MjXhgqbf0P1UW9ebxJuohd+czLBf+FuF2PTxhUY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728295218; c=relaxed/simple;
	bh=cYo9V1UIltaO9ShHBWLec362vugAkhYmHURfIX94hFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j1l1s5+F75NKEpAlm+YJLadn9YZG+xOqTEO0pw0D4/FlZuzUxB+lbQ5wsaBm5TRLC+DLEF0mmi77NRGwjhS6gbkfiAQrL5mBoz72mMnXMZkE5eCNDJX3BRxuA0BAlSaI1OH1z5YUwHoqjy8/uIICuQCmB5lK1V4yE2t+VJxxAIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMcBQjT9; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37ccebd7f0dso2807930f8f.1
        for <bpf@vger.kernel.org>; Mon, 07 Oct 2024 03:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728295214; x=1728900014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sll7JLEHgXGJR32nDZ0iI2qJz9B5qTzitcjl3kS5oJs=;
        b=cMcBQjT9qZcGczO63m6H8ZlH++kxXHqgIUd1eAmE29IPE7hDS4Cno67GmoAFnjrn8q
         FtNUVAG5KEuXSukcnpom5kMUuGMdC7+Lvq/5gV2iey86hA0OK2JwzmPd5DuocEm/Mdjj
         pr5R2u9frvLqEYpCpWhFH6fLBEDYNg/EkakTnRt/Z8ZF8XaQHyOjqzswWNBI41huJ67L
         bPSjvc+LpeD1pCuTytBfau3tt/ayOAXGOg6k3QC2lrKl3rEOOjlpIQKB7WghYb+Kqqz1
         06mbhhHMxM0IfwtRXEQ4Dg8Z8hVltpb2okcT3sz9DFF4pK+6L+ig9hkZbcIP3Z6Kth3o
         PzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728295214; x=1728900014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sll7JLEHgXGJR32nDZ0iI2qJz9B5qTzitcjl3kS5oJs=;
        b=SXWPMTImY3vRGVpil4lveVtOBbP74Nwij+8vbtsO3lpsILcyGgFk6Qw3bckunAVzFy
         Si+8stxmMj7qFtHzZlDapxaqBc44qJyMYwczlgnoztxIOV0mrvj0NGV/tVwb7xlxNMOJ
         J61Uotr1r2O16FUHY01Wb6V4MuDOJ1vuGY7FAhmG2gIKRpaz+5g4SMBp/nftYYeiMVmU
         jw8Fj4AcAvK28fuo02+nEeZBJFiqlCxa8/wb7XWEigMr//zgewot/Ji4DEYIW3JoYe3n
         FgCQ+NR+D+0eeGtpO1aFCNHGxogRFsuJ3P7ULm7ck0DQQj3/WnrblaOtPCgyyXS7Cdhh
         44Yw==
X-Gm-Message-State: AOJu0YzxUNjCI5n809buVeIdFjHy5ClftyDjVfmUPW45BQrG0wq1JVhm
	vfGE/9+padVq7P8AVrvC/6Tf/oqSxR6/GzgiGcNhhSeoKTHCRlWsT2QeOrRyfLE=
X-Google-Smtp-Source: AGHT+IEbdDZ8BOhqvMcnPZNbdNrTBLicZnCYEsE9j8scLfc12ZYINFIxKGXky2J41jJMsU8m2DulhA==
X-Received: by 2002:adf:ce0e:0:b0:37c:d2be:6213 with SMTP id ffacd0b85a97d-37d0e6f2b03mr6670915f8f.21.1728295214308;
        Mon, 07 Oct 2024 03:00:14 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.c.cilium-dev.internal (169.218.205.35.bc.googleusercontent.com. [35.205.218.169])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37d1695e84fsm5341188f8f.75.2024.10.07.03.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 03:00:13 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v3 1/2] bpf: add get_netns_cookie helper to tc programs
Date: Mon,  7 Oct 2024 09:59:57 +0000
Message-Id: <20241007095958.97442-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <a67821e7-e0e2-442e-a7c4-30889a482806@iogearbox.net>
References: <a67821e7-e0e2-442e-a7c4-30889a482806@iogearbox.net>
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
index cd3524cb326b..944bbe12a039 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5138,6 +5138,17 @@ static u64 __bpf_get_netns_cookie(struct sock *sk)
 	return net->net_cookie;
 }

+BPF_CALL_1(bpf_get_netns_cookie, struct sk_buff *, skb)
+{
+	return __bpf_get_netns_cookie(skb && skb->sk ? skb->sk : NULL);
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


