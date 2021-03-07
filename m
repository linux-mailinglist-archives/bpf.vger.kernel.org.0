Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2EF3300B2
	for <lists+bpf@lfdr.de>; Sun,  7 Mar 2021 13:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhCGMKO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Mar 2021 07:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhCGMJ6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Mar 2021 07:09:58 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B07DC06174A
        for <bpf@vger.kernel.org>; Sun,  7 Mar 2021 04:09:58 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so2106414wml.2
        for <bpf@vger.kernel.org>; Sun, 07 Mar 2021 04:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9T16Nbpro9JN+rUYMwobVEmAKWWLwCRoIhHSkiXK6ps=;
        b=BjmNce/ht7lc+58UcynqG54mfekKYJctBliUlReVkIZZ09iGZD8OKHjb9nf+UmkB0U
         Z2ehsttT2V5nnOr91f+qOtROBsODvo7POx0zbyjJYdXCpZu7bYzUcvc4cyS/EsjJkTyO
         ffcylDkB6WpF5bTq6FElpYCAJUxC900XHwup5cK91ZT5v4bQa1nTXqksag1YKKVPBOQN
         mW49I3163rS0Y3RbH+bqiHdvC2G/qYgVSbqxVCQlGd+J/hxOKzJPcytgfYAgn56qj3ZZ
         TXd1nqoL6u1HVktYbFtAYJC0yCAcixVTnVawgiw3DDlTVKXpDDSVwkNAtCfsiQk/a2WT
         0aKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9T16Nbpro9JN+rUYMwobVEmAKWWLwCRoIhHSkiXK6ps=;
        b=ILVsiv0fkRwYD4i9w5Kth1vZtl6KMN+411U4GuAoeDXLrtrE8RkyWF5xMiTnTmDdDt
         Zeqyr1AJB6JtBocnqdIUtDId/cK7PzWn7d8gRFK9QYdMeE7ayHgIcAxgEqab0OWX5VJW
         OL3PhBKBjYX2uCeUlxiesLIzwAHnBWRrVAZZSMtfI5r5HKUYdE9lFC8rxQuNxH6iNcOy
         thcvX0tFxWQDiOMv1iDSqYOUE0L3wu4FdCquFBub+SRRq0wW6+Dr9FSkCaHOmBQKCe8R
         ufUZogp542xua7IJwWdegODKM/k8UKB81G0jys5TIr3TyoTo6p+60Nf2+tTIPPcbiOwi
         jw0Q==
X-Gm-Message-State: AOAM532yXaa9D9mrD19cUYtkcohSfIcNGHnab9UJKuYiNnFCOKxsHMO1
        wfnsFp03lJuDsRykd2PzMtKBrHKDPP6tggY=
X-Google-Smtp-Source: ABdhPJz2bZHvka5StxeO7IrBzwlIS0ZpgHVpQ+ZdHg3FTRX9sPZgiyIvtgd8xnx5g6gLjpNvwbyvRA==
X-Received: by 2002:a1c:a958:: with SMTP id s85mr17086466wme.138.1615118997131;
        Sun, 07 Mar 2021 04:09:57 -0800 (PST)
Received: from localhost.localdomain ([192.116.60.117])
        by smtp.gmail.com with ESMTPSA id 3sm14737257wry.72.2021.03.07.04.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 04:09:56 -0800 (PST)
From:   Tal Lossos <tallossos@gmail.com>
To:     bpf@vger.kernel.org
Cc:     yhs@fb.com, kpsingh@kernel.org, gilad.reti@gmail.com,
        Tal Lossos <tallossos@gmail.com>
Subject: [PATCH bpf-next v2] bpf: Change inode_storage's lookup_elem return value from NULL to -EBADF.
Date:   Sun,  7 Mar 2021 14:09:48 +0200
Message-Id: <20210307120948.61414-1-tallossos@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_fd_inode_storage_lookup_elem returned NULL when getting a bad FD,
which caused -ENOENT in bpf_map_copy_value.
EBADF is better than ENOENT for a bad FD behaviour.

The patch was partially contributed by CyberArk Software, Inc.

Signed-off-by: Tal Lossos <tallossos@gmail.com>
---
 kernel/bpf/bpf_inode_storage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index da753721457c..2921ca39a93e 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -109,7 +109,7 @@ static void *bpf_fd_inode_storage_lookup_elem(struct bpf_map *map, void *key)
 	fd = *(int *)key;
 	f = fget_raw(fd);
 	if (!f)
-		return NULL;
+		return ERR_PTR(-EBADF);
 
 	sdata = inode_storage_lookup(f->f_inode, map, true);
 	fput(f);
-- 
2.27.0

