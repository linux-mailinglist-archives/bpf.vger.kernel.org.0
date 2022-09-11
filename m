Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425475B5118
	for <lists+bpf@lfdr.de>; Sun, 11 Sep 2022 22:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiIKUPL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Sep 2022 16:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiIKUPI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Sep 2022 16:15:08 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D531A817
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 13:15:05 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bj14so12252179wrb.12
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 13:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ixQHMERYdgRb7FUM1/1Io76g7S2tfmEKG93IxR6PYMU=;
        b=wkJdJFZkR0v25pHG3qJEVRrlgKFSoACgyrOZS+S32uO1OxMERcJXgi3KWeZnFh7KJu
         11/S6DG5rw+9y1bz+PTn+n3O2vk7JSaednJKaGq21v2zKTECv1bxH7ZfIiqa0Iuc0nJw
         jH0Za3r89FKnsfLwF4swsodKkHQPwFiHf25oTFSECq01/YhznJVDXU1w6o/zl+d2U9ZJ
         N3Ou44JJlOb0KueO76jKS3eyfE2BZ1jRfCiTKV0uzNB1ubSvWUYC05x3h14sRakWVvqZ
         /tiKfXaMZmzXo1QHRSH5dLqcaS2/UjykVEZ0dqVAhboIHsl1/cKXY/jevwYUWIydifCi
         dXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ixQHMERYdgRb7FUM1/1Io76g7S2tfmEKG93IxR6PYMU=;
        b=5NZabnH3tx4tbQnBTb2jTYM3ST4ddm1fOcJ2JTk+GSC2EnZxKCkwsDQf7vgwGV/lgn
         iS14bXrQCUrkGftCe+L8YQBAowervzAMpj+JV5VFSZdLmJ8EtFJ0y5eZYNwVpjORsH5G
         PGC71h/0vWqGvlRRtsP9jvv2sgAHERUmFGnUviRryKImGrDX0iOJuQ7bT45tVoCDOslC
         FpYbNFFDnpZ+0k8ZbaEXYdndTrKf/zyX0LjwbzNBHw3k509GtOV9MdXsI/5ewLdMhR/o
         K4rVawssjx4qb2dKzK41Lmyx7CL+QcMWcgjHxTaJAjhNlBTbRoQq69/LYyt0JMskHv5f
         tNAg==
X-Gm-Message-State: ACgBeo0QT9uuS12po6cg3yaHcLAQ6GeTSazGoEFMdlK6yd66WbY0tkqS
        wsBhDt7ZUgXOxQEIYSNpsY38Kw==
X-Google-Smtp-Source: AA6agR7wIncRH+kS9Za/sTkPpPPqlp1hINZlv0AyJPvzSYk2YWDn4W4RRuF+7PAXevo/1tg9HoQxiw==
X-Received: by 2002:a5d:45c4:0:b0:228:9248:867d with SMTP id b4-20020a5d45c4000000b002289248867dmr13163772wrs.474.1662927304477;
        Sun, 11 Sep 2022 13:15:04 -0700 (PDT)
Received: from harfang.access.network ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id bh16-20020a05600c3d1000b003a60ff7c082sm7603789wmb.15.2022.09.11.13.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 13:15:03 -0700 (PDT)
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
        Andres Freund <andres@anarazel.de>, Song Liu <song@kernel.org>
Subject: [PATCH bpf-next v2 3/8] bpftool: Split FEATURE_TESTS/FEATURE_DISPLAY definitions in Makefile
Date:   Sun, 11 Sep 2022 21:14:46 +0100
Message-Id: <20220911201451.12368-4-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220911201451.12368-1-quentin@isovalent.com>
References: <20220911201451.12368-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Tested-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Acked-by: Song Liu <song@kernel.org>
---
 tools/bpf/bpftool/Makefile | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 4a95c017ad4c..0218d6a1cae7 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -93,11 +93,20 @@ INSTALL ?= install
 RM ?= rm -f
 
 FEATURE_USER = .bpftool
-FEATURE_TESTS = libbfd libbfd-liberty libbfd-liberty-z \
-	disassembler-four-args disassembler-init-styled libcap \
-	clang-bpf-co-re
-FEATURE_DISPLAY = libbfd libbfd-liberty libbfd-liberty-z \
-	libcap clang-bpf-co-re
+
+FEATURE_TESTS := clang-bpf-co-re
+FEATURE_TESTS += libcap
+FEATURE_TESTS += libbfd
+FEATURE_TESTS += libbfd-liberty
+FEATURE_TESTS += libbfd-liberty-z
+FEATURE_TESTS += disassembler-four-args
+FEATURE_TESTS += disassembler-init-styled
+
+FEATURE_DISPLAY := clang-bpf-co-re
+FEATURE_DISPLAY += libcap
+FEATURE_DISPLAY += libbfd
+FEATURE_DISPLAY += libbfd-liberty
+FEATURE_DISPLAY += libbfd-liberty-z
 
 check_feat := 1
 NON_CHECK_FEAT_TARGETS := clean uninstall doc doc-clean doc-install doc-uninstall
-- 
2.34.1

