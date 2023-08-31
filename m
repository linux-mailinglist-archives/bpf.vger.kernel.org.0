Return-Path: <bpf+bounces-9043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DB378EB3C
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 13:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A85228149E
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 11:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E90B8F61;
	Thu, 31 Aug 2023 11:00:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0A26FB6
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 11:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AB9C433C8;
	Thu, 31 Aug 2023 11:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693479625;
	bh=U42vRhpwRCmX2Tpld//hoium+pb4Il1DnZk6n/ijw4E=;
	h=From:To:Cc:Subject:Date:From;
	b=K/65nH51zpMSI4G1nwAnLNLTr6H9WfTVh8MH4CevYseYk7XRb/vGc3sUHL8LHe2UZ
	 vvVm9vkAVPZcSlpysewS1JPoQpCSpub9xXZM+QstaQ6sJSWV58q3WeNvoW2DcTgfwq
	 +R5fUhoWlmKPbSbTALUgvCPyE9dr7fl59Ej/v0lbpb7KGBB+wEB5a+SafF3ppJvgRh
	 p9WwKaT/VTUT82lOod01pT8ac59qDD3khNTAR+zDm5X9cxWhes/JGR1CuLarnreeCC
	 2bXWI0ZY/soMSio2VAHrFLCOEIfdHq+w0e1QWyGN9i2wh7BFilay+G4WwN3+y2NRVc
	 1Zf6CY4rxOSnw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Hou Tao <houtao@huaweicloud.com>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Hou Tao <houtao1@huawei.com>
Subject: [PATCH bpf-next] selftests/bpf: Fix d_path test
Date: Thu, 31 Aug 2023 13:00:19 +0200
Message-ID: <20230831110020.290102-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent commit [1] broken d_path test, because now filp_close is not called
directly from sys_close, but eventually later when the file is finally
released.

As suggested by Hou Tao we don't need to re-hook the bpf program, but just
instead we can use sys_close_range to trigger filp_close synchronously.

[1] 021a160abf62 ("fs: use __fput_sync in close(2)")
Suggested-by: Hou Tao <houtao@huaweicloud.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/d_path.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/testing/selftests/bpf/prog_tests/d_path.c
index 911345c526e6..81e34a4a05d1 100644
--- a/tools/testing/selftests/bpf/prog_tests/d_path.c
+++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
@@ -90,7 +90,11 @@ static int trigger_fstat_events(pid_t pid)
 	fstat(indicatorfd, &fileStat);
 
 out_close:
-	/* triggers filp_close */
+	/* sys_close no longer triggers filp_close, but we can
+	 * call sys_close_range instead which still does
+	 */
+#define close(fd) close_range(fd, fd, 0)
+
 	close(pipefd[0]);
 	close(pipefd[1]);
 	close(sockfd);
@@ -98,6 +102,8 @@ static int trigger_fstat_events(pid_t pid)
 	close(devfd);
 	close(localfd);
 	close(indicatorfd);
+
+#undef close
 	return ret;
 }
 
-- 
2.41.0


