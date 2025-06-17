Return-Path: <bpf+bounces-60824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1345EADD384
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 17:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCDCA1886EE4
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 15:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FDD2ED848;
	Tue, 17 Jun 2025 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amYisdfN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D6E2EB5D3;
	Tue, 17 Jun 2025 15:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175367; cv=none; b=eiZkXfT5mnMZmM+rTbPSpkO6RaOXj5ezwblXW9lwHXBho2WkiSvCUrbtGF/Espkj0I45pnnntSOg7+3z4qxql/RC5nyKO5mVmywTysMiK7QMF3ehpWyZIIx3MGXPoUQWry9yYATwABbFiisCTI1uXmFsG8yQAGwEKHVmwuDtXXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175367; c=relaxed/simple;
	bh=8s9t1kuXB6avTYRQ0vG2v4H1fTsDd+syfRgNT4/rrL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l38fuqlQm/8aRsYB61fBwz2DkY6vQ3z6qdO8IYs4qk/yfIvYO3PgoGbmuGgsWIuiuItX97mapAtJJSKg00uUjwQuW5lBXUq1EBbJm2RZ6UhO0vd4Dt+QMj2QSau3kgUuwwAh5g2Vxf1iE8maQRnm6Y2PY21sM1RExt71U6h5Oxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amYisdfN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-450dd065828so48238375e9.2;
        Tue, 17 Jun 2025 08:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750175363; x=1750780163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ED7sxa3PS0VApQnvLXC5jidvzh+lHXS4510sX1ujII=;
        b=amYisdfNuq1F2xRGHqXeqoWvnZjy+3Z6PV0+tPyJahboULy+DBhSFA011NhpLzUL2K
         qs4YDN9Bp6cuMwF+PbggMSTuYRQprxI6SHtgJmJ0miU8hNIaoi/rpVG3lAO/RI2XtcKb
         jkDDWCzO7wk33o2wV7gvC5MGpKubipCRiA7HznCDaxbEkTrwOaZzoIud+rQ9Sb3R7Pwr
         b0ITwcNwffHJbsSZMTZuUO8axgY/W0UrvoBRnEfDhRUI1OsauCQBGIXK8JHgDhD0ZwF2
         H8qPPeELffaeAoqCW7vTs1V2Osk5Jm5mQXJeU1oDFatZQ8b4oAwSerudOj/RXuEqkc3O
         zQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750175363; x=1750780163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ED7sxa3PS0VApQnvLXC5jidvzh+lHXS4510sX1ujII=;
        b=BBCCqgrVO+Zz2IMHt6jpiDhGQoiHwvfUHynPe361RY0wIPvniwybp5gMXf0HFxXuhL
         ix28EapV+qmBKsRhNed32X7xWjleeCxzkm92LdcXUoLlaEnBtBOHvolH5hzpLgLdI6im
         xS4m7HEqQfSWFuRzciVn0P0dC+js8kdqkMCMSoc8Rbq3bI3ArCQlhGt0pYCNCyhIyGON
         OrxsUSvy9y7jw94tti6Y//+ctWiQ57CqKHXUUCuZDgYjCt9r7JcIZS4SWgWIvbVCDXfk
         hFattWVDe9dqXXvlMdjNszvIE1R0MveZfg3IAD+LIKudHa0rSIdlQcWGQkzng0+h+Mdz
         /7AQ==
X-Forwarded-Encrypted: i=1; AJvYcCU228JV+jRYQ0Qnqwa6W5ScEhdvhYyhxbd0cWBTn5UBjGe+2h/KVjW010lPtSgCBVo31I/YjDFU@vger.kernel.org, AJvYcCXyExSjZeBBpGmCPvU/qqiUBEolP4pkj0ROo5aiTfc8AtaOUgsBvjdzN7Ut1Xuqq7Q/77E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB1Ss99GjhPjfRd2VeznHOAyV3bNu7C+/jUK5eWoPLrwf/0Go+
	HKP0sjWVK54+frCb9QThUSbknkYVZFl4QYffTxmbibpcvgwFcE1WST+JCwr2SzIb
X-Gm-Gg: ASbGncswJSh4u7BPPKsXjxbIbLTx07HldaycE1+Sv6mz7lZEHgvJv0+I9aAfjgNNNCc
	p0uEsqQBq9vdHU3VlL94xXaZlXMcIMuYZ/ThM88RBTA5oeGoMqIi+AU5uUrij+HpQQzIpGrrOQZ
	6wRNZowffY6c/f2LrNsNeFvZM/NzUa+y8K4BQkQAdIM0D2FpYWHS15+SBrb3MG2c0AYCxSK8kyK
	IcxcFo6fzpm+PuVYe+u70UJ7DGuU6GI86T2DHQm0v7IIIoXf//oYGnZ+FW7ssnbLcPY50puukBZ
	Ne7z2djVjmoQ4I14Rw0OoMn2DJhY07GbqDRdFfm4QdBvc09oTkVmxpebr0g4nPgTYNiFs64Rnz8
	eVZmrZXpWuee/NEmW6He23cUwFVXXr0KvPZtlU29HQBC33qM27oqiyW7hwSsgDPphlDbpp/Y=
X-Google-Smtp-Source: AGHT+IFDwtTxvdIk8gaYyDwV4B4f9ZCesBloO5HyZeHmjRI0aKuIc5DEn11og0iET4+2nV8PKlUKqw==
X-Received: by 2002:a05:600c:3f07:b0:442:f4a3:b5ec with SMTP id 5b1f17b1804b1-4533ca7a34bmr143186285e9.4.1750175363138;
        Tue, 17 Jun 2025 08:49:23 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00112ae8a423a3e4b4.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:112a:e8a4:23a3:e4b4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b6debasm14650000f8f.93.2025.06.17.08.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 08:49:22 -0700 (PDT)
Date: Tue, 17 Jun 2025 17:49:21 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Tom Herbert <tom@herbertland.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH stable 5.10,5.15 2/2] bpf: Fix L4 csum update on IPv6 in
 CHECKSUM_COMPLETE
Message-ID: <2ce92c476e4acba76002b69ad71093c5f8a681c6.1750171422.git.paul.chaignon@gmail.com>
References: <0bd9e0321544730642e1b068dd70178d5a3f8804.1750171422.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bd9e0321544730642e1b068dd70178d5a3f8804.1750171422.git.paul.chaignon@gmail.com>

[ Upstream commit ead7f9b8de65632ef8060b84b0c55049a33cfea1 ]
[ Note: Fixed conflict due to unrelated comment change. ]

In Cilium, we use bpf_csum_diff + bpf_l4_csum_replace to, among other
things, update the L4 checksum after reverse SNATing IPv6 packets. That
use case is however not currently supported and leads to invalid
skb->csum values in some cases. This patch adds support for IPv6 address
changes in bpf_l4_csum_update via a new flag.

When calling bpf_l4_csum_replace in Cilium, it ends up calling
inet_proto_csum_replace_by_diff:

    1:  void inet_proto_csum_replace_by_diff(__sum16 *sum, struct sk_buff *skb,
    2:                                       __wsum diff, bool pseudohdr)
    3:  {
    4:      if (skb->ip_summed != CHECKSUM_PARTIAL) {
    5:          csum_replace_by_diff(sum, diff);
    6:          if (skb->ip_summed == CHECKSUM_COMPLETE && pseudohdr)
    7:              skb->csum = ~csum_sub(diff, skb->csum);
    8:      } else if (pseudohdr) {
    9:          *sum = ~csum_fold(csum_add(diff, csum_unfold(*sum)));
    10:     }
    11: }

The bug happens when we're in the CHECKSUM_COMPLETE state. We've just
updated one of the IPv6 addresses. The helper now updates the L4 header
checksum on line 5. Next, it updates skb->csum on line 7. It shouldn't.

For an IPv6 packet, the updates of the IPv6 address and of the L4
checksum will cancel each other. The checksums are set such that
computing a checksum over the packet including its checksum will result
in a sum of 0. So the same is true here when we update the L4 checksum
on line 5. We'll update it as to cancel the previous IPv6 address
update. Hence skb->csum should remain untouched in this case.

The same bug doesn't affect IPv4 packets because, in that case, three
fields are updated: the IPv4 address, the IP checksum, and the L4
checksum. The change to the IPv4 address and one of the checksums still
cancel each other in skb->csum, but we're left with one checksum update
and should therefore update skb->csum accordingly. That's exactly what
inet_proto_csum_replace_by_diff does.

This special case for IPv6 L4 checksums is also described atop
inet_proto_csum_replace16, the function we should be using in this case.

This patch introduces a new bpf_l4_csum_replace flag, BPF_F_IPV6,
to indicate that we're updating the L4 checksum of an IPv6 packet. When
the flag is set, inet_proto_csum_replace_by_diff will skip the
skb->csum update.

Fixes: 7d672345ed295 ("bpf: add generic bpf_csum_diff helper")
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://patch.msgid.link/96a6bc3a443e6f0b21ff7b7834000e17fb549e05.1748509484.git.paul.chaignon@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 include/uapi/linux/bpf.h       | 2 ++
 net/core/filter.c              | 5 +++--
 tools/include/uapi/linux/bpf.h | 2 ++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0bdeeabbc5a8..2ac62d5ed466 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1695,6 +1695,7 @@ union bpf_attr {
  * 		for updates resulting in a null checksum the value is set to
  * 		**CSUM_MANGLED_0** instead. Flag **BPF_F_PSEUDO_HDR** indicates
  * 		the checksum is to be computed against a pseudo-header.
+ * 		Flag **BPF_F_IPV6** should be set for IPv6 packets.
  *
  * 		This helper works in combination with **bpf_csum_diff**\ (),
  * 		which does not update the checksum in-place, but offers more
@@ -5106,6 +5107,7 @@ enum {
 	BPF_F_PSEUDO_HDR		= (1ULL << 4),
 	BPF_F_MARK_MANGLED_0		= (1ULL << 5),
 	BPF_F_MARK_ENFORCE		= (1ULL << 6),
+	BPF_F_IPV6			= (1ULL << 7),
 };
 
 /* BPF_FUNC_skb_set_tunnel_key and BPF_FUNC_skb_get_tunnel_key flags. */
diff --git a/net/core/filter.c b/net/core/filter.c
index 65b7fb9c3d29..169d9ba4e7a0 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1951,10 +1951,11 @@ BPF_CALL_5(bpf_l4_csum_replace, struct sk_buff *, skb, u32, offset,
 	bool is_pseudo = flags & BPF_F_PSEUDO_HDR;
 	bool is_mmzero = flags & BPF_F_MARK_MANGLED_0;
 	bool do_mforce = flags & BPF_F_MARK_ENFORCE;
+	bool is_ipv6   = flags & BPF_F_IPV6;
 	__sum16 *ptr;
 
 	if (unlikely(flags & ~(BPF_F_MARK_MANGLED_0 | BPF_F_MARK_ENFORCE |
-			       BPF_F_PSEUDO_HDR | BPF_F_HDR_FIELD_MASK)))
+			       BPF_F_PSEUDO_HDR | BPF_F_HDR_FIELD_MASK | BPF_F_IPV6)))
 		return -EINVAL;
 	if (unlikely(offset > 0xffff || offset & 1))
 		return -EFAULT;
@@ -1970,7 +1971,7 @@ BPF_CALL_5(bpf_l4_csum_replace, struct sk_buff *, skb, u32, offset,
 		if (unlikely(from != 0))
 			return -EINVAL;
 
-		inet_proto_csum_replace_by_diff(ptr, skb, to, is_pseudo, false);
+		inet_proto_csum_replace_by_diff(ptr, skb, to, is_pseudo, is_ipv6);
 		break;
 	case 2:
 		inet_proto_csum_replace2(ptr, skb, from, to, is_pseudo);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 54b8c899d21c..fe70f9ce8b00 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1695,6 +1695,7 @@ union bpf_attr {
  * 		for updates resulting in a null checksum the value is set to
  * 		**CSUM_MANGLED_0** instead. Flag **BPF_F_PSEUDO_HDR** indicates
  * 		the checksum is to be computed against a pseudo-header.
+ * 		Flag **BPF_F_IPV6** should be set for IPv6 packets.
  *
  * 		This helper works in combination with **bpf_csum_diff**\ (),
  * 		which does not update the checksum in-place, but offers more
@@ -5106,6 +5107,7 @@ enum {
 	BPF_F_PSEUDO_HDR		= (1ULL << 4),
 	BPF_F_MARK_MANGLED_0		= (1ULL << 5),
 	BPF_F_MARK_ENFORCE		= (1ULL << 6),
+	BPF_F_IPV6			= (1ULL << 7),
 };
 
 /* BPF_FUNC_clone_redirect and BPF_FUNC_redirect flags. */
-- 
2.43.0


