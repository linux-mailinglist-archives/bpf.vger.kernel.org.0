Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01FEADFD4
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2019 11:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfD2Jwq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Apr 2019 05:52:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54721 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbfD2Jwp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Apr 2019 05:52:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id b10so500358wmj.4
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2019 02:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eUEvq1ZZP5fAahJx3cvB+6G7/DCNm265wzSKCNJscfc=;
        b=OlPzI37wp5Q8kwqaYmuSWrTMVDmWNqOZcIGD5lEDtKoMm+dn44RGYcaOdz+n0OFzqA
         htOQuaJkTsvIJleuoJ9lA63jBJUYNLJTtdYhvkjDQVskjINfuzlpIroJaxPr+IVs/FbM
         1RAN4omqKALTA3n9YSoG0YzrrX6yxVsYZthRmWgaVrAUy0QeQ+v7OlhcWCfR4CnsZHW0
         xI76ZLzadwTzlvzPi09n+TBqc0N065TJis34KpBCvpCq8suokDZDrh4dpom2d8p9nwzD
         upPFIGg8HYkLAXb/7xAgDL7QfdysVRCA+MAWkOhUk1TZVfKqMjJD/dVjY4gE0exacuwt
         2Rkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eUEvq1ZZP5fAahJx3cvB+6G7/DCNm265wzSKCNJscfc=;
        b=YdAS2k+NqXKTR8c05zcbuYVyzQCOSF4jmtWBIaL+RMxBgQXQWkDQQY7ZigBcjVO3Wj
         7S3Alvao03d6A6Fxg4HVJg6ohj0zZK0DS+eL+DQN0oxT5hvLyRnAwO8VByHLAPlAk5AX
         5d4KZfKpo+MWdNuu+IorQKoO5o5rqlsi3sRuywU5Owqzf9R5p76vAfYYgeMR9emeL34X
         wPJ7/UhxI/Llr/yPuwwQAxARsRqINRoopzBMDV3QNTxU+iqcAJ84CRaUcsPyCWoQCJW0
         4kYL1AtVD8daqcnrB0G864qJysWs/+lfxO9K8zds6m9/n37J5/I5wS/30rVp6KD0443/
         ikew==
X-Gm-Message-State: APjAAAXVsi36958oph44UcvAqgcOw7dmBACj4h8fgLsTsC1HKKnTFn5W
        fEPYt62oKZQ/2bGjLEIX7b9aMg==
X-Google-Smtp-Source: APXvYqwjyPaHA773c2VUFVGYPa5REgr1zOLKI+SnkrCi5OvNSeKthl4bSSsD31mS1wQGNzj6T1mR1w==
X-Received: by 2002:a1c:d7:: with SMTP id 206mr17976344wma.69.1556531563666;
        Mon, 29 Apr 2019 02:52:43 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id x20sm11241535wrg.29.2019.04.29.02.52.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 02:52:42 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf-next 2/6] tools: bpftool: add --log-all option to print all possible log info
Date:   Mon, 29 Apr 2019 10:52:23 +0100
Message-Id: <20190429095227.9745-3-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190429095227.9745-1-quentin.monnet@netronome.com>
References: <20190429095227.9745-1-quentin.monnet@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The --log-all option is a shortcut for "--log-libbpf warn,info,debug".
It tells bpftool to print all possible logs from libbpf, and may be
extended in the future to set other log levels from other components as
well.

This option has a short name: "-l".

Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 tools/bpf/bpftool/Documentation/bpftool-prog.rst | 4 ++++
 tools/bpf/bpftool/bash-completion/bpftool        | 3 ++-
 tools/bpf/bpftool/main.c                         | 7 ++++++-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index 77d9570488d1..0525275f79f1 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -180,6 +180,10 @@ OPTIONS
 		  levels of information to print, which can be **warn**,
 		  **info** or **debug**. The default is **warn,info**.
 
+	-l, --log-all
+		  Print all possible log information. This is a shortcut for
+		  **--log-libbpf warn,info,debug**.
+
 EXAMPLES
 ========
 **# bpftool prog show**
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index a232da1b158d..f4ad75c6b243 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -209,7 +209,8 @@ _bpftool()
 
     # Deal with options
     if [[ ${words[cword]} == -* ]]; then
-        local c='--version --json --pretty --bpffs --mapcompat --log-libbpf'
+        local c='--version --json --pretty --bpffs --mapcompat \
+            --log-libbpf --log-all'
         COMPREPLY=( $( compgen -W "$c" -- "$cur" ) )
         return 0
     fi
diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 6318be6feb5c..417cff76c7a1 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -360,6 +360,7 @@ int main(int argc, char **argv)
 		{ "mapcompat",	no_argument,		NULL,	'm' },
 		{ "nomount",	no_argument,		NULL,	'n' },
 		{ "log-libbpf",	required_argument,	NULL,	'd' },
+		{ "log-all",	no_argument,		NULL,	'l' },
 		{ 0 }
 	};
 	int opt, ret;
@@ -375,7 +376,7 @@ int main(int argc, char **argv)
 	hash_init(map_table.table);
 
 	opterr = 0;
-	while ((opt = getopt_long(argc, argv, "Vhpjfmn",
+	while ((opt = getopt_long(argc, argv, "Vhpjfmnl",
 				  options, NULL)) >= 0) {
 		switch (opt) {
 		case 'V':
@@ -409,6 +410,10 @@ int main(int argc, char **argv)
 			if (set_libbpf_loglevel(optarg))
 				return -1;
 			break;
+		case 'l':
+			if (set_libbpf_loglevel("warn,info,debug"))
+				return -1;
+			break;
 		default:
 			p_err("unrecognized option '%s'", argv[optind - 1]);
 			if (json_output)
-- 
2.17.1

