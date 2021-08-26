Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212783F8927
	for <lists+bpf@lfdr.de>; Thu, 26 Aug 2021 15:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242652AbhHZNkQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 09:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242601AbhHZNkP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Aug 2021 09:40:15 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021C1C061757;
        Thu, 26 Aug 2021 06:39:28 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id j1so2226634pjv.3;
        Thu, 26 Aug 2021 06:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SQ8X68+agmo/9YIuGhT9zb0QxYHN2zLKWc/jICvz7q0=;
        b=Po1YYxpEyLyYWZqDoAMVn9GmaKXBB1P5i7AjLj1ItDim/6/5LFpK0+7XbxUdGYXw8W
         0vfFS7rK9drXrWoT5PWbFYFGa+McstOePM02mbyw9VWAwy9SF7hKIt4JKwpl+yvt7FbO
         e8kJ3eg0FR8RGb/kjrazXg1ZAcTNfmwuYgnHC2U72bciP+vjlrzPS8SsaWD4P2MFjmHF
         2mDstd1in0jmSqohPZ2E8AqEGUgbUvetW9ZUxVmlc/p9M5Oms5EFw+EnqTSLsOCgic33
         za/A7Ism3ZiNUmR+TEgg9l25trE6LeRFn3Zd7xb5O5W6GRnv1GQAMcxyh3Ol5CG7oL/4
         Huiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SQ8X68+agmo/9YIuGhT9zb0QxYHN2zLKWc/jICvz7q0=;
        b=K99e8KtTigTLVBMrl13zFis4d9K712hkCZF8zUM+52+cuL4qZgmRpK6LLTvwUdSKxo
         GCDg9OEqCRCW12Y5mJgjik/+vs9WaWFe1Zd5t2R9F9R+6g9wo/gFYZUfmxm+mnYvptJu
         KIpmXa3UeAM5eGBVr/nRbPaY+pIXs2CpWJswm/42uejJQecAEKUI1G5M6+CCc6xwNKM7
         ASLwzpkhkzhJPiVH28LZzfCQuqdO148DwMLFMNwRq/2pOVMFPWDkz4jZFnLr3Y2TS7l0
         4DC9b0JlwTBztjTrHSpI/4QABSofeDztb1B3z1r2TT4denxZIyNd+l1y6aZa7csXLSmZ
         iC+w==
X-Gm-Message-State: AOAM531BgNmGvy8IHK0cYKK9zh0iWl4EhruYZc5ZvycR/flXPzeJvszA
        vypqPlEJqLU0lfTMv57QyQJmbvKH3V4=
X-Google-Smtp-Source: ABdhPJzVj8Twv4CwSQJuK1Jpsdk7ku+SLYJQ82nGUUQxzISLjtsVZ8/zKK0LQ4VN+XrtZx074JUbng==
X-Received: by 2002:a17:902:b102:b0:134:a329:c2f8 with SMTP id q2-20020a170902b10200b00134a329c2f8mr3714167plr.71.1629985167354;
        Thu, 26 Aug 2021 06:39:27 -0700 (PDT)
Received: from localhost ([2405:201:6014:d820:9cc6:d37f:c2fd:dc6])
        by smtp.gmail.com with ESMTPSA id 11sm3052712pfl.41.2021.08.26.06.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 06:39:27 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Spencer Baugh <sbaugh@catern.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Alexander Mihalicyn <alexander@mihalicyn.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH bpf-next v2 3/5] libbpf: Add bpf_probe_map_type support for file local storage
Date:   Thu, 26 Aug 2021 19:09:11 +0530
Message-Id: <20210826133913.627361-4-memxor@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210826133913.627361-1-memxor@gmail.com>
References: <20210826133913.627361-1-memxor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/libbpf_probes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index cd8c703dde71..a97f2088c53a 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -233,6 +233,7 @@ bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex)
 	case BPF_MAP_TYPE_SK_STORAGE:
 	case BPF_MAP_TYPE_INODE_STORAGE:
 	case BPF_MAP_TYPE_TASK_STORAGE:
+	case BPF_MAP_TYPE_FILE_STORAGE:
 		btf_key_type_id = 1;
 		btf_value_type_id = 3;
 		value_size = 8;
-- 
2.33.0

