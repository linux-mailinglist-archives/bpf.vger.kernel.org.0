Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7B86BA34C
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 00:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjCNXEg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 19:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjCNXEf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 19:04:35 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02DFCDD8;
        Tue, 14 Mar 2023 16:04:34 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bp27so11777052lfb.6;
        Tue, 14 Mar 2023 16:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678835072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yP0TRJN4eh00/BpCyREFlXc4OCtxCsau3kExI5Vt0g0=;
        b=WoeQ+7Z8zCC3rL3DR0NMGMSo3tDy+9Q2XQQldi/iwhnVOD6O1KqrSFqeepVPe81vnB
         9EBlN8SAFkzScYECoelfB5Y0vjCA0rdY1zx7JtuBJW0Wf+lWadtkSjfNxPC6mopD9EIq
         YAU+g/WjCdlpzOs20YPob66MHm2BgUiUvCTvTy7dhU7vGkG/WiFgWe3urx09l6m4rxoX
         Qst8ImZ3lQhkzmipzEg3YWEvoqOsFYNBxcEH0vzSq3cbCRxHTCOyrh0v/Tfk5yyBWQYa
         HgPx8/wSxkHiovqD5xnau0V3BPMT8Y3eY+Q572arG3qrkeRsnCRAkXUk8jcJsSajOUh5
         3VNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678835072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yP0TRJN4eh00/BpCyREFlXc4OCtxCsau3kExI5Vt0g0=;
        b=4KVC7XGfWPLdMfNKJV8abNcgIUNG9IPuNsgHlGJ8Kq6D8EfHFMI4/WdFpO4ubBa5I/
         OBymlJ4yViqxncj+IiTLD5bC0+eez0GWDTw01oG36TXmASxIfd5kWDPWekcaWVrku04X
         3Fdvsa0kZggUsUsxa1kFM1R7hRSZApHlI9wCpimd9ui7WZSWJaFtdD8+pDqCkonw/inq
         3o/b/1Cot9eay3hxwJFHKUN3HpxwYvEkFezTq0SAdXnhMWESJmDFDLHd4F0IlB4DZ3QH
         QYZ+rduljWsSEG9yLlkuF11CQCprfzpJeTqWhkefRUwPQ4MYChi4ndRHRQJ2zXVTk7SL
         ROPA==
X-Gm-Message-State: AO0yUKVbtPFaYQ8zKVGydfIi8R5PQdlVTiBfdY/dWwboGGluPQ+Eisl7
        3GFLKCM/W1Sd1HekAapvo4Fu3Ry48bKUPlhT
X-Google-Smtp-Source: AK7set9q7qhpQ9EhcJ/EqeAx4H9ba7eqljlKm0kurMs2aWsjrKVpc/OAdW23QDL8Q0U0JGN7lmF75A==
X-Received: by 2002:a19:ae01:0:b0:4db:25f2:c116 with SMTP id f1-20020a19ae01000000b004db25f2c116mr1159564lfc.18.1678835072486;
        Tue, 14 Mar 2023 16:04:32 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id b1-20020ac25e81000000b004cc7acfbd2bsm569638lfq.287.2023.03.14.16.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 16:04:32 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     dwarves@vger.kernel.org, arnaldo.melo@gmail.com
Cc:     bpf@vger.kernel.org, kernel-team@fb.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
        jose.marchesi@oracle.com, david.faust@oracle.com,
        alan.maguire@oracle.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH dwarves v2 2/5] btf_loader: A hack for BTF import of btf_type_tag attributes
Date:   Wed, 15 Mar 2023 01:04:14 +0200
Message-Id: <20230314230417.1507266-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230314230417.1507266-1-eddyz87@gmail.com>
References: <20230314230417.1507266-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Pahole does not print type names correctly for the following example,
when BTF loader is used:

    #define __tag1 __attribute__((btf_type_tag("tag1")))

    struct st {
      int __tag1 *a;
    } g;

Here is the pahole output:

    $ clang -target bpf -g -c test.c -o test.o
    $ pahole -F btf test.o
    BTF: idx: 2, Unknown kind 18
    struct st {
    	<ERROR                    > a;                   /*     0     8 */
        ...
    };

Note the type name for field `a`.

This commit adds a workaround for this issue: it creates a tag
instance with tag->tag set to `DW_TAG_LLVM_annotation` and `tag->type`
pointing to the type wrapped by `BTF_KIND_TYPE_TAG`, `int` for the
example above.

Note that this is not a complete replication of behavior of DWARF
loader. When DWARF is processed type tag instances are added to the
annotations list of the parent pointer type. However, this is
sufficient to fix the printing issue and helps with `btfdiff` script.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 btf_loader.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/btf_loader.c b/btf_loader.c
index e579323..3fe07d0 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -429,10 +429,11 @@ static int create_new_tag(struct cu *cu, int type, const struct btf_type *tp, ui
 		return -ENOMEM;
 
 	switch (type) {
-	case BTF_KIND_CONST:	tag->tag = DW_TAG_const_type;	 break;
-	case BTF_KIND_PTR:	tag->tag = DW_TAG_pointer_type;  break;
-	case BTF_KIND_RESTRICT:	tag->tag = DW_TAG_restrict_type; break;
-	case BTF_KIND_VOLATILE:	tag->tag = DW_TAG_volatile_type; break;
+	case BTF_KIND_CONST:	tag->tag = DW_TAG_const_type;	   break;
+	case BTF_KIND_PTR:	tag->tag = DW_TAG_pointer_type;    break;
+	case BTF_KIND_RESTRICT:	tag->tag = DW_TAG_restrict_type;   break;
+	case BTF_KIND_VOLATILE:	tag->tag = DW_TAG_volatile_type;   break;
+	case BTF_KIND_TYPE_TAG:	tag->tag = DW_TAG_LLVM_annotation; break;
 	default:
 		free(tag);
 		printf("%s: Unknown type %d\n\n", __func__, type);
@@ -489,6 +490,12 @@ static int btf__load_types(struct btf *btf, struct cu *cu)
 		case BTF_KIND_PTR:
 		case BTF_KIND_CONST:
 		case BTF_KIND_RESTRICT:
+		/* For type tag it's a bit of a lie.
+		 * In DWARF it is encoded as a child tag of whatever type it
+		 * applies to. Here we load it as a standalone tag with a pointer
+		 * to a next type only to have a valid ID in the types table.
+		 */
+		case BTF_KIND_TYPE_TAG:
 			err = create_new_tag(cu, type, type_ptr, type_index);
 			break;
 		case BTF_KIND_UNKN:
-- 
2.39.1

