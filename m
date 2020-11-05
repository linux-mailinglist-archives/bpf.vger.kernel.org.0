Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B2B2A8A3B
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 23:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732415AbgKEW6f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 17:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732035AbgKEW6e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 17:58:34 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F25C0613D2
        for <bpf@vger.kernel.org>; Thu,  5 Nov 2020 14:58:34 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id y12so3605968wrp.6
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2020 14:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GQFn82EPSsaqSkZSdg3eEn7h3cPHKXwNy46wDlBGgtk=;
        b=AfUyQ0GCER1kiz7y6Er5a1XrBzRmWwQCRun4Q/B9r1TDkD2nUEKBjTGy1TPuorkFl0
         A7uaOrPmRVGcBIOh/PdHDQ0IIzPmTh0CI8qQj5+5Vtb1Ey5bnQo3alrLKWw9/WneLLiH
         jT6fUjsyzTE6pnSt9h21AStcAzVSyyplBxSTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GQFn82EPSsaqSkZSdg3eEn7h3cPHKXwNy46wDlBGgtk=;
        b=HJFxccDS1rA6jNT7tgXiCKHhqovuwfcCdkZd2W0wReqRh/v21HZ7i4FkQX05BAvx+Q
         x5Gv6zinCqWFaYpsvE3VLqmYAbx7Tn6AhwHyvdYDWWBOr16ZadWWyowJQg+TJRXiVNqM
         8K1mUDPJWrlqouK/20V3+PPVjel188S8qYoiMVresGqlEOCE/8zFH+aI3gAixsdVHnx2
         EbJvlW8sQAVyfDoUpuXFkyRiLYlHxN9FocElU4psz4bZncwAxJb4wIHqkcYQk/0gHW5b
         Rqz0PK/OfvdAJl70uEftzIqfgSvnxscVrpNbf3uYkZPBjvWChkRP/NCK5dunEvCG0eaI
         S/1w==
X-Gm-Message-State: AOAM533KTHvo3Tkex4rX9j5892M+jy+J3X2eAPG7TkftU9w5zG0E4Tob
        /L/DIfDvukhyweP2McSP8cjRmA==
X-Google-Smtp-Source: ABdhPJyjHaHvfqN5Y2NQXokSE81fyWCQfq4G9DExZPFwX3NWsRso7D5U9KJBjPOH3fh/6tf0ePei2A==
X-Received: by 2002:adf:f90f:: with SMTP id b15mr5487937wrr.343.1604617113044;
        Thu, 05 Nov 2020 14:58:33 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id f19sm3977366wml.21.2020.11.05.14.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 14:58:32 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v5 3/9] libbpf: Add support for task local storage
Date:   Thu,  5 Nov 2020 22:58:21 +0000
Message-Id: <20201105225827.2619773-4-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201105225827.2619773-1-kpsingh@chromium.org>
References: <20201105225827.2619773-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Updates the bpf_probe_map_type API to also support
BPF_MAP_TYPE_TASK_STORAGE similar to other local storage maps.

Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/lib/bpf/libbpf_probes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 5482a9b7ae2d..ecaae2927ab8 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -230,6 +230,7 @@ bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex)
 		break;
 	case BPF_MAP_TYPE_SK_STORAGE:
 	case BPF_MAP_TYPE_INODE_STORAGE:
+	case BPF_MAP_TYPE_TASK_STORAGE:
 		btf_key_type_id = 1;
 		btf_value_type_id = 3;
 		value_size = 8;
-- 
2.29.1.341.ge80a0c044ae-goog

