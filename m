Return-Path: <bpf+bounces-5778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D447D760381
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 02:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106261C20D2A
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 00:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170C8154B7;
	Tue, 25 Jul 2023 00:00:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C1D156DF
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 00:00:12 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC821732
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 17:00:11 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5734d919156so49071477b3.3
        for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 17:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690243211; x=1690848011;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j0xCHxAGKShVCxci31z5oM/FwnvfCpkAI53IOFmhMP4=;
        b=iEUUWQTZEiKO/M6CzAyb7NJ1+iN4XGynsPwh213pq4B1/X4QekZtkIplANkA4Ws4EL
         7oX9jnWsgMXtdyFoRe77XuoUGClQceYg03IB2ESt88lxzMt8xOy2a56LAOSmfSypwr4w
         rRsqOq0ziPWbMDQF9J3iHRieHYNbPkkNqq/hoazKVzevlLV52hoONAr9TQ3lRAa7HFJA
         stUn6AWKB0CbOVUmEejhKGy/rpyWgx3ZeDcYq4zQcdAD693bUrs26CzbfS9Mv4jMGPMr
         7ApjMaecLegto10DRwvAC5RNo+1lTD/SlRRytkOGewHUrRkvvKoees2S19GaHmt1LvQL
         Aayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690243211; x=1690848011;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j0xCHxAGKShVCxci31z5oM/FwnvfCpkAI53IOFmhMP4=;
        b=c6IZlaGVe90dtaK/d0+Lj0ZuhsZA0ARO3T4iTcdjNNIcA1mBmbtPizNQNuV5xtoWwt
         UnjE//j02fHi9qP9VE1Ze9mdJIO+HIje5UXhqUdXueke+tAKEAkafvvtnjEF0aNjsU+B
         rFdZxIg3rdGF8d/VF02haujqh2A21T4rwakXV0Xa2Hnsh2vsVSjJMzcAYFxL5v9BLIyw
         q0bobhcvtG9SKJmpQ3C2CfGntQqWatuNOmsmHLfM6B6D/CqdnWepJj8P4rkCuBSZ5Tgr
         j++tn449w/EXm9+zBKWc7bVfUCBtaCh86jBFMj+urQ78ENAELx6zJssq1EYM75GCggVx
         UUyg==
X-Gm-Message-State: ABy/qLYVZ8ZXDD9H+f2Ux53IDkF8nCfaxUmn5mU72ehRIkkbwpUp21QV
	CSXx6jQp1/5+d92k8ibtyc0u7PjHCLfFIyI59s2wkZVd3h6WPWqbd9+qfg7/9w9OTbXfgFNeHGV
	qEkcnZW5IQzXNFEJYOHHDYdIv0MyICzoPgj9iI/akz2jtJTlG5g==
X-Google-Smtp-Source: APBJJlEgxr/axKa6jbuffaWm0GOh8TggDPXk67nc+YfYvbSh3OyokwhpRZY+YAjRzvWJ2vov0tNpeGY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:af21:0:b0:56c:e585:8b17 with SMTP id
 n33-20020a81af21000000b0056ce5858b17mr75742ywh.5.1690243210706; Mon, 24 Jul
 2023 17:00:10 -0700 (PDT)
Date: Mon, 24 Jul 2023 16:59:55 -0700
In-Reply-To: <20230724235957.1953861-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230724235957.1953861-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230724235957.1953861-7-sdf@google.com>
Subject: [RFC net-next v4 6/8] selftests/bpf: Add csum helpers
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
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
index 694185644da6..d749757a36a3 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -67,4 +67,47 @@ struct nstoken;
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
2.41.0.487.g6d72f3e995-goog


