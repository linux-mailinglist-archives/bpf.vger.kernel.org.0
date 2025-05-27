Return-Path: <bpf+bounces-58983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6654AC4BC0
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 11:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8669617B1D5
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 09:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8009253B60;
	Tue, 27 May 2025 09:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4h886Rw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A511D157A48;
	Tue, 27 May 2025 09:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748339325; cv=none; b=Po/XgqYPzJxvRx99Pvsmb7qp78kUDuhVKPJUfzEDNNQ8+665rW4CHw+JyatTxUBNJUajbZ4Vg2ziRcZVewF+Y25TVUAfsaaRcq216llWdlvrtg7EMy6PdeibHUvYfMdjPGVDOt/W+QxlGtwVVs4VkRYgCK+ObePbFB3vmCdp5zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748339325; c=relaxed/simple;
	bh=7jhn0ocJocKbmcpqwW0ArPnbdJ6mEXgOA+JJLcObY9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcG+CUS0oC9pp64Sb4szQz4fUlovSvmlf9t0FGFZ1+B8Xaq/MAAXTEqx+BypTa5VPMTo7DnhSlFIisXobFac1TjfDZK4qjddTXHwOXXz7y4zPfknKVKZJM+y1ZcTljqWACpLLE5ixD1+qSC/ij6hHYVw+yIyCksomD2sxeolemk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4h886Rw; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-442f4a3a4d6so21414375e9.0;
        Tue, 27 May 2025 02:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748339322; x=1748944122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sNz/QzDugy/+GyzpyqunW+LM6Fm4UTizSp7m4y6c9Yk=;
        b=I4h886RwXpJUCAmOL2Yiukg454YucdBpA3T37o8ajhhRtXbXVS6eT0xpjgLHMxShZN
         aVUaDe5k6YHgEcS5r9ELvRReub8d347/hQ090CVBzEcVZPC8i3qWau/zCT4nXmRJE9jk
         C3Wf7uiTN6hkBZQRuxXCd2GPd8S9acdmxSdAYQlfahAjFPXhM9XXLvM/TGFaq2J5BYJG
         TsAdrpg1/IDbDy6p9RWDEQ/HJ52H38IWjD0IUSo7yFxi2PfQun4DKwGuCwtXidBwCamP
         dXvsIvbavoux2bAvts8rBGpj8pMgOzyFp3zqEheHTA62B4Y35VH6A3vXe+8nZIKlWP0A
         MBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748339322; x=1748944122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNz/QzDugy/+GyzpyqunW+LM6Fm4UTizSp7m4y6c9Yk=;
        b=teMupVh97kwzUSvBIrGQrr9Jpp3Gyfm54fNMTSuLDO9lGZIBMKU3Jkye85+neHFIW/
         9g4645FZESD0u6N6V6Dfd2JZhfiGYQf7NUdh7RLOBWWGNO9QVyHysUYlYaJMDiAqNdP8
         N+Lgc99DJqy8M+gYLkeCc1IatNWY6kw7z6jr06ks4thrnjge0U7c/Wc2Mf4ArFE9ZKMJ
         y01sop3eQjV/n9VHg0DxkHNL+Ppm6ehFNezuG+EBw+uHZXVZufFWMOkqDAyyc1hMmzzZ
         qv8RBZ04j9E3U+3xyzi9ZHIHkDn1iK3KveQXcWJCME0WUPL6F6JY7PdhweIqP5SLBvti
         8RZA==
X-Forwarded-Encrypted: i=1; AJvYcCXvxsx0Knx9h5QBwRwkKcifMCwFkxiuP4se/5/orDGsFYYsmGoZgqk6Q2gp313zbgJLCqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuS5QIdZeFBvRcYdpuUUlTLMuabqyggSkVk0M1yr+Pm2OQSrZu
	i16SWiIytvWxN5yCadajs+5KkBV7n4PfvIl/Y2YQLKEwSdlOL4ZsyCef0c0TzcZH
X-Gm-Gg: ASbGncs96GjMczUI4UFzeeDnFVi5l52FlzZQwkNa+SLX6l67SSErDddHgg5vQQcJmmS
	wzS9Ult+jYd19yfdEs2hqlbbgf2ausXSZYndRjWd1UA55Ku2hBL74NGzmTqX5G5wlpCGr7Fwmt9
	L0y974TTY2Mz8pyRU70DWxhLl557lKa2jGTga74pqxQPd6i/FKeGrgaRAZ3Vq5M8vYqeAcCrrVl
	uKd8LSpLe3VXQ0e4mNf28UHLHu0PQT91RhXNamxr5Bf8hJheqll1wr7dDVD7z48ce2OgpEh64UR
	DbcETFslFJz+ZA6yT7lNFfcb7nHf2j1AIEozPqsQlbZt1K3sSSDvF3p/Ng6whU1tJxPYLdqk0tb
	aRImkfSAB9aaFLfOf2hakg3XcBCwSxw6Gdrso/OECZAONSPyO
X-Google-Smtp-Source: AGHT+IHjbjTwWTxMTrOrjKchawB4AdMqFZVZw/UCCSsn9bYkmVkGeB5f66nr1p0btkEGhZ7O6Dp/Qg==
X-Received: by 2002:a05:600c:3208:b0:441:bbe5:f562 with SMTP id 5b1f17b1804b1-44b53991a34mr107904775e9.16.1748339321762;
        Tue, 27 May 2025 02:48:41 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00f6e2550003dabfc0.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:f6e2:5500:3da:bfc0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f1ef01besm261086265e9.10.2025.05.27.02.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 02:48:40 -0700 (PDT)
Date: Tue, 27 May 2025 11:48:39 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Tom Herbert <tom@herbertland.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH net v2 2/2] bpf: Fix L4 csum update on IPv6 in
 CHECKSUM_COMPLETE
Message-ID: <458dd94a6f546156fcf2ec325424cd43be3e8862.1748337614.git.paul.chaignon@gmail.com>
References: <cover.1748337614.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748337614.git.paul.chaignon@gmail.com>

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
---
 include/uapi/linux/bpf.h       | 4 +++-
 net/core/filter.c              | 5 +++--
 tools/include/uapi/linux/bpf.h | 4 +++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index fd404729b115..b5ac285d4fc2 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2051,7 +2051,8 @@ union bpf_attr {
  * 		untouched (unless **BPF_F_MARK_ENFORCE** is added as well), and
  * 		for updates resulting in a null checksum the value is set to
  * 		**CSUM_MANGLED_0** instead. Flag **BPF_F_PSEUDO_HDR** indicates
- * 		the checksum is to be computed against a pseudo-header.
+ * 		the checksum is to be computed against a pseudo-header. Flag
+ * 		**BPF_F_IPV6** should be set for IPv6 packets.
  *
  * 		This helper works in combination with **bpf_csum_diff**\ (),
  * 		which does not update the checksum in-place, but offers more
@@ -6068,6 +6069,7 @@ enum {
 	BPF_F_PSEUDO_HDR		= (1ULL << 4),
 	BPF_F_MARK_MANGLED_0		= (1ULL << 5),
 	BPF_F_MARK_ENFORCE		= (1ULL << 6),
+	BPF_F_IPV6			= (1ULL << 7),
 };
 
 /* BPF_FUNC_skb_set_tunnel_key and BPF_FUNC_skb_get_tunnel_key flags. */
diff --git a/net/core/filter.c b/net/core/filter.c
index 3c93765742c9..357d26b76c22 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1968,10 +1968,11 @@ BPF_CALL_5(bpf_l4_csum_replace, struct sk_buff *, skb, u32, offset,
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
@@ -1987,7 +1988,7 @@ BPF_CALL_5(bpf_l4_csum_replace, struct sk_buff *, skb, u32, offset,
 		if (unlikely(from != 0))
 			return -EINVAL;
 
-		inet_proto_csum_replace_by_diff(ptr, skb, to, is_pseudo, false);
+		inet_proto_csum_replace_by_diff(ptr, skb, to, is_pseudo, is_ipv6);
 		break;
 	case 2:
 		inet_proto_csum_replace2(ptr, skb, from, to, is_pseudo);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index fd404729b115..b5ac285d4fc2 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2051,7 +2051,8 @@ union bpf_attr {
  * 		untouched (unless **BPF_F_MARK_ENFORCE** is added as well), and
  * 		for updates resulting in a null checksum the value is set to
  * 		**CSUM_MANGLED_0** instead. Flag **BPF_F_PSEUDO_HDR** indicates
- * 		the checksum is to be computed against a pseudo-header.
+ * 		the checksum is to be computed against a pseudo-header. Flag
+ * 		**BPF_F_IPV6** should be set for IPv6 packets.
  *
  * 		This helper works in combination with **bpf_csum_diff**\ (),
  * 		which does not update the checksum in-place, but offers more
@@ -6068,6 +6069,7 @@ enum {
 	BPF_F_PSEUDO_HDR		= (1ULL << 4),
 	BPF_F_MARK_MANGLED_0		= (1ULL << 5),
 	BPF_F_MARK_ENFORCE		= (1ULL << 6),
+	BPF_F_IPV6			= (1ULL << 7),
 };
 
 /* BPF_FUNC_skb_set_tunnel_key and BPF_FUNC_skb_get_tunnel_key flags. */
-- 
2.43.0


