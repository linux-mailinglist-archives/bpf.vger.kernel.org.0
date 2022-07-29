Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA62585615
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 22:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238647AbiG2U1g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 16:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiG2U1f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 16:27:35 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF546FA36;
        Fri, 29 Jul 2022 13:27:35 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id b9so5556326pfp.10;
        Fri, 29 Jul 2022 13:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=U36cxZBBBAsWK0SgXU07/6cSCngvofZtFK0Cv/h7b5Q=;
        b=B6/ndEJPHc4+9jyYT5GDz7FcNNUlakcC9XrRLetuqsQ9Hcy9CP512PPT2A5QM530vm
         izqu82rxhPC3e5vWCVDpoSSOE09mO8AfJEG2hF27RmKLOv/icjyHhwE4chwslxx+GVi5
         u1F4QwHrMgH22/KQkwKVxj9gkKZC4yyWrZkp8FcvJp0WmAS2C0v5ut7PluaFXRQItP2Q
         +K73SAK2Wo8v2C7LGnLsjDAofYfR3kzjEEYVxD+KxfL602ubXQHkbeRxgTY24kXapPb9
         rYIe5I+q3Bbyp0cmqpcQOLAUgGNqlWFY619rT6ocl0TCk2faUXHmWZLURo28k6UNDJGr
         HLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=U36cxZBBBAsWK0SgXU07/6cSCngvofZtFK0Cv/h7b5Q=;
        b=rDNhA1N2wjk04GOtJ8se3so8MhDcU73wPIh4OQRvzahH5Zq8NQKiC3tjgkNYaWpT0G
         rQpX97g1s8Wm4FiJoaaRRBKQtyFDoaHxXze7zCcG6B6eMd8pTtYwmbXf6v8adrMm5/E2
         HMDK98KVmYKNC9wlkZK8l0LmspU6nZ7ZFI3wvHwfmNy2EgfU/GRZBFclZlSGqb8UcoZT
         053Jorr9yjawOWaMywucYuxjIFCVW1RMH7vTapdxNDZO1ULSM+YGrDxt+15JPLCQnHcn
         k/hQBypg5/Hx0VSJS7cJ6hEkZmSFVSvqbaovHkLFhCUTEPZPL6AxHVqwte25eMN+/3H9
         FfHA==
X-Gm-Message-State: AJIora8bPPrD6MFq7mGkf5TB8wsuJzA6Z8ljvKWwuJkPWVryxWckhnOj
        bhyPkon0PirrNY1tAUWvROfErlywRA==
X-Google-Smtp-Source: AGRyM1sL8lAt8k/dgJPWI7c5WieHBqLG3euAM6eaRzH7JwksAuL2l81l0uFq+aZb0oBXQ4+tE7CKPg==
X-Received: by 2002:a05:6a00:2401:b0:52b:cd67:d997 with SMTP id z1-20020a056a00240100b0052bcd67d997mr5105428pfh.70.1659126454733;
        Fri, 29 Jul 2022 13:27:34 -0700 (PDT)
Received: from jevburton3.c.googlers.com.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id mg20-20020a17090b371400b001f30b100e04sm6235945pjb.15.2022.07.29.13.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 13:27:34 -0700 (PDT)
From:   Joe Burton <jevburton.kernel@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Joe Burton <jevburton@google.com>
Subject: [PATCH v3 bpf-next] libbpf: Add bpf_obj_get_opts()
Date:   Fri, 29 Jul 2022 20:27:27 +0000
Message-Id: <20220729202727.3311806-1-jevburton.kernel@gmail.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Joe Burton <jevburton@google.com>

Add an extensible variant of bpf_obj_get() capable of setting the
`file_flags` parameter.

This parameter is needed to enable unprivileged access to BPF maps.
Without a method like this, users must manually make the syscall.

Signed-off-by: Joe Burton <jevburton@google.com>
---
 tools/lib/bpf/bpf.c      |  9 +++++++++
 tools/lib/bpf/bpf.h      | 11 +++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 21 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 5eb0df90eb2b..efcc06dafbd9 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -578,12 +578,21 @@ int bpf_obj_pin(int fd, const char *pathname)
 }
 
 int bpf_obj_get(const char *pathname)
+{
+	return bpf_obj_get_opts(pathname, NULL);
+}
+
+int bpf_obj_get_opts(const char *pathname, const struct bpf_obj_get_opts *opts)
 {
 	union bpf_attr attr;
 	int fd;
 
+	if (!OPTS_VALID(opts, bpf_obj_get_opts))
+		return libbpf_err(-EINVAL);
+
 	memset(&attr, 0, sizeof(attr));
 	attr.pathname = ptr_to_u64((void *)pathname);
+	attr.file_flags = OPTS_GET(opts, file_flags, 0);
 
 	fd = sys_bpf_fd(BPF_OBJ_GET, &attr, sizeof(attr));
 	return libbpf_err_errno(fd);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 88a7cc4bd76f..9c50beabdd14 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -270,8 +270,19 @@ LIBBPF_API int bpf_map_update_batch(int fd, const void *keys, const void *values
 				    __u32 *count,
 				    const struct bpf_map_batch_opts *opts);
 
+struct bpf_obj_get_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+
+	__u32 file_flags;
+
+	size_t :0;
+};
+#define bpf_obj_get_opts__last_field file_flags
+
 LIBBPF_API int bpf_obj_pin(int fd, const char *pathname);
 LIBBPF_API int bpf_obj_get(const char *pathname);
+LIBBPF_API int bpf_obj_get_opts(const char *pathname,
+				const struct bpf_obj_get_opts *opts);
 
 struct bpf_prog_attach_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 0625adb9e888..119e6e1ea7f1 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -355,6 +355,7 @@ LIBBPF_0.8.0 {
 
 LIBBPF_1.0.0 {
 	global:
+		bpf_obj_get_opts;
 		bpf_prog_query_opts;
 		bpf_program__attach_ksyscall;
 		btf__add_enum64;
-- 
2.37.1.455.g008518b4e5-goog

