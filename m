Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDB06ED237
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 18:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjDXQL5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 12:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjDXQLx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 12:11:53 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFF37EFB
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 09:11:51 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-63b73203e0aso28940211b3a.1
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 09:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682352711; x=1684944711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7QPSPjAvKCV9dKLHUXG7SZ1HySGBNUKkOL8fwoyMnR8=;
        b=kEeH0CuWqoIfs4idL5D/28VRi+VKDobKnI6e4sHaX1kkCLzIhAH9wNMBjshGDfAQQk
         aziKIlBaMX80WxZk+U/zHD4uJGTxDxih3RIuGEi5HpFuuavMs3IKHznJ3QZq2urS2bvv
         4Hsdn2j6WigI++t0yMeAhPovRmHLVzn0UL+kGKuOfMVfvoFTDNYwMlHX0Df1FfY1g/rr
         irr/L6jgbiZRX5HWw/sWgW1GuFT5NrwDpMHuYVRpJsnwbiLIBBaya82k3Fq3i05Hxtfo
         jvmAaG4IyaY9hHCNBxrwGKsve2BOYR6UP3njH5d1HwD/Pf3EglYy5nFvC9KB0YPRGze3
         FUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682352711; x=1684944711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7QPSPjAvKCV9dKLHUXG7SZ1HySGBNUKkOL8fwoyMnR8=;
        b=VaJNRgCNaRHDmSeldTcQ54kV0r9AmeooLxx4hcVz+3reLOXl0MH8D5o7rxxTD0BvKE
         V9hbUZh+zPbPNvAgMllQMXOiH0S1e1E6P5jDWZoVabs7o6d4fSBaz4qG6h6ys+Vuw6uO
         ewCy9D0swxsrQOglumfEBak/ViEhsKJNy6YY+p5NSgyJ+lTYYiC8XgRpnFzFInSmf+LP
         0HlokRgDxq2ewIMSkmMl298owwA+/Bk9B8IZMT8Ld9jZu3a/Uz51XyyDWNuJPYIguDxd
         udOWgzweSno8oaK3n31KAuaIj7TEyFrRZl6l4IpyXi/s5KmrI1ea5x/nw0aptRXSgPrg
         pzpQ==
X-Gm-Message-State: AAQBX9dBhAR8UHd5xTb1qW+EozvUiaHyrMyPA4ibkPYHLb0+MiAKDXm/
        l+Z+ucLlEcF6B6GZYEqgkkA=
X-Google-Smtp-Source: AKy350Z4LjocZn3ft5IzFbxrEB8eLHsPgpMVo81bO0GzVEyXyyJ4C4awXwPncrvWwN/1CKFcCgLfXA==
X-Received: by 2002:a05:6a21:78a5:b0:f5:cf7d:fcc4 with SMTP id bf37-20020a056a2178a500b000f5cf7dfcc4mr1934181pzc.11.1682352711008;
        Mon, 24 Apr 2023 09:11:51 -0700 (PDT)
Received: from vultr.guest ([64.176.50.146])
        by smtp.gmail.com with ESMTPSA id 20-20020a630514000000b005142206430fsm6775729pgf.36.2023.04.24.09.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:11:50 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 0/2] bpf: Fix issues caused by bpf trampoline 
Date:   Mon, 24 Apr 2023 16:11:02 +0000
Message-Id: <20230424161104.3737-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
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

The panic caused by fentry[1] drives me to write a testcase[2] to check if
it safe to attach other kernel functions. Unsurprisingly it catches some
issues. This patchset fixes them. 

[1]. https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=c11bd046485d7bf1ca200db0e7d0bdc4bafdd395
[2]. https://github.com/laoar/ebpf/tree/main/fentry 

Yafang Shao (2):
  bpf: Add __rcu_read_{lock,unlock} into btf id deny list
  fork: Rename mm_init to task_mm_init

 kernel/bpf/verifier.c | 4 ++++
 kernel/fork.c         | 6 +++---
 2 files changed, 7 insertions(+), 3 deletions(-)

-- 
1.8.3.1

