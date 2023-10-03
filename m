Return-Path: <bpf+bounces-11309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D50D7B7242
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 22:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E04BE281C61
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 20:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543503D3AB;
	Tue,  3 Oct 2023 20:05:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087363D991
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 20:05:40 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56022B0
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 13:05:39 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f7d109926so18604307b3.2
        for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 13:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696363538; x=1696968338; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i46mDPbkS444ecqdpl7wlqYw/jPyqLr/xzNOaA+jOp0=;
        b=yedfwImd4NkCYCB1tWcLU21VoV5sJgGI5WK2wfsPuEKxS2gMz2rCMHCLFyuf+e3ndc
         1rb9FMi8Fi/TP+TWDLsTekafz83kN3jR1FJ5wXAI9aMNanrkAByMlQq5cRcW34ooV5Qv
         MXZIKBvXWYwN+rRlktEwFu6NJMpk5P75Nv6SFJ/QSFGH26PUjKGg50Nzi2u10kG5DlAj
         JC2gWoC8Neo8+U1pfZ3sYQG4jh6NJBjSY/GPmbhiP53MtVHjRfn8/gVgyNc747iDwdUv
         BHtERzny1GORlQMcC81Q5fdwe5D1pVzIOghWBk1SosGsIxIkLSwZTElcAmtU/toUhXrJ
         HE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696363538; x=1696968338;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i46mDPbkS444ecqdpl7wlqYw/jPyqLr/xzNOaA+jOp0=;
        b=cLl/OTTNk2v3YA4uKOEocclFPPF8RCohEaSGU9m96LcaNhzBR73tBWWHRyERf/elnO
         DWmTLl+70vXJ8yJI1kIGs4+EiayPNg7XGUrrux//VEzphnjtNDumERKQkA15PnNlL3Mx
         X1LmQyT+duSxctQ9s1yTGhZUNsO1HdH65yzqKcburRzU50YlRoTW+HRvLxrXkmr/xhfb
         j/PSC1IgVXXLjA6fmQlTjWlLwMTQMorSMfEeh2C/qXi6ojV3iNR50TbDlIcEhP7CzMhg
         2EqiUIRLVsx2f7yA/FxSKSJv82+yOODq7nGcfoz70/tauzeddRPYdSAF5Q6bjI71Mu1h
         +EhQ==
X-Gm-Message-State: AOJu0YxWqfXZVrrqey7R7Siy8pJCc91z5jq5wfNx988k02UwmIriEfGU
	SsZZuVAcn1RzI6PUiobwXoP8Rxkio7GILF6h26HevoJU5gbGPLqDn9nWPalVVKkc49atpkHvtVJ
	r3G6sJcLnxAScaar1sQb15lZdnCOzTlhNzFxyneCl62gaNaXOHg==
X-Google-Smtp-Source: AGHT+IGvz5XH8tMQAIcRbgTpu83PYPgI1FfIBafasTRbUK4Y+pHcK8ImXgPrHYlzONMcQsDRhxaRCvQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:441c:0:b0:59b:ec33:ec6c with SMTP id
 r28-20020a81441c000000b0059bec33ec6cmr9223ywa.9.1696363538214; Tue, 03 Oct
 2023 13:05:38 -0700 (PDT)
Date: Tue,  3 Oct 2023 13:05:19 -0700
In-Reply-To: <20231003200522.1914523-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231003200522.1914523-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231003200522.1914523-8-sdf@google.com>
Subject: [PATCH bpf-next v3 07/10] selftests/bpf: Add csum helpers
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
index 5eccc67d1a99..654a854c9fb2 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -70,4 +70,47 @@ struct nstoken;
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
2.42.0.582.g8ccd20d70d-goog


