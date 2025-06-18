Return-Path: <bpf+bounces-60967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E247ADF299
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 18:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A246A3BB953
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 16:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B032F234F;
	Wed, 18 Jun 2025 16:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="VEs2nvQn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244FF2F19B4
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263956; cv=none; b=fKxRDigbBOFv2ViMWSH7IidBfoktm0n0pKpOPAn07HeCtZv1vlSwJgY+YZeK+CWXpsnn6LiNn1iolE0/6IFTmvY45siQArmiXwuWAZ0Lz42hiFEmXNHs/XxvN0N/2K3alm7f1NCeaNX2AIuQNQllwjPKae7HhbdUucG/72JqxQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263956; c=relaxed/simple;
	bh=FOcUHNTpKxanwjKC5eDfYqm4hOoO4sD1M81ThFNCU5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjOgbzSN8T6PhojGThWHJo2AVM1P+jTDsyX8R6ttbYDHKlfYgvOGsw98S084+8qSbmrhRiCzQ5lUxolngxsXZvq8JL/fOCEituIFRg/jVm9KbFYbk/1ncNm4muxEMN4ZqsW9PFhqWTqWPkJyYFXQs46coY9MIwtu5YKgx5Gh5IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=VEs2nvQn; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-313dc7be67aso948804a91.0
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 09:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1750263954; x=1750868754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAuMzqm0JIrbgbPTkm58pDclP9IWfOkAF/9DsG83V1U=;
        b=VEs2nvQnL+/BOUFB/H2UUWgIvcc/jLpjiRtWtyBRGmCjRkglcSyDo00Lf1iBNHiSv0
         2gkthxdr/hvJdsGD7ovmar1siuf3vWyhgpGxU7wqPE9lKiqsNf4nSuj3wQQDRbVqJc6/
         fP/PfmjW8vUCjAbAJlFtM7vrt/JWNHLA1jXlUKhAWl/271pc0AJKhRkL2xDRVoqqLxUq
         DdHrk+8qt3M3/E29/08N5DHffvHBs3Z/uBpUSjUh+/T0QRCi1LdLW0B/onMvc2aTAJdx
         sTAw5THQ1q/D0P1W+iyLQq2b3dj76ldCuJD/LrJ9R1/ElxcjQ4ejO54AxMpQVnf5rObh
         wpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750263954; x=1750868754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAuMzqm0JIrbgbPTkm58pDclP9IWfOkAF/9DsG83V1U=;
        b=uErg19j/VKtW+tMuS9rz5MtxKBqzq2udJc/7X5JpOhE9K9dhUc4OmOuZOkTYOoLvuc
         2c0WLQbSQ/0V/j7qYGBq97H3oNgt+n8M8W6fBZ5UF/coQozZEK1ZwdCO5TTIuzB4NzU+
         tUgOLdajCDNm0+EBWpnfzjgUPMqUT6BXttsVPs8R0cCPb09jJvy/1o646gsUlRw/5HWF
         fCBlVSfPCwaa9zHzKFuX4Wki8Qwha5IAbGZriK34mAUMhYU6lGE2WhxB+0x6ZTB1QTF8
         uNvbUSdEmc5e81i+1IA2oXB3IQkckPZsFlbx/l2zD7aIeLZi1FekJxB/dN0SlESsNXpn
         LW2g==
X-Forwarded-Encrypted: i=1; AJvYcCUq1xLOhGE4/Ijy8JtpkCx4v4fINKU/X5ACFMIUCfVIpfYCkd93Jgkzpayn4Ij/SUD0Zlk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7wtE/QwWb2MsWLjM8CHfQ0Iuu/iaY/yWoqgBKxxpI46GH+VHq
	s+heJTa1EiOmwilbN8G/T8satvI014aXxaJw9lECsmJmvDuQBJozJGkdc/o4oyFcejs=
X-Gm-Gg: ASbGncsmiEsojP80ELrwXG0agnkxOpSJVzi6MJ5GwtTFTnBiZUNEuVuUN4ohIMaZzxD
	SJaEew1h4hfe+xUmrTt/WiPiIFTWaFLtlVug2yUyh6M9r0UAGIQ1Saj4PCi2czV/nAakeSW5dJ+
	mS0l9tFCQyZe+q1i5v5Luf9wj+zrQrX95mnIxQAH8UcFYzUdwJljluSgvyKG+I2OB4pEYvL7MXs
	7Ic3cE6xB+ZSeUKxKmYgkbCYCdz0M2bjZaZCRYdQJ736P2/LVF07P9mKtm9vG+9Bazm0RXhtsBl
	JD6HcnwVGXUG/nWSjqBZ2duXhTbwhX9MFwqbNtkd/fC6Y4c75WOypt8OtI9Llg==
X-Google-Smtp-Source: AGHT+IGspeVbwxO1GvshrL/fWlIu2IAT+URdmUqfrqAPZ2ixKsSUFXa/APdjxaque6X9FQlW7q9ypg==
X-Received: by 2002:a17:90b:4c45:b0:313:2bfc:94c with SMTP id 98e67ed59e1d1-313f1e70849mr9943508a91.8.1750263954290;
        Wed, 18 Jun 2025 09:25:54 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d683:8e90:dec5:4c47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a2768c6sm137475a91.44.2025.06.18.09.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:25:54 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [RESEND PATCH v2 bpf-next 05/12] bpf: tcp: Avoid socket skips and repeats during iteration
Date: Wed, 18 Jun 2025 09:25:36 -0700
Message-ID: <20250618162545.15633-6-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618162545.15633-1-jordan@jrife.io>
References: <20250618162545.15633-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the offset-based approach for tracking progress through a bucket
in the TCP table with one based on socket cookies. Remember the cookies
of unprocessed sockets from the last batch and use this list to
pick up where we left off or, in the case that the next socket
disappears between reads, find the first socket after that point that
still exists in the bucket and resume from there.

This approach guarantees that all sockets that existed when iteration
began and continue to exist throughout will be visited exactly once.
Sockets that are added to the table during iteration may or may not be
seen, but if they are they will be seen exactly once.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 net/ipv4/tcp_ipv4.c | 142 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 114 insertions(+), 28 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index c51ac10fc351..f32adf0b7cf5 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -58,6 +58,7 @@
 #include <linux/times.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
+#include <linux/sock_diag.h>
 
 #include <net/net_namespace.h>
 #include <net/icmp.h>
@@ -3016,6 +3017,7 @@ static int tcp4_seq_show(struct seq_file *seq, void *v)
 #ifdef CONFIG_BPF_SYSCALL
 union bpf_tcp_iter_batch_item {
 	struct sock *sk;
+	__u64 cookie;
 };
 
 struct bpf_tcp_iter_state {
@@ -3046,10 +3048,19 @@ static int tcp_prog_seq_show(struct bpf_prog *prog, struct bpf_iter_meta *meta,
 
 static void bpf_iter_tcp_put_batch(struct bpf_tcp_iter_state *iter)
 {
+	union bpf_tcp_iter_batch_item *item;
 	unsigned int cur_sk = iter->cur_sk;
+	__u64 cookie;
 
-	while (cur_sk < iter->end_sk)
-		sock_gen_put(iter->batch[cur_sk++].sk);
+	/* Remember the cookies of the sockets we haven't seen yet, so we can
+	 * pick up where we left off next time around.
+	 */
+	while (cur_sk < iter->end_sk) {
+		item = &iter->batch[cur_sk++];
+		cookie = sock_gen_cookie(item->sk);
+		sock_gen_put(item->sk);
+		item->cookie = cookie;
+	}
 }
 
 static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
@@ -3073,6 +3084,106 @@ static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
 	return 0;
 }
 
+static struct sock *bpf_iter_tcp_resume_bucket(struct sock *first_sk,
+					       union bpf_tcp_iter_batch_item *cookies,
+					       int n_cookies)
+{
+	struct hlist_nulls_node *node;
+	struct sock *sk;
+	int i;
+
+	for (i = 0; i < n_cookies; i++) {
+		sk = first_sk;
+		sk_nulls_for_each_from(sk, node) {
+			if (cookies[i].cookie == atomic64_read(&sk->sk_cookie))
+				return sk;
+		}
+	}
+
+	return NULL;
+}
+
+static struct sock *bpf_iter_tcp_resume_listening(struct seq_file *seq)
+{
+	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
+	struct bpf_tcp_iter_state *iter = seq->private;
+	struct tcp_iter_state *st = &iter->state;
+	unsigned int find_cookie = iter->cur_sk;
+	unsigned int end_cookie = iter->end_sk;
+	int resume_bucket = st->bucket;
+	struct sock *sk;
+
+	if (end_cookie && find_cookie == end_cookie)
+		++st->bucket;
+
+	sk = listening_get_first(seq);
+	iter->cur_sk = 0;
+	iter->end_sk = 0;
+
+	if (sk && st->bucket == resume_bucket && end_cookie) {
+		sk = bpf_iter_tcp_resume_bucket(sk, &iter->batch[find_cookie],
+						end_cookie - find_cookie);
+		if (!sk) {
+			spin_unlock(&hinfo->lhash2[st->bucket].lock);
+			++st->bucket;
+			sk = listening_get_first(seq);
+		}
+	}
+
+	return sk;
+}
+
+static struct sock *bpf_iter_tcp_resume_established(struct seq_file *seq)
+{
+	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
+	struct bpf_tcp_iter_state *iter = seq->private;
+	struct tcp_iter_state *st = &iter->state;
+	unsigned int find_cookie = iter->cur_sk;
+	unsigned int end_cookie = iter->end_sk;
+	int resume_bucket = st->bucket;
+	struct sock *sk;
+
+	if (end_cookie && find_cookie == end_cookie)
+		++st->bucket;
+
+	sk = established_get_first(seq);
+	iter->cur_sk = 0;
+	iter->end_sk = 0;
+
+	if (sk && st->bucket == resume_bucket && end_cookie) {
+		sk = bpf_iter_tcp_resume_bucket(sk, &iter->batch[find_cookie],
+						end_cookie - find_cookie);
+		if (!sk) {
+			spin_unlock_bh(inet_ehash_lockp(hinfo, st->bucket));
+			++st->bucket;
+			sk = established_get_first(seq);
+		}
+	}
+
+	return sk;
+}
+
+static struct sock *bpf_iter_tcp_resume(struct seq_file *seq)
+{
+	struct bpf_tcp_iter_state *iter = seq->private;
+	struct tcp_iter_state *st = &iter->state;
+	struct sock *sk = NULL;
+
+	switch (st->state) {
+	case TCP_SEQ_STATE_LISTENING:
+		sk = bpf_iter_tcp_resume_listening(seq);
+		if (sk)
+			break;
+		st->bucket = 0;
+		st->state = TCP_SEQ_STATE_ESTABLISHED;
+		fallthrough;
+	case TCP_SEQ_STATE_ESTABLISHED:
+		sk = bpf_iter_tcp_resume_established(seq);
+	}
+
+	return sk;
+}
+
 static unsigned int bpf_iter_tcp_listening_batch(struct seq_file *seq,
 						 struct sock **start_sk)
 {
@@ -3145,7 +3256,6 @@ static void bpf_iter_tcp_unlock_bucket(struct seq_file *seq)
 
 static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 {
-	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
 	struct bpf_tcp_iter_state *iter = seq->private;
 	struct tcp_iter_state *st = &iter->state;
 	int prev_bucket, prev_state;
@@ -3154,29 +3264,10 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 	struct sock *sk;
 	int err;
 
-	/* The st->bucket is done.  Directly advance to the next
-	 * bucket instead of having the tcp_seek_last_pos() to skip
-	 * one by one in the current bucket and eventually find out
-	 * it has to advance to the next bucket.
-	 */
-	if (iter->end_sk && iter->cur_sk == iter->end_sk) {
-		st->offset = 0;
-		st->bucket++;
-		if (st->state == TCP_SEQ_STATE_LISTENING &&
-		    st->bucket > hinfo->lhash2_mask) {
-			st->state = TCP_SEQ_STATE_ESTABLISHED;
-			st->bucket = 0;
-		}
-	}
-
 again:
-	/* Get a new batch */
-	iter->cur_sk = 0;
-	iter->end_sk = 0;
-
 	prev_bucket = st->bucket;
 	prev_state = st->state;
-	sk = tcp_seek_last_pos(seq);
+	sk = bpf_iter_tcp_resume(seq);
 	if (!sk)
 		return NULL; /* Done */
 	if (st->bucket != prev_bucket || st->state != prev_state)
@@ -3245,11 +3336,6 @@ static void *bpf_iter_tcp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 		 * meta.seq_num is used instead.
 		 */
 		st->num++;
-		/* Move st->offset to the next sk in the bucket such that
-		 * the future start() will resume at st->offset in
-		 * st->bucket.  See tcp_seek_last_pos().
-		 */
-		st->offset++;
 		sock_gen_put(iter->batch[iter->cur_sk++].sk);
 	}
 
-- 
2.43.0


