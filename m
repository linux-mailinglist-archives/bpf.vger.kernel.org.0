Return-Path: <bpf+bounces-56554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A855A99C41
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 01:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49D827B0AC9
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 23:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B233A242D91;
	Wed, 23 Apr 2025 23:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="rFXobRAo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD7B2701BF
	for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 23:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745452290; cv=none; b=kF212FxfLi9vnSjZCUzrtavZ88B8VWa3Pr+u0lhhai7BAVOZBpy/dzHqpDoNgpEaWieW1BZweyIXxbupieECmFlRilI+dnRStV4TWD10pon4cRG2YtoPy1CbTL+cD8pi2WHDufQ0Flm6cpFQHAXDqebjSv2heMMn5en5AXGQMT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745452290; c=relaxed/simple;
	bh=FvoiZo8CsQW0GPXAIiATIYaWqN8/nCTt141sKLDXks4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nfED4Y0m4iCw9GkeEpKP8P40sZzxHai6+qq9OqFpUznAnaqjP/NcCuuxkpa+2doPwVjbDPUGwvzfM0VJq45lh2kbEJAbNJRAUWr00ypnjh7EOTr7GezYRL0oSOCyeDqovcBypbuLvmCPi2q5K28GaWquPXjYNpnQOPuw2bgyeSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=rFXobRAo; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-227e29b6c55so744855ad.1
        for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 16:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1745452288; x=1746057088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8T6hDhDL07Ig6e5imc6Py5jYi0Q9TXugskoJKEqglC8=;
        b=rFXobRAo9Veuz4M9cQXAlNUiDRPg8N281ifgb77de6foU7X/+NYyNwCBbHk6/8Z4sq
         dIdfTgM/4+jgY/ov+Nr6mbHdi0zA3/z+R0xMECK1U+79hxbPGcfwJwGdlYKfO3QX89GV
         ZNakRegm0AELqMkC4chAo9HZVTVWfgB5xEpc6Ahcx7DsZ0Hmn+CM+0Ae2XmewzwGtnco
         W/8o6OQ7MYtrBoco+zj9sGW9FyABmNX/Q7kaqFELG/Y3NJMcTjtGa2W16IgDzb9gfc7G
         FxMZGKe1TZwXxrtrWzyI48toWDFkA3QsTGWRKVkO0/wqf43eBc2OItPTysdnfu5P6LtL
         Xtjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745452288; x=1746057088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8T6hDhDL07Ig6e5imc6Py5jYi0Q9TXugskoJKEqglC8=;
        b=s2/Fek5fooO0yyFZfj105TBv4qEwevlsAmM5mh+uuEUxbhP0xSVbmEudfPefPVF5ud
         4XG9cY+2NT9D5eSZ+ekG9QkwXsxQBU9HyuYVK+JJ0+YWojYT6dndJof0+84Y61p8AIqW
         cSB+N3wvhsJgV943DJCaJ0rGLwVULJwF1D0MiTqERkXwUS3oB+GzOJTjJ6fLKr3NsTs2
         4X0OaiE+g9u44rNuH3CJZxBahSUk15zh0mCbgqhYanpJVK3ZScp1TXQMe3bi8Lb4779G
         djkHKAs3h2qlDFFBofQ1b8kd5Py3OXVTarniIGrc57v4OVWM8auYkaP0ym7nF7qYn811
         SMmg==
X-Forwarded-Encrypted: i=1; AJvYcCVwSAb2fmKYwBefSiaAt1AkSJ4OvGi5i/fBZHlnCl7lO+uxnElKlS0ZuvzPWtN1xfARq7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWMqytG8yY5vDrvDhzNe+TXIQ2mIe3vt0sQZdm+bF4ph0w24AZ
	66/vh2kS6q8ijIxVj+5O/5vu1Vit0i8iDJ9ogcJ7JqVwya4BVDjoVJOKghep1/Q=
X-Gm-Gg: ASbGncu9wNPmpgfDH+yiKo27G1HbCnW8xqYVGPw8zoYdyue4M38dDMiSrsmhHcYI7ai
	yMhzyZ1p5EFqs8BZduLFjxKzlb9zIEnIbDAJPGlEthCqqb9K2BYkPddMncupKp85FM+Pn3DOWUY
	E5rZ8B1+bnIqMAymPTceT0aqDoZnqD089jFJHUqlvf+6iEUb0DB3sSI1Y1GAfqGGHCq1iWJVWFp
	LXM7AyD7ZDJTicncSL9IzNsJBhKXSbKAIklNMplQOBQVkl78W1NrHzF36MA1LkeUF7hyRJ+mB42
	ZHfhgdEtTB9oPX1G7HFSTfWVJ5qtKA==
X-Google-Smtp-Source: AGHT+IEyGRyxFGq4bQ617nWX+ar/YlqkpHG2LTnFNSv2adeU33TxrPM3w/oazKd8EtAl2do0qnCXDw==
X-Received: by 2002:a17:902:f541:b0:212:48f0:5b6f with SMTP id d9443c01a7336-22db3d72cbcmr1907505ad.9.1745452287851;
        Wed, 23 Apr 2025 16:51:27 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:f4b1:8a64:c239:dca3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d76cfasm499175ad.47.2025.04.23.16.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 16:51:27 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH v5 bpf-next 1/6] bpf: udp: Make mem flags configurable through bpf_iter_udp_realloc_batch
Date: Wed, 23 Apr 2025 16:51:09 -0700
Message-ID: <20250423235115.1885611-2-jordan@jrife.io>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250423235115.1885611-1-jordan@jrife.io>
References: <20250423235115.1885611-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for the next patch which needs to be able to choose either
GFP_USER or GFP_ATOMIC for calls to bpf_iter_udp_realloc_batch.

Signed-off-by: Jordan Rife <jordan@jrife.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/udp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 2742cc7602bb..6a3c351aa06e 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3401,7 +3401,7 @@ struct bpf_udp_iter_state {
 };
 
 static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
-				      unsigned int new_batch_sz);
+				      unsigned int new_batch_sz, int flags);
 static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 {
 	struct bpf_udp_iter_state *iter = seq->private;
@@ -3477,7 +3477,8 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
 		iter->st_bucket_done = true;
 		goto done;
 	}
-	if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2)) {
+	if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2,
+						    GFP_USER)) {
 		resized = true;
 		/* After allocating a larger batch, retry one more time to grab
 		 * the whole bucket.
@@ -3831,12 +3832,12 @@ DEFINE_BPF_ITER_FUNC(udp, struct bpf_iter_meta *meta,
 		     struct udp_sock *udp_sk, uid_t uid, int bucket)
 
 static int bpf_iter_udp_realloc_batch(struct bpf_udp_iter_state *iter,
-				      unsigned int new_batch_sz)
+				      unsigned int new_batch_sz, int flags)
 {
 	struct sock **new_batch;
 
 	new_batch = kvmalloc_array(new_batch_sz, sizeof(*new_batch),
-				   GFP_USER | __GFP_NOWARN);
+				   flags | __GFP_NOWARN);
 	if (!new_batch)
 		return -ENOMEM;
 
@@ -3859,7 +3860,7 @@ static int bpf_iter_init_udp(void *priv_data, struct bpf_iter_aux_info *aux)
 	if (ret)
 		return ret;
 
-	ret = bpf_iter_udp_realloc_batch(iter, INIT_BATCH_SZ);
+	ret = bpf_iter_udp_realloc_batch(iter, INIT_BATCH_SZ, GFP_USER);
 	if (ret)
 		bpf_iter_fini_seq_net(priv_data);
 
-- 
2.48.1


