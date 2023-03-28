Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937CF6CB393
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 04:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjC1CI0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 22:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjC1CIZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 22:08:25 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A1F10F7
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 19:08:24 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id eh3so43606353edb.11
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 19:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679969303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XIN4N2FdPSeVC1kny4EBp3VbbWjDU8F2Z/wSWsYwmxc=;
        b=NJXAP4MSXMVXtqwMrZVmfATFBB5VSTSDAXyUJJihmlPJyBcjCj7ZB3Sx6zTDziWm1+
         sEa2eTyfl0jp5z94pFK1S8G9cxh5tExvtTPWmEuwqQKzkXHAMGAjLW+sS/BF3OpE+MiR
         VYc+0ujhU2N2op2xhUFSaWHhrfShxrqboxsLTxzsxbNB7EoXxnx8EB9/xCQaT2FOp1TZ
         DV9uqcR5WfZDfihUGrErNkzUI+GVwzrRI/OW9mDMVj/ie6K4wXE2I34rXOMtQv3ULRbq
         E/Xu9yQu8bPJRE/0MJJZ9ue7CuNpzXejPvgVWQrzCLj4ruKsiHoRaH/uco0NJmW/rWu6
         kGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679969303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XIN4N2FdPSeVC1kny4EBp3VbbWjDU8F2Z/wSWsYwmxc=;
        b=gCbyN/vCSoXXap11MSV8T1GT6lfZekIt8yv3VESvo3k9p4pHxqCI/RFv8yrvuxivWw
         VFANgeaatdhhv1Aswi2lO38kdAUAf8uowZ4pqmL1esIirFfWoqn8z3sGFXdYPaHuI/d8
         ycb0HnINsAO/CSe4/ZU09pS0z+UGy/0p4yvPd5dM87cIrf4Nh5T14Bz8EkMLvKMteLu4
         GqaPQCx9JBFQWUjUyBINyAe1T21JQL8EdDSvMaZLjmBhmx3vheNeVkAXiNvpJKfTJ8Zb
         IykqzpVl4EjydkT65XI7dVQK91W343AH3BSwqSmwNzXurIUf6BU45D2ovHMWJGmPWgxL
         jKjg==
X-Gm-Message-State: AAQBX9dHjeKjOTAD8k+xiIwYxZ5z9gN6OBfbyTh5GsTH/xxArmwpiEsb
        53D6DLSieorto0O9TURoaY9ByNHVBvsMQg==
X-Google-Smtp-Source: AKy350bYq5IX4//5jTtYpduuhXCdPHK32ZO50dvF3LzsYEYpz9aaeG61qApaF/5ElaqTMkKwyW20jA==
X-Received: by 2002:a17:906:3f89:b0:877:a9d2:e5e9 with SMTP id b9-20020a1709063f8900b00877a9d2e5e9mr15366528ejj.42.1679969302684;
        Mon, 27 Mar 2023 19:08:22 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id xh9-20020a170906da8900b009447277c26fsm2199573ejb.72.2023.03.27.19.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 19:08:22 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 0/2] verifier/xdp_direct_packet_access.c converted to inline assembly
Date:   Tue, 28 Mar 2023 05:08:11 +0300
Message-Id: <20230328020813.392560-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

verifier/xdp_direct_packet_access.c automatically converted to inline
assembly using [1].

This is a leftover from [2], the last patch in a batch was blocked by
mail server for being too long. This patch-set splits it in two:
- one to add migrated test to progs/
- one to remove old test from verifier/

[1] Migration tool
    https://github.com/eddyz87/verifier-tests-migrator
[2] First batch of migrated verifier/*.c tests
    https://lore.kernel.org/bpf/167979433109.17761.17302808621381963629.git-patchwork-notify@kernel.org/

Eduard Zingerman (2):
  selftests/bpf: verifier/xdp_direct_packet_access.c converted to inline
    assembly
  selftests/bpf: remove verifier/xdp_direct_packet_access.c, converted
    to progs/verifier_xdp_direct_packet_access.c

 .../selftests/bpf/prog_tests/verifier.c       |    2 +
 .../progs/verifier_xdp_direct_packet_access.c | 1722 +++++++++++++++++
 .../bpf/verifier/xdp_direct_packet_access.c   | 1468 --------------
 3 files changed, 1724 insertions(+), 1468 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_xdp_direct_packet_access.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/xdp_direct_packet_access.c

-- 
2.40.0

