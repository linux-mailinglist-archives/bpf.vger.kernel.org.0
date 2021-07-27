Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D933D764B
	for <lists+bpf@lfdr.de>; Tue, 27 Jul 2021 15:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbhG0N0n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Jul 2021 09:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237312AbhG0N0L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Jul 2021 09:26:11 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884A2C061799
        for <bpf@vger.kernel.org>; Tue, 27 Jul 2021 06:26:11 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id t21so15619069plr.13
        for <bpf@vger.kernel.org>; Tue, 27 Jul 2021 06:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=opjptYABd9lTAjTURUlye+PGqKAxcZ0rcai12mEW6Gw=;
        b=q7+kOBeo8gnXElVAaWQrnMCou/0GA5JCLDn+kUL8CsYabPADrf6EgdbVaZ8PH4PuB5
         uAlSyYK1xtYnJgiPtZjXi1siZTfKU3ZaLvFz0pKooRx44/588cHoqDp3UiEFHF0Ip25o
         UwOBDbJDh/ZXCYnU9qLAs0131QKfLlwZgJaXYs+UCjTAH44VYlLViKWNJs515Rlkvg3N
         aHm1H9s6eS7aS0Mm3Kv2Y7l7Bb+4/1YTPQT7uIIXoBgpNNliAgIO66lmY4/5zNsjKHEX
         pOXFGk9jX8L/eyloAXNHsSQgzOk3ussPtC5lCL6b+7UTDtw4kbnlK2vUCAmvbtfc4to3
         4ZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=opjptYABd9lTAjTURUlye+PGqKAxcZ0rcai12mEW6Gw=;
        b=mib2KSUk8ZIjYend0IdJU5YX4TGIK0ixx+cFTLrryO2/Sg202hbV2Hr0QxezGO87oQ
         5MBz4TGNKAH7CSK0i+iAHR54QfsVTsLiHGZ8/i33TfwUMmNTtR09wtNeFa31Qpt/Wse1
         00YCO/eU8fAfHNnm+HIxeyDnYduPULY3iQAjfAV0qNADlSh++gjPeN7tRDI3DsKc9DBr
         xychuYNumZKtbtpb8SR2JNAOqPwOKyf2yy7y88AV2zxmJrcyb8RgbQNLA91x74xcekhx
         83JVpqaMshLWwXgLeUUipMq4HqbuqAl3yNMM6+R3DpC5RZbSxtBDaDm5Wu5BjCcyV9mO
         7aug==
X-Gm-Message-State: AOAM5322GweoUsU60ks7xd4WeF4Dp9EvYZ+lZZ7lQEsqyGe7I0TmdRFt
        NJUZZ34uzVwwQwW9VLvVhuyNgdOZPR8rSQ==
X-Google-Smtp-Source: ABdhPJw1TUtv5rzFWg/NskEXRsk04VpVWrme6IjRn0HrlqzVjVQf2jfO2aSJGRreBu/W6KzjNYvQWg==
X-Received: by 2002:a63:84:: with SMTP id 126mr6652730pga.221.1627392371028;
        Tue, 27 Jul 2021 06:26:11 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id l11sm2002892pfd.187.2021.07.27.06.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 06:26:10 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, jolsa@kernel.org,
        yanivagman@gmail.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next v5 2/2] bpf: expose bpf_d_path helper to vfs_* and security_* functions
Date:   Tue, 27 Jul 2021 21:25:32 +0800
Message-Id: <20210727132532.2473636-3-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210727132532.2473636-1-hengqi.chen@gmail.com>
References: <20210727132532.2473636-1-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add vfs_* and security_* to bpf_d_path allowlist, so that we can use
bpf_d_path helper to extract full file path from these functions' arguments.
This will help tools like BCC's filetop[1]/filelife to get full file path.

[1] https://github.com/iovisor/bcc/issues/3527

Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 kernel/trace/bpf_trace.c | 60 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index c5e0b6a64091..e7b24abcf3bf 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -849,18 +849,70 @@ BPF_CALL_3(bpf_d_path, struct path *, path, char *, buf, u32, sz)
 
 BTF_SET_START(btf_allowlist_d_path)
 #ifdef CONFIG_SECURITY
+BTF_ID(func, security_bprm_check)
+BTF_ID(func, security_bprm_committed_creds)
+BTF_ID(func, security_bprm_committing_creds)
+BTF_ID(func, security_bprm_creds_for_exec)
+BTF_ID(func, security_bprm_creds_from_file)
+BTF_ID(func, security_file_alloc)
+BTF_ID(func, security_file_fcntl)
+BTF_ID(func, security_file_free)
+BTF_ID(func, security_file_ioctl)
+BTF_ID(func, security_file_lock)
+BTF_ID(func, security_file_open)
 BTF_ID(func, security_file_permission)
+BTF_ID(func, security_file_receive)
+BTF_ID(func, security_file_set_fowner)
 BTF_ID(func, security_inode_getattr)
-BTF_ID(func, security_file_open)
+BTF_ID(func, security_sb_mount)
 #endif
 #ifdef CONFIG_SECURITY_PATH
+BTF_ID(func, security_path_chmod)
+BTF_ID(func, security_path_chown)
+BTF_ID(func, security_path_chroot)
+BTF_ID(func, security_path_link)
+BTF_ID(func, security_path_mkdir)
+BTF_ID(func, security_path_mknod)
+BTF_ID(func, security_path_notify)
+BTF_ID(func, security_path_rename)
+BTF_ID(func, security_path_rmdir)
+BTF_ID(func, security_path_symlink)
 BTF_ID(func, security_path_truncate)
+BTF_ID(func, security_path_unlink)
 #endif
-BTF_ID(func, vfs_truncate)
-BTF_ID(func, vfs_fallocate)
 BTF_ID(func, dentry_open)
-BTF_ID(func, vfs_getattr)
 BTF_ID(func, filp_close)
+BTF_ID(func, vfs_cancel_lock)
+BTF_ID(func, vfs_clone_file_range)
+BTF_ID(func, vfs_copy_file_range)
+BTF_ID(func, vfs_dedupe_file_range)
+BTF_ID(func, vfs_dedupe_file_range_one)
+BTF_ID(func, vfs_fadvise)
+BTF_ID(func, vfs_fallocate)
+BTF_ID(func, vfs_fchmod)
+BTF_ID(func, vfs_fchown)
+BTF_ID(func, vfs_fsync)
+BTF_ID(func, vfs_fsync_range)
+BTF_ID(func, vfs_getattr)
+BTF_ID(func, vfs_getattr_nosec)
+BTF_ID(func, vfs_iocb_iter_read)
+BTF_ID(func, vfs_iocb_iter_write)
+BTF_ID(func, vfs_ioctl)
+BTF_ID(func, vfs_iter_read)
+BTF_ID(func, vfs_iter_write)
+BTF_ID(func, vfs_llseek)
+BTF_ID(func, vfs_lock_file)
+BTF_ID(func, vfs_open)
+BTF_ID(func, vfs_read)
+BTF_ID(func, vfs_readv)
+BTF_ID(func, vfs_setlease)
+BTF_ID(func, vfs_setpos)
+BTF_ID(func, vfs_statfs)
+BTF_ID(func, vfs_test_lock)
+BTF_ID(func, vfs_truncate)
+BTF_ID(func, vfs_utimes)
+BTF_ID(func, vfs_write)
+BTF_ID(func, vfs_writev)
 BTF_SET_END(btf_allowlist_d_path)
 
 static bool bpf_d_path_allowed(const struct bpf_prog *prog)
-- 
2.25.1

