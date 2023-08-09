Return-Path: <bpf+bounces-7391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B55B7765BE
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 18:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D98432816CD
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 16:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFFF1DA5F;
	Wed,  9 Aug 2023 16:54:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B231D30D
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 16:54:33 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5083A1BFE
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 09:54:32 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-56463e0340cso104640a12.2
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 09:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691600072; x=1692204872;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tPNCL2h2Yk0iVM2TXMAyw8lteKar2ayTQ5gnI+CrlwY=;
        b=GicCoH9oxpAap2NbclDS+ijO8buo3MYC+WBOhdHvZWEGNWxoSjHEFY8e8/K8gbgHy4
         snYETT/pzh2iJ6GygT/K3hMwG621KGphqH/njC4rtPxFsKivW4TaHksAgcsJJi02TNJD
         I2sguxYimENc2zRlmF264uNrtCAYNXRmMR6/nsOGBKG0KkItmyo659GTiWFoGx09ffT7
         CWVGrrzxFzjhUTffXVkEncnxbXCZCjQXO1azrzK+NnQOjFHRNY1Sv5WUnzO5TNitqQbc
         aSMboJkb/AGjLQ8rLvYY+q5RbCcG0ZOKrGBWXEGd3MtJyIwfeNBEkRCzni7PuhaNz9vB
         5ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691600072; x=1692204872;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tPNCL2h2Yk0iVM2TXMAyw8lteKar2ayTQ5gnI+CrlwY=;
        b=WgnKxRqpyRfTMCK383/AT8blK5+PCiZWedPzia4EM6aKYnf8keRpn8VMeljloMauE8
         hn9ZRLcNRZ4Oe6LDjoUjkYbOryxIZGrfEgSMQdqbCoo1JS8XfCOdC8NdEiIyWHk4/wOb
         7ePG2bb/g+SiE3neRjpgpsc+jwm6Ux6uPjoxyag3O0NlHdCLOsDv18cPzQGvvO5St2uO
         0r41mfvHB5588s/sE50KQJHyCXPWGfI/yzj/XEj0C8q4f/vQqkYrcFoqQLM2kjMGJcdw
         CdVFl+YozDysioFz0T3Od+9HaJzc1GDDdATjapqblMBUr652GESvG0vbs5oyvpM9vkNK
         zovw==
X-Gm-Message-State: AOJu0YzuAySPAm+3cDfjC6UzBplvumZ4DASUqyuxHZ4z48/S2KQuU9FS
	iT23j7OLVydkrtoCFc76+Bf8ke1vK7ShKEUlr/e8sStXHhWQ0u2TRXmG/Q4KbAsrBteCL4QM/HR
	7zxbWZj64yqHlJa48gV/CL7VdI+QvxpKWJD2O7OkcjA/eQUnaOw==
X-Google-Smtp-Source: AGHT+IEQ7jDbp63pxepzuS37WQVUvH0F8J/jIFOfJDxRIhRIMXfGCPUxrcw+7XNUyKR4ZuJcrc2C/N4=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:3dc3:0:b0:53f:f4ca:1b0 with SMTP id
 k186-20020a633dc3000000b0053ff4ca01b0mr294649pga.9.1691600071807; Wed, 09 Aug
 2023 09:54:31 -0700 (PDT)
Date: Wed,  9 Aug 2023 09:54:15 -0700
In-Reply-To: <20230809165418.2831456-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230809165418.2831456-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230809165418.2831456-7-sdf@google.com>
Subject: [PATCH bpf-next 6/9] selftests/bpf: Add csum helpers
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, netdev@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
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
2.41.0.640.ga95def55d0-goog


