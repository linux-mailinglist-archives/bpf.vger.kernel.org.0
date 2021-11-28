Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264EA46097C
	for <lists+bpf@lfdr.de>; Sun, 28 Nov 2021 20:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344013AbhK1TmC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Nov 2021 14:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357083AbhK1TkC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Nov 2021 14:40:02 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E175AC061758
        for <bpf@vger.kernel.org>; Sun, 28 Nov 2021 11:35:19 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id cq22-20020a17090af99600b001a9550a17a5so13645900pjb.2
        for <bpf@vger.kernel.org>; Sun, 28 Nov 2021 11:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dmNqlpcGID7Mev0eXWpsm8TOyOFu3TNt16/RTQ9aR0M=;
        b=ZyB77H7IdflSm344nUuGhRs7cOIxmTCF4EvhBS8sndMrzJLAgcqM7qKF36bmGdwvwL
         AugtbjtshmLaU7vcyn0hKvCu48EpbvON4UKZb0lA2HGzu/SjC+JrK9hBl7X8Zr9c3+GU
         ggKt96f4T4Yo6HHUPKEQByfbxEgYrPm6k6g19BB/C59Irn2/DkPx6rqRRwIjoEZ84bxZ
         srcbRdNeWxhu9vyc/WyV8KbjACzgIYyWAvdej0KmNojsy6KS6sVKI4NK4+0WUQwHqFqn
         xDMrpq8jKYMwuquKW1iHTTPaxJ5LxX77l3wp5a51yVOgjT8ZnL3edLnqX7aCiNmaQsGr
         0ylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dmNqlpcGID7Mev0eXWpsm8TOyOFu3TNt16/RTQ9aR0M=;
        b=31vMNYyn7NnlwnU2SGxs44o3rsQ1RL9p1JrnBeyW+K1qQSgk0WMMVSF8I7PuAl08mj
         QArBoX5mOXzUxe3vQ1JAxgnmaEbY8PNd6j6pMuzeGPJrLZFtFfT6c777i3gEahDnmmWi
         yVtNrrCa+ZvmA5PA6c5b0e9i6MC/DsPze8bL/zYV3seB2qiYmkcWRsFzECzPRmdVTays
         G8pXvqzcJh+TJTO+LW060wkt4KXisPbxjErVLl5iAHdfwavIh2Gj+cgYA+balmfDbSXP
         zbzJmhZOncxqrAvUL+TCq7pUHKl1Z+iLRJctuRNafSeFrBTZhnbdtHRfiWHM5rr/h6Sh
         44Qg==
X-Gm-Message-State: AOAM533RMy0wzT9wroJGH9iw1SpcHtJ+E/3bIjL8x5wKUI/E9Wu4Gre/
        pJeq+wQ11tBgXM3cNfMCswFI4m9epo0=
X-Google-Smtp-Source: ABdhPJz7I/m+xVOPjv8cRFebEwcwsCtrERjdnLLOi2JVdpPl/GngzVzPKs/vpqkZ1cZCOq1nYkzesA==
X-Received: by 2002:a17:90b:2249:: with SMTP id hk9mr32333028pjb.245.1638128119159;
        Sun, 28 Nov 2021 11:35:19 -0800 (PST)
Received: from localhost.localdomain ([68.170.74.242])
        by smtp.gmail.com with ESMTPSA id s16sm14474021pfu.109.2021.11.28.11.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 11:35:18 -0800 (PST)
From:   Mehrdad Arshad Rad <arshad.rad@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Mehrdad Arshad Rad <arshad.rad@gmail.com>
Subject: [PATCH bpf-next] libbpf: Remove duplicate assignments
Date:   Sun, 28 Nov 2021 11:33:37 -0800
Message-Id: <20211128193337.10628-1-arshad.rad@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There is a same action when load_attr.attach_btf_id is initialized.

Signed-off-by: Mehrdad Arshad Rad <arshad.rad@gmail.com>
---
 tools/lib/bpf/libbpf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 672671879b21..339680d2fea9 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6475,7 +6475,6 @@ static int bpf_object_load_prog_instance(struct bpf_object *obj, struct bpf_prog
 	load_attr.attach_btf_id = prog->attach_btf_id;
 	load_attr.attach_prog_fd = prog->attach_prog_fd;
 	load_attr.attach_btf_obj_fd = prog->attach_btf_obj_fd;
-	load_attr.attach_btf_id = prog->attach_btf_id;
 	load_attr.kern_version = kern_version;
 	load_attr.prog_ifindex = prog->prog_ifindex;
 
-- 
2.33.1

