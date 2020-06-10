Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265DD1F555E
	for <lists+bpf@lfdr.de>; Wed, 10 Jun 2020 15:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgFJNIJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Jun 2020 09:08:09 -0400
Received: from sym2.noone.org ([178.63.92.236]:40382 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728844AbgFJNIJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Jun 2020 09:08:09 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 49hnNR6QsPzvjcX; Wed, 10 Jun 2020 15:08:07 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org
Subject: [PATCH bpf] tools, bpftool: check return value of function codegen
Date:   Wed, 10 Jun 2020 15:08:07 +0200
Message-Id: <20200610130807.21497-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The codegen function might fail an return an error. Check its return
value in all call sites and handle it properly.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 tools/bpf/bpftool/gen.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index ecbae47e66b8..b5fa3060dce3 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -325,7 +325,7 @@ static int do_skeleton(int argc, char **argv)
 	}
 
 	get_header_guard(header_guard, obj_name);
-	codegen("\
+	err = codegen("\
 		\n\
 		/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */   \n\
 									    \n\
@@ -342,6 +342,8 @@ static int do_skeleton(int argc, char **argv)
 		",
 		obj_name, header_guard
 	);
+	if (err)
+		goto out;
 
 	if (map_cnt) {
 		printf("\tstruct {\n");
@@ -376,7 +378,7 @@ static int do_skeleton(int argc, char **argv)
 			goto out;
 	}
 
-	codegen("\
+	err = codegen("\
 		\n\
 		};							    \n\
 									    \n\
@@ -453,8 +455,10 @@ static int do_skeleton(int argc, char **argv)
 		",
 		obj_name
 	);
+	if (err)
+		goto out;
 
-	codegen("\
+	err = codegen("\
 		\n\
 									    \n\
 		static inline int					    \n\
@@ -474,7 +478,7 @@ static int do_skeleton(int argc, char **argv)
 		obj_name
 	);
 	if (map_cnt) {
-		codegen("\
+		err = codegen("\
 			\n\
 									    \n\
 				/* maps */				    \n\
@@ -486,6 +490,9 @@ static int do_skeleton(int argc, char **argv)
 			",
 			map_cnt
 		);
+		if (err)
+			goto out;
+
 		i = 0;
 		bpf_object__for_each_map(map, obj) {
 			ident = get_map_ident(map);
@@ -493,13 +500,16 @@ static int do_skeleton(int argc, char **argv)
 			if (!ident)
 				continue;
 
-			codegen("\
+			err = codegen("\
 				\n\
 									    \n\
 					s->maps[%zu].name = \"%s\";	    \n\
 					s->maps[%zu].map = &obj->maps.%s;   \n\
 				",
 				i, bpf_map__name(map), i, ident);
+			if (err)
+				goto out;
+
 			/* memory-mapped internal maps */
 			if (bpf_map__is_internal(map) &&
 			    (bpf_map__def(map)->map_flags & BPF_F_MMAPABLE)) {
@@ -510,7 +520,7 @@ static int do_skeleton(int argc, char **argv)
 		}
 	}
 	if (prog_cnt) {
-		codegen("\
+		err = codegen("\
 			\n\
 									    \n\
 				/* programs */				    \n\
@@ -522,6 +532,9 @@ static int do_skeleton(int argc, char **argv)
 			",
 			prog_cnt
 		);
+		if (err)
+			goto out;
+
 		i = 0;
 		bpf_object__for_each_program(prog, obj) {
 			codegen("\
@@ -535,13 +548,15 @@ static int do_skeleton(int argc, char **argv)
 			i++;
 		}
 	}
-	codegen("\
+	err = codegen("\
 		\n\
 									    \n\
 			s->data_sz = %d;				    \n\
 			s->data = (void *)\"\\				    \n\
 		",
 		file_sz);
+	if (err)
+		goto out;
 
 	/* embed contents of BPF object file */
 	for (i = 0, len = 0; i < file_sz; i++) {
@@ -558,7 +573,7 @@ static int do_skeleton(int argc, char **argv)
 			printf("\\x%02x", (unsigned char)obj_data[i]);
 	}
 
-	codegen("\
+	err = codegen("\
 		\n\
 		\";							    \n\
 									    \n\
@@ -571,7 +586,6 @@ static int do_skeleton(int argc, char **argv)
 		#endif /* %s */						    \n\
 		",
 		header_guard);
-	err = 0;
 out:
 	bpf_object__close(obj);
 	if (obj_data)
-- 
2.27.0

