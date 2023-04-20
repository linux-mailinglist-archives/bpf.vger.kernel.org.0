Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB1F6E8B2B
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 09:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjDTHPO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 03:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbjDTHPO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 03:15:14 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA4C35BE
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 00:15:07 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-246eebbde1cso519072a91.3
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 00:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681974907; x=1684566907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4WiKQnAkY6Ma1naXObAb5T1iqQjf6RV6bQv/iulJmoE=;
        b=ZqK3pJxVvDm+gK0tyOjygvJ6PWc04z/910y13+WetDMcaC7kZR0RyhZwcj1yAzZRUB
         MOH23Bb7ZuvZ0OavkFyN7SshHbnkTXDg9kV7sgcRuu7oR7ew2uIQCuBNivDlYygugoqc
         hrlJ+sTg7hApk3pguYm8YpmZmHjaW+699MauibwZ21siACzteOEQGDfdSz8HXEmfsUHw
         +Qkki5nL1ZtsXxOHlZuEmZWpoj398wjLyMLrSbDKnPmzxPnyYzhsgYYehM0x31JhwbXh
         QPNlbjCrb+yi19EDh5mgdNNRUIk6iiKGjj58AH8VwHurPk+nQMvabIaMNGULgeObPhFw
         YstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681974907; x=1684566907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4WiKQnAkY6Ma1naXObAb5T1iqQjf6RV6bQv/iulJmoE=;
        b=hOq1uP52l+2LvH7CbdSrf/qmw+NvxihLQ02Ly0RLp6Ubi7tAyDUnyWWPJ7+Mt8LYN+
         3buE7PqG6iNtXffdRBesR6cbfmqbFa5O4nUHb5GPalwVc1kz0kR1fUnI7c1js28HbOVM
         zXiHlzT3eWXl6156ulCxHfegeimXLlLaGNR3wt5iOv7KXlzwsGVyPpM5DGU3YF6dIGfO
         Q5NkIBob3G0DwSZIaKz0ZqvvnKRPXbzYi3bSSfEATFIbfQsLZnSGSkqI15jUwjAmPWzK
         1E6+idYXCozR/N2bMIp6jwQ0UItFpGqbJesj5X89CdVnvOlYoscxmwScBGLmJlcMi0FW
         95og==
X-Gm-Message-State: AAQBX9exuijtdubIgPt4UW/zwNqr/mRgcmEbFkyiyh0Ktb4qBbuLnpzw
        Ju/xIFl0tF+tY9Nf96YbG3PQ2WHwFACajg==
X-Google-Smtp-Source: AKy350YV+Yy4XLY09ldG8ze1vPxS943aU9WAq+1qPOmaHD7tbSIQ0khvvj4flL0TyUXaM0puZGLAGA==
X-Received: by 2002:a17:90a:fa96:b0:23b:3699:b8a9 with SMTP id cu22-20020a17090afa9600b0023b3699b8a9mr700651pjb.17.1681974906982;
        Thu, 20 Apr 2023 00:15:06 -0700 (PDT)
Received: from gatsby.corp.tfbnw.net (75-172-126-232.tukw.qwest.net. [75.172.126.232])
        by smtp.gmail.com with ESMTPSA id a7-20020a17090acb8700b00246b5a609d2sm588208pju.27.2023.04.20.00.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 00:15:06 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v2 bpf-next 0/5] Dynptr helpers
Date:   Thu, 20 Apr 2023 00:14:09 -0700
Message-Id: <20230420071414.570108-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset is the 3rd in the dynptr series. The 1st (dynptr
fundamentals) can be found here [0] and the second (skb + xdp dynptrs)
can be found here [1].

This patchset adds the following helpers for interacting with
dynptrs:

int bpf_dynptr_adjust(struct bpf_dynptr *ptr, __u32 start, __u32 end) __ksym;
int bpf_dynptr_is_null(const struct bpf_dynptr *ptr) __ksym;
int bpf_dynptr_is_rdonly(const struct bpf_dynptr *ptr) __ksym;
__u32 bpf_dynptr_size(const struct bpf_dynptr *ptr) __ksym;
int bpf_dynptr_clone(const struct bpf_dynptr *ptr, struct bpf_dynptr *clone__init) __ksym;

[0] https://lore.kernel.org/bpf/20220523210712.3641569-1-joannelkoong@gmail.com/
[1] https://lore.kernel.org/bpf/20230301154953.641654-1-joannelkoong@gmail.com/

v1 -> v2:
v1: https://lore.kernel.org/bpf/20230409033431.3992432-1-joannelkoong@gmail.com/
* change bpf_dynptr_advance/trim to bpf_dynptr_adjust
* rename bpf_dynptr_get_size to bpf_dynptr_size
* refactor handling clone for process_dynptr_func, maintain unique ids
  for parent and clone
* remove bpf_dynptr_get_offset()

Joanne Koong (5):
  bpf: Add bpf_dynptr_adjust
  bpf: Add bpf_dynptr_is_null and bpf_dynptr_is_rdonly
  bpf: Add bpf_dynptr_size
  bpf: Add bpf_dynptr_clone
  selftests/bpf: add tests for dynptr convenience helpers

 include/linux/bpf.h                           |   2 +-
 kernel/bpf/helpers.c                          |  76 ++++-
 kernel/bpf/verifier.c                         | 105 ++++--
 kernel/trace/bpf_trace.c                      |   4 +-
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   6 +
 .../testing/selftests/bpf/prog_tests/dynptr.c |   6 +
 .../testing/selftests/bpf/progs/dynptr_fail.c | 287 +++++++++++++++++
 .../selftests/bpf/progs/dynptr_success.c      | 298 ++++++++++++++++++
 8 files changed, 755 insertions(+), 29 deletions(-)

-- 
2.34.1

