Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705171B340A
	for <lists+bpf@lfdr.de>; Wed, 22 Apr 2020 02:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgDVAh5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Apr 2020 20:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgDVAh5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Apr 2020 20:37:57 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FB9C0610D5
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2020 17:37:56 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id f11so863582qkk.16
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2020 17:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1BrRYo+96Cv/JrFZbPvJV2ENqhE9dtp0nSEuMgbSQkQ=;
        b=dfTf8cY1rflgEMK+6VegOrQLECkYzWyPJgQo8Cr/jLkKJ7Edly28gwqUP4WPaIOKH6
         HgURW/boPMJzzBZDoA9ZYKilb17dcMLSdv/OowopVy1WS97hTDqLaEn09GOOvSrr97iV
         b0r/E+uJovR8ZNrC+GZeotliH7c/dvwHD5ONa+NwYbqsbvpR+PKdnMpm/rJrbzWpt0Ut
         BO0Hnc6/Xs67TKQBiXA8Bk3c/nLZsx0jcoXTUyBFOIZKek/6Q2VRF0A3P3TxWlXStxUd
         +c7wBfEQbHVcm4tUuLnpIV7qTHdR6/lpKyNTpn3N6OSYu7AWgjzoDepWr3rlnoR2lDSt
         3kIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1BrRYo+96Cv/JrFZbPvJV2ENqhE9dtp0nSEuMgbSQkQ=;
        b=X20lecEqflZ/1qbREYwUyyTIm0sMKvBa3gmjPwq3bQ3Iaqibo/sWc8XWaqdBJr4eTd
         Y2wNol0Q5aswJ54OZcXGuRFnstSDDWRh48IP9cwvFR3T+uwTxwKXOnQOtF6+mU8u23+w
         tJ95h23BlH4aND2Xp7/xX3peyO8V8XcjDb6uzC6/+obSZ56S86Z+2qFd/bOsslB6DfpW
         bHj56diaAlza3W6EY/3WQiEiFlQIhXEqkjawO9tihQSLL5LJX5FfPeAW1QHqJdMwcSyh
         s6aeWYt8wkEBPlp7QFzX0wNGuO5z3Y7qoQaVHaqFMQ8icj8Qn7jMw2UT5XycludKurw/
         dWtw==
X-Gm-Message-State: AGi0PuaHV1vL9D5q6voS3sYZxNVtyajCK4kQ7IlkzBg+4tvWOGApQXW4
        ifDKgqF+Wnvv2cCbMT2FNxFj8mE=
X-Google-Smtp-Source: APiQypJcpVWz/74werdqSCEawvRSVe7Vio1SPu9EF2xlsLpHHbZ7b1/Vlmn9uTRrsVNuc9b/19qfyGI=
X-Received: by 2002:ac8:6f6c:: with SMTP id u12mr23727526qtv.103.1587515875944;
 Tue, 21 Apr 2020 17:37:55 -0700 (PDT)
Date:   Tue, 21 Apr 2020 17:37:53 -0700
Message-Id: <20200422003753.124921-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH bpf-next] selftests/bpf: fix a couple of broken test_btf cases
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 51c39bb1d5d1 ("bpf: Introduce function-by-function verification")
introduced function linkage flag and changed the error message from
"vlen != 0" to "Invalid func linkage" and broke some fake BPF programs.

Adjust the test accordingly.

AFACT, the programs don't really need any arguments and only look
at BTF for maps, so let's drop the args altogether.

Before:
BTF raw test[103] (func (Non zero vlen)): do_test_raw:3703:FAIL expected
err_str:vlen != 0
magic: 0xeb9f
version: 1
flags: 0x0
hdr_len: 24
type_off: 0
type_len: 72
str_off: 72
str_len: 10
btf_total_size: 106
[1] INT (anon) size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
[2] INT (anon) size=4 bits_offset=0 nr_bits=32 encoding=(none)
[3] FUNC_PROTO (anon) return=0 args=(1 a, 2 b)
[4] FUNC func type_id=3 Invalid func linkage

BTF libbpf test[1] (test_btf_haskv.o): libbpf: load bpf program failed:
Invalid argument
libbpf: -- BEGIN DUMP LOG ---
libbpf:
Validating test_long_fname_2() func#1...
Arg#0 type PTR in test_long_fname_2() is not supported yet.
processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0
peak_states 0 mark_read 0

libbpf: -- END LOG --
libbpf: failed to load program 'dummy_tracepoint'
libbpf: failed to load object 'test_btf_haskv.o'
do_test_file:4201:FAIL bpf_object__load: -4007
BTF libbpf test[2] (test_btf_newkv.o): libbpf: load bpf program failed:
Invalid argument
libbpf: -- BEGIN DUMP LOG ---
libbpf:
Validating test_long_fname_2() func#1...
Arg#0 type PTR in test_long_fname_2() is not supported yet.
processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0
peak_states 0 mark_read 0

libbpf: -- END LOG --
libbpf: failed to load program 'dummy_tracepoint'
libbpf: failed to load object 'test_btf_newkv.o'
do_test_file:4201:FAIL bpf_object__load: -4007
BTF libbpf test[3] (test_btf_nokv.o): libbpf: load bpf program failed:
Invalid argument
libbpf: -- BEGIN DUMP LOG ---
libbpf:
Validating test_long_fname_2() func#1...
Arg#0 type PTR in test_long_fname_2() is not supported yet.
processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0
peak_states 0 mark_read 0

libbpf: -- END LOG --
libbpf: failed to load program 'dummy_tracepoint'
libbpf: failed to load object 'test_btf_nokv.o'
do_test_file:4201:FAIL bpf_object__load: -4007

Fixes: 51c39bb1d5d1 ("bpf: Introduce function-by-function verification")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/progs/test_btf_haskv.c       | 18 +++++-------------
 .../selftests/bpf/progs/test_btf_newkv.c       | 18 +++++-------------
 .../selftests/bpf/progs/test_btf_nokv.c        | 18 +++++-------------
 tools/testing/selftests/bpf/test_btf.c         |  2 +-
 4 files changed, 16 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_btf_haskv.c b/tools/testing/selftests/bpf/progs/test_btf_haskv.c
index 88b0566da13d..31538c9ed193 100644
--- a/tools/testing/selftests/bpf/progs/test_btf_haskv.c
+++ b/tools/testing/selftests/bpf/progs/test_btf_haskv.c
@@ -20,20 +20,12 @@ struct bpf_map_def SEC("maps") btf_map = {
 
 BPF_ANNOTATE_KV_PAIR(btf_map, int, struct ipv_counts);
 
-struct dummy_tracepoint_args {
-	unsigned long long pad;
-	struct sock *sock;
-};
-
 __attribute__((noinline))
-int test_long_fname_2(struct dummy_tracepoint_args *arg)
+int test_long_fname_2(void)
 {
 	struct ipv_counts *counts;
 	int key = 0;
 
-	if (!arg->sock)
-		return 0;
-
 	counts = bpf_map_lookup_elem(&btf_map, &key);
 	if (!counts)
 		return 0;
@@ -44,15 +36,15 @@ int test_long_fname_2(struct dummy_tracepoint_args *arg)
 }
 
 __attribute__((noinline))
-int test_long_fname_1(struct dummy_tracepoint_args *arg)
+int test_long_fname_1(void)
 {
-	return test_long_fname_2(arg);
+	return test_long_fname_2();
 }
 
 SEC("dummy_tracepoint")
-int _dummy_tracepoint(struct dummy_tracepoint_args *arg)
+int _dummy_tracepoint(void *arg)
 {
-	return test_long_fname_1(arg);
+	return test_long_fname_1();
 }
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_btf_newkv.c b/tools/testing/selftests/bpf/progs/test_btf_newkv.c
index a924e53c8e9d..6c5560162746 100644
--- a/tools/testing/selftests/bpf/progs/test_btf_newkv.c
+++ b/tools/testing/selftests/bpf/progs/test_btf_newkv.c
@@ -28,20 +28,12 @@ struct {
 	__type(value, struct ipv_counts);
 } btf_map SEC(".maps");
 
-struct dummy_tracepoint_args {
-	unsigned long long pad;
-	struct sock *sock;
-};
-
 __attribute__((noinline))
-int test_long_fname_2(struct dummy_tracepoint_args *arg)
+int test_long_fname_2(void)
 {
 	struct ipv_counts *counts;
 	int key = 0;
 
-	if (!arg->sock)
-		return 0;
-
 	counts = bpf_map_lookup_elem(&btf_map, &key);
 	if (!counts)
 		return 0;
@@ -57,15 +49,15 @@ int test_long_fname_2(struct dummy_tracepoint_args *arg)
 }
 
 __attribute__((noinline))
-int test_long_fname_1(struct dummy_tracepoint_args *arg)
+int test_long_fname_1(void)
 {
-	return test_long_fname_2(arg);
+	return test_long_fname_2();
 }
 
 SEC("dummy_tracepoint")
-int _dummy_tracepoint(struct dummy_tracepoint_args *arg)
+int _dummy_tracepoint(void *arg)
 {
-	return test_long_fname_1(arg);
+	return test_long_fname_1();
 }
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_btf_nokv.c b/tools/testing/selftests/bpf/progs/test_btf_nokv.c
index 983aedd1c072..506da7fd2da2 100644
--- a/tools/testing/selftests/bpf/progs/test_btf_nokv.c
+++ b/tools/testing/selftests/bpf/progs/test_btf_nokv.c
@@ -17,20 +17,12 @@ struct bpf_map_def SEC("maps") btf_map = {
 	.max_entries = 4,
 };
 
-struct dummy_tracepoint_args {
-	unsigned long long pad;
-	struct sock *sock;
-};
-
 __attribute__((noinline))
-int test_long_fname_2(struct dummy_tracepoint_args *arg)
+int test_long_fname_2(void)
 {
 	struct ipv_counts *counts;
 	int key = 0;
 
-	if (!arg->sock)
-		return 0;
-
 	counts = bpf_map_lookup_elem(&btf_map, &key);
 	if (!counts)
 		return 0;
@@ -41,15 +33,15 @@ int test_long_fname_2(struct dummy_tracepoint_args *arg)
 }
 
 __attribute__((noinline))
-int test_long_fname_1(struct dummy_tracepoint_args *arg)
+int test_long_fname_1(void)
 {
-	return test_long_fname_2(arg);
+	return test_long_fname_2();
 }
 
 SEC("dummy_tracepoint")
-int _dummy_tracepoint(struct dummy_tracepoint_args *arg)
+int _dummy_tracepoint(void *arg)
 {
-	return test_long_fname_1(arg);
+	return test_long_fname_1();
 }
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_btf.c b/tools/testing/selftests/bpf/test_btf.c
index 8da77cda5f4a..305fae8f80a9 100644
--- a/tools/testing/selftests/bpf/test_btf.c
+++ b/tools/testing/selftests/bpf/test_btf.c
@@ -2854,7 +2854,7 @@ static struct btf_raw_test raw_tests[] = {
 	.value_type_id = 1,
 	.max_entries = 4,
 	.btf_load_err = true,
-	.err_str = "vlen != 0",
+	.err_str = "Invalid func linkage",
 },
 
 {
-- 
2.26.2.303.gf8c07b1a785-goog

