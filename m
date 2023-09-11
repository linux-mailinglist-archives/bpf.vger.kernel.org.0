Return-Path: <bpf+bounces-9686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A52C679AB18
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 21:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60153281282
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 19:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E670815AE3;
	Mon, 11 Sep 2023 19:47:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B745B15ADC
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 19:47:37 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068E31A5
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 12:47:36 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-573e1a0b355so4083856a12.3
        for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 12:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694461655; x=1695066455; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3nwjio3YybUJeFLtCV5ZO4JKsSFTYsVB9hRkJd1lzqk=;
        b=dgg3afw/1QkxE1RVWk0lM/LY1TuXkdpuVddNbydj+7ZzMPkMH0KlzViY+paVsKwUYu
         PILOVD6OIpWe596VAjDHffafVBidEaqmXhIsdp1ZXbLAqpDKdQ4eQuibGrtmk+Nt/uaW
         P+yUTmKiWScjvdtkV6OMNWpgqMR3KAIxaP9YikO9ckvh+yPU5gsv5NhT03FjQWkhavZs
         RF9J9n4OHcUrqQI/VcqH39pkkNiKbSKGOwShOzkHcBmYtvtnxQkyNwhqixN8QthsA9fO
         T+QgAdhzIV0koFu2qMY+AYGw2UaR6YHMbEefAuzpp4UsT3oXQ34N1oge5CrJ4Ghd3nXt
         DkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694461655; x=1695066455;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3nwjio3YybUJeFLtCV5ZO4JKsSFTYsVB9hRkJd1lzqk=;
        b=w76ghg0iFsw0wcBiiV2a/UC6d6vefvNTvMhzAohpaL1WlC0EDhthSDcqzmSXIAypBr
         k0R9kcrIKJbKFKozXG2m2Pz6w68NOWaStqRTOMEmj1x2BO7l0Cl5gD09QHJS4TbBOfxk
         ScVadJhx++V87uL+bp0ZBs6Y8z/EDvCfcj0C+iSvnr4vS4WIA8WeP8rQ0iHg5ahNLUD2
         NsrLfRcfmdwvCyxQRJgSqbIpAQdgOZA3rfHfM/8T/VWoB5l50SOAKW1ZjjsMLryREeoc
         4dpRAW1brmzzroGQXF1fC8efcX7J9Uc/Z4s5Ge/0O/wZF31XCXcTjMSSfoeB4KwsH/g9
         ZY3A==
X-Gm-Message-State: AOJu0Ywzq3BtQeV6K1LGl7bUigd3YlgvUsUOGAV7yFwmcIYmcQBoa/XY
	xNr3KRpEz6c9HQ9hVYJun+60cuUxlccMzf9Vvgq3ImSNV26CMnGN3156XJRwcdEy8cdwNigBxwx
	d9dOXG/pZJ0SeFmlxShRGGh8Z4HJGQKde5Z12QTVyBLY7JeD2GA==
X-Google-Smtp-Source: AGHT+IFI8UUyhgmxhhm35m8hXDn2zLPuLjoTTCihRdPXEaOUfB/PkSHH+1Th77LKnTcPSjCHjGkaGrI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:3d49:0:b0:574:57d:7c14 with SMTP id
 k70-20020a633d49000000b00574057d7c14mr2258348pga.2.1694461655365; Mon, 11 Sep
 2023 12:47:35 -0700 (PDT)
Date: Mon, 11 Sep 2023 12:47:31 -0700
In-Reply-To: <20230911194731.286342-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230911194731.286342-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230911194731.286342-2-sdf@google.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: update bpf_clone_redirect
 expected return code
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 151e887d8ff9 ("veth: Fixing transmit return status for dropped
packets") started propagating proper NET_XMIT_DROP error to
the caller which means it's now possible to get positive error code
when calling bpf_clone_redirect() in this particular test. Update the
test to reflect that.

Reported-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/prog_tests/empty_skb.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/empty_skb.c b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
index 3b77d8a422db..261228eb68e8 100644
--- a/tools/testing/selftests/bpf/prog_tests/empty_skb.c
+++ b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
@@ -24,6 +24,7 @@ void test_empty_skb(void)
 		int *ifindex;
 		int err;
 		int ret;
+		int lwt_egress_ret; /* expected retval at lwt/egress */
 		bool success_on_tc;
 	} tests[] = {
 		/* Empty packets are always rejected. */
@@ -57,6 +58,7 @@ void test_empty_skb(void)
 			.data_size_in = sizeof(eth_hlen),
 			.ifindex = &veth_ifindex,
 			.ret = -ERANGE,
+			.lwt_egress_ret = -ERANGE,
 			.success_on_tc = true,
 		},
 		{
@@ -70,6 +72,7 @@ void test_empty_skb(void)
 			.data_size_in = sizeof(eth_hlen),
 			.ifindex = &ipip_ifindex,
 			.ret = -ERANGE,
+			.lwt_egress_ret = -ERANGE,
 		},
 
 		/* ETH_HLEN+1-sized packet should be redirected. */
@@ -79,6 +82,7 @@ void test_empty_skb(void)
 			.data_in = eth_hlen_pp,
 			.data_size_in = sizeof(eth_hlen_pp),
 			.ifindex = &veth_ifindex,
+			.lwt_egress_ret = 1, /* veth_xmit NET_XMIT_DROP */
 		},
 		{
 			.msg = "ipip ETH_HLEN+1 packet ingress",
@@ -108,8 +112,12 @@ void test_empty_skb(void)
 
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
 		bpf_object__for_each_program(prog, bpf_obj->obj) {
-			char buf[128];
+			bool at_egress = strstr(bpf_program__name(prog), "egress") != NULL;
 			bool at_tc = !strncmp(bpf_program__section_name(prog), "tc", 2);
+			int expected_ret;
+			char buf[128];
+
+			expected_ret = at_egress && !at_tc ? tests[i].lwt_egress_ret : tests[i].ret;
 
 			tattr.data_in = tests[i].data_in;
 			tattr.data_size_in = tests[i].data_size_in;
@@ -128,7 +136,7 @@ void test_empty_skb(void)
 			if (at_tc && tests[i].success_on_tc)
 				ASSERT_GE(bpf_obj->bss->ret, 0, buf);
 			else
-				ASSERT_EQ(bpf_obj->bss->ret, tests[i].ret, buf);
+				ASSERT_EQ(bpf_obj->bss->ret, expected_ret, buf);
 		}
 	}
 
-- 
2.42.0.283.g2d96d420d3-goog


