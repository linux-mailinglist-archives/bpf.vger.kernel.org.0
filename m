Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBF74FEB3F
	for <lists+bpf@lfdr.de>; Wed, 13 Apr 2022 01:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbiDLXfo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Apr 2022 19:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiDLXco (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Apr 2022 19:32:44 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A674DC0549
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 15:19:32 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n8so291491plh.1
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 15:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NXYriN68WEaDGO+51HtETWH0OR2nXCbI78x/3AkLtc4=;
        b=e7BBQbbMliu6kU5oldGaJTR1GYt+FjhLZiGhtdGglZIq4s5B6Li1sJiqNgR1Oh2KRD
         inuaWtIWKeMbkCoSFuxf9EiX4SPp3bNXuXiKPR3UeL7dvHtyeYlSX0iVqEituIW//sxU
         tGf6oeTGD24B0Ge0XpsmOE+mxo8Jg1JCOYt+QSmfb9Gc/MfJL3QL079sdx05JMac9Yy8
         TmOok8Mbf8rOYhupdtCgxsICp1dANDxsel00M57bi9TuVqin8BNE6cBljomU2/tUCJj/
         7u3O34HF/camWUoY0pChUAgTJo/1xvLstfL+zsEchoB/cJKJ2ivaLo+3bC+NkW7kyBgj
         BxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NXYriN68WEaDGO+51HtETWH0OR2nXCbI78x/3AkLtc4=;
        b=Ocl4Az+LCUhaclg/uE8Yex8j6liNyoG1f70GrPt/oGM7GDAsUl4FeXQMAH3/N/GMIT
         5pBRaYr3pshqdqU+zVGgjxdEoB28WwEuESddTMfAII03DcMlk33KMik+NX7iLdPoHl/v
         7sE2aOeQaIzicSpJCcPg4r2kKcYoUD1yU1sI718CkRq9UOYPviTwnHG78Ak49k9Doehp
         vbM4qaFVlDgK/3EovfaP9lljSkh1jTCJsPNDpvwbSAjikY3L374fIIqfeXYC5xBe3KUl
         lfYGBdV8gdlwH8zM9FI2jmckKxFPEtvrYmZM2VeL5kA87lwYIHesnJp98s10EcisM+xg
         4HYg==
X-Gm-Message-State: AOAM530JnyCL7CQw2+hxL4mUKcO410F7Gvlul+GtBozEPRIVtDcfTELu
        tIXQse9lFXLJPAS/cIaF96vAM07NTu4j1zeG
X-Google-Smtp-Source: ABdhPJzhFnzN1y1fvnO3NvUtwd+9nh9SLc0OQH3Yk7tNyyGuJqKmyeYWkk0h5wdg8+6g7Lq36YLDhA==
X-Received: by 2002:ad4:5dec:0:b0:441:5ffb:450e with SMTP id jn12-20020ad45dec000000b004415ffb450emr5698869qvb.28.1649800485403;
        Tue, 12 Apr 2022 14:54:45 -0700 (PDT)
Received: from localhost.localdomain (cpe-104-162-105-43.nyc.res.rr.com. [104.162.105.43])
        by smtp.gmail.com with ESMTPSA id r7-20020ac85c87000000b002e234014a1fsm28781674qta.81.2022.04.12.14.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 14:54:44 -0700 (PDT)
From:   grantseltzer <grantseltzer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, grantseltzer@gmail.com
Subject: [PATCH bpf-next] Add documentation to API functions
Date:   Tue, 12 Apr 2022 17:54:31 -0400
Message-Id: <20220412215431.271150-1-grantseltzer@gmail.com>
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

