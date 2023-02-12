Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96D86935E5
	for <lists+bpf@lfdr.de>; Sun, 12 Feb 2023 04:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBLDwy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Feb 2023 22:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBLDwx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Feb 2023 22:52:53 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB47C11E99
        for <bpf@vger.kernel.org>; Sat, 11 Feb 2023 19:52:52 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id w5so10442220plg.8
        for <bpf@vger.kernel.org>; Sat, 11 Feb 2023 19:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PgeDiep57yqZOM9tBJGHWCt+l/2GlmGGj/5BxR/KoUM=;
        b=jZQnfx7PEytHc9wBW0FT7w2XXaOwvsSMaNSDBSsXNwpynEUGG+JmhGx6cDjZhCOibh
         9v4k+N2zNN7EdmZ69KXx1j58MkmAKnqoPBKa4o2jszHOwKOw004VtM0/evZwWuTC7IPp
         kYmph3Y0MwThZSLMgFbI+H7EgNNTg8oySHHvI2OmUrDDxXGwIroNGPTczgt7CbDuR2Hz
         xOSTycNhJa2KuF0N0YHj+PpasAqzre2GVJj31dIUwsNEujV4Opy/vfMEJFCinKMq3zB1
         +L8xHQpJ2BPxOArZm1D3cA0a/XoeLgq8Xfy9X6524bvbnERBw94uU26C9l+/esjxjlcu
         D7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PgeDiep57yqZOM9tBJGHWCt+l/2GlmGGj/5BxR/KoUM=;
        b=plaPIM7yJglTHFmUZvDF2ApwI0czliCv+wnpUXASH2KUI9FkU9STgG0G3H4kDsA+Y+
         X7VR5imwRnbPGKVHp3dyQmLvWF+9PdA4H/Wiq7nWrgvtxgmmRIMCL5rFSxnlSVPgg+in
         IpV7TQcPQECJHVy3czWmVsFP7bEwjg3e8ByLjP/wuxKAxpGzJZAJMRXIVUHk2WE2E+Y4
         RBndnTkMAweHCSiO8wOEbO888cPAbRedbkmDjkBLCdoN5bnUpghs0FBYgCMoPGmPukr2
         ggERvTCPVBe52S01xK5hrExziMQRLu+VtctGq8ZCv1PEiooMu8d9zRCHJPO2L1Kyxrpc
         d/jA==
X-Gm-Message-State: AO0yUKVOoTfRAP9LFO+dxklTIxRzaD0IP3rLJAF6B1LWSC06BBS5gC+S
        wipC6+oWzb3YoNjMEy2yeLqmc1G61Kw=
X-Google-Smtp-Source: AK7set+DCePLre4oTy3bjFr0clrDBIsqIeAwe7aiTJ+7oCIoo61sxgjMksnWkK6nWwAZGa9pFz5FxA==
X-Received: by 2002:a05:6a21:99a2:b0:bf:8aea:c555 with SMTP id ve34-20020a056a2199a200b000bf8aeac555mr24418942pzb.13.1676173972071;
        Sat, 11 Feb 2023 19:52:52 -0800 (PST)
Received: from localhost.localdomain ([43.132.141.9])
        by smtp.gmail.com with ESMTPSA id s1-20020a63dc01000000b004fab4455748sm5055399pgg.75.2023.02.11.19.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 19:52:51 -0800 (PST)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org, loongarch@lists.linux.dev
Cc:     hengqi.chen@gmail.com
Subject: [PATCH 0/2] Allow mixing bpf2bpf calls with tailcalls on LoongArch
Date:   Sun, 12 Feb 2023 11:52:34 +0800
Message-Id: <20230212035236.1436532-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.31.1
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

This patchset enables mixing bpf2bpf calls with tailcalls on LoongArch.

The first patch fixes JIT for function calls, like:

  [   29.346981] multi-func JIT bug 105 != 103

This is because we are emiting variable instructions for 64-bit immediate moves.
During the first pass of JIT, the placeholder address is just zero, emiting two
instructions for it. In the extra pass, the function address is in XKVRANGE,
emiting four instructions for it. This change the instruction index in JIT context.
Fix it by using a fixed 4-instruction sequence.

The second patch enables mixing bpf2bpf calls with tailcalls on LoongArch.

Hengqi Chen (2):
  LoongArch: BPF: Treat function address as 64-bit value
  LoongArch: BPF: Support mixing bpf2bpf and tailcalls

 arch/loongarch/net/bpf_jit.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

--
2.31.1
