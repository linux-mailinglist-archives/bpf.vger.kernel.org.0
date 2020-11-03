Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334322A49E7
	for <lists+bpf@lfdr.de>; Tue,  3 Nov 2020 16:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgKCPcJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 10:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbgKCPbl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Nov 2020 10:31:41 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340B3C061A04
        for <bpf@vger.kernel.org>; Tue,  3 Nov 2020 07:31:41 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c18so13173688wme.2
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2020 07:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kXlb9heLa6kkwouNTwIIOIWMo+YR89VhadoqFB4UnL4=;
        b=AWSOfzSfAjrXvlG/k8OB/VxWgM6ajWM7CMBaq62WE4Syycr0k8qgmylvnRyGTPQwYm
         cQcZnmO+ryY7/Fk1tSrYWvCiAuZbr5CAuwGE1ZB/w/44REfMKXUyCwFQFc2+SGbBYWlN
         XeX8rXsiNiwGlAg6ClW02e7LwUaFm2scamauU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kXlb9heLa6kkwouNTwIIOIWMo+YR89VhadoqFB4UnL4=;
        b=pV76fS2N8aOgLhZiGiWj+60XECzxnQv5XA/NexuNld4vax5ecJGrfodC8mJ/opoFy+
         s1l8R+JPo2x5tkdYZJHfD3/9Jg0e+q8zOzFjAZ0ar/4xHIikVDcK9t5TuCmQ9Bj3Iz+o
         DLe4YBO36EwmnA731x9FX3JJAp6kJOJhYQRb8I4eifV54IXHGX3pzKlF1PxX8PGCYIMu
         z85odqws7jHor3VL2Au7xPy3UKQuU7w/P5FMOKUUZ6Fp2sHxxQhpzvC0Yr6Ss6a7zOCa
         +jp3vaitoy/W3UokEd7s5GskgQhbljZ9P/mKJyX59HABK+TjN0H/b86JhW7WT2oAubVn
         nGOg==
X-Gm-Message-State: AOAM531oy/xQjHUmyftp5+rm9zG/NbXnICMUz8U0/4K4C5utRb9zjfHq
        c5obV1YCPtQ2O4qc/TaBmzqjIg==
X-Google-Smtp-Source: ABdhPJy4uWEyZvhM164baFgqEmCr0TVVkuxKVbl83kdii9i3U8zspWt3idT5hly5tvCAc75IlJRpAA==
X-Received: by 2002:a1c:6456:: with SMTP id y83mr320087wmb.59.1604417499734;
        Tue, 03 Nov 2020 07:31:39 -0800 (PST)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id m126sm2451966wmm.0.2020.11.03.07.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:31:39 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v2 2/8] libbpf: Add support for task local storage
Date:   Tue,  3 Nov 2020 16:31:26 +0100
Message-Id: <20201103153132.2717326-3-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201103153132.2717326-1-kpsingh@chromium.org>
References: <20201103153132.2717326-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/lib/bpf/libbpf_probes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 5482a9b7ae2d..bed00ca194f0 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 /* Copyright (c) 2019 Netronome Systems, Inc. */
 
+#include "linux/bpf.h"
 #include <errno.h>
 #include <fcntl.h>
 #include <string.h>
@@ -230,6 +231,7 @@ bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex)
 		break;
 	case BPF_MAP_TYPE_SK_STORAGE:
 	case BPF_MAP_TYPE_INODE_STORAGE:
+	case BPF_MAP_TYPE_TASK_STORAGE:
 		btf_key_type_id = 1;
 		btf_value_type_id = 3;
 		value_size = 8;
-- 
2.29.1.341.ge80a0c044ae-goog

