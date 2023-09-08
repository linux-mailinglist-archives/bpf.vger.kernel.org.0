Return-Path: <bpf+bounces-9555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6C7799156
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 23:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E43D8281733
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 21:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4439630FB5;
	Fri,  8 Sep 2023 21:00:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E979030FB1
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 21:00:13 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51485E46
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 14:00:12 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5958487ca15so27071127b3.1
        for <bpf@vger.kernel.org>; Fri, 08 Sep 2023 14:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694206811; x=1694811611; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=norNfSBT5F4z9CQcDn5RrP9YOgJ7ih7oYHT+rCwBRgM=;
        b=PVXvD+4fMbXbn5ShvDirC8omVY7RYq3Wls0M4WKOPtickkd2grkwWzDQuv27jb3+c+
         2xJ0Lms/DV3IvGKwKC187gPCUdVRFH/LneiIwZlyksVmy1rgViuX2eF78QliVMAQup0M
         2YerWXMKp0uzj5rqmgUPIhsB/xTs75euj/IkyNoKlFnHP8AyjMzszNWWhpimjqIVCVko
         4hCXMS2Js0Jh3QX/G/q4Vchs2YN7ArAc3Zdwt7AH1iR0JcgGlm+CeH5ntVHcBPhZYNk6
         y2deVx4hBWxVOnrBSzrteDncgYefnv+0einQDJ7mbK3EcqO611kvffAfsVLbVHiJPC3x
         Rg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694206811; x=1694811611;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=norNfSBT5F4z9CQcDn5RrP9YOgJ7ih7oYHT+rCwBRgM=;
        b=EnRO0TzUTCnByuIhORw2xVGGvF+CBiExEfgI4S72i2XiRIIpFQbAAu3S7+M7LNWkYW
         aJ85hPRSbMs0EuVtR4XqFayMn0gB0UOKHkD8kdDGl3XJypSge+rA6KEvASSBVUNlMY7m
         IpujGxhMXoi+Si4m+wJiaQHKl1CX809cjAzy/wtSAfgfSTBpssU+12rS5FXyy/0FWJw7
         rBY37tXnVNHQGlEs9ROe/aD9PWEJzFI33P4QRJCzLDEXiJ9JP4NfWWk4wG9TJZZp4kFp
         zTOePYZ/70ccRiNu3w6DvxNp4+OAIlKcZSoc6JzYQGD20A/yhRj7xS4H8hYFWhSVndw9
         TAiw==
X-Gm-Message-State: AOJu0YxiyM4JSV+UwsOlFBRvkvAso04bJrcbJ3Ix4PAozIo0VjC2WgX8
	yO6Ryl6LMcCjh3KDFvnq25R0tK4ILJxP2lXTaglEpicADFBKQn+sosIBBmeQmifXbWbBN8kEOJw
	EeVRm6Op72Gd9f0nIGVZIBrvIPLVcfEgtf4WxGUVBeroq0kqJkw==
X-Google-Smtp-Source: AGHT+IHFDfs7XkOIWRQZ7JuZGTXuP9lFnw0MJvmNFUN71qcJGqGN94g0I3SA4WfgxUN2hzGyuU4Hi0I=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:ae1a:0:b0:59b:4e9a:2ac3 with SMTP id
 m26-20020a81ae1a000000b0059b4e9a2ac3mr85875ywh.9.1694206811524; Fri, 08 Sep
 2023 14:00:11 -0700 (PDT)
Date: Fri,  8 Sep 2023 14:00:07 -0700
In-Reply-To: <20230908210007.1469091-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230908210007.1469091-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230908210007.1469091-2-sdf@google.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: update bpf_clone_redirect
 expected return code
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 151e887d8ff9 ("veth: Fixing transmit return status for dropped
packets") started propagating proper NET_XMIT_DROP error into
the caller which means it's now possible to get -ENOBUFS when
calling bpf_clone_redirect() in this particular test. Update the
test to reflect that.

Reported-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/prog_tests/empty_skb.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/empty_skb.c b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
index 3b77d8a422db..b9f5cb312033 100644
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
+			.lwt_egress_ret = -ENOBUFS,
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


