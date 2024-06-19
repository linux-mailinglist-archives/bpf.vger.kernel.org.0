Return-Path: <bpf+bounces-32492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3889490E1C9
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 04:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E421F23350
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 02:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E40353362;
	Wed, 19 Jun 2024 02:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UT/gw0A3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B403F5227;
	Wed, 19 Jun 2024 02:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718765783; cv=none; b=PjrBPkpYaxXMlbb3wRkeGGSeUn/RAD4+B7xst7nU3rUAGtwJ8q+MRLoBqQ3pDn8evpGUFdcYhlWNlAGYX3Czhm/qtiJWje3z9IJZFaBfwvh0yFVfDtr/wJh1AXDIFYfC3limvyNTwPDtvj8p/1iO9XjocjeJvQe2OCgNYIo9gJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718765783; c=relaxed/simple;
	bh=ek0iCBSuhwxmBUkXZ25YiD2CARKWMEhFftoQUiEh56g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWBDzTYRVmGhz2B5kjkI34HcUILhp0hF3YZRO+hqRoU2MFFoL7zw6AYlNM7bQoHfC4sUYu74Y8SC4p0dl4HFePoSvU9bEpmAM1AbcH+iMpe6udT52qygJ5kk5iAgZi5AaUiHLg7Yp4PAsdP1wTdJXqYDngwRlyaI4fJfumWwQz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UT/gw0A3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8734CC4AF1A;
	Wed, 19 Jun 2024 02:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718765783;
	bh=ek0iCBSuhwxmBUkXZ25YiD2CARKWMEhFftoQUiEh56g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UT/gw0A3HcImMJcHlTQ2ZZqgOsEsflFsqVnXwCQpfwuiqId2yQP+E8ZbWcOGetSkR
	 y2prm+pSJq5IzTsv8hQ94PZBPAhgkCxrCkIEZg2e3dYKajcdZoyuWPQ+YxlqmHGy1V
	 j3h8zmG8gE+poDpeKy4dK740orZ8RHIDEBjz/XAcJlFYek4Zl0oNTIYnnCKoblhNUs
	 yrj5Nuc/XsD77KTxLprBhMr2A77PtU4CH21REEauAlDDuEWybVNiu65ZnZwmNC64f6
	 YRqKxyD7Q8yFhy0VTKOjmGybh9hv5MJalO/UAUjkFRWb3of0q4eyFVsYxnBFiZnDOH
	 UlsHNkgjQDHfw==
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
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v5 6/6] selftests/bpf: Use start_server_str in test_tcp_check_syncookie_user
Date: Wed, 19 Jun 2024 10:51:11 +0800
Message-ID: <898be0e7459a8d408638157f41e43767d86f9077.1718765124.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718765123.git.tanggeliang@kylinos.cn>
References: <cover.1718765123.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Since start_server_str() is added now, it can be used in script
test_tcp_check_syncookie_user.c instead of start_server_addr() to
simplify the code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/test_tcp_check_syncookie_user.c       | 29 ++-----------------
 1 file changed, 3 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c b/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
index aebc58c24dc5..3844f9b8232a 100644
--- a/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
+++ b/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
@@ -156,10 +156,6 @@ static int v6only_false(int fd, void *opts)
 int main(int argc, char **argv)
 {
 	struct network_helper_opts opts = { 0 };
-	struct sockaddr_in addr4;
-	struct sockaddr_in6 addr6;
-	struct sockaddr_in addr4dual;
-	struct sockaddr_in6 addr6dual;
 	int server = -1;
 	int server_v6 = -1;
 	int server_dual = -1;
@@ -181,36 +177,17 @@ int main(int argc, char **argv)
 		goto err;
 	}
 
-	memset(&addr4, 0, sizeof(addr4));
-	addr4.sin_family = AF_INET;
-	addr4.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
-	addr4.sin_port = 0;
-	memcpy(&addr4dual, &addr4, sizeof(addr4dual));
-
-	memset(&addr6, 0, sizeof(addr6));
-	addr6.sin6_family = AF_INET6;
-	addr6.sin6_addr = in6addr_loopback;
-	addr6.sin6_port = 0;
-
-	memset(&addr6dual, 0, sizeof(addr6dual));
-	addr6dual.sin6_family = AF_INET6;
-	addr6dual.sin6_addr = in6addr_any;
-	addr6dual.sin6_port = 0;
-
-	server = start_server_addr(SOCK_STREAM, (struct sockaddr_storage *)&addr4,
-				   sizeof(addr4), NULL);
+	server = start_server_str(AF_INET, SOCK_STREAM, "127.0.0.1", 0, NULL);
 	if (server == -1)
 		goto err;
 
 	opts.post_socket_cb = v6only_true;
-	server_v6 = start_server_addr(SOCK_STREAM, (struct sockaddr_storage *)&addr6,
-				      sizeof(addr6), &opts);
+	server_v6 = start_server_str(AF_INET6, SOCK_STREAM, "::1", 0, &opts);
 	if (server_v6 == -1)
 		goto err;
 
 	opts.post_socket_cb = v6only_false;
-	server_dual = start_server_addr(SOCK_STREAM, (struct sockaddr_storage *)&addr6dual,
-					sizeof(addr6dual), &opts);
+	server_dual = start_server_str(AF_INET6, SOCK_STREAM, "::0", 0, &opts);
 	if (server_dual == -1)
 		goto err;
 
-- 
2.43.0


