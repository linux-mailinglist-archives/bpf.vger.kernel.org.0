Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D394046F757
	for <lists+bpf@lfdr.de>; Fri, 10 Dec 2021 00:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbhLIX0h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Dec 2021 18:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhLIX0h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Dec 2021 18:26:37 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CAEC061746
        for <bpf@vger.kernel.org>; Thu,  9 Dec 2021 15:23:03 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id a24so6575632qvb.5
        for <bpf@vger.kernel.org>; Thu, 09 Dec 2021 15:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6ZyFZflVxMIPFk789obWfFVWoQojaiSoWwfUf9YgFwM=;
        b=TpeS+E25ibFTo5OJPHVlR9u+qOVOZTemxUnSyZiicUH0zO/7kA6sPUDW+TlM16/0Wz
         7UmOwRVqN6JQmeS43kPERRJsqAmPwa3BXe5+qMfaJInHjePMcK/ywi6tk+ztRIGNdeJq
         lqhqD4qRhoxh7+g8oX53P+p7iDkDA+zQBXXHdekeQpTqNqgreA1Ry9x57X2aPxjLnloY
         GPdartiGzNoPpVhzROwfrKP7QpujiXTE9anvkLDWvyRfdoLPNTqXdJB/zewGiHLGd34L
         B3QGanMUI7uUpWQlzhG+iiEscHpnwZMDJgT2mErUmhSTgKYgmCz+R7qPT5/GDlRSk3Kh
         YzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6ZyFZflVxMIPFk789obWfFVWoQojaiSoWwfUf9YgFwM=;
        b=6wKWfjdHFUWaODAH3b7D0ofsYaB6D9zvmT7NfKPmPTpj+/r/+7X8FCgbQyM4b/vrrM
         eCGbCBJHAmdeMCX36PM/5HWmtPEI8URsPnxusyNfsUOgAVlc8vtRyG6BcVIyNfj9v21l
         p9KcdsMmKzcCaiShFq3SuMlUyuS7KEYWN87p2qjH4tmy46UUL7tZVrpLl6qhA4PWQmZJ
         qm/Vdhrs9f8ccm/sZKy/6h9vq6bYDIWyZzT2qaT1NPCC7uVIiPkZu4izGOjnsCpYCJw5
         Vxqi/e8rGOZWltyQtwZlc3Xw673FatSPYRR5lXrEQ+4o+3TtOHb3oYcLRokEAZkdG30h
         I+Dw==
X-Gm-Message-State: AOAM531/tw/MMu1FsLCVzhCmFFDEGRlNOq/pmlFmHaGfIJ9j0K9QQzvq
        KH7X0Dja6MZjJs7RtzpOAY7APrcGVxd5thPg
X-Google-Smtp-Source: ABdhPJyzDM0vjDCPKsqsLd5AYM3hDhD+iXeYvkAYLlsTCrBSub7k3vvJ3DSeETMWc/fSI/ISyqIjxg==
X-Received: by 2002:a05:6214:2623:: with SMTP id gv3mr21240720qvb.63.1639092182062;
        Thu, 09 Dec 2021 15:23:02 -0800 (PST)
Received: from localhost.localdomain (cpe-104-162-105-43.nyc.res.rr.com. [104.162.105.43])
        by smtp.gmail.com with ESMTPSA id f12sm720459qtj.93.2021.12.09.15.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 15:23:00 -0800 (PST)
From:   grantseltzer <grantseltzer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, grantseltzer@gmail.com
Subject: [PATCH bpf-next] libbpf: Add doc comments for bpf_program__(un)pin()
Date:   Thu,  9 Dec 2021 18:22:22 -0500
Message-Id: <20211209232222.541733-1-grantseltzer@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Grant Seltzer <grantseltzer@gmail.com>

This adds doc comments for the two bpf_program pinning functions,
bpf_program__pin() and bpf_program__unpin()

Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
---
 tools/lib/bpf/libbpf.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 4802c1e73..d6518f30a 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -299,7 +299,31 @@ LIBBPF_DEPRECATED_SINCE(0, 7, "multi-instance bpf_program support is deprecated"
 LIBBPF_API int bpf_program__unpin_instance(struct bpf_program *prog,
 					   const char *path,
 					   int instance);
+
+/**
+ * @brief **bpf_program__pin()** pins the BPF program to a file
+ * in the BPFFS specified by a path. This increments the programs
+ * reference count, allowing it to stay loaded after the process
+ * which loaded it has exited.
+ *
+ * @param prog BPF program to pin, must already be loaded
+ * @param path filepath in a BPF Filesystem
+ * @return int error code, 0 if no error (errno is also set to error)
+ */
 LIBBPF_API int bpf_program__pin(struct bpf_program *prog, const char *path);
+
+/**
+ * @brief **bpf_program__unpin()** unpins the BPF program from a file
+ * in the BPFFS specified by a path. This decrements the programs
+ * reference count.
+ *
+ * The file pinning the BPF program can also be unlinked by a different
+ * process in which case this function will return an error
+ *
+ * @param prog BPF program to unpin
+ * @param path filepath to the pin in a BPF Filesystem
+ * @return int error code, 0 if no error (errno is also set to error)
+ */
 LIBBPF_API int bpf_program__unpin(struct bpf_program *prog, const char *path);
 LIBBPF_API void bpf_program__unload(struct bpf_program *prog);
 
-- 
2.33.1

