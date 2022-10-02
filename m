Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26525F2127
	for <lists+bpf@lfdr.de>; Sun,  2 Oct 2022 05:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiJBDVp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Oct 2022 23:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJBDVn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 1 Oct 2022 23:21:43 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406AC3498A;
        Sat,  1 Oct 2022 20:21:31 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id u21so1847002pfc.13;
        Sat, 01 Oct 2022 20:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=oORAsNAjlV+kGub6/vHK5sXENo+dkak9K21Z6qFMibM=;
        b=WUIDMUnCdiSZ2vk70Uu1Y/5q++VmzOQ4v8ps9ChRXoRdvDO42p8ZrndlEOYgNd+FDg
         Z9GhVBu04l5+2nN2pxWDHu70MlQJ7CjanierTmWDBHQo8qQZv2B8CtlqZ53aGqFPHmP3
         ZvvsgmfnJX8KbTrc0RjrtoA52fJBDfKhpDXLE/t/lWMMU98fxpDpw/PE6vELdwhjow9V
         /BeyaUI5VrYWVY2UPx0TcVAYjW15Bta+HDjgTMc9k18SPlb80JfPYXtNV4BOfUSKb3Z1
         NluKSAezx4u5AKfU4aaYYtBSE2dHh4gdf66D80lrhEBAZ+V8RNcY4H59I8khzBrRMdQ2
         gXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=oORAsNAjlV+kGub6/vHK5sXENo+dkak9K21Z6qFMibM=;
        b=Tb2kALimbMQmK+zEK7CP0Mlxf+x3LcJdbCuKlTLow0Khe4DxwtOKYiegUONwYxVB6O
         XFi/r9loMlr4lgTX2BI5hpog335IiJZ+W1jUhhRzfjeXaT0deIFjhbsVWj5qLBazeXhE
         CmCm5oxYg3DZSiJhpBwS5i8pOsdn24nClGltyHulmRP3oY295TZZSMDMM9r6J1CWrMr5
         cUq1v/XNqqWy/3Ax2YGoJ9pIghq7B4qN2mGadcHnxBWvYncc+n9fG/SY3a78h4QJZc2O
         ZLiD0NaSwrxYSJXNZvs0hgOs6I9Kk2YWw665lmMn1hP7WwWkbIx1TcqvrkP0GXwQ36RQ
         /x9w==
X-Gm-Message-State: ACrzQf2AfEDCfewHccWASjPHPJgxe5q9BK17h8sfTQ8Q6BUYFcgrlJ/N
        dKVU+r3blsXvnOsocfLVKjKc0obHygFnog==
X-Google-Smtp-Source: AMsMyM6zW/0rqYRGVYcWQTKjbD0LCFDqzX6jsFwXGq1kzQEiIIw1bI9y56FOUsRf2i19Yhz0zKO4Fg==
X-Received: by 2002:a05:6a00:198e:b0:541:f85a:6c27 with SMTP id d14-20020a056a00198e00b00541f85a6c27mr16318317pfl.81.1664680890502;
        Sat, 01 Oct 2022 20:21:30 -0700 (PDT)
Received: from debian.. (subs02-180-214-232-82.three.co.id. [180.214.232.82])
        by smtp.gmail.com with ESMTPSA id a23-20020aa79717000000b0056149203b60sm45921pfg.46.2022.10.01.20.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 20:21:30 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Dave Thaler <dthaler@microsoft.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH bpf-next] Documentation: bpf: Add implementation notes documentations to table of contents
Date:   Sun,  2 Oct 2022 10:20:23 +0700
Message-Id: <20221002032022.24693-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1456; i=bagasdotme@gmail.com; h=from:subject; bh=3FxgODjRXn/aDHCdRj+wx/Y2X1pOJpd+3lE9my6zu8k=; b=owGbwMvMwCH2bWenZ2ig32LG02pJDMmWzPmO74x4pNQuvD7g2DZjr5/c3piggMD2sMdz5m37suvO 6q3uHaUsDGIcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZjIZhdGhoXy7HGHd3OlFC5rvuis/J b54om/a3e8XMGw+Q1P9NWSJ7GMDBuEuQLk577eF9q9/bVr2bIPr6xVLvTZml1k1lvrKbvpPjcA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sphinx reported warnings on missing implementation notes documentations in the
table of contents:

Documentation/bpf/clang-notes.rst: WARNING: document isn't included in any toctree
Documentation/bpf/linux-notes.rst: WARNING: document isn't included in any toctree

Add these documentations to the table of contents (index.rst) of BPF
documentation to fix the warnings.

Link: https://lore.kernel.org/linux-doc/202210020749.yfgDZbRL-lkp@intel.com/
Fixes: 6c7aaffb24efbd ("bpf, docs: Move Clang notes to a separate file")
Fixes: 6166da0a02cde2 ("bpf, docs: Move legacy packet instructions to a separate file")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Hi bpf maintainers,

 This is last-minute fix due to upcoming merge window that will be open
 shortly on the next week.

 Documentation/bpf/index.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
index 1bc2c5c58bdbdc..1b50de1983ee2c 100644
--- a/Documentation/bpf/index.rst
+++ b/Documentation/bpf/index.rst
@@ -26,6 +26,8 @@ that goes into great technical depth about the BPF Architecture.
    classic_vs_extended.rst
    bpf_licensing
    test_debug
+   clang-notes
+   linux-notes
    other
 
 .. only::  subproject and html

base-commit: b502a6fb46d275aa978c1e0655bada2cafc81fea
-- 
An old man doll... just what I always wanted! - Clara

