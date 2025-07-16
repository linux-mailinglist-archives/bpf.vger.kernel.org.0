Return-Path: <bpf+bounces-63454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC51B07AF1
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 18:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC4325622E0
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 16:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834712F5C48;
	Wed, 16 Jul 2025 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="KGN5DK/E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF7F2F50BD
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682676; cv=none; b=ps+dYXRWtmKNQEeT5IeDxKNn80qcohbjKUflts0TxK6KZZWOzIeFv/sakvvCzvhXDf+fxvXSB9JaXJkZ37EFFYK7V8323k/NSp+rIsYpehdL9nzUQZ5PUWstd6KR8q25joaATgzHPMfdA5uaEpdJ2dD5sbN+GWBgXHmoedbq21Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682676; c=relaxed/simple;
	bh=JFIPahAiD0S7HsBpke/RZEbMLXbwVGk2s1FtL6LTWAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UUZWi3wLAj2gXtRvT0yLdTOcr/fK3Kj0KsslRSFl1YnuwFAs2I3EPw1gJYnGEJDob8l/nOjnHhlFAc0efRaBLRiIn4iyg6CuDyEcpK+L8PNEHUKNY8KEMS9k7DO1M0/iEDcR/U2vDy2TEkfEYp53Zr1Wbamd08vTsyHxRyJqCZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=KGN5DK/E; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-32b43c5c04fso10539461fa.0
        for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 09:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1752682673; x=1753287473; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mpc9897NG2ftoPu05usDVcGrykyyCose3qXOwJWywwI=;
        b=KGN5DK/EtkoeZBtDyy8FCwohoC9HIiFBcpZM73ikqGbvvpzTKgv8PgPXt6SdTOYnKP
         TOecHZLr6TiXc1q3Zo9A7GI/vSyjbejTDhFYW6INGKbqxSOFYgv2ML4heWSZn2n9VoMR
         4cvj4TZK91AOO011ZO0zZkGA0tMSxVD6tIGKERuRcmUDUVbAiBW/A2bWMGyMubroiJkQ
         FHhYi4i6T1PqM+EsBnABL51war6hYTeHpM5Ilc7djAgwGbU4r0OFfFZaTENFL76OhzO5
         4xMn6eWCrVOYGZ/RN6Vou8RSUT7TXCs0tvpjsh1fzO37LWUzviI4ei8Qn54bL9lhupMu
         +0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752682673; x=1753287473;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mpc9897NG2ftoPu05usDVcGrykyyCose3qXOwJWywwI=;
        b=NCIWsADqUROuyX1Dq4nLf/6CaqLwIr2Ch2AHHmGRs1xNWlZThTG+Pjon+X0Rf6fcoQ
         PSK5pTUiNL4bws3qwc7AZnfoCe+ybQ6WxPN1dSy43lzXRMjtiyW9S2H0UvKJtb26J7Bx
         c1HkNJ3Vx3z8XZsZWte4800rEvkPUvNfT/WvQaYwD2rt0+Qe7F4oXBwOmi675MjsxjWO
         h9hq6RXdJQtmX+/eVu83h1WcXmlO74JAYjJFtA83bAW/tmpcw4h+f5fuA/7IS+iKbjWk
         gEwJhEWVKuw67KehiuwKJOcxD5FBA1FUMcHWhqYYwXAdtEuH/slTcUTqfQCfo43wSpDx
         PUMg==
X-Gm-Message-State: AOJu0Ywj5CIGA+ojDMAcdrtSwACV7vDv46EpcRTJq2GiuzKH/BnIUv2q
	wFzuV75/WBw+3CeiBgQIlyHt/ePmJ9i+YWJOee4ddS2ZvXPNxTdA0oAXGYjoAZg68lc=
X-Gm-Gg: ASbGnctpZgV810K85jX4Rf4Hg1EiqPHLIhX+nj4gEpAA8qycDO/WZkCveE2qfYxj285
	WOOYiDL+cMXtQhUeDu5cJZOjxYq0n3iSSogkvgwAC/IH4sPz9l2jrxx7/ygfxQ8IsSqL8W7RZ2W
	5tJMwFcqDdYhHjraMP0RLckwAFGp2cTammm3kbzhndfZP2BGYkBpogJ6L13fK3+UY8wWHhjl2Ov
	WfXz15FvTkRTcJG7k0Ctv/k0RFV3bVNdTyGDg1JxHnOw0jfT7V/rUwZwTcMPKWIKznf8fjqP5Ht
	MUpaPRiT6RtP6TmoLoLhTHCL0ZGi+iSJByU7i+XbC1vU2/y8GO1I6cp2TAS2Bbzq37Wj+GWvW3c
	5ua+RL+UlpgCPpq57mfovf6P78hdUolChW82m25nzo65V9rOnSiYPRYqzeDEtgSrZXoJc
X-Google-Smtp-Source: AGHT+IG5fHYm5DfMrn0ILUmvEuxKl6DoA5SDDt0HM3v0vmT5V6a7U33fuwM+eoxZlI8cr8trjwANLw==
X-Received: by 2002:a2e:9950:0:b0:32a:82d7:6d63 with SMTP id 38308e7fff4ca-33098baeb31mr106681fa.12.1752682672507;
        Wed, 16 Jul 2025 09:17:52 -0700 (PDT)
Received: from cloudflare.com (79.184.150.73.ipv4.supernova.orange.pl. [79.184.150.73])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fab8ede38sm22547371fa.87.2025.07.16.09.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 09:17:50 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 16 Jul 2025 18:16:47 +0200
Subject: [PATCH bpf-next v2 03/13] bpf: Enable write access to skb metadata
 with bpf_dynptr_write
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-skb-metadata-thru-dynptr-v2-3-5f580447e1df@cloudflare.com>
References: <20250716-skb-metadata-thru-dynptr-v2-0-5f580447e1df@cloudflare.com>
In-Reply-To: <20250716-skb-metadata-thru-dynptr-v2-0-5f580447e1df@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, kernel-team@cloudflare.com, 
 netdev@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

Make it possible to write to skb metadata area using the
bpf_dynptr_write() BPF helper.

This prepares ground for access to skb metadata from all BPF hooks
which operate on __sk_buff context.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/filter.h |  8 ++++++++
 kernel/bpf/helpers.c   |  2 +-
 net/core/filter.c      | 12 ++++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index de0d1ce34f0d..7709e30ce2bb 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1774,6 +1774,8 @@ void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off,
 		      void *buf, unsigned long len, bool flush);
 int bpf_skb_meta_load_bytes(const struct sk_buff *src, u32 offset,
 			    void *dst, u32 len);
+int bpf_skb_meta_store_bytes(struct sk_buff *dst, u32 offset,
+			     const void *src, u32 len);
 #else /* CONFIG_NET */
 static inline int __bpf_skb_load_bytes(const struct sk_buff *skb, u32 offset,
 				       void *to, u32 len)
@@ -1814,6 +1816,12 @@ static inline int bpf_skb_meta_load_bytes(const struct sk_buff *src, u32 offset,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int bpf_skb_meta_store_bytes(struct sk_buff *dst, u32 offset,
+					   const void *src, u32 len)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_NET */
 
 #endif /* __LINUX_FILTER_H__ */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 54b0e8dd747e..a264a6a3b4e4 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1834,7 +1834,7 @@ int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset, void *src,
 			return -EINVAL;
 		return __bpf_xdp_store_bytes(dst->data, dst->offset + offset, src, len);
 	case BPF_DYNPTR_TYPE_SKB_META:
-		return -EOPNOTSUPP; /* not implemented */
+		return bpf_skb_meta_store_bytes(dst->data, dst->offset + offset, src, len);
 	default:
 		WARN_ONCE(true, "bpf_dynptr_write: unknown dynptr type %d\n", type);
 		return -EFAULT;
diff --git a/net/core/filter.c b/net/core/filter.c
index 93524839a49f..86b1572e8424 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11990,6 +11990,18 @@ int bpf_skb_meta_load_bytes(const struct sk_buff *skb, u32 offset,
 	return 0;
 }
 
+int bpf_skb_meta_store_bytes(struct sk_buff *dst, u32 offset,
+			     const void *src, u32 len)
+{
+	u32 meta_len = skb_metadata_len(dst);
+
+	if (len > meta_len || offset > meta_len - len)
+		return -E2BIG; /* out of bounds */
+
+	memmove(skb_metadata_end(dst) - meta_len + offset, src, len);
+	return 0;
+}
+
 static int dynptr_from_skb_meta(struct __sk_buff *skb_, u64 flags,
 				struct bpf_dynptr *ptr_, bool rdonly)
 {

-- 
2.43.0


