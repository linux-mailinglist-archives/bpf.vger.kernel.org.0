Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DE622A12C
	for <lists+bpf@lfdr.de>; Wed, 22 Jul 2020 23:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733004AbgGVVNR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 22 Jul 2020 17:13:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24802 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732992AbgGVVNQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jul 2020 17:13:16 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-BaSweAAkMvWvyrT75k2W3w-1; Wed, 22 Jul 2020 17:13:11 -0400
X-MC-Unique: BaSweAAkMvWvyrT75k2W3w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29322800465;
        Wed, 22 Jul 2020 21:13:09 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2317519C4F;
        Wed, 22 Jul 2020 21:13:05 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        David Miller <davem@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Wenbo Zhang <ethercflow@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Florent Revest <revest@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v8 bpf-next 11/13] selftests/bpf: Add verifier test for d_path helper
Date:   Wed, 22 Jul 2020 23:12:21 +0200
Message-Id: <20200722211223.1055107-12-jolsa@kernel.org>
In-Reply-To: <20200722211223.1055107-1-jolsa@kernel.org>
References: <20200722211223.1055107-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding verifier test for attaching tracing program and
calling d_path helper from within and testing that it's
allowed for dentry_open function and denied for 'd_path'
function with appropriate error.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/test_verifier.c   | 19 +++++++++-
 tools/testing/selftests/bpf/verifier/d_path.c | 37 +++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/d_path.c

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 78a6bae56ea6..9be395d9dc64 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -114,6 +114,7 @@ struct bpf_test {
 		bpf_testdata_struct_t retvals[MAX_TEST_RUNS];
 	};
 	enum bpf_attach_type expected_attach_type;
+	const char *kfunc;
 };
 
 /* Note we want this to be 64 bit aligned so that the end of our array is
@@ -984,8 +985,24 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 		attr.log_level = 4;
 	attr.prog_flags = pflags;
 
+	if (prog_type == BPF_PROG_TYPE_TRACING && test->kfunc) {
+		attr.attach_btf_id = libbpf_find_vmlinux_btf_id(test->kfunc,
+						attr.expected_attach_type);
+		if (attr.attach_btf_id < 0) {
+			printf("FAIL\nFailed to find BTF ID for '%s'!\n",
+				test->kfunc);
+			(*errors)++;
+			return;
+		}
+	}
+
 	fd_prog = bpf_load_program_xattr(&attr, bpf_vlog, sizeof(bpf_vlog));
-	if (fd_prog < 0 && !bpf_probe_prog_type(prog_type, 0)) {
+
+	/* BPF_PROG_TYPE_TRACING requires more setup and
+	 * bpf_probe_prog_type won't give correct answer
+	 */
+	if (fd_prog < 0 && prog_type != BPF_PROG_TYPE_TRACING &&
+	    !bpf_probe_prog_type(prog_type, 0)) {
 		printf("SKIP (unsupported program type %d)\n", prog_type);
 		skips++;
 		goto close_fds;
diff --git a/tools/testing/selftests/bpf/verifier/d_path.c b/tools/testing/selftests/bpf/verifier/d_path.c
new file mode 100644
index 000000000000..b988396379a7
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/d_path.c
@@ -0,0 +1,37 @@
+{
+	"d_path accept",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_1, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_MOV64_IMM(BPF_REG_6, 0),
+	BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_6, 0),
+	BPF_LD_IMM64(BPF_REG_3, 8),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_d_path),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_TRACING,
+	.expected_attach_type = BPF_TRACE_FENTRY,
+	.kfunc = "dentry_open",
+},
+{
+	"d_path reject",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_1, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_MOV64_IMM(BPF_REG_6, 0),
+	BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_6, 0),
+	BPF_LD_IMM64(BPF_REG_3, 8),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_d_path),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.errstr = "helper call is not allowed in probe",
+	.result = REJECT,
+	.prog_type = BPF_PROG_TYPE_TRACING,
+	.expected_attach_type = BPF_TRACE_FENTRY,
+	.kfunc = "d_path",
+},
-- 
2.25.4

