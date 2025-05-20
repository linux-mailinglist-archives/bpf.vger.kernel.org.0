Return-Path: <bpf+bounces-58620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6961CABE6BD
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 00:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BD7A1BC12F0
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 22:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8425B2586CF;
	Tue, 20 May 2025 22:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKXQevha"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F73314386D
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 22:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747778791; cv=none; b=sSQJYC6OlgPFC2Vswq2kNGUW8578JRnGXVNBLaH7FD6RRHWtRSO+buR0d1BQNTmRhqiwc9EJHdM2TC/kTGS5wx2y2g+B+tknrFRlloz54DpzGs65Z9kBoIMnSyrMj+Cbyw85CbfHfTPAbYzscN3rrRlup2intZmiD1lY9GmfReQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747778791; c=relaxed/simple;
	bh=lqQ5RNH7yV+1lJqA+59Xt3mltE8oEFeGQos80aXoYvk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BsO4mkH36fTGsjN05NPICf71Rk4KZ1UEoyVD402ACfAyvYenzAaC/xzlacR9HI/zGpzfoL9qOIMEiyCsofTN53cYcES23Dcr0+ap1LYQq7W9PytIHMnG0Kko4sX9nqVkdCHkOrJ2Kr8Kjom5nWm8e+BF3OsORTTUDrX2OsiCKbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKXQevha; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-443a787bd14so28042125e9.1
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 15:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747778787; x=1748383587; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DJAeo0d5hz/g1/QC4F8fvpus4Jbk1xU6cd9gdg8f3uQ=;
        b=JKXQevhaiqHzhAKC71XvnfmuLfGjdKWZB6jwk/SVW6Lw3sl20sgMuVC+LnyIhnypWq
         ztkHktYX2WpyLIXpt3gf9hNGhCqk+bM92yAXzx2VhvR9jZs7VTqctvd7rIJFb2xQ/h33
         h1w5Uq0PfE8jKg6QEi2VXQy8uYmzW28m2ZmZPL9FuS+ztD1K08Y1WLZfVy2dieTfk2RS
         rdLpTp54BHVzdWVSY1fyMvHZgV92W6FAkS/5KAObnA4/22NNfGg1BdxGe3ElAS9KMqk9
         u3QZIIyaUsSQkob/cRhN8CW722QlJCXV8rERBAGMLCc3qCQqma/XXbTnzFI06Bn9yyOv
         Uc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747778787; x=1748383587;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJAeo0d5hz/g1/QC4F8fvpus4Jbk1xU6cd9gdg8f3uQ=;
        b=KlUpywYp1A4NFjj6LuUPvAmpSqjUSH7OzdouJmCaiebwpNH8u4IDbc27zVWcpoqy//
         7uTxZZNqsOmG6ZsHClKuApTlC0sMTymlL0B1ff7g+2qf30FPy46G8iuCbJhszrJyRFXP
         Mu0pib7aV6MMC0joPk8dzMLxWwoLqnle0FXZrEjwZEW1g0X3gT2+CRDD5wb85CfkhLcN
         +8+jqVN7xgF5b46YByt9ft1lFYy79KKrRCzVK4oneBZAi2zvPIx1vUkuioTPnPKvrP13
         APL/LzQQDVccurGM93A0b9Y6SMAU7rFa93M2Cq7sTCVHVHS6TWDVgpvBsmEJh9V0NnTu
         Yh2g==
X-Gm-Message-State: AOJu0Yw1sIzsvui1OMFRE4iR7wQpRuvT4qO23Hz2IudVWZwKc2Qnb60t
	uu1pKJNw9C2qvUkFCo49DHeXbcrVv7WUqYW7yR+Y0meI6XWbKmoBbg27FkNQ+nQy
X-Gm-Gg: ASbGncuBXTDI14bO+FGn07zDqZy7VRVY9JTdnTuxLRHgEyqtnyTftcxsqeZFc1hZXvC
	PrwYyCztRNBvAuTeWTCQAarG4AG4tOFGNKz0LVm42mTCgGBdGiBYQn6pta9bBGa1Uh6VM+JgmRN
	ckHsuSgFbRhSf1zcKC+VdOaeJoYe74mrRjww108sMbiDpIcKdzeUmohPMw7ZEuvdGx+qb/ax1tJ
	gzLEJACyfdRFdUJ+bxzWnnNbqO5z1tNPMNvB+eRtgh5S+etVqVZmOwm6wnbRwWVmTDv5IzOR01U
	fZHCl9aofCj28ts4oI+B/grsRRdKQKcTni1IfNgIjPN6OXjLyzFqvfmC93YsoYzbrcz/NxMWerC
	9bEiqpV6xuGLtzWJCqwVL/Xis47oBExewAVDMp9GekqliA4Krpg==
X-Google-Smtp-Source: AGHT+IHClpwv+mwyTCSvU0+v1lm1OXrCGO3xpT3W0Js3Rdn+eUDVpIakj6DqyuZLmkPcdbFQyUo71A==
X-Received: by 2002:a5d:64e8:0:b0:3a3:6c7b:d0ce with SMTP id ffacd0b85a97d-3a36c7bd389mr9459943f8f.2.1747778787209;
        Tue, 20 May 2025 15:06:27 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e006f5e16534b25caf5.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:6f5e:1653:4b25:caf5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca6210asm17540129f8f.41.2025.05.20.15.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 15:06:26 -0700 (PDT)
Date: Wed, 21 May 2025 00:06:24 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [RFC PATCH bpf-next] bpf: Support L4 csum update for IPv6 address
 changes
Message-ID: <aCz84JU60wd8etiT@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

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

This patch introduces a new bpf_l4_csum_replace flag, BPF_F_IPV6_ADDR,
to indicate we're updating the L4 checksum after an IPv6 address change.
When this flag is set, bpf_l4_csum_replace will call
inet_proto_csum_replace16 instead of inet_proto_csum_replace_by_diff.

I'm sending this as an RFC because I'm not convinced this is the ideal
solution, but also prefer to discuss this around concrete code rather
than a simple bug report. In particular, I would have preferred a
solution we can backport to stable. Since we will have to change the API
to provide additional information to bpf_l4_csum_replace, I'm unsure
such a solution exists.

Fixes: 7d672345ed295 ("bpf: add generic bpf_csum_diff helper")
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 include/uapi/linux/bpf.h       |  1 +
 net/core/filter.c              | 21 +++++++++++++--------
 tools/include/uapi/linux/bpf.h |  1 +
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 16e95398c91c..ed2a8d223c86 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6069,6 +6069,7 @@ enum {
 	BPF_F_PSEUDO_HDR		= (1ULL << 4),
 	BPF_F_MARK_MANGLED_0		= (1ULL << 5),
 	BPF_F_MARK_ENFORCE		= (1ULL << 6),
+	BPF_F_IPV6_ADDR			= (1ULL << 7),
 };
 
 /* BPF_FUNC_skb_set_tunnel_key and BPF_FUNC_skb_get_tunnel_key flags. */
diff --git a/net/core/filter.c b/net/core/filter.c
index 30e7d3679088..777c9e467d07 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1965,13 +1965,15 @@ static const struct bpf_func_proto bpf_l3_csum_replace_proto = {
 BPF_CALL_5(bpf_l4_csum_replace, struct sk_buff *, skb, u32, offset,
 	   u64, from, u64, to, u64, flags)
 {
-	bool is_pseudo = flags & BPF_F_PSEUDO_HDR;
-	bool is_mmzero = flags & BPF_F_MARK_MANGLED_0;
-	bool do_mforce = flags & BPF_F_MARK_ENFORCE;
+	bool is_pseudo    = flags & BPF_F_PSEUDO_HDR;
+	bool is_mmzero    = flags & BPF_F_MARK_MANGLED_0;
+	bool do_mforce    = flags & BPF_F_MARK_ENFORCE;
+	bool is_ipv6_addr = flags & BPF_F_IPV6_ADDR;
 	__sum16 *ptr;
 
 	if (unlikely(flags & ~(BPF_F_MARK_MANGLED_0 | BPF_F_MARK_ENFORCE |
-			       BPF_F_PSEUDO_HDR | BPF_F_HDR_FIELD_MASK)))
+			       BPF_F_PSEUDO_HDR | BPF_F_HDR_FIELD_MASK |
+			       BPF_F_IPV6_ADDR)))
 		return -EINVAL;
 	if (unlikely(offset > 0xffff || offset & 1))
 		return -EFAULT;
@@ -1984,10 +1986,13 @@ BPF_CALL_5(bpf_l4_csum_replace, struct sk_buff *, skb, u32, offset,
 
 	switch (flags & BPF_F_HDR_FIELD_MASK) {
 	case 0:
-		if (unlikely(from != 0))
-			return -EINVAL;
-
-		inet_proto_csum_replace_by_diff(ptr, skb, to, is_pseudo);
+		if (is_ipv6_addr) {
+			inet_proto_csum_replace16(ptr, skb, (void *)from, (void *)to, is_pseudo);
+		} else {
+			if (unlikely(from != 0))
+				return -EINVAL;
+			inet_proto_csum_replace_by_diff(ptr, skb, to, is_pseudo);
+		}
 		break;
 	case 2:
 		inet_proto_csum_replace2(ptr, skb, from, to, is_pseudo);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 16e95398c91c..ed2a8d223c86 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6069,6 +6069,7 @@ enum {
 	BPF_F_PSEUDO_HDR		= (1ULL << 4),
 	BPF_F_MARK_MANGLED_0		= (1ULL << 5),
 	BPF_F_MARK_ENFORCE		= (1ULL << 6),
+	BPF_F_IPV6_ADDR			= (1ULL << 7),
 };
 
 /* BPF_FUNC_skb_set_tunnel_key and BPF_FUNC_skb_get_tunnel_key flags. */
-- 
2.43.0


