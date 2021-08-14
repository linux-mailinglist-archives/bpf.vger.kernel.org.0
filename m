Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95693EC073
	for <lists+bpf@lfdr.de>; Sat, 14 Aug 2021 06:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbhHNE2u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 14 Aug 2021 00:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236816AbhHNE2p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 14 Aug 2021 00:28:45 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517C1C061757
        for <bpf@vger.kernel.org>; Fri, 13 Aug 2021 21:28:18 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d1so14610337pll.1
        for <bpf@vger.kernel.org>; Fri, 13 Aug 2021 21:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MtJ8xI/B+EIULIghvMhd6tf0lsFMRQDGP/UDMzZQQ5Q=;
        b=K1MuxmLBc6sX5hsO0gbwwh0Rn/AQTd0+/M4bm0Nk31QKlaLAsgOUbpztMicW3a5Oht
         nmuQYJGTP+7HaxZ/pGkSFjn6o3io0wcEhhBB63YicDxke75NXDBL99TzfgjZsuxd4KGF
         drVeQUF7v8n6ag8SXUUt2F+9R+noYBxhJxmLKiHgJINUigK8kCYCcttXgJvcBeqUZCMw
         gAfY/DLwZH6vLITZfaDJsLkFTI7z5Fh/lXqd0a+7ekRBGNX+RtVFUFB2bX8JWVwpS+Y5
         SPAl9yKM9xLr5xp/nCdsH8dXPazprfl8Ug7vqg7RBKDp6KDqBOF/iLsbgrxPPRbfCKAE
         bNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MtJ8xI/B+EIULIghvMhd6tf0lsFMRQDGP/UDMzZQQ5Q=;
        b=nakPqzHIFks2Nmw8P/VvBpFIu7+7OJHFlSvtx5JNn9vIFUkUeWOWOGRxBZpdHJ8264
         8fZBiOuy36OEACkP0suci9RIbwSvT/fEDzj9kkV1pK49xOaVD6ukJOEf+RaGyDx7k+b4
         l6JEaxZpjGRzYAiMnH6yrk6cAhr1AAOFtaSHiRHsFH4Vw90yFmD4C1eHynpxP92qI6/h
         Sm/kdUkhPCgH4dS7VItGQGyg7aaYzjsaOx0wc4xZBJT5atE+HINbJudcootq8aPN5ydh
         YXlYhLWSir18lbDS7Lzj1+Bu40H6ilF4SUOeqpHfkf8rjbN+i4ku0tYUptQAKGTyrUHf
         QTxA==
X-Gm-Message-State: AOAM533RwtvM1YAAW2Dzosw9FHAFDj+FHDFSm0y4xbHMIJgLKRBrn5uO
        Iaf1oskaKy07wwdARzH0yn2iVQ==
X-Google-Smtp-Source: ABdhPJzWh8HABO8THAix+/Fh+iSTqcCOEXAFqdQhb1CotB+J23uLb6DdoxaJOuYh6VZuA35EDCOWgw==
X-Received: by 2002:a63:542:: with SMTP id 63mr5178633pgf.359.1628915297972;
        Fri, 13 Aug 2021 21:28:17 -0700 (PDT)
Received: from ip-10-124-121-13.byted.org (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
        by smtp.gmail.com with ESMTPSA id q21sm4420492pgk.71.2021.08.13.21.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 21:28:17 -0700 (PDT)
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
        Rao Shoaib <rao.shoaib@oracle.com>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v6 3/5] selftest/bpf: add tests for sockmap with unix stream type.
Date:   Sat, 14 Aug 2021 04:27:48 +0000
Message-Id: <20210814042754.3351268-4-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210814042754.3351268-1-jiang.wang@bytedance.com>
References: <20210814042754.3351268-1-jiang.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add two tests for unix stream to unix stream redirection
in sockmap tests.

Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
Reviewed-by: Cong Wang <cong.wang@bytedance.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index a9f1bf9d5dff..7a976d43281a 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -2020,11 +2020,13 @@ void test_sockmap_listen(void)
 	run_tests(skel, skel->maps.sock_map, AF_INET);
 	run_tests(skel, skel->maps.sock_map, AF_INET6);
 	test_unix_redir(skel, skel->maps.sock_map, SOCK_DGRAM);
+	test_unix_redir(skel, skel->maps.sock_map, SOCK_STREAM);
 
 	skel->bss->test_sockmap = false;
 	run_tests(skel, skel->maps.sock_hash, AF_INET);
 	run_tests(skel, skel->maps.sock_hash, AF_INET6);
 	test_unix_redir(skel, skel->maps.sock_hash, SOCK_DGRAM);
+	test_unix_redir(skel, skel->maps.sock_hash, SOCK_STREAM);
 
 	test_sockmap_listen__destroy(skel);
 }
-- 
2.20.1

