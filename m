Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EB6508CEC
	for <lists+bpf@lfdr.de>; Wed, 20 Apr 2022 18:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349975AbiDTQPn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Apr 2022 12:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiDTQPn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 12:15:43 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407231AF32
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 09:12:53 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id s70so1556002qke.8
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 09:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YirZyGhFwGLz2nWcoe7jsOWnL1ZWpI03APwwR8ujjCI=;
        b=AKFkgRH3T+T8bjrwH4euWQAgdLOcQdpWevXuZJfifwidhqRO+i3B5OYZhnQisXvOsH
         airVakLT20eDtX29Yj8I+SakuMZ2hYDo351T5l1jjrHUnFbrg1MH89sdYeg1Ft4PplPz
         Lw++WFHtMTrAOrYtEJkVoH/ACVL2FGcd3EQahIlXzEqFlKmZuj6det5jp5RnxPby7Sck
         dygvuDkob5eqOcp/sw+U2+XP/YG+vXUkrCN6aUymG51E/v2TL2QsdReesQgbugkRMig0
         9oxlB6dl2oLAW0ZZjoY5Vl1NId/JAH/6kK5sICz1CDh5R4O+J9+/8+HYanCLKAP9batP
         ONOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YirZyGhFwGLz2nWcoe7jsOWnL1ZWpI03APwwR8ujjCI=;
        b=qz8dlOffR6c0UHyE2A692LDNRZOS7QnnvX3irdQ2Lsaxfgk3zWtVwFJDmKruRlvaVX
         z90O9wChBN5wHkkbXKodKuGvUNNEruAzZ7FDTQpcYsrfM22Ok9AnMcml/d9NK5RMjGX1
         vk+aHvj7f7S2Ga+MkWZPn9hVV78amaKToqKEKMGCX3B3wlR4XtwtprKazWW/+B/iflaQ
         /q7X9IXxgd+9Bf0fjxnFna80r273lOqeSpQMgpJAxxa4wojI1KDALE75SsMLyEeNAMPX
         UhbBQz02uadARPo+vAVc3nmk7lDyL8LDLX7PFlae4TUvhUS0dvmFJwmIwaX5YR/nZlnX
         EqpA==
X-Gm-Message-State: AOAM531XezxDTCJGUu8BTXlGcOB9YLSphJ7gHSU7QgaRJpXR1LeasYKk
        IXzXXNbeD9QVWsg6Qxd5174gnlfD3Ese9w==
X-Google-Smtp-Source: ABdhPJzE3W/UPpeleKqJrk6R7pdMgCyBnIU5sIWLG+zQgg1BalkJj7DoSkTzaHajAv6iuNeVGq5paQ==
X-Received: by 2002:a05:620a:4049:b0:69e:ab40:5bc9 with SMTP id i9-20020a05620a404900b0069eab405bc9mr7826703qko.319.1650471171852;
        Wed, 20 Apr 2022 09:12:51 -0700 (PDT)
Received: from localhost.localdomain (pool-96-250-109-131.nycmny.fios.verizon.net. [96.250.109.131])
        by smtp.gmail.com with ESMTPSA id f28-20020a05620a20dc00b0069d98e6bff9sm1694090qka.32.2022.04.20.09.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 09:12:51 -0700 (PDT)
From:   grantseltzer <grantseltzer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, grantseltzer@gmail.com, song@kernel.org
Subject: [PATCH bpf-next v4 3/3] Add documentation to API functions
Date:   Wed, 20 Apr 2022 12:12:26 -0400
Message-Id: <20220420161226.86803-3-grantseltzer@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220420161226.86803-1-grantseltzer@gmail.com>
References: <20220420161226.86803-1-grantseltzer@gmail.com>
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
 tools/lib/bpf/libbpf.h | 77 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 63d66f1adf1a..ddc33c78c70c 100644
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
 
@@ -686,12 +726,37 @@ LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_program__set_type() instead")
 LIBBPF_API int bpf_program__set_sk_lookup(struct bpf_program *prog);
 
 LIBBPF_API enum bpf_prog_type bpf_program__type(const struct bpf_program *prog);
-LIBBPF_API void bpf_program__set_type(struct bpf_program *prog,
+
+/**
+ * @brief **bpf_program__set_type()** sets the program
+ * type of the passed BPF program.
+ * @param prog BPF program to set the program type for
+ * @param type program type to set the BPF map to have
+ * @return error code; or 0 if no error. An error occurs
+ * if the object is already loaded.
+ *
+ * This must be called before the BPF object is loaded,
+ * otherwise it has no effect and an error is returned.
+ */
+LIBBPF_API int bpf_program__set_type(struct bpf_program *prog,
 				      enum bpf_prog_type type);
 
 LIBBPF_API enum bpf_attach_type
 bpf_program__expected_attach_type(const struct bpf_program *prog);
-LIBBPF_API void
+
+/**
+ * @brief **bpf_program__set_expected_attach_type()** sets the
+ * attach type of the passed BPF program. This is used for
+ * auto-detection of attachment when programs are loaded.
+ * @param prog BPF program to set the attach type for
+ * @param type attach type to set the BPF map to have
+ * @return error code; or 0 if no error. An error occurs
+ * if the object is already loaded.
+ *
+ * This must be called before the BPF object is loaded,
+ * otherwise it has no effect and an error is returned.
+ */
+LIBBPF_API int
 bpf_program__set_expected_attach_type(struct bpf_program *prog,
 				      enum bpf_attach_type type);
 
@@ -707,6 +772,14 @@ LIBBPF_API int bpf_program__set_log_level(struct bpf_program *prog, __u32 log_le
 LIBBPF_API const char *bpf_program__log_buf(const struct bpf_program *prog, size_t *log_size);
 LIBBPF_API int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log_size);
 
+/**
+ * @brief **bpf_program__set_attach_target()** sets BTF-based attach target
+ * for supported BPF program types:
+ * BTF-aware raw tracepoints, fentry/fexit/fmod_ret, lsm, freplace
+ * @param prog BPF program to set the attach type for
+ * @param type attach type to set the BPF map to have
+ * @return error code; or 0 if no error occurred.
+ */
 LIBBPF_API int
 bpf_program__set_attach_target(struct bpf_program *prog, int attach_prog_fd,
 			       const char *attach_func_name);
-- 
2.34.1

