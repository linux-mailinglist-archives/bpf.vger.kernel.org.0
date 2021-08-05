Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E033E0DAF
	for <lists+bpf@lfdr.de>; Thu,  5 Aug 2021 07:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237668AbhHEFOq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Aug 2021 01:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237686AbhHEFOk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Aug 2021 01:14:40 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8467FC06179A
        for <bpf@vger.kernel.org>; Wed,  4 Aug 2021 22:14:21 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id cl16-20020a17090af690b02901782c35c4ccso3157323pjb.5
        for <bpf@vger.kernel.org>; Wed, 04 Aug 2021 22:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9iqwgQUcM7kXjxKmNPoKYxMsXr+XLcOB8+pWCUZkNe8=;
        b=RbpJzx+BoK8RbyOspFM+n29W5JH0aaCLGjko+2aoqRhjPFUM4R6/71EkAOhUPIp54h
         6/KUb2shwI6HSqMwRcFwsJOezU9+mA05bVf//hYKutCXxfA5Y1zXGcF/ZSoYJAvFzX7B
         tpCCbQC8YNWQamkT69AYaJ7+rX2cu626mDpfumFsOjquW7ytN4o5zo6SDPiVHneAphmz
         7sr2Rijb7Vuk2pkmMoj4ojrFlnN+LBUi8EafRwqdB9wrq3ci/9F0L4rhpYQkHHqt8j+N
         vv6ouIdmsMv5OGbjpAZkuUoVwdzVVJ4XN72JbUi9FwRZ3KpNGhHkmEOTksXjQ/riRbnh
         mQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9iqwgQUcM7kXjxKmNPoKYxMsXr+XLcOB8+pWCUZkNe8=;
        b=GmdcC6bKFFcr9OanasXomtT0zhqrskHWay1IzNh3VbnjvhsDGDKdl/K26dhkNipqQk
         56L8t8piXy9JftKbzvf5TQhPXBFgsuWBk0qAH2SFY/BUQyOhUiEZf1BgxdzYKvOEQixo
         R5VZvIbuRyaT59QfGAwzNQ8rrJShGx+K6jCEOSypzXq7MGb9JjYcUiEoQel0WKXou2K9
         xjdD7qm2HtNHtWx4sgKUtYWszTGRH/JfRRRCAdf+9geDZVKKRna90HpfURG4jN+7/u0n
         vJ7gLy0luWoDtmOvS+NYCIe6VhU+XJ2tday6TufH7vflotyhtRuTrvHcQy2dNGLhuyD5
         Ib9A==
X-Gm-Message-State: AOAM531YE3/bx1NY6TboZreaTs8PkxLVbxsz17Cv3c+UBHEpjsA6BWuR
        hKzsEQXm9a1XY79FCCVjHq5hkQ==
X-Google-Smtp-Source: ABdhPJwxpstYm1Z68yFetFV4U3XzSVLVc5w6RZx9tXnuPslfOOTSiZZl0VLhXwmobFYSed0IpSgNpw==
X-Received: by 2002:a05:6a00:180e:b029:39e:4765:20c4 with SMTP id y14-20020a056a00180eb029039e476520c4mr3119587pfa.30.1628140461072;
        Wed, 04 Aug 2021 22:14:21 -0700 (PDT)
Received: from ip-10-124-121-13.byted.org (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
        by smtp.gmail.com with ESMTPSA id k4sm4201098pjs.55.2021.08.04.22.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 22:14:20 -0700 (PDT)
From:   Jiang Wang <jiang.wang@bytedance.com>
To:     netdev@vger.kernel.org
Cc:     cong.wang@bytedance.com, duanxiongchun@bytedance.com,
        xieyongji@bytedance.com, chaiwen.cc@bytedance.com,
        John Fastabend <john.fastabend@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 5/5] selftest/bpf: add new tests in sockmap for unix stream to tcp.
Date:   Thu,  5 Aug 2021 05:13:37 +0000
Message-Id: <20210805051340.3798543-6-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210805051340.3798543-1-jiang.wang@bytedance.com>
References: <20210805051340.3798543-1-jiang.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add two new test cases in sockmap tests, where unix stream is
redirected to tcp and vice versa.

Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
Reviewed-by: Cong Wang <cong.wang@bytedance.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 .../selftests/bpf/prog_tests/sockmap_listen.c    | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 07ed8081f9ae..afa14fb66f08 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1884,7 +1884,7 @@ static void inet_unix_redir_to_connected(int family, int type, int sock_mapfd,
 	xclose(p0);
 }
 
-static void udp_unix_skb_redir_to_connected(struct test_sockmap_listen *skel,
+static void inet_unix_skb_redir_to_connected(struct test_sockmap_listen *skel,
 					    struct bpf_map *inner_map, int family)
 {
 	int verdict = bpf_program__fd(skel->progs.prog_skb_verdict);
@@ -1899,9 +1899,13 @@ static void udp_unix_skb_redir_to_connected(struct test_sockmap_listen *skel,
 	skel->bss->test_ingress = false;
 	inet_unix_redir_to_connected(family, SOCK_DGRAM, sock_map, verdict_map,
 				    REDIR_EGRESS);
+	inet_unix_redir_to_connected(family, SOCK_STREAM, sock_map, verdict_map,
+				    REDIR_EGRESS);
 	skel->bss->test_ingress = true;
 	inet_unix_redir_to_connected(family, SOCK_DGRAM, sock_map, verdict_map,
 				    REDIR_INGRESS);
+	inet_unix_redir_to_connected(family, SOCK_STREAM, sock_map, verdict_map,
+				    REDIR_INGRESS);
 
 	xbpf_prog_detach2(verdict, sock_map, BPF_SK_SKB_VERDICT);
 }
@@ -1961,7 +1965,7 @@ static void unix_inet_redir_to_connected(int family, int type, int sock_mapfd,
 
 }
 
-static void unix_udp_skb_redir_to_connected(struct test_sockmap_listen *skel,
+static void unix_inet_skb_redir_to_connected(struct test_sockmap_listen *skel,
 					    struct bpf_map *inner_map, int family)
 {
 	int verdict = bpf_program__fd(skel->progs.prog_skb_verdict);
@@ -1976,9 +1980,13 @@ static void unix_udp_skb_redir_to_connected(struct test_sockmap_listen *skel,
 	skel->bss->test_ingress = false;
 	unix_inet_redir_to_connected(family, SOCK_DGRAM, sock_map, verdict_map,
 				     REDIR_EGRESS);
+	unix_inet_redir_to_connected(family, SOCK_STREAM, sock_map, verdict_map,
+				     REDIR_EGRESS);
 	skel->bss->test_ingress = true;
 	unix_inet_redir_to_connected(family, SOCK_DGRAM, sock_map, verdict_map,
 				     REDIR_INGRESS);
+	unix_inet_redir_to_connected(family, SOCK_STREAM, sock_map, verdict_map,
+				     REDIR_INGRESS);
 
 	xbpf_prog_detach2(verdict, sock_map, BPF_SK_SKB_VERDICT);
 }
@@ -1994,8 +2002,8 @@ static void test_udp_unix_redir(struct test_sockmap_listen *skel, struct bpf_map
 	snprintf(s, sizeof(s), "%s %s %s", map_name, family_name, __func__);
 	if (!test__start_subtest(s))
 		return;
-	udp_unix_skb_redir_to_connected(skel, map, family);
-	unix_udp_skb_redir_to_connected(skel, map, family);
+	inet_unix_skb_redir_to_connected(skel, map, family);
+	unix_inet_skb_redir_to_connected(skel, map, family);
 }
 
 static void run_tests(struct test_sockmap_listen *skel, struct bpf_map *map,
-- 
2.20.1

