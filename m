Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011A03CDE14
	for <lists+bpf@lfdr.de>; Mon, 19 Jul 2021 17:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345363AbhGSPBw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Jul 2021 11:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344725AbhGSO7z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Jul 2021 10:59:55 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C636FC05BA6B
        for <bpf@vger.kernel.org>; Mon, 19 Jul 2021 07:49:00 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id e14so6986689plh.8
        for <bpf@vger.kernel.org>; Mon, 19 Jul 2021 08:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L9RGmR33gIiIhMJ0Il3ZuEkqjIRODMdp2M7uwLfN3dk=;
        b=qH2ig5XfHukYXLayKOcok78A2QgSstpJ3/4nlLa8NC4r6U4QWlMF+V3LFz5ReUDEjW
         HEzswSPH/bCctDlG+6XPSQlg1vHwSmtcRtE5cyZHZ0EFvcxkADXHJNMxzge9rzurqnRg
         Yvc5t38bnyRirQ6ydgTQ0CGeUiQZPOLT7SzchUBfAoBmgaFeyyazxKjydxJRl2KOyw33
         xcn6/prDvY2UF/SpAKx0F9pfSbbenGg+c72p/3XRAC2JvU+L30I/LJG78Tda8qD/f76B
         FdKMXnmCmbqr1hybo6PFGD18BnM4apWK+HZr5HNZNIY8jiQHX8r4KPDkcBlUDhL3L58I
         4UPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L9RGmR33gIiIhMJ0Il3ZuEkqjIRODMdp2M7uwLfN3dk=;
        b=ng8eAYjY2N0Z+blxeeNJT+QUkBxKr+H7WsJiqRFIVQFZ0jKSA2uFcPXHOrpSo3TSRS
         eMf/nTnvjfxPdXnSd0WPWNSTyJvvynTCrdPRysFf8fG4uibLEPJkowMakmlY0F83Go+p
         vyA2RvDmw4l7hFzz+YdjjWszpv5S7gIomIcJnCzorQWjx7G8EN1Jqxf9dmfi0p9ynPNk
         zrQxTQ1vR4THpFhEU/kIDZgUVnuiM8DVK54QQNMzvtRkAa20bhVqNa6FyldK+k4a+dZ7
         mh7slndvwfuqqstmPkOLckcKT0fTBk1EFQVGxF/Uc+vgqpF6zjL1okm77ZzEunJZOCaa
         hcBA==
X-Gm-Message-State: AOAM532x6mj04w9ffw+bAppb+Nt2K6X/KIHb+lhV22Xj5iVc6pQ6NFaN
        YmAvnWLqEjcImu0wJTNmOSdQ9ZPmQkY0Bw==
X-Google-Smtp-Source: ABdhPJxNFj4SaWaf+CEHELDkYcGKX4dGx6f74MDA0g+quiCRTyBR421vI6tU5LNfK/QXndGYvtka9g==
X-Received: by 2002:a17:90a:d150:: with SMTP id t16mr11364150pjw.179.1626707911928;
        Mon, 19 Jul 2021 08:18:31 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id u12sm4039373pju.15.2021.07.19.08.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 08:18:31 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, jolsa@kernel.org,
        hengqi.chen@gmail.com
Subject: [PATCH bpf-next v2] bpf: expose bpf_d_path helper to vfs_* and security_* functions
Date:   Mon, 19 Jul 2021 23:17:53 +0800
Message-Id: <20210719151753.399227-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add vfs_* and security_* to bpf_d_path allowlist, so that we can use
bpf_d_path helper to extract full file path from these functions'
`struct path *` and `struct file *` arguments. This will help tools
like IOVisor's filetop[2]/filelife to get full file path.

Changes since v1: [1]
 - Alexei and Yonghong suggested that bpf_d_path helper could also
   apply to vfs_* and security_file_* kernel functions. Added them.

[1] https://lore.kernel.org/bpf/20210712162424.2034006-1-hengqi.chen@gmail.com/
[2] https://github.com/iovisor/bcc/issues/3527

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 kernel/trace/bpf_trace.c | 50 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 08906007306d..c784f3c7143f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -850,16 +850,62 @@ BPF_CALL_3(bpf_d_path, struct path *, path, char *, buf, u32, sz)
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

