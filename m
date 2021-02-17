Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9CDA31D7F2
	for <lists+bpf@lfdr.de>; Wed, 17 Feb 2021 12:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbhBQLJ2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Feb 2021 06:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbhBQLI5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Feb 2021 06:08:57 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF4BC0613D6
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 03:08:17 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id l1so9864189qtv.2
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 03:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ajZkQUpdD91YaKxYZS+6hb11vUCM5tx8VfmWTzbq5CE=;
        b=tPeKGEJsRm7bag5ChoB4+RYn4gD3GJjqyfimARLITA5CzqOfCuAQ1uSrwW9cWm9JyQ
         KTLMAIamnPujMoVKCoD9UoCkdnUV0wJY5Ujdx+XejD65wKFo86/uNJdwvztoewwxx5QJ
         RWJF6Fa6yuH7Efa3ZZEQgULYaI4zvgDt7/aB/IYv2CJ7Dn1Y1TLJ3oxFCL8JdS026WV4
         swjU4QXn1xcduIkxzQtSphug/aarIqdg3uppjYi5xOr26nzLzIhWUNWh4wO8SOh/+Epy
         JvMCM3b2DAdTI3F2tRonQCb4o8f91mWrdgERX2wDHRcTv2urtI4URqiQZR9KOfP2YJzx
         Ob2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ajZkQUpdD91YaKxYZS+6hb11vUCM5tx8VfmWTzbq5CE=;
        b=uDkDD/TMvJ75ZgzO0RNwpfHMvlqHQkIyhE+l+GZzpMsfAnaQTkEqNIOgiJxoZrukRU
         NUpQDRJz8SEYvHhb6l5dT00676/o0cYGi5QNHU2xa03yfZiPwat13KPLDh3XuIVZyjzH
         CbEGXiboBakBRZwKRBs0EnEzsTgL+EYRHBC/lyl/tk/QFksTglv61yRcn91zSQGS/WVw
         PziNZ68TZzQKIRwEVBk6JPb8FoIHrJUYQBWb8SHX/07xxdQkPWzn+J8f5i9UTzp1G+1u
         onRCMG3wMo9SryKMaEdQHNFThc1QOGnNQ3dagHjuuFWx1s7YrjhRFG/D9v6J3KpR7zN0
         yxwQ==
X-Gm-Message-State: AOAM530V4JCfYOU+8zk+INV8PmYYU0GjarU2d2ChbQeP+6YY0TrktllH
        u4I4HRJh1Ov7Ecw8WYm90Ym/8WU/JLGaSw==
X-Google-Smtp-Source: ABdhPJzg1aMAb13eTxUh3bqLKkQVWxGXNaAaDk1GlCH9Rd+XiSyWwrc3ipEuNbzCtt3z/liffkc0HhKA31nxXA==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:61b3:1cb2:c180:c3f])
 (user=gprocida job=sendgmr) by 2002:a0c:fc44:: with SMTP id
 w4mr22445659qvp.55.1613560096470; Wed, 17 Feb 2021 03:08:16 -0800 (PST)
Date:   Wed, 17 Feb 2021 11:08:00 +0000
In-Reply-To: <20210217110804.75923-1-gprocida@google.com>
Message-Id: <20210217110804.75923-2-gprocida@google.com>
Mime-Version: 1.0
References: <20210205134221.2953163-1-gprocida@google.com> <20210217110804.75923-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH dwarves v4 1/5] btf_encoder: Funnel ELF error reporting
 through a macro
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org, acme@kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, gprocida@google.com,
        maennich@google.com, kernel-team@android.com, kernel-team@fb.com,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds elf_error which prepends error messages with the function
and appends a readable ELF error status.

Also capitalise ELF consistently in error messages.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 libbtf.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/libbtf.c b/libbtf.c
index 9f76283..7bc49ba 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -27,6 +27,16 @@
 #include "dwarves.h"
 #include "elf_symtab.h"
 
+/*
+ * This depends on the GNU extension to eliminate the stray comma in the zero
+ * arguments case.
+ *
+ * The difference between elf_errmsg(-1) and elf_errmsg(elf_errno()) is that the
+ * latter clears the current error.
+ */
+#define elf_error(fmt, ...) \
+	fprintf(stderr, "%s: " fmt ": %s.\n", __func__, ##__VA_ARGS__, elf_errmsg(-1))
+
 struct btf *base_btf;
 uint8_t btf_elf__verbose;
 uint8_t btf_elf__force;
@@ -103,15 +113,13 @@ try_as_raw_btf:
 			goto errout;
 
 		if (elf_version(EV_CURRENT) == EV_NONE) {
-			fprintf(stderr, "%s: cannot set libelf version.\n",
-				__func__);
+			elf_error("cannot set libelf version");
 			goto errout;
 		}
 
 		btfe->elf = elf_begin(btfe->in_fd, ELF_C_READ_MMAP, NULL);
 		if (!btfe->elf) {
-			fprintf(stderr, "%s: cannot read %s ELF file: %s.\n",
-				__func__, filename, elf_errmsg(elf_errno()));
+			elf_error("cannot read %s ELF file", filename);
 			goto errout;
 		}
 	}
@@ -127,7 +135,7 @@ try_as_raw_btf:
 			goto try_as_raw_btf;
 		}
 		if (btf_elf__verbose)
-			fprintf(stderr, "%s: cannot get elf header.\n", __func__);
+			elf_error("cannot get ELF header");
 		goto errout;
 	}
 
@@ -141,7 +149,7 @@ try_as_raw_btf:
 		btf__set_endianness(btfe->btf, BTF_BIG_ENDIAN);
 		break;
 	default:
-		fprintf(stderr, "%s: unknown elf endianness.\n", __func__);
+		fprintf(stderr, "%s: unknown ELF endianness.\n", __func__);
 		goto errout;
 	}
 
@@ -707,15 +715,13 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 	}
 
 	if (elf_version(EV_CURRENT) == EV_NONE) {
-		fprintf(stderr, "Cannot set libelf version: %s.\n",
-			elf_errmsg(elf_errno()));
+		elf_error("Cannot set libelf version");
 		goto out;
 	}
 
 	elf = elf_begin(fd, ELF_C_RDWR, NULL);
 	if (elf == NULL) {
-		fprintf(stderr, "Cannot update ELF file: %s.\n",
-			elf_errmsg(elf_errno()));
+		elf_error("Cannot update ELF file");
 		goto out;
 	}
 
@@ -723,8 +729,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 
 	ehdr = gelf_getehdr(elf, &ehdr_mem);
 	if (ehdr == NULL) {
-		fprintf(stderr, "%s: elf_getehdr failed: %s.\n", __func__,
-			elf_errmsg(elf_errno()));
+		elf_error("elf_getehdr failed");
 		goto out;
 	}
 
@@ -736,7 +741,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 		btf__set_endianness(btf, BTF_BIG_ENDIAN);
 		break;
 	default:
-		fprintf(stderr, "%s: unknown elf endianness.\n", __func__);
+		fprintf(stderr, "%s: unknown ELF endianness.\n", __func__);
 		goto out;
 	}
 
@@ -768,8 +773,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 		    elf_update(elf, ELF_C_WRITE) >= 0)
 			err = 0;
 		else
-			fprintf(stderr, "%s: elf_update failed: %s.\n",
-				__func__, elf_errmsg(elf_errno()));
+			elf_error("elf_update failed");
 	} else {
 		const char *llvm_objcopy;
 		char tmp_fn[PATH_MAX];
-- 
2.30.0.478.g8a0d178c01-goog

