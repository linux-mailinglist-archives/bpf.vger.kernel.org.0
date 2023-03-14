Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909BD6BA34B
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 00:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjCNXEg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 19:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjCNXEe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 19:04:34 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE8623DAC;
        Tue, 14 Mar 2023 16:04:33 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x17so5941066lfu.5;
        Tue, 14 Mar 2023 16:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678835071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UU0Bn7UeA8alALTZ1D0adE9t/Pl+aBM3F1PUcMiWTfw=;
        b=qRzFS3lUXQaVT/w0Eqgp3xKVhIKbASiJCJX4yuTtPaZaGYIHIXoiqstRPRhIdRDLuw
         MqviSTMs1ELMWMGQnVMJwCuYNteEHP0PV5jH0ynd88Vn03qrL49wdcVUvwtEs5R84L9N
         ATIFL6N6AlEK0Ma+Iv5H9Z4xvNI4md86afp2aKvKc+8iHl/Y5DZqpRkYH8DNH73Y1Svr
         fKLLCRdqA7uDAx8TQ9sRitD5vXm7D06M6W+cunzIIk9m4SwzVo8GNRx+MyMSHyHQjvGh
         AYCAf/iSmUfYVfYkO2dzt/TWy97XIj/NrkNtysAC/GmvH8uXqXdcxnlpuRYsN13dtW/g
         P53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678835071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UU0Bn7UeA8alALTZ1D0adE9t/Pl+aBM3F1PUcMiWTfw=;
        b=tIEhnxfpMDe3y1VVQuIDlaAM6hc5cZYPpeCeK1FivhPm7yrsr6U94dqj+VgaqnvYrD
         JVj/UeQyqmsg043tBEoPvos9I/+P+UprWD4ieWrjbygTY6OpG6IZH8SyDcc1So8ojhmd
         T35gWOrb0WgNlQ4upDUYr+BIPomBzmL/Pj50CfbUpCSFh3iMJZOQ8lGemtVlP8VUoSqt
         qm00ickdN85mP5u6GIpWcIuNG9OWyAbUsLcVAUgyr9grdQb4b3xHYwXhuSVI2sCLQ5Y1
         MRCpfekjcrW9A9UN5RBQIH1ctdAx39pR7Is+QaxD7IwCzEb80ueXfKQxYrftOG2Qzg/E
         nYcA==
X-Gm-Message-State: AO0yUKUQQMtJMQo+gzfdGqvfnqvqqrGAfZx6JxnW77JPdnXcxkASvPBp
        ddHh9JVNnoJ2FX/WLgRPQ0bD+XOc47MLF14S
X-Google-Smtp-Source: AK7set9kk4VoEbBxsT7GBEyTmRBp7dIu0/OHwWN7xvjJV2IgxKV7rSro0DOTr4iykJZ211rBhHpwTw==
X-Received: by 2002:ac2:48bc:0:b0:4cc:597b:583e with SMTP id u28-20020ac248bc000000b004cc597b583emr1185144lfg.55.1678835071119;
        Tue, 14 Mar 2023 16:04:31 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id b1-20020ac25e81000000b004cc7acfbd2bsm569638lfq.287.2023.03.14.16.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 16:04:30 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     dwarves@vger.kernel.org, arnaldo.melo@gmail.com
Cc:     bpf@vger.kernel.org, kernel-team@fb.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
        jose.marchesi@oracle.com, david.faust@oracle.com,
        alan.maguire@oracle.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH dwarves v2 1/5] fprintf: Correct names for types with btf_type_tag attribute
Date:   Wed, 15 Mar 2023 01:04:13 +0200
Message-Id: <20230314230417.1507266-2-eddyz87@gmail.com>
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

The following example contains a structure field annotated with
btf_type_tag attribute:

    #define __tag1 __attribute__((btf_type_tag("tag1")))

    struct st {
      int __tag1 *a;
    } g;

It is not printed correctly by `pahole -F dwarf` command:

    $ clang -g -c test.c -o test.o
    pahole -F dwarf test.o
    struct st {
    	tag1 *                     a;                    /*     0     8 */
    	...
    };

Note the type for variable `a`: `tag1` is printed instead of `int`.
This commit teaches `type__fprintf()` and `__tag_name()` logic to skip
`DW_TAG_LLVM_annotation` objects that are used to encode type tags.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 dwarves_fprintf.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index e8399e7..1e6147a 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -572,6 +572,7 @@ static const char *__tag__name(const struct tag *tag, const struct cu *cu,
 	case DW_TAG_restrict_type:
 	case DW_TAG_atomic_type:
 	case DW_TAG_unspecified_type:
+	case DW_TAG_LLVM_annotation:
 		type = cu__type(cu, tag->type);
 		if (type == NULL && tag->type != 0)
 			tag__id_not_found_snprintf(bf, len, tag->type);
@@ -786,6 +787,10 @@ next_type:
 			n = tag__has_type_loop(type, ptype, NULL, 0, fp);
 			if (n)
 				return printed + n;
+			if (ptype->tag == DW_TAG_LLVM_annotation) {
+				type = ptype;
+				goto next_type;
+			}
 			if (ptype->tag == DW_TAG_subroutine_type) {
 				printed += ftype__fprintf(tag__ftype(ptype),
 							  cu, name, 0, 1,
@@ -880,6 +885,14 @@ print_modifier: {
 		else
 			printed += enumeration__fprintf(type, &tconf, fp);
 		break;
+	case DW_TAG_LLVM_annotation: {
+		struct tag *ttype = cu__type(cu, type->type);
+		if (ttype) {
+			type = ttype;
+			goto next_type;
+		}
+		goto out_type_not_found;
+	}
 	}
 out:
 	if (type_expanded)
-- 
2.39.1

