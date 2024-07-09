Return-Path: <bpf+bounces-34202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE82B92B372
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 11:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 756EA1F23267
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 09:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA48153BC1;
	Tue,  9 Jul 2024 09:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FI/TbSRa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E981DA2F;
	Tue,  9 Jul 2024 09:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720516608; cv=none; b=RTflzzeFunjNxeAvq4s7x7QX9rgL01chRiJxprqveNlqPxPxu5cbjeF+mhfBKPRzC47SXHgHpCIl5blyXV73O/zKB48/nh7DeMbyr11K+WOGnHgLdgxc8I2Uv7afSyk2dofgELplllXOYxZFLHca2BP4fivFdCmAA2GRXmKw+1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720516608; c=relaxed/simple;
	bh=bAX1OLxg4DkksZvjRAzn/L1GhmwINGXrUi0DgLiNpt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=laiGv2nazwLgmLNcfZuSedtHU2tJRjc9m6iQ/voPTygDhquAZuZfxTJO1/wjIc7VgNDLnCQFk6/Ln8PpoHfnmM/RxfSRkRZuAd8o/RcYUJtM4444Ht761j81CrMBHTWXnq8uZ0ziIH55c5Xh7vRMYGUdEUQLVmPC64BGZFgLVpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FI/TbSRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBFAC4AF10;
	Tue,  9 Jul 2024 09:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720516608;
	bh=bAX1OLxg4DkksZvjRAzn/L1GhmwINGXrUi0DgLiNpt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FI/TbSRatTZ/4gu+8lUuTEizJSrAHBko6K/ssAosGbA4oCtBeXZ10QcaM0RWp7iCc
	 y8uMnKaNN0VgOoWbVmtyhbeNwhx7quqFFOILBGynzum//SUScVCwMubMRVl89YkQkq
	 aRmm9caHVIMmCzahz+ET33jPtfkOJDfOjOqiWZJKSNnpei5CrwifTAtrSnlTdu9dcY
	 pnOPcQbgNS/u7dbDL4mZjz0xLAc5RHQvwBqLoxBID2IkCoaEjhHTjIYTp2Sx78PQKR
	 b0C0p5tw8d0qYE0LCuCA5/bHVVKZs8k/MeiDU9XovdH6kLk9MUQqYGi1gnt8rGeCyM
	 ybhzWLynSq7qQ==
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
Subject: [PATCH bpf-next v11 1/9] selftests/bpf: Add backlog for network_helper_opts
Date: Tue,  9 Jul 2024 17:16:17 +0800
Message-ID: <1660229659b66eaad07aa2126e9c9fe217eba0dd.1720515893.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720515893.git.tanggeliang@kylinos.cn>
References: <cover.1720515893.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Some callers expect __start_server() helper to pass their own "backlog"
value to listen() instead of the default of 1. So this patch adds struct
member "backlog" for network_helper_opts to allow callers to set "backlog"
value via start_server_str() helper.

listen(fd, 0 /* backlog */) can be used to enforce syncookie. Meaning
backlog 0 is a legit value.

Using 0 as a default and changing it to 1 here is fine. It makes the test
program easier to write for the common case. Enforcing syncookie mode by
using backlog 0 is a niche use case but it should at least have a way for
the caller to do that.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 2 +-
 tools/testing/selftests/bpf/network_helpers.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 44c2c8fa542a..e0cba4178e41 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -106,7 +106,7 @@ static int __start_server(int type, const struct sockaddr *addr, socklen_t addrl
 	}
 
 	if (type == SOCK_STREAM) {
-		if (listen(fd, 1) < 0) {
+		if (listen(fd, opts->backlog ? MAX(opts->backlog, 0) : 1) < 0) {
 			log_err("Failed to listed on socket");
 			goto error_close;
 		}
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 9ea36524b9db..4f26bfc2dbf5 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -25,6 +25,10 @@ struct network_helper_opts {
 	int timeout_ms;
 	bool must_fail;
 	int proto;
+	/* The backlog argument for listen(), defines the maximum length to which
+	 * the queue of pending connections for sockfd may grow.
+	 */
+	int backlog;
 	int (*post_socket_cb)(int fd, void *opts);
 	void *cb_opts;
 };
-- 
2.43.0


