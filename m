Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B39B6834E9
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 19:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjAaSMj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 13:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjAaSMg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 13:12:36 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6243D30B22
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:12:35 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h16so15027064wrz.12
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3L/fWcvdj5YA10dhKmkJdrnzelFzc0ImmESK2pqDOKI=;
        b=QQmdH2d0nsYr5Tm2EK55bJqvz4frLsth6xzNRBqCo/pYdCfu0LdaxbI+sGJa7XQmaA
         UYeThzHqqtgyHm4touJTseLlqdXvLUvV56xNp8dIdHTdNkcNtrzKDkhPvNs1c/J9fC/W
         aD/mBDxUKnDD6BCuryRleVEz6n25Dg4LwVmss461Bob++0U6W52Epv/pB8ru9/ZFvMjA
         dEB6v4sWKN5ASVq2UbRIYFqidjBFhQtmAboUhO4wbtEleR3eoO9g1Aox7glSLlDr1nLn
         +vaqc8vSrbDX8P7DWn3RHp2uQsY4IYKLrmfJf2SgRgchYIJsM7BEFMpfvrtpXc0wTPwq
         Rtfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3L/fWcvdj5YA10dhKmkJdrnzelFzc0ImmESK2pqDOKI=;
        b=JYqWiBBHsqqSiq0KL1wwiTllXKAhjB/nhhDdvLQF1EhQQ0N8YqS4T1eySveHhJuCwN
         kH7WRHqOStvXz6XAyZiSd2j3Y7ZuWDu+jj+9amOW78tUbRULWL8xJWRM1ai6qJu0M+Yn
         riz85eN6Fhqny8gAF1qoATWDHIgDEMf+IB4cbN3bgCFliGwwqGoBmItVWSo6r+GGP8DI
         xO1QVfqiy4nJqK8N6pBRbvG24ZDuEeqlWNqvuQFVjzic/ZEWVoPYgGkUv0dGcoXWKUBB
         dDSnxplUeyZDjd/egXzY6OLO/nRNKjVQs8gmGzKODioPXIQQ+SY/vbeBGGoa93KULnoz
         NYfQ==
X-Gm-Message-State: AO0yUKVsdU+zmiat/qbCddvb5tr63ASPD/uidYOa/zdR4ymfgWohF1qb
        lCwQTZXOVxdF8RFgyKZ2Zn4eQetmk6rj7Q==
X-Google-Smtp-Source: AK7set/foqfMMdwYLx1QsDSZkB0BRrbCHdb1cMgHNytG3oKiuTK2fSMHF/gnKCplLstJwYWR9uibvw==
X-Received: by 2002:a5d:534c:0:b0:2bf:cfc0:ac71 with SMTP id t12-20020a5d534c000000b002bfcfc0ac71mr17385496wrv.53.1675188753492;
        Tue, 31 Jan 2023 10:12:33 -0800 (PST)
Received: from pluto.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z12-20020a5d4d0c000000b002bbb2d43f65sm15409044wrt.14.2023.01.31.10.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 10:12:32 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com, ecree.xilinx@gmail.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 0/1] docs/bpf: Add description of register liveness tracking algorithm
Date:   Tue, 31 Jan 2023 20:11:17 +0200
Message-Id: <20230131181118.733845-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

An overview of the register tracking liveness algorithm.
Previous versions posted here: [1], [2].
- Changes from RFC to v1 (suggested by Andrii Nakryiko):
  - wording corrected to use term "stack slot" instead of "stack spill";
  - parentage chain diagram updated to show nil links for frame #1;
  - added example for non-BPF_DW writes behavior;
  - explanation in "Read marks propagation for cache hits" is reworked.
- Changes from v1 to v2:
  - lot's of grammatical / wording fixes as suggested by David Vernet;
  - "Register parentage chains" section is fixed to reflect what
    happens to r1-r5 when function call is processed (as suggested by David and Alexei);
  - Example in "Liveness marks tracking" section updated to explain
    why partial writes should not lead to REG_LIVE_WRITTEN marks
    (suggested by David);
  - "Read marks propagation for cache hits" section updates:
    - Explanation updated to hint why read marks should be propagated
      before jumping to example (suggested by David);
    - Removed box around B/D in the diagram updated (suggested by Alexei).

[1] https://lore.kernel.org/bpf/20230124220343.2942203-1-eddyz87@gmail.com/
[2] https://lore.kernel.org/bpf/20230130182400.630997-1-eddyz87@gmail.com/

Eduard Zingerman (1):
  docs/bpf: Add description of register liveness tracking algorithm

 Documentation/bpf/verifier.rst | 280 +++++++++++++++++++++++++++++++++
 1 file changed, 280 insertions(+)

-- 
2.39.0

