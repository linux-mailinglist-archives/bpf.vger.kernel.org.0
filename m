Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1C769E6CE
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 19:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjBUSFj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 13:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjBUSFi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 13:05:38 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6223C23300
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 10:05:20 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id q68-20020a632a47000000b004f74bc0c71fso1698637pgq.18
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 10:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JcHWxZkDLG8XUyiySDcL8tK+NfRaOXui97wD6jankdE=;
        b=s+eejRNd0c/PTlEc/1UsQIfirjcY11RxVM8STGP4h3g+R1vbUs8KBI2p9DKZEhTFMo
         f2gsjmgsYEAbAMCGJV0kFZDfQ20HaUVrRWVd1/Lot+9y5Cys1h+NHsFsDbj2PIaUsB5/
         tPTQmVi3u4Cyi8Tth4SKR25pdIwLAtX3n9lQOGG3PcLKEJHiBNBvbuJ8fobWCtUCzaef
         rQKPI64sKTSt8V4r3X5y2jOBFgwmBOWbgzmQJXgYVccjBOnNJaZ6ox3zEMZSUfG2jZof
         CLNhdJhov+3wEWd801PP0E0vLGUyKirGPB3aD2pW+YFlM6puhKurktNSvYFqhynNHP0S
         hhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JcHWxZkDLG8XUyiySDcL8tK+NfRaOXui97wD6jankdE=;
        b=od0thtk/qm4PqDihCwa0TFatfSbdwAPC24alfS28yODOXk88B4rNz4XNAbl6MiOSoa
         xv/Ec7p0wboIjnokawncZn+eM/GMIAsqV5YrGXJcglXtK/fEaiKJeMVl5rZI/gtm0D2M
         3zv88Ow/wGTVGM+vcw2c0g4OI2dQkMs+zUvdoliXmuG6lX996x+xsrlM1UroT+MHRvza
         j1T3x/RBMByGYtBUHsB7EPCnODpEcz/xe9G6Ek5DisyBhMbU2bJV7xABrkDPGHASq/Ll
         WXt2bOglLBJZs/fbWE4yPdvSoVQ7JojfijPoyl2n6oFEWzmqaZnY87p56M/+w/gzL3EU
         QVQA==
X-Gm-Message-State: AO0yUKWEpUcQdmnRqvjULJmBdSn74ap86SX4E/aXpXDmwa6rYM9eB2+x
        xUG53BQMG6tH7sC/PLiZtjPHhJ5PQeEcdSj1v09JZIifJRDM9Uczi44Brr40J7rMTH0FcvbUeM4
        n5lLQNR7/7cblGD+jlRNrkq240MDNsUnvaRWqsR9Epta/UeoSog==
X-Google-Smtp-Source: AK7set//w5TJznK2K8ganyXtBPm2FkMiBz8dV/ugdOHe3QGmLtqxXetIQiD/HvcMEG2i44wKu4JsBFI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:38c8:b0:230:8730:c1f7 with SMTP id
 nn8-20020a17090b38c800b002308730c1f7mr1526290pjb.27.1677002719742; Tue, 21
 Feb 2023 10:05:19 -0800 (PST)
Date:   Tue, 21 Feb 2023 10:05:18 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230221180518.2139026-1-sdf@google.com>
Subject: [PATCH bpf-next] selftests/bpf: Fix BPF_FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL
 for empty flow label
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kernel's flow dissector continues to parse the packet when
the (optional) IPv6 flow label is empty even when instructed
to stop (via BPF_FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL). Do
the same in our reference BPF reimplementation.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/flow_dissector.c | 24 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_flow.c  |  2 +-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index 7acca37a3d2b..c4773173a4e4 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -345,6 +345,30 @@ struct test tests[] = {
 		.flags = BPF_FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL,
 		.retval = BPF_OK,
 	},
+	{
+		.name = "ipv6-empty-flow-label",
+		.pkt.ipv6 = {
+			.eth.h_proto = __bpf_constant_htons(ETH_P_IPV6),
+			.iph.nexthdr = IPPROTO_TCP,
+			.iph.payload_len = __bpf_constant_htons(MAGIC_BYTES),
+			.iph.flow_lbl = { 0x00, 0x00, 0x00 },
+			.tcp.doff = 5,
+			.tcp.source = 80,
+			.tcp.dest = 8080,
+		},
+		.keys = {
+			.flags = BPF_FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL,
+			.nhoff = ETH_HLEN,
+			.thoff = ETH_HLEN + sizeof(struct ipv6hdr),
+			.addr_proto = ETH_P_IPV6,
+			.ip_proto = IPPROTO_TCP,
+			.n_proto = __bpf_constant_htons(ETH_P_IPV6),
+			.sport = 80,
+			.dport = 8080,
+		},
+		.flags = BPF_FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL,
+		.retval = BPF_OK,
+	},
 	{
 		.name = "ipip-encap",
 		.pkt.ipip = {
diff --git a/tools/testing/selftests/bpf/progs/bpf_flow.c b/tools/testing/selftests/bpf/progs/bpf_flow.c
index a20c5ed5e454..b04e092fac94 100644
--- a/tools/testing/selftests/bpf/progs/bpf_flow.c
+++ b/tools/testing/selftests/bpf/progs/bpf_flow.c
@@ -337,7 +337,7 @@ PROG(IPV6)(struct __sk_buff *skb)
 	keys->ip_proto = ip6h->nexthdr;
 	keys->flow_label = ip6_flowlabel(ip6h);
 
-	if (keys->flags & BPF_FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL)
+	if (keys->flow_label && keys->flags & BPF_FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL)
 		return export_flow_keys(keys, BPF_OK);
 
 	return parse_ipv6_proto(skb, ip6h->nexthdr);
-- 
2.39.2.637.g21b0678d19-goog

