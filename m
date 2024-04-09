Return-Path: <bpf+bounces-26247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBA089D1DE
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 07:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DAA01F24387
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 05:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1835B1EA;
	Tue,  9 Apr 2024 05:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4zxdDrb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C26A433C8;
	Tue,  9 Apr 2024 05:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712639941; cv=none; b=cO7Kiu6PjvEkcC5rbwvjiPpYx/XEQM1wm9MxeovX/pkX0gWh2M535uI+WZkqjIZh3Ls+I8qDjS7y/msGwpluOThEhyPWiL7ymiiHIavJrVwesyQEw0qoezgpspJ6F1M6MrOk4sp/jtN5EeiZQYWiFcY3EWNLkefis9iGKm5UGtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712639941; c=relaxed/simple;
	bh=kyRs5Dn9q/PNdmhzLdwShhMh1tHoLcJ0NKrgF3iBslc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FCaQbodeSS4szT3nfP20CdXEBKr24ydXD3Z2eKGtKu/QQiLId5Pvw5ZV3PI5Nv3FnWWM12KPFaa50+tnLMYJNkL9h0uhhNZlWfIw9IRlaslVmLpTml8rHTvZ4O3D3F7P/vFih+Xv4jCRVI79Z6dSgZeZW4Kg7igOta+nYKNRnZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4zxdDrb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDA7C433B1;
	Tue,  9 Apr 2024 05:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712639940;
	bh=kyRs5Dn9q/PNdmhzLdwShhMh1tHoLcJ0NKrgF3iBslc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j4zxdDrb30t/BfTJVbH/HEn8hNk5nibvtpXUGI+P5yR6Hm0QRU/0UrD6ebiaV0tnO
	 NZR384P0Wx1bJ3gjmNK/fKI5D7/awuA/C7my1N6rkKZYfWTM6+PesjHS3obW4GwBxW
	 X4GS6auxGe6THmsHf9Q3QZMVCA7rZKL+reYn4FEd8/3JLqYSgnw0bRlbbWBaexxz2x
	 tf3crndEKn7IZB8DiB6coCOUdIxH7no8nRqlVDfSqYQv3ioZUKarplMVcgF5edSMdN
	 s53HYHVH1xcIeTLtFJszC1YzTmV5Wbv0GTSbWNNnpJDpwXJtGlRfK2JdsPjxnkg4rK
	 jTfb5ayxORjQw==
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
Subject: [PATCH bpf v4 1/2] selftests/bpf: Add F_SETFL for fcntl in test_sockmap
Date: Tue,  9 Apr 2024 13:18:39 +0800
Message-Id: <e4efa52c26ca5ae97c7e4e7570d8da9cd44df533.1712639568.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712639568.git.tanggeliang@kylinos.cn>
References: <cover.1712639568.git.tanggeliang@kylinos.cn>
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
some subtests of test_sockmap fail.

Fixes: 16962b2404ac ("bpf: sockmap, add selftests")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/test_sockmap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 024a0faafb3b..4feed253fca2 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -603,7 +603,9 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 		struct timeval timeout;
 		fd_set w;
 
-		fcntl(fd, fd_flags);
+		if (fcntl(fd, F_SETFL, fd_flags))
+			goto out_errno;
+
 		/* Account for pop bytes noting each iteration of apply will
 		 * call msg_pop_data helper so we need to account for this
 		 * by calculating the number of apply iterations. Note user
@@ -678,6 +680,7 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 					perror("recv failed()");
 					goto out_errno;
 				}
+				continue;
 			}
 
 			s->bytes_recvd += recv;
-- 
2.40.1


