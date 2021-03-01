Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CBC327BEA
	for <lists+bpf@lfdr.de>; Mon,  1 Mar 2021 11:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbhCAKXI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Mar 2021 05:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbhCAKVo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Mar 2021 05:21:44 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E847C0617A7
        for <bpf@vger.kernel.org>; Mon,  1 Mar 2021 02:19:30 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d11so15482104wrj.7
        for <bpf@vger.kernel.org>; Mon, 01 Mar 2021 02:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m7RqUGlAZKFc49U41qGqNoOsHvlpZbIedEeyhnhCTbI=;
        b=oonpr2B3rHnYHupaHPShB/68/ySpZhsnym3v+SNUtmhwaRRl+ebfMYlGZJepX2qulG
         9cbrc6OOaR8fnjJU0XjBJiOhQvEFKeYlDJCkCm3uSGitqaz0tsBUynXX8v3UT1Urgh8C
         HpPB4txSmK4g50EGTw+LoucZuZaxS1O+CJBis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m7RqUGlAZKFc49U41qGqNoOsHvlpZbIedEeyhnhCTbI=;
        b=YXN99w6k46u925nCH4ffWRAz6Pce9L4q1ZlmyGC7dZuhOoL6o9yCa8/v5CJDIykhZw
         bqErSlu0QGm60CMQbj+BZWyDsps69GLuXuMIVXafhB6Sb7AqHLg0++zPV4qVN4GQPrHr
         4DpTLSDAIkrjS/yhzf6R2PrZgTLe8wDRH126sEMHxvXCBiv1F5fMc9fO+Xkk+V162UMM
         FUBi+ViphhnSb8x03E/H/uw3TkUTEjKHcswmbs0/ui5RjeRh0FEa6g7pN9d4P2Fvu+h9
         IClgz5uRvuPFOKVQLs2apGtjk/H422v2pZOFcaQUQzm6gf7EYzls1jytdctWspSmHvQp
         OVXw==
X-Gm-Message-State: AOAM530MX/e2+SzgqsnLsNz8S1r5gilJ+kC8gS2HnX2NrNmnm/gpTIeD
        5ZB36yMkL7BPP5eks9tnN92fEg==
X-Google-Smtp-Source: ABdhPJxgNFJm+3dLBERmicTkvuFnp/OHYctVVHJxCxBBK52+5gRrGS4TXSb4/Tq6ikZiw2R9Ht38Dw==
X-Received: by 2002:adf:d851:: with SMTP id k17mr10256340wrl.254.1614593969442;
        Mon, 01 Mar 2021 02:19:29 -0800 (PST)
Received: from localhost.localdomain (2.b.a.d.8.4.b.a.9.e.4.2.1.8.0.5.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:5081:24e9:ab48:dab2])
        by smtp.gmail.com with ESMTPSA id a198sm14134600wmd.11.2021.03.01.02.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 02:19:29 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v3 5/5] selftests: bpf: don't run sk_lookup in verifier tests
Date:   Mon,  1 Mar 2021 10:18:59 +0000
Message-Id: <20210301101859.46045-6-lmb@cloudflare.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210301101859.46045-1-lmb@cloudflare.com>
References: <20210301101859.46045-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

sk_lookup doesn't allow setting data_in for bpf_prog_run. This doesn't
play well with the verifier tests, since they always set a 64 byte
input buffer. Allow not running verifier tests by setting
bpf_test.runs to a negative value and don't run the ctx access case
for sk_lookup. We have dedicated ctx access tests so skipping here
doesn't reduce coverage.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 tools/testing/selftests/bpf/test_verifier.c          | 4 ++--
 tools/testing/selftests/bpf/verifier/ctx_sk_lookup.c | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 58b5a349d3ba..1512092e1e68 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -105,7 +105,7 @@ struct bpf_test {
 	enum bpf_prog_type prog_type;
 	uint8_t flags;
 	void (*fill_helper)(struct bpf_test *self);
-	uint8_t runs;
+	int runs;
 #define bpf_testdata_struct_t					\
 	struct {						\
 		uint32_t retval, retval_unpriv;			\
@@ -1165,7 +1165,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 
 	run_errs = 0;
 	run_successes = 0;
-	if (!alignment_prevented_execution && fd_prog >= 0) {
+	if (!alignment_prevented_execution && fd_prog >= 0 && test->runs >= 0) {
 		uint32_t expected_val;
 		int i;
 
diff --git a/tools/testing/selftests/bpf/verifier/ctx_sk_lookup.c b/tools/testing/selftests/bpf/verifier/ctx_sk_lookup.c
index fb13ca2d5606..d78627be060f 100644
--- a/tools/testing/selftests/bpf/verifier/ctx_sk_lookup.c
+++ b/tools/testing/selftests/bpf/verifier/ctx_sk_lookup.c
@@ -239,6 +239,7 @@
 	.result = ACCEPT,
 	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
 	.expected_attach_type = BPF_SK_LOOKUP,
+	.runs = -1,
 },
 /* invalid 8-byte reads from a 4-byte fields in bpf_sk_lookup */
 {
-- 
2.27.0

