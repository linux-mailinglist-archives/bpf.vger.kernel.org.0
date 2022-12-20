Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23EC652831
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 22:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbiLTVDR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 16:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiLTVDQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 16:03:16 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181D912C
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 13:03:14 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id m21so8838941edc.3
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 13:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YYydSB6+iey2Nsx/7DVG35p90Yhmq2HJv6KE/4bsPmg=;
        b=TpmVAxbCWDonnhzuTffgMXHgT++1+3oocWcxi8mygGGYllpy/FRT/1Rk81PGIoNQ+x
         jgWcdQcUPQgE6Xo2Xw1SXqX8Tm17eQDXbthhGViQjKp6lfNJq3q7ZuzaUIz9mVv7Yhnw
         5qS4DWg9f4MJALmVYAFANQypcG62/nzT3+GRfJhutJf/rrhiSdRQtt6+ExXp0InDa4Rb
         zLR2e3Zc15CfIZYsHNf/UIVdL+lkwXrIkSotCLLG4IBRVIcGZv6kl+OtqVtWVjNNeqMB
         odmf3Tv5sqWH6YvsDhy2bt3K1LZndpeMvYYM+Njvn/NX95lVwMBn1g3CU7d58DVXrRIE
         Q88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YYydSB6+iey2Nsx/7DVG35p90Yhmq2HJv6KE/4bsPmg=;
        b=dedL4aMn7WvIbW39B8D7LA2XUSobQwRepoB3RY1aggs78+Z89378ApP8Q532RulsLP
         Rr7su5R1BHFDPCoTxtNlPqvjb7whDHgyX/9LpSqKtnisUoVyAjeJLTZn2ejCtfmJobYQ
         /qxpE1vAUq0QDxPhpDNnwr45IX5GReVMmxXu5Vi2JBeHeAtpltHbb8+hgZFgMmwKmZyn
         xt7Z82Oi1SoPe6MNOsuKVEqr9xgBuBASqMBuRLYDzygPv6MycxE3WvgXchAWkzEOfOki
         8yucBNqfftiaFgW8/hVlGuF3DQjeLwr+2X8kXJuoIHFiNpbr8KDRaZOZI6lUe6QkT3oV
         B+QA==
X-Gm-Message-State: ANoB5plDVnBhWOcuSqfXrSrCExk579gONzQYB7HmnfUrwnL41b+LjtwO
        syEXN4xInIuGIVNVZMEWdrINLLILU6ixl8alrRs=
X-Google-Smtp-Source: AA0mqf5o5Yt1jZhI/mT0Np/s7uxWNrhp3LVgl1M1zr/t8E+Q2NH6chfMidv5QQqMkiI7VBiOQtsswrD5M+3xA5RKJCE=
X-Received: by 2002:a50:ed90:0:b0:46a:e6e3:b3cf with SMTP id
 h16-20020a50ed90000000b0046ae6e3b3cfmr52074169edr.333.1671570192418; Tue, 20
 Dec 2022 13:03:12 -0800 (PST)
MIME-Version: 1.0
References: <20221217021711.172247-1-eddyz87@gmail.com> <20221217021711.172247-2-eddyz87@gmail.com>
In-Reply-To: <20221217021711.172247-2-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 20 Dec 2022 13:03:00 -0800
Message-ID: <CAEf4BzZH0ZxorCi7nPDbRqSK9f+410RooNwNJGwfw8=0a5i1nw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] selftests/bpf: support for
 BPF_F_TEST_STATE_FREQ in test_loader
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 16, 2022 at 6:17 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Adds a macro __test_state_freq, the macro expands as a btf_decl_tag of a
> special form that instructs test_loader that the flag BPF_F_TEST_STATE_FREQ
> has to be passed to BPF verifier when program is loaded.
>

I needed similar capabilities locally, but I went a slightly different
direction. Instead of defining custom macros and logic, I define just
__flags(X) macro and then parse flags either by their symbolic name
(or just integer value, which might be useful sometimes for
development purposes). I've also added support for matching multiple
messages sequentially which locally is in the same commit. Feel free
to ignore that part, but I think it's useful as well. So WDYT about
the below?


commit 936bb5d21d717d54c85e74047e082ca3216a7a40
Author: Andrii Nakryiko <andrii@kernel.org>
Date:   Mon Dec 19 15:57:26 2022 -0800

    selftests/bpf: support custom per-test flags and multiple expected messages

    Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

diff --git a/tools/testing/selftests/bpf/test_loader.c
b/tools/testing/selftests/bpf/test_loader.c
index 679efb3aa785..b0dab5dee38c 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -13,12 +13,15 @@
 #define TEST_TAG_EXPECT_SUCCESS "comment:test_expect_success"
 #define TEST_TAG_EXPECT_MSG_PFX "comment:test_expect_msg="
 #define TEST_TAG_LOG_LEVEL_PFX "comment:test_log_level="
+#define TEST_TAG_PROG_FLAGS_PFX "comment:test_prog_flags="

 struct test_spec {
     const char *name;
     bool expect_failure;
-    const char *expect_msg;
+    const char **expect_msgs;
+    size_t expect_msg_cnt;
     int log_level;
+    int prog_flags;
 };

 static int tester_init(struct test_loader *tester)
@@ -67,7 +70,8 @@ static int parse_test_spec(struct test_loader *tester,

     for (i = 1; i < btf__type_cnt(btf); i++) {
         const struct btf_type *t;
-        const char *s;
+        const char *s, *val;
+        char *e;

         t = btf__type_by_id(btf, i);
         if (!btf_is_decl_tag(t))
@@ -82,14 +86,47 @@ static int parse_test_spec(struct test_loader *tester,
         } else if (strcmp(s, TEST_TAG_EXPECT_SUCCESS) == 0) {
             spec->expect_failure = false;
         } else if (str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX)) {
-            spec->expect_msg = s + sizeof(TEST_TAG_EXPECT_MSG_PFX) - 1;
+            void *tmp;
+            const char **msg;
+
+            tmp = realloc(spec->expect_msgs, (1 +
spec->expect_msg_cnt) * sizeof(void *));
+            if (!tmp) {
+                ASSERT_FAIL("failed to realloc memory for messages\n");
+                return -ENOMEM;
+            }
+            spec->expect_msgs = tmp;
+            msg = &spec->expect_msgs[spec->expect_msg_cnt++];
+            *msg = s + sizeof(TEST_TAG_EXPECT_MSG_PFX) - 1;
         } else if (str_has_pfx(s, TEST_TAG_LOG_LEVEL_PFX)) {
+            val = s + sizeof(TEST_TAG_LOG_LEVEL_PFX) - 1;
             errno = 0;
-            spec->log_level = strtol(s +
sizeof(TEST_TAG_LOG_LEVEL_PFX) - 1, NULL, 0);
-            if (errno) {
+            spec->log_level = strtol(val, &e, 0);
+            if (errno || e[0] != '\0') {
                 ASSERT_FAIL("failed to parse test log level from '%s'", s);
                 return -EINVAL;
             }
+        } else if (str_has_pfx(s, TEST_TAG_PROG_FLAGS_PFX)) {
+            val = s + sizeof(TEST_TAG_PROG_FLAGS_PFX) - 1;
+            if (strcmp(val, "BPF_F_STRICT_ALIGNMENT") == 0) {
+                spec->prog_flags |= BPF_F_STRICT_ALIGNMENT;
+            } else if (strcmp(val, "BPF_F_ANY_ALIGNMENT") == 0) {
+                spec->prog_flags |= BPF_F_ANY_ALIGNMENT;
+            } else if (strcmp(val, "BPF_F_TEST_RND_HI32") == 0) {
+                spec->prog_flags |= BPF_F_TEST_RND_HI32;
+            } else if (strcmp(val, "BPF_F_TEST_STATE_FREQ") == 0) {
+                spec->prog_flags |= BPF_F_TEST_STATE_FREQ;
+            } else if (strcmp(val, "BPF_F_SLEEPABLE") == 0) {
+                spec->prog_flags |= BPF_F_SLEEPABLE;
+            } else if (strcmp(val, "BPF_F_XDP_HAS_FRAGS") == 0) {
+                spec->prog_flags |= BPF_F_XDP_HAS_FRAGS;
+            } else /* assume numeric value */ {
+                errno = 0;
+                spec->prog_flags |= strtol(val, &e, 0);
+                if (errno || e[0] != '\0') {
+                    ASSERT_FAIL("failed to parse test prog flags from
'%s'", s);
+                    return -EINVAL;
+                }
+            }
         }
     }

@@ -101,7 +138,7 @@ static void prepare_case(struct test_loader *tester,
              struct bpf_object *obj,
              struct bpf_program *prog)
 {
-    int min_log_level = 0;
+    int min_log_level = 0, prog_flags;

     if (env.verbosity > VERBOSE_NONE)
         min_log_level = 1;
@@ -119,7 +156,11 @@ static void prepare_case(struct test_loader *tester,
     else
         bpf_program__set_log_level(prog, spec->log_level);

+    prog_flags = bpf_program__flags(prog);
+    bpf_program__set_flags(prog, prog_flags | spec->prog_flags);
+
     tester->log_buf[0] = '\0';
+    tester->next_match_pos = 0;
 }

 static void emit_verifier_log(const char *log_buf, bool force)
@@ -135,17 +176,26 @@ static void validate_case(struct test_loader *tester,
               struct bpf_program *prog,
               int load_err)
 {
-    if (spec->expect_msg) {
+    int i, j;
+
+    for (i = 0; i < spec->expect_msg_cnt; i++) {
         char *match;
+        const char *expect_msg;
+
+        expect_msg = spec->expect_msgs[i];

-        match = strstr(tester->log_buf, spec->expect_msg);
+        match = strstr(tester->log_buf + tester->next_match_pos, expect_msg);
         if (!ASSERT_OK_PTR(match, "expect_msg")) {
             /* if we are in verbose mode, we've already emitted log */
             if (env.verbosity == VERBOSE_NONE)
                 emit_verifier_log(tester->log_buf, true /*force*/);
-            fprintf(stderr, "EXPECTED MSG: '%s'\n", spec->expect_msg);
+            for (j = 0; j < i; j++)
+                fprintf(stderr, "MATCHED  MSG: '%s'\n", spec->expect_msgs[j]);
+            fprintf(stderr, "EXPECTED MSG: '%s'\n", expect_msg);
             return;
         }
+
+        tester->next_match_pos = match - tester->log_buf + strlen(expect_msg);
     }
 }

diff --git a/tools/testing/selftests/bpf/test_progs.h
b/tools/testing/selftests/bpf/test_progs.h
index 3f058dfadbaf..9af80704f20a 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -410,6 +410,7 @@ int write_sysctl(const char *sysctl, const char *value);
 struct test_loader {
     char *log_buf;
     size_t log_buf_sz;
+    size_t next_match_pos;

     struct bpf_object *obj;
 };




> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/testing/selftests/bpf/progs/bpf_misc.h |  1 +
>  tools/testing/selftests/bpf/test_loader.c    | 10 ++++++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
> index 4a01ea9113bf..a42363a3fef1 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -6,6 +6,7 @@
>  #define __failure              __attribute__((btf_decl_tag("comment:test_expect_failure")))
>  #define __success              __attribute__((btf_decl_tag("comment:test_expect_success")))
>  #define __log_level(lvl)       __attribute__((btf_decl_tag("comment:test_log_level="#lvl)))
> +#define __test_state_freq      __attribute__((btf_decl_tag("comment:test_state_freq")))
>
>  #if defined(__TARGET_ARCH_x86)
>  #define SYSCALL_WRAPPER 1
> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
> index 679efb3aa785..ac8517a77161 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -11,6 +11,7 @@
>
>  #define TEST_TAG_EXPECT_FAILURE "comment:test_expect_failure"
>  #define TEST_TAG_EXPECT_SUCCESS "comment:test_expect_success"
> +#define TEST_TAG_TEST_STATE_FREQ "comment:test_state_freq"
>  #define TEST_TAG_EXPECT_MSG_PFX "comment:test_expect_msg="
>  #define TEST_TAG_LOG_LEVEL_PFX "comment:test_log_level="
>
> @@ -19,6 +20,7 @@ struct test_spec {
>         bool expect_failure;
>         const char *expect_msg;
>         int log_level;
> +       bool test_state_freq;
>  };
>
>  static int tester_init(struct test_loader *tester)
> @@ -81,6 +83,8 @@ static int parse_test_spec(struct test_loader *tester,
>                         spec->expect_failure = true;
>                 } else if (strcmp(s, TEST_TAG_EXPECT_SUCCESS) == 0) {
>                         spec->expect_failure = false;
> +               } else if (strcmp(s, TEST_TAG_TEST_STATE_FREQ) == 0) {
> +                       spec->test_state_freq = true;
>                 } else if (str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX)) {
>                         spec->expect_msg = s + sizeof(TEST_TAG_EXPECT_MSG_PFX) - 1;
>                 } else if (str_has_pfx(s, TEST_TAG_LOG_LEVEL_PFX)) {
> @@ -102,6 +106,7 @@ static void prepare_case(struct test_loader *tester,
>                          struct bpf_program *prog)
>  {
>         int min_log_level = 0;
> +       __u32 flags = 0;
>
>         if (env.verbosity > VERBOSE_NONE)
>                 min_log_level = 1;
> @@ -120,6 +125,11 @@ static void prepare_case(struct test_loader *tester,
>                 bpf_program__set_log_level(prog, spec->log_level);
>
>         tester->log_buf[0] = '\0';
> +
> +       if (spec->test_state_freq)
> +               flags |= BPF_F_TEST_STATE_FREQ;
> +
> +       bpf_program__set_flags(prog, flags);

see my example above, it's safer to fetch current prog flags to not
override stuff like BPF_F_SLEEPABLE

>  }
>
>  static void emit_verifier_log(const char *log_buf, bool force)
> --
> 2.38.2
>
