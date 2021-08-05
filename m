Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A696A3E0DA5
	for <lists+bpf@lfdr.de>; Thu,  5 Aug 2021 07:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhHEFO1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Aug 2021 01:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237137AbhHEFOY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Aug 2021 01:14:24 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B61C0613D5
        for <bpf@vger.kernel.org>; Wed,  4 Aug 2021 22:14:11 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id dw2-20020a17090b0942b0290177cb475142so12351497pjb.2
        for <bpf@vger.kernel.org>; Wed, 04 Aug 2021 22:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MtJ8xI/B+EIULIghvMhd6tf0lsFMRQDGP/UDMzZQQ5Q=;
        b=f8VLcDJC+GRjS77dEkbSH6oWriAdkrwFK8WU/fuDD0VoO5jfFofEfUhFzBRQ/W0qwL
         DFZ/l/JHSWlAXdZDv/POklmCvh2gbAKB/anr+MLYyldRM7T/sFqsveKKbrqeqZAnHuG/
         mahuvRljWFeg1AR5PQBmTelYbs2vJo8ipHPxbP45gHbimwrKlIEh1M+Vw4hpnbz0WzyH
         XDIVvOfc91KduWvUIqiJyIyCved82FFZAjPYfUFH3QGNVYpfiLllHIEV6c01AWhEkNwf
         gwdKMH22KS58YnDu4LhZxT2pkAeRsPPnYu+Bjh7KueEvt/KT+tjteGWmKFVWpadAI80c
         4UCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MtJ8xI/B+EIULIghvMhd6tf0lsFMRQDGP/UDMzZQQ5Q=;
        b=Wu9z9X04iwpFggAUJNqiDilxfMj67v1A1GDFcKtaPzTURM66G/4kQZNYfhykvZwakE
         VusAcI6C6uhngl+mGrMGx8Jdke7cjzvpLWVcxfpBbXQaA5x2dZcfmuQ154PJuGlX7VVR
         MZwMAJ8Rj0WS54kmedcdaRoViaG7Yro9uLfSMiKwC9TFJDt4TixjlN4m+3pnXGVyQusw
         XC+36nmoZOKUkeSpf7J1S+YaLoub3jQluesnP9mQx7pgti9izp9gbCALjmTF+7vdAlIE
         nyXOfw6fAcjdFbLcMTk5CxdUbvZ0vxZarTLCpHsQizXjhRrgIKtaKbFPH3tK96l3OKih
         gOxw==
X-Gm-Message-State: AOAM531+6t4HntEUkp5bmXiJhBupdS+s+QGJkeBSTZMqlz0faIi0Pg36
        9A9tWIwlmKcFX+uLl7Fmnein5g==
X-Google-Smtp-Source: ABdhPJxoqkDuGMiJPBMRXDNgMTWDDbDekyZOw7bqlEeTLB83QJFlTOdX9N/wIdxhzebo8D10q4B+iA==
X-Received: by 2002:a17:902:8a98:b029:12c:3177:c3ef with SMTP id p24-20020a1709028a98b029012c3177c3efmr2465741plo.21.1628140450732;
        Wed, 04 Aug 2021 22:14:10 -0700 (PDT)
Received: from ip-10-124-121-13.byted.org (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
        by smtp.gmail.com with ESMTPSA id k4sm4201098pjs.55.2021.08.04.22.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 22:14:10 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 3/5] selftest/bpf: add tests for sockmap with unix stream type.
Date:   Thu,  5 Aug 2021 05:13:35 +0000
Message-Id: <20210805051340.3798543-4-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210805051340.3798543-1-jiang.wang@bytedance.com>
References: <20210805051340.3798543-1-jiang.wang@bytedance.com>
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

