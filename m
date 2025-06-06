Return-Path: <bpf+bounces-59899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 288F7AD073D
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 19:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 725733ADEB0
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 17:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1534228A1CB;
	Fri,  6 Jun 2025 17:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9RVO82n"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFA4289356;
	Fri,  6 Jun 2025 17:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749229868; cv=none; b=kD8Ebfy1lrjxIHpkzkZ+0r6F8w+QW0sDXyOi1LCPx0Maaf+R0i+DcQDXNYpPo41ELmU7TEiqOXDl1z/ApBGDUKfHYrjZp1W2arnbU8857JiHLt4ysVx+hgU+Rg9bVwkcihfV22AUJCbYF9gq7ZauHMM9YOi+5SLDPw9jzKWvYbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749229868; c=relaxed/simple;
	bh=6+GobG0hQYhzxyYNBAoxR/PdlVWqMkVm5lRIM1SNtE4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Muwbhr1BrfJ79gA4jkf7ovCnrHdjCIYXuJkUiutqoXzdcUP6u7472DNni9ingm4sv5aJAlOHsLNUCSFl6Tav7l2nxZ648rEVNxRbuvUsZsGxf5hOpt2TZiuTx84OxNUQazUn3JkjHsn77BUauvxdnTwqagcLZFZsV3Q7d3+5l8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9RVO82n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63312C4CEEB;
	Fri,  6 Jun 2025 17:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749229868;
	bh=6+GobG0hQYhzxyYNBAoxR/PdlVWqMkVm5lRIM1SNtE4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h9RVO82nyI3agMJUPn6vDJDr81E+3Ey6abjj2n6XE3ZDc0klBz9HOkFr2GSuqzkKR
	 Pint7OrBeCoezn3EN7ib8q3liAKA2jFQ2Pk/tZ/XZwJbTOYPBuTIgjmHs/ffE1MHzw
	 rbkxM5UKjZxczTauit6GT+zUkXcy4jBOtfPNZTRXYHShMZiAS28lDK3hTZTjXhIrDK
	 0NJmHr7SId2Cz3J/JZmnCi6DRSmoUnD6UCh+zxIoY3uOjmy51SRBtyx8+UI4BdKUUl
	 +1VPBrUlAuKiRjFFZrt3PVXCI4dF0UPQvZC97B9Y1YOozTZBJFhjOcbHO4a43v5h3z
	 8bZzGp7DB6M2A==
Date: Fri, 6 Jun 2025 10:11:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?= <maze@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, martin.lau@linux.dev,
 daniel@iogearbox.net, john.fastabend@gmail.com, eddyz87@gmail.com,
 sdf@fomichev.me, haoluo@google.com, willemb@google.com,
 william.xuanziyang@huawei.com, alan.maguire@oracle.com, bpf@vger.kernel.org
Subject: Re: [PATCH net] net: clear the dst when changing skb protocol
Message-ID: <20250606101106.133cb314@kernel.org>
In-Reply-To: <CANP3RGfXNrL7b+BPUCPc_=iiExtxZVxLhpQR=vyzgksuuLYkeA@mail.gmail.com>
References: <20250604210604.257036-1-kuba@kernel.org>
	<CANP3RGfRaYwve_xgxH6Tp2zenzKn2-DjZ9tg023WVzfdJF3p_w@mail.gmail.com>
	<20250605062234.1df7e74a@kernel.org>
	<CANP3RGc=U4g7aGfX9Hmi24FGQ0daBXLVv_S=Srk288x57amVDg@mail.gmail.com>
	<20250605070131.53d870f6@kernel.org>
	<684231d3bb907_208a5f2945f@willemb.c.googlers.com.notmuch>
	<20250605173142.1c370506@kernel.org>
	<CANP3RGfXNrL7b+BPUCPc_=iiExtxZVxLhpQR=vyzgksuuLYkeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Jun 2025 11:40:31 +0200 Maciej =C5=BBenczykowski wrote:
> Hopefully this is helpful?

So IIUC this is what we should do?
Cover the cases where we are 99% sure dropping dst is right without
being overeager ?

---->8-----

diff --git a/net/core/filter.c b/net/core/filter.c
index 327ca73f9cd7..d5917d6446f2 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3401,18 +3401,24 @@ BPF_CALL_3(bpf_skb_change_proto, struct sk_buff *, =
skb, __be16, proto,
 	 * care of stores.
 	 *
 	 * Currently, additional options and extension header space are
 	 * not supported, but flags register is reserved so we can adapt
 	 * that. For offloads, we mark packet as dodgy, so that headers
 	 * need to be verified first.
 	 */
 	ret =3D bpf_skb_proto_xlat(skb, proto);
+	if (ret)
+		return ret;
+
 	bpf_compute_data_pointers(skb);
-	return ret;
+	if (skb_valid_dst(skb))
+		skb_dst_drop(skb);
+
+	return 0;
 }
=20
 static const struct bpf_func_proto bpf_skb_change_proto_proto =3D {
 	.func		=3D bpf_skb_change_proto,
 	.gpl_only	=3D false,
 	.ret_type	=3D RET_INTEGER,
 	.arg1_type	=3D ARG_PTR_TO_CTX,
 	.arg2_type	=3D ARG_ANYTHING,
@@ -3549,16 +3555,19 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u3=
2 off, u32 len_diff,
=20
 		/* Match skb->protocol to new outer l3 protocol */
 		if (skb->protocol =3D=3D htons(ETH_P_IP) &&
 		    flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV6)
 			skb->protocol =3D htons(ETH_P_IPV6);
 		else if (skb->protocol =3D=3D htons(ETH_P_IPV6) &&
 			 flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV4)
 			skb->protocol =3D htons(ETH_P_IP);
+
+		if (skb_valid_dst(skb))
+			skb_dst_drop(skb);
 	}
=20
 	if (skb_is_gso(skb)) {
 		struct skb_shared_info *shinfo =3D skb_shinfo(skb);
=20
 		/* Header must be checked, and gso_segs recomputed. */
 		shinfo->gso_type |=3D gso_type;
 		shinfo->gso_segs =3D 0;
@@ -3576,16 +3585,17 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u3=
2 off, u32 len_diff,
 	}
=20
 	return 0;
 }
=20
 static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 			      u64 flags)
 {
+	bool decap =3D flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK;
 	int ret;
=20
 	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_FIXED_GSO |
 			       BPF_F_ADJ_ROOM_DECAP_L3_MASK |
 			       BPF_F_ADJ_ROOM_NO_CSUM_RESET)))
 		return -EINVAL;
=20
 	if (skb_is_gso(skb) && !skb_is_gso_tcp(skb)) {
@@ -3598,23 +3608,28 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, =
u32 off, u32 len_diff,
 	ret =3D skb_unclone(skb, GFP_ATOMIC);
 	if (unlikely(ret < 0))
 		return ret;
=20
 	ret =3D bpf_skb_net_hdr_pop(skb, off, len_diff);
 	if (unlikely(ret < 0))
 		return ret;
=20
-	/* Match skb->protocol to new outer l3 protocol */
-	if (skb->protocol =3D=3D htons(ETH_P_IP) &&
-	    flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
-		skb->protocol =3D htons(ETH_P_IPV6);
-	else if (skb->protocol =3D=3D htons(ETH_P_IPV6) &&
-		 flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4)
-		skb->protocol =3D htons(ETH_P_IP);
+	if (decap) {
+		/* Match skb->protocol to new outer l3 protocol */
+		if (skb->protocol =3D=3D htons(ETH_P_IP) &&
+		    flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
+			skb->protocol =3D htons(ETH_P_IPV6);
+		else if (skb->protocol =3D=3D htons(ETH_P_IPV6) &&
+			 flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4)
+			skb->protocol =3D htons(ETH_P_IP);
+
+		if (skb_valid_dst(skb))
+			skb_dst_drop(skb);
+	}
=20
 	if (skb_is_gso(skb)) {
 		struct skb_shared_info *shinfo =3D skb_shinfo(skb);
=20
 		/* Due to header shrink, MSS can be upgraded. */
 		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO))
 			skb_increase_gso_size(shinfo, len_diff);
=20

