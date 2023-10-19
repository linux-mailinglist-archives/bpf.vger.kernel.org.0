Return-Path: <bpf+bounces-12717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CC87D00EC
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 19:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2288282213
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 17:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3313B37CA5;
	Thu, 19 Oct 2023 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sozcOd+g"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF8738DE1
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 17:50:02 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E3812A
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 10:50:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9ab79816a9so10956498276.3
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 10:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697737799; x=1698342599; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wrMWyFZARXAbpMZ2Cvd01jTOzKURZkdFORFzsP3Nbog=;
        b=sozcOd+gm7+oWQr4Pdeaz4CG1/tv3av3wtbcpxuM5G7nEl21faL49eNShlaLa+XaQ3
         kPUkqLa+w0CdobN/ofrRTuhqk0p9Vk5qrimkGrof+i5dUAGSRmPaErC8hq6/LeKMzPRe
         7ov7dJbtmiD58M5d/MPhlyYpra5EunyHJKr4GCI6xKAmMk5dDqM8igMLucFPEkk5tutS
         qYPtJ1OzKdIQ3z00qWuHJx2/4VVXUfrn1QMmHmVO6TN+qI2M4ZR7CB8TpWKAUZBcadCV
         nH9BQQzTaUp7wqbBe3UGwo5jscS4BYOB11ElcslKXGHCA3psqjTyYlMNJAvQHhaDJONw
         VRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697737799; x=1698342599;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wrMWyFZARXAbpMZ2Cvd01jTOzKURZkdFORFzsP3Nbog=;
        b=a7t4F6+/WyYFcZe8GAAJupCr6lRQelO+QH7am3os6UOLV0IPQhX7Jc7z6IbUqnq5K+
         JKg+ZJRbuK9HqfCGqb8WPrgJRXIqGHmhGPAJGicrMojaXKGlRCMWbLO06X8WPoirsOUt
         hqNObT3PiZ2ZklGGtOR85+vCUZPYqbf/xnEZYFkFZiUuWzSwtg8ODLQmTladE/jTY1bP
         s0yX988S1BMUX3GQwZ9fhV1bhOthl9mfcqEX0JIN0CM5eaPilGvc4YRuF2kkeR35oAno
         KjzBHnY/bgMdHc/60klnXmgZlzK4wqlMavxKftzM+wUsr8vZqs3Kur/WZ9lYvybeMSAt
         9/Kw==
X-Gm-Message-State: AOJu0YzGvTOamciW1ZYclCxsMzj71yURroi7rePRcZyOfl+/mTrx1eh6
	+UYk/bPZtjNh2ztkfSZQ+YqGYqfk68IFw4SPNPJbYfBWNNcaWR+5pfse7MlHFKmlV/uFbl+48aR
	tKeqsZ1CUiuiDkaZvY0IynYXEYc48LofyqZeAhhmmlLgfKi3Wtw==
X-Google-Smtp-Source: AGHT+IHxAHuZty9GGyTtLqkmEaq6ArCG74wlQJWAeDJOpo/lmMbANhh3Wg7LQS1zGZMT2E0QcNDyIUs=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:2683:0:b0:d9a:519f:d0e6 with SMTP id
 m125-20020a252683000000b00d9a519fd0e6mr64878ybm.6.1697737798751; Thu, 19 Oct
 2023 10:49:58 -0700 (PDT)
Date: Thu, 19 Oct 2023 10:49:40 -0700
In-Reply-To: <20231019174944.3376335-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231019174944.3376335-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231019174944.3376335-8-sdf@google.com>
Subject: [PATCH bpf-next v4 07/11] selftests/bpf: Add csum helpers
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"

Checksum helpers will be used to calculate pseudo-header checksum in
AF_XDP metadata selftests.

The helpers are mirroring existing kernel ones:
- csum_tcpudp_magic : IPv4 pseudo header csum
- csum_ipv6_magic : IPv6 pseudo header csum
- csum_fold : fold csum and do one's complement

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/network_helpers.h | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 34f1200a781b..94b9be24e39b 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -71,4 +71,47 @@ struct nstoken;
  */
 struct nstoken *open_netns(const char *name);
 void close_netns(struct nstoken *token);
+
+static __u16 csum_fold(__u32 csum)
+{
+	csum = (csum & 0xffff) + (csum >> 16);
+	csum = (csum & 0xffff) + (csum >> 16);
+
+	return (__u16)~csum;
+}
+
+static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
+					__u32 len, __u8 proto,
+					__wsum csum)
+{
+	__u64 s = csum;
+
+	s += (__u32)saddr;
+	s += (__u32)daddr;
+	s += htons(proto + len);
+	s = (s & 0xffffffff) + (s >> 32);
+	s = (s & 0xffffffff) + (s >> 32);
+
+	return csum_fold((__u32)s);
+}
+
+static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
+				      const struct in6_addr *daddr,
+					__u32 len, __u8 proto,
+					__wsum csum)
+{
+	__u64 s = csum;
+	int i;
+
+	for (i = 0; i < 4; i++)
+		s += (__u32)saddr->s6_addr32[i];
+	for (i = 0; i < 4; i++)
+		s += (__u32)daddr->s6_addr32[i];
+	s += htons(proto + len);
+	s = (s & 0xffffffff) + (s >> 32);
+	s = (s & 0xffffffff) + (s >> 32);
+
+	return csum_fold((__u32)s);
+}
+
 #endif
-- 
2.42.0.655.g421f12c284-goog


