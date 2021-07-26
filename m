Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25F13D5AFD
	for <lists+bpf@lfdr.de>; Mon, 26 Jul 2021 16:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbhGZNa2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Jul 2021 09:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbhGZNa2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Jul 2021 09:30:28 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6400C061757
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 07:10:56 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id l19so13140100pjz.0
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 07:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=opjptYABd9lTAjTURUlye+PGqKAxcZ0rcai12mEW6Gw=;
        b=uCUW0kdYL4B4847h7AnDLCG65JZvkqnHy99+dHXU4SLXpcbbxSzMqcJpEEKEgXbEr7
         0m5Yol/8ViWxU169rxDBcSLnWQ4bUWePcxOGNbUK1Cv2DLrrk7rgoqm8X9MAAzqb6PA7
         NqLmAPOm5BDd3SaG4Q5EGCXN4m0j5txlksTQEWTtrKDmkFLCfMm2IZYfJdTMJjOHzLG+
         4iPRpUdKY4GwWY7PClNlUpEyr8Z99xGZtjyWG65ebJKbyAVAMwTQoH7LYgSEbMP+biOF
         1xSMfFy2wXft3L2YDCQ5OmQJMAW4XrUBKY7EX47mvzPyfMcsu2NsQvS4k2ogOBHs2zot
         UA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=opjptYABd9lTAjTURUlye+PGqKAxcZ0rcai12mEW6Gw=;
        b=thnojVgryAeh9hOnJB/8LrXBvN7U+2UwhQmFFgtucK/QZvyO2G4ZULiYpxRYoPFD1r
         7PPywEjinljPhpkh96+OEhnH2tVRvXjJyep0AaJ2HbRmFi7lDl1jIaHdnO7okEn1MOiZ
         oKOCYw5cGPQAWDAgLg4+1XZ+V5hewJFXJ4gpxZzqsx5+FjnCBFcy6vfeJ/aefWfBFrKu
         CN9G/7vzpeXDL+TBEDQ8A6tKitqqYNFRzvxZRfroqaVrRNV0M8puRwu1khXNpoVfxClI
         dNApFVfHavu4YhRMIj60kHA6P42UGsuir7ixIj1DeXaiBy4UYRvOFOCyj4G2Bhk+qtED
         cZYw==
X-Gm-Message-State: AOAM530fLTFxi8iMISHXje3E8ubsLAN60+HZO7j2eAawpbNuj44DIth8
        mwGFv3EAcs4W6kPBoFAswuThn9DyiEc0XQ==
X-Google-Smtp-Source: ABdhPJyeAKdHjfYBTDGehD05xyfriIcmhewsv1R1GDER3lRch2tuYLV5l3FR1mff/95WSpiq8adpIQ==
X-Received: by 2002:a63:1648:: with SMTP id 8mr18372289pgw.140.1627308656405;
        Mon, 26 Jul 2021 07:10:56 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id r18sm4847074pgk.54.2021.07.26.07.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 07:10:56 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, jolsa@kernel.org,
        yanivagman@gmail.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next v4 2/2] bpf: expose bpf_d_path helper to vfs_* and security_* functions
Date:   Mon, 26 Jul 2021 22:10:13 +0800
Message-Id: <20210726141013.2239765-3-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726141013.2239765-1-hengqi.chen@gmail.com>
References: <20210726141013.2239765-1-hengqi.chen@gmail.com>
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

