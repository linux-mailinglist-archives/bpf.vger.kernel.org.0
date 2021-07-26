Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3563D5AFB
	for <lists+bpf@lfdr.de>; Mon, 26 Jul 2021 16:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbhGZNaR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Jul 2021 09:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbhGZNaR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Jul 2021 09:30:17 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317C6C061757
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 07:10:46 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id e14so11780602plh.8
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 07:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8VozWXixIfDY/soeTQXILNz3g1ltpTqy9ydTJwf0M+k=;
        b=EzNSwf3bc0e6K9tW4PBckmSfH1Of39eGzbRwLpcWoGVXBvwahxW04ctHHWhpXUuudU
         aulwtWDRMrNjD4iMJzJRm+j6WuENFFxFarnJwX4ZhYMPhsnPm66X+oHPmlWJVrIilInm
         kqalO39kMGmT4+1oEnryKsV9ecI7bsQuXkDfU/opDPoeNrTmRjUlm2MODKKqNwMc8kbJ
         psR/EOh+lT2iIeRA/sWTuLKfNmy/baT9RuJPaMHFawWr00eKCfoonb5BYzNyBg2v37fx
         qsHLie6vphvMHidXEwyXcitSpmTsyTOzLaS9/5OAZkhNU2sCwdgW4yck5qnvChI2/MWM
         vX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8VozWXixIfDY/soeTQXILNz3g1ltpTqy9ydTJwf0M+k=;
        b=t4TUvbsYmo8QwHaeBp7Sp2GgMaH0/ACqKYhvXonP/LXHzhOo0jHuJ0rrwKH8i+MFIh
         CJiHwWsLXr8SJ2ScfW7XnsXymGvH4RSH78ut9LD05ORciFVqzAnD4yx4EEft7cgUTRKD
         lmgxlR94Hf2QasGHeheRVaIxJLsv7dw5q9wD+jse8LHI38YTOWXdqO7YrZlIJpdsoOrW
         iPnYKr4yY/dLIF6VKN46qAlBPQfcWneB8mqXihj7Do+wsCxXGujc/P0H4mh9IQnMl4gB
         LkgoPHNdWkNN6czzLxbK2O70M6QTAPxjBlFb91rmpgaDOPb1loALIbAofK38ldKhVPha
         bOgA==
X-Gm-Message-State: AOAM5326kbj5MNSwsOARUjbXrODVhzFRVfF1E3LuMiktkQpo9696uYNB
        IUKfXuY1qdqxHMFnaaz0LLAOX4z0nGZHIQ==
X-Google-Smtp-Source: ABdhPJzNu8Gz5FSJNvnbTogp5dPFNqV4SrAvEIDzuZ/xJXHijGe11W2xgj307juZg/6mBtRsyy9/xg==
X-Received: by 2002:aa7:948c:0:b029:328:8e56:aefd with SMTP id z12-20020aa7948c0000b02903288e56aefdmr18277490pfk.19.1627308645664;
        Mon, 26 Jul 2021 07:10:45 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id r18sm4847074pgk.54.2021.07.26.07.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 07:10:45 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, jolsa@kernel.org,
        yanivagman@gmail.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next v4 0/2] bpf: expand bpf_d_path helper allowlist
Date:   Mon, 26 Jul 2021 22:10:11 +0800
Message-Id: <20210726141013.2239765-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set adds more functions to bpf_d_path allowlist.

Patch 1 is prep work which updates resolve_btfids to emit warnings
on missing symbols instead of aborting kernel build process.

Patch 2 expands bpf_d_path allowlist.

Changes since v3: [3]
 - Addressed Yonghong's comments. Sort allowlist and add security_bprm_*

Changes since v2: [2]
 - Andrii suggested that we should first address an issue of .BTF_ids
   before adding more symbols to .BTF_ids. Fixed that.
 - Yaniv proposed adding security_sb_mount and security_bprm_check.
   Added them.

Changes since v1: [1]
 - Alexei and Yonghong suggested that bpf_d_path helper could also
   apply to vfs_* and security_file_* kernel functions. Added them.

[1] https://lore.kernel.org/bpf/20210712162424.2034006-1-hengqi.chen@gmail.com/
[2] https://lore.kernel.org/bpf/20210719151753.399227-1-hengqi.chen@gmail.com/
[3] https://lore.kernel.org/bpf/20210725141814.2000828-3-hengqi.chen@gmail.com/

Hengqi Chen (2):
  tools/resolve_btfids: emit warnings and patch zero id for missing
    symbols
  bpf: expose bpf_d_path helper to vfs_* and security_* functions

 kernel/trace/bpf_trace.c        | 60 ++++++++++++++++++++++++++++++---
 tools/bpf/resolve_btfids/main.c | 13 +++----
 2 files changed, 63 insertions(+), 10 deletions(-)

-- 
2.25.1

