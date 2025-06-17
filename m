Return-Path: <bpf+bounces-60815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E27ADCF57
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 16:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA4E3A9835
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 14:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A37A2DE219;
	Tue, 17 Jun 2025 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c90U5FiN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43800212B3B;
	Tue, 17 Jun 2025 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169307; cv=none; b=B6Lq80ykj/UbvrrXny1/ZyJTwQ4uNbhuPwbQTwLJkxlQwrNA+U1+RtvgCPNVNdcCDME6it/9WTdSKfDK1aO8OoGVWqg47/Dg7NGpOu+I7yLm89WIyVRnWSfAoFqTY61qPcu4qYGeobH9mIQHbrkiZdEiaN7WyoSU71h4vjT8C7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169307; c=relaxed/simple;
	bh=AsY+km8zu9QwAiqj5ecxJmfYO9sHnSLVFm+41I3R1oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZOkan6D5/SR/V3XFdBLqsh1iN5eyAB2dtj8RSUa8kEnudqT/JW1LuVrdqYcAD5M9fYZhwSmkLgpMuKToIKIGQeTR5s3opgeMrxczXpTCXDB17gKV9oabpxcediODpPB6lzw6q2z/tJN5idYTzShBE3uE84Di21dUTtTa2jRirE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c90U5FiN; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45347d6cba3so7131695e9.0;
        Tue, 17 Jun 2025 07:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169303; x=1750774103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SI9R8nQ2JLtxjBJjfyLDvHLXoOUvu+2sBgYNTvW4Kj4=;
        b=c90U5FiN8VRRNkKBdNGVgbmawWYg9m9hIbvU0EvycavFzlArAiU2jz6sV5PnEqtZIS
         Bd6DBU94+GJ9/afufOlzx3m1R06gkAD02ny7EFKAPR1FKRX9EXcWsCRd70O2Ps4VQrcP
         oxQ5iPC6eA4wGhNWiY+M5Y6i7okn/+Qx7mis8jmeS7AkcjlE6sEn2AAjNEmU1kOhF0ac
         1HQdmvylVWnr3BY1bJz6Iag3cgTi8WN7WMVVCTt3t9EZWQDVwmNzwQUP9JhMWcwwmUvC
         QdOn4s1ewgBIZJv/L8UH/mrryuUc6si4JqXLLzLnBGQLkKpCpLMYbiVeyAYbSjiOyaqO
         4cKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169303; x=1750774103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SI9R8nQ2JLtxjBJjfyLDvHLXoOUvu+2sBgYNTvW4Kj4=;
        b=SkYcEeGSblsbuW1P/kUV+luHmauZ1b2UJP8Zx7Mw3XV96vBxpqU8GiGPsT7gE1CGly
         hPwS2U5Uj1pCq8DNlMVbXxp+yECnr5Sp5uXA+R+rhuS8w3kGk3bHt+G430MFaGiTCgem
         8yp10DVk6I249vu+Xyy858SfpKUOJpmQT0Ygo9cv27WIGzPI5Udvfd5yvuPuhbFKfYHo
         Cces2i+fSdWfv4zRRrz5JdAcDpdp8KKV+9QTnY0PgT5sUTij5SpeM6x4Uk6tBQ2yK6KL
         8k0IR1DpQfM4/dKefYH3TI4WEACmzx/Atbcs6GUua2vzkUUwLsudSlVwq4bXCE7hyBqt
         SsvA==
X-Forwarded-Encrypted: i=1; AJvYcCUmEyNZo0Cyo/kScQ0K1N1r9Licqo7E0kREvkAXV/vdHQy5U80H3ND8tZafe7O0nBsh3yEz00I5@vger.kernel.org, AJvYcCV8/y+ldh0Ikp5bU06tH6fb+UofbdmW5w1KiCRNIUuPsAGXp34hESTKziF4SQ9KDwzg2tc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/2fVLXrfY9dSOQkbRfPegLzN7wPVfJcpU8j12H5EI3oj9cxKN
	WvTdgF8tdUSV8Viu5Mw2aIUL50A7N5bjrDGJbQTqHFLWAjjsymys/P1Y/tITGxBT
X-Gm-Gg: ASbGncvxXmsngWWDKvnm50bT+Nge5XdMMJr4JgSe+JORCwi2F+shUdld7Kk370WpgpW
	3glGeD/RyeT3pXq9eqBLJIXhOgwaKX8AeC2kI3idEUj/ego7KKZoYmtPLEq4WNReRVgPgwWaFuw
	iu0kOF+SKinXjT9Ps2oTOUIsKT1neuv0RnIuMrjeTEx6GeEMvU+xxYeptnMvDBOUPIdAtyXP+1v
	IW9nzfE/qG/9SwHDD7qliPa7dml3QhbDJApLrClyhoriUyeT2NWkGs8tPCb8eX6EOyU9spWyEyy
	EsUioAhLQCsc7VDY8JCLyjavqEvY+Bl5E5PC5J5+f4gkoAJlBuAASqRwUtDhTEcUpyIikYLLtGt
	gIFZPaXqaFKuwusg3MGm30xm2mCBfz4SVYMpuFrus2sCxCSaWoGziK7cGGSuT
X-Google-Smtp-Source: AGHT+IGPMVh/+ttSxotYqzproaz+fzRALHT4pOdxJDZUcs1hON/RLA5Ezkd80x6Lq0fegsNttgej0w==
X-Received: by 2002:a05:600c:8509:b0:450:cf46:5510 with SMTP id 5b1f17b1804b1-4533cb53b27mr121902215e9.29.1750169303379;
        Tue, 17 Jun 2025 07:08:23 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00112ae8a423a3e4b4.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:112a:e8a4:23a3:e4b4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b08a2bsm14349503f8f.62.2025.06.17.07.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:08:22 -0700 (PDT)
Date: Tue, 17 Jun 2025 16:08:21 +0200
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
Subject: [PATCH stable 6.1-6.12 2/2] bpf: Fix L4 csum update on IPv6 in
 CHECKSUM_COMPLETE
Message-ID: <ad27219689eb849a3b8ec0672591b6384bb2bbcc.1750168920.git.paul.chaignon@gmail.com>
References: <6520b247c2d367849f41689f71961e9741b1b7eb.1750168920.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6520b247c2d367849f41689f71961e9741b1b7eb.1750168920.git.paul.chaignon@gmail.com>

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
index 552fd633f820..5a5cdb453935 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2035,6 +2035,7 @@ union bpf_attr {
  * 		for updates resulting in a null checksum the value is set to
  * 		**CSUM_MANGLED_0** instead. Flag **BPF_F_PSEUDO_HDR** indicates
  * 		the checksum is to be computed against a pseudo-header.
+ * 		Flag **BPF_F_IPV6** should be set for IPv6 packets.
  *
  * 		This helper works in combination with **bpf_csum_diff**\ (),
  * 		which does not update the checksum in-place, but offers more
@@ -6049,6 +6050,7 @@ enum {
 	BPF_F_PSEUDO_HDR		= (1ULL << 4),
 	BPF_F_MARK_MANGLED_0		= (1ULL << 5),
 	BPF_F_MARK_ENFORCE		= (1ULL << 6),
+	BPF_F_IPV6			= (1ULL << 7),
 };
 
 /* BPF_FUNC_skb_set_tunnel_key and BPF_FUNC_skb_get_tunnel_key flags. */
diff --git a/net/core/filter.c b/net/core/filter.c
index e0d978c1a4cd..7c6811988c26 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1980,10 +1980,11 @@ BPF_CALL_5(bpf_l4_csum_replace, struct sk_buff *, skb, u32, offset,
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
@@ -1999,7 +2000,7 @@ BPF_CALL_5(bpf_l4_csum_replace, struct sk_buff *, skb, u32, offset,
 		if (unlikely(from != 0))
 			return -EINVAL;
 
-		inet_proto_csum_replace_by_diff(ptr, skb, to, is_pseudo, false);
+		inet_proto_csum_replace_by_diff(ptr, skb, to, is_pseudo, is_ipv6);
 		break;
 	case 2:
 		inet_proto_csum_replace2(ptr, skb, from, to, is_pseudo);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 552fd633f820..5a5cdb453935 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2035,6 +2035,7 @@ union bpf_attr {
  * 		for updates resulting in a null checksum the value is set to
  * 		**CSUM_MANGLED_0** instead. Flag **BPF_F_PSEUDO_HDR** indicates
  * 		the checksum is to be computed against a pseudo-header.
+ * 		Flag **BPF_F_IPV6** should be set for IPv6 packets.
  *
  * 		This helper works in combination with **bpf_csum_diff**\ (),
  * 		which does not update the checksum in-place, but offers more
@@ -6049,6 +6050,7 @@ enum {
 	BPF_F_PSEUDO_HDR		= (1ULL << 4),
 	BPF_F_MARK_MANGLED_0		= (1ULL << 5),
 	BPF_F_MARK_ENFORCE		= (1ULL << 6),
+	BPF_F_IPV6			= (1ULL << 7),
 };
 
 /* BPF_FUNC_skb_set_tunnel_key and BPF_FUNC_skb_get_tunnel_key flags. */
-- 
2.43.0


