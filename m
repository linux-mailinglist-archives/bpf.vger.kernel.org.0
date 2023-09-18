Return-Path: <bpf+bounces-10272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6F67A461A
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 11:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786302820D8
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 09:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541341C2BA;
	Mon, 18 Sep 2023 09:38:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A6F1BDF7;
	Mon, 18 Sep 2023 09:38:28 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A0CD109;
	Mon, 18 Sep 2023 02:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=E6Gq9
	q199088uQOPOTWvFqHg+HaKxn9bHmNfYLiu5Pc=; b=RNgmNIYISLthaIaO9kLB9
	nJWV450G5i0dDGgSXisS5fgLpPATWjhJptaqaLQQF3kYN/mso4x4w2pdO5BrE3Z+
	NBbaLtFvDny8PhUY7hA2m3LKvigIAg66HfKArN9m5m3VEQHGTTOS6wmO2sWuKfVG
	Vbm5UFEUyzuudXVXDS7+r4=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by zwqz-smtp-mta-g5-1 (Coremail) with SMTP id _____wDnq2QWGghlLjGXCQ--.241S4;
	Mon, 18 Sep 2023 17:36:32 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: john.fastabend@gmail.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Ma Ke <make_ruc2021@163.com>
Subject: [PATCH] bpf, sockmap: fix deadlocks in the sockhash and sockmap
Date: Mon, 18 Sep 2023 17:36:20 +0800
Message-Id: <20230918093620.3479627-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnq2QWGghlLjGXCQ--.241S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aryktr43tr48Xw4DGF15urg_yoW8GF4rpF
	yrKa1rWrWkA3WF9FZ3Xw4vqrs5trn8Zr1UGFyrCa4Yyr9xKryqgFy0kasY9r1YyrW2yr15
	GF42k3y3G3yrC3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zifcTdUUUUU=
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbiyALuC1p7LzCXDgAAsI
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
	RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

It seems that elements in sockhash are rarely actively
deleted by users or ebpf program. Therefore, we do not
pay much attention to their deletion. Compared with hash
maps, sockhash only provides spin_lock_bh protection.
This causes it to appear to have self-locking behavior
in the interrupt context, as CVE-2023-0160 points out.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 net/core/sock_map.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index cb11750b1df5..1302d484e769 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -928,11 +928,12 @@ static long sock_hash_delete_elem(struct bpf_map *map, void *key)
 	struct bpf_shtab_bucket *bucket;
 	struct bpf_shtab_elem *elem;
 	int ret = -ENOENT;
+	unsigned long flags;
 
 	hash = sock_hash_bucket_hash(key, key_size);
 	bucket = sock_hash_select_bucket(htab, hash);
 
-	spin_lock_bh(&bucket->lock);
+	spin_lock_irqsave(&bucket->lock, flags);
 	elem = sock_hash_lookup_elem_raw(&bucket->head, hash, key, key_size);
 	if (elem) {
 		hlist_del_rcu(&elem->node);
@@ -940,7 +941,7 @@ static long sock_hash_delete_elem(struct bpf_map *map, void *key)
 		sock_hash_free_elem(htab, elem);
 		ret = 0;
 	}
-	spin_unlock_bh(&bucket->lock);
+	spin_unlock_irqrestore(&bucket->lock, flags);
 	return ret;
 }
 
-- 
2.37.2


