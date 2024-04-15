Return-Path: <bpf+bounces-26736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB008A4816
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 08:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7911B22063
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 06:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE36C17BA4;
	Mon, 15 Apr 2024 06:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMAEkcLp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5C74689;
	Mon, 15 Apr 2024 06:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713162728; cv=none; b=JHt0I3KbArHv2ShU83WJPETRERN9JmMIARXV5f7nru6HXydZcl9BnmR5Sd68nDa50lnJ9yUPWpn3Pe30+jJQROb6nb+2Oqn8XLf9H+XKbh7D4FNy/2VKLjnDqfe7TybaYYMSBYBDMHTn3MZ2Oc1Z23eOj+jTd+0u62i90GcjeXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713162728; c=relaxed/simple;
	bh=rHc0ZaD+/SOM6afPT4tmEZZK6h9YUARUauoAo1057pA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iyC2oBySUKthuHtQopaziZ+1RyqtHfHp5bjZzfgArPLPQ90KrmtUdHUVMzpMi87aamlhVkNF+mYDgcaYixJajp71mEOS7hQj2VU7J805xAxHJ3JEWctlwUGpC0543KRU76G8gmY9gfyYCSj3pk8B9opE5swywSTjH+KZXS/d67U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMAEkcLp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DCFCC113CC;
	Mon, 15 Apr 2024 06:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713162728;
	bh=rHc0ZaD+/SOM6afPT4tmEZZK6h9YUARUauoAo1057pA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pMAEkcLpDdmIK21t7ivGQqwmRWjbWyOqeYfI6hbV8wf/P/mLvsvYtU+yrVeTKlOPQ
	 dbSubInKCZlcS0aex+mNypOmExc3GMtj6AKx8y5eGl/lOd6uhI7JF4YWCYDizem8Y6
	 4T+oRV/GtQ4oqeeHW87aUoi4bF24/ZbEc3+vWEHCN6uyz2ORJvDCE+/8lMX2/h3XXN
	 rtQqZjJgR2+7hD0v4mceKWPkGZu5RBNRACsXnc3cwIIpEG+FL6mSO7zGwvSZTn/3yl
	 kf8GVzFjCIAQ0qxdfD9cdRrQEoItfI0Y2Dr+RMp3cMmpgvFYRNRi0xJCaPLU7LQa57
	 IwEBTn5m063zQ==
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
Subject: [PATCH bpf-next v3 6/9] selftests/bpf: Use connect_to_addr in sk_assign
Date: Mon, 15 Apr 2024 14:31:15 +0800
Message-Id: <7a2b32cb2cb222d2e226df91bb0c336c409f5e18.1713161975.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713161974.git.tanggeliang@kylinos.cn>
References: <cover.1713161974.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses public helper connect_to_addr() exported in
network_helpers.h instead of the local defined function connect_to_server()
in prog_tests/sk_assign.c. This can avoid duplicate code.

The code that sets SO_SNDTIMEO timeout as timeo_sec (3s) can be dropped,
since connect_to_addr() sets default timeout as 3s.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sk_assign.c      | 26 +------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
index 70c1a5893830..b2d2b689b0cb 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
@@ -23,8 +23,6 @@
 #define NS_SELF "/proc/self/ns/net"
 #define SERVER_MAP_PATH "/sys/fs/bpf/tc/globals/server_map"
 
-static const struct timeval timeo_sec = { .tv_sec = 3 };
-static const size_t timeo_optlen = sizeof(timeo_sec);
 static int stop, duration;
 
 static bool
@@ -74,28 +72,6 @@ configure_stack(void)
 	return true;
 }
 
-static int
-connect_to_server(const struct sockaddr *addr, socklen_t len, int type)
-{
-	int fd = -1;
-
-	fd = socket(addr->sa_family, type, 0);
-	if (CHECK_FAIL(fd == -1))
-		goto out;
-	if (CHECK_FAIL(setsockopt(fd, SOL_SOCKET, SO_SNDTIMEO, &timeo_sec,
-				  timeo_optlen)))
-		goto close_out;
-	if (CHECK_FAIL(connect(fd, addr, len)))
-		goto close_out;
-
-	goto out;
-close_out:
-	close(fd);
-	fd = -1;
-out:
-	return fd;
-}
-
 static in_port_t
 get_port(int fd)
 {
@@ -138,7 +114,7 @@ run_test(int server_fd, const struct sockaddr *addr, socklen_t len, int type)
 	in_port_t port;
 	int ret = 1;
 
-	client = connect_to_server(addr, len, type);
+	client = connect_to_addr(type, (struct sockaddr_storage *)addr, len);
 	if (client == -1) {
 		perror("Cannot connect to server");
 		goto out;
-- 
2.40.1


