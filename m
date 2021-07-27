Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70AA33D7645
	for <lists+bpf@lfdr.de>; Tue, 27 Jul 2021 15:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237067AbhG0N0K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Jul 2021 09:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236871AbhG0NZ5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Jul 2021 09:25:57 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E318C061798
        for <bpf@vger.kernel.org>; Tue, 27 Jul 2021 06:25:48 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id m1so17760162pjv.2
        for <bpf@vger.kernel.org>; Tue, 27 Jul 2021 06:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BbP1RAY7tPPAmP6oXhv/LhWIVi2YwFmp4iUHfkRkNek=;
        b=ZKY2yrG0WQkwfdOaq6VdyCGSeNmgBbPfOAQcIbhSF90e12zQvNlRE5l4yVE6TA487H
         Ao5D4itMeLwklPB8wY+uEzxbczuA3wHb0Rh6U9WdHUjjgo4x5uSp60WysNhhZFeR8itM
         mNW2q2upPa/5sDLhKW2tPjR7Cx5mbABk/JLPFUsBcQqD6E+KXkWst8Prlv4Rx4oI64bg
         y9IKIo5Gd7kiasCxG3w/AnCN4Tso6W/NktgG/uP/yfHTrg/Zl+A8mqsY/3wy+jnsJOP0
         n7D5eM8UDRxJuztAMw/5w6p9T+U9pkxUFKjDfWJAj2tmoknanp3hHLXAEoVhBkLNP4gG
         7C7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BbP1RAY7tPPAmP6oXhv/LhWIVi2YwFmp4iUHfkRkNek=;
        b=KNpZDn2JxXOi36pvwMotl8TUvTIdSBjuJcor0Qave/o2EZ9OcmIaS7ObKz6p6k5EeD
         24huumSongAv22VlMibh5nl+QpATBeY5Gs1pZXsXRw1iDlUUOuEAqWjQD8VoZMDpucmw
         Tkzz6yhnNgefgasRQo9wp4ZLKASdEu3++XRABfn4tDK2B+ItgicHMmB4lX3moNjFKe5b
         SP6yTyiqHi/rOnMvHU05sWq9lJIIDO8HXZGqIB0zxghK/mqjye334ba9GDuqN/0OWO+l
         VJg8aQMBKgMHnC50iQ5xxYKvmvDFEyy44dtOtq8X4T+2Qbt7h4qS/fqrBBroZsx5uCVv
         Rsew==
X-Gm-Message-State: AOAM5321EVuWnG7oDR9IZ2KdscApceWGhynWtiR5Jx5Chl/+I8CnE9Mp
        g3REnWNC2+m4Gyrq4uM9hh2ZeW4G41863Q==
X-Google-Smtp-Source: ABdhPJzlLjoYZptJkOlqyAv7kzMLAdvVPCLteW2hQQmVeSQxxZk2UalQtiOSMWCar5eRB/EjxrXIQA==
X-Received: by 2002:a17:902:b909:b029:12b:95e2:de65 with SMTP id bf9-20020a170902b909b029012b95e2de65mr18315336plb.45.1627392347865;
        Tue, 27 Jul 2021 06:25:47 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id l11sm2002892pfd.187.2021.07.27.06.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 06:25:47 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, jolsa@kernel.org,
        yanivagman@gmail.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next v5 0/2] bpf: expand bpf_d_path helper allowlist
Date:   Tue, 27 Jul 2021 21:25:30 +0800
Message-Id: <20210727132532.2473636-1-hengqi.chen@gmail.com>
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

Changes since v4: [4] 
 - Addressed Andrii's comments. Update warning message.

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
[4] https://lore.kernel.org/bpf/20210725141814.2000828-2-hengqi.chen@gmail.com/

Hengqi Chen (2):
  tools/resolve_btfids: emit warnings and patch zero id for missing
    symbols
  bpf: expose bpf_d_path helper to vfs_* and security_* functions

 kernel/trace/bpf_trace.c        | 60 ++++++++++++++++++++++++++++++---
 tools/bpf/resolve_btfids/main.c | 13 +++----
 2 files changed, 63 insertions(+), 10 deletions(-)

-- 
2.25.1

