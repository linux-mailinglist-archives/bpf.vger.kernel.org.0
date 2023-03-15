Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA5F6BBA4F
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 17:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjCOQ4a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 12:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjCOQ43 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 12:56:29 -0400
Received: from faui40.informatik.uni-erlangen.de (faui40.informatik.uni-erlangen.de [131.188.34.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E437B106;
        Wed, 15 Mar 2023 09:56:11 -0700 (PDT)
Received: from luis-i4.informatik.uni-erlangen.de (i4laptop35.informatik.uni-erlangen.de [10.188.34.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: gerhorst)
        by faui40.informatik.uni-erlangen.de (Postfix) with ESMTPSA id 4PcGkH5cMdznkbm;
        Wed, 15 Mar 2023 17:56:07 +0100 (CET)
From:   Luis Gerhorst <gerhorst@cs.fau.de>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Andrei Matei <andreimatei1@gmail.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Luis Gerhorst <gerhorst@cs.fau.de>
Subject: [PATCH] bpf: remove misleading spec_v1 check on var-offset stack read
Date:   Wed, 15 Mar 2023 17:54:00 +0100
Message-Id: <20230315165358.23701-1-gerhorst@cs.fau.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ff8135a6-506f-330f-89fb-f98672467b27@cs.fau.de>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For every BPF_ADD/SUB involving a pointer, adjust_ptr_min_max_vals()
ensures that the resulting pointer has a constant offset if
bypass_spec_v1 is false. This is ensured by calling
sanitize_check_bounds() which in turn calls
check_stack_access_for_ptr_arithmetic(). There, -EACCESS is returned if
the register's offset is not constant, thereby rejecting the program.

In summary, an unprivileged user must never be able to create stack
pointers with a variable offset. That is also the case, because a
respective check in check_stack_write() is missing. If they were able to
create a variable-offset pointer, users could still use it in a
stack-write operation to trigger unsafe speculative behavior [1].

Because unprivileged users must already be prevented from creating
variable-offset stack pointers, viable options are to either remove this
check (replacing it with a clarifying comment), or to turn it into a
"verifier BUG"-message, also adding a similar check in
check_stack_write() (for consistency, as a second-level defense). This
patch implements the first option to reduce verifier bloat.

This check was introduced by commit 01f810ace9ed ("bpf: Allow
variable-offset stack access") which correctly notes that
"variable-offset reads and writes are disallowed (they were already
disallowed for the indirect access case) because the speculative
execution checking code doesn't support them". However, it does not
further discuss why the check in check_stack_read() is necessary. The
code which made this check obsolete was also introduced in this commit.

I have compiled ~650 programs from the Linux selftests, Linux samples,
Cilium, and libbpf/examples projects and confirmed that none of these
trigger the check in check_stack_read() [2]. Instead, all of these
programs are, as expected, already rejected when constructing the
variable-offset pointers. Note that the check in
check_stack_access_for_ptr_arithmetic() also prints "off=%d" while the
code removed by this patch does not (the error removed does not appear
in the "verification_error" values). For reproducibility, the repository
linked includes the raw data and scripts used to create the plot.

[1] https://arxiv.org/pdf/1807.03757.pdf
[2] https://gitlab.cs.fau.de/un65esoq/bpf-spectre/-/raw/53dc19fcf459c186613b1156a81504b39c8d49db/data/plots/23-02-26_23-56_bpftool/bpftool/0004-errors.pdf?inline=false

Fixes: 01f810ace9ed ("bpf: Allow variable-offset stack access")
Signed-off-by: Luis Gerhorst <gerhorst@cs.fau.de>
---
 kernel/bpf/verifier.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8c13dd0f73e5..c1dc7fed655c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3958,16 +3958,13 @@ static int check_stack_read(struct bpf_verifier_env *env,
 	}
 	/* Variable offset is prohibited for unprivileged mode for simplicity
 	 * since it requires corresponding support in Spectre masking for stack
-	 * ALU. See also retrieve_ptr_limit().
+	 * ALU. See also retrieve_ptr_limit(). The check in
+	 * check_stack_access_for_ptr_arithmetic() called by
+	 * adjust_ptr_min_max_vals() prevents users from creating stack pointers
+	 * with variable offsets, therefore no check is required here. Further,
+	 * just checking it here would be insufficient as speculative stack
+	 * writes could still lead to unsafe speculative behaviour.
 	 */
-	if (!env->bypass_spec_v1 && var_off) {
-		char tn_buf[48];
-
-		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
-		verbose(env, "R%d variable offset stack access prohibited for !root, var_off=%s\n",
-				ptr_regno, tn_buf);
-		return -EACCES;
-	}
 
 	if (!var_off) {
 		off += reg->var_off.value;
-- 
2.34.1

