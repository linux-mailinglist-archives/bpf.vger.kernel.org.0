Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592654AA2C4
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 23:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbiBDWFL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 17:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbiBDWFK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Feb 2022 17:05:10 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A76C061714
        for <bpf@vger.kernel.org>; Fri,  4 Feb 2022 14:05:05 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id t1so923499qtq.13
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 14:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qdfyFpDVpUT1ZBxa6A5YOPMbRXGMprHWtOCb3CXxF8w=;
        b=bHzLejQ7Ctq4KbKFB1FeAPg9lrAQ4oiMnFy43Wyh4iurvORb++vqwB8Q8AGQMlwZVX
         uHc5xEzrBoJEucA4gMwL++oNdKtA3UoE9bxNHmx1mlbWRfuWM7R9e7W6PYgChA8L2H68
         6HDi8NBa3r7XBSh7rl62B5KNg1/qcvgaOTLpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qdfyFpDVpUT1ZBxa6A5YOPMbRXGMprHWtOCb3CXxF8w=;
        b=6xD1FxOhBKCSGpN8mkRiKTmaJfWFanW+wATdPWvRJ8DUcpwQ/pSHtzVWlZi2QERZZ3
         /RfyVXIw8PjVZyoOjpCBfleo+D6vilFpPfnIKsArF5YQCL+qS9E13wkT0qNFDKqH4Nyv
         f0zEckYuYzBN3NhopIdpu+ri0rtFr5CNwQ4OzITzCC8i6U0l2R37OCDJY+Afkuen6atS
         V4dGZRP/Wp/IfJUwoTFR4mkSr85JymVNCQ4mYPAkKBR8GoIfmS5185JFUykVyq88U2Vh
         azLfMhdp2oM7q2aG7VPnB/qKMEtJ8ohERm1u001nu9TuKNSBN+5c9tpQuN3cfHjacam2
         P+Ww==
X-Gm-Message-State: AOAM533Xra1HkoDvAjOicMBTDc7KwxEsITnglIZtjA7Zh/j/JO13D1WT
        JpAJDNWkMJ4CNCADzEmzJxsO3LLfY5j25w==
X-Google-Smtp-Source: ABdhPJx9Ai49pCFOj6pdgEVMkOWBN7nJ1MaKjC+WJ5hmbXrZ/FfEkVOI1yfQWeMnBTzjOQzmZQy7Cw==
X-Received: by 2002:ac8:7dd4:: with SMTP id c20mr833923qte.167.1644012304089;
        Fri, 04 Feb 2022 14:05:04 -0800 (PST)
Received: from localhost.localdomain ([181.136.110.101])
        by smtp.gmail.com with ESMTPSA id a186sm1516427qkf.102.2022.02.04.14.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 14:05:03 -0800 (PST)
From:   =?UTF-8?q?Mauricio=20V=C3=A1squez?= <mauricio@kinvolk.io>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next] libbpf: Fix strict mode calculation
Date:   Fri,  4 Feb 2022 17:04:35 -0500
Message-Id: <20220204220435.301896-1-mauricio@kinvolk.io>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The correct formula to get all possible values is
((__LIBBPF_STRICT_LAST - 1) * 2 - 1) as stated in
libbpf_set_strict_mode().

Fixes: 93b8952d223a ("libbpf: deprecate legacy BPF map definitions")

Signed-off-by: Mauricio Vásquez <mauricio@kinvolk.io>
---
 tools/bpf/bpftool/main.c                     |  6 +++++-
 tools/testing/selftests/bpf/prog_tests/btf.c | 10 ++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 9d01fa9de033..c5b27e41d1e9 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -483,8 +483,12 @@ int main(int argc, char **argv)
 		/* Allow legacy map definitions for skeleton generation.
 		 * It will still be rejected if users use LIBBPF_STRICT_ALL
 		 * mode for loading generated skeleton.
+		 *
+		 * __LIBBPF_STRICT_LAST is the last power-of-2 value used + 1, so to
+		 * get all possible values we compensate last +1, and then (2*x - 1)
+		 * to get the bit mask
 		 */
-		mode = (__LIBBPF_STRICT_LAST - 1) & ~LIBBPF_STRICT_MAP_DEFINITIONS;
+		mode = ((__LIBBPF_STRICT_LAST - 1) * 2 - 1) & ~LIBBPF_STRICT_MAP_DEFINITIONS;
 		ret = libbpf_set_strict_mode(mode);
 		if (ret)
 			p_err("failed to enable libbpf strict mode: %d", ret);
diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 14f9b6136794..90d5cd4f504c 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -4533,6 +4533,7 @@ static void do_test_file(unsigned int test_num)
 	struct btf_ext *btf_ext = NULL;
 	struct bpf_prog_info info = {};
 	struct bpf_object *obj = NULL;
+	enum libbpf_strict_mode mode;
 	struct bpf_func_info *finfo;
 	struct bpf_program *prog;
 	__u32 info_len, rec_size;
@@ -4560,8 +4561,13 @@ static void do_test_file(unsigned int test_num)
 	has_btf_ext = btf_ext != NULL;
 	btf_ext__free(btf_ext);
 
-	/* temporary disable LIBBPF_STRICT_MAP_DEFINITIONS to test legacy maps */
-	libbpf_set_strict_mode((__LIBBPF_STRICT_LAST - 1) & ~LIBBPF_STRICT_MAP_DEFINITIONS);
+	/* temporary disable LIBBPF_STRICT_MAP_DEFINITIONS to test legacy maps
+	 * __LIBBPF_STRICT_LAST is the last power-of-2 value used + 1, so to
+	 * get all possible values we compensate last +1, and then (2*x - 1)
+	 * to get the bit mask
+	 */
+	mode = ((__LIBBPF_STRICT_LAST - 1) * 2 - 1) & ~LIBBPF_STRICT_MAP_DEFINITIONS
+	libbpf_set_strict_mode(mode);
 	obj = bpf_object__open(test->file);
 	err = libbpf_get_error(obj);
 	if (CHECK(err, "obj: %d", err))
-- 
2.25.1

