Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25BB73D6AD9
	for <lists+bpf@lfdr.de>; Tue, 27 Jul 2021 02:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbhGZXd2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Jul 2021 19:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbhGZXd1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Jul 2021 19:33:27 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2F0C061757
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 17:13:54 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id a4-20020a17090aa504b0290176a0d2b67aso1512977pjq.2
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 17:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H8KgAJIkqSeG/hKZeeo63HZDWfcmzz7HUI7sYt9dwKU=;
        b=C+RhA7ziN1zDjtNR5+EWOcd/bjdRj04Spii1eQKtWinQJJ3cPwHJ5PMQGFIk1k6V/X
         /OG3RhKw083oQqwms2GGh+IGNokqmQvlpQryIcvnNxViHjBQ3JG9/ggT6U2f1JeztaC7
         PhnA0NYnNdKdjxvUjVsBBKcYDy1RFuPwLdHeXSJRtkf9N6+W2UqxcKhiKmrWw9usjUjn
         0zjntieDPS7WgWaNlj6ixS7f/jZg+dQzEpDZXFQ6DN3kgXCdtrX6uAfIjSTbo8WYh0tA
         0GNhcmxd3RqR4ofhzUqka4PMQ336tiNOH6x7dwoSqSXW6e2YCZlByhLSJxh/3jyiAbjW
         49YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H8KgAJIkqSeG/hKZeeo63HZDWfcmzz7HUI7sYt9dwKU=;
        b=pyb6zL9g/7hPzI1Nw6PVQzwUXXzbgRyjAmYTpa2f0gYob9i6JsKBlJo727lxbdsUrq
         rv+zlLY7LhhczVv6dx/YPI9NNW3OxNPsXwlXBBq+9sE5Ij4WvhSaBm7pICiAI4bPf45P
         Sd1LRVLPeMfBriLQqi0VHhDz02V1S0OCqrkYIPltDgaQvFF5BShvdLwBPORpoVMTzCk3
         yz7EjqPv0KMChlZhUIMeBQ3Tgndd82WEaM7/l+Kg0F64PTvtkdcm7Y3dMoWFYgytOXKg
         upemnPoPqZ4/HOPg1a+4pGpdbr+nYcUbr3RLL/6CFX+WxQysuuXVzZIXUrWHYbybaB9E
         lB3g==
X-Gm-Message-State: AOAM533gRhX+HYbWmahwnGRqn9WC4+iYDIqve4DkLZ71bkton8oKPU8o
        7yPB6IgGwyxpiP7nXf0XbcVIIw==
X-Google-Smtp-Source: ABdhPJy0qtMofanpMrj7StC17d15Tex6Rg7PpBZKhRx0uLrez5+EamqiCFlDgTM0GIGin3nNRVdEUg==
X-Received: by 2002:a17:90a:9f91:: with SMTP id o17mr1459607pjp.29.1627344834176;
        Mon, 26 Jul 2021 17:13:54 -0700 (PDT)
Received: from ip-10-124-121-13.byted.org (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
        by smtp.gmail.com with ESMTPSA id k1sm1079452pga.70.2021.07.26.17.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 17:13:53 -0700 (PDT)
From:   Jiang Wang <jiang.wang@bytedance.com>
To:     netdev@vger.kernel.org
Cc:     cong.wang@bytedance.com, duanxiongchun@bytedance.com,
        xieyongji@bytedance.com, chaiwen.cc@bytedance.com,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
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
Subject: [PATCH bpf-next v1 3/5] selftest/bpf: add tests for sockmap with unix stream type.
Date:   Tue, 27 Jul 2021 00:12:50 +0000
Message-Id: <20210727001252.1287673-4-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210727001252.1287673-1-jiang.wang@bytedance.com>
References: <20210727001252.1287673-1-jiang.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add two tests for unix stream to unix stream redirection
in sockmap tests.

Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
Reviewed-by: Cong Wang <cong.wang@bytedance.com>.
---
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index a9f1bf9d5..7a976d432 100644
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

