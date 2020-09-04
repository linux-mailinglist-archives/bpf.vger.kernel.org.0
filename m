Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CFA25E31E
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 22:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgIDU5T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 16:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgIDU5N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 16:57:13 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBFCC061245
        for <bpf@vger.kernel.org>; Fri,  4 Sep 2020 13:57:13 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id s13so7806925wmh.4
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2020 13:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eWakah6Nz94r7VC8i4SYX31lbCXE472GZVFRmRPPkhA=;
        b=BebxWY6G3h9RvBbaOmuR6WE5ErNOp+33b+0E1W87Zkyl2C8t19VPeG9FmT6ts7OEKF
         4uiVHLglY+g6pfsfYYwt+RU8H9zg0Yq4SiZFRu6mL65uDpL7rPOa5VPItKFU9YKYkWV4
         YGP8rKUeVtjZy86lsX73NfLz68AXy251+m8qX5M++PP76ZdoifdDA/emUpUEXzMHQCNs
         vfNU5tRdraLDu2FFKsMd55YDMKrahZXdC8R2dcs8rO1eHduDtdSm+DCO18nhXzm7rIrT
         0ewXiKDEwdn3MzycfSTwfc19NwOy731NkAxOQDoeFvZRekR4lBdW6vsCtnBCuJGnGiXp
         LQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eWakah6Nz94r7VC8i4SYX31lbCXE472GZVFRmRPPkhA=;
        b=Zu4lzJ99F2zhOYnMtizYYwEWtPa5fWub+9AfEmxymWlMKNinSFbUjoP4kqbgQWRXoC
         msksvjsj79PHGmB+EsUqds6GUrGxhBCj0aztRN5HRFOzd04WWNlYz/E31c7ryebzTpML
         91DM9GF+ki3JOrfab4sQqQi6UIXQljXbXpZSbHH6xio5wWUgD5TPTCdcERGMjdJLR9S8
         E4knLC/cpPbPXDVbpXHfPhfvSDM4Oh5d5thpnP4UPqjCxCf0Pv8fZY34x/KI14bWg/eY
         Xqecc+Pz7SnyYw957sGqkYVV3PxJ9u6scRdi0XyjdLwgGMrgCxZ7omWabT4Uqn79GUR/
         H6Pw==
X-Gm-Message-State: AOAM533YCtfaE8Q0G9/l4Z+enat7G6KVIoI+1zh5KHDTir4ltJPzCpxq
        L5VhCgZf6xJFmbxW+rnHnA40jqllIxOO5F+6
X-Google-Smtp-Source: ABdhPJy+omOqMJuEYxswQ9Wd8hXV8QXLgWnyx0gLWi6QRi4Jt/jtFE2pVDtyPtmzBqckNinJu0kfEw==
X-Received: by 2002:a1c:7714:: with SMTP id t20mr9163849wmi.186.1599253031838;
        Fri, 04 Sep 2020 13:57:11 -0700 (PDT)
Received: from localhost.localdomain ([194.35.117.177])
        by smtp.gmail.com with ESMTPSA id u17sm12985395wmm.4.2020.09.04.13.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 13:57:11 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 1/3] tools: bpftool: print optional built-in features along with version
Date:   Fri,  4 Sep 2020 21:56:55 +0100
Message-Id: <20200904205657.27922-2-quentin@isovalent.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200904205657.27922-1-quentin@isovalent.com>
References: <20200904205657.27922-1-quentin@isovalent.com>
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
        "features": [
            "libbfd": true,
            "skeletons": true
        ]
    }

Some other parameters are optional at compilation
("DISASM_FOUR_ARGS_SIGNATURE", LIBCAP support) but they do not impact
significantly bpftool's behaviour from a user's point of view, so their
status is not reported.

Available commands and supported program types depend on the version
number, and are therefore not reported either. Note that they are
already available, albeit without JSON, via bpftool's help messages.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/Documentation/bpftool.rst |  8 +++++++-
 tools/bpf/bpftool/main.c                    | 22 +++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

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
index 4a191fcbeb82..2ae8c0d82030 100644
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
 		jsonw_start_object(json_wtr);
+
 		jsonw_name(json_wtr, "version");
 		jsonw_printf(json_wtr, "\"%s\"", BPFTOOL_VERSION);
+
+		jsonw_name(json_wtr, "features");
+		jsonw_start_array(json_wtr);
+		jsonw_bool_field(json_wtr, "libbfd", has_libbfd);
+		jsonw_bool_field(json_wtr, "skeletons", has_skeletons);
+		jsonw_end_array(json_wtr);
+
 		jsonw_end_object(json_wtr);
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

