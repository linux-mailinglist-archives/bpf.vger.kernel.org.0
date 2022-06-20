Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B11552841
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 01:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245210AbiFTXXN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jun 2022 19:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346593AbiFTXXB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 19:23:01 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E162BB19
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 16:18:05 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id E8806240108
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 01:18:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1655767083; bh=2AXd5CKVR5VYsRxh0WrG33Ue7HtinUs0TiUP2XNxdoQ=;
        h=From:To:Cc:Subject:Date:From;
        b=jGf4/IY+lWTuYQRFdh1zyBlfs5gMZvlsiOqwcjYvn514AQjB0uq1ZfSK6KkniV13P
         IfFrql4om0FS9dZxrQFalA7pMyswBH+BQzYPvp/VGCIclM9T+dD6Bov9xLk/IpMlH2
         sUbIVjAqbZtTuiOqyfv7wgJ2D+CgXF5M8iEhIASTJn0eCnjmWv0wMPEwGN4mZONClu
         jXI9VFaxwwgfUobuJQUlBcFrVz/yY7FWrE2rVtz8lUa/zZf5ezLN3G6VoAiFFScLld
         m9pD1lKGiYwOP1hsG+IwzEIZRRz7/O1eHqgEW3Ietjv1FjI9T2z15eq9ycLAYtBKGO
         wDyiu/+sujY1A==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LRltg0CPkz6tmX;
        Tue, 21 Jun 2022 01:18:03 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 2/7] bpftool: Honor BPF_CORE_TYPE_MATCHES relocation
Date:   Mon, 20 Jun 2022 23:17:08 +0000
Message-Id: <20220620231713.2143355-3-deso@posteo.net>
In-Reply-To: <20220620231713.2143355-1-deso@posteo.net>
References: <20220620231713.2143355-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpftool needs to know about the newly introduced BPF_CORE_TYPE_MATCHES
relocation for its 'gen min_core_btf' command to work properly in the
present of this relocation.
Specifically, we need to make sure to mark types and fields so that they
are present in the minimized BTF for "type match" checks to work out.
However, contrary to the existing btfgen_record_field_relo, we need to
rely on the BTF -- and not the spec -- to find fields. With this change
we handle this new variant correctly. The functionality will be tested
with follow on changes to BPF selftests, which already run against a
minimized BTF created with bpftool.

Cc: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Daniel Müller <deso@posteo.net>
---
 tools/bpf/bpftool/gen.c | 106 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 480cbd8..cf45ce 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -1856,6 +1856,110 @@ static int btfgen_record_field_relo(struct btfgen_info *info, struct bpf_core_sp
 	return 0;
 }
 
+/* Mark types, members, and member types. Compared to btfgen_record_field_relo,
+ * this function does not rely on the target spec for inferring members, but
+ * uses the associated BTF.
+ *
+ * The `behind_ptr` argument is used to stop marking of composite types reached
+ * through a pointer. This way, we keep can keep BTF size in check while
+ * providing reasonable match semantics.
+ */
+static int btfgen_mark_types_match(struct btfgen_info *info, __u32 type_id, bool behind_ptr)
+{
+	const struct btf_type *btf_type;
+	struct btf *btf = info->src_btf;
+	struct btf_type *cloned_type;
+	int i, err;
+
+	if (type_id == 0)
+		return 0;
+
+	btf_type = btf__type_by_id(btf, type_id);
+	/* mark type on cloned BTF as used */
+	cloned_type = (struct btf_type *)btf__type_by_id(info->marked_btf, type_id);
+	cloned_type->name_off = MARKED;
+
+	switch (btf_kind(btf_type)) {
+	case BTF_KIND_UNKN:
+	case BTF_KIND_INT:
+	case BTF_KIND_FLOAT:
+	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
+		break;
+	case BTF_KIND_STRUCT:
+	case BTF_KIND_UNION: {
+		struct btf_member *m = btf_members(btf_type);
+		__u16 vlen = btf_vlen(btf_type);
+
+		if (behind_ptr)
+			break;
+
+		for (i = 0; i < vlen; i++, m++) {
+			/* mark member */
+			btfgen_mark_member(info, type_id, i);
+
+			/* mark member's type */
+			err = btfgen_mark_types_match(info, m->type, false);
+			if (err)
+				return err;
+		}
+		break;
+	}
+	case BTF_KIND_CONST:
+	case BTF_KIND_VOLATILE:
+	case BTF_KIND_TYPEDEF:
+		return btfgen_mark_types_match(info, btf_type->type, false);
+	case BTF_KIND_PTR:
+		return btfgen_mark_types_match(info, btf_type->type, true);
+	case BTF_KIND_ARRAY: {
+		struct btf_array *array;
+
+		array = btf_array(btf_type);
+		/* mark array type */
+		err = btfgen_mark_types_match(info, array->type, false);
+		/* mark array's index type */
+		err = err ? : btfgen_mark_types_match(info, array->index_type, false);
+		if (err)
+			return err;
+		break;
+	}
+	case BTF_KIND_FUNC_PROTO: {
+		__u16 vlen = btf_vlen(btf_type);
+		struct btf_param *param;
+
+		/* mark ret type */
+		err = btfgen_mark_types_match(info, btf_type->type, false);
+		if (err)
+			return err;
+
+		/* mark parameters types */
+		param = btf_params(btf_type);
+		for (i = 0; i < vlen; i++) {
+			err = btfgen_mark_types_match(info, param->type, false);
+			if (err)
+				return err;
+			param++;
+		}
+		break;
+	}
+	/* tells if some other type needs to be handled */
+	default:
+		p_err("unsupported kind: %s (%d)", btf_kind_str(btf_type), type_id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/* Mark types, members, and member types. Compared to btfgen_record_field_relo,
+ * this function does not rely on the target spec for inferring members, but
+ * uses the associated BTF.
+ */
+static int btfgen_record_types_match_relo(struct btfgen_info *info, struct bpf_core_spec *targ_spec)
+{
+	return btfgen_mark_types_match(info, targ_spec->root_type_id, false);
+}
+
 static int btfgen_record_type_relo(struct btfgen_info *info, struct bpf_core_spec *targ_spec)
 {
 	return btfgen_mark_type(info, targ_spec->root_type_id, true);
@@ -1882,6 +1986,8 @@ static int btfgen_record_reloc(struct btfgen_info *info, struct bpf_core_spec *r
 	case BPF_CORE_TYPE_EXISTS:
 	case BPF_CORE_TYPE_SIZE:
 		return btfgen_record_type_relo(info, res);
+	case BPF_CORE_TYPE_MATCHES:
+		return btfgen_record_types_match_relo(info, res);
 	case BPF_CORE_ENUMVAL_EXISTS:
 	case BPF_CORE_ENUMVAL_VALUE:
 		return btfgen_record_enumval_relo(info, res);
-- 
2.30.2

