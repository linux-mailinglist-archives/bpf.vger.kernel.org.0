Return-Path: <bpf+bounces-26131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0D489B54C
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 03:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C22B1C2099C
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 01:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9FA10FF;
	Mon,  8 Apr 2024 01:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjfeU0Z7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213097F8;
	Mon,  8 Apr 2024 01:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712540210; cv=none; b=dKg/bwNo7OemazU/cHMAYG3uQDYbp5H8GxYx1H5Z6VkEHRKl2Wdo7aV6zZnBDEjmFl72ke3fIQCXF/e/8oNMU78VKs1ThQ06JZYpcO3xwpBg30nW+tLTTRpDRF2E+76ZvoTOqoi0G9JzcvCoonPySDHCga5DTr/q1oq+39D5/Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712540210; c=relaxed/simple;
	bh=knQEsTcpSgk/3Cc+TDk8z2dvFHCQMXuY0MUvtDfCQFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XYnLlEov5k5dm/2Omx3QnbAQ0Kt7K3E/hGCFb83DH4buwvy7pOvojItpQZ5D0JSZy6eKX2IMCbuPOFcTTKmMkV+BMAF6w4g1QP/bHCXzJm+Kd62Iprp7DMoum7dFiHmNBdDG4ZthPXEmugFfIDZ6LQHCw08tGrovS0uasBQtko0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjfeU0Z7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A760C433B1;
	Mon,  8 Apr 2024 01:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712540209;
	bh=knQEsTcpSgk/3Cc+TDk8z2dvFHCQMXuY0MUvtDfCQFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AjfeU0Z7VuvNB8H/6RTPXObLTeQjbapggW1bsdLECbot2KTu6OYX1pcTj0yF+hOFS
	 30ohM5EDP2xf5csHemUyNGuQ53j+D9Aq+FjOZSiKxc+veC8k7QppW+fMLh4qWq/PsD
	 dD0QTv4FxGdqTxzep5jRdmtce8UDjwtoPuI7TCigSmKqnjmqI7+YrsZATfZSXKu4XO
	 JS8rWKeYiTLSpOxe/vREakdmYBLe5Hs5we7Dd+y1g53ttnYZOY3fRNesiph59iv9ee
	 n/UC0UoFeGcmHuJrqXJ8qei7zw8cqffe2iT21peVSmhG1bn629nZtuAzqsQmk7+mCt
	 /GhvxWGuFwnJA==
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH bpf-next v3 1/2] selftests/bpf: Add F_SETFL for fcntl in test_sockmap
Date: Mon,  8 Apr 2024 09:36:29 +0800
Message-Id: <2f9f84be1366ca68b1123dd2f3fd06034e1bd3a4.1712539403.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712539403.git.tanggeliang@kylinos.cn>
References: <cover.1712539403.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Incorrect arguments are passed to fcntl() in test_sockmap.c when invoking
it to set file status flags. If O_NONBLOCK is used as 2nd argument and
passed into fcntl, -EINVAL will be returned (See do_fcntl() in fs/fcntl.c).
The correct approach is to use F_SETFL as 2nd argument, and O_NONBLOCK as
3rd one.

In nonblock mode, if EWOULDBLOCK is received, continue receiving, otherwise
some subtests of test_sockmap will fail.

Fixes: 16962b2404ac ("bpf: sockmap, add selftests")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/test_sockmap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 024a0faafb3b..4f32a5eb3864 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -603,7 +603,7 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 		struct timeval timeout;
 		fd_set w;
 
-		fcntl(fd, fd_flags);
+		fcntl(fd, F_SETFL, fd_flags);
 		/* Account for pop bytes noting each iteration of apply will
 		 * call msg_pop_data helper so we need to account for this
 		 * by calculating the number of apply iterations. Note user
@@ -678,6 +678,9 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 					perror("recv failed()");
 					goto out_errno;
 				}
+				fd_flags = fcntl(fd, F_GETFL);
+				if (fd_flags & O_NONBLOCK)
+					continue;
 			}
 
 			s->bytes_recvd += recv;
-- 
2.40.1


