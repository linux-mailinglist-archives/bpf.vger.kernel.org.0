Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4518C5F8F12
	for <lists+bpf@lfdr.de>; Mon, 10 Oct 2022 00:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiJIWAM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 9 Oct 2022 18:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiJIWAK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 9 Oct 2022 18:00:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A676380
        for <bpf@vger.kernel.org>; Sun,  9 Oct 2022 15:00:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B588560C42
        for <bpf@vger.kernel.org>; Sun,  9 Oct 2022 22:00:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC914C433D6;
        Sun,  9 Oct 2022 22:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665352808;
        bh=Y5NL5K0zQHFR57AsqS+cHR4zee/oSpJm2IJvYGR9lhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FXne5XbT6RzBdvDQ7CPQqF1x4FqnvKXhvRYhg7LJjQFb7Kq1wxFjuDXLvIq0tFe1U
         ZOoZo6yRllvFudhUhojklsY89H46TeHllYtYUekHig5miZKOQ9Hjfn2VSWbsSAK0h5
         KYsYKDDbMWSWTuAg8Tyy2nO8DMhYpk1908NNITzot6CGVvU78FZ+n43Tce+CRF+F1e
         OKCp39uHnzQQ0s1LZZSjrYO9G9JgleTx2Is0IwY+eSW+oFJRI7kOex2sHgonvinW6J
         zBixoGaxWeDOtwdIXRnvJ0HnEjQ1kkNGGd+O+HgQ9RstB8ktR6mXbF4wgaVGUmYHV3
         CSsffrhgArQhg==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Christoph Hellwig <hch@lst.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Martynas Pumputis <m@lambda.lt>
Subject: [PATCH bpf-next 3/8] bpf: Rename __bpf_kprobe_multi_cookie_cmp to bpf_kprobe_multi_addrs_cmp
Date:   Sun,  9 Oct 2022 23:59:21 +0200
Message-Id: <20221009215926.970164-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221009215926.970164-1-jolsa@kernel.org>
References: <20221009215926.970164-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Renaming __bpf_kprobe_multi_cookie_cmp to bpf_kprobe_multi_addrs_cmp,
because it's more suitable to current and upcoming code.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 688552df95ca..9be1a2b6b53b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2545,7 +2545,7 @@ static void bpf_kprobe_multi_cookie_swap(void *a, void *b, int size, const void
 	swap(*cookie_a, *cookie_b);
 }
 
-static int __bpf_kprobe_multi_cookie_cmp(const void *a, const void *b)
+static int bpf_kprobe_multi_addrs_cmp(const void *a, const void *b)
 {
 	const unsigned long *addr_a = a, *addr_b = b;
 
@@ -2556,7 +2556,7 @@ static int __bpf_kprobe_multi_cookie_cmp(const void *a, const void *b)
 
 static int bpf_kprobe_multi_cookie_cmp(const void *a, const void *b, const void *priv)
 {
-	return __bpf_kprobe_multi_cookie_cmp(a, b);
+	return bpf_kprobe_multi_addrs_cmp(a, b);
 }
 
 static u64 bpf_kprobe_multi_cookie(struct bpf_run_ctx *ctx)
@@ -2574,7 +2574,7 @@ static u64 bpf_kprobe_multi_cookie(struct bpf_run_ctx *ctx)
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

