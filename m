Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618ED3DAE40
	for <lists+bpf@lfdr.de>; Thu, 29 Jul 2021 23:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbhG2VYd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 17:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbhG2VYa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Jul 2021 17:24:30 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3973BC061765
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 14:24:27 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id t21so8475387plr.13
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 14:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bhGcOUQjFyv9qKej/FfYNNPvlVrV7Is0yhKG/rkyjT0=;
        b=tMVW2kJI+MM5+iQPUQUAbpfsUS+j5kqaGJ77UoKjLLiMWAlEzGF9s9e42dtbBXaWWh
         lpTdxwJ1BsaRoSW89ntPIWuunBv3CYPtAl5irkVszvUD+y1A33OHtZGqTxB2ANvj9dWq
         ckYPzoKks9a/+DJSmYCIUNIots6glRfhrj+uZRJ/WElDCxWpmNy5pPKB/GB61/kC33wg
         2oIAU2Y4ruZ1Syn7texzmL3MSsdCAu5YY2Qj6ILsy9df0+hEcQHLYxM0PT6o5PZfKHZr
         FFNcdX/aLg7VZp7aRPFdeyhuDE34udmmZmiakyWwODw5XIf685DOcB/N84nIEas9nMBS
         Np4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bhGcOUQjFyv9qKej/FfYNNPvlVrV7Is0yhKG/rkyjT0=;
        b=VIlJaEoNl0edvy6EWAeqCSXj/zD0b2W4JGitJRHLTG51mAJ6vWMh3PjSOjUK+k+NV9
         Pa3T4xC8oGWOT2zorie9jpyHw7Ds5p6APvl6oMIDyluZ0vkJIowDGzHCWjCAGRAkL5mp
         8821/T43HAHJFD35BCbBsNxARC8o1KtU5PJZc5L2z8UWltwh07PMsHwJsGNDwOY6gY9b
         PwsrGwQqOl7m4qCLksR/wl+LDfehJjXBB61ZThfSz8NMWzRTXdCEMfCQofwh1gmjoect
         rDqzHNyfLnVx76XK63p26A4wJlZXWQ54zLAa2ibGcOlNRYYWkkfT8qEBhahp0U3zqT8v
         qJ+g==
X-Gm-Message-State: AOAM532H8DgthaYK8nIv4lMHglz2e+fidFPnlSq3uNIxpjyaT+4ba7HR
        Jfe9xH/BbDL8rBJEyT5C0uaqSA==
X-Google-Smtp-Source: ABdhPJz4+6Qd39ubFrTCqLVoQ7dWmWNt2B5ozeKGFEYNOy6d8WfsGkVhKdhpd2Tc6fu9mRxXIKrr6g==
X-Received: by 2002:a17:902:da82:b029:12b:ac76:204a with SMTP id j2-20020a170902da82b029012bac76204amr6395381plx.56.1627593866842;
        Thu, 29 Jul 2021 14:24:26 -0700 (PDT)
Received: from ip-10-124-121-13.byted.org (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
        by smtp.gmail.com with ESMTPSA id c15sm4686258pfl.181.2021.07.29.14.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 14:24:26 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 3/5] selftest/bpf: add tests for sockmap with unix stream type.
Date:   Thu, 29 Jul 2021 21:23:59 +0000
Message-Id: <20210729212402.1043211-4-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210729212402.1043211-1-jiang.wang@bytedance.com>
References: <20210729212402.1043211-1-jiang.wang@bytedance.com>
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

