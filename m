Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3814165A946
	for <lists+bpf@lfdr.de>; Sun,  1 Jan 2023 09:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjAAIeJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 1 Jan 2023 03:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjAAIeI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 1 Jan 2023 03:34:08 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264F42AC5
        for <bpf@vger.kernel.org>; Sun,  1 Jan 2023 00:34:07 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id m7-20020a17090a730700b00225ebb9cd01so18030970pjk.3
        for <bpf@vger.kernel.org>; Sun, 01 Jan 2023 00:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=41J6sbp1oqLox8j2lSCpQyHOqor/I1SSkTi7Ee/zp3A=;
        b=BFTWUdi2ACz5gCtnKeA0MWP7Gi2oEM95zWwteTR0bBKb8kNSxxl4p9DRQ7XHjJ+H+a
         kU5LgqOfm1FfqYeCf64fpAZPpUftszGydhGir0nRW+tLI6Z3/fPdHLMPS1pBZIZ5VJ0V
         OLK3i/wZvaD2wF2mljEgaHG9KtAsJUMxlU6pSWXwnkL94/pyJS+bT+TNJgLjcz4mO3JR
         9lD6Q3akHceqHtODLTpbSpcWzWNOfgKjgpzs+mNyzaeLdz0EnAMYrxXfs7FaUKGrlhZy
         A/rmOr7I4B5gSrhJ+Zgm1lwsQJdyUONohMVBBIXJXu7aDos5WoooQuzHtf2utFunR9MA
         NFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=41J6sbp1oqLox8j2lSCpQyHOqor/I1SSkTi7Ee/zp3A=;
        b=AsWuFGqp0z71Gh8TFoeWl81HuGWAMpibtIGh7qOCvtfAquQczLXfZ+58MZpC1cb1z+
         bNtlDKFFjpD7e1hq6mqUJm9GQB5Z0XZz1ZBVpbfim/srbgdTD9o0Ss4o3mNFTPp01+Oa
         MbZOrGePlsDoe5GTht9f0yzrwBiM2f4FAYEcjQUMqYXkHsou0Lp43hGPrARuuH0gmmp9
         lZ2lqu+qWgR9ZlPMAWvH7TYDWJdUyLNzsOeblx9dDy824lJaeTSG6ts9VPA6PZ6S8hOg
         i2Z1cWeEs45sBO01UCZmcUShA8R3JdIo69qicDEw7SMXtmDtHtLaXo7zhDXCy3xTOP3A
         3jHw==
X-Gm-Message-State: AFqh2koYmnrKl4RMmN7uNDqiIzT2znxj1K9FImrUjCtx8FU2+GArDQOr
        jz35idzHombIyu0PVMGqZjUOyeUDLc4oltkD
X-Google-Smtp-Source: AMrXdXv7Yl59ygNrry3r1WIYtPFZZ3qrmLRxfGAOxWnnyzb0p8Lt3Q5Y0nZpWl44m4GCc3PDIE0sJw==
X-Received: by 2002:a17:90a:fa6:b0:225:da94:58e0 with SMTP id 35-20020a17090a0fa600b00225da9458e0mr27131022pjz.23.1672562046367;
        Sun, 01 Jan 2023 00:34:06 -0800 (PST)
Received: from localhost ([2405:201:6014:d8bc:6259:1a87:ebdd:30a7])
        by smtp.gmail.com with ESMTPSA id ml4-20020a17090b360400b00225ab429953sm16922555pjb.6.2023.01.01.00.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 00:34:06 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 0/8] Dynptr fixes
Date:   Sun,  1 Jan 2023 14:03:54 +0530
Message-Id: <20230101083403.332783-1-memxor@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1298; i=memxor@gmail.com; h=from:subject; bh=KdsZ9FRq+X2M0XGa6+ELGsGOLJJ1SlzE5uIMEFUYAmY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjsUV0pcko8DrtvTV7AEOja9J/TRRb71e3mlD9wtY+ 2qY/aHGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY7FFdAAKCRBM4MiGSL8Ryj/RD/ 9a9MmJ2tsJdMAldApX0hI8ts7UMef3UOmXudbf7E3sA87fGXnQqGDmTEThHIpPa82G1pcJSwJD1cqu D1wJfwNVmfSOWMPEkafX9y4r316cJTmu8sL6GaLItrXDQmKvwCl/DhkVu+dczBzrFYZxvSpz7HglHR MwNZePncgspwdagQSEfwixyVi0YNGjhrvkKsUAHDDT2BZfwIZl0RjY/yj12LFP2ldxas0cmQGIDbri GR35s5nEUhmSUkXFhryssTUyW1KClzARxDvWDJWd2qBPvLDSn8xIqw3KuZXhCWdBbgA8aavlvIK38J tTg0fZNx87Gbqg5+DysQFQbO+phnDV5subDVmFQbDgYWe0ZVN6SvcFbQA/3PVk49Q77LcYd9YGrMDD /XPPjkPqErlpNZlQMjU/7fD6T6CXrfmexPN6Q2epDzvND2f1k+3ogxjFMqLZCUhmXIQB/mqbVi39EC LkbmdgxaUvNXOj1TlbECM5XNWMfIu7K3H/w0g06P/He/X2HpPR5qWtcYolvt0CtGKbmZEB6UZfYLi1 kVpyuvlTGhYL6DQbgsMTOd+2ZmAYW+r3no/31IQMODD+h9y0suA91GKjTL8RUAIqNJBf7qE2XOoJLq OcGJWryDnp+emye/vRpGtcmUnXipx408/l+NX8pMfFyguAibgcc2B9zufy/g==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
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

Happy New Year!

This is part 2 of https://lore.kernel.org/bpf/20221018135920.726360-1-memxor@gmail.com.

Changelog:
----------
Old v1 -> v1
Old v1: https://lore.kernel.org/bpf/20221018135920.726360-1-memxor@gmail.com

 * Allow overwriting dynptr stack slots from dynptr init helpers
 * Fix a bug in alignment check where reg->var_off.value was still not included
 * Address other minor nits

Kumar Kartikeya Dwivedi (8):
  bpf: Fix state pruning for STACK_DYNPTR stack slots
  bpf: Fix missing var_off check for ARG_PTR_TO_DYNPTR
  bpf: Fix partial dynptr stack slot reads/writes
  bpf: Allow reinitializing unreferenced dynptr stack slots
  selftests/bpf: Add dynptr pruning tests
  selftests/bpf: Add dynptr var_off tests
  selftests/bpf: Add dynptr partial slot overwrite tests
  selftests/bpf: Add dynptr helper tests

 kernel/bpf/verifier.c                         | 243 ++++++++++++++++--
 .../bpf/prog_tests/kfunc_dynptr_param.c       |   2 +-
 .../testing/selftests/bpf/progs/dynptr_fail.c |  68 ++++-
 tools/testing/selftests/bpf/verifier/dynptr.c | 182 +++++++++++++
 4 files changed, 464 insertions(+), 31 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/dynptr.c


base-commit: bb5747cfbc4b7fe29621ca6cd4a695d2723bf2e8
-- 
2.39.0

