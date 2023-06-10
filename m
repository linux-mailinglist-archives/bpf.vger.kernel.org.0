Return-Path: <bpf+bounces-2338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2601772AD33
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 18:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 432121C20A70
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 16:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6B5261E2;
	Sat, 10 Jun 2023 16:12:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140E4C8F6
	for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 16:12:48 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36744488
	for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 09:12:31 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30e56fc9fd2so2680443f8f.0
        for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 09:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686413528; x=1689005528;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pwYMvVDtDeMxDpan+XQeqhiNTjyJ3BxX8xvun0+4810=;
        b=YLQzMRZ1lO1BQlvkOaAElWb6EEYz7qAiLXE1NJI526f6ZfJlQsCHNnwBD63aNm/EmS
         eH80JouKXGbLHungB+13HYoHRhkqTcGv9EJ0sQdN+Bgtq956IGIqv9Fc/1Gafs7PS+Dc
         +VzcqhrdW0fyCzYCG0juZPpPz2iU1HASKc6CARhlkwo7GYiubdbp/Xo+J66GBXiFbQLI
         sSDKmJiwSmz98SXm65vAdEihbVbJL7oBrO9kbr9JRrVZlha3a0xM1ASubBPHOzywJdU3
         uMhskFgOJe8NtPlHJpdyqsPyXaYGq83RC5Xe1gqhKnGDSp3fhg+TwpIA/+R4MtGYi5ae
         fIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686413528; x=1689005528;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pwYMvVDtDeMxDpan+XQeqhiNTjyJ3BxX8xvun0+4810=;
        b=Hli8oG3CQzRD4N0dFDgHhtA29r1korhTSaOnpA/fKNZH+mZ6ihBhFg01JUOb0/brF9
         RdIygX8rh/N+NE1FxFdNe0u3y12WKOFp7LLrn5NNz0vn20XBMnBTRFgniLARhlnOiqKU
         aF5ix/8dKlJ5k3X0zlOCer8PQX/w7/mBEmYN2jLI7kCkTrvhJiiGjFJuvDHBUO+roBqu
         wW1AHh28xy5AfE9LZitqNcXImPmaSDNYzM5WTtBgMC0iwQWNdPJCrwtMxGUp8bRjS2bf
         1jKE0lbJq8o0wGgnhpq1Zml0VuWoHTfoIL0UZcOwhgcws118TyX3Mh8SUuliNI1gMK5m
         RWbQ==
X-Gm-Message-State: AC+VfDxmLeN+wqKqDMVIEq0jRf2XsQvFV82PYyzcd5ulQG3w+0qmZSVH
	k8hTBGXpw3BPZ7m78mbLGho5Tw==
X-Google-Smtp-Source: ACHHUZ6yqy6/s9krkQFTqNF4ENRu4006HuXc7bosbag+gxCH24WeaXJOz579H6GEDA0cDujFgzri5w==
X-Received: by 2002:adf:f701:0:b0:30a:ea8a:7a6d with SMTP id r1-20020adff701000000b0030aea8a7a6dmr1560264wrp.16.1686413528543;
        Sat, 10 Jun 2023 09:12:08 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id u9-20020a5d4349000000b003079c402762sm7431145wrr.19.2023.06.10.09.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 09:12:08 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Sat, 10 Jun 2023 18:11:52 +0200
Subject: [PATCH net 17/17] selftests: mptcp: join: skip mixed tests if not
 supported
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230609-upstream-net-20230610-mptcp-selftests-support-old-kernels-part-3-v1-17-2896fe2ee8a3@tessares.net>
References: <20230609-upstream-net-20230610-mptcp-selftests-support-old-kernels-part-3-v1-0-2896fe2ee8a3@tessares.net>
In-Reply-To: <20230609-upstream-net-20230610-mptcp-selftests-support-old-kernels-part-3-v1-0-2896fe2ee8a3@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Florian Westphal <fw@strlen.de>, 
 Davide Caratti <dcaratti@redhat.com>, Christoph Paasch <cpaasch@apple.com>, 
 Geliang Tang <geliangtang@gmail.com>, Geliang Tang <geliang.tang@suse.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2834;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=PI3L9ABnerswxTMqx6UTE581B0kBCB3cu6Q+YqONX60=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkhKC/oSOXJtkmjY+HOVFkhrxqwZyGqCtAlqidW
 LDI+5gIZlyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZISgvwAKCRD2t4JPQmmg
 c3IwD/48YMd8rDjzHYVBYD4HEfyc4z5nj3ogAwDh2ngzuk/Mjcow/1HLqoZV/fbF/bAYcUxjZ4K
 UvL0n3qPjbEH1ubK4XWLhgw2csjThEQq1zk9USJQqVqP88tZBQsZuEDxjwlfmkK4g1IJ/VD4UXt
 5XJylV/IVb8qKni3FoidLF0aMtYOjZT7hXbjGsj98yFmpUNLH0H1A8Ng+M3QzIb5ZJCFuzFkdkY
 MtGTJPbQjZxpuu9P0aa1WmydhNbDZar8rNWp0c1NfzNEMv/WIbTY6NuOSUntikgHANbMeAxlKH0
 RvhfZ0n6ra/gQiz1WhEC4Yt4JBVgQBnbWwZQ3JkbvbaNatv4T140Sl/l7O3ETiBmJhF0IfR08mR
 qi+GcDjJLol3L45uWun6IFlNhCilDj7I2gDHgP5K8H8ahxmF/ppMOCY1wFaP+96EX6sIr9GoqLj
 NnHkwMlLcZopqktA2bJMyRQV4EzCM6/xg2Lz56YuqtUtAt6ZhN1fhQZLBDRmoTHYQzZH26/W5rF
 yq7tgYbB8ZKebHXNRZLGqVmsxDz480JmMeT0iEdkg39WVj/tMn5Wok/0q0IV4cAUnoCti3uRRAk
 jyiR4qgkHPuN1rmMSU1PSULgN+hUmUeR5YWAye5ZfXKTY4RTdOdIWkzZHCo0KNznSsAb56CrzMD
 gSvSCkmxAsN7wfA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the support of a mix of subflows in v4 and v6 by the
in-kernel PM introduced by commit b9d69db87fb7 ("mptcp: let the
in-kernel PM use mixed IPv4 and IPv6 addresses").

It looks like there is no external sign we can use to predict the
expected behaviour. Instead of accepting different behaviours and thus
not really checking for the expected behaviour, we are looking here for
a specific kernel version. That's not ideal but it looks better than
removing the test because it cannot support older kernel versions.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: ad3493746ebe ("selftests: mptcp: add test-cases for mixed v4/v6 subflows")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 281581d3c8eb..0ae8cafde439 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2637,7 +2637,8 @@ v4mapped_tests()
 
 mixed_tests()
 {
-	if reset "IPv4 sockets do not use IPv6 addresses"; then
+	if reset "IPv4 sockets do not use IPv6 addresses" &&
+	   continue_if mptcp_lib_kversion_ge 6.3; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
@@ -2646,7 +2647,8 @@ mixed_tests()
 	fi
 
 	# Need an IPv6 mptcp socket to allow subflows of both families
-	if reset "simult IPv4 and IPv6 subflows"; then
+	if reset "simult IPv4 and IPv6 subflows" &&
+	   continue_if mptcp_lib_kversion_ge 6.3; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
@@ -2655,7 +2657,8 @@ mixed_tests()
 	fi
 
 	# cross families subflows will not be created even in fullmesh mode
-	if reset "simult IPv4 and IPv6 subflows, fullmesh 1x1"; then
+	if reset "simult IPv4 and IPv6 subflows, fullmesh 1x1" &&
+	   continue_if mptcp_lib_kversion_ge 6.3; then
 		pm_nl_set_limits $ns1 0 4
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns2 dead:beef:2::2 flags subflow,fullmesh
@@ -2666,7 +2669,8 @@ mixed_tests()
 
 	# fullmesh still tries to create all the possibly subflows with
 	# matching family
-	if reset "simult IPv4 and IPv6 subflows, fullmesh 2x2"; then
+	if reset "simult IPv4 and IPv6 subflows, fullmesh 2x2" &&
+	   continue_if mptcp_lib_kversion_ge 6.3; then
 		pm_nl_set_limits $ns1 0 4
 		pm_nl_set_limits $ns2 2 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal

-- 
2.40.1


