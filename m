Return-Path: <bpf+bounces-75365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03130C81942
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 17:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 574F74E7877
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 16:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103AC31B11E;
	Mon, 24 Nov 2025 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dGOsyWBj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D241431AF06
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001772; cv=none; b=mp9c85pSZfXEPpnZekcYCQJaihV7UMGGfkapzQh05O7BDAKp9kSBmr2230COryiHJMfh3C2yub12TPzwG41iLWWZ6Vm/OlP9CfeeklB9Dwj6Iy5L3fHDFDEOUitfjGHh1YWFYjgwQ6rU5onCWr+0xiUZNkB7fDvoWZ1cMoYaQFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001772; c=relaxed/simple;
	bh=UAInQ+1vDLAGa6d9dmaxYhqAGIKQzZ9+tIIoI/hgJq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Iic7anUPUpX3ixkbXRsXAbOARRo/DsPc0FpQ97FzMI/8cgcs3K5bkvIiuPOsO+6LQHIZR2Ek5FWVA7VsAxVSgpthS2eyIOf5/dn+guak+hE8DIB3O08HjJ89OiMFC6nYcyge771vWzYmb6ykoFzk7kY168rxdik1SV4n6I5Upns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dGOsyWBj; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64175dfc338so7572854a12.0
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 08:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1764001769; x=1764606569; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HehKTi7HG5k0VmidZAFWiuea5SnTnA46ALpIVUGcCBU=;
        b=dGOsyWBjEoIJbsb47SV5T9sdoR00njREZm72ZDLKGjjZtOhXpguiqJ6flMV/DUHAk3
         j3wMn+/R/A234XQZRjfg3xcQDgK9NriYufne2CKDQJ/fLpKp0R3OYCT3sT7dt8npW8H6
         0Thtv203nMfh5mi8v9/RnSyKoDKCnHEHXoxEH7qdywSG4fzvsQiY9hpGsI0BKz3F2lE/
         s2lyGF3OE9V79NgtuqNm6M/cdC/KHfg5pfAAEAfWsTUuwmmyt1A9nJ6M2OxI8o3LLhEx
         CJntaYKEYf96JAdxZDpL9lF+VAOlgsQBY1tkgUmZo1uKI/ztXHRj2AF44Ekzn5TLKOe6
         4BlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764001769; x=1764606569;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HehKTi7HG5k0VmidZAFWiuea5SnTnA46ALpIVUGcCBU=;
        b=LwZhKCFvjTbZiMTkZs8ZfpXUKXeXMkuTFZx0nQqdIglS20I61RUq1qoJZ1xSOowM3n
         I2RLE6dtoYoUC6vK3KbjnAxRk5bcCo8xvFuapnmp7BtqsnfrLFGE7P6ODPxFd2/jI0DH
         GGb99bN3OmDux0som8dBQnxhruVf7EBH+rarFA3315g+cPYkRUaqbup6JvoO7i47ERsG
         tfEkBYUgwM3f1UTKroXQVYdB0/JbB2WBGTnHDCrnL0pshVt7SdRRqOni3TheW2y1FqXe
         Pc64AExn6gWxhwnxliZysy7Udu9alpfxWftrYtLoWsIGUereIiMOpCu/Fpr1T83BkdDe
         HPGQ==
X-Gm-Message-State: AOJu0YxLluRAG4N59MHJQWty16aWynY3ulLtea4OhWOO0K9LbtxwwGz8
	MET6HY4eF/Hroswxw4onet40nWO9VenITjR6BBSekVy/1b4owpF5NP43ShDqN52OeQ2ww4zJslI
	YBNyY
X-Gm-Gg: ASbGncumglFy7nQie2YSPz1e7NG9p9sJ16uj+DNmp7CQ78an3zDtsh8PydywXUQgvS+
	CfHJikOZy9Nd8Mzw41w5BJf+VkHD4C/Y41aBXaiakPb2cAXKlwSlabJUGnggXOcA9TVgLL9nRqe
	rN9vwgiW8M18lTw1D6J5djxY5z8QwBI4iSMlV7iCC2f/XdOvnsVT1Jg9VZDI5VSgU2dRhFU5DRh
	EMEtYhlIjBNUb/XX7swg9NwNutcqE0aC1tUH6OdtQMI0xtnzUEDqe1LgBo5KN+sJiUhRyey9rjE
	ckzQ9mei8XLqnnKtksGF1riYTa/wO44hJ4nh22h9IlPRjxPEg3DkisUxEsLk4DZFRubJscjdjgX
	bHeeYfD/nv5diHtuSBpTS4XHcXBFAjfPWb7bhnbxz1ch7oNTopkJncmpsTvbyC+fpY7Ckrswdn2
	VEDHicG3ZgkSSBp4IYm7qBYQWu9abJ63GzMa7AawzFdoXMBihyI0Ztgowd
X-Google-Smtp-Source: AGHT+IGTfsGW03jQxs84v0YwM0SH5pLUw2DgIM7xyazuFdCl5sDn9njDLi/heBgRs+exPj5SGMRyUg==
X-Received: by 2002:a17:907:6d06:b0:b73:7652:efc2 with SMTP id a640c23a62f3a-b76718c3862mr1359876566b.60.1764001768853;
        Mon, 24 Nov 2025 08:29:28 -0800 (PST)
Received: from cloudflare.com (79.184.84.214.ipv4.supernova.orange.pl. [79.184.84.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76550512d2sm1334759566b.67.2025.11.24.08.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 08:29:28 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 24 Nov 2025 17:28:51 +0100
Subject: [PATCH RFC bpf-next 15/15] bpf: Realign skb metadata for TC progs
 using data_meta
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-15-8978f5054417@cloudflare.com>
References: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
In-Reply-To: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Martin KaFai Lau <martin.lau@linux.dev>
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
 include/linux/skbuff.h | 25 +++++++++++++++--------
 net/core/filter.c      | 55 ++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 70 insertions(+), 10 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 8868db976e1f..24c4e216d0cb 100644
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
index 334421910107..91100c923f2c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -9125,11 +9125,62 @@ static int bpf_gen_ld_abs(const struct bpf_insn *orig,
 	return insn - insn_buf;
 }
 
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc void bpf_skb_meta_realign(struct __sk_buff *skb_)
+{
+	struct sk_buff *skb = (typeof(skb))skb_;
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
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(tc_cls_act_hidden_ids)
+BTF_ID_FLAGS(func, bpf_skb_meta_realign, KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(tc_cls_act_hidden_ids)
+
+BTF_ID_LIST_SINGLE(bpf_skb_meta_realign_ids, func, bpf_skb_meta_realign)
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
+		*insn++ = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
+		*insn++ = BPF_CALL_KFUNC(0, bpf_skb_meta_realign_ids[0]);
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


