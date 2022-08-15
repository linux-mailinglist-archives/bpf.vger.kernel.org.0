Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DE0593312
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 18:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbiHOQY2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 12:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbiHOQYO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 12:24:14 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CF729CB8
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 09:22:13 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m10-20020a05600c3b0a00b003a603fc3f81so173167wms.0
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 09:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=4p2xt3j+BhLytyffk/lmb1GEEiuCcAsHYH43bZ+ctBs=;
        b=JV5VaFP9fmG4kbi8Y5fQHcPf0cb9hLQaeOrJ8kocgVWqtmDJZPI4j1aYs2o18SFQN7
         5GlJHnzbc5/rl/yJeAyt+EsNAZBe8UiEbEmP4zZE7qGhj6BbO93V0GEKiVJLtt3HG/eB
         y6akcSOLvnFKe8h3zcv+wrg7cj6UYrNJ4nYGYZRwZTQSUuZh+hmkHAFaes4kjs62QGmw
         jr9zJ543RUB67Ch7HS1A3Aakk6WEUav9YRjSmAODS4Hcw1lk+EyGLpAAlVuR3jmtTToU
         25SyflFq3Vy80Skoa2icWZscB297EuEZg6SeJoWyDGAzpfVAU6t3uvAYvhpo9HbM09lU
         p8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=4p2xt3j+BhLytyffk/lmb1GEEiuCcAsHYH43bZ+ctBs=;
        b=sb7RZUiWa6RdWQB5CTe/PTkSGVDb0Ak1RxA8rcCh0Wr2JEqVbrd3CyKs/V9DtgZekA
         yxSgdSCYDYKVNc4boQpOd3Gkvf0CLsbsO2Gk5pw9EoPB7+2DvUhBDbHwstUhn4s89FKI
         LVvfUIU08Jk99NCadx2+b4jfbLaei82SCLs1fH+xJRasjUGGuvCdt0dKq28iIN6FWffM
         R3Xljj99sDf+qil6lIvvo7kXl/CYJkuRXiPy5km83ScNJ/rAxpd1Sz4qgnIZIhOlaMnO
         bXW91IIbeibzTGR/Bc5KO+Id/FtGe8s3J8QEjEOHAgMEKvyJ1N+RZqTdyo30ZyGbQhKV
         4EzQ==
X-Gm-Message-State: ACgBeo32pe+L16FuebST/zyI0VnpG17UUaClotajDilaCMiqAF6TJClX
        iuFdTvHw5kBziANXKj/BOTKTQA==
X-Google-Smtp-Source: AA6agR4jff+LCebNsywezXexMufeyOLRj/okct8dxgq1DsRZI4q58+KfOesLiehD6poGK3K/2mF+OA==
X-Received: by 2002:a05:600c:27cb:b0:3a5:cd14:269d with SMTP id l11-20020a05600c27cb00b003a5cd14269dmr9766687wmb.128.1660580530739;
        Mon, 15 Aug 2022 09:22:10 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id g7-20020a05600c4ec700b003a3170a7af9sm10269028wmq.4.2022.08.15.09.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 09:22:10 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v2] bpftool: Clear errno after libcap's checks
Date:   Mon, 15 Aug 2022 17:22:05 +0100
Message-Id: <20220815162205.45043-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When bpftool is linked against libcap, the library runs a "constructor"
function to compute the number of capabilities of the running kernel
[0], at the beginning of the execution of the program. As part of this,
it performs multiple calls to prctl(). Some of these may fail, and set
errno to a non-zero value:

    # strace -e prctl ./bpftool version
    prctl(PR_CAPBSET_READ, CAP_MAC_OVERRIDE) = 1
    prctl(PR_CAPBSET_READ, 0x30 /* CAP_??? */) = -1 EINVAL (Invalid argument)
    prctl(PR_CAPBSET_READ, CAP_CHECKPOINT_RESTORE) = 1
    prctl(PR_CAPBSET_READ, 0x2c /* CAP_??? */) = -1 EINVAL (Invalid argument)
    prctl(PR_CAPBSET_READ, 0x2a /* CAP_??? */) = -1 EINVAL (Invalid argument)
    prctl(PR_CAPBSET_READ, 0x29 /* CAP_??? */) = -1 EINVAL (Invalid argument)
    ** fprintf added at the top of main(): we have errno == 1
    ./bpftool v7.0.0
    using libbpf v1.0
    features: libbfd, libbpf_strict, skeletons
    +++ exited with 0 +++

This has been addressed in libcap 2.63 [1], but until this version is
available everywhere, we can fix it on bpftool side.

Let's clean errno at the beginning of the main() function, to make sure
that these checks do not interfere with the batch mode, where we error
out if errno is set after a bpftool command.

[0] https://git.kernel.org/pub/scm/libs/libcap/libcap.git/tree/libcap/cap_alloc.c?h=libcap-2.65#n20
[1] https://git.kernel.org/pub/scm/libs/libcap/libcap.git/commit/?id=f25a1b7e69f7b33e6afb58b3e38f3450b7d2d9a0

v2:
- Make the comment more meaningful
- Comment on v2.63 fixing the issue on libcap side
- Only reset errno if libcap is in use

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 451cefc2d0da..ccd7457f92bf 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -435,6 +435,16 @@ int main(int argc, char **argv)
 
 	setlinebuf(stdout);
 
+#ifdef USE_LIBCAP
+	/* Libcap < 2.63 hooks before main() to compute the number of
+	 * capabilities of the running kernel, and doing so it calls prctl()
+	 * which may fail and set errno to non-zero.
+	 * Let's reset errno to make sure this does not interfere with the
+	 * batch mode.
+	 */
+	errno = 0;
+#endif
+
 	last_do_help = do_help;
 	pretty_output = false;
 	json_output = false;
-- 
2.25.1

