Return-Path: <bpf+bounces-26113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069EF89AFAA
	for <lists+bpf@lfdr.de>; Sun,  7 Apr 2024 10:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32DD31C21115
	for <lists+bpf@lfdr.de>; Sun,  7 Apr 2024 08:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F74C1119A;
	Sun,  7 Apr 2024 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h13PZM00"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA56510A26;
	Sun,  7 Apr 2024 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712478500; cv=none; b=DrWT2L99MnhgcsF8ST5RrE4IYuarKWsDkLBsu/mzvMUKcf6jkkA1BbOvhbFwPJToC0nodRxoAxSWulwOEYxcUzRjRGXI0ofUKtV+drCwbTcFhYwmF+iQ7TjSe76vvUmaWJ9CvUuglAiHpUpxtmQ5YM4/waGb20fgZO/XDRoT39o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712478500; c=relaxed/simple;
	bh=sQRFh15eS1KcsyILFzsjsuNASDD2MRAK6hYQtzSXvF0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jQpSoNbuRraXXKj7zsyNIj+I2sIESmlegvR2WhnV3A8/vIeQsyCRvyx+I12/UVmqCA51WPf3m3rxETuiB8U5E7CNtR+fEppPeMD9yqeiW/w2al4CrsqbTF0ZpZHxZGG/0MUDsibGFRZP3uMcPCs9yWkOpTG53AXRVYprwSvmeOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h13PZM00; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008E6C433C7;
	Sun,  7 Apr 2024 08:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712478500;
	bh=sQRFh15eS1KcsyILFzsjsuNASDD2MRAK6hYQtzSXvF0=;
	h=From:To:Cc:Subject:Date:From;
	b=h13PZM009XrP2abNT1yWDVKHtOrym04yKdHaM5lzb170nD+64MufU7MjK2vMdJnOL
	 J+d0WZvLI+I7s3SfMku3XqfcErvrFg/HvT/izT/3Qzm7vjbMzKn8x/KKMmsgdikHCI
	 PW693o1V5RPuoZWxls1p5eJBrLSRwRnpR9vwTx0wp8iMVoUaSeIxHoX8SoJowiES6J
	 VLrwFoI98T4wU5Bg6Buur2Vll39BYgXg01FLVdNRzYO8RbkA52fw0irO7xkm66QEQD
	 xt0b1N1JJ5iLzK5QnTYrZGzu6ogiL5dVFV5v3bnYJurs80uco1DyuLjp4IofYSlv8K
	 fiXVJ11EIt9og==
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
Subject: [PATCH bpf-next v2] selftests/bpf: Add F_SETFL for fcntl
Date: Sun,  7 Apr 2024 16:28:09 +0800
Message-Id: <6af4240525d760d0d89ed374bfa28826c18c7a2c.1712478251.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
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

In nonblock mode, if EWOULDBLOCK is received, receive again, otherwise some
subtests of test_sockmap will fail.

Fixes: 16962b2404ac ("bpf: sockmap, add selftests")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 v2:
 - fix errors:
# 6/ 7  sockmap::txmsg test skb:FAIL
#21/ 7 sockhash::txmsg test skb:FAIL
#36/ 7 sockhash:ktls:txmsg test skb:FAIL
Pass: 42 Fail: 3
---
 tools/testing/selftests/bpf/test_sockmap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 024a0faafb3b..bbc3fd57f349 100644
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
@@ -671,12 +671,15 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 				flags = 0;
 			}
 
+again:
 			recv = recvmsg(fd, &msg, flags);
 			if (recv < 0) {
 				if (errno != EWOULDBLOCK) {
 					clock_gettime(CLOCK_MONOTONIC, &s->end);
 					perror("recv failed()");
 					goto out_errno;
+				} else {
+					goto again;
 				}
 			}
 
-- 
2.40.1


