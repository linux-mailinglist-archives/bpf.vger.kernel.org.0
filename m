Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244313EDD87
	for <lists+bpf@lfdr.de>; Mon, 16 Aug 2021 21:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhHPTEY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Aug 2021 15:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhHPTEX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Aug 2021 15:04:23 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A861BC0613C1
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 12:03:51 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso1747510pjy.5
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 12:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MtJ8xI/B+EIULIghvMhd6tf0lsFMRQDGP/UDMzZQQ5Q=;
        b=yHQ7KFpaSoLUFXvywBlsxOc007iUMb3VOTOm9M4LWT+9O+bzW85FAsYJ+2+j31NX19
         htKek/lqVIPZaKxLLvxPFasoLSybrRImtsqOgexCHJCZcMpy/ZYMD/d3DDpe8zooTxzV
         lmad08s/DI7s8H9JGUvQ9NWD5BRG1qffBwLWpnmgXt/GA/8oMTbLxdWe4azBSn+iLK/R
         DOTAMO5Gj2jA9NBcLEy9/gNTPEgvCqHKfM99KmVKfXZ931xNKrnAA3g7M2xVzwVLVu8m
         vat+YxWolXO6PWriuwV7iO6UM63mbcgcLK/ntFm8lXL0+lFyWcOmgEZJyBO90pvmyKPd
         +p7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MtJ8xI/B+EIULIghvMhd6tf0lsFMRQDGP/UDMzZQQ5Q=;
        b=WJ6E2pOm7kr3FEYNkYuYtnLuyN8b9mbxyaxUUVzmWQjB9v8D6lecaftLdYoHO7cGua
         nAZKKv7MDJcUvZV8C5GQDrAqHs+1yP54KkHVZ5SpzXnxuXexngf1qcf2X0mVDBPHcxFW
         Fdf8DhMXzXodErsQu7w0gOkHInTkssD3ACd3qXoouqje2Mw8wGOK79P/vBUzl3dlzEH2
         JvMhHvHEpKZ7M8NGFu+pyL2gPBRd3Kt3BaLB37RRxlw8785l72fdqx1odjrAWOkRVIGi
         toIbq6eDAKhSqd7ckBJLChDrIn7EsT4jz+1ytlv1cSN+vCBOmeExSzVLBpSuUxyaolyy
         HsOw==
X-Gm-Message-State: AOAM532Vxm6vsHUU+oQJaCQuCqhK7a85F8PDBWK8lj9gSgwr2bKnjr7q
        sUiHtbQYdMSdZwf0mxC65vXd4A==
X-Google-Smtp-Source: ABdhPJyCn1iWQdqbyGCARtxYqmvlkk6vJVemR7k9B/+VUAc9mQ0T9xJxanvkszWmha4+nBIPwcyhvQ==
X-Received: by 2002:a17:90b:360a:: with SMTP id ml10mr66158pjb.134.1629140631294;
        Mon, 16 Aug 2021 12:03:51 -0700 (PDT)
Received: from ip-10-124-121-13.byted.org (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
        by smtp.gmail.com with ESMTPSA id t30sm175845pgl.47.2021.08.16.12.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 12:03:51 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 3/5] selftest/bpf: add tests for sockmap with unix stream type.
Date:   Mon, 16 Aug 2021 19:03:22 +0000
Message-Id: <20210816190327.2739291-4-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210816190327.2739291-1-jiang.wang@bytedance.com>
References: <20210816190327.2739291-1-jiang.wang@bytedance.com>
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

