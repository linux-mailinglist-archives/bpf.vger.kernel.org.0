Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1DA01838F5
	for <lists+bpf@lfdr.de>; Thu, 12 Mar 2020 19:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgCLSq1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Mar 2020 14:46:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40256 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgCLSq1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Mar 2020 14:46:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id e26so7535893wme.5
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2020 11:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2T2eHblusz//rStInGejsiCGwQd+1CQQkRqGDLdL4OQ=;
        b=wM46Yby04IPTvWcG/O3nHmvup5lFISadeM42/O8LGrG+5dbPKh9cjArpKIG19i165z
         0r0gUCgtPid0YQhqGAZ7/T5q3Ds6EwuqJqj65OPQQW0ivhdD0mzfZ6XdH05dX+nm1pas
         CQ+Fe7SlVF+5C13c3g9dWj3nWpgnRtI9Lu9KS+u41Zd5ck8jzsuu/bQDrKeWY+eYSpL9
         XyjFmr8ekHAaLUP44vxlerEoo65tqGiHMBzdrd38rk3j4mx0Ouap646Z+x1sXLM9VZw4
         lWP6EpjONXZgwkCHfRZgX9q2uvNAVF0kJE3pUEbmVKSRYudLYiIEXI/UXyQ6jJAjVEjB
         X4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2T2eHblusz//rStInGejsiCGwQd+1CQQkRqGDLdL4OQ=;
        b=qkri9KBPyAlaoZEwYse/LwgBXkv/FQ+Xul0Xi29VBFV7KhTHSTLykZGk1OXfwZpnQE
         5TpqKch9jEgulLZvfINNrg6a+wRGW9bs7RyfuH7hhGKltyDZ8p9+2cePXyV3w4XPP/6y
         FpomIyODFfajT5Eb/kvFg8nShOXIePgFaOA/hfgKKm/S2zGS9WrfwyVRjCzfDrNAi0N1
         VyOLyx2g4kgLdKrfi0ZomlVMpIutpuSb48cY0w9BDS2lF7AeVV7WIq6g/uxnuDguFDX5
         HH1vMZ7bMXQ0VdujD+ocmpX6qu3vyz17XEcbJCeagQhj0VyBxB+SMbBYOoQcSk1xtL35
         yIHg==
X-Gm-Message-State: ANhLgQ2ZrBYs1cPIJduxbvnWYVwKvYPLVwjDU7ZnKnutPWBF17YIMwXx
        /RNVwlpXfZm3nyMf54hxy7dbUg==
X-Google-Smtp-Source: ADFU+vt5R/ZFULZXYbV/obOPvrJsGl62bN88BKQEF4PSO5hFXIR+6pcr2SDvC6s/fAk0kARrfoB1cQ==
X-Received: by 2002:a7b:c414:: with SMTP id k20mr6094149wmi.119.1584038784968;
        Thu, 12 Mar 2020 11:46:24 -0700 (PDT)
Received: from localhost.localdomain ([194.35.118.177])
        by smtp.gmail.com with ESMTPSA id b12sm50019665wro.66.2020.03.12.11.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 11:46:24 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v2 1/2] tools: bpftool: allow all prog/map handles for pinning objects
Date:   Thu, 12 Mar 2020 18:46:07 +0000
Message-Id: <20200312184608.12050-2-quentin@isovalent.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312184608.12050-1-quentin@isovalent.com>
References: <20200312184608.12050-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Documentation and interactive help for bpftool have always explained
that the regular handles for programs (id|name|tag|pinned) and maps
(id|name|pinned) can be passed to the utility when attempting to pin
objects (bpftool prog pin PROG / bpftool map pin MAP).

THIS IS A LIE!! The tool actually accepts only ids, as the parsing is
done in do_pin_any() in common.c instead of reusing the parsing
functions that have long been generic for program and map handles.

Instead of fixing the doc, fix the code. It is trivial to reuse the
generic parsing, and to simplify do_pin_any() in the process.

Do not accept to pin multiple objects at the same time with
prog_parse_fds() or map_parse_fds() (this would require a more complex
syntax for passing multiple sysfs paths and validating that they
correspond to the number of e.g. programs we find for a given name or
tag).

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/common.c | 33 ++++-----------------------------
 tools/bpf/bpftool/main.h   |  2 +-
 tools/bpf/bpftool/map.c    |  2 +-
 tools/bpf/bpftool/prog.c   |  2 +-
 4 files changed, 7 insertions(+), 32 deletions(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index b75b8ec5469c..ad634516ba80 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -211,39 +211,14 @@ int do_pin_fd(int fd, const char *name)
 	return err;
 }
 
-int do_pin_any(int argc, char **argv, int (*get_fd_by_id)(__u32))
+int do_pin_any(int argc, char **argv, int (*get_fd)(int *, char ***))
 {
-	unsigned int id;
-	char *endptr;
 	int err;
 	int fd;
 
-	if (argc < 3) {
-		p_err("too few arguments, id ID and FILE path is required");
-		return -1;
-	} else if (argc > 3) {
-		p_err("too many arguments");
-		return -1;
-	}
-
-	if (!is_prefix(*argv, "id")) {
-		p_err("expected 'id' got %s", *argv);
-		return -1;
-	}
-	NEXT_ARG();
-
-	id = strtoul(*argv, &endptr, 0);
-	if (*endptr) {
-		p_err("can't parse %s as ID", *argv);
-		return -1;
-	}
-	NEXT_ARG();
-
-	fd = get_fd_by_id(id);
-	if (fd < 0) {
-		p_err("can't open object by id (%u): %s", id, strerror(errno));
-		return -1;
-	}
+	fd = get_fd(&argc, &argv);
+	if (fd < 0)
+		return fd;
 
 	err = do_pin_fd(fd, *argv);
 
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 724ef9d941d3..d57972dd0f2b 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -146,7 +146,7 @@ char *get_fdinfo(int fd, const char *key);
 int open_obj_pinned(char *path, bool quiet);
 int open_obj_pinned_any(char *path, enum bpf_obj_type exp_type);
 int mount_bpffs_for_pin(const char *name);
-int do_pin_any(int argc, char **argv, int (*get_fd_by_id)(__u32));
+int do_pin_any(int argc, char **argv, int (*get_fd_by_id)(int *, char ***));
 int do_pin_fd(int fd, const char *name);
 
 int do_prog(int argc, char **arg);
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index e6c85680b34d..693a632f6813 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1384,7 +1384,7 @@ static int do_pin(int argc, char **argv)
 {
 	int err;
 
-	err = do_pin_any(argc, argv, bpf_map_get_fd_by_id);
+	err = do_pin_any(argc, argv, map_parse_fd);
 	if (!err && json_output)
 		jsonw_null(json_wtr);
 	return err;
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 576ddd82bc96..6e3d69f06b60 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -813,7 +813,7 @@ static int do_pin(int argc, char **argv)
 {
 	int err;
 
-	err = do_pin_any(argc, argv, bpf_prog_get_fd_by_id);
+	err = do_pin_any(argc, argv, prog_parse_fd);
 	if (!err && json_output)
 		jsonw_null(json_wtr);
 	return err;
-- 
2.20.1

