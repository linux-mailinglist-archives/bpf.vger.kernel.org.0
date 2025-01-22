Return-Path: <bpf+bounces-49530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FAEA1997A
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 21:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F7F816AD6A
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 20:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F37215F4E;
	Wed, 22 Jan 2025 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hsa/RVXP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF0C1BE238
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737576256; cv=none; b=fe/6qwLzOPwoyIBNuyu0/XRkyHQt3hwSmqhMQrItcO08DDBetyIXpc8y9jN91MKtKls5M98lyCAGRAWl2I+kYxXxQ8wWh0HKT12fqEHhRlBGskQw+J6vNxdTeKiZ62KSaCxO1kekYcxlT05DhQlhABHVuR+2EQz0giMN6fUDI9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737576256; c=relaxed/simple;
	bh=XnOtT13HudSo/t5aTUQUe9jqx2EsCkhi+wwhAHszSpE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Cc++LEloAPvl91rITTEzqcG9LrpLzgJF7kBByNil6Pudu16M4fkEB4pIlh4uao9a7K0a7J8gAQk0P7bI/wvGADR0U1c1nRDEuMyi7rUmfrDf3Ndmm7nn/n0qXoG9tFFgtD06Nov2Bau4vZXczDHOpWiBw6nvBni2MoguxBsTN4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hsa/RVXP; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maze.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21648c8601cso1207365ad.2
        for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 12:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737576254; x=1738181054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ozi+W3TuMxcKCBieZitU4SmxxIHib2ALKkefPS+Ch58=;
        b=Hsa/RVXPlmXIMMRobCLeCqT+IyFjujmjX8ubamYkHLH4RxKiamyoBQoZOnjWE8knUT
         xcHyXAa/J0wICp4e+0icMojTLmDzyhzV1CNGw+XMoGyPNwb1yX2fZkU2aZeQyNmMBg8z
         aYxwhFOpgObW/Xxg2tKgxMiJJkZ33XVIFFvdUqCesrpmtnTo/UdyiWJxrT+18pfv/Rjo
         2IhWmoUX/jxdLpP+UCXmxig/IuawwiyBsG9i4bhgV3fAvnDIA82h3Nq3bAS1W7Vh6RRZ
         MlSLUyQPHiUA7gpSj1txr88JzX9RDPBMbUOdbNmNiloLTtze3w9hA0S5tHG9DHRLyDqq
         m07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737576254; x=1738181054;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ozi+W3TuMxcKCBieZitU4SmxxIHib2ALKkefPS+Ch58=;
        b=dHS88UbiA+PNsvfrIKtXns9jkkSewRKSM+JmAxZ+TC/SNFLPnoQbJ9JyyM0r+gi0UU
         3NCr6Gml4b0jb1UnhI2ToVv3P2xmGDa8fWnNizBqp1ZKJeuHMFYh8fu9vjKpyjWy6lZu
         Hf+7QR9qqmtuicybBn2FNAkFHRGpFbTzs6YRkp6at8CMsEJNUffc28GYsoH2WXWIbIRd
         me9/I9MXXVBXYM+8rdcyj19weBSW03T1BkXPJ1usbQnKv+KW71UpVcFD2htqSqcb70mv
         AfaHkZy5kS4XiMn0ZwurINEEeSWv/ojjrOLqknzpvYU6mOxhxEmBOQ+WAK6zxcSrnLx6
         Uz2g==
X-Forwarded-Encrypted: i=1; AJvYcCV4ZyP92MyqaUg+Om7uGZq+pTDZAZyTtmw0OqTH3gN3xSPbSgzZZVld1AJ8Rd9lU1T+hBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+wQf/+vsaqtVtIcHYR/ib52ABgmbpbZxcC+Bgj6FVmCo14Uck
	uj2rvoJ62AHxRfVNuiek8XIpjR5yzCheHHAEy50JQOxKFvd3aRPduaN6EvM9KvOeH0NdlQ==
X-Google-Smtp-Source: AGHT+IHpSV7GVNyrwh5GIG16/iJ0rRkMw3mueP4dceG3gVzgrm9kryZBPCQsDNMjT1C/+MV9sYgrFxKg
X-Received: from pllb16.prod.google.com ([2002:a17:902:e950:b0:21b:d402:6f93])
 (user=maze job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e802:b0:215:827e:3a6
 with SMTP id d9443c01a7336-21c355ba38amr376633905ad.40.1737576253571; Wed, 22
 Jan 2025 12:04:13 -0800 (PST)
Date: Wed, 22 Jan 2025 12:04:02 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250122200402.3461154-1-maze@google.com>
Subject: [PATCH bpf] bpf: fix classic bpf reads from negative offset outside
 of linear skb portion
From: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
To: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, BPF Mailing List <bpf@vger.kernel.org>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, 
	Matt Moeller <moeller.matt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

We're received reports of cBPF code failing to accept DHCP packets.
"BPF filter for DHCP not working (android14-6.1-lts + android-14.0.0_r74)"

The relevant Android code is at:
  https://cs.android.com/android/platform/superproject/main/+/main:packages=
/modules/NetworkStack/jni/network_stack_utils_jni.cpp;l=3D95;drc=3D9df50aef=
1fd163215dcba759045706253a5624f5
which uses a lot of macros from:
  https://cs.android.com/android/platform/superproject/main/+/main:packages=
/modules/Connectivity/bpf/headers/include/bpf/BpfClassic.h;drc=3Dc58cfb7c7d=
a257010346bd2d6dcca1c0acdc8321

This is widely used and does work on the vast majority of drivers,
but is exposing a core kernel cBPF bug related to driver skb layout.

Root cause is iwlwifi driver, specifically on (at least):
  Dell 7212: Intel Dual Band Wireless AC 8265
  Dell 7220: Intel Wireless AC 9560
  Dell 7230: Intel Wi-Fi 6E AX211
delivers frames where the UDP destination port is not in the skb linear
portion, while the cBPF code is using SKF_NET_OFF relative addressing.

simplified from above, effectively:
  BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, SKF_NET_OFF)
  BPF_STMT(BPF_LD  | BPF_H | BPF_IND, SKF_NET_OFF + 2)
  BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 68, 1, 0)
  BPF_STMT(BPF_RET | BPF_K, 0)
  BPF_STMT(BPF_RET | BPF_K, 0xFFFFFFFF)
fails to match udp dport=3D68 packets.

Specifically the 3rd cBPF instruction fails to match the condition:
  if (ptr >=3D skb->head && ptr + size <=3D skb_tail_pointer(skb))
within bpf_internal_load_pointer_neg_helper() and thus returns NULL,
which results in reading -EFAULT.

This is because bpf_skb_load_helper_{8,16,32} don't include the
"data past headlen do skb_copy_bits()" logic from the non-negative
offset branch in the negative offset branch.

Note: I don't know sparc assembly, so this doesn't fix sparc...
ideally we should just delete bpf_internal_load_pointer_neg_helper()
This seems to have always been broken (but not pre-git era, since
obviously there was no eBPF helpers back then), but stuff older
than 5.4 is no longer LTS supported anyway, so using 5.4 as fixes tag.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Willem de Bruijn <willemb@google.com>
Reported-by: Matt Moeller <moeller.matt@gmail.com>
Closes: https://issuetracker.google.com/384636719 [Treble - GKI partner int=
ernal]
Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
Fixes: 219d54332a09 ("Linux 5.4")
---
 include/linux/filter.h |  2 ++
 kernel/bpf/core.c      | 14 +++++++++
 net/core/filter.c      | 69 +++++++++++++++++-------------------------
 3 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index a3ea46281595..c24d8e338ce4 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1479,6 +1479,8 @@ static inline u16 bpf_anc_helper(const struct sock_fi=
lter *ftest)
 void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *skb,
 					   int k, unsigned int size);
=20
+int bpf_internal_neg_helper(const struct sk_buff *skb, int k);
+
 static inline int bpf_tell_extensions(void)
 {
 	return SKF_AD_MAX;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index da729cbbaeb9..994988dabb97 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -89,6 +89,20 @@ void *bpf_internal_load_pointer_neg_helper(const struct =
sk_buff *skb, int k, uns
 	return NULL;
 }
=20
+int bpf_internal_neg_helper(const struct sk_buff *skb, int k)
+{
+	if (k >=3D 0)
+		return k;
+	if (k >=3D SKF_NET_OFF)
+		return skb->network_header + k - SKF_NET_OFF;
+	if (k >=3D SKF_LL_OFF) {
+		if (unlikely(!skb_mac_header_was_set(skb)))
+			return -1;
+		return skb->mac_header + k - SKF_LL_OFF;
+	}
+	return -1;
+}
+
 /* tell bpf programs that include vmlinux.h kernel's PAGE_SIZE */
 enum page_size_enum {
 	__PAGE_SIZE =3D PAGE_SIZE
diff --git a/net/core/filter.c b/net/core/filter.c
index e56a0be31678..609ef7df71ce 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -221,21 +221,16 @@ BPF_CALL_3(bpf_skb_get_nlattr_nest, struct sk_buff *,=
 skb, u32, a, u32, x)
 BPF_CALL_4(bpf_skb_load_helper_8, const struct sk_buff *, skb, const void =
*,
 	   data, int, headlen, int, offset)
 {
-	u8 tmp, *ptr;
-	const int len =3D sizeof(tmp);
-
-	if (offset >=3D 0) {
-		if (headlen - offset >=3D len)
-			return *(u8 *)(data + offset);
-		if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
-			return tmp;
-	} else {
-		ptr =3D bpf_internal_load_pointer_neg_helper(skb, offset, len);
-		if (likely(ptr))
-			return *(u8 *)ptr;
-	}
+	u8 tmp;
=20
-	return -EFAULT;
+	offset =3D bpf_internal_neg_helper(skb, offset);
+	if (unlikely(offset < 0))
+		return -EFAULT;
+	if (headlen - offset >=3D sizeof(u8))
+		return *(u8 *)(data + offset);
+	if (skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
+		return -EFAULT;
+	return tmp;
 }
=20
 BPF_CALL_2(bpf_skb_load_helper_8_no_cache, const struct sk_buff *, skb,
@@ -248,21 +243,16 @@ BPF_CALL_2(bpf_skb_load_helper_8_no_cache, const stru=
ct sk_buff *, skb,
 BPF_CALL_4(bpf_skb_load_helper_16, const struct sk_buff *, skb, const void=
 *,
 	   data, int, headlen, int, offset)
 {
-	__be16 tmp, *ptr;
-	const int len =3D sizeof(tmp);
+	__be16 tmp;
=20
-	if (offset >=3D 0) {
-		if (headlen - offset >=3D len)
-			return get_unaligned_be16(data + offset);
-		if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
-			return be16_to_cpu(tmp);
-	} else {
-		ptr =3D bpf_internal_load_pointer_neg_helper(skb, offset, len);
-		if (likely(ptr))
-			return get_unaligned_be16(ptr);
-	}
-
-	return -EFAULT;
+	offset =3D bpf_internal_neg_helper(skb, offset);
+	if (unlikely(offset < 0))
+		return -EFAULT;
+	if (headlen - offset >=3D sizeof(__be16))
+		return get_unaligned_be16(data + offset);
+	if (skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
+		return -EFAULT;
+	return be16_to_cpu(tmp);
 }
=20
 BPF_CALL_2(bpf_skb_load_helper_16_no_cache, const struct sk_buff *, skb,
@@ -275,21 +265,16 @@ BPF_CALL_2(bpf_skb_load_helper_16_no_cache, const str=
uct sk_buff *, skb,
 BPF_CALL_4(bpf_skb_load_helper_32, const struct sk_buff *, skb, const void=
 *,
 	   data, int, headlen, int, offset)
 {
-	__be32 tmp, *ptr;
-	const int len =3D sizeof(tmp);
-
-	if (likely(offset >=3D 0)) {
-		if (headlen - offset >=3D len)
-			return get_unaligned_be32(data + offset);
-		if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
-			return be32_to_cpu(tmp);
-	} else {
-		ptr =3D bpf_internal_load_pointer_neg_helper(skb, offset, len);
-		if (likely(ptr))
-			return get_unaligned_be32(ptr);
-	}
+	__be32 tmp;
=20
-	return -EFAULT;
+	offset =3D bpf_internal_neg_helper(skb, offset);
+	if (unlikely(offset < 0))
+		return -EFAULT;
+	if (headlen - offset >=3D sizeof(__be32))
+		return get_unaligned_be32(data + offset);
+	if (skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
+		return -EFAULT;
+	return be32_to_cpu(tmp);
 }
=20
 BPF_CALL_2(bpf_skb_load_helper_32_no_cache, const struct sk_buff *, skb,
--=20
2.48.1.262.g85cc9f2d1e-goog


