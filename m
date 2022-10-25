Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBDD60CDC0
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 15:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbiJYNm3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 09:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJYNm2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 09:42:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BD4183D83
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 06:42:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49AA361939
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 13:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5717CC433D6;
        Tue, 25 Oct 2022 13:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666705346;
        bh=BLrWSK2y6Ic1QFL/lOXOKAwcJZalvL2PzPAMR6ELH6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R3pUqrLo8wXYaAyE4Lty8UnMNUB4WcrxjxYvnKqA7iqoTNFNFTBd9MGyI5sjVDVSp
         /9EgcTAK61n2bfeIiTkS01bjO1BLGdIo5ix0UreOVPtAzJKKHXJKMXWzpf7b4LO67H
         5k4t0f/j5dDVDM6Iy2CrStt5XT2wIOsShdIDxOo63qahTiRdu+rIy0UnhSQ/Kmdfo1
         0SiZ6yosS+e9VjaY2St1krr/J6cgsqC8vySTIjDqajmhOZV/qdMQHFmQD5h6bWj3Cj
         VZcK8mwPNZrfQ+RUfbjK5fiS0wJ+PZmQQv6igheEkKm3pZ56R4Yxi7LQhCeDityCrO
         yAsChfCtVZINg==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Song Liu <song@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Christoph Hellwig <hch@lst.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Martynas Pumputis <m@lambda.lt>
Subject: [PATCHv3 bpf-next 3/8] bpf: Rename __bpf_kprobe_multi_cookie_cmp to bpf_kprobe_multi_addrs_cmp
Date:   Tue, 25 Oct 2022 15:41:43 +0200
Message-Id: <20221025134148.3300700-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221025134148.3300700-1-jolsa@kernel.org>
References: <20221025134148.3300700-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Renaming __bpf_kprobe_multi_cookie_cmp to bpf_kprobe_multi_addrs_cmp,
because it's more suitable to current and upcoming code.

Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 1ed08967fb97..17ae9e8336db 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2550,7 +2550,7 @@ static void bpf_kprobe_multi_cookie_swap(void *a, void *b, int size, const void
 	swap(*cookie_a, *cookie_b);
 }
 
-static int __bpf_kprobe_multi_cookie_cmp(const void *a, const void *b)
+static int bpf_kprobe_multi_addrs_cmp(const void *a, const void *b)
 {
 	const unsigned long *addr_a = a, *addr_b = b;
 
@@ -2561,7 +2561,7 @@ static int __bpf_kprobe_multi_cookie_cmp(const void *a, const void *b)
 
 static int bpf_kprobe_multi_cookie_cmp(const void *a, const void *b, const void *priv)
 {
-	return __bpf_kprobe_multi_cookie_cmp(a, b);
+	return bpf_kprobe_multi_addrs_cmp(a, b);
 }
 
 static u64 bpf_kprobe_multi_cookie(struct bpf_run_ctx *ctx)
@@ -2579,7 +2579,7 @@ static u64 bpf_kprobe_multi_cookie(struct bpf_run_ctx *ctx)
 		return 0;
 	entry_ip = run_ctx->entry_ip;
 	addr = bsearch(&entry_ip, link->addrs, link->cnt, sizeof(entry_ip),
-		       __bpf_kprobe_multi_cookie_cmp);
+		       bpf_kprobe_multi_addrs_cmp);
 	if (!addr)
 		return 0;
 	cookie = link->cookies + (addr - link->addrs);
-- 
2.37.3

