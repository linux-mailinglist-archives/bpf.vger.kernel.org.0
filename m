Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2304377AE
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 15:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhJVNJx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Oct 2021 09:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbhJVNJv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Oct 2021 09:09:51 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276AAC061764
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 06:07:34 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id t184so3627252pfd.0
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 06:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oS6DLiTkGwKnOt3xws5AjwGPpbcVF9DdvXAtP6jtXN0=;
        b=pqEh8Y0PwHr820X2UGmBgEL5JhJEFIW6QhcijhUGl27Y/JxqZ+dfFJE3PpOlj5MMR9
         N3e2ASLLdgwPLrBZziTIL+ucEpi5q/Jozvtvm+V3nKFQXL+m6kXruDLAf4VPaVYLEOj2
         SlEP0sxxXw71TM/WfkNDRdx5BGcC9s1UWTk9JHwk4Xmj2S7zlqjWmw91rHluLbFy16vt
         6C7AqqIdBGkXJGILwwZp4fLSBVzNN+TGnFjOUCrsa7L5AnZd9Z0EReGQWWFeKaunsWwd
         DMjuVQtXzU/eZfMrqIxBl0EFWG9wsgJ6zEUCQzZr1jULzWCO/ekKEyrrNOXsYAOVLhMb
         kpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oS6DLiTkGwKnOt3xws5AjwGPpbcVF9DdvXAtP6jtXN0=;
        b=brypaGTQu/4eIAZ2i5JcbCFr/txIsNJkq2/7Hc754sXkmJFaTxV29/FYXTRz7N5+Ze
         NLLLsPUyVdfDu9tNNmWuvQtk0/GfwpDRrShSCeCG9ZmBNhzQTScYaQFPJsXlp5KR7uZL
         Azdu8/hu/N4TlbZvaqU9diselefThynMxA8UyxKzkySBqhaf12q/DPM4qJBGJgjZUbid
         TIvaPrwHaWRzuLFTn4I2EOC0NeAKAOVHy0i/sS32PinxBIsigHCbw35+y6VHmEX4GZ7C
         G6qNHGXcobSOiYF97QNGgLf2HYsb7eeJ0JZtakCiP6BNX4tFqVS5CCHYpS45xvONz6iT
         P4BA==
X-Gm-Message-State: AOAM532/YNuiM0NmLiUMFboCfhPFf0dWcob0YxcfIGBbP1AyLwJz4VsS
        CHdJjYLfNWjVVd1pPziarqHbQwz860aU8w==
X-Google-Smtp-Source: ABdhPJxLP3O4WxsULhyIlUtMwM9YNFWeAFqumFLONOqsgvI/i/QMLv71WJhfVrRURVo2UB7UQgAKgQ==
X-Received: by 2002:a63:af4b:: with SMTP id s11mr9342055pgo.185.1634908053062;
        Fri, 22 Oct 2021 06:07:33 -0700 (PDT)
Received: from VM-32-4-ubuntu.. ([43.132.164.184])
        by smtp.gmail.com with ESMTPSA id k22sm9632083pfi.149.2021.10.22.06.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 06:07:32 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kafai@fb.com,
        songliubraving@fb.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next 4/5 v2] bpftool: Switch to new btf__type_cnt API
Date:   Fri, 22 Oct 2021 21:06:22 +0800
Message-Id: <20211022130623.1548429-5-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211022130623.1548429-1-hengqi.chen@gmail.com>
References: <20211022130623.1548429-1-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Replace the call to btf__get_nr_types with new API btf__type_cnt.
The old API will be deprecated in libbpf v0.7+. No functionality
change.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/bpf/bpftool/btf.c | 12 ++++++------
 tools/bpf/bpftool/gen.c |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 7b68d4f65fe6..0cd769adac66 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -329,7 +329,7 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
 				printf("\n\ttype_id=%u offset=%u size=%u",
 				       v->type, v->offset, v->size);

-				if (v->type <= btf__get_nr_types(btf)) {
+				if (v->type < btf__type_cnt(btf)) {
 					vt = btf__type_by_id(btf, v->type);
 					printf(" (%s '%s')",
 					       btf_kind_str[btf_kind_safe(btf_kind(vt))],
@@ -390,14 +390,14 @@ static int dump_btf_raw(const struct btf *btf,
 		}
 	} else {
 		const struct btf *base;
-		int cnt = btf__get_nr_types(btf);
+		int cnt = btf__type_cnt(btf);
 		int start_id = 1;

 		base = btf__base_btf(btf);
 		if (base)
-			start_id = btf__get_nr_types(base) + 1;
+			start_id = btf__type_cnt(base);

-		for (i = start_id; i <= cnt; i++) {
+		for (i = start_id; i < cnt; i++) {
 			t = btf__type_by_id(btf, i);
 			dump_btf_type(btf, i, t);
 		}
@@ -440,9 +440,9 @@ static int dump_btf_c(const struct btf *btf,
 				goto done;
 		}
 	} else {
-		int cnt = btf__get_nr_types(btf);
+		int cnt = btf__type_cnt(btf);

-		for (i = 1; i <= cnt; i++) {
+		for (i = 1; i < cnt; i++) {
 			err = btf_dump__dump_type(d, i);
 			if (err)
 				goto done;
diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index c446405ab73f..5c18351290f0 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -211,7 +211,7 @@ static int codegen_datasec_def(struct bpf_object *obj,
 static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
 {
 	struct btf *btf = bpf_object__btf(obj);
-	int n = btf__get_nr_types(btf);
+	int n = btf__type_cnt(btf);
 	struct btf_dump *d;
 	struct bpf_map *map;
 	const struct btf_type *sec;
@@ -233,7 +233,7 @@ static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
 			continue;

 		sec = NULL;
-		for (i = 1; i <= n; i++) {
+		for (i = 1; i < n; i++) {
 			const struct btf_type *t = btf__type_by_id(btf, i);
 			const char *name;

--
2.30.2
