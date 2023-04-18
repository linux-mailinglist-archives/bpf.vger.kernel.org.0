Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143416E569E
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 03:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjDRBlW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 21:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjDRBlQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 21:41:16 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65C26A62
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 18:41:03 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54f3e30726cso211598217b3.22
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 18:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681782062; x=1684374062;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lsQkf1cfcx1tPqZWAOmJuqvsGQVDqkZnL5eNvi6K+GA=;
        b=UQ9uxhJbkgCQxRon02p9V9Zp2euXuXeVILgWOJj+rbvZ3QD7E30qpSzuqQRtpHzIcs
         8tnRPiCMZyAQmeuciCikVJLw4VTasapz/7TmXSqFJVxajgMpiDPL3jaC69UU0eF3Pmld
         suwPAwdtbxwHDIwMmZV1+ebFmsf+0c1mQqM0wqAbBAcWmTR/pu/B+pWRBe6CMDjEcF28
         52pROSussOyzq+qdDWeLqKG/NteVXVxS9qOWASMLH+0EyOqr9kwiYoF84wPX73T5L1ct
         9vIqWaFSNn9DOrA0aD+R+WbFQQl5+R6HM2rzlIC/vsjZJqWw523DmBw3bRNkdvwjG4sw
         pLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681782062; x=1684374062;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lsQkf1cfcx1tPqZWAOmJuqvsGQVDqkZnL5eNvi6K+GA=;
        b=YsrkzMxvDnb2yRJ/tukPRwpWVHf53TRP2LYi+CNklTY/X4pYapjZG9KkBD6jko/ZbW
         d+huBhOHuMx329C6b0Ixkuj/6Q+ceaB1C2FOFHh3x0vZnPsW1FshEZWNGjM3e6mw2Vay
         j6xuC9t+cQRxWSqzMI1+jfq4F27GVmrdyQp0gAuVk78OUZEIhhHE4IZmSPoIr389PVVO
         LOc1Z+OOxusOOxxjk/0YX6Vq9PPECs/ylw+UOT8RB65HXfyISRnRycFUHKl95cYKho/J
         zHY5qMh5INZ5xs3Te/6T2P6Nq/939k4dAOE9HeiSNVqEG+TS1sT90j5tyy7WGGRCDUwi
         HrYg==
X-Gm-Message-State: AAQBX9efOaJDw32cqnCjNtFhUeJYBs2y5oNRyaGoaY9hE1RrtC4TDNVu
        2IEdl+JBCSa8xdKTfTTzimvYGROYpI8=
X-Google-Smtp-Source: AKy350ZwWg/HHOg0CI32Fv3NaozHYx5kISDmv+5KnVkQwLfS05n+gGaQY14q9hCSUWer05c4Oi37kCTsPHw=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:e67a:98b0:942d:86aa])
 (user=drosen job=sendgmr) by 2002:a81:c406:0:b0:54d:913b:c9e8 with SMTP id
 j6-20020a81c406000000b0054d913bc9e8mr10100712ywi.5.1681782062021; Mon, 17 Apr
 2023 18:41:02 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:40:05 -0700
In-Reply-To: <20230418014037.2412394-1-drosen@google.com>
Mime-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418014037.2412394-6-drosen@google.com>
Subject: [RFC PATCH v3 05/37] fuse-bpf: Update fuse side uapi
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adds structures which will be used to inform fuse about what it is being
stacked on top of. Once filters are in place, error_in will inform the
post filter if the backing call returned an error.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 include/uapi/linux/fuse.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 1b9d0dfae72d..04d96f34e9a1 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -607,6 +607,29 @@ struct fuse_entry_out {
 	struct fuse_attr attr;
 };
 
+#define FUSE_BPF_MAX_ENTRIES	2
+
+enum fuse_bpf_type {
+	FUSE_ENTRY_BACKING		= 1,
+	FUSE_ENTRY_BPF			= 2,
+	FUSE_ENTRY_REMOVE_BACKING	= 3,
+	FUSE_ENTRY_REMOVE_BPF		= 4,
+};
+
+#define BPF_FUSE_NAME_MAX 15
+
+struct fuse_bpf_entry_out {
+	uint32_t	entry_type;
+	uint32_t	unused;
+	union {
+		struct {
+			uint64_t unused2;
+			uint64_t fd;
+		};
+		char name[BPF_FUSE_NAME_MAX + 1];
+	};
+};
+
 struct fuse_forget_in {
 	uint64_t	nlookup;
 };
-- 
2.40.0.634.g4ca3ef3211-goog

