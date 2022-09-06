Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2998F5AEAB6
	for <lists+bpf@lfdr.de>; Tue,  6 Sep 2022 15:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbiIFNox (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 09:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239371AbiIFNny (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 09:43:54 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35BB186C1
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 06:38:23 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e20so15465568wri.13
        for <bpf@vger.kernel.org>; Tue, 06 Sep 2022 06:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=LI8DCiu6TjIj4OulZQ/ctoBXW72bGsaE1sE9uyzbXoM=;
        b=Lj2hEeMm1oMmAa2X2cMg/JtZ1Ze8KzNCbIq+EF+wrvE9Yy2fE0c3dBEDY6Wltez/Zc
         zUNXQaXp3tii5Zv+YHQk8ztdWiMZ08+xOp5DEGkgXZ895Db3ogzeYtnu8KuVXQd4EeCO
         QE4nbojmSHAp6+p3PLFnQlQIYqIorvwCjt+IyWK6CkOO17GnGyXQLF5AhYFAOzPMZb9o
         ZWaa++po6FwuFeLlVzSTle8ccofvih9KDQDrtBvOmJf95fjCTR1vHygh82WeTn6b/hgb
         rKuqldrmvi7G89xNwxaBTux9mOnKkTuJ9EwBcEWYqeJ0+lpKo6AfgZTClyVDZ4oY2Lr4
         5J0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LI8DCiu6TjIj4OulZQ/ctoBXW72bGsaE1sE9uyzbXoM=;
        b=ZzFMy9MzLOcjout9/SCHvB/v9hin2p2P4KW/7JxjrDSYG9YWsuVMfY7QVU8P73ZjDa
         Ri16rtwWdCBcg4qe80jgNZUeU7HeuLGAMRXZO1t1/P5rH5TsP4oev3/HLGrwjbMNXE2H
         14SIWHp28Sfb6+wpxiuIm1pc6E5oL0a/SUrVoenH5kdv7nrXyUUl1bAEgCzucbcBbFCe
         b+eY8GxehM65Yp0iu17pp9Y/H7H5o0mbR4c2xfUxjMyaRgMtXfsyhRiSy6l3n63zo/et
         MV+BibJj2+SuVzsYbe9Oqv4dGsfmhoMCf81IYtd690dBdcRDojICJaVtFC7TonYxxClA
         JX7Q==
X-Gm-Message-State: ACgBeo3H18xbugck+FzzSyOWkQ9uT1mS6/GMwGYqW4rK8Sn2Ww8Boije
        5xF+AbpXFGsesw71Ou4jDAkmZw==
X-Google-Smtp-Source: AA6agR5C2+9R0i8dUUe3jeYG5H35Qbvnh5cvhAfaFL5hioqA5EnfjZnjjmXgm/CPYaVTcch/2oJCfQ==
X-Received: by 2002:a5d:550e:0:b0:228:da13:952c with SMTP id b14-20020a5d550e000000b00228da13952cmr1852407wrv.694.1662471394407;
        Tue, 06 Sep 2022 06:36:34 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id n189-20020a1ca4c6000000b003a5c244fc13sm21775621wme.2.2022.09.06.06.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 06:36:34 -0700 (PDT)
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
        bpf@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Andres Freund <andres@anarazel.de>
Subject: [PATCH bpf-next 3/7] bpftool: Split FEATURE_TESTS/FEATURE_DISPLAY definitions in Makefile
Date:   Tue,  6 Sep 2022 14:36:09 +0100
Message-Id: <20220906133613.54928-4-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906133613.54928-1-quentin@isovalent.com>
References: <20220906133613.54928-1-quentin@isovalent.com>
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

Make FEATURE_TESTS and FEATURE_DISPLAY easier to read and less likely to
be subject to conflicts on updates by having one feature per line.

Suggested-by: Andres Freund <andres@anarazel.de>
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/Makefile | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 04d733e98bff..8b5bfd8256c5 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -93,9 +93,16 @@ INSTALL ?= install
 RM ?= rm -f
 
 FEATURE_USER = .bpftool
-FEATURE_TESTS = libbfd disassembler-four-args disassembler-init-styled libcap \
-	clang-bpf-co-re
-FEATURE_DISPLAY = libbfd libcap clang-bpf-co-re
+
+FEATURE_TESTS := clang-bpf-co-re
+FEATURE_TESTS += libcap
+FEATURE_TESTS += libbfd
+FEATURE_TESTS += disassembler-four-args
+FEATURE_TESTS += disassembler-init-styled
+
+FEATURE_DISPLAY := clang-bpf-co-re
+FEATURE_DISPLAY += libcap
+FEATURE_DISPLAY += libbfd
 
 check_feat := 1
 NON_CHECK_FEAT_TARGETS := clean uninstall doc doc-clean doc-install doc-uninstall
-- 
2.34.1

