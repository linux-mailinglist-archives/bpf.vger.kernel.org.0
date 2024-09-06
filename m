Return-Path: <bpf+bounces-39149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D09A096F88D
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 17:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773AC1F225FB
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 15:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5B61D318F;
	Fri,  6 Sep 2024 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mZ8KjB+b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071021D2F5E
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725637495; cv=none; b=Dbc1KY7GqdYIo91oRF+2D7ODA9KaRZ5l1J1VA6ItCBxWY3IfQ2bh09daOxaZ0fmgoa7wpmRF2dmIheSmheS2yfPHai6OQPPgGWkk8itfidSY2PuIKjO6R0EKr7ojuEAV2iJsxnO1AQgQmqSk/ErqstEX/5dKI6rvv84IzW43Lag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725637495; c=relaxed/simple;
	bh=h0OZ4BVzGmMJB5EH5ZjRAevdZvga495/HrIhRKoR+mI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IWuQl9nczyjWKDwb+FIUAO2MQxulxva7iVYwjNHvkAcHtsK3aoeGrVRjEr0QHHOT0HDPS3wPFmvM+kITwCX367ag/edKaK/knlLGWBFugdtBx/DkNAED3B3w9JkdcA5NmnOuwRI94DrTBI/jJKlOLq4khEV2q8wgt9dAJ57aZvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mZ8KjB+b; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1d1a1e4896so5365056276.3
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2024 08:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725637493; x=1726242293; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ka5B86ATyytf2qARVLJqT+nYwZxs8AhLMD/nslR8eNk=;
        b=mZ8KjB+bIzpDW801Ysrrie1w6Z2d2naJ53U4voiBHDyQoz603y4y8yEnthxF70EppO
         ofPcScfphTJ7AMJzXD4mpUY5FmVIwGemG7ZJt6r7RJ1c8pyuKkC9XLXL9F2jaT1wTydi
         H7HhKxPTq0pk74sQdamtBLpKSmvoj5IW5yurIGGeaJ+xSXGB/v/6kHcO7q62Ga6zbDPL
         CZ6wGY+ktIAiEa30rJtv4DWtHbs+Ox/6odG6De05mK2zybSwxJQE14VcCuGsaMZ5lI2k
         80Ia7Hub3BPIo1WV7vc5B4XBm18XjJhIcVOPnyZWh4s/5EMI7fMZa9mde62snKaMQmxj
         3b/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725637493; x=1726242293;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ka5B86ATyytf2qARVLJqT+nYwZxs8AhLMD/nslR8eNk=;
        b=ndET3JurZH4y0WfyLdhskv4x3oo99KnKhQMw1GHCHpRPLlfgVevHMZ2dekgalBJ5m1
         nNxrJTFhpwWcOKucLWyzLPixhjU4kRzDFW6QodFTU3MXn9rlBfuFfLQZQEWpKHaZUUtX
         WhJKOb6pf8bGT8igJkMWPgW5oHxzLf0LeIoDjjCuJQ9TvEgqaggPRQpWt3UjL9I8BUiL
         p6GBAQJ1z5dJws0JaZV9eHY7iYvJ7vtka5uF5sBugQ7fZ72ZDKXIBXtTlF0xsl3JzQM5
         CNsrlyplRGy5AMGnWwydzISwMIAVfoekI2jk9o0NYtJZrwNLqInUJz5CrAf9xMvZLSPo
         QP7w==
X-Forwarded-Encrypted: i=1; AJvYcCWirsqVlROkmMRahXuLyJDas8VIdyvp72tVotyfjMBuiV5DV7PvNjtlPhFKJS669s4Bkok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7IEES233eUOh41cnriDj1DdjSu+Qut6p+6SMSucltlpNqzGq7
	BNqvYDl2laTKcIc5L2IqzY0DV+15cPLauWGBNUPbFaxxxZqTnCzwDkjvkoCB0h5UO6GKR9lc+jw
	9fahIrnimsQ==
X-Google-Smtp-Source: AGHT+IFl8y59Vuvf4+P7wemx9BANG8LHKt8GkC5urpK9INHDJ48xP6+CXwbcXzG9v3Q/+2zqbdPyqOHH7k01dQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:9390:0:b0:e16:69e2:2028 with SMTP id
 3f1490d57ef6-e1d34879f14mr5329276.3.1725637492825; Fri, 06 Sep 2024 08:44:52
 -0700 (PDT)
Date: Fri,  6 Sep 2024 15:44:49 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240906154449.3742932-1-edumazet@google.com>
Subject: [PATCH bpf] sock_map: add a cond_resched() in sock_hash_free()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot <syzkaller@googlegroups.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"

Several syzbot soft lockup reports all have in common sock_hash_free()

If a map with a large number of buckets is destroyed, we need to yield
the cpu when needed.

Fixes: 75e68e5bf2c7 ("bpf, sockhash: Synchronize delete from bucket list on map free")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/sock_map.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index d3dbb92153f2fe7f1ddc8e35b495533fbf60a8cb..724b6856fcc3e9fd51673d31927cfd52d5d7d0aa 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1183,6 +1183,7 @@ static void sock_hash_free(struct bpf_map *map)
 			sock_put(elem->sk);
 			sock_hash_free_elem(htab, elem);
 		}
+		cond_resched();
 	}
 
 	/* wait for psock readers accessing its map link */
-- 
2.46.0.469.g59c65b2a67-goog


