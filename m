Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231CD34AC42
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 17:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhCZQGH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 12:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhCZQFm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Mar 2021 12:05:42 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0F5C0613B1
        for <bpf@vger.kernel.org>; Fri, 26 Mar 2021 09:05:42 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z2so6156643wrl.5
        for <bpf@vger.kernel.org>; Fri, 26 Mar 2021 09:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zQoMkVCtgJGZXmdu3KME93w0y7DWMF1NiaK0WZ/Njao=;
        b=c+9PKPHPQWy3wo5EWypLaXKArM+ciNIfHE9FYOFvc0BOz5q9EWn7yxqrFQQCXvrx7L
         TRTWIsmNz/YnqEJpjoTDkww998W9jGgrXntAcm0BwD/WFpYONRR0yox8H0w3KCM8pkbX
         aTDw/tcCgAq/eDw9tVYDqEp0GY1JInboUh670=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zQoMkVCtgJGZXmdu3KME93w0y7DWMF1NiaK0WZ/Njao=;
        b=p5fkom2sPQuq41/QFReY7CniRWyGenQ6m7XIAmuX2sLQFrOkgvI//2QrXtkvuGJ1lX
         fjpJC4gGOcCp6aqwLdTIlFQuMqsN1x/9zU2WDQN177DPR/V0Tc+S3ovscSpU48Jl/w3T
         jFsa5wsd6Yz+17WH0oFjMwgq1mUTcvond+9mhTNsnz8kgKCqsKt0ipIdGVrEgYa7iAyi
         +tlJ46xFmE+9m/jwjQiX4yWeIIBRXb3sIByuEYjhZ1/vnMLdGlzIUFF5z32T44cPXgPq
         knZ2+wO3+nMA+dQ0GrEKNaRZebHPbXL/IIFA0Nh0zmdSI348UdnoxAlUhxfH+XWb4ahD
         J/hA==
X-Gm-Message-State: AOAM532Bc9ye7JwGKkHEgyQq5WVB+0MHxsAZCDjJVCOVhnQoAnGdQPtt
        RhxZKryywkE+8McX/NzUho+oGw==
X-Google-Smtp-Source: ABdhPJxcmgrtuRv8romzbSyTFqTQSEJa4We5oSZ52yZtkB8W2HhNmi/u9IhtgCmLrgu5W1J+ucGIvQ==
X-Received: by 2002:a5d:4582:: with SMTP id p2mr14928666wrq.34.1616774740745;
        Fri, 26 Mar 2021 09:05:40 -0700 (PDT)
Received: from localhost.localdomain (5.0.8.c.b.e.d.6.4.e.c.a.1.e.f.4.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:4fe1:ace4:6deb:c805])
        by smtp.gmail.com with ESMTPSA id s20sm11692879wmj.36.2021.03.26.09.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 09:05:40 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf v2 1/2] bpf: link: refuse non-O_RDWR flags in BPF_OBJ_GET
Date:   Fri, 26 Mar 2021 16:05:00 +0000
Message-Id: <20210326160501.46234-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Invoking BPF_OBJ_GET on a pinned bpf_link checks the path access
permissions based on file_flags, but the returned fd ignores flags.
This means that any user can acquire a "read-write" fd for a pinned
link with mode 0664 by invoking BPF_OBJ_GET with BPF_F_RDONLY in
file_flags. The fd can be used to invoke BPF_LINK_DETACH, etc.

Fix this by refusing non-O_RDWR flags in BPF_OBJ_GET. This works
because OBJ_GET by default returns a read write mapping and libbpf
doesn't expose a way to override this behaviour for programs
and links.

Fixes: 70ed506c3bbc ("bpf: Introduce pinnable bpf_link abstraction")
Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 kernel/bpf/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 1576ff331ee4..dc56237d6960 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -547,7 +547,7 @@ int bpf_obj_get_user(const char __user *pathname, int flags)
 	else if (type == BPF_TYPE_MAP)
 		ret = bpf_map_new_fd(raw, f_flags);
 	else if (type == BPF_TYPE_LINK)
-		ret = bpf_link_new_fd(raw);
+		ret = (f_flags != O_RDWR) ? -EINVAL : bpf_link_new_fd(raw);
 	else
 		return -ENOENT;
 
-- 
2.27.0

