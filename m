Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730B6500E5B
	for <lists+bpf@lfdr.de>; Thu, 14 Apr 2022 15:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243116AbiDNNLQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Apr 2022 09:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbiDNNLQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Apr 2022 09:11:16 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C8E7890F
        for <bpf@vger.kernel.org>; Thu, 14 Apr 2022 06:08:50 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id d9so3935514qvm.4
        for <bpf@vger.kernel.org>; Thu, 14 Apr 2022 06:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6hvYNqBVb9Erx1Inv4EoefZdAhnrF0S9OlZ9Sx97f74=;
        b=lGpLS9a3bKcTWb+b0X4fmnwWBd9nOQJq32CKmykR88rGjNqgcgOnorjzfknHs/kV/f
         nb8GR4aiWCKddaHVP4quSI1jQ/Bh5m29CDZrTMxGY+br5CCvL51VPGd3BO/jUNTxRPeE
         A7ZWRYA7AWMkX4ZsPrxlbPHQn0VD7R5BcrpaSaJYvP3D3YiXxkSpNaA+Fp0MyIXQo+6r
         jaTVzFaDBku+LZ9U9ymLk7d6Rx8d7d75wFjJ9UJC65FfX7QgKWPplNhSkreTN+88VOa4
         zFNJ0OlRwon1e95XFffecPq2wnOJolvYV8Qrbwcxlz+jwRWnT0hd7yPx3SnvYQDYTm5d
         0o3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6hvYNqBVb9Erx1Inv4EoefZdAhnrF0S9OlZ9Sx97f74=;
        b=CQCLfR2t3snS6z+JlIKuBZB0DsQy/GWBNdhBsnLnk4PSTjz9XExTzx3CnMSw+rCPeC
         JjEK6G4D1C5NdbwYHAkq7B5iDEesRJBE+OQW9hKRjag9X7RFuafc/J4VqyEpQkwtiGo8
         kzOarpiveLazscQ5seOZHTv/cx2ynLZGXsU4w94J41YsN88p/mQRBHwg7ai/n+U9ZGhv
         wcc7+VI5zBvN1FZj3USEdPvvCRwxwS4ml2O8JdkktBKTn7wPwCDqE2JZM37+t19+qHpB
         9p56sc5PZAjGuOMTGy+uQvmncDm7onu3in4o4XjYfyxPRndvMLfmuooui3Z4qpbqqj8f
         cV2Q==
X-Gm-Message-State: AOAM533KAUmmpQMHhf3pyM7phFKsf4/jg9zfTf8pTwSWvQBKxiI4OD8i
        V/WIoVUFoy5cyjlx9ttKCWCjLxIkSNuD9g==
X-Google-Smtp-Source: ABdhPJx6KHl6qebiAoJ9aUDlrTDyLR/bl4+fpLz1oJXwRTKx+jNJKVDS7EMn8hfudmVp0c5hS9H7KA==
X-Received: by 2002:a0c:f7c8:0:b0:444:4ef6:8282 with SMTP id f8-20020a0cf7c8000000b004444ef68282mr3152094qvo.63.1649941729006;
        Thu, 14 Apr 2022 06:08:49 -0700 (PDT)
Received: from localhost.localdomain (cpe-104-162-105-43.nyc.res.rr.com. [104.162.105.43])
        by smtp.gmail.com with ESMTPSA id z15-20020a05622a060f00b002e2070bf899sm1080590qta.90.2022.04.14.06.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 06:08:48 -0700 (PDT)
From:   grantseltzer <grantseltzer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, grantseltzer@gmail.com
Subject: [PATCH v2 bpf-next] Add documentation to API functions
Date:   Thu, 14 Apr 2022 09:08:32 -0400
Message-Id: <20220414130832.101112-1-grantseltzer@gmail.com>
X-Mailer: git-send-email 2.34.1
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
 tools/lib/bpf/libbpf.h | 84 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 63d66f1adf1a..09a8bf2fd7d9 100644
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
+ * @param link BPF link to unpin
+ * @param path file path to the pin in a BPF file system
+ * @return 0, on success; negative error code, otherwise
+ */
 LIBBPF_API int bpf_link__unpin(struct bpf_link *link);
 LIBBPF_API int bpf_link__update_program(struct bpf_link *link,
 					struct bpf_program *prog);
@@ -386,6 +410,21 @@ LIBBPF_API void bpf_link__disconnect(struct bpf_link *link);
 LIBBPF_API int bpf_link__detach(struct bpf_link *link);
 LIBBPF_API int bpf_link__destroy(struct bpf_link *link);
 
+/**
+ * @brief **bpf_program__attach()** is a generic function for attaching
+ * a BPF program based on auto-detection of program type, attach type,
+ * and extra parameters, where applicable.
+ *
+ * @param prog BPF program to attach
+ * @return Reference to the newly created BPF link; or NULL is returned on error,
+ * error code is stored in errno
+ *
+ * This is supported for:
+ *   - kprobe/kretprobe
+ *   - tracepoint
+ *   - raw tracepoint
+ *   - tracing programs (typed raw TP/fentry/fexit/fmod_ret)
+ */
 LIBBPF_API struct bpf_link *
 bpf_program__attach(const struct bpf_program *prog);
 
@@ -686,11 +725,36 @@ LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__set_type() instead")
 LIBBPF_API int bpf_program__set_sk_lookup(struct bpf_program *prog);
 
 LIBBPF_API enum bpf_prog_type bpf_program__type(const struct bpf_program *prog);
+/**
+ * @brief **bpf_program__set_type()** sets the program
+ * type of the passed BPF program.
+ * @param prog BPF program to set the program type for
+ * @param type program type to set the BPF map to have
+ */
 LIBBPF_API void bpf_program__set_type(struct bpf_program *prog,
 				      enum bpf_prog_type type);
 
 LIBBPF_API enum bpf_attach_type
 bpf_program__expected_attach_type(const struct bpf_program *prog);
+/**
+ * @brief **bpf_program__set_expected_attach_type()** sets the
+ * attach type of the passed BPF program. This is used for
+ * auto-detection of attachment when programs are loaded.
+ * @param prog BPF program to set the attach type for
+ * @param type attach type to set the BPF map to have
+ *
+ * An example workflow:
+ *
+ * ...
+ *   xdp_fd = bpf_prog_get_fd_by_id(id);
+ *   trace_obj = bpf_object__open_file("func.o", NULL);
+ *   prog = bpf_object__find_program_by_title(trace_obj, "fentry/myfunc");
+ *   bpf_program__set_expected_attach_type(prog, BPF_TRACE_FENTRY);
+ *   bpf_program__set_attach_target(prog, xdp_fd, "xdpfilt_blk_all");
+ *   bpf_object__load(trace_obj);
+ * ...
+ *
+ */
 LIBBPF_API void
 bpf_program__set_expected_attach_type(struct bpf_program *prog,
 				      enum bpf_attach_type type);
@@ -707,6 +771,26 @@ LIBBPF_API int bpf_program__set_log_level(struct bpf_program *prog, __u32 log_le
 LIBBPF_API const char *bpf_program__log_buf(const struct bpf_program *prog, size_t *log_size);
 LIBBPF_API int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log_size);
 
+/**
+ * @brief **bpf_program__set_attach_target()** sets the
+ * specified BPF program to attach to a specific tracepoint
+ * or kernel function. This can be used to supplement
+ * the BPF program name/section not matching the tracepoint
+ * or function semantics.
+ * @param prog BPF program to set the attach type for
+ * @param type attach type to set the BPF map to have
+ *
+ * An example workflow:
+ *
+ * ...
+ *   xdp_fd = bpf_prog_get_fd_by_id(id);
+ *   trace_obj = bpf_object__open_file("func.o", NULL);
+ *   prog = bpf_object__find_program_by_title(trace_obj, "fentry/myfunc");
+ *   bpf_program__set_expected_attach_type(prog, BPF_TRACE_FENTRY);
+ *   bpf_program__set_attach_target(prog, xdp_fd, "xdpfilt_blk_all");
+ *   bpf_object__load(trace_obj);
+ * ...
+ */
 LIBBPF_API int
 bpf_program__set_attach_target(struct bpf_program *prog, int attach_prog_fd,
 			       const char *attach_func_name);
-- 
2.34.1

