Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B0A64831C
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 14:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiLIN6t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Dec 2022 08:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLIN6s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 08:58:48 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B003675BC5
        for <bpf@vger.kernel.org>; Fri,  9 Dec 2022 05:58:47 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id fc4so11619105ejc.12
        for <bpf@vger.kernel.org>; Fri, 09 Dec 2022 05:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BnAn+O0EQKCuwxsZgkkPRvuoLosMXCph/6+7EgI/Ejw=;
        b=jctk4i3G6Qz4xAJufuthTnK9tty4y4KW++hd/xVG8yxQd0PY0yuXjjOOLJW6+eOuP7
         8vYdhePL7aKrKiGkeGuXklNCKCo4EHqXldnY8f3Xel8xSuS+n6uzuG+9UYjiytvxOtiO
         5tWfbBtPOGOOumgas2djT1fnlGkKP/w58GKH5/Lfspso04owKAnQjf3uhcmcy203SC8b
         3nlwyq+CXregxpA7gCRmX+ylovqi3EiKAOufMwebi6QxbWTzZHtPkGs/t6q9sgRea4qM
         OBBUB7jax1GnU48CKb6Yumwz1fSYcbHI16KKQ3XOS4ckvVukin3JOHHTBHljNz4Z9FAE
         Ww3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BnAn+O0EQKCuwxsZgkkPRvuoLosMXCph/6+7EgI/Ejw=;
        b=c0DxHyNel3FEzC5L5vs0/wPofNvIrVluEVb38F8zWMX+1g+ijfvXY9qkeH8XLxm4Jm
         Yda9R5ZJiG2+yDRqZ1vKb6FmG7KaRtWQ3cKALsEN6tmV/75BcHOUSGdKpnqCjODh+r4B
         Vavppi/PBcsa0Ro1sno/Bgje2Qqrbdb1JmlbQpmXZIWOMFpVSeqhQBdTpRRh+dw38+hm
         wxro2ZtRuejWR36Er2/t08plJCWftjSYN3g65B8E+As12WFTYsg6QjSdSWRqCuR+2r5L
         EQOHhw/lwHCojO1B9oOOuweiCju6lGlGDU/RAbvUhcb1yTO+XTCxr/4Tg9aYSmAOjrbi
         A5+Q==
X-Gm-Message-State: ANoB5plwhjRC0yWXDNIZ06GjE/TgLggEO0Dw/0ZWV1F1petLQ9IthDeM
        IPEXY0HArdB3E58CQHFULIyX8NdVq2Tn5w==
X-Google-Smtp-Source: AA0mqf617SpKL22goTDayDP8AXwSLP2NVoXTWvUOO/qxMokkqQU04yT3hCEW5i3ku0p6Y99P52UQDg==
X-Received: by 2002:a17:906:eda6:b0:7c0:d2b2:eb07 with SMTP id sa6-20020a170906eda600b007c0d2b2eb07mr4479807ejb.26.1670594325912;
        Fri, 09 Dec 2022 05:58:45 -0800 (PST)
Received: from pluto.. (178-133-28-80.mobile.vf-ua.net. [178.133.28.80])
        by smtp.gmail.com with ESMTPSA id j6-20020a170906830600b007c10fe64c5dsm589028ejx.86.2022.12.09.05.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 05:58:45 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, memxor@gmail.com, ecree.xilinx@gmail.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 0/7] stricter register ID checking in regsafe()
Date:   Fri,  9 Dec 2022 15:57:26 +0200
Message-Id: <20221209135733.28851-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This patch-set consists of a series of bug fixes for register ID
tracking in verifier.c:states_equal()/regsafe() functions:
 - for registers of type PTR_TO_MAP_{KEY,VALUE}, PTR_TO_PACKET[_META]
   the regsafe() should call check_ids() even if registers are
   byte-to-byte equal;
 - states_equal() must maintain idmap that covers all function frames
   in the state because functions like mark_ptr_or_null_regs() operate
   on all registers in the state;
 - regsafe() must compare spin lock ids for PTR_TO_MAP_VALUE registers.

The last point covers issue reported by Kumar Kartikeya Dwivedi in [1],
I borrowed the test commit from there.
Note, that there is also an issue with register id tracking for
scalars described here [2], it would be addressed separately.

[1] https://lore.kernel.org/bpf/20221111202719.982118-1-memxor@gmail.com/
[2] https://lore.kernel.org/bpf/20221128163442.280187-2-eddyz87@gmail.com/

Eduard Zingerman (6):
  bpf: regsafe() must not skip check_ids()
  selftests/bpf: test cases for regsafe() bug skipping check_id()
  bpf: states_equal() must build idmap for all function frames
  selftests/bpf: verify states_equal() maintains idmap across all frames
  bpf: use check_ids() for active_lock comparison
  selftests/bpf: test case for relaxed prunning of active_lock.id

Kumar Kartikeya Dwivedi (1):
  selftests/bpf: Add pruning test case for bpf_spin_lock

 include/linux/bpf_verifier.h                  |   4 +-
 kernel/bpf/verifier.c                         |  48 ++++----
 tools/testing/selftests/bpf/verifier/calls.c  |  82 +++++++++++++
 .../bpf/verifier/direct_packet_access.c       |  54 +++++++++
 .../selftests/bpf/verifier/spin_lock.c        | 114 ++++++++++++++++++
 .../selftests/bpf/verifier/value_or_null.c    |  49 ++++++++
 6 files changed, 324 insertions(+), 27 deletions(-)

-- 
2.34.1

