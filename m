Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C003DE160
	for <lists+bpf@lfdr.de>; Mon,  2 Aug 2021 23:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbhHBVTr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Aug 2021 17:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbhHBVTn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Aug 2021 17:19:43 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87100C061798
        for <bpf@vger.kernel.org>; Mon,  2 Aug 2021 14:19:33 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id t3so19080807plg.9
        for <bpf@vger.kernel.org>; Mon, 02 Aug 2021 14:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bhGcOUQjFyv9qKej/FfYNNPvlVrV7Is0yhKG/rkyjT0=;
        b=V9yA3wfLW3Nb3n38uMk2DBs0XGzy+UJzOlvnkxCQVEWtF+0IfvWz0EDgHGexdKbdEJ
         ACqVURPZWxTLj+uuwq6dmt9zrb0vr/U8ZmE2oVLmFYObxjZxs+5aNH0QStHaymEcTtfm
         p7K8+FV6CJEJISR3rVVFDmpwfArOfTQlX4gL5rxalRn3/5MZ8J7gc7l7/4vj7aYHDpmX
         JU/TQSZS0ONNgb1GBV7BewTO6ejZJWeuMwvgB+82ktyqclQvrc2AdEHK76xqQ73R2Jfh
         7XjfEwUy2E6nsWxUrefA8rli+qcxy+WM4LDB5vQa4W5G+/eWgLEyqgsSn3P4r4fClvxT
         5YWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bhGcOUQjFyv9qKej/FfYNNPvlVrV7Is0yhKG/rkyjT0=;
        b=oUEhWWyPme1NPIj/EAHfYIIsCQl1hzgSlNd+X80iQbQs0grH8CQj1H4w0H18gJsjqi
         SCKVkDYQWSNJEHSjhFzoRIeO37EeXbkgqvxnHW6huB7fMpeJJ+o0pNxJrZlPgh8AoBp+
         lvJof6IYJ6DL0cipZ18HhZeUzBqe1MT1GNGrqJoc75Z1wjPNMRi3VcsizS6HgmII89bo
         N2k1u4OmWGijT/cnloFDnxhd0Y9sbH3ga99QMsGNJO7OLnfQ3OtwqYzm6Ie78r1swUY4
         qcs4C7Kn+quSi/CaDex82C5McoPOh4yf8+1JHjZl8aKiT7FwhPIQIoAmdwS08OR6pDVn
         spNQ==
X-Gm-Message-State: AOAM530WbLy3rBR77BqWx8TPYAcsTCeih5w0vS+vTfAJDZOeFEF2hrNl
        EyvpSOiz2Pvy9/CMOvKW4N6Ikw==
X-Google-Smtp-Source: ABdhPJxyyXXtMtdHZHk9LczlqhouDVCP9UCZRAUE1QXLwPGvbzitTiIj3CydSAzrL/pm5lSnlycavQ==
X-Received: by 2002:a17:90a:3f87:: with SMTP id m7mr18866335pjc.96.1627939173152;
        Mon, 02 Aug 2021 14:19:33 -0700 (PDT)
Received: from ip-10-124-121-13.byted.org (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
        by smtp.gmail.com with ESMTPSA id 10sm12949212pjc.41.2021.08.02.14.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 14:19:32 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 3/5] selftest/bpf: add tests for sockmap with unix stream type.
Date:   Mon,  2 Aug 2021 21:19:07 +0000
Message-Id: <20210802211912.116329-4-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210802211912.116329-1-jiang.wang@bytedance.com>
References: <20210802211912.116329-1-jiang.wang@bytedance.com>
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

