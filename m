Return-Path: <bpf+bounces-30641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 159D68CFEC0
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 13:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC4B1F229DA
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 11:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EBA13C830;
	Mon, 27 May 2024 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DDnSdCty"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C685613C812
	for <bpf@vger.kernel.org>; Mon, 27 May 2024 11:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716808832; cv=none; b=UHlztvuH7oAPAPtwuVGy1bWPV52bRgwd+vdKb9BD2s+695tUVbJNkTbozmN8H8bKumXi/z3MbQilAhgra4Fe+w9LC5i70WZrGvNgjTcTXprlXj77p+7l27kI0/YzSDqqhEo/XNrpUgS6Q0n8AixBAy+rCIBT/GXQLtoyI+7w3OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716808832; c=relaxed/simple;
	bh=/pUlgplupYCOqK1duqkRbcNAf5YH4JpBn1oxEDeAaAs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M6PSIy6rFBvdELvq/0M/sidSDA2p1AFNPoNod5RiQF47USHbMGLU1/QZNW5xermVHC76f7HQ3sE6MWr2ouGK8zLE/QsTPsP7z1OcSpbHXDgGemAwbApZiWsGQuC1Rs8f0yzSDl5Ydmuwv50tJXPdHY1h8yhIq6z72zV5q7Qalnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DDnSdCty; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-578517c8b49so3598234a12.3
        for <bpf@vger.kernel.org>; Mon, 27 May 2024 04:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1716808829; x=1717413629; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=23ydGa8yIzcGu+r2oGEhHlYDDTdCA1ncbXSuOWhVYp4=;
        b=DDnSdCtyMO6b2TRxJLXiZVv0dgWZw4drthuuJB5Mt0p1sDWEvlU05p+5Iav9OV1F/j
         AFrUn7IjJZjm6wqCcjmJop+S9TMdcac4/ri3LestQYukGCadlnxsZ7ZC5rkXnHNuAELA
         eO0uuBM2t71jjvbHAElNJQpJrNKUAOt46Yp7WmVX5+nr7RrxAOM+JXzBf3yesn+buytl
         q67QIOIoFq0GjUao8iI1jEnP9IL215PXeMb5pJU56pUG/m2jNco3fYIC8u2P1lxmv34G
         jO9AeVRjuTSZzcQRXGs1vDPMqz8HtllU6K1/cXusJq/cJVWSdkb7o6UlDaknBFcuH5lc
         835g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716808829; x=1717413629;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23ydGa8yIzcGu+r2oGEhHlYDDTdCA1ncbXSuOWhVYp4=;
        b=obDMsmqsaK5b/jbxYFXxm+v77OBvfYExafO4TfVM/CyRzEi5rr1EtJjDFeB61nkOe+
         a6MITUJ01S3stf9l1CNV9/dlGT6I/UvHqdJja2MC6rx4wy4y7p/4e6KrD907mgFlKsZO
         izpyKJKKjt3dN9VPo5drKy/VMAqblljioEBviQukz8oemLMkHXiyMLdI2BpOMIirKxI5
         CuQaPDYgfR7v8lfeWjpIU7K3WTzK9ztwe/9hmaDF9GBTqr1VFHw9AVVgL8poOOALK6rj
         TxtO96wI7VEVEcLqf+bMX5gIVD8j2WtQBK2lqu+aBZczRzpPGQMGFjKOTGGxyv7kd2k2
         ktbA==
X-Gm-Message-State: AOJu0YyfvRB18x7YKQ8oMgNfmIXSB1VolAiiftMYYB8IHEM/d14DGoUW
	oqm1NaLg6G7ztKbSwgUoM/TkjgElBKLYR9lcspTAk0HEkZdM0LSyEfFnrFKIV9s=
X-Google-Smtp-Source: AGHT+IFvvW2lCjoGdGPrafpT7u5NIuceCRbFGyD2XheJvPNRdpJVua1qetJRkoBXERnEWuzaSX3vOQ==
X-Received: by 2002:a17:906:1c8e:b0:a62:15b7:c45 with SMTP id a640c23a62f3a-a6264f15d6fmr616516366b.55.1716808829145;
        Mon, 27 May 2024 04:20:29 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:20])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a62b67f0bbesm280204666b.211.2024.05.27.04.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 04:20:28 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 27 May 2024 13:20:08 +0200
Subject: [PATCH bpf 2/3] Revert "bpf, sockmap: Prevent lock inversion
 deadlock in map delete elem"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-sockmap-verify-deletes-v1-2-944b372f2101@cloudflare.com>
References: <20240527-sockmap-verify-deletes-v1-0-944b372f2101@cloudflare.com>
In-Reply-To: <20240527-sockmap-verify-deletes-v1-0-944b372f2101@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, Hillf Danton <hdanton@sina.com>, 
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.13.0

This reverts commit ff91059932401894e6c86341915615c5eb0eca48.

This check is no longer needed. BPF programs attached to tracepoints are
now rejected by the verifier when they attempt to delete from a
sockmap/sockhash maps.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/sock_map.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 9402889840bf..63c016b4c169 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -423,9 +423,6 @@ static int __sock_map_delete(struct bpf_stab *stab, struct sock *sk_test,
 	struct sock *sk;
 	int err = 0;
 
-	if (irqs_disabled())
-		return -EOPNOTSUPP; /* locks here are hardirq-unsafe */
-
 	spin_lock_bh(&stab->lock);
 	sk = *psk;
 	if (!sk_test || sk_test == sk)
@@ -948,9 +945,6 @@ static long sock_hash_delete_elem(struct bpf_map *map, void *key)
 	struct bpf_shtab_elem *elem;
 	int ret = -ENOENT;
 
-	if (irqs_disabled())
-		return -EOPNOTSUPP; /* locks here are hardirq-unsafe */
-
 	hash = sock_hash_bucket_hash(key, key_size);
 	bucket = sock_hash_select_bucket(htab, hash);
 

-- 
2.40.1


