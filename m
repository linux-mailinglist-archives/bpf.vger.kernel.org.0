Return-Path: <bpf+bounces-74290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD7BC525F8
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 14:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A43B73AADC8
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 12:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401013370FF;
	Wed, 12 Nov 2025 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HBqw4pgo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ACE3358C6
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762952129; cv=none; b=GaNgyTWezAgyDK0Ccghq8970h6+nz0q9Xjffp2etsHeF6qffsAlhNdqF5fvd/VZ8FqL+erMCdxFajC1yK2Rjp1ntFF0s5LnkBMPjxQqXsVXaBI11crATCVvIFcKZUGmvPq+U3kXOx3Z81OEZvRcH8lMIKLJPv3hv4mGHW7B3wEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762952129; c=relaxed/simple;
	bh=wl6Xo0IXSzmb0uTVxkVrEryJxhav9P1MiVf1FF2pDsw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BkxX03eIck9k6xNhOJvPDc6fWFBzT6FoI4/qzPnoUcvvNb6P5SBZbmbluWiUwGup5dY2qTH30ywVdW32G1ExxSjUosj+LUOjHEU9qM38pSeYEnxUpkTvgdkrS3+lW5Sg1SE5pVqWK7tEIudQWuWleLP6rpek4gfvgbHg7+OiPQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HBqw4pgo; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-7849d90b742so9784917b3.0
        for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 04:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762952127; x=1763556927; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1VGJUzn5WtQBVoTTrQyM2FX5ydLOnFLFtVi21N9cUAY=;
        b=HBqw4pgobZwj+V0UGfwqcjoY609yUgTZZ7Q0/3yC4pOZGfMkJBQ872wbJKbVmUuZnn
         Mxdx6S8dIuzoTKXXfp3FVdCD7fQpOnaUcRQ/ITEBWc8LUxGC87DaTyiMSLNnXg6WN1na
         sdcD4felEuEVxkYAEpTBdAEOBOpPHHmGckCiNlYrnkBMQ/mAf/JU1KKXtgfWoZMU+iRC
         i+UD7hnJgpABsHhzYO73NLQal4dgU1/7B8RdTboVCIwnxqpoqjzera3XKaDKq2J7v3ZO
         1O8D86cJs4tF3fIsMbnuZTDlupUQ8pObkLMXlBrbkGrXWmSpg+DlJcU1TLhHm4T8pwZT
         x1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762952127; x=1763556927;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1VGJUzn5WtQBVoTTrQyM2FX5ydLOnFLFtVi21N9cUAY=;
        b=LLUSbvyXF0i+VhXST114L3MTxfCbdnsjI52Zn6ar7RuUdCCuyE0CzRho9nYLt83wJf
         wYbvkyXeW6ilPZcqiOh/kIgUvtWVqtMiUKCxMPSPv6edDyqzx5sqHugnOqQF+1HMOUqF
         KIJEevv70XojDZN6qNtazsdTxSa19eY/AwtTsjkeoRmG6L3IX9SE6cx0t1VlLF/IJueX
         hja7XbqYLyvNgYol7GdmdPi8IX1A2b5Z48ewP+ABqvAK1rHINOeHAPJ+Nr5x1rOO0k0X
         IyloBMCHt5kyX+Hr0T0mlwBWlicuuoeZ0+MMB3GD8qJx/Xr8pB/vkSrSgiEKxSxxKMwC
         mCQA==
X-Forwarded-Encrypted: i=1; AJvYcCWy5yqmgoSw8c7w2TcbuR+BNPBhdf9Ay+GjSEH5i370zJ8m8b7i9apDWIEaAtKSnjBfpCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3W7VDdf0OBEiVd5HO8ACQs5l1a4E/hIN97nCy3/GC6qLetfWP
	X3zoXu5tIF+MYl8KpCrEHi8gdHIjOvGIEGwLlLezKrv0UsW+CZpLLhto1oHVkk1FhyspWy9Xl01
	svEZnBsFSp3DQ/g==
X-Google-Smtp-Source: AGHT+IFKfHvm1zPt56Z+EIU7I8V5Sxnqk8D6FIACRhXohV4MLib7Je6Hv9q4Dbu8q6IiXFWl/QnGz62pdOGScQ==
X-Received: from ywll26.prod.google.com ([2002:a05:690c:a1da:b0:787:ce47:7423])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:9692:b0:787:f043:1eed with SMTP id 00721157ae682-788136e4a15mr20671387b3.53.1762952126885;
 Wed, 12 Nov 2025 04:55:26 -0800 (PST)
Date: Wed, 12 Nov 2025 12:55:16 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251112125516.1563021-1-edumazet@google.com>
Subject: [PATCH net/bpf] bpf: add bpf_prog_run_data_pointers()
From: Eric Dumazet <edumazet@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Paul Blakey <paulb@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

syzbot found that cls_bpf_classify() is able to change
tc_skb_cb(skb)->drop_reason triggering a warning in sk_skb_reason_drop().

WARNING: CPU: 0 PID: 5965 at net/core/skbuff.c:1192 __sk_skb_reason_drop net/core/skbuff.c:1189 [inline]
WARNING: CPU: 0 PID: 5965 at net/core/skbuff.c:1192 sk_skb_reason_drop+0x76/0x170 net/core/skbuff.c:1214

struct tc_skb_cb has been added in commit ec624fe740b4 ("net/sched:
Extend qdisc control block with tc control block"), which added a wrong
interaction with db58ba459202 ("bpf: wire in data and data_end for
cls_act_bpf").

drop_reason was added later.

Add bpf_prog_run_data_pointers() helper to save/restore the net_sched
storage colliding with BPF data_meta/data_end.

Fixes: ec624fe740b4 ("net/sched: Extend qdisc control block with tc control block")
Reported-by: syzbot <syzkaller@googlegroups.com>
Closes: https://lore.kernel.org/netdev/6913437c.a70a0220.22f260.013b.GAE@google.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Paul Blakey <paulb@nvidia.com>
---
 include/linux/filter.h | 20 ++++++++++++++++++++
 net/sched/act_bpf.c    |  7 +++----
 net/sched/cls_bpf.c    |  6 ++----
 3 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index f5c859b8131a3e5fa5111b60cc291cedd44f096d..973233b82dc1fd422f26ac221eeb46c66c47767a 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -901,6 +901,26 @@ static inline void bpf_compute_data_pointers(struct sk_buff *skb)
 	cb->data_end  = skb->data + skb_headlen(skb);
 }
 
+static inline int bpf_prog_run_data_pointers(
+	const struct bpf_prog *prog,
+	struct sk_buff *skb)
+{
+	struct bpf_skb_data_end *cb = (struct bpf_skb_data_end *)skb->cb;
+	void *save_data_meta, *save_data_end;
+	int res;
+
+	save_data_meta = cb->data_meta;
+	save_data_end = cb->data_end;
+
+	bpf_compute_data_pointers(skb);
+	res = bpf_prog_run(prog, skb);
+
+	cb->data_meta = save_data_meta;
+	cb->data_end = save_data_end;
+
+	return res;
+}
+
 /* Similar to bpf_compute_data_pointers(), except that save orginal
  * data in cb->data and cb->meta_data for restore.
  */
diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
index 396b576390d00aad56bca6a18b7796e5324c0aef..3f5a5dc55c29433525b319f1307725d7feb015c6 100644
--- a/net/sched/act_bpf.c
+++ b/net/sched/act_bpf.c
@@ -47,13 +47,12 @@ TC_INDIRECT_SCOPE int tcf_bpf_act(struct sk_buff *skb,
 	filter = rcu_dereference(prog->filter);
 	if (at_ingress) {
 		__skb_push(skb, skb->mac_len);
-		bpf_compute_data_pointers(skb);
-		filter_res = bpf_prog_run(filter, skb);
+		filter_res = bpf_prog_run_data_pointers(filter, skb);
 		__skb_pull(skb, skb->mac_len);
 	} else {
-		bpf_compute_data_pointers(skb);
-		filter_res = bpf_prog_run(filter, skb);
+		filter_res = bpf_prog_run_data_pointers(filter, skb);
 	}
+
 	if (unlikely(!skb->tstamp && skb->tstamp_type))
 		skb->tstamp_type = SKB_CLOCK_REALTIME;
 	if (skb_sk_is_prefetched(skb) && filter_res != TC_ACT_OK)
diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
index 7fbe42f0e5c2b7aca0a28c34cd801c3a767c804e..a32754a2658bb7d21e8ceb62c67d6684ed4f9fcc 100644
--- a/net/sched/cls_bpf.c
+++ b/net/sched/cls_bpf.c
@@ -97,12 +97,10 @@ TC_INDIRECT_SCOPE int cls_bpf_classify(struct sk_buff *skb,
 		} else if (at_ingress) {
 			/* It is safe to push/pull even if skb_shared() */
 			__skb_push(skb, skb->mac_len);
-			bpf_compute_data_pointers(skb);
-			filter_res = bpf_prog_run(prog->filter, skb);
+			filter_res = bpf_prog_run_data_pointers(prog->filter, skb);
 			__skb_pull(skb, skb->mac_len);
 		} else {
-			bpf_compute_data_pointers(skb);
-			filter_res = bpf_prog_run(prog->filter, skb);
+			filter_res = bpf_prog_run_data_pointers(prog->filter, skb);
 		}
 		if (unlikely(!skb->tstamp && skb->tstamp_type))
 			skb->tstamp_type = SKB_CLOCK_REALTIME;
-- 
2.51.2.1041.gc1ab5b90ca-goog


