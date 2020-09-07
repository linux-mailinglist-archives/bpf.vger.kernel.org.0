Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D9525FFF8
	for <lists+bpf@lfdr.de>; Mon,  7 Sep 2020 18:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730949AbgIGQmO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Sep 2020 12:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730948AbgIGQiJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Sep 2020 12:38:09 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9768DC061755
        for <bpf@vger.kernel.org>; Mon,  7 Sep 2020 09:38:08 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l9so14750914wme.3
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2020 09:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BJoEBQbVWXYlOqLU5cbV6bt1TTlsLV/Qtq4ImP8ofAU=;
        b=RAobz4z02AZSvKr0A+KyMeHCsFsF0y3s/+mTsvhDfALo01MBcgevnctS8DDfNb4r7Z
         FjG+pMGmyXkinfpj23I9Kw8Pg9FUkLHJMWxqpy+g8GCWfqMBDiAy2XbY/wlbLn9QeyVL
         7EzFbvk/hgeQAzsg/qOz7YUxGAjf7syShJQxxt7Mn7KATuFj9BBUbdYuYKUBXXtDZVYi
         1aAeF66YUCChpWFbIItPqaR8eg66It8/7cmGaCH++71D0QFJHJKddSOTGoKBv4/xzbmJ
         SBPPJ0jdaVNpIsgI4lWR1Lw+1kYnQxO6es6jmIzDpGVnOnJqL76sVxPiiv8KdzfJgVe/
         A71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BJoEBQbVWXYlOqLU5cbV6bt1TTlsLV/Qtq4ImP8ofAU=;
        b=Nm8jpBh3ru6MTJWa+GXAxfNIsBBREU9bWHB8PtiazAERIUve4CwJVFtXAzjPpOOeKu
         Fz/YOCLQdlrI09DBpOar0Yzo+ZFIwgEZxFUw/G4Kv+OLuTVShaZDz3a9rL1o3eywuapr
         3zhd8GubhK8yNtwv3EOtHw3ckzgJl4u+uN7TUvcq+O0qb9UPPLr8Asyq0S8b+W/WLbU9
         qzRGqeNB8U0N9/l3F5u+NnURcy+Xa7ZGoiPFc7PBIAiNC8LH+EQjMI4dSx1OJxtnwl9R
         Mpl2dfbKe+GJlxLEezpVJ0u+weFX9JKWkBk8i8RkhyZyv0m/ZEChsdPWNOlWyQ38A+3Q
         Jbzw==
X-Gm-Message-State: AOAM531YQYm5VWuXsAeRm25EuN5fZHDhohO7Q0sK5mTF3U6pHJ8uV/dr
        PMZkmJP2S4DtMC97zqcrY/XbVw==
X-Google-Smtp-Source: ABdhPJzoXXU77iPYv/YRcJAPo8T9EnX20DwTM7hmEOsDLSTu+6z1evY4R9WjA8MgfCTyhMLeafytTw==
X-Received: by 2002:a7b:c1c3:: with SMTP id a3mr206999wmj.68.1599496687323;
        Mon, 07 Sep 2020 09:38:07 -0700 (PDT)
Received: from localhost.localdomain ([194.35.119.17])
        by smtp.gmail.com with ESMTPSA id g12sm26546580wro.89.2020.09.07.09.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 09:38:06 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v2 1/3] tools: bpftool: print optional built-in features along with version
Date:   Mon,  7 Sep 2020 17:38:02 +0100
Message-Id: <20200907163804.29244-2-quentin@isovalent.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200907163804.29244-1-quentin@isovalent.com>
References: <20200907163804.29244-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bpftool has a number of features that can be included or left aside
during compilation. This includes:

- Support for libbfd, providing the disassembler for JIT-compiled
  programs.
- Support for BPF skeletons, used for profiling programs or iterating on
  the PIDs of processes associated with BPF objects.

In order to make it easy for users to understand what features were
compiled for a given bpftool binary, print the status of the two
features above when showing the version number for bpftool ("bpftool -V"
or "bpftool version"). Document this in the main manual page. Example
invocation:

    $ bpftool -p version
    {
        "version": "5.9.0-rc1",
        "features": {
            "libbfd": true,
            "skeletons": true
        }
    }

Some other parameters are optional at compilation
("DISASM_FOUR_ARGS_SIGNATURE", LIBCAP support) but they do not impact
significantly bpftool's behaviour from a user's point of view, so their
status is not reported.

Available commands and supported program types depend on the version
number, and are therefore not reported either. Note that they are
already available, albeit without JSON, via bpftool's help messages.

v2:
- Fix JSON (object instead or array for the features).

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/Documentation/bpftool.rst |  8 ++++++-
 tools/bpf/bpftool/main.c                    | 26 +++++++++++++++++++--
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool.rst b/tools/bpf/bpftool/Documentation/bpftool.rst
index 420d4d5df8b6..a3629a3f1175 100644
--- a/tools/bpf/bpftool/Documentation/bpftool.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool.rst
@@ -50,7 +50,13 @@ OPTIONS
 		  Print short help message (similar to **bpftool help**).
 
 	-V, --version
-		  Print version number (similar to **bpftool version**).
+		  Print version number (similar to **bpftool version**), and
+		  optional features that were included when bpftool was
+		  compiled. Optional features include linking against libbfd to
+		  provide the disassembler for JIT-ted programs (**bpftool prog
+		  dump jited**) and usage of BPF skeletons (some features like
+		  **bpftool prog profile** or showing pids associated to BPF
+		  objects may rely on it).
 
 	-j, --json
 		  Generate JSON output. For commands that cannot produce JSON, this
diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 4a191fcbeb82..a47bf5f7562a 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -70,13 +70,35 @@ static int do_help(int argc, char **argv)
 
 static int do_version(int argc, char **argv)
 {
+#ifdef HAVE_LIBBFD_SUPPORT
+	const bool has_libbfd = true;
+#else
+	const bool has_libbfd = false;
+#endif
+#ifdef BPFTOOL_WITHOUT_SKELETONS
+	const bool has_skeletons = false;
+#else
+	const bool has_skeletons = true;
+#endif
+
 	if (json_output) {
-		jsonw_start_object(json_wtr);
+		jsonw_start_object(json_wtr);	/* root object */
+
 		jsonw_name(json_wtr, "version");
 		jsonw_printf(json_wtr, "\"%s\"", BPFTOOL_VERSION);
-		jsonw_end_object(json_wtr);
+
+		jsonw_name(json_wtr, "features");
+		jsonw_start_object(json_wtr);	/* features */
+		jsonw_bool_field(json_wtr, "libbfd", has_libbfd);
+		jsonw_bool_field(json_wtr, "skeletons", has_skeletons);
+		jsonw_end_object(json_wtr);	/* features */
+
+		jsonw_end_object(json_wtr);	/* root object */
 	} else {
 		printf("%s v%s\n", bin_name, BPFTOOL_VERSION);
+		printf("features: libbfd=%s, skeletons=%s\n",
+		       has_libbfd ? "true" : "false",
+		       has_skeletons ? "true" : "false");
 	}
 	return 0;
 }
-- 
2.25.1

