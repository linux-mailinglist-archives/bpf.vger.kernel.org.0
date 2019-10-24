Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43ED6E33D4
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2019 15:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733289AbfJXNVY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Oct 2019 09:21:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47298 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732060AbfJXNVY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Oct 2019 09:21:24 -0400
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2E818112D81
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2019 13:21:24 +0000 (UTC)
Received: by mail-lj1-f198.google.com with SMTP id e3so3995740ljj.16
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2019 06:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GuoLFI180GdL56vV8nO50qFTF6fdq6eDG+c2BybpcyU=;
        b=EmoI97jG2xvJVbbh+/jDz/uPEPX88DZjDi/vxuNquKHLZ+Rp8oYqOeGY2wdA84OrZA
         SDSIQEsdIj3U0TMySWyl+fAA7ZbLrpfz/zZB8ay3agmSegRWWUorvA9LpmF1LhUHXdpL
         Thq9XQi7vlzGBMRyFQmd71S6tuL8Rf/+9PU5S/Q2/Qvu4k/pVo4p9x1ItULm2VF3wBTd
         vjDDuMPeW/a0PdBdIeOK9/JyLo1Rsd8+mg4mrgSteC8Tjsp9SsDBHVFeFQfswPBBXIrc
         8+9atnXbWD66tKY+Kxn+aXln2Db/9HvulUdHFeivJsZCKGSKF+mUYbOf/Num2gif/Jp4
         w1Ew==
X-Gm-Message-State: APjAAAV96/8Y8IXeWhaXDbuK+brp7dd6pnfL/fhxcywl+WpibYBSbK59
        yWGN/GdiAKBpIeekD2TeGj/9T87ME75/FQaJBBNH3ewaQC0dGb4QxjJz6poHTHpB92qNPmlYSk5
        Yc6Is1xUxQPBx
X-Received: by 2002:a2e:6c15:: with SMTP id h21mr1339855ljc.10.1571923282360;
        Thu, 24 Oct 2019 06:21:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzTkbKGPfYCEvo/cXPu1tP1v+SxyEJBzuGQZ2v+4MNmHQpt+R5XWVeBbQeSwjMdSlLAmFC2MA==
X-Received: by 2002:a2e:6c15:: with SMTP id h21mr1339816ljc.10.1571923281703;
        Thu, 24 Oct 2019 06:21:21 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id b19sm10948284lji.41.2019.10.24.06.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 06:21:21 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 226091804B1; Thu, 24 Oct 2019 15:21:20 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     daniel@iogearbox.net, ast@fb.com
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH bpf-next] libbpf: Add libbpf_set_log_level() function to adjust logging
Date:   Thu, 24 Oct 2019 15:21:07 +0200
Message-Id: <20191024132107.237336-1-toke@redhat.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, the only way to change the logging output of libbpf is to
override the print function with libbpf_set_print(). This is somewhat
cumbersome if one just wants to change the logging level (e.g., to enable
debugging), so add another function that just adjusts the default output
printing by adjusting the filtering of messages.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf.c   | 12 +++++++++++-
 tools/lib/bpf/libbpf.h   |  2 ++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d1c4440a678e..93909d9a423d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -67,10 +67,12 @@
 
 #define __printf(a, b)	__attribute__((format(printf, a, b)))
 
+static enum libbpf_print_level __libbpf_log_level = LIBBPF_INFO;
+
 static int __base_pr(enum libbpf_print_level level, const char *format,
 		     va_list args)
 {
-	if (level == LIBBPF_DEBUG)
+	if (level > __libbpf_log_level)
 		return 0;
 
 	return vfprintf(stderr, format, args);
@@ -86,6 +88,14 @@ libbpf_print_fn_t libbpf_set_print(libbpf_print_fn_t fn)
 	return old_print_fn;
 }
 
+enum libbpf_print_level libbpf_set_log_level(enum libbpf_print_level level)
+{
+	enum libbpf_print_level old_level = __libbpf_log_level;
+
+	__libbpf_log_level = level;
+	return old_level;
+}
+
 __printf(2, 3)
 void libbpf_print(enum libbpf_print_level level, const char *format, ...)
 {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index c63e2ff84abc..0bba6c2259f1 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -58,6 +58,8 @@ typedef int (*libbpf_print_fn_t)(enum libbpf_print_level level,
 				 const char *, va_list ap);
 
 LIBBPF_API libbpf_print_fn_t libbpf_set_print(libbpf_print_fn_t fn);
+LIBBPF_API enum libbpf_print_level
+libbpf_set_log_level(enum libbpf_print_level level);
 
 /* Hide internal to user */
 struct bpf_object;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index d1473ea4d7a5..c3f79418c2be 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -197,4 +197,5 @@ LIBBPF_0.0.6 {
 		bpf_object__open_mem;
 		bpf_program__get_expected_attach_type;
 		bpf_program__get_type;
+		libbpf_set_log_level;
 } LIBBPF_0.0.5;
-- 
2.23.0

