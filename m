Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52714260E0
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 02:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237056AbhJHAFe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 20:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbhJHAFd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Oct 2021 20:05:33 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA8EC061570
        for <bpf@vger.kernel.org>; Thu,  7 Oct 2021 17:03:39 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s75so1393259pgs.5
        for <bpf@vger.kernel.org>; Thu, 07 Oct 2021 17:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VqqT5R9H+XOhf2XrgCzQZ0OVBn/DcIpASC9a16Ev/ZA=;
        b=C4BvuIQGtTBp9UqsUjE6LdGZXQ1VGaaVK6p4r0nQKRDaLhvdiqSR8vWlE/16FWBJNp
         kGyOjbnFN1H1FGY9hHUIw9nRR/rxuLoCd78OUrCUnmTu77C8Vl5ClUPGmtbeRFp45Sw4
         ERls+IDmpZhPlUBzxmsmTYDl28dlzntdK33bko+T8igDyYxO4wiXe9E/6KMhHs577x+U
         6F+hDWsADpIP5bkVpjfx1LGdR8s4zJSf2HlaViAqUq4dny840uwyvdW+Ii9NXtQ6188h
         mNkUKI+Yt2DnBRzJE61CYjnazoGC38492MpCMRWSZmh55nlaKzpnUIZ6RSm+0WTzpkLi
         rd+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VqqT5R9H+XOhf2XrgCzQZ0OVBn/DcIpASC9a16Ev/ZA=;
        b=2mSvzrSvvTHoLbVW1Kz2xPWq77Wdx6fe8sG+CfqtNaFUv5DmhHK8UOJ/aGq77XU/dx
         681BfNXVxKBFInZL9/+YEfBgDhDEiU9Qzub7fcPuUEquQGXoJuaargPkkM23AEjoWfyF
         IkbsO2G3KZBYT/MLdu9HuWQXhMQYbPj+8FQnZsyCibcJX3wB3mB0GH9usoXezBYLUHsa
         xKlOMf26N9xNTdj1SLWD9jX8APyzu2jcL6n+RzvhLDsCj8+Yrs/SkcbKJ3gv+PP6wTQ6
         0c3tTPFLshUoqyIlUArX1+tHYPzkX2VslL0Xz7rYRRUf2SBhJ4St8c9Ox6pKnLKeuTLE
         Yq9w==
X-Gm-Message-State: AOAM532AEo4vnd8O9qRRQ5zWerFMEsZX/wmnBFPPQ4I6NlTuTMlOw8u6
        Nm4HKJYxl3oJ0hKX9fug8ZzlygJNCamjZQ==
X-Google-Smtp-Source: ABdhPJx/2/u8ZjJc8oq9U0IvwpvuIyQBJjl8L9IhpSky63phhg2k5Mz3aNzi0cpof3VHOnk6iZzK9Q==
X-Received: by 2002:aa7:8891:0:b0:44c:255d:391f with SMTP id z17-20020aa78891000000b0044c255d391fmr7359400pfe.26.1633651418809;
        Thu, 07 Oct 2021 17:03:38 -0700 (PDT)
Received: from andriin-mbp.thefacebook.com ([2620:10d:c090:500::e050])
        by smtp.gmail.com with ESMTPSA id 127sm517689pfw.10.2021.10.07.17.03.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Oct 2021 17:03:38 -0700 (PDT)
From:   andrii.nakryiko@gmail.com
X-Google-Original-From: andrii@kernel.org
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com
Subject: [PATCH bpf-next 06/10] bpftool: improve skeleton generation for data maps without DATASEC type
Date:   Thu,  7 Oct 2021 17:03:05 -0700
Message-Id: <20211008000309.43274-7-andrii@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211008000309.43274-1-andrii@kernel.org>
References: <20211008000309.43274-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andrii@kernel.org>

It can happen that some data sections (e.g., .rodata.cst16, containing
compiler populated string constants) won't have a corresponding BTF
DATASEC type. Now that libbpf supports .rodata.* and .data.* sections,
situation like that will cause invalid BPF skeleton to be generated that
won't compile successfully, as some parts of skeleton would assume
memory-mapped struct definitions for each special data section.

Fix this by generating empty struct definitions for such data sections.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/bpf/bpftool/gen.c | 51 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 5fbd90bb0c09..889a5b1542c9 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -214,22 +214,61 @@ static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
 	struct btf *btf = bpf_object__btf(obj);
 	int n = btf__get_nr_types(btf);
 	struct btf_dump *d;
+	struct bpf_map *map;
+	const struct btf_type *sec;
+	char sec_ident[256], map_ident[256];
 	int i, err = 0;
 
 	d = btf_dump__new(btf, NULL, NULL, codegen_btf_dump_printf);
 	if (IS_ERR(d))
 		return PTR_ERR(d);
 
-	for (i = 1; i <= n; i++) {
-		const struct btf_type *t = btf__type_by_id(btf, i);
+	bpf_object__for_each_map(map, obj) {
+		/* only generate definitions for memory-mapped internal maps */
+		if (!bpf_map__is_internal(map))
+			continue;
+		if (!(bpf_map__def(map)->map_flags & BPF_F_MMAPABLE))
+			continue;
 
-		if (!btf_is_datasec(t))
+		if (!get_map_ident(map, map_ident, sizeof(map_ident)))
 			continue;
 
-		err = codegen_datasec_def(obj, btf, d, t, obj_name);
-		if (err)
-			goto out;
+		sec = NULL;
+		for (i = 1; i <= n; i++) {
+			const struct btf_type *t = btf__type_by_id(btf, i);
+			const char *name;
+
+			if (!btf_is_datasec(t))
+				continue;
+
+			name = btf__str_by_offset(btf, t->name_off);
+			if (!get_datasec_ident(name, sec_ident, sizeof(sec_ident)))
+				continue;
+
+			if (strcmp(sec_ident, map_ident) == 0) {
+				sec = t;
+				break;
+			}
+		}
+
+		/* In some cases (e.g., sections like .rodata.cst16 containing
+		 * compiler allocated string constants only) there will be
+		 * special internal maps with no corresponding DATASEC BTF
+		 * type. In such case, generate empty structs for each such
+		 * map. It will still be memory-mapped and its contents
+		 * accessible from user-space through BPF skeleton.
+		 */
+		if (!sec) {
+			printf("	struct %s__%s {\n", obj_name, map_ident);
+			printf("	} *%s;\n", map_ident);
+		} else {
+			err = codegen_datasec_def(obj, btf, d, sec, obj_name);
+			if (err)
+				goto out;
+		}
 	}
+
+
 out:
 	btf_dump__free(d);
 	return err;
-- 
2.30.2

