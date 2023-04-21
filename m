Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBF26EB0D7
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 19:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjDURnV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 13:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbjDURnE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 13:43:04 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCA930D7
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:42:47 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-2fe3fb8e2f7so1280873f8f.0
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682098966; x=1684690966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7K9QJLCiWjNf7ZX2dsiP9tDIrrE+yxdZAgYhLTPqVxI=;
        b=hX73LR5hzpsMbBZ/KJEQ/VgQjT2DWpn1ffTNJTBh2vvpbNGmQEsBAdqZDhCUllCX8W
         OwISkZ9r7dxLj7tMgCOwNp4YQpkqyflLGw3uuJ7v1TeZBlE1n+sg20urQXTlHRwk0BFn
         XLMmbOMZBlBQgqHi/pke3b8b0uzn5HDFhlfMjdQsV1awC3Jf6jlE1lV9j+SdbwSG9mfL
         B3f+/M0aV9YhXil3wKrpXCF9oTu111RzOaAoDmctr/5AVOp7n6DH4au8kD6Zn8BDr7cN
         vBfHvoOyKR2PMyNyFW40VMEkmHhrhaKyBY66C40NiHXRVyDkY7WS4Bj2ArRL28+6FpDC
         wQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098966; x=1684690966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7K9QJLCiWjNf7ZX2dsiP9tDIrrE+yxdZAgYhLTPqVxI=;
        b=lhQC9ZN8+zDhdLjm+rSF8Vf0Ud09WUJE4mco5UjYLNF/DC9GSlXYFpL2rB45AMOGLW
         iD8KVjM9xd3pHis1fripbkNeWOpoQCOsOaGw7MNV3feRIzgB7V24VkYXepZsJLvY8aKE
         8iuQMB+5AezLmg3xxyWiiXv7BBvTZUM6YCaL8vGo+T+x+6CAEaaY62C2KV2GGZgN370u
         JdvE/9fxg4PNOsi11rv9l19Vi5ofb1D44Whzu8tEp50oEFSP7UNxKVgJb8Pd8nE/qN40
         nM5PNidYBcB3em5yxEpHsZhCOqlcRKR+kUqx2Tx2Cka5Lrsuw8AgYhSjJiMf/pID6b4f
         LBxw==
X-Gm-Message-State: AAQBX9eVmB1imnXdF4xgVmUUtK28B/MofrSNIGE7EqqEraPNzhg7R7ZT
        bEwG3ho4hUOJmAKLzyYfNsCZm1oy0En0xA==
X-Google-Smtp-Source: AKy350ZcUjNF6ia5iyegWqYpQvIdlWIB+zZB3Xa2CcuU5JvAwf2NSX/eEw+IojsucFUkCU4a3oYT3w==
X-Received: by 2002:a5d:5226:0:b0:2f8:f144:a22c with SMTP id i6-20020a5d5226000000b002f8f144a22cmr4702582wra.62.1682098965866;
        Fri, 21 Apr 2023 10:42:45 -0700 (PDT)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id f4-20020a0560001b0400b002ffbf2213d4sm4849933wrz.75.2023.04.21.10.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 10:42:45 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 01/24] selftests/bpf: Add notion of auxiliary programs for test_loader
Date:   Fri, 21 Apr 2023 20:42:11 +0300
Message-Id: <20230421174234.2391278-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421174234.2391278-1-eddyz87@gmail.com>
References: <20230421174234.2391278-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In order to express test cases that use bpf_tail_call() intrinsic it
is necessary to have several programs to be loaded at a time.
This commit adds __auxiliary annotation to the set of annotations
supported by test_loader.c. Programs marked as auxiliary are always
loaded but are not treated as a separate test.

For example:

    void dummy_prog1(void);

    struct {
            __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
            __uint(max_entries, 4);
            __uint(key_size, sizeof(int));
            __array(values, void (void));
    } prog_map SEC(".maps") = {
            .values = {
                    [0] = (void *) &dummy_prog1,
            },
    };

    SEC("tc")
    __auxiliary
    __naked void dummy_prog1(void) {
            asm volatile ("r0 = 42; exit;");
    }

    SEC("tc")
    __description("reference tracking: check reference or tail call")
    __success __retval(0)
    __naked void check_reference_or_tail_call(void)
    {
            asm volatile (
            "r2 = %[prog_map] ll;"
            "r3 = 0;"
            "call %[bpf_tail_call];"
            "r0 = 0;"
            "exit;"
            :: __imm(bpf_tail_call),
            :  __clobber_all);
    }

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h |  6 ++
 tools/testing/selftests/bpf/test_loader.c    | 89 +++++++++++++++-----
 2 files changed, 73 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 3b307de8dab9..d3c1217ba79a 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -53,6 +53,10 @@
  *                   - A numeric value.
  *                   Multiple __flag attributes could be specified, the final flags
  *                   value is derived by applying binary "or" to all specified values.
+ *
+ * __auxiliary         Annotated program is not a separate test, but used as auxiliary
+ *                     for some other test cases and should always be loaded.
+ * __auxiliary_unpriv  Same, but load program in unprivileged mode.
  */
 #define __msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_msg=" msg)))
 #define __failure		__attribute__((btf_decl_tag("comment:test_expect_failure")))
@@ -65,6 +69,8 @@
 #define __flag(flag)		__attribute__((btf_decl_tag("comment:test_prog_flags="#flag)))
 #define __retval(val)		__attribute__((btf_decl_tag("comment:test_retval="#val)))
 #define __retval_unpriv(val)	__attribute__((btf_decl_tag("comment:test_retval_unpriv="#val)))
+#define __auxiliary		__attribute__((btf_decl_tag("comment:test_auxiliary")))
+#define __auxiliary_unpriv	__attribute__((btf_decl_tag("comment:test_auxiliary_unpriv")))
 
 /* Convenience macro for use with 'asm volatile' blocks */
 #define __naked __attribute__((naked))
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 40c9b7d532c4..b4edd8454934 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -25,6 +25,8 @@
 #define TEST_TAG_DESCRIPTION_PFX "comment:test_description="
 #define TEST_TAG_RETVAL_PFX "comment:test_retval="
 #define TEST_TAG_RETVAL_PFX_UNPRIV "comment:test_retval_unpriv="
+#define TEST_TAG_AUXILIARY "comment:test_auxiliary"
+#define TEST_TAG_AUXILIARY_UNPRIV "comment:test_auxiliary_unpriv"
 
 /* Warning: duplicated in bpf_misc.h */
 #define POINTER_VALUE	0xcafe4all
@@ -59,6 +61,8 @@ struct test_spec {
 	int log_level;
 	int prog_flags;
 	int mode_mask;
+	bool auxiliary;
+	bool valid;
 };
 
 static int tester_init(struct test_loader *tester)
@@ -87,6 +91,11 @@ static void free_test_spec(struct test_spec *spec)
 	free(spec->unpriv.name);
 	free(spec->priv.expect_msgs);
 	free(spec->unpriv.expect_msgs);
+
+	spec->priv.name = NULL;
+	spec->unpriv.name = NULL;
+	spec->priv.expect_msgs = NULL;
+	spec->unpriv.expect_msgs = NULL;
 }
 
 static int push_msg(const char *msg, struct test_subspec *subspec)
@@ -204,6 +213,12 @@ static int parse_test_spec(struct test_loader *tester,
 			spec->unpriv.expect_failure = false;
 			spec->mode_mask |= UNPRIV;
 			has_unpriv_result = true;
+		} else if (strcmp(s, TEST_TAG_AUXILIARY) == 0) {
+			spec->auxiliary = true;
+			spec->mode_mask |= PRIV;
+		} else if (strcmp(s, TEST_TAG_AUXILIARY_UNPRIV) == 0) {
+			spec->auxiliary = true;
+			spec->mode_mask |= UNPRIV;
 		} else if (str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX)) {
 			msg = s + sizeof(TEST_TAG_EXPECT_MSG_PFX) - 1;
 			err = push_msg(msg, &spec->priv);
@@ -314,6 +329,8 @@ static int parse_test_spec(struct test_loader *tester,
 		}
 	}
 
+	spec->valid = true;
+
 	return 0;
 
 cleanup:
@@ -516,16 +533,18 @@ void run_subtest(struct test_loader *tester,
 		 struct bpf_object_open_opts *open_opts,
 		 const void *obj_bytes,
 		 size_t obj_byte_cnt,
+		 struct test_spec *specs,
 		 struct test_spec *spec,
 		 bool unpriv)
 {
 	struct test_subspec *subspec = unpriv ? &spec->unpriv : &spec->priv;
+	struct bpf_program *tprog, *tprog_iter;
+	struct test_spec *spec_iter;
 	struct cap_state caps = {};
-	struct bpf_program *tprog;
 	struct bpf_object *tobj;
 	struct bpf_map *map;
-	int retval;
-	int err;
+	int retval, err, i;
+	bool should_load;
 
 	if (!test__start_subtest(subspec->name))
 		return;
@@ -546,15 +565,23 @@ void run_subtest(struct test_loader *tester,
 	if (!ASSERT_OK_PTR(tobj, "obj_open_mem")) /* shouldn't happen */
 		goto subtest_cleanup;
 
-	bpf_object__for_each_program(tprog, tobj)
-		bpf_program__set_autoload(tprog, false);
+	i = 0;
+	bpf_object__for_each_program(tprog_iter, tobj) {
+		spec_iter = &specs[i++];
+		should_load = false;
+
+		if (spec_iter->valid) {
+			if (strcmp(bpf_program__name(tprog_iter), spec->prog_name) == 0) {
+				tprog = tprog_iter;
+				should_load = true;
+			}
 
-	bpf_object__for_each_program(tprog, tobj) {
-		/* only load specified program */
-		if (strcmp(bpf_program__name(tprog), spec->prog_name) == 0) {
-			bpf_program__set_autoload(tprog, true);
-			break;
+			if (spec_iter->auxiliary &&
+			    spec_iter->mode_mask & (unpriv ? UNPRIV : PRIV))
+				should_load = true;
 		}
+
+		bpf_program__set_autoload(tprog_iter, should_load);
 	}
 
 	prepare_case(tester, spec, tobj, tprog);
@@ -617,11 +644,12 @@ static void process_subtest(struct test_loader *tester,
 			    skel_elf_bytes_fn elf_bytes_factory)
 {
 	LIBBPF_OPTS(bpf_object_open_opts, open_opts, .object_name = skel_name);
+	struct test_spec *specs = NULL;
 	struct bpf_object *obj = NULL;
 	struct bpf_program *prog;
 	const void *obj_bytes;
+	int err, i, nr_progs;
 	size_t obj_byte_cnt;
-	int err;
 
 	if (tester_init(tester) < 0)
 		return; /* failed to initialize tester */
@@ -631,25 +659,42 @@ static void process_subtest(struct test_loader *tester,
 	if (!ASSERT_OK_PTR(obj, "obj_open_mem"))
 		return;
 
-	bpf_object__for_each_program(prog, obj) {
-		struct test_spec spec;
+	nr_progs = 0;
+	bpf_object__for_each_program(prog, obj)
+		++nr_progs;
+
+	specs = calloc(nr_progs, sizeof(struct test_spec));
+	if (!ASSERT_OK_PTR(specs, "Can't alloc specs array"))
+		return;
 
-		/* if we can't derive test specification, go to the next test */
-		err = parse_test_spec(tester, obj, prog, &spec);
-		if (err) {
+	i = 0;
+	bpf_object__for_each_program(prog, obj) {
+		/* ignore tests for which  we can't derive test specification */
+		err = parse_test_spec(tester, obj, prog, &specs[i++]);
+		if (err)
 			PRINT_FAIL("Can't parse test spec for program '%s'\n",
 				   bpf_program__name(prog));
+	}
+
+	i = 0;
+	bpf_object__for_each_program(prog, obj) {
+		struct test_spec *spec = &specs[i++];
+
+		if (!spec->valid || spec->auxiliary)
 			continue;
-		}
 
-		if (spec.mode_mask & PRIV)
-			run_subtest(tester, &open_opts, obj_bytes, obj_byte_cnt, &spec, false);
-		if (spec.mode_mask & UNPRIV)
-			run_subtest(tester, &open_opts, obj_bytes, obj_byte_cnt, &spec, true);
+		if (spec->mode_mask & PRIV)
+			run_subtest(tester, &open_opts, obj_bytes, obj_byte_cnt,
+				    specs, spec, false);
+		if (spec->mode_mask & UNPRIV)
+			run_subtest(tester, &open_opts, obj_bytes, obj_byte_cnt,
+				    specs, spec, true);
 
-		free_test_spec(&spec);
 	}
 
+	for (i = 0; i < nr_progs; ++i)
+		free_test_spec(&specs[i]);
+	free(specs);
 	bpf_object__close(obj);
 }
 
-- 
2.40.0

