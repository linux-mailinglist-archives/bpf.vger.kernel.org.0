Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA566612C22
	for <lists+bpf@lfdr.de>; Sun, 30 Oct 2022 19:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJ3SDF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 30 Oct 2022 14:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3SDE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 30 Oct 2022 14:03:04 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCED18C;
        Sun, 30 Oct 2022 11:03:04 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id b29so8856568pfp.13;
        Sun, 30 Oct 2022 11:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n3bgwDu7yEbSlWh+oZ2tboVXfvOGKM5QoZOmwgtujng=;
        b=kcr7R+pEISD7rSvrr9wr03fiZOvKieVEESUSh5b79pBMJ6goa79lpWCoupHHv0zih/
         IbmHIdCpvq7YKq9Is6ZBuL5vv6O0banawYuJ4Smi/dwR8qmPyKzPHBNDeUEtJLz5KNwb
         cqG+Y+2lmtz5TWDj1gCaC3/oiVBQct6BFCcEp2uJu4iHAILrx11is4MOGG63yHVXUL1U
         ikQ5vTPTiNdkbe+U3nvuWRBzBE9Op+W0ZXpMni/IqG+k7waVtk9Z1YDA3wNLorTcBTtG
         ovmEbkN6ZBy7llq4uDdDjvovJ1ghoCgwfcms+zvx/+d6GrwuLhJGkePQb1AImQ6Zfbj3
         QJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3bgwDu7yEbSlWh+oZ2tboVXfvOGKM5QoZOmwgtujng=;
        b=FIzTqDK59vsh0bAnywJbBzHYLBp5ukFlQS54BR1AWFIj33qGBb9nYrtHKmFnHU+8L+
         Ew1ekxQ7uEzaFDbpISZmUDVgufA1Na8Gt4JPmQwIwdOOF0fmWpiiK/6c3b1gH9kGwv2+
         2P46awV2gkMBE4g0oWhmFCcDFe3AMOf4HVK6vs/wqsEEwWbAqQWWGug9dQ1zK4IY6N7o
         Q0hNMDWRvKbjQPLVswORrgD+9HZeaG++sxCKSk6FXFR56OvGAfTNP10ACMOqVrzp/xH4
         at2RfCHf66sAXQ1b7ikq3QmMH2u4do9kl6pNRktPMNPCPIpfDAGJxbfB8cZVV5OWrbr+
         vMjQ==
X-Gm-Message-State: ACrzQf3JOQnb1l1SDwphFmHKI62bRnQ13uR2QE0n9ScpkEFxyDUXUFsp
        eJAanYhwC/tpi0V20GoNgSB7e04zM7+M5yxO
X-Google-Smtp-Source: AMsMyM7svrXqRhOA9qSH7n/V0BWYlfXAQuV9YrP/sdh79ubDSvBvg5qx7BGXvNvRk3sFI8B9uEK6YA==
X-Received: by 2002:a05:6a00:10d4:b0:56c:fc55:610c with SMTP id d20-20020a056a0010d400b0056cfc55610cmr10212244pfu.6.1667152983566;
        Sun, 30 Oct 2022 11:03:03 -0700 (PDT)
Received: from uftrace.. ([14.5.161.231])
        by smtp.gmail.com with ESMTPSA id y189-20020a6264c6000000b00540f96b7936sm2905840pfb.30.2022.10.30.11.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 11:03:03 -0700 (PDT)
From:   Kang Minchul <tegongkang@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kang Minchul <tegongkang@gmail.com>
Subject: [PATCH v2] samples/bpf: fix typo in README
Date:   Mon, 31 Oct 2022 03:02:54 +0900
Message-Id: <20221030180254.34138-1-tegongkang@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix 'cofiguration' typo in BPF samples README.

Signed-off-by: Kang Minchul <tegongkang@gmail.com>
---
V1 -> V2: Amended the commit message more precisely

 samples/bpf/README.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/README.rst b/samples/bpf/README.rst
index 60c6494adb1b..af4934639133 100644
--- a/samples/bpf/README.rst
+++ b/samples/bpf/README.rst
@@ -87,7 +87,7 @@ Cross compiling samples
 -----------------------
 In order to cross-compile, say for arm64 targets, export CROSS_COMPILE and ARCH
 environment variables before calling make. But do this before clean,
-cofiguration and header install steps described above. This will direct make to
+configuration and header install steps described above. This will direct make to
 build samples for the cross target::
 
  export ARCH=arm64
-- 
2.34.1

