Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBED57A756
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 21:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239545AbiGSTkg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 15:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239183AbiGSTkg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 15:40:36 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432B51A04B;
        Tue, 19 Jul 2022 12:40:35 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o18so1563866pjs.2;
        Tue, 19 Jul 2022 12:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3j8jhweYwfAvlYpAUSAk3G7ksfaZwinAbU12iCmSRoo=;
        b=eSl7srVvYwHrA26gkTgWwAe21ZF48gtN0pXC7oKy9US4TqxIetn+6BnA/4S+4i9wb2
         FUUDg3IidPrMGJGCLDZXUeexfID3VCKmP045N5wbKUOpga5InctORVfZE9iHRfH8oFQP
         u1RlEVtNkCR6r8QLTlcSscDWC0T/WPmWSkPUkITjB70wIzbncitCQDiNgiC2UA5R/ZMp
         yKN+rAQxJggJLaiXBRpgdDDQEf5TNtsoiyfmUgunGfEWnucEtDzbt1Fqq4PjTisCtA+o
         znSUxPSKz75z7hmjp5vu44DOZW0Ngq8LQ1dLP+DVBcYwIJfPbxGG0WR1xUzuvLIVsMaA
         qVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3j8jhweYwfAvlYpAUSAk3G7ksfaZwinAbU12iCmSRoo=;
        b=UNZ+g+IRG7RlH997Z4ii1qOxYI1KuRpctHPitmeTJIDxP4pUwHN7IFBTVu8w1C2czw
         npvK+3S4gd+lh7xJLok1JZvQtqlW/hSAb+cpP6CWcy3N7YfZwjeuubVfhr66rWc7SyX6
         r5CeFwLpVfRjiFoWbYOOPvDeXxpv3B9XyKyUTI3Yw3wXPClXzLrBKabc+I04R5o61Yhj
         DVZ8NQ43pCQM3tT8SgWfH7CgWpZvGmBjVarLomSGHBaFYOcUjMgKIEqdi9DMpTarcm3V
         a6+j0Yhub5KbLQK+TRxngpJWOx0RU7Szj5MaTiBrNQXj8mH5Os4TUUgb+NtyfPRxBQIt
         4RfQ==
X-Gm-Message-State: AJIora/3/UEMiBtJTWiiOzWu+3U4eD4JHkoWl+f3XozTiSlM2R4/F/6p
        kIhj1uHnoQBbeCTN3gF6Gg==
X-Google-Smtp-Source: AGRyM1sNje6ORtgN0esEbjm0cCFzNF6SkYBH/IuZkqpozem8axBtnrPD4HiT9dYlqetFUJl0xu0amw==
X-Received: by 2002:a17:90b:4ad0:b0:1f0:28c6:9493 with SMTP id mh16-20020a17090b4ad000b001f028c69493mr1041519pjb.142.1658259634604;
        Tue, 19 Jul 2022 12:40:34 -0700 (PDT)
Received: from jevburton3.c.googlers.com.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id f80-20020a623853000000b00528d620eb58sm12192927pfa.17.2022.07.19.12.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 12:40:33 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next] libbpf: Add bpf_obj_get_opts()
Date:   Tue, 19 Jul 2022 19:40:28 +0000
Message-Id: <20220719194028.4180569-1-jevburton.kernel@gmail.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
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
 tools/lib/bpf/bpf.c      | 10 ++++++++++
 tools/lib/bpf/bpf.h      |  9 +++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 20 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 5eb0df90eb2b..5acb0e8bd13c 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -578,12 +578,22 @@ int bpf_obj_pin(int fd, const char *pathname)
 }
 
 int bpf_obj_get(const char *pathname)
+{
+	LIBBPF_OPTS(bpf_obj_get_opts, opts);
+	return bpf_obj_get_opts(pathname, &opts);
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
index 88a7cc4bd76f..f31b493b5f9a 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -270,8 +270,17 @@ LIBBPF_API int bpf_map_update_batch(int fd, const void *keys, const void *values
 				    __u32 *count,
 				    const struct bpf_map_batch_opts *opts);
 
+struct bpf_obj_get_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+
+	__u32 file_flags;
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
2.37.0.170.g444d1eabd0-goog

