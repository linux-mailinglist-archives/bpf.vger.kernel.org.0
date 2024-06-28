Return-Path: <bpf+bounces-33339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8221F91BA60
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 10:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A595F1C235A4
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 08:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4794A14E2EF;
	Fri, 28 Jun 2024 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="45YlAJLC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ss46+fOS"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C13014AD35
	for <bpf@vger.kernel.org>; Fri, 28 Jun 2024 08:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719564546; cv=none; b=ZaFWrKlOf/LxQ1UuEvnXKm/4d2v8M1zkt2vhSOb0BnII6+eIFlibogvIYUWfopnqT+yhrKauCqsxUAMR/F+22v3MvWDLSpXNOd9YawqQabPSz5yl0OyFb3sujpuQEWRkrLhmFVwjKy1EYCjxkgwnZl0ayyD2woat0NlWL0x+VKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719564546; c=relaxed/simple;
	bh=Jmp15m7DL/9CIirMtc/sXhw+FIwwKVeUs0zdTAHo3g4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifiLCCsD6Bcl35U9+8TJ1HcQqZe5dAu1C67w5n0ctmEhRDRtqCuXYU+eILPrXpycXy3HfYq6bCp23T5fU2mO/wEvWbh5LcD5fuSOoVjtpbz0vrBIVRLI0b1ivcLU7++EWNGnYfX9/fuyn4WVCTTZfBbJEJgkEdbpRpVWDcXLVsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=45YlAJLC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ss46+fOS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719564541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uu4Q3+wslqXJvO6xMEb3kL901uruUkEDytAMQS77wrg=;
	b=45YlAJLCUR85ZakeNyO+9Xe9o/lsIolFo6S5TFzbVNbpDax6AcNUFBip1PfP/ELDEZXIXC
	k3WqJMsJJKJnzrcMjyWR7koRzx0mP76HTletKer6zyMcF5oqnCogrkovvDpYF38HVQTRdH
	8sFTnSkhSL4NExPvrNrL7tgT71XC29coJdBqyjn9U7TjihgZyVY7puCSLh79cMhf6WzyAU
	zqk7n3GxgtzxhUUhpd66iSkFWauGk14LDW8jRi2Y00jE/VyQXw8ooTJQL8y6l+++3cTYoE
	vh3NM3eCvwlRE4JfySQNww9Sckz0+tPE8JinKFJ+JpY2QvW1RffAdfejglxCbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719564541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uu4Q3+wslqXJvO6xMEb3kL901uruUkEDytAMQS77wrg=;
	b=Ss46+fOS28TulJPiW5W8IOxg7adK9kCMmlfmFGL7TF/hyPESzYqjSeUVWxxfkkl2zgKegy
	0+2GSw2bYYNEQcAQ==
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yonghong Song <yonghong.song@linux.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH bpf-next 1/3] bpf: Add casts to keep sparse quiet.
Date: Fri, 28 Jun 2024 10:40:59 +0200
Message-ID: <20240628084857.1719108-2-bigeasy@linutronix.de>
In-Reply-To: <20240628084857.1719108-1-bigeasy@linutronix.de>
References: <20240628084857.1719108-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

sparse complains about wrong data types within the BPF callbacks.
Functions like bpf_l3_csum_replace() are invoked with a specific set of
arguments and its further usage is based on a flag. So it can not be set
right upfront.
There is also access to variables in struct bpf_nh_params and struct
bpf_xfrm_state which should be __be32. The content comes directly
from the BPF program so conversion is already right.

Add __force casts for the right data type and update the members in
struct bpf_xfrm_state and bpf_nh_params in order to keep sparse happy.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406261217.A4hdCnYa-lkp@int=
el.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/filter.h   |  2 +-
 include/uapi/linux/bpf.h |  6 +++---
 net/core/filter.c        | 18 ++++++++++--------
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index c0349522de8fb..9a96019376b67 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -728,7 +728,7 @@ struct bpf_skb_data_end {
 struct bpf_nh_params {
 	u32 nh_family;
 	union {
-		u32 ipv4_nh;
+		__be32 ipv4_nh;
 		struct in6_addr ipv6_nh;
 	};
 };
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 25ea393cf084b..f45b03706e4e9 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6290,12 +6290,12 @@ struct bpf_tunnel_key {
  */
 struct bpf_xfrm_state {
 	__u32 reqid;
-	__u32 spi;	/* Stored in network byte order */
+	__be32 spi;	/* Stored in network byte order */
 	__u16 family;
 	__u16 ext;	/* Padding, future use. */
 	union {
-		__u32 remote_ipv4;	/* Stored in network byte order */
-		__u32 remote_ipv6[4];	/* Stored in network byte order */
+		__be32 remote_ipv4;	/* Stored in network byte order */
+		__be32 remote_ipv6[4];	/* Stored in network byte order */
 	};
 };
=20
diff --git a/net/core/filter.c b/net/core/filter.c
index eb1c4425c06f3..11939971f3c6a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1939,13 +1939,13 @@ BPF_CALL_5(bpf_l3_csum_replace, struct sk_buff *, s=
kb, u32, offset,
 		if (unlikely(from !=3D 0))
 			return -EINVAL;
=20
-		csum_replace_by_diff(ptr, to);
+		csum_replace_by_diff(ptr, (__force __wsum)to);
 		break;
 	case 2:
-		csum_replace2(ptr, from, to);
+		csum_replace2(ptr, (__force __be16)from, (__force __be16)to);
 		break;
 	case 4:
-		csum_replace4(ptr, from, to);
+		csum_replace4(ptr, (__force __be32)from, (__force __be32)to);
 		break;
 	default:
 		return -EINVAL;
@@ -1990,13 +1990,15 @@ BPF_CALL_5(bpf_l4_csum_replace, struct sk_buff *, s=
kb, u32, offset,
 		if (unlikely(from !=3D 0))
 			return -EINVAL;
=20
-		inet_proto_csum_replace_by_diff(ptr, skb, to, is_pseudo);
+		inet_proto_csum_replace_by_diff(ptr, skb, (__force __wsum)to, is_pseudo);
 		break;
 	case 2:
-		inet_proto_csum_replace2(ptr, skb, from, to, is_pseudo);
+		inet_proto_csum_replace2(ptr, skb, (__force __be16)from, (__force __be16=
)to,
+					 is_pseudo);
 		break;
 	case 4:
-		inet_proto_csum_replace4(ptr, skb, from, to, is_pseudo);
+		inet_proto_csum_replace4(ptr, skb, (__force __be32)from, (__force __be32=
)to,
+					 is_pseudo);
 		break;
 	default:
 		return -EINVAL;
@@ -2046,7 +2048,7 @@ BPF_CALL_5(bpf_csum_diff, __be32 *, from, u32, from_s=
ize,
=20
 	ret =3D csum_partial(sp->diff, diff_size, seed);
 	local_unlock_nested_bh(&bpf_sp.bh_lock);
-	return ret;
+	return (__force __u32)ret;
 }
=20
 static const struct bpf_func_proto bpf_csum_diff_proto =3D {
@@ -2068,7 +2070,7 @@ BPF_CALL_2(bpf_csum_update, struct sk_buff *, skb, __=
wsum, csum)
 	 * as emulating csum_sub() can be done from the eBPF program.
 	 */
 	if (skb->ip_summed =3D=3D CHECKSUM_COMPLETE)
-		return (skb->csum =3D csum_add(skb->csum, csum));
+		return (__force __u32)(skb->csum =3D csum_add(skb->csum, csum));
=20
 	return -ENOTSUPP;
 }
--=20
2.45.2


