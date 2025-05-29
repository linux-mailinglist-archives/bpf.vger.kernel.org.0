Return-Path: <bpf+bounces-59284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EC0AC7BBE
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 12:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E323216EF9C
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 10:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11133229B1A;
	Thu, 29 May 2025 10:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQfjGc5w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E49225A32;
	Thu, 29 May 2025 10:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748514521; cv=none; b=rLjLUgdlyJqq4Qh2ri38FL08iPBhuVWzEq5VDheW1IAbg39aWJyepBl6wcqX8nk8X0wjf0PIciq6rqWO0ggNhKVcdq7jrBGTsTU98YIgnD0GtRR1eZb1wqdDramb1SdUVgoej84waZCutj5assH/J5h+WWzMOdZGqY1FCHGT73c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748514521; c=relaxed/simple;
	bh=EHjLas2wC/jhmRXqbyVP136qJPzEAJLbPhHL60bDXRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VuX1r0+6Yg/P8LjAzWx/rNcdEH2F7+Sxw7lKsGk4LfWxpkticzUihacEc8xneJUBD4x7dWEViFN5MsBX4dGpA5AqYLlrFIo/qd//KSRrZWXxVvkY/Ipoo5X3i9hLa9tx+ybPHujvQYoLI/kRRlG/9fa6EwLfXeEpVAmyPXECNXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQfjGc5w; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a3771c0f8cso421403f8f.3;
        Thu, 29 May 2025 03:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748514518; x=1749119318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G+AWE0ChEcv4BK6NxMsaTCk+YtxkhcPlbfmQixtnutQ=;
        b=MQfjGc5wGTyzJVxFNSrwdMfCRTVD3v8vlPO0++846vZJ43z955c6qZ2kF3mpL+Dswa
         Of15A5wOwUHzvawj4HVR61Dmym4fxJyRs3iwROvhyld91s9qiNA34aehu/vNoCRGJBYh
         ICsw7DHPAB9O64QYge6Uk///z35+P7Mww0E7w1TF0Wi3akMsAS6aQZE8JE+hQvqGYXFk
         tcabbVk2HaJeMbyD6F0ZIGfjFLlAFC01w3GPQ3viNSkE+mqst+DtSbiS9sSntbJGLtpH
         p9ExBzCDCmTHXlsXyqvF0d5kk5+34VhD8FN/8nacUIsVYySvgzh8H1oQciv6UqS5nPk1
         Ehvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748514518; x=1749119318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+AWE0ChEcv4BK6NxMsaTCk+YtxkhcPlbfmQixtnutQ=;
        b=MxQ84LuIlFdkcMMkd/36REeyP4dnth6oupLvlmQA+wgfJMK0R5M3p1LzXYmzKScr3W
         FCebY8Jod7400gWwtKJV0rndt47LGEhajkAaLj8fXn3UZSuz+6EFTR5for969jm65WvH
         CFm0XMCpUQ0sHsfb5+qSURAqIz6MOXXNtGWwcfZ6soBLR63jAz5Ijl9DQ28GF9oxYdYP
         FTZWWbT5hyvM7WsulOUz6IK5xJw2fHFq2RzKExFyUNjD02AB0UAIT0e3j0LVQ5BDyarB
         ltH2X+XT4k5M/vuBIBVaOAM8402N+c9qJGna6bc0f3PeEqnWvnrbhCK5lHQTNB6Ya6oA
         8xYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL5fpHr7G143Ympb2V7uf2VoNp9Nz7iwLRtIN2Wu9Ly9v5+c4bIYDhLR8R9t0Zm9Gud5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwECAt90/sQ3DaeqZClfIaoLO9L2Gr4Iz0JBbA2Ps67hSfA/CVf
	tB7cA95ftNAnXe4Y1Hb0YFemUgcrsa1/oM+1dF94MVoPmEEwyKys82SwIXdMy6/U
X-Gm-Gg: ASbGnct+43rTlOhy+N5PZaZ+yKz/S1oOr4ytfkJQvKfDWxmxYTXGE5+jdDRK5nJscem
	BFYgTgI5m/2SKY85xN4LQ3EBUl61lDabtE3MPEaFUbXlcD0oS0Uh5rOIuD5yihnE7jSkrSV8hWH
	obpDcX5JkWeMZZ7mQ7ymGx+pEbt+vn4XSoytyaCOeL9T9E5CpIdNRR9hYKaK/7LLPCf6RTI+G1R
	2aS1vhbuX+UZKEyzK4cfuG4wgCxGZodyIcnS4FlrV15+eHni5tIbH0WCgVspFJtm1dvxDvpMiiC
	ApPEvowbHynBLSWlDQKjRKTVJdu37yUxBWzwgv2dQL6Z1T4Xi2RFcVwk11RpUYwWTwAUN48DmiB
	OYfmWmXcqzfwZRDQyYP5CTGwxlpm6Msi/7jg9EphFxUXHNQmo+w==
X-Google-Smtp-Source: AGHT+IGDNS3qioCeISKUQkC5ZNk6jddjSzW8D59S1wCeMyv6dgm7jfO30NZoaz8w3qGaEdFaNqSrNQ==
X-Received: by 2002:a05:6000:178d:b0:3a0:b84d:60cc with SMTP id ffacd0b85a97d-3a4cb408685mr17894917f8f.2.1748514517843;
        Thu, 29 May 2025 03:28:37 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00bc44bdc1afbcf705.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:bc44:bdc1:afbc:f705])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe73ee0sm1556779f8f.46.2025.05.29.03.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 03:28:37 -0700 (PDT)
Date: Thu, 29 May 2025 12:28:35 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Tom Herbert <tom@herbertland.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH net v3 2/2] bpf: Fix L4 csum update on IPv6 in
 CHECKSUM_COMPLETE
Message-ID: <96a6bc3a443e6f0b21ff7b7834000e17fb549e05.1748509484.git.paul.chaignon@gmail.com>
References: <cover.1748509484.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748509484.git.paul.chaignon@gmail.com>

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
---
 include/uapi/linux/bpf.h       | 2 ++
 net/core/filter.c              | 5 +++--
 tools/include/uapi/linux/bpf.h | 2 ++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 85180e4aaa5a..0b4a2f124d11 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2056,6 +2056,7 @@ union bpf_attr {
  * 		for updates resulting in a null checksum the value is set to
  * 		**CSUM_MANGLED_0** instead. Flag **BPF_F_PSEUDO_HDR** indicates
  * 		that the modified header field is part of the pseudo-header.
+ * 		Flag **BPF_F_IPV6** should be set for IPv6 packets.
  *
  * 		This helper works in combination with **bpf_csum_diff**\ (),
  * 		which does not update the checksum in-place, but offers more
@@ -6072,6 +6073,7 @@ enum {
 	BPF_F_PSEUDO_HDR		= (1ULL << 4),
 	BPF_F_MARK_MANGLED_0		= (1ULL << 5),
 	BPF_F_MARK_ENFORCE		= (1ULL << 6),
+	BPF_F_IPV6			= (1ULL << 7),
 };
 
 /* BPF_FUNC_skb_set_tunnel_key and BPF_FUNC_skb_get_tunnel_key flags. */
diff --git a/net/core/filter.c b/net/core/filter.c
index f1de7bd8b547..327ca73f9cd7 100644
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
index 85180e4aaa5a..0b4a2f124d11 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2056,6 +2056,7 @@ union bpf_attr {
  * 		for updates resulting in a null checksum the value is set to
  * 		**CSUM_MANGLED_0** instead. Flag **BPF_F_PSEUDO_HDR** indicates
  * 		that the modified header field is part of the pseudo-header.
+ * 		Flag **BPF_F_IPV6** should be set for IPv6 packets.
  *
  * 		This helper works in combination with **bpf_csum_diff**\ (),
  * 		which does not update the checksum in-place, but offers more
@@ -6072,6 +6073,7 @@ enum {
 	BPF_F_PSEUDO_HDR		= (1ULL << 4),
 	BPF_F_MARK_MANGLED_0		= (1ULL << 5),
 	BPF_F_MARK_ENFORCE		= (1ULL << 6),
+	BPF_F_IPV6			= (1ULL << 7),
 };
 
 /* BPF_FUNC_skb_set_tunnel_key and BPF_FUNC_skb_get_tunnel_key flags. */
-- 
2.43.0


