Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A39459084
	for <lists+bpf@lfdr.de>; Mon, 22 Nov 2021 15:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238407AbhKVOux (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 09:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235929AbhKVOuw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 09:50:52 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B415FC061574
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 06:47:45 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so24286pjb.5
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 06:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GaObZLF/JUgmwiYi1Od0FyZ1+qCRXkII88GBLP5E4qg=;
        b=ida3ejrwgGaWIM5tqIsYjtH/rBx1EogedHlQ3PXtMn41zfv3vP5ZtPB3eIqanuk9XN
         JyEEvRRqHlPeZTNh7GKLhT0kLNN0w3gBNalOvEMYJbHqIWaNngQk4wHPYfCsbbbBBhXw
         FdXmfecjIjuveqt6vxQ5iUdAMxYUIH+L8gAHQfvAMcVVW9aA875RQ1bhfyKWo8ayoCYU
         NQpfjOunMu32yZEduqZS/uAkBwG+T+1XuCXua+aIveun874EoaunWJ2Ve8ihHu2LyJv2
         JWHSnQw/x2WcO0u61ftWQqFpXoULvVSemjBMvzwB5z7+EFufFtzjRLkOfvveeBm88drM
         bvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GaObZLF/JUgmwiYi1Od0FyZ1+qCRXkII88GBLP5E4qg=;
        b=GysX236+dbcEJnZoqi/x7jWeWoXrv9aUpKNxI5ERI48tmCpmmx2naf2bKWTgPuPedi
         tyo85r7ZZM6RNzWEQ2U28xyYrlRKz8xAttF3xhiZsbMLIhnr+7QtMkNY5OLhGL9Dzuwe
         eASWpIfoV3bUVKpSmAiTveFGsoOQ6PZyb6IiQoVmjFSdyIYjtHbY3ik7kB9sEjggfFy3
         Suscrs0rYLpcf9hcW+C3eiL0ZwknEhusRSrKTbtpCFJGLyJcSOvziGF5DS+VvCSOJFtv
         V2wgLRMmh+YuYPJrYs5exUyrMwVNw7CFIgqNKRTq15fE5gE5mEmvT2yYpT5mTwmMWtMi
         YotQ==
X-Gm-Message-State: AOAM532Y4v1/8WHVXK13ifcueKUhSDnFT8hQXupPsDgGpFRONohoUhX5
        uCkOI9+bYg1J3RjMHkzELdn7TD7pPkc=
X-Google-Smtp-Source: ABdhPJzzL6/d35nIshWtRXg61WSG/xF/mUZjYnBlD6payAWgdvZkSnYN6HBh6l5DSr9clWr9Trx52w==
X-Received: by 2002:a17:90b:350b:: with SMTP id ls11mr31519000pjb.227.1637592465081;
        Mon, 22 Nov 2021 06:47:45 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:3d4e:6265:800c:dc84])
        by smtp.gmail.com with ESMTPSA id i2sm9378984pfg.90.2021.11.22.06.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 06:47:44 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v2 0/3] Fixes for kfunc-mod regressions and warnings
Date:   Mon, 22 Nov 2021 20:17:39 +0530
Message-Id: <20211122144742.477787-1-memxor@gmail.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=824; h=from:subject; bh=kzSg0Ju+WFYAt0XxfJYxl8fIenXGFIMRR+QKXGKXGeg=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBhm619e+EJKvNKOSjomNTpcoEa1smuolhCBLrwQzIw UpxJJvmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYZutfQAKCRBM4MiGSL8RyhNLD/ 4pkvuFL14LR2ye+2F2oBCW6HDC39DXBS+G6kLXHD+fJ/yQI74Qr43hxb5MqZCVXa4cbJXqpWIGGOKo xARmOhX6vGXjbFJJAiWU8S4HQWgi8M3rxVHCair8VJ8a2DPAyOeeePnH1wCqXquY/g+JfJ1k/wa/r4 wUFTgrwNkfDpMTtnPSpI7IPinVH/PFQpwIhoHHZWdtNi37dFcsvRHcVPhw5moqjEPG9cCA/QKy5YDW jm8UW/pnZr+444e5J0H8RIomLWDjTLScu/D8b/IYd6METix92TNWg3PeTnRa1vbIG11/55bv9bcJ2P ywYDM1KSyrHzm0uWdvZcCEf4vU3/gCfIG0m/+UzGc5z3ibcu97yxYMyxQZvSmmweMh5ywltS1FnIuf vX1RD56tz3ff4fnrBRHer8jw+qr6tn8aYCem7tEKSsJDCVV1QYJoHhOYLRJjQeZehcmID6QDVuWH5m ECroF2F4wzSQCnMjPuw8ZWYIBXJICPXxZaHvZQpmCCy6wcHOluB/hlAuBPNDaKf5JXt25W9hw9sLq6 +Xvs1NtQ2T5AjqtWSqhbvBjBgFCqlWOSHoyN4PvZoel7nMwFwcJbv0wiSHZkodaqqFcf5fTodxfV8c oBJrUxX/GQ1NN4j1S/4joRgbJHI7B6Z2MXyPiC/NYEAI477/mJNYLnR493dg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This set includes fixes for two regressions and one build warning introduced by
the kfunc for modules series.

Changelog:
----------

v1 -> v2:
v1: https://lore.kernel.org/bpf/20211115191840.496263-1-memxor@gmail.com

 * Instead of demoting resolve_btfids warning to debug, only skip in case of
   set->cnt == 0.

Kumar Kartikeya Dwivedi (3):
  bpf: Make CONFIG_DEBUG_INFO_BTF depend upon CONFIG_BPF_SYSCALL
  bpf: Fix bpf_check_mod_kfunc_call for built-in modules
  tools/resolve_btfids: Skip unresolved symbol warning for empty BTF
    sets

 include/linux/btf.h             | 14 ++++++++++----
 kernel/bpf/btf.c                | 11 ++---------
 lib/Kconfig.debug               |  1 +
 tools/bpf/resolve_btfids/main.c |  8 +++++---
 4 files changed, 18 insertions(+), 16 deletions(-)

-- 
2.34.0

