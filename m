Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C3D1F65B9
	for <lists+bpf@lfdr.de>; Thu, 11 Jun 2020 12:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgFKKdo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Jun 2020 06:33:44 -0400
Received: from sym2.noone.org ([178.63.92.236]:36098 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbgFKKdn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Jun 2020 06:33:43 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 49jKvn1xPKzvjc1; Thu, 11 Jun 2020 12:33:41 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org
Subject: [PATCH] tools, bpftool: Exit on error in function codegen
Date:   Thu, 11 Jun 2020 12:33:41 +0200
Message-Id: <20200611103341.21532-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200610130807.21497-1-tklauser@distanz.ch>
References: <20200610130807.21497-1-tklauser@distanz.ch>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, the codegen function might fail and return an error. But its
callers continue without checking its return value. Since codegen can
fail only in the ounlikely case of the system running out of memory or
the static template being malformed, just exit(-1) directly from codegen
and make it void-returning.

Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
Replaces https://lore.kernel.org/bpf/20200610130807.21497-1-tklauser@distanz.ch/
and to be applied on top of
https://lore.kernel.org/bpf/20200610130804.21423-1-tklauser@distanz.ch/

 tools/bpf/bpftool/gen.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index ecbae47e66b8..7443879e87af 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -200,7 +200,7 @@ static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
 	return err;
 }
 
-static int codegen(const char *template, ...)
+static void codegen(const char *template, ...)
 {
 	const char *src, *end;
 	int skip_tabs = 0, n;
@@ -211,7 +211,7 @@ static int codegen(const char *template, ...)
 	n = strlen(template);
 	s = malloc(n + 1);
 	if (!s)
-		return -ENOMEM;
+		exit(-1);
 	src = template;
 	dst = s;
 
@@ -225,7 +225,7 @@ static int codegen(const char *template, ...)
 			p_err("unrecognized character at pos %td in template '%s'",
 			      src - template - 1, template);
 			free(s);
-			return -EINVAL;
+			exit(-1);
 		}
 	}
 
@@ -236,7 +236,7 @@ static int codegen(const char *template, ...)
 				p_err("not enough tabs at pos %td in template '%s'",
 				      src - template - 1, template);
 				free(s);
-				return -EINVAL;
+				exit(-1);
 			}
 		}
 		/* trim trailing whitespace */
@@ -257,7 +257,8 @@ static int codegen(const char *template, ...)
 	va_end(args);
 
 	free(s);
-	return n;
+	if (n)
+		exit(-1);
 }
 
 static int do_skeleton(int argc, char **argv)
-- 
2.27.0

