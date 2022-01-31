Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F984A5203
	for <lists+bpf@lfdr.de>; Mon, 31 Jan 2022 23:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiAaWFj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 Jan 2022 17:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiAaWFh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Jan 2022 17:05:37 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F26C061714
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 14:05:37 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id z10-20020a17090acb0a00b001b520826011so533149pjt.5
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 14:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ExzQCm1Cob3B/RxP+ekQVOx0efrBc719H5atIcS561A=;
        b=i3XT1q6PmQl4+gp58wXmv3L/jUbXqzYxGCrwi/fv5pBWPTZ2BQPdpShZIDrBSfL8DD
         LJ3CIERxT9Rwgi/OFPkt3BEpm+uxBt/JuwEChX1tupj3l0TLHu0dmRJVgzWOIMrkLTNe
         AIzJslvtX9T9a/EzGtNBU0kx6z8O5IYLdLFgREf21puLHLI7kRaXDxzhXReT1cQokjcX
         A0F8aGb8Ik3z3xBSXz1+MWM4mueDnEGVPH4xEBm3wwp5zO4KiFl5JbM3dsklWyRtwyQm
         V7NfQ3/pRQTm9a8RE3KWHXoc4T6EbThMrIWYdwrqmIpuIqvsZ1zKkGDV8R2NmV6aXMwg
         wtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ExzQCm1Cob3B/RxP+ekQVOx0efrBc719H5atIcS561A=;
        b=dvogqANx972qtMr/4t8PDlc0/MtvWDUlr6v2ay7iPJtcYy3oSx/XwZeWWiuoiiKLz3
         CPZa6xCB0YCjgQffIb4DbMO7rImM02nLI1xmhFnpa2LVBanhOpXEKtoZYcUszS448rMC
         WCNz05Zjmf+Uzzn4vI1nMmHh/7C1zXqq6ZgE0aTQnRi5YPPi2DZr4JNuHocI6d3aeFlN
         DHXB0Iya/89h3Lh4MXl/4EEY633BIZdseHqcuPWkl/91jlwCTIpq/i9CEyTPvIA+WEox
         SwtNzrpQbY/KORsqptrvfLKAlEsD4zE+2DqWTJASgnHjBlqAdfWZlDzCVWxsTlliQ9xC
         NinQ==
X-Gm-Message-State: AOAM531BZcmv486Td6X4qhYwek5nl2x0KlRFdPLuE0lUb68L+i9HYt1s
        OrR4L5SxE5dRCo2HaoLpuYU=
X-Google-Smtp-Source: ABdhPJzvfn0xJNKzof7bnUYpEWonXZn/mqf3qdq8iAIbtejlFgSvqECt1NRrvkoetP6NCEpkYQg+Qw==
X-Received: by 2002:a17:902:f682:: with SMTP id l2mr22535105plg.114.1643666736712;
        Mon, 31 Jan 2022 14:05:36 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:78b6])
        by smtp.gmail.com with ESMTPSA id l8sm19883755pfc.187.2022.01.31.14.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:05:36 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH bpf-next 2/7] libbpf: Open code low level bpf commands.
Date:   Mon, 31 Jan 2022 14:05:23 -0800
Message-Id: <20220131220528.98088-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220131220528.98088-1-alexei.starovoitov@gmail.com>
References: <20220131220528.98088-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Open code low level bpf commands used by light skeleton to
be able to avoid full libbpf eventually.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/skel_internal.h | 44 +++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
index 0b84d8e6b72a..57507f1c1934 100644
--- a/tools/lib/bpf/skel_internal.h
+++ b/tools/lib/bpf/skel_internal.h
@@ -70,19 +70,59 @@ static inline int skel_closenz(int fd)
 	return -EINVAL;
 }
 
+#ifndef offsetofend
+#define offsetofend(TYPE, MEMBER) \
+	(offsetof(TYPE, MEMBER)	+ sizeof((((TYPE *)0)->MEMBER)))
+#endif
+
+static inline int skel_map_create(enum bpf_map_type map_type,
+				  const char *map_name,
+				  __u32 key_size,
+				  __u32 value_size,
+				  __u32 max_entries)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, map_extra);
+	union bpf_attr attr;
+
+	memset(&attr, 0, attr_sz);
+
+	attr.map_type = map_type;
+	strncpy(attr.map_name, map_name, sizeof(attr.map_name));
+	attr.key_size = key_size;
+	attr.value_size = value_size;
+	attr.max_entries = max_entries;
+
+	return skel_sys_bpf(BPF_MAP_CREATE, &attr, attr_sz);
+}
+
+static inline int skel_map_update_elem(int fd, const void *key,
+				       const void *value, __u64 flags)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, flags);
+	union bpf_attr attr;
+
+	memset(&attr, 0, attr_sz);
+	attr.map_fd = fd;
+	attr.key = (long) key;
+	attr.value = (long) value;
+	attr.flags = flags;
+
+	return skel_sys_bpf(BPF_MAP_UPDATE_ELEM, &attr, attr_sz);
+}
+
 static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
 {
 	int map_fd = -1, prog_fd = -1, key = 0, err;
 	union bpf_attr attr;
 
-	map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "__loader.map", 4, opts->data_sz, 1, NULL);
+	map_fd = skel_map_create(BPF_MAP_TYPE_ARRAY, "__loader.map", 4, opts->data_sz, 1);
 	if (map_fd < 0) {
 		opts->errstr = "failed to create loader map";
 		err = -errno;
 		goto out;
 	}
 
-	err = bpf_map_update_elem(map_fd, &key, opts->data, 0);
+	err = skel_map_update_elem(map_fd, &key, opts->data, 0);
 	if (err < 0) {
 		opts->errstr = "failed to update loader map";
 		err = -errno;
-- 
2.30.2

