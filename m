Return-Path: <bpf+bounces-526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BB3702E72
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 15:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2911C20BD1
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 13:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174A3C8FA;
	Mon, 15 May 2023 13:38:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421F8C8EC
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 13:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300A9C433D2;
	Mon, 15 May 2023 13:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684157933;
	bh=PpjCQLDbUnlMKk9tHg2M9KwWLgQuMtiP2zFmMh9wIuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QerYqZegJsfGAFZqaSpAoJGn7++W/ICx14Dkupp/cDTXcNGzQey/HSdrFG4xXrqfv
	 feEnaetL2Ar1wgXFt6+DPgo+qYsOZzXKyl4imiMfWITax97BncBn8QpJBZX1pHIt4c
	 YDMWudr8WkubgX+OIbQaht9vh9QE7G9Oav7PRH0sBrnnTiQl5hkdXCCx2TKnrJN9kK
	 bTZFpXjMlU1yfrIwpCmxmk7jDBgF2f8vm8CUnea2+smldmgntAzJlGm6SxASazj8Cg
	 sL31eRfX/ni70YqwUNp+z088NX/595cQ6AmRy3pd2AlKg6y0bRQwBq8MJBHmV0LAzh
	 GmPYrW6ITeL2w==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: David Vernet <void@manifault.com>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCHv4 bpf-next 05/10] selftests/bpf: Do not unload bpf_testmod in load_bpf_testmod
Date: Mon, 15 May 2023 15:37:51 +0200
Message-Id: <20230515133756.1658301-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515133756.1658301-1-jolsa@kernel.org>
References: <20230515133756.1658301-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not unload bpf_testmod in load_bpf_testmod, instead call
unload_bpf_testmod separatelly.

This way we will be able use un/load_bpf_testmod functions
in other tests that un/load bpf_testmod module.

Acked-by: David Vernet <void@manifault.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/test_progs.c      | 11 ++++++++---
 tools/testing/selftests/bpf/testing_helpers.c |  3 ---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index cebe62d29f8d..4d582cac2c09 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1657,9 +1657,14 @@ int main(int argc, char **argv)
 	env.stderr = stderr;
 
 	env.has_testmod = true;
-	if (!env.list_test_names && load_bpf_testmod(verbose())) {
-		fprintf(env.stderr, "WARNING! Selftests relying on bpf_testmod.ko will be skipped.\n");
-		env.has_testmod = false;
+	if (!env.list_test_names) {
+		/* ensure previous instance of the module is unloaded */
+		unload_bpf_testmod(verbose());
+
+		if (load_bpf_testmod(verbose())) {
+			fprintf(env.stderr, "WARNING! Selftests relying on bpf_testmod.ko will be skipped.\n");
+			env.has_testmod = false;
+		}
 	}
 
 	/* initializing tests */
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index f73bc88f3eb6..e01d7a62306c 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -359,9 +359,6 @@ int load_bpf_testmod(bool verbose)
 {
 	int fd;
 
-	/* ensure previous instance of the module is unloaded */
-	unload_bpf_testmod(verbose);
-
 	if (verbose)
 		fprintf(stdout, "Loading bpf_testmod.ko...\n");
 
-- 
2.40.1


