Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F603D4E16
	for <lists+bpf@lfdr.de>; Sun, 25 Jul 2021 16:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhGYNib (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Jul 2021 09:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbhGYNiZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Jul 2021 09:38:25 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641F6C061760
        for <bpf@vger.kernel.org>; Sun, 25 Jul 2021 07:18:55 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id e21so4073249pla.5
        for <bpf@vger.kernel.org>; Sun, 25 Jul 2021 07:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wEIKTTc5JxEPZ1DCVyJ/UFx8Lf0W22ikzKKyZOb413Q=;
        b=dJFFu/BbCPb5OSuUTXUzwQWuMFUBqqfcewPdHDt5IeU2VFyDbMz25AeWgL59xEXEcA
         PoDfOFZ6IbbQC+AhOXEApAe7u0Po6V8pHYYFERv7AeDUTTphN2ZEL3ZIvvOekhzEqc32
         Y8v51XniHnwwg2V/VU1RBfltW8Nvesub8+lYxeNBSoK1b5tK8QU7aJLJoDrQcdQ2+UwA
         VQoNfBEis2g2JN1kg3fZpAxSua8AEcMQ+ZvV4KawIi3h0oaex9BFuRFUCza6GA7N8n/4
         DhEnnqGZ0gOvAGEFjR7EkHgYaUUyK74v4/NHufqWsCk6hVjKhBUknqp6rdv3EfBwaWkC
         6yZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wEIKTTc5JxEPZ1DCVyJ/UFx8Lf0W22ikzKKyZOb413Q=;
        b=bwSYtVoZxjRYIXB/dnqD81/zIA3RhGZ6nDcHJwDnZjTNWWB9u3vzuzGnlGgGsBzipY
         kGY1M7HntmTphEUEPvjs0J2+s3OWoGz7pfiAh8ybKCnoAuVFPlmkJxOnHkabBonmDor/
         3eCcWlHX8mKZ/3rEwhUMilIge0l3eIsKJt8eyleiCNozQjz+38mZex2h+MxVXGBdSvac
         q44NLgc5u701z67mrXG+lNCaPPNTlpeJLtjgRLd2ooBMcbyiiAC426gs6QrXYaP7WFV/
         Xu1azTpojKuQUK3RK87k4GMPbRDlwIC0JXjFykePPZ58HrDGX5xvhCKXJzEBm0al2Sjx
         omMw==
X-Gm-Message-State: AOAM5332qhXkqEHGoE5jNI60Aw43HVqmz6oSC++nwNAlSLi7wXHBTijd
        mb73+TA55jzbJjaU9+79eNfUtyX+iCHX3Q==
X-Google-Smtp-Source: ABdhPJzJxGTraJOu71UCQncEWH0ri+R+/r2avjNBJ3rZS776Br6IYWlIYBXaCaz9Ke2SN4lV25t9BA==
X-Received: by 2002:a63:1648:: with SMTP id 8mr13856657pgw.140.1627222734857;
        Sun, 25 Jul 2021 07:18:54 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id q17sm48055188pgd.39.2021.07.25.07.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 07:18:54 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, jolsa@kernel.org,
        yanivagman@gmail.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next 2/2] bpf: expose bpf_d_path helper to vfs_* and security_* functions
Date:   Sun, 25 Jul 2021 22:18:14 +0800
Message-Id: <20210725141814.2000828-3-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210725141814.2000828-1-hengqi.chen@gmail.com>
References: <20210725141814.2000828-1-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add vfs_* and security_* to bpf_d_path allowlist, so that we can use
bpf_d_path helper to extract full file path from these functions'
`struct path *` and `struct file *` arguments. This will help tools
like IOVisor's filetop[2]/filelife to get full file path.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 kernel/trace/bpf_trace.c | 52 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index c5e0b6a64091..355777b5bf63 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -850,16 +850,64 @@ BPF_CALL_3(bpf_d_path, struct path *, path, char *, buf, u32, sz)
 BTF_SET_START(btf_allowlist_d_path)
 #ifdef CONFIG_SECURITY
 BTF_ID(func, security_file_permission)
-BTF_ID(func, security_inode_getattr)
 BTF_ID(func, security_file_open)
+BTF_ID(func, security_file_ioctl)
+BTF_ID(func, security_file_free)
+BTF_ID(func, security_file_alloc)
+BTF_ID(func, security_file_lock)
+BTF_ID(func, security_file_fcntl)
+BTF_ID(func, security_file_set_fowner)
+BTF_ID(func, security_file_receive)
+BTF_ID(func, security_inode_getattr)
+BTF_ID(func, security_sb_mount)
+BTF_ID(func, security_bprm_check)
 #endif
 #ifdef CONFIG_SECURITY_PATH
 BTF_ID(func, security_path_truncate)
+BTF_ID(func, security_path_notify)
+BTF_ID(func, security_path_unlink)
+BTF_ID(func, security_path_mkdir)
+BTF_ID(func, security_path_rmdir)
+BTF_ID(func, security_path_mknod)
+BTF_ID(func, security_path_symlink)
+BTF_ID(func, security_path_link)
+BTF_ID(func, security_path_rename)
+BTF_ID(func, security_path_chmod)
+BTF_ID(func, security_path_chown)
+BTF_ID(func, security_path_chroot)
 #endif
 BTF_ID(func, vfs_truncate)
 BTF_ID(func, vfs_fallocate)
-BTF_ID(func, dentry_open)
 BTF_ID(func, vfs_getattr)
+BTF_ID(func, vfs_fadvise)
+BTF_ID(func, vfs_fchmod)
+BTF_ID(func, vfs_fchown)
+BTF_ID(func, vfs_open)
+BTF_ID(func, vfs_setpos)
+BTF_ID(func, vfs_llseek)
+BTF_ID(func, vfs_read)
+BTF_ID(func, vfs_write)
+BTF_ID(func, vfs_iocb_iter_read)
+BTF_ID(func, vfs_iter_read)
+BTF_ID(func, vfs_readv)
+BTF_ID(func, vfs_iocb_iter_write)
+BTF_ID(func, vfs_iter_write)
+BTF_ID(func, vfs_writev)
+BTF_ID(func, vfs_copy_file_range)
+BTF_ID(func, vfs_getattr_nosec)
+BTF_ID(func, vfs_ioctl)
+BTF_ID(func, vfs_fsync_range)
+BTF_ID(func, vfs_fsync)
+BTF_ID(func, vfs_utimes)
+BTF_ID(func, vfs_statfs)
+BTF_ID(func, vfs_dedupe_file_range_one)
+BTF_ID(func, vfs_dedupe_file_range)
+BTF_ID(func, vfs_clone_file_range)
+BTF_ID(func, vfs_cancel_lock)
+BTF_ID(func, vfs_test_lock)
+BTF_ID(func, vfs_setlease)
+BTF_ID(func, vfs_lock_file)
+BTF_ID(func, dentry_open)
 BTF_ID(func, filp_close)
 BTF_SET_END(btf_allowlist_d_path)

--
2.25.1
