Return-Path: <bpf+bounces-9065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE8C78EF53
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 16:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27CB21C20A04
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 14:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3E511C9D;
	Thu, 31 Aug 2023 14:11:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869A711707
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 14:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3D3C433C8;
	Thu, 31 Aug 2023 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693491069;
	bh=0YvwvZnhqaqvWS4lgyFlHi1fXr4iRhMPNaCqpDJgTe0=;
	h=From:To:Cc:Subject:Date:From;
	b=eiF3vB6p1Zh0dIkxkUMQKYqwg2hiCs1CXMYkde+Mg0ufnEvYZhK5osjiyFSWXQCRr
	 XxLNBEWGqK2wIDqkN/K1LgBHgfjjHoxDry13UcrUffdeYug/wvzaJ2Z3JwrMMnEViU
	 ITOHc1wGmq/ifg7emsFZcFo2VM2+yamrTEC3Na//2APCFu6l00YfQxHjJsO2pyh9Y6
	 7anKeLe7cZVP8TNHdiPGu8yr+SO7dBcTYD8ExamINhQN1hm1aGbPVKLyyOrcIXubw0
	 aTNoCFBm1A//8IVuklzJi/bpoyI7JAt2iAAHH0YNsE3/dOeX1C/O4Gv+eIXJA6OSLd
	 +azWTDHFVR+HA==
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
Subject: [PATCHv2 bpf-next] selftests/bpf: Fix d_path test
Date: Thu, 31 Aug 2023 16:11:03 +0200
Message-ID: <20230831141103.359810-1-jolsa@kernel.org>
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
 .../testing/selftests/bpf/prog_tests/d_path.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

  v2: call close_range through syscall call [Hou Tao]

diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/testing/selftests/bpf/prog_tests/d_path.c
index 911345c526e6..ccc768592e66 100644
--- a/tools/testing/selftests/bpf/prog_tests/d_path.c
+++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
@@ -12,6 +12,17 @@
 #include "test_d_path_check_rdonly_mem.skel.h"
 #include "test_d_path_check_types.skel.h"
 
+/* sys_close_range is not around for long time, so let's
+ * make sure we can call it on systems with older glibc
+ */
+#ifndef __NR_close_range
+#ifdef __alpha__
+#define __NR_close_range 546
+#else
+#define __NR_close_range 436
+#endif
+#endif
+
 static int duration;
 
 static struct {
@@ -90,7 +101,11 @@ static int trigger_fstat_events(pid_t pid)
 	fstat(indicatorfd, &fileStat);
 
 out_close:
-	/* triggers filp_close */
+	/* sys_close no longer triggers filp_close, but we can
+	 * call sys_close_range instead which still does
+	 */
+#define close(fd) syscall(__NR_close_range, fd, fd, 0)
+
 	close(pipefd[0]);
 	close(pipefd[1]);
 	close(sockfd);
@@ -98,6 +113,8 @@ static int trigger_fstat_events(pid_t pid)
 	close(devfd);
 	close(localfd);
 	close(indicatorfd);
+
+#undef close
 	return ret;
 }
 
-- 
2.41.0


