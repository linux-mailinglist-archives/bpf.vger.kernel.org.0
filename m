Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2D76D10D5
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 23:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjC3V1P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 17:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjC3V1N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 17:27:13 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10219EF3;
        Thu, 30 Mar 2023 14:27:11 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id c29so26313299lfv.3;
        Thu, 30 Mar 2023 14:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680211630; x=1682803630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aIedYYpon/ynoMObOBHo5C0y/vKynxTAC+6+n/9ySI0=;
        b=COpevuwdHtP5pBYirKf/aAO6VJpMnibHKINpLt29KrdBFQCuOtreJmC/NAzuTABHag
         BTGgnWkN443VzkdoEFPsicllqe2paYSwzDeNZGDshnI1TGQJ0gg+UypPTItyX0UQ6lKy
         yCmwRzOh+XasGkppjJzKFVKEhfOXIhKxp3zMjdeXVLt39FGe+MK4DZ1LSXbIm7waz5Mr
         vodHZyFNZEvaCNB/Z38YYwZvkkTQVuySyIXahoS1mj+UGw5HxsbtU/xLiLibhpgvjdCl
         UxpFQG+WS5xpefKbOTz4ORZLSKp4xa311a+J4J68S4C+rpx1fukO1/1U1/q0YrtaveYZ
         glUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680211630; x=1682803630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aIedYYpon/ynoMObOBHo5C0y/vKynxTAC+6+n/9ySI0=;
        b=UAuqMamrIhTAT3FSCYxbcxQY2Q46L+Ms0v8Vs1iKSealNesnwnO/KSExeX5fPx+tdM
         L2Pv80KMyXvRwGYvF2iEgz1coonZhzcPOu2fHB48gQIqjpS95wYU+cSDA0NjBZV4fSeR
         29DQBpsYD0WEdQ9ufF/Y8U+LpbiOXrdM5MAE72UGlA5uUmQqiOSXTGzLN2zzKUEmcJ05
         GRskDw+W6FnbnYWNK0OCGfbEW5VyPKy3NYkEM/vlaIB1eIXvlH+w1JGYN6jdHv+9kQZ2
         6LxDs7CYtT7b9zU/JwXFmX9sS/zIFNeBOsAekKU0MfgWfK8FdJ9W2KS6mH0RKpFmE2FE
         i+Ow==
X-Gm-Message-State: AAQBX9eHWj30APOqHDY3+y3buUENJ3MgE6C/zFAyNfDlBLiSytTdU/LC
        l7dx8W0STgQWzLmwQ/9846qJVDw9SgHJ5w==
X-Google-Smtp-Source: AKy350YCI13KpYSu4BequVbwT1vi4JLJS3ZOgjDXsvkUiISITwXjpVRX+9OhCUTBkKShXN3/R9M9Pg==
X-Received: by 2002:ac2:4c95:0:b0:4e7:fa8a:886e with SMTP id d21-20020ac24c95000000b004e7fa8a886emr8096157lfl.51.1680211629493;
        Thu, 30 Mar 2023 14:27:09 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id q24-20020ac246f8000000b004db513b0175sm94684lfo.136.2023.03.30.14.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 14:27:09 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     dwarves@vger.kernel.org, arnaldo.melo@gmail.com
Cc:     bpf@vger.kernel.org, kernel-team@fb.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH dwarves] fprintf: Fix `*` not being printed for pointers with btf_type_tag
Date:   Fri, 31 Mar 2023 00:27:00 +0300
Message-Id: <20230330212700.697124-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Recent change to fprintf (see below) causes incorrect `type_fprintf()`
behavior for pointers annotated with btf_type_tag, for example:

    $ cat tag-test.c
    #define __t __attribute__((btf_type_tag("t1")))

    struct foo {
      int __t *a;
    } g;

    $ clang -g -c tag-test.c -o tag-test.o && \
      pahole -J tag-test.o && pahole --sort -F dwarf tag-test.o
    struct foo {
    	int                        a;                    /*     0     8 */
    	...
    };

Note that `*` is missing in the pahole output.
The issue is caused by `goto next_type` that jumps over the
`tag__name()` that is responsible for pointer printing.

As agreed in [1] `type__fprintf()` is modified to skip type tags for
now and would be modified to emit type tags later.

The change in `__tag__name()` is necessary to avoid the following behavior:

    $ cat tag-test.c
    #define __t __attribute__((btf_type_tag("t1")))

    struct foo {
      int __t *a;
      int __t __t *b;
    } g;

    $ clang -g -c tag-test.c -o tag-test.o && \
      pahole -J tag-test.o && pahole --sort -F dwarf tag-test.o
    struct foo {
    	int  *                     a;                    /*     0     8 */
    	int   *                    b;                    /*     8     8 */
            ...
    };

Note the extra space before `*` for field `b`.

The issue was reported and tracked down to the root cause by
Arnaldo Carvalho de Melo.

Links:
[1] https://lore.kernel.org/dwarves/20230314230417.1507266-1-eddyz87@gmail.com/T/#md82b04f66867434524beec746138951f26a3977e

Fixes: e7fb771f2649 ("fprintf: Correct names for types with btf_type_tag attribute")
Reported-by: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Link: https://lore.kernel.org/dwarves/20230314230417.1507266-1-eddyz87@gmail.com/T/#mc630bcd474ddd64c70d237edd4e0590dc048d63d
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 dwarves_fprintf.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index 1e6147a..818db2d 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -572,7 +572,6 @@ static const char *__tag__name(const struct tag *tag, const struct cu *cu,
 	case DW_TAG_restrict_type:
 	case DW_TAG_atomic_type:
 	case DW_TAG_unspecified_type:
-	case DW_TAG_LLVM_annotation:
 		type = cu__type(cu, tag->type);
 		if (type == NULL && tag->type != 0)
 			tag__id_not_found_snprintf(bf, len, tag->type);
@@ -618,6 +617,13 @@ static const char *__tag__name(const struct tag *tag, const struct cu *cu,
 	case DW_TAG_variable:
 		snprintf(bf, len, "%s", variable__name(tag__variable(tag)));
 		break;
+	case DW_TAG_LLVM_annotation:
+		type = cu__type(cu, tag->type);
+		if (type == NULL && tag->type != 0)
+			tag__id_not_found_snprintf(bf, len, tag->type);
+		else if (!tag__has_type_loop(tag, type, bf, len, NULL))
+			__tag__name(type, cu, bf, len, conf);
+		break;
 	default:
 		snprintf(bf, len, "%s%s", tag__prefix(cu, tag->tag, pconf),
 			 type__name(tag__type(tag)) ?: "");
@@ -677,6 +683,22 @@ static size_t type__fprintf_stats(struct type *type, const struct cu *cu,
 	return printed;
 }
 
+static type_id_t skip_llvm_annotations(const struct cu *cu, type_id_t id)
+{
+	struct tag *type;
+
+	for (;;) {
+		if (id == 0)
+			break;
+		type = cu__type(cu, id);
+		if (type == NULL || type->tag != DW_TAG_LLVM_annotation || type->type == id)
+			break;
+		id = type->type;
+	}
+
+	return id;
+}
+
 static size_t union__fprintf(struct type *type, const struct cu *cu,
 			     const struct conf_fprintf *conf, FILE *fp);
 
@@ -778,19 +800,17 @@ inner_struct:
 
 next_type:
 	switch (type->tag) {
-	case DW_TAG_pointer_type:
-		if (type->type != 0) {
+	case DW_TAG_pointer_type: {
+		type_id_t ptype_id = skip_llvm_annotations(cu, type->type);
+
+		if (ptype_id != 0) {
 			int n;
-			struct tag *ptype = cu__type(cu, type->type);
+			struct tag *ptype = cu__type(cu, ptype_id);
 			if (ptype == NULL)
 				goto out_type_not_found;
 			n = tag__has_type_loop(type, ptype, NULL, 0, fp);
 			if (n)
 				return printed + n;
-			if (ptype->tag == DW_TAG_LLVM_annotation) {
-				type = ptype;
-				goto next_type;
-			}
 			if (ptype->tag == DW_TAG_subroutine_type) {
 				printed += ftype__fprintf(tag__ftype(ptype),
 							  cu, name, 0, 1,
@@ -811,6 +831,7 @@ next_type:
 			}
 		}
 		/* Fall Thru */
+	}
 	default:
 print_default:
 		printed += fprintf(fp, "%-*s %s", tconf.type_spacing,
-- 
2.40.0

