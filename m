Return-Path: <bpf+bounces-78112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C85CCFE4D1
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 15:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B49113003841
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 14:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF3D34DCE2;
	Wed,  7 Jan 2026 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JaPxrPe5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D61B34DB76
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796112; cv=none; b=aYRR38ILh1MUn/m/i041b2o355R7PqgCOzSCHqUSEVCwdBTmmgD3bu/9eTaykqDjdB5axw0q/cFzSHSMbuRv0eDAP2smxJ8dbkvxamijbccWQG0YF6I2YMROR79O8UW10OYznY61CoGn45o8jr2/d/gM9d6xa9oCMM5r41NvRhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796112; c=relaxed/simple;
	bh=CMEA1ed8Y3EPO2C40M3Bj3ApHXZV26tPgRlBTWeNxbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c3fuVYvtRi4YoiZhcBi6nlhvywUvO+X0kZZLEvuqMtZJxQW8gYc+99p1Cr7S4/UzqH6UnpxTy4/fHKhglGIyoMXGwBo1qUS3WLz48p2uX1WxO6nsrB42oZkJlMAMx0zYlupeeu+TNQ5/uZum4sotU9CXwdlpV6yPz9G1+3RDu0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=JaPxrPe5; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b7cee045187so164249066b.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 06:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767796109; x=1768400909; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QspRVHpPXQa/w26+vRWWYnHCNMOwjz3rIB4fNBHnMNI=;
        b=JaPxrPe5WExZvjB2pImHxXQDiLk5fBwIYXMgSs2Xp57SvnqqBqwTdlwY+HOirWQ7cO
         H+uhU+ee20B0qqwbGS1dUTi4XqLubMNYsezC+DUZRHzcitq5olwsFYu3ldOJlzIZ3TkM
         ufWnHilBj9bts5XZncKV07vdmxctOfS6512M55r8lYSeKkK8FcEFfGxOlRaAT0Fjj+d2
         4DULAY6zldx17lGhntZSC1C4oYtppuoQ8AZUF6Gkd1oSx7q0sXxfkzVd0LuCaRIV+qua
         6zpPYSNOggtYmD6oUDiEkSNguONxh2UzNFN9HHNL82yBdd0cRLGUDmA8aBIogPs9Z4t/
         XXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767796109; x=1768400909;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QspRVHpPXQa/w26+vRWWYnHCNMOwjz3rIB4fNBHnMNI=;
        b=v4ogeI/Djs1m2paMfnFxje7eT7NJxRrEFMYNOTtIe8Tz/mz37n549uHs5oaRgb05EX
         lFQ+9PeXF0H/LhG7gA8FNuaMDVPDyb8UtfsImGcHnEb1h1DTSUhhog36cRI0WhhU6RHB
         uPBKqmVKfEYiocujoqn2/jViWg+lZR0VokYntT6CEUZrTciittEAJoVp1AuK+UJMISWI
         Ba+1sfLeWXPWtqVtD0fFzvCP7u1aylfDQWxvPHEuWfVU+k8NUfPmo2LdU7rdza/N/Fm2
         d8yoopUxfYFWBejE7lAtOktcuT/MJYAJpqVBuXQoeb1/2MUe/WMPCNNTIYtWLb5xb0ny
         japQ==
X-Gm-Message-State: AOJu0Yy9hm5O62WjTffMOa7RlPW4BbT+1mZFidnt1CcfXEmV9ke9jR2N
	9DMjsojPr5OjjxCSv+nIG3skWUYRwaMaioUxvU5uOpWM4vssfDPi8CDzuG8aWRWiHyk=
X-Gm-Gg: AY/fxX53OXezANlhEl35Pvea6hm0kHtGl8X98M+aaaoL8+QtXrZMbDlDW6a6eOHen3N
	M3RE90BNQ315INEle7E36UXkREr1z3gEjpABX8l8cm6y7/IrvYwIAk72+qsL6KKe4d8zkvqn8Ks
	GiheP/WMi6odM9p+ynmeb0IVqJHLqjK1xjLdcA3Ppp1C3UjgyAAb8LKRkrHHxbPPWydM55DReDY
	7Iu4pKq0Iodk7Io1yUNpYzfeTR1BXHAXD7z6TDdItqmQcWluDtzW+HKTBtP8kksnyM/vjtTGo/T
	Y012SmpL64quj2bN9xmJ8aAjlX4/xQUlDQbMaDwp9fTYPT/ME8C8wZbQ590noceqtq5NMlI4Gcc
	EAOjSAwlix2fFDd8XzoNQgqkmWhZRiJXb3/60GrWbhIvYWDO57mSYa2IA+TDvB3V3MCS+uE/KB2
	dlvjDQQkM7Yc65tczD088DlS7KDgXZKkKpCHkaxZq9lttT1dlO6D4us/7x6o8=
X-Google-Smtp-Source: AGHT+IHYVwWBm3wbCdNeaNGxUEX4+zyNgPwzo60XUGsF2A6g0coemBLf1hYirk9Y+XY3EsTCc7wVGg==
X-Received: by 2002:a17:907:7f8f:b0:b79:d08c:a7d6 with SMTP id a640c23a62f3a-b8429b97ffdmr659971666b.28.1767796108617;
        Wed, 07 Jan 2026 06:28:28 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b8c4c15sm4749642a12.4.2026.01.07.06.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:28:28 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 07 Jan 2026 15:28:16 +0100
Subject: [PATCH bpf-next v3 16/17] bpf: Realign skb metadata for TC progs
 using data_meta
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-16-0d461c5e4764@cloudflare.com>
References: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
In-Reply-To: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

After decoupling metadata location from MAC header offset, a gap can appear
between metadata and skb->data on L2 decapsulation (e.g., VLAN, GRE). This
breaks the BPF data_meta pointer which assumes metadata is directly before
skb->data.

Introduce bpf_skb_meta_realign() kfunc to close the gap by moving metadata
to immediately precede the MAC header. Inject a call to it in
tc_cls_act_prologue() when the verifier detects data_meta access
(PA_F_DATA_META_LOAD flag).

Update skb_data_move() to handle the gap case: on skb_push(), move metadata
to the top of the head buffer; on skb_pull() where metadata is already
detached, leave it in place.

This restores data_meta functionality for TC programs while keeping the
performance benefit of avoiding memmove on L2 decapsulation for programs
that don't use data_meta.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/skbuff.h | 25 +++++++++++++++++--------
 net/core/filter.c      | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 6dd09f55a975..0fc4df42826e 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4600,19 +4600,28 @@ static inline void skb_data_move(struct sk_buff *skb, const int len,
 	if (!meta_len)
 		goto no_metadata;
 
-	meta_end = skb_metadata_end(skb);
-	meta = meta_end - meta_len;
-
-	if (WARN_ON_ONCE(meta_end + len != skb->data ||
-			 meta_len > skb_headroom(skb))) {
+	/* Not enough headroom left for metadata. Drop it. */
+	if (WARN_ONCE(meta_len > skb_headroom(skb),
+		      "skb headroom smaller than metadata")) {
 		skb_metadata_clear(skb);
 		goto no_metadata;
 	}
 
-	memmove(meta + len, meta, meta_len + n);
-	skb_shinfo(skb)->meta_end += len;
-	return;
+	meta_end = skb_metadata_end(skb);
+	meta = meta_end - meta_len;
 
+	/* Metadata in front of data before push/pull. Keep it that way. */
+	if (meta_end == skb->data - len) {
+		memmove(meta + len, meta, meta_len + n);
+		skb_shinfo(skb)->meta_end += len;
+		return;
+	}
+
+	if (len < 0) {
+		/* Data pushed. Move metadata to the top. */
+		memmove(skb->head, meta, meta_len);
+		skb_shinfo(skb)->meta_end = meta_len;
+	}
 no_metadata:
 	memmove(skb->data, skb->data - len, n);
 }
diff --git a/net/core/filter.c b/net/core/filter.c
index e91d5a39e0a7..df4c97fe79ee 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -9136,11 +9136,53 @@ static int bpf_gen_ld_abs(const struct bpf_insn *orig,
 	return insn - insn_buf;
 }
 
+static void bpf_skb_meta_realign(struct sk_buff *skb)
+{
+	u8 *meta_end = skb_metadata_end(skb);
+	u8 meta_len = skb_metadata_len(skb);
+	u8 *meta;
+	int gap;
+
+	gap = skb_mac_header(skb) - meta_end;
+	if (!meta_len || !gap)
+		return;
+
+	if (WARN_ONCE(gap < 0, "skb metadata end past mac header")) {
+		skb_metadata_clear(skb);
+		return;
+	}
+
+	meta = meta_end - meta_len;
+	memmove(meta + gap, meta, meta_len);
+	skb_shinfo(skb)->meta_end += gap;
+
+	bpf_compute_data_pointers(skb);
+}
+
 static int tc_cls_act_prologue(struct bpf_insn *insn_buf, u32 pkt_access_flags,
 			       const struct bpf_prog *prog)
 {
-	return bpf_unclone_prologue(insn_buf, pkt_access_flags, prog,
-				    TC_ACT_SHOT);
+	struct bpf_insn *insn = insn_buf;
+	int cnt;
+
+	if (pkt_access_flags & PA_F_DATA_META_LOAD) {
+		/* Realign skb metadata for access through data_meta pointer.
+		 *
+		 * r6 = r1; // r6 will be "u64 *ctx"
+		 * r0 = bpf_skb_meta_realign(r1); // r0 is undefined
+		 * r1 = r6;
+		 */
+		BUILD_BUG_ON(!__same_type(&bpf_skb_meta_realign,
+					  (void (*)(struct sk_buff *))NULL));
+		*insn++ = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
+		*insn++ = BPF_EMIT_CALL(bpf_skb_meta_realign);
+		*insn++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
+	}
+	cnt = bpf_unclone_prologue(insn, pkt_access_flags, prog, TC_ACT_SHOT);
+	if (!cnt && insn > insn_buf)
+		*insn++ = prog->insnsi[0];
+
+	return cnt + insn - insn_buf;
 }
 
 static bool tc_cls_act_is_valid_access(int off, int size,

-- 
2.43.0


