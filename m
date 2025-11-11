Return-Path: <bpf+bounces-74132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20164C4B52D
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 04:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF40F3A987C
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 03:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FFB3491F2;
	Tue, 11 Nov 2025 03:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdND3W7h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2812E54A3
	for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 03:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762831776; cv=none; b=ZKScmzqekB7YFCAQ1g2Zb5I56p1zr1e18O6y0k3exEVVDnVLVX8f6hlRVMeWSZYsCj4niwyi7KRxZGlLZJo0YhTHDj56ej1w7SZSRCjk5t2qcoKcxesKAM3jprumhioYfQzprwxlhZpz3+IGX+MYjQknzy4COIuE+Q780i2H3TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762831776; c=relaxed/simple;
	bh=nTivBjp6QyVyDCBLPMP/oQ8ew3xUvE7EL2sXOp9SrCU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uHNQX1yuVUjXmRx/YQxSqZr3dJn8Pvpw8Q3nADjadguz4WF0FNBa8tp7Mll5kclWyboDBU+i3pKpKP2QBTXZT4/MqJXysxK9gaxeNTfiOIG9kaAejWuIX2vfBbg1g/7pNVFb2YRmVNrc8CKI0xM5wLFcU3TUhBtgp/+kN5mVtYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdND3W7h; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b550eff972eso2197521a12.3
        for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 19:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762831774; x=1763436574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HWhsd7IoYV35d1eOubDw5zFQuXdGmCOfKoKZZB6pydM=;
        b=CdND3W7hRcn38Wjbz/tQ/mpdRPBnaX4TQDmUM36OV1iTNNmiH02cxITbfrX0v1peAE
         1jupCiH5OiaEtfScKXDmv8+teN++Iyd9neEYPOtliUcT1Q37+2tmqvlxs+3MdmcyeTxG
         +8a+KQ24cFDE3O0ohDcw3gwyORka7KTHMVUsyhY87TM3SLMVi20iPXkD3Q9hR1JBuE3D
         9+w4XQ5XDn+xeAenM7CifPjGXyg9kPnqyZnTsXhlHdnAbsKG6LwcvrjL94GTHTi71841
         bbfDGlZD/S9+fob+/ccugp5G6OzCua6BLniPYSsFl1tcE7FDFv4h+J+gNWYo/VKIlumx
         qZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762831774; x=1763436574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWhsd7IoYV35d1eOubDw5zFQuXdGmCOfKoKZZB6pydM=;
        b=cDw0U0TrXLNWFdCGqB0GR5MN8jmVvQTr+9M1OekN19jfKSkqRAX/ugMFPu9L9U3xj/
         5N9FsUEsrAtOc9E9fPc8uPEMm76xPBGhNKtMD799ztj3p90oSpvbO3Q3MexndIEo9qs3
         OzeDFHZX67JO181eWI1vipKV+5BCq0EPM+5omatj5vIso0gAeffecNDl6N0K6OmMmOIB
         TmHHMGLaYlU7zQWKCduehvcFKNIcYbee4xfRgKX9315zrGOXQ2DgOIYj17tt/BpMRYrA
         +A+7CGOPIZyPJZDntC3Ol0om5+LK52fMR4Udx2u64eS58zV+67DF/uivVcsXeOSHae/x
         DZUA==
X-Gm-Message-State: AOJu0YyERbz2y2dIwzbiSUF04b7hEtENI5eaFAGPH1dxqIbW0Qt7BFa+
	Ulb4DzkOSAoeEb7CNpSixgmr88NrAVcCvp4Jl7xU0CiWwB9bJPSq8x7JRfwsJg==
X-Gm-Gg: ASbGnctA88fbZh75AVZReI7pJtwqZP0xE926aASMOTK+lHdet/NGORLmb9lrUEkc3FJ
	aXn8dg3hcZuuXBPgOhmYi/j9zUSzJHqkU3WjGOaznHV1AaOKRBoLmM4HihXWvDG8tOnayMim2u0
	z3lCbI4THHzuqbkdwv7EZMlr8ZSH3ZzCgs4EQegys+LzoURMEBgJDyUoSrKhaAHrPBKMK+6taHc
	DI85yPe8S4DablPpvyh81oNU5+HUfvhkGcXZBhtcKWqIvD+3JM2TPOsmuCTPW/hptYIhFJ7pNON
	J9OsfMr7aNqzY0otT2WnkXCYara4IWUqy+ylnqCyicter/ftvIG62Tai+O4CEbzWjvSJCG4d3y7
	/KBskOFCWpHVwIPDEeHZp18OdQpA0P0BRCLoyWeHfL+cKsrR5tGNXav9VeUHI2NKraWTNeaITc+
	D78BsNHOb0oxykIJ3iOMPqlcPa2fZXtK7OHKHr1cvlMEip
X-Google-Smtp-Source: AGHT+IFnK5yOXwxnKDfm5OkC1/hrfcgjOQqyynEgP1KifetAlx3O+lgOsFaXdbW0G+0OuiwQ/eaeDw==
X-Received: by 2002:a17:902:fc8f:b0:295:ceaf:8d76 with SMTP id d9443c01a7336-297e56f89cemr128824635ad.47.1762831773361;
        Mon, 10 Nov 2025 19:29:33 -0800 (PST)
Received: from localhost.localdomain ([2603:3023:126:8500:1c82:6ab4:808c:1834])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c92cddsm165860235ad.83.2025.11.10.19.29.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Nov 2025 19:29:32 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org
Subject: [PATCH bpf-next] selftests/bpf: Convert glob_match() to bpf arena
Date: Mon, 10 Nov 2025 19:29:31 -0800
Message-Id: <20251111032931.21430-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Increase arena test coverage.
Convert glob_match() to bpf arena in two steps:
1.
Copy paste lib/glob.c into bpf_arena_strsearch.h
Copy paste lib/globtests.c into progs/arena_strsearch.c

2.
Add __arena to pointers
Add __arg_arena to global functions that accept arena pointers
Add cond_break to loops

The test also serves as a good example of what's possible
with bpf arena and how existing algorithms can be converted.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/bpf_arena_strsearch.h       | 128 +++++++++++++++
 .../bpf/prog_tests/arena_strsearch.c          |  30 ++++
 .../selftests/bpf/progs/arena_strsearch.c     | 146 ++++++++++++++++++
 3 files changed, 304 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_strsearch.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_strsearch.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_strsearch.c

diff --git a/tools/testing/selftests/bpf/bpf_arena_strsearch.h b/tools/testing/selftests/bpf/bpf_arena_strsearch.h
new file mode 100644
index 000000000000..c1b6eaa905bb
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_arena_strsearch.h
@@ -0,0 +1,128 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#pragma once
+#include "bpf_arena_common.h"
+
+__noinline int bpf_arena_strlen(const char __arena *s __arg_arena)
+{
+	const char __arena *sc;
+
+	for (sc = s; *sc != '\0'; ++sc)
+		cond_break;
+	return sc - s;
+}
+
+/**
+ * glob_match - Shell-style pattern matching, like !fnmatch(pat, str, 0)
+ * @pat: Shell-style pattern to match, e.g. "*.[ch]".
+ * @str: String to match.  The pattern must match the entire string.
+ *
+ * Perform shell-style glob matching, returning true (1) if the match
+ * succeeds, or false (0) if it fails.  Equivalent to !fnmatch(@pat, @str, 0).
+ *
+ * Pattern metacharacters are ?, *, [ and \.
+ * (And, inside character classes, !, - and ].)
+ *
+ * This is small and simple implementation intended for device blacklists
+ * where a string is matched against a number of patterns.  Thus, it
+ * does not preprocess the patterns.  It is non-recursive, and run-time
+ * is at most quadratic: strlen(@str)*strlen(@pat).
+ *
+ * An example of the worst case is glob_match("*aaaaa", "aaaaaaaaaa");
+ * it takes 6 passes over the pattern before matching the string.
+ *
+ * Like !fnmatch(@pat, @str, 0) and unlike the shell, this does NOT
+ * treat / or leading . specially; it isn't actually used for pathnames.
+ *
+ * Note that according to glob(7) (and unlike bash), character classes
+ * are complemented by a leading !; this does not support the regex-style
+ * [^a-z] syntax.
+ *
+ * An opening bracket without a matching close is matched literally.
+ */
+__noinline bool glob_match(char const __arena *pat __arg_arena, char const __arena *str __arg_arena)
+{
+	/*
+	 * Backtrack to previous * on mismatch and retry starting one
+	 * character later in the string.  Because * matches all characters
+	 * (no exception for /), it can be easily proved that there's
+	 * never a need to backtrack multiple levels.
+	 */
+	char const __arena *back_pat = NULL, *back_str;
+
+	/*
+	 * Loop over each token (character or class) in pat, matching
+	 * it against the remaining unmatched tail of str.  Return false
+	 * on mismatch, or true after matching the trailing nul bytes.
+	 */
+	for (;;) {
+		unsigned char c = *str++;
+		unsigned char d = *pat++;
+
+		switch (d) {
+		case '?':	/* Wildcard: anything but nul */
+			if (c == '\0')
+				return false;
+			break;
+		case '*':	/* Any-length wildcard */
+			if (*pat == '\0')	/* Optimize trailing * case */
+				return true;
+			back_pat = pat;
+			back_str = --str;	/* Allow zero-length match */
+			break;
+		case '[': {	/* Character class */
+			bool match = false, inverted = (*pat == '!');
+			char const __arena *class = pat + inverted;
+			unsigned char a = *class++;
+
+			/*
+			 * Iterate over each span in the character class.
+			 * A span is either a single character a, or a
+			 * range a-b.  The first span may begin with ']'.
+			 */
+			do {
+				unsigned char b = a;
+
+				if (a == '\0')	/* Malformed */
+					goto literal;
+
+				if (class[0] == '-' && class[1] != ']') {
+					b = class[1];
+
+					if (b == '\0')
+						goto literal;
+
+					class += 2;
+					/* Any special action if a > b? */
+				}
+				match |= (a <= c && c <= b);
+				cond_break;
+			} while ((a = *class++) != ']');
+
+			if (match == inverted)
+				goto backtrack;
+			pat = class;
+			}
+			break;
+		case '\\':
+			d = *pat++;
+			__attribute__((__fallthrough__));
+		default:	/* Literal character */
+literal:
+			if (c == d) {
+				if (d == '\0')
+					return true;
+				break;
+			}
+backtrack:
+			if (c == '\0' || !back_pat)
+				return false;	/* No point continuing */
+			/* Try again from last *, one character later in str. */
+			pat = back_pat;
+			str = ++back_str;
+			break;
+		}
+		cond_break;
+	}
+	return false;
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/arena_strsearch.c b/tools/testing/selftests/bpf/prog_tests/arena_strsearch.c
new file mode 100644
index 000000000000..f81a0c066505
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_strsearch.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include "arena_strsearch.skel.h"
+
+static void test_arena_str(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct arena_strsearch *skel;
+	int ret;
+
+	skel = arena_strsearch__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "arena_strsearch__open_and_load"))
+		return;
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arena_strsearch), &opts);
+	ASSERT_OK(ret, "ret_add");
+	ASSERT_OK(opts.retval, "retval");
+	if (skel->bss->skip) {
+		printf("%s:SKIP:compiler doesn't support arena_cast\n", __func__);
+		test__skip();
+	}
+	arena_strsearch__destroy(skel);
+}
+
+void test_arena_strsearch(void)
+{
+	if (test__start_subtest("arena_strsearch"))
+		test_arena_str();
+}
diff --git a/tools/testing/selftests/bpf/progs/arena_strsearch.c b/tools/testing/selftests/bpf/progs/arena_strsearch.c
new file mode 100644
index 000000000000..b01f73b938ce
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_strsearch.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include "bpf_experimental.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 100); /* number of pages */
+} arena SEC(".maps");
+
+#include "bpf_arena_strsearch.h"
+
+struct glob_test {
+	char const __arena *pat, *str;
+	bool expected;
+};
+
+static bool test(char const __arena *pat, char const __arena *str, bool expected)
+{
+	bool match = glob_match(pat, str);
+	bool success = match == expected;
+
+/*	bpf_printk("glob_match %s %s res %d ok %d", pat, str, match, success);*/
+	return success;
+}
+
+/*
+ * The tests are all jammed together in one array to make it simpler
+ * to place that array in the .init.rodata section.  The obvious
+ * "array of structures containing char *" has no way to force the
+ * pointed-to strings to be in a particular section.
+ *
+ * Anyway, a test consists of:
+ * 1. Expected glob_match result: '1' or '0'.
+ * 2. Pattern to match: null-terminated string
+ * 3. String to match against: null-terminated string
+ *
+ * The list of tests is terminated with a final '\0' instead of
+ * a glob_match result character.
+ */
+static const char __arena glob_tests[] =
+	/* Some basic tests */
+	"1" "a\0" "a\0"
+	"0" "a\0" "b\0"
+	"0" "a\0" "aa\0"
+	"0" "a\0" "\0"
+	"1" "\0" "\0"
+	"0" "\0" "a\0"
+	/* Simple character class tests */
+	"1" "[a]\0" "a\0"
+	"0" "[a]\0" "b\0"
+	"0" "[!a]\0" "a\0"
+	"1" "[!a]\0" "b\0"
+	"1" "[ab]\0" "a\0"
+	"1" "[ab]\0" "b\0"
+	"0" "[ab]\0" "c\0"
+	"1" "[!ab]\0" "c\0"
+	"1" "[a-c]\0" "b\0"
+	"0" "[a-c]\0" "d\0"
+	/* Corner cases in character class parsing */
+	"1" "[a-c-e-g]\0" "-\0"
+	"0" "[a-c-e-g]\0" "d\0"
+	"1" "[a-c-e-g]\0" "f\0"
+	"1" "[]a-ceg-ik[]\0" "a\0"
+	"1" "[]a-ceg-ik[]\0" "]\0"
+	"1" "[]a-ceg-ik[]\0" "[\0"
+	"1" "[]a-ceg-ik[]\0" "h\0"
+	"0" "[]a-ceg-ik[]\0" "f\0"
+	"0" "[!]a-ceg-ik[]\0" "h\0"
+	"0" "[!]a-ceg-ik[]\0" "]\0"
+	"1" "[!]a-ceg-ik[]\0" "f\0"
+	/* Simple wild cards */
+	"1" "?\0" "a\0"
+	"0" "?\0" "aa\0"
+	"0" "??\0" "a\0"
+	"1" "?x?\0" "axb\0"
+	"0" "?x?\0" "abx\0"
+	"0" "?x?\0" "xab\0"
+	/* Asterisk wild cards (backtracking) */
+	"0" "*??\0" "a\0"
+	"1" "*??\0" "ab\0"
+	"1" "*??\0" "abc\0"
+	"1" "*??\0" "abcd\0"
+	"0" "??*\0" "a\0"
+	"1" "??*\0" "ab\0"
+	"1" "??*\0" "abc\0"
+	"1" "??*\0" "abcd\0"
+	"0" "?*?\0" "a\0"
+	"1" "?*?\0" "ab\0"
+	"1" "?*?\0" "abc\0"
+	"1" "?*?\0" "abcd\0"
+	"1" "*b\0" "b\0"
+	"1" "*b\0" "ab\0"
+	"0" "*b\0" "ba\0"
+	"1" "*b\0" "bb\0"
+	"1" "*b\0" "abb\0"
+	"1" "*b\0" "bab\0"
+	"1" "*bc\0" "abbc\0"
+	"1" "*bc\0" "bc\0"
+	"1" "*bc\0" "bbc\0"
+	"1" "*bc\0" "bcbc\0"
+	/* Multiple asterisks (complex backtracking) */
+	"1" "*ac*\0" "abacadaeafag\0"
+	"1" "*ac*ae*ag*\0" "abacadaeafag\0"
+	"1" "*a*b*[bc]*[ef]*g*\0" "abacadaeafag\0"
+	"0" "*a*b*[ef]*[cd]*g*\0" "abacadaeafag\0"
+	"1" "*abcd*\0" "abcabcabcabcdefg\0"
+	"1" "*ab*cd*\0" "abcabcabcabcdefg\0"
+	"1" "*abcd*abcdef*\0" "abcabcdabcdeabcdefg\0"
+	"0" "*abcd*\0" "abcabcabcabcefg\0"
+	"0" "*ab*cd*\0" "abcabcabcabcefg\0";
+
+bool skip = false;
+
+SEC("syscall")
+int arena_strsearch(void *ctx)
+{
+	unsigned successes = 0;
+	unsigned n = 0;
+	char const __arena *p = glob_tests;
+
+	/*
+	 * Tests are jammed together in a string.  The first byte is '1'
+	 * or '0' to indicate the expected outcome, or '\0' to indicate the
+	 * end of the tests.  Then come two null-terminated strings: the
+	 * pattern and the string to match it against.
+	 */
+	while (*p) {
+		bool expected = *p++ & 1;
+		char const __arena *pat = p;
+
+		cond_break;
+		p += bpf_arena_strlen(p) + 1;
+		successes += test(pat, p, expected);
+		p += bpf_arena_strlen(p) + 1;
+		n++;
+	}
+
+	n -= successes;
+/*	bpf_printk("glob: %u self-tests passed, %u failed\n", successes, n);*/
+
+	return n ? -1 : 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.3


