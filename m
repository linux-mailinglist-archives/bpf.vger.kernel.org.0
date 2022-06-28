Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1262755EB4F
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 19:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbiF1RtG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 13:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbiF1Rsr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 13:48:47 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F3D64D3
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 10:48:32 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id p13so8689828ilq.0
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 10:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csp-edu.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3LBlOsHDDvMdp4y73P1jZxUXSiowmAwvg2Xs0aTbdiQ=;
        b=WNWZQLxtnV+XDSNndK3uTuvHqQcoFqbdsbXNLG3WG/5u7zQsy836LJBWNMrB6jkmtP
         2nUd/0YOGpoFgmxeHRthpfuaLm7Il7xiS+GtRH6Dh0N/MgVRiegDY9Lv/TM2RTA389XR
         VZtT2RpsfggYMFOAjrXxL75Y5AW/5diMbm6NLevXIGyaoBvpjo6TPEY4XSZAom6Ol2zG
         6aX5ZuBR48nkQpgXM1b9bT59GhBr3jwzWphxSDZOrpCk7uHoFE5fQv9gxrCbK9pBa4xY
         GPzEykKXAQ06WWCf2vvn0tIJLHQr2eEtwWa+z/2zMt0mHZEPgzj5T36n2CjnJ7L8DpT7
         P1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3LBlOsHDDvMdp4y73P1jZxUXSiowmAwvg2Xs0aTbdiQ=;
        b=AjwnnBC42Dc6enVHc+0Wxw1IKQokq+EZvydjpruRU+3y6oDWeDxvw0ek4Q2dHXIJvF
         zwUlHQZ4CeezTb3bkJJtQ1tR/T7R7RMV8rNKI2NnNrUjzbGh3wPCduSfqIHjgFUEkEzl
         aL8QdY1F4cYDwuzB3onNwtfOXM4eFXOjWuc/QsXQbxu1IFt1mX1TzKOt1U9dAdL7TqcU
         K7CqC1UF2oASLcgWzMk9uv1mc019dhnUsF0xUinKlDtFBA8y6/yZQYHUMK5aVZWacg2y
         tdkWfy2xI1iNr7GfYle22JygchRnSKeQNYpnTBhUWJK3HLVIS8SPsbhHXnTbtfMlDO4E
         zqhw==
X-Gm-Message-State: AJIora/m+B+YPUsFlvduhffkwNomSMGb5dS33DHNPGAR5x/c9Dv5v/bB
        z2lqiTN1ukfDJr6rjBOEts8icQ==
X-Google-Smtp-Source: AGRyM1sgcFYWfJ9UEVGyZgKpCri6wKICjkhE65hbuPqiGbd6RUWnd42zOoe4rRwk3R043c4MnVYl/g==
X-Received: by 2002:a92:d94f:0:b0:2d9:3ebe:7252 with SMTP id l15-20020a92d94f000000b002d93ebe7252mr10884416ilq.279.1656438511968;
        Tue, 28 Jun 2022 10:48:31 -0700 (PDT)
Received: from kernel-dev-1 (75-168-90-187.mpls.qwest.net. [75.168.90.187])
        by smtp.gmail.com with ESMTPSA id p3-20020a92da43000000b002daa3e1fe85sm1703442ilq.58.2022.06.28.10.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 10:48:31 -0700 (PDT)
From:   Coleman Dietsch <dietschc@csp.edu>
To:     linux-kselftest@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Coleman Dietsch <dietschc@csp.edu>
Subject: [PATCH] selftests net: fix kselftest net fatal error
Date:   Tue, 28 Jun 2022 12:47:44 -0500
Message-Id: <20220628174744.7908-1-dietschc@csp.edu>
X-Mailer: git-send-email 2.34.1
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

The incorrect path is causing the following error when trying to run net
kselftests:

In file included from bpf/nat6to4.c:43:
../../../lib/bpf/bpf_helpers.h:11:10: fatal error: 'bpf_helper_defs.h' file not found
         ^~~~~~~~~~~~~~~~~~~
1 error generated.

Signed-off-by: Coleman Dietsch <dietschc@csp.edu>
---
 tools/testing/selftests/net/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/bpf/Makefile b/tools/testing/selftests/net/bpf/Makefile
index 8a69c91fcca0..8ccaf8732eb2 100644
--- a/tools/testing/selftests/net/bpf/Makefile
+++ b/tools/testing/selftests/net/bpf/Makefile
@@ -2,7 +2,7 @@
 
 CLANG ?= clang
 CCINCLUDE += -I../../bpf
-CCINCLUDE += -I../../../lib
+CCINCLUDE += -I../../../../lib
 CCINCLUDE += -I../../../../../usr/include/
 
 TEST_CUSTOM_PROGS = $(OUTPUT)/bpf/nat6to4.o
-- 
2.34.1

