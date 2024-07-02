Return-Path: <bpf+bounces-33638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BE69240BB
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 16:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA51E1F242EA
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 14:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382C61BA08A;
	Tue,  2 Jul 2024 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hhUKNyES";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tYGKZgFJ"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0E71BA06B
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930349; cv=none; b=hEdz4tATkj+8GHDq9Zhsx1hM55IvRuRuJIcM3roAPu9SwhYC+3ZsJk0oAv37sv2T4r5NM3SqxYjXgofWi2OVae62ZRowzEvh+w924MfXUciSBTdDsa2kMaKq538DU+BWFnFMTxWJoW+eqFeB5yfnKCuyuQlvl3L9NdN1qY7Hpzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930349; c=relaxed/simple;
	bh=3+hAt5Mk/KC225kGTnF42PzvQcOgagOMb3bzECebRtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSHifhrhuKV59sPOnG5d75CKBNYE7VcfpiI2zvADhKKX+SpxEWQqJqpjF5T57lrvmyw9Yi6ZgzVTqBJfWknhYzIavbtyBi4nnTvUWnCyYnOlxMpXeNUdg771oCfissFaA+N553119hVwO/luShKBArcIGBASPksrloXwQklBZj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hhUKNyES; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tYGKZgFJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719930346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IkCowhvQum3v1KzbsfgE3rIZxwleg1P8LF5qLPsnbog=;
	b=hhUKNyESyqJ0P376rzlhgA1AZ+GCx+p+3krY7rlofW2qQhTQasLAp1ypVa4CBN2bMuXsV3
	kt4YFwUDSovK6wHK9TF9y3PVL+6oXf9JE83L6XJJyZtWIQ4HzynExljc02PXymR5KstXME
	3amFkIKY/2ff8MOqNshXgUhMvsIC7ahUm3o8yCh3XRpkM2QVJcbr2zeiMwuWm6h0xfmWtz
	mmo3Tg4s39CBotSzzx+HXO9A7aiSdWGWxSIe8tL2Oo4xVRlIP3kpRolYBTrN71urPxCMT9
	lUX/gLlz4R4h4P8H6QsQYOyXzVPA+aWmeAiTyHux/BCJb/rMjDInVG6MYe3cvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719930346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IkCowhvQum3v1KzbsfgE3rIZxwleg1P8LF5qLPsnbog=;
	b=tYGKZgFJ+6d1Ypz5JmD9+pprGYdxmyz4la8l0VApdswo9tGON2cLgfHPKJoDmBO5a6yWs1
	M07XLY7bJ9ufcxDA==
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
Subject: [PATCH v2 bpf-next 1/3] bpf: Add casts to keep sparse quiet.
Date: Tue,  2 Jul 2024 16:21:41 +0200
Message-ID: <20240702142542.179753-2-bigeasy@linutronix.de>
In-Reply-To: <20240702142542.179753-1-bigeasy@linutronix.de>
References: <20240702142542.179753-1-bigeasy@linutronix.de>
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
 include/linux/filter.h         |  2 +-
 include/uapi/linux/bpf.h       |  6 +++---
 net/core/filter.c              | 18 ++++++++++--------
 tools/include/uapi/linux/bpf.h |  6 +++---
 4 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 02ddcfdf94c46..15aee0143f1cf 100644
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
index 403d23faf22e1..3f14c8019f26d 100644
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
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 25ea393cf084b..f45b03706e4e9 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
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
--=20
2.45.2


