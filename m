Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8981643D8E
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 08:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiLFHTT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 02:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiLFHTS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 02:19:18 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2244815717;
        Mon,  5 Dec 2022 23:19:18 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id u5so4228190pjy.5;
        Mon, 05 Dec 2022 23:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wC+jgDs02zc9bwLl6AMbyEX4xn+dp/+JRiH8UBwdO7c=;
        b=X2b3y6qCh3VVvoH1Rd6ofeI0cnm6FpDnPv3sDWF5XU38qQbVCG34SRyT6/lKN5D23E
         LME5u42zSTywwqK7SU7C+gQ0PpmqbA4XEpW8IZcZaXdhTPz9/56XYWi7T9foANSEGYJM
         5XlAAHW7UaYV74O/b/WsWXwTiJzty68ZK05/KLfUG18uOh3Yc2ob83+zCgF8FpAGTIh7
         kC6QR57QrPr9Zzni359A/oPv2iwtUpt38ldljADqfJdnqxIOpHqnChLl4XcXFCDzsyaE
         /HaScXIeCuoRb2Q4bp+Ghu4n8yR34dpytC1cyFbwJCm6rDqd0KghI7hTxcHGgERW2XnQ
         KLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wC+jgDs02zc9bwLl6AMbyEX4xn+dp/+JRiH8UBwdO7c=;
        b=6IzMnqWJ6jq8MM+uWlGapxIU/h50fb10MIBVA7G0jp46ZYuvDfhqIxEM6vng07i3A+
         Fd7QOmA7j31kc0dhDIe8d2b8/CWpt5W0WeIJi4/M18WcszdP1ag1r2jnt4TIQOaC1Un6
         Ipgc+7GhXjbUOE93YFLQOSpG0S+nsVDZnLBpYTftxuUlOL7ekJZ5Kq+ux5rKCU1muAa/
         whbFE368qVeOa8ef9o5Y7OtNkh0E5iICji5qpmZ5nTSYN8as2t4DchkIC8nYgyerTFIp
         7HzqQn/Vu/Sw6Tws0Djt8gZQ1SCZJ5qFImGp5d5/rdKcfII0dd7XEIAk1mRttlLZnPgw
         OyCA==
X-Gm-Message-State: ANoB5pmdtP92sgmPWSeKnLlxwXnn628UYVxibXJ25/wXmqzgb50vjk6o
        Tou7iSWEVW4rJhhRebfLkwE=
X-Google-Smtp-Source: AA0mqf5flU9WXavqZ3VBbP6o+q5cajYHdPdQCKCk9kv2oo7BLWv2uHzSgqs6G/7NXExaWsp1nHlQRQ==
X-Received: by 2002:a17:902:f08d:b0:189:6b32:27dc with SMTP id p13-20020a170902f08d00b001896b3227dcmr52399133pla.29.1670311157567;
        Mon, 05 Dec 2022 23:19:17 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id pc16-20020a17090b3b9000b00212cf2fe8c3sm989912pjb.1.2022.12.05.23.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 23:19:16 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v2] bpftool: Fix memory leak in do_build_table_cb
Date:   Tue,  6 Dec 2022 11:19:06 +0400
Message-Id: <20221206071906.806384-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

strdup() allocates memory for path. We need to release the memory in
the following error path. Add free() to avoid memory leak.

Fixes: 8f184732b60b ("bpftool: Switch to libbpf's hashmap for pinned paths of BPF objects")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- move free(path); into error branch.
---
 tools/bpf/bpftool/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 0cdb4f711510..e7a11cff7245 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -499,6 +499,7 @@ static int do_build_table_cb(const char *fpath, const struct stat *sb,
 	if (err) {
 		p_err("failed to append entry to hashmap for ID %u, path '%s': %s",
 		      pinned_info.id, path, strerror(errno));
+		free(path);
 		goto out_close;
 	}
 
-- 
2.25.1

