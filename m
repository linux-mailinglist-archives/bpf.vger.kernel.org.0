Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFF94DC4F0
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 12:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiCQLku (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Mar 2022 07:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbiCQLkt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 07:40:49 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D175D1E3E37
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 04:39:25 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id n19so8492208lfh.8
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 04:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=al55RwOac+/z9BBt+f6IKfG92+gHay1WckoruFKyL+E=;
        b=MKV1gMjokNAMx+1BuKa6Cs9I6ohJP6o3FEP3ch6dRlvZk7AzLx90cM8XlR2BX5OdF0
         BG9FQzMtZVbSv6b2YQWPUG56ELF8DuawKNouWUf/8v7t5KxSNhIRXM/jusetCmrQ7yYQ
         YTL5KtKt2IiAHd+jN9up5Xlnx0sgjYDPNoeqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=al55RwOac+/z9BBt+f6IKfG92+gHay1WckoruFKyL+E=;
        b=Sa2nqSKURInmkyBKEVCc0oYgDOn2kg/96JFRUyzeHFS2k68II6etyMuZLoSCVmcEcC
         7e3udVnmOf5W7ZIVmooQDRn36vIzkuDT0MNSUpFkz9p+xCnIiZegnl5uZF/VroGLCdEj
         gSBiGgbrGf6uXCHlc0Ngh8UZmclxX46gpD62zD1v4fTcPy6AvoTIKuFyFo54OCKp8ZoP
         hTC6z8WC970QgRmJSHN7cEgmxk/SCe5qnzdOmA9cBwLcBQSZUJKsAWq0lxdq3brzSFbX
         DMaV8Vb/YEG8NmIy+3FeOqSz8/LXr/Gbyq8nHWaSlwZL/dcQ/NZk9EK07SR9ylXXulwB
         4qxg==
X-Gm-Message-State: AOAM531uQcioFqndnREFageJbhljHlH2+7QHNB4Xk7KYNxqDG7tIW714
        zNET8IajMVjGOhTbM4850OU938nsO2R4Pg==
X-Google-Smtp-Source: ABdhPJyDGHOeK9PboPorQnDj2A7ABx/II7JKZ/K9Fk4pu/tDlrlEcCL8skcXftGW4jME2XyexcoDbQ==
X-Received: by 2002:a05:6512:68e:b0:449:fb65:c532 with SMTP id t14-20020a056512068e00b00449fb65c532mr1162481lfe.386.1647517163970;
        Thu, 17 Mar 2022 04:39:23 -0700 (PDT)
Received: from cloudflare.com ([2a01:110f:4809:d800::f9c])
        by smtp.gmail.com with ESMTPSA id t25-20020ac243b9000000b0044824f72b16sm430873lfl.80.2022.03.17.04.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 04:39:23 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@cloudflare.com, Ilya Leoshkevich <iii@linux.ibm.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v3 3/4] selftests/bpf: Use constants for socket states in sock_fields test
Date:   Thu, 17 Mar 2022 12:39:19 +0100
Message-Id: <20220317113920.1068535-4-jakub@cloudflare.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220317113920.1068535-1-jakub@cloudflare.com>
References: <20220317113920.1068535-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Replace magic numbers in BPF code with constants from bpf.h, so that they
don't require an explanation in the comments.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/progs/test_sock_fields.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_sock_fields.c b/tools/testing/selftests/bpf/progs/test_sock_fields.c
index 43b31aa1fcf7..43a17fdef226 100644
--- a/tools/testing/selftests/bpf/progs/test_sock_fields.c
+++ b/tools/testing/selftests/bpf/progs/test_sock_fields.c
@@ -134,11 +134,11 @@ int egress_read_sock_fields(struct __sk_buff *skb)
 	if (!sk)
 		RET_LOG();
 
-	/* Not the testing egress traffic or
-	 * TCP_LISTEN (10) socket will be copied at the ingress side.
+	/* Not testing the egress traffic or the listening socket,
+	 * which are covered by the cgroup_skb/ingress test program.
 	 */
 	if (sk->family != AF_INET6 || !is_loopback6(sk->src_ip6) ||
-	    sk->state == 10)
+	    sk->state == BPF_TCP_LISTEN)
 		return CG_OK;
 
 	if (sk->src_port == bpf_ntohs(srv_sa6.sin6_port)) {
@@ -232,8 +232,8 @@ int ingress_read_sock_fields(struct __sk_buff *skb)
 	    sk->src_port != bpf_ntohs(srv_sa6.sin6_port))
 		return CG_OK;
 
-	/* Only interested in TCP_LISTEN */
-	if (sk->state != 10)
+	/* Only interested in the listening socket */
+	if (sk->state != BPF_TCP_LISTEN)
 		return CG_OK;
 
 	/* It must be a fullsock for cgroup_skb/ingress prog */
-- 
2.35.1

