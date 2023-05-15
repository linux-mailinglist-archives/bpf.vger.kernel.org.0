Return-Path: <bpf+bounces-525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7960A702E70
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 15:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BAC61C20B12
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 13:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F503C8FA;
	Mon, 15 May 2023 13:38:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B37EC8EC
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 13:38:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB434C433EF;
	Mon, 15 May 2023 13:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684157922;
	bh=qIemmLs49ERrxm7NFOkM64bN+H5XApkmaIy3OjF1pww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NZRpG2T9LDTG94x/fF5KmShKZIlPSz425jOGulCD/9VY8a5rWY1XEMy0nk4yab+bz
	 zcyINV6EGugrFHpFLL07w7Ka8nLPq0pS2/Gtfx7vJ8z6jqVpMuqE2r/c8v37Dg3+pV
	 G0mSKYWz+a9Ia4uCc9YwKjMF/Vkf7uMojq1TQKk/6yJoTs1dNZ5BsKTzdF8bmnRQ/T
	 DS729dgJj+CfZmdeE9AMYbPTqMzEi+AxOXGnbJ4b7F2S6/Fr7OX7i8GARUvf2zoFLr
	 JYrDNeEkyaZ8w++Z1NsW0/ss7oPJ939pFWAXWTOgQfm07xq1VXQOpIt52AeaOqAjgI
	 W7l/gqqL7uHHw==
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
Subject: [PATCHv4 bpf-next 04/10] selftests/bpf: Use only stdout in un/load_bpf_testmod functions
Date: Mon, 15 May 2023 15:37:50 +0200
Message-Id: <20230515133756.1658301-5-jolsa@kernel.org>
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

We are about to use un/load_bpf_testmod functions in couple tests
and it's better  to print output to stdout,  so it's aligned with
tests ASSERT macros output, which use stdout as well.

Acked-by: David Vernet <void@manifault.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/testing_helpers.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index 648c7d3eb319..f73bc88f3eb6 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -341,14 +341,14 @@ static int delete_module(const char *name, int flags)
 void unload_bpf_testmod(bool verbose)
 {
 	if (kern_sync_rcu())
-		fprintf(stderr, "Failed to trigger kernel-side RCU sync!\n");
+		fprintf(stdout, "Failed to trigger kernel-side RCU sync!\n");
 	if (delete_module("bpf_testmod", 0)) {
 		if (errno == ENOENT) {
 			if (verbose)
 				fprintf(stdout, "bpf_testmod.ko is already unloaded.\n");
 			return;
 		}
-		fprintf(stderr, "Failed to unload bpf_testmod.ko from kernel: %d\n", -errno);
+		fprintf(stdout, "Failed to unload bpf_testmod.ko from kernel: %d\n", -errno);
 		return;
 	}
 	if (verbose)
@@ -367,11 +367,11 @@ int load_bpf_testmod(bool verbose)
 
 	fd = open("bpf_testmod.ko", O_RDONLY);
 	if (fd < 0) {
-		fprintf(stderr, "Can't find bpf_testmod.ko kernel module: %d\n", -errno);
+		fprintf(stdout, "Can't find bpf_testmod.ko kernel module: %d\n", -errno);
 		return -ENOENT;
 	}
 	if (finit_module(fd, "", 0)) {
-		fprintf(stderr, "Failed to load bpf_testmod.ko into the kernel: %d\n", -errno);
+		fprintf(stdout, "Failed to load bpf_testmod.ko into the kernel: %d\n", -errno);
 		close(fd);
 		return -EINVAL;
 	}
-- 
2.40.1


