Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB209615649
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 00:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiKAXy5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 19:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKAXy4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 19:54:56 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA55B18B11
        for <bpf@vger.kernel.org>; Tue,  1 Nov 2022 16:54:55 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id o12so25658832lfq.9
        for <bpf@vger.kernel.org>; Tue, 01 Nov 2022 16:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AlVuJ4d7yqDFcoy3CYpWq+I7hoPcWrNi8dVfQVgri28=;
        b=qO6TRGmP7qYb4fuLNZ5Y0+YRPDAm9DthmA/+amhvXODb7MYaipLeNnYAksX9kuV0bu
         pbKnxaOgQyJd9+zzx3u15OaY8Q7E0qY6o4fBBFAT+DVjstH2Mk7ehazRx6F1rgry+LFB
         XWr0vmGpqAM65ZE+Ak26qdyswEKbv2BB+1kkA5JeHpgf7ZDDqyPZAfP1y9/7ciynWk36
         griz00ktuKeSlgep98Ew80oVx4azJt+7BHauGRjUDLoWxw+4pG6ZGjvchOUGzmhwh4CA
         87TztmuhKirvhIbcODkKQxspzu3uXCWMdjm8gIsWz/HGMWHzI5o7F4BaXWQGzuw/hePo
         fC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AlVuJ4d7yqDFcoy3CYpWq+I7hoPcWrNi8dVfQVgri28=;
        b=vGL2CWfdlSraS4Nw5Ch1VF8Oy94KzVf4iL+9w5aNfItGtJ0N+N+tnf24Ow1YJzY2qr
         rdPOeHMrdFwDJ16otpFTKnLxiOH3AX6oar7ZBrpqdE1LjPy466TR4m5Bw1rbpmQ/Zhwk
         6cEgfwkfdc24hMOq+YDTle74gn3l/IVD6ehG5Mqfj80QxOH2A1CRqb2O1WLUu6eNQUt4
         UJKF0IpoLAg8U6U5TFChn5VsOuQtPofp90SILgbG5ZTO9XYxUIUY41Wzq5qtmD7LdYF2
         62ZPohw70ZYq3s52RdtlwBZBCSB2V2bw25y1JstSC6tR+WPUyLcpw7qH29UWrZfA2fit
         eyTA==
X-Gm-Message-State: ACrzQf0duCSKKBQ9y0FM0cdgjiPzHGtN9PyCK2PjHA1Mre4TG4OzVisB
        ly/wqgxOg6f5JxgQUrpmqCtjg6ZEsf2VG/4Z
X-Google-Smtp-Source: AMsMyM6EsDf9KDMYOgstDlooHrCsFVS3NU3QVtJK4hYSVIEvgGzSfdVExnXhhNdaIodFw5zfMi97pw==
X-Received: by 2002:a05:6512:a8e:b0:4a2:675c:9ed8 with SMTP id m14-20020a0565120a8e00b004a2675c9ed8mr7807252lfu.547.1667346893721;
        Tue, 01 Nov 2022 16:54:53 -0700 (PDT)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id h17-20020a05651c125100b0026fbac7468bsm1673056ljh.103.2022.11.01.16.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 16:54:53 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, alan.maguire@oracle.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 1/2] libbpf: Resolve enum fwd as full enum64 and vice versa
Date:   Wed,  2 Nov 2022 01:54:12 +0200
Message-Id: <20221101235413.1824260-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Changes de-duplication logic for enums in the following way:
- update btf_hash_enum to ignore size and kind fields to get
  ENUM and ENUM64 types in a same hash bucket;
- update btf_compat_enum to consider enum fwd to be compatible with
  full enum64 (and vice versa);

This allows BTF de-duplication in the following case:

    // CU #1
    enum foo;

    struct s {
      enum foo *a;
    } *x;

    // CU #2
    enum foo {
      x = 0xfffffffff // big enough to force enum64
    };

    struct s {
      enum foo *a;
    } *y;

De-duplicated BTF prior to this commit:

    [1] ENUM64 'foo' encoding=UNSIGNED size=8 vlen=1
    	'x' val=68719476735ULL
    [2] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64
        encoding=(none)
    [3] STRUCT 's' size=8 vlen=1
    	'a' type_id=4 bits_offset=0
    [4] PTR '(anon)' type_id=1
    [5] PTR '(anon)' type_id=3
    [6] STRUCT 's' size=8 vlen=1
    	'a' type_id=8 bits_offset=0
    [7] ENUM 'foo' encoding=UNSIGNED size=4 vlen=0
    [8] PTR '(anon)' type_id=7
    [9] PTR '(anon)' type_id=6

De-duplicated BTF after this commit:

    [1] ENUM64 'foo' encoding=UNSIGNED size=8 vlen=1
    	'x' val=68719476735ULL
    [2] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64
        encoding=(none)
    [3] STRUCT 's' size=8 vlen=1
    	'a' type_id=4 bits_offset=0
    [4] PTR '(anon)' type_id=1
    [5] PTR '(anon)' type_id=3

Enum forward declarations in C do not provide information about
enumeration values range. Thus the `btf_type->size` field is
meaningless for forward enum declarations. In fact, GCC does not
encode size in DWARF for forward enum declarations
(but dwarves sets enumeration size to a default value of `sizeof(int) * 8`
when size is not specified see dwarf_loader.c:die__create_new_enumeration).

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/btf.c | 75 +++++++++++++++------------------------------
 1 file changed, 25 insertions(+), 50 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 675a0df5c840..6efc11a35afe 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3404,23 +3404,17 @@ static long btf_hash_enum(struct btf_type *t)
 {
 	long h;
 
-	/* don't hash vlen and enum members to support enum fwd resolving */
+	/* don't hash vlen, enum members and size to support enum fwd resolving */
 	h = hash_combine(0, t->name_off);
-	h = hash_combine(h, t->info & ~0xffff);
-	h = hash_combine(h, t->size);
 	return h;
 }
 
-/* Check structural equality of two ENUMs. */
-static bool btf_equal_enum(struct btf_type *t1, struct btf_type *t2)
+static bool btf_equal_enum_members(struct btf_type *t1, struct btf_type *t2)
 {
 	const struct btf_enum *m1, *m2;
 	__u16 vlen;
 	int i;
 
-	if (!btf_equal_common(t1, t2))
-		return false;
-
 	vlen = btf_vlen(t1);
 	m1 = btf_enum(t1);
 	m2 = btf_enum(t2);
@@ -3433,15 +3427,12 @@ static bool btf_equal_enum(struct btf_type *t1, struct btf_type *t2)
 	return true;
 }
 
-static bool btf_equal_enum64(struct btf_type *t1, struct btf_type *t2)
+static bool btf_equal_enum64_members(struct btf_type *t1, struct btf_type *t2)
 {
 	const struct btf_enum64 *m1, *m2;
 	__u16 vlen;
 	int i;
 
-	if (!btf_equal_common(t1, t2))
-		return false;
-
 	vlen = btf_vlen(t1);
 	m1 = btf_enum64(t1);
 	m2 = btf_enum64(t2);
@@ -3455,6 +3446,19 @@ static bool btf_equal_enum64(struct btf_type *t1, struct btf_type *t2)
 	return true;
 }
 
+/* Check structural equality of two ENUMs. */
+static bool btf_equal_enum(struct btf_type *t1, struct btf_type *t2)
+{
+	if (!btf_equal_common(t1, t2))
+		return false;
+
+	/* t1 & t2 kinds are identical because of btf_equal_common */
+	if (btf_kind(t1) == BTF_KIND_ENUM)
+		return btf_equal_enum_members(t1, t2);
+	else
+		return btf_equal_enum64_members(t1, t2);
+}
+
 static inline bool btf_is_enum_fwd(struct btf_type *t)
 {
 	return btf_is_any_enum(t) && btf_vlen(t) == 0;
@@ -3464,21 +3468,14 @@ static bool btf_compat_enum(struct btf_type *t1, struct btf_type *t2)
 {
 	if (!btf_is_enum_fwd(t1) && !btf_is_enum_fwd(t2))
 		return btf_equal_enum(t1, t2);
-	/* ignore vlen when comparing */
-	return t1->name_off == t2->name_off &&
-	       (t1->info & ~0xffff) == (t2->info & ~0xffff) &&
-	       t1->size == t2->size;
-}
-
-static bool btf_compat_enum64(struct btf_type *t1, struct btf_type *t2)
-{
-	if (!btf_is_enum_fwd(t1) && !btf_is_enum_fwd(t2))
-		return btf_equal_enum64(t1, t2);
-
-	/* ignore vlen when comparing */
+	/* At this point either t1 or t2 or both are forward declarations, thus:
+	 * - skip comparing vlen because it is zero for forward declarations;
+	 * - skip comparing size to allow enum forward declarations
+	 *   to be compatible with enum64 full declarations;
+	 * - skip comparing kind for the same reason.
+	 */
 	return t1->name_off == t2->name_off &&
-	       (t1->info & ~0xffff) == (t2->info & ~0xffff) &&
-	       t1->size == t2->size;
+	       btf_is_any_enum(t1) && btf_is_any_enum(t2);
 }
 
 /*
@@ -3763,6 +3760,7 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
 		break;
 
 	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
 		h = btf_hash_enum(t);
 		for_each_dedup_cand(d, hash_entry, h) {
 			cand_id = (__u32)(long)hash_entry->value;
@@ -3783,27 +3781,6 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
 		}
 		break;
 
-	case BTF_KIND_ENUM64:
-		h = btf_hash_enum(t);
-		for_each_dedup_cand(d, hash_entry, h) {
-			cand_id = (__u32)(long)hash_entry->value;
-			cand = btf_type_by_id(d->btf, cand_id);
-			if (btf_equal_enum64(t, cand)) {
-				new_id = cand_id;
-				break;
-			}
-			if (btf_compat_enum64(t, cand)) {
-				if (btf_is_enum_fwd(t)) {
-					/* resolve fwd to full enum */
-					new_id = cand_id;
-					break;
-				}
-				/* resolve canonical enum fwd to full enum */
-				d->map[cand_id] = type_id;
-			}
-		}
-		break;
-
 	case BTF_KIND_FWD:
 	case BTF_KIND_FLOAT:
 		h = btf_hash_common(t);
@@ -4099,10 +4076,8 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
 		return btf_equal_int_tag(cand_type, canon_type);
 
 	case BTF_KIND_ENUM:
-		return btf_compat_enum(cand_type, canon_type);
-
 	case BTF_KIND_ENUM64:
-		return btf_compat_enum64(cand_type, canon_type);
+		return btf_compat_enum(cand_type, canon_type);
 
 	case BTF_KIND_FWD:
 	case BTF_KIND_FLOAT:
-- 
2.34.1

