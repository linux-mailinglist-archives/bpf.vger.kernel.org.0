Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8766621DB
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 10:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjAIJnj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 04:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjAIJni (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 04:43:38 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459AE1166;
        Mon,  9 Jan 2023 01:43:37 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id c9so5674768pfj.5;
        Mon, 09 Jan 2023 01:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=001Ob8msDHYSJ4H6+BAMlx9g50lKceUKFFGpbLEZpGo=;
        b=eYDyOUaHHTHcueKILaSCYIfEciTW1pbEIlEDRLZdc9Ld42Fi2TMY/zFOiUclIOYxKE
         G3/Vdt+ep3en4CD1mF1VzlSKuo+Wh9HxpkvfD9ZxyfG2pUc4J+5QBSTBaqsv0puA5093
         Qu9WF+zTU+e/LwbJOmsbes/c0YUi3NyINImEReG2kovWz6Wvfh0NfJoHTvzal72OKPmz
         61xy1Eh8diyfbUQbVjVt0GljfAvO+xDSAPx4ODJJMHsDZZYuir01obzwfCabdj6JAyF/
         WE5/hm2vf1huqC9lEba3pNmbEHqaTcg3Xwj/ovuUgF8h08W+FGa52hgsIdz66aXOjA+L
         EozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=001Ob8msDHYSJ4H6+BAMlx9g50lKceUKFFGpbLEZpGo=;
        b=4ls3ZSJ89YHmWAiBGRBfdptqdECbkarkPa3NlYFCtG2ZZoK9v4YlSR9iShIrnrNq6I
         bG9bbKWiwnvSk4UkwK1gVR0E3sJDbc3a/3z/mmnzSbcGyUqPeu9D1BctoCxe3f0Fwi+C
         mvp+KHqRC1ox2K2QArXmboobn5qLbA0Kb+zzkua4KcgS+YtW5ms75bcvi4vw+dFPotzC
         VnoZQ0dKmfnrdHFDBnZ2KLhnIiOvR2sKKB7rUUmmqZ28DrcKXKeNXc8cQlD4NHJ+jq4g
         FMNS4xPwCl8EGa/KduPloI7Ti7ycPmA7DzNmlndKQ0WS7PgnB00oDnwgZiR4iW4omC1D
         SnDw==
X-Gm-Message-State: AFqh2kpC8eJd7vRq+/rxBhO7ARCWWJG8AEbAXcSXuta/jxGfaAljlfoY
        kU3EaIL0HQ7HIZ04ys6Ukrw=
X-Google-Smtp-Source: AMrXdXvDm89D+EhcP8RUapv3tOByyW5gaBVPaMYRnrQQnRB++bFW5P3AFGSMG+z2cmA4N6tdKEu4fQ==
X-Received: by 2002:a05:6a00:414c:b0:581:7c46:debd with SMTP id bv12-20020a056a00414c00b005817c46debdmr44941706pfb.24.1673257416708;
        Mon, 09 Jan 2023 01:43:36 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.20])
        by smtp.gmail.com with ESMTPSA id z8-20020aa79e48000000b00580849b55a2sm5629527pfq.26.2023.01.09.01.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 01:43:36 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     daniel@iogearbox.net
Cc:     ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Subject: [PATCH] libbpf: resolve kernel function name optimization for kprobe
Date:   Mon,  9 Jan 2023 17:42:47 +0800
Message-Id: <20230109094247.1464856-1-imagedong@tencent.com>
X-Mailer: git-send-email 2.39.0
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

From: Menglong Dong <imagedong@tencent.com>

The function name in kernel may be changed by the compiler. For example,
the function 'ip_rcv_core' can be compiled to 'ip_rcv_core.isra.0'.

This kind optimization can happen in any kernel function. Therefor, we
should conside this case.

If we failed to attach kprobe with a '-ENOENT', then we can lookup the
kallsyms and check if there is a similar function end with '.xxx', and
retry.

Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
 tools/lib/bpf/libbpf.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a5c67a3c93c5..fdfb1ca34ced 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10375,12 +10375,30 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 	return libbpf_err_ptr(err);
 }
 
+struct kprobe_resolve {
+	char pattern[128];
+	char name[128];
+};
+
+static int kprobe_kallsyms_cb(unsigned long long sym_addr, char sym_type,
+			      const char *sym_name, void *ctx)
+{
+	struct kprobe_resolve *res = ctx;
+
+	if (!glob_match(sym_name, res->pattern))
+		return 0;
+	strcpy(res->name, sym_name);
+	return 1;
+}
+
 static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf_link **link)
 {
 	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts);
+	struct kprobe_resolve res = {};
 	unsigned long offset = 0;
 	const char *func_name;
 	char *func;
+	int err;
 	int n;
 
 	*link = NULL;
@@ -10408,8 +10426,25 @@ static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf
 
 	opts.offset = offset;
 	*link = bpf_program__attach_kprobe_opts(prog, func, &opts);
+	err = libbpf_get_error(*link);
+
+	if (!err || err != -ENOENT)
+		goto out;
+
+	sprintf(res.pattern, "%s.*", func);
+	if (!libbpf_kallsyms_parse(kprobe_kallsyms_cb, &res))
+		goto out;
+
+	pr_warn("prog '%s': trying to create %s '%s+0x%zx' perf event instead\n",
+		prog->name, opts.retprobe ? "kretprobe" : "kprobe",
+		res.name, offset);
+
+	*link = bpf_program__attach_kprobe_opts(prog, res.name, &opts);
+	err = libbpf_get_error(*link);
+
+out:
 	free(func);
-	return libbpf_get_error(*link);
+	return err;
 }
 
 static int attach_ksyscall(const struct bpf_program *prog, long cookie, struct bpf_link **link)
-- 
2.39.0

