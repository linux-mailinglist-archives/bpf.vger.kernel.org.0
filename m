Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B035A3C606C
	for <lists+bpf@lfdr.de>; Mon, 12 Jul 2021 18:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbhGLQ1l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Jul 2021 12:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbhGLQ1l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Jul 2021 12:27:41 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F44C0613E8
        for <bpf@vger.kernel.org>; Mon, 12 Jul 2021 09:24:52 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 37so18809253pgq.0
        for <bpf@vger.kernel.org>; Mon, 12 Jul 2021 09:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IvjUIjPNpa0I941SNlmHBcYhl5QkXjKCaZ/ONhaJN8g=;
        b=iUFFvWTDlqUF0nRBLVbGisvBhz3uwYj/hmElSlcdGmvXk6INZ8OV2rhwTdC940Lt0m
         MN5oDs/yKnTKwArbeTj27FgMRa4aUutdZ036nBIieUSD/MUkjwVzLVdyULGJJNM9QGiC
         SWXKXweD/hXealhKXgWXkMAZsCNzzOkCewETRRzR1XSH/mG/42e4O6kaxuCrs8Ucd1y5
         XUcy+W8XbOO+bmXPzTbY2EjcLpbgn+8C0WtYHXS9TXx26peaOAFgaMk3S2aa4HKBOUGO
         Je7Cr4oY7wlq2NhK6eNd9HHXlbqP2wOiUwS6Tp/DMGZNQqr1WUZORIDqSPf6AM4GmFVK
         VfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IvjUIjPNpa0I941SNlmHBcYhl5QkXjKCaZ/ONhaJN8g=;
        b=fdcR65/xL2iZDYmD1r5ZorTFfqBIzGZcglvX5ZZjyvljKJebCsgKxgAlprTF/RVgRu
         Y3tmQrBLp9+21+tMiOASXJazCD6YTxHHUpWxNTH8XS4bLTvonbwLHzFyAcp3naM01GS+
         Odz34X9Wo85F3nMkXeFef92srh0Zt7MVAlkxjfvYLiurc6XCDVrlbg6fPqYoA8qy5Nf7
         RFa2OrK98cTCfOWP4q+Eg+5jvDeupInEkX3TEobmpJbPkMsL4VFc3fPRCmBGI8V0DXga
         tEx5LSunOaUT3jQPZ66e7Z0mJFN/BWT1gS7KOe+4YwU3aqXL+zqdhCcMV+Qu7893K+Gl
         WtkQ==
X-Gm-Message-State: AOAM533Nh9H0Rj1a1QEgbgr9p9Oi1CUrB7lEwzORmx62T3m6mdEcsTbT
        SzUi9Sl5WU1Xkjllfw+ZJM818pL3MMZtrA==
X-Google-Smtp-Source: ABdhPJywWiIEFgtQNkrIHMwnnIKtNs+GjqUfXQRCE9MxWnNb32YiQrlj/fTsh8x7N4W6vG62VT2VPQ==
X-Received: by 2002:aa7:9e9e:0:b029:32a:fa43:1c with SMTP id p30-20020aa79e9e0000b029032afa43001cmr63859pfq.24.1626107092225;
        Mon, 12 Jul 2021 09:24:52 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id x30sm2871551pfh.126.2021.07.12.09.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 09:24:51 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     yhs@fb.com, andriin@fb.com, jolsa@kernel.org, hengqi.chen@gmail.com
Subject: [PATCH bpf-next] bpf: Expose bpf_d_path helper to vfs_read/vfs_write
Date:   Tue, 13 Jul 2021 00:24:24 +0800
Message-Id: <20210712162424.2034006-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add vfs_read and vfs_write to bpf_d_path allowlist.
This will help tools like IOVisor's filetop to get
full file path.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 kernel/trace/bpf_trace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 64bd2d84367f..6d3f951f38c5 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -861,6 +861,8 @@ BTF_ID(func, vfs_fallocate)
 BTF_ID(func, dentry_open)
 BTF_ID(func, vfs_getattr)
 BTF_ID(func, filp_close)
+BTF_ID(func, vfs_read)
+BTF_ID(func, vfs_write)
 BTF_SET_END(btf_allowlist_d_path)
 
 static bool bpf_d_path_allowed(const struct bpf_prog *prog)
-- 
2.25.1

