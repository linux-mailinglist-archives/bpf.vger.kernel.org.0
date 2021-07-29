Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADB03DAE49
	for <lists+bpf@lfdr.de>; Thu, 29 Jul 2021 23:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbhG2VYo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 17:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbhG2VYf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Jul 2021 17:24:35 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE99C06179B
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 14:24:31 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id q2so8500753plr.11
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 14:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P804EkvFn0VAlLFLpkTDkQMHTFJyfBf84bJVijuk6QE=;
        b=dC1o5JwNCalIc67spfo5hNab+Dt0qiaAvRdyb6QJWJjb7FGcopjbDBCsHQpNE2IaOe
         UcEVgwF5tJrwHTYjVuYgX69nUh/EAgA4SBL3DvkM+uGmWDfL60Ia6T49V2eCKRaYz9xM
         bKV7smjFUa/wIPtS6zGFAJZyXU4vq7XKInKyzN+iBHDec1qgD/LzaTnVZ0clUVkV/olz
         XqAeR+893OZFQCSVTk6SLZZgnTLxQdeRB7tjaBcAmvj75Slckg1OLeuNLmhgtfDEVn8B
         pwScqVVtKTN5mhtRFh6zHIivp35KrEGFaLif8+MhnB2cPgiOW8OIItL3UP1AR5XMl89L
         diog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P804EkvFn0VAlLFLpkTDkQMHTFJyfBf84bJVijuk6QE=;
        b=YzRVsNefB2EhhObqa66PSE1sxjFw4Kp+bsOWSgRjjwiBllftrCVD6FkUTrwn7nUXbB
         dge8OafczirkwM1xDgu/WyBAQdBFReayqsvF84pSRApRf6EHVHpPS+jbmaXXxF2GIwG9
         dzLcLb2LlsE5KcUDMS/FbrwN1Lv6s9xVxpW0MrgjiS3oH1vfN7MScU4MStLI3ebcWf2y
         nxQx9+xdFKo9DSysRdM2ZlBJxc/CmHCdY56XXtIYuwqUJ5nDyKoeQrK3v5ChDfMQO1N/
         UKBcV+4VI4C5qtWVrvSIi1y9Qzkh/MkQA+yxMfzsElSoPL/wYF8tDV5VdFJF5nh8XwMZ
         xqcg==
X-Gm-Message-State: AOAM531JbYcapZSk+ErThFdWyJfE859fjxjUV+xT5ku4IJOY8NPhdUbg
        ky7yNCBJCzPQcwUpsEOfhl4JfA==
X-Google-Smtp-Source: ABdhPJziHcTOM0HV/igPeyKZPBHiSrcNPd/zNJ5Eq2CehLSbnnVWlq3d+PFzXrcE/5iZ4h8SYCseWA==
X-Received: by 2002:a17:902:9b87:b029:11e:7c15:a597 with SMTP id y7-20020a1709029b87b029011e7c15a597mr6542105plp.6.1627593871331;
        Thu, 29 Jul 2021 14:24:31 -0700 (PDT)
Received: from ip-10-124-121-13.byted.org (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
        by smtp.gmail.com with ESMTPSA id c15sm4686258pfl.181.2021.07.29.14.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 14:24:31 -0700 (PDT)
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
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 5/5] selftest/bpf: add new tests in sockmap for unix stream to tcp.
Date:   Thu, 29 Jul 2021 21:24:01 +0000
Message-Id: <20210729212402.1043211-6-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210729212402.1043211-1-jiang.wang@bytedance.com>
References: <20210729212402.1043211-1-jiang.wang@bytedance.com>
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
index 07ed8081f..afa14fb66 100644
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

