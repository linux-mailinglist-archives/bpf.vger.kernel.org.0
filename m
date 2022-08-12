Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C240591329
	for <lists+bpf@lfdr.de>; Fri, 12 Aug 2022 17:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237931AbiHLPhe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Aug 2022 11:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237169AbiHLPhd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Aug 2022 11:37:33 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323605C367
        for <bpf@vger.kernel.org>; Fri, 12 Aug 2022 08:37:32 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z16so1574522wrh.12
        for <bpf@vger.kernel.org>; Fri, 12 Aug 2022 08:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=A2o6e3Nij8KZL7IeimjJtlfpagEjmLoVO1Ru10BHdf4=;
        b=xWcbYAkFNSHYqydrZpJNxLC68wCVdWTjJXwETMTeiW7PNBLchDNJvi38PS3KcXvDX4
         rGv+Me0bn5FdAKIm6CmzYjln7GOOLi03fIJmE70Ext3ND298yRnAVLMyhSVdWwV3w/OL
         Kqs9LUFbNC9EhYiwaJ70rSOdoCkdzh3eCUBnHXfNgiNHJqc8tX+ykCxT6jQczVha9FX2
         i5VdeAnkxAhHefC4ZenvXywm8OIhNPYREC7pQKUnpQ6hqPxG+LhA3tylGmyFj2edMh60
         MvZzt2edl2kLj+BBmFaHz1W9h3vbBBlmON0QQdpsm5hpGXdlSdjmc12aiaeBcyG2foYk
         +uHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=A2o6e3Nij8KZL7IeimjJtlfpagEjmLoVO1Ru10BHdf4=;
        b=1Q1t0El2DjH8JN1BFUnOZcn3UVJRRb1PrLS6cPDWsVQigkVZQLEQIZfoL7btQ5gyjf
         NQflAvaHYdk69ABTk7YIioVqunXReO0ty14qBj4SLhL58qKUnKjvD7GVa/dOHEKdUqY1
         IfN7w6eA2nXMmYwDk2u1HZ6m8LnyAu2rFHITmRnRBrubALIK7N/E2KjfBYkSrYbEW64c
         G8JY6CX9y7v1bZcbg2TizLgzdDqv3qqiWBEqm6q5MDR7lLaYVj8YasOoXQR6a+zqw42L
         hwsu3sNX1rJOA5TsDoT+YtctiiPGaN8A0jDquQOOQOSHZvfSVZUZ/xOKfbQh41/SKmLE
         JfkQ==
X-Gm-Message-State: ACgBeo1poiP6UdhbpqofC2xU0V0HEafjyIydMw7/x1KgXwTL5/fcGdVn
        qOohpw9S9eQKma0dSG3A30M4eA==
X-Google-Smtp-Source: AA6agR4Ld0xuV8EDliXl4qqeb+GcEqjgdhIQR3dRnF+q2gukMmZ7tvia1EFzAC7qYyiszleOibFV+g==
X-Received: by 2002:a05:6000:186b:b0:220:5bf8:a5e8 with SMTP id d11-20020a056000186b00b002205bf8a5e8mr2525072wri.328.1660318650559;
        Fri, 12 Aug 2022 08:37:30 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id l25-20020a1ced19000000b003a502c23f2asm9410138wmh.16.2022.08.12.08.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 08:37:30 -0700 (PDT)
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
Subject: [PATCH bpf-next] bpftool: Fix a typo in a comment
Date:   Fri, 12 Aug 2022 16:37:25 +0100
Message-Id: <20220812153727.224500-1-quentin@isovalent.com>
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

This is the wrong library name. Libcap, not libpcap.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/feature.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index 7ecabf7947fb..36cf0f1517c9 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -1147,7 +1147,7 @@ static int handle_perms(void)
 	return res;
 #else
 	/* Detection assumes user has specific privileges.
-	 * We do not use libpcap so let's approximate, and restrict usage to
+	 * We do not use libcap so let's approximate, and restrict usage to
 	 * root user only.
 	 */
 	if (geteuid()) {
-- 
2.25.1

