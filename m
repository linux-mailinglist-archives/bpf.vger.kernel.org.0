Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F5550727E
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 18:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354300AbiDSQHW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 12:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354319AbiDSQHP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 12:07:15 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83862344FF
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 09:04:32 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id b17so13480406qvp.6
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 09:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UUzTUcwpstS+E0CaU1mBGK6wnnvFxO/6H9iPMhWSudA=;
        b=IX5UfXYSWNk17f5LOqaIMxaEVWDFMvnKch+d+GsoVA/8Z0udW9Ges+G/GcsWX8OCSx
         cTtRlqiBTKVeYRaExc6iyQqqsK1sAQOIf5SJVFS3ZZbF0/1Bj6Fy8YIEyU2w9ObpflPf
         +Ha9TlQf0rJLHH7xxH1gMH9TiqzU5OwSzOZPUg59sDxYsV07Z79Uzt7a7cfVtVKr+l4B
         7MFzwMxxVa/Fv2jgr1boSXFjnganeUWC9rLnfpZYyF+ylbIg0EuWobpucnYYeEENPjiR
         pttrUB7P/QCgKU8feb6pJFd1hjcLJV2DA/Ky5jflVZqN0VbIQcUiFtsSnzJTEIOdpfw8
         betQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UUzTUcwpstS+E0CaU1mBGK6wnnvFxO/6H9iPMhWSudA=;
        b=bNWIyvOK9WtzKjhkJ73G/vohVwMOlaucuJs7t6pMYwMLSkNCsnRIdVLoK4kU25vKEb
         he0vLwUgAdouSjvr3XjBo4D3LRMn4Pw0Ogf7Ut4AdvkPUThSO2MaeiKkaQxSUcuFdSzE
         3l/1MX639TddukjjxjRtSXZQ+tZ3CQ2hHgyytpgtU+UO5cJR7Lp1zXIZJZdsod/FQx7y
         ETa2RB9nhIrvXwY3MpynfyrFdlA9I2l0eQqcL7/y0k98U2HMlrGLGXMWicNvI6H+LTDD
         fT8BkwU3Sd5XMnTLaX2XF1NImAwl4AupbOH+9iUr9xDCGt8KA8f5yBquOKBPW5ViSHBs
         fCTQ==
X-Gm-Message-State: AOAM530jy5zFUxef/3unxmrcb2DIGs1FvuRk7QRaL+1hT1LINyYKHrtP
        LsNNxpGrbNZqZhI1gZEWtt+lmqGT0Lx8jA==
X-Google-Smtp-Source: ABdhPJyolB1i6cbIWP7R1tQ3jte49lvNhs9kI/ZClwrtMfX+Xm6ghwURrvaIaRxHeGpWdlW5GYlQHA==
X-Received: by 2002:a05:6214:224f:b0:43f:cd6a:1d6b with SMTP id c15-20020a056214224f00b0043fcd6a1d6bmr12178852qvc.12.1650384271278;
        Tue, 19 Apr 2022 09:04:31 -0700 (PDT)
Received: from localhost.localdomain (pool-96-250-109-131.nycmny.fios.verizon.net. [96.250.109.131])
        by smtp.gmail.com with ESMTPSA id c3-20020ac87d83000000b002e1d1b3df15sm232204qtd.44.2022.04.19.09.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 09:04:30 -0700 (PDT)
From:   grantseltzer <grantseltzer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, grantseltzer@gmail.com, song@kernel.org
Subject: [PATCH bpf-next v3 3/3] Add documentation to API functions
Date:   Tue, 19 Apr 2022 12:03:46 -0400
Message-Id: <20220419160346.35633-3-grantseltzer@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220419160346.35633-1-grantseltzer@gmail.com>
References: <20220419160346.35633-1-grantseltzer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Grant Seltzer <grantseltzer@gmail.com>

This adds documentation for the following API functions:
- bpf_program__set_expected_attach_type()
- bpf_program__set_type()
- bpf_program__set_attach_target()
- bpf_program__attach()
- bpf_program__pin()
- bpf_program__unpin()

Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
---
 tools/lib/bpf/libbpf.h | 100 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 63d66f1adf1a..a2b9ec9f0990 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -378,7 +378,31 @@ struct bpf_link;
 LIBBPF_API struct bpf_link *bpf_link__open(const char *path);
 LIBBPF_API int bpf_link__fd(const struct bpf_link *link);
 LIBBPF_API const char *bpf_link__pin_path(const struct bpf_link *link);
+/**
+ * @brief **bpf_link__pin()** pins the BPF link to a file
+ * in the BPF FS specified by a path. This increments the links
+ * reference count, allowing it to stay loaded after the process
+ * which loaded it has exited.
+ *
+ * @param link BPF link to pin, must already be loaded
+ * @param path file path in a BPF file system
+ * @return 0, on success; negative error code, otherwise
+ */
+
 LIBBPF_API int bpf_link__pin(struct bpf_link *link, const char *path);
+
+/**
+ * @brief **bpf_link__unpin()** unpins the BPF link from a file
+ * in the BPFFS specified by a path. This decrements the links
+ * reference count.
+ *
+ * The file pinning the BPF link can also be unlinked by a different
+ * process in which case this function will return an error.
+ *
+ * @param prog BPF program to unpin
+ * @param path file path to the pin in a BPF file system
+ * @return 0, on success; negative error code, otherwise
+ */
 LIBBPF_API int bpf_link__unpin(struct bpf_link *link);
 LIBBPF_API int bpf_link__update_program(struct bpf_link *link,
 					struct bpf_program *prog);
@@ -386,6 +410,22 @@ LIBBPF_API void bpf_link__disconnect(struct bpf_link *link);
 LIBBPF_API int bpf_link__detach(struct bpf_link *link);
 LIBBPF_API int bpf_link__destroy(struct bpf_link *link);
 
+/**
+ * @brief **bpf_program__attach()** is a generic function for attaching
+ * a BPF program based on auto-detection of program type, attach type,
+ * and extra paremeters, where applicable.
+ *
+ * @param prog BPF program to attach
+ * @return Reference to the newly created BPF link; or NULL is returned on error,
+ * error code is stored in errno
+ *
+ * This is supported for:
+ *   - kprobe/kretprobe (depends on SEC() definition)
+ *   - uprobe/uretprobe (depends on SEC() definition)
+ *   - tracepoint
+ *   - raw tracepoint
+ *   - tracing programs (typed raw TP/fentry/fexit/fmod_ret)
+ */
 LIBBPF_API struct bpf_link *
 bpf_program__attach(const struct bpf_program *prog);
 
@@ -686,12 +726,45 @@ LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__set_type() instead")
 LIBBPF_API int bpf_program__set_sk_lookup(struct bpf_program *prog);
 
 LIBBPF_API enum bpf_prog_type bpf_program__type(const struct bpf_program *prog);
-LIBBPF_API void bpf_program__set_type(struct bpf_program *prog,
+/**
+ * @brief **bpf_program__set_type()** sets the program
+ * type of the passed BPF program. This must be done
+ * before the program is loaded, otherwise it has no
+ * effect.
+ * @param prog BPF program to set the program type for
+ * @param type program type to set the BPF map to have
+ * @return error code; or 0 if no error. An error occurs
+ * if the object is already loaded.
+ */
+LIBBPF_API int bpf_program__set_type(struct bpf_program *prog,
 				      enum bpf_prog_type type);
 
 LIBBPF_API enum bpf_attach_type
 bpf_program__expected_attach_type(const struct bpf_program *prog);
-LIBBPF_API void
+/**
+ * @brief **bpf_program__set_expected_attach_type()** sets the
+ * attach type of the passed BPF program. This is used for
+ * auto-detection of attachment when programs are loaded.
+ * @param prog BPF program to set the attach type for
+ * @param type attach type to set the BPF map to have
+ * @return error code; or 0 if no error. An error occurs
+ * if the object is already loaded.
+ *
+ * An example workflow:
+ *
+ * ...
+ *   xdp_fd = bpf_prog_get_fd_by_id(id);
+ *   trace_obj = bpf_object__open_file("func.o", NULL);
+ *   prog = bpf_object__find_program_by_title(trace_obj, "fentry/myfunc");
+ *   int err = bpf_program__set_expected_attach_type(prog, BPF_TRACE_FENTRY);
+ *   if (err != 0) {
+ *     // Object already loaded
+ *   }
+ *   bpf_program__set_attach_target(prog, xdp_fd, "xdpfilt_blk_all");
+ *   bpf_object__load(trace_obj);
+ * ...
+ */
+LIBBPF_API int
 bpf_program__set_expected_attach_type(struct bpf_program *prog,
 				      enum bpf_attach_type type);
 
@@ -707,6 +780,29 @@ LIBBPF_API int bpf_program__set_log_level(struct bpf_program *prog, __u32 log_le
 LIBBPF_API const char *bpf_program__log_buf(const struct bpf_program *prog, size_t *log_size);
 LIBBPF_API int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log_size);
 
+/**
+ * @brief **bpf_program__set_attach_target()** sets the
+ * specified BPF program to attach to a specific tracepoint
+ * or kernel function. This can be used to supplement
+ * the BPF program name/section not matching the tracepoint
+ * or function semanics.
+ * @param prog BPF program to set the attach type for
+ * @param type attach type to set the BPF map to have
+ * @return error code; or 0 if no error occurred.
+ * An example workflow:
+ *
+ * ...
+ *   xdp_fd = bpf_prog_get_fd_by_id(id);
+ *   trace_obj = bpf_object__open_file("func.o", NULL);
+ *   prog = bpf_object__find_program_by_title(trace_obj, "fentry/myfunc");
+ *   bpf_program__set_expected_attach_type(prog, BPF_TRACE_FENTRY);
+ *   int err = bpf_program__set_attach_target(prog, xdp_fd, "xdpfilt_blk_all");
+ *   if (err != 0) {
+ *     // Object already loaded
+ *   }
+ *   bpf_object__load(trace_obj);
+ * ...
+ */
 LIBBPF_API int
 bpf_program__set_attach_target(struct bpf_program *prog, int attach_prog_fd,
 			       const char *attach_func_name);
-- 
2.34.1

