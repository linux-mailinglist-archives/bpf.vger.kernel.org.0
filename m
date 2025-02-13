Return-Path: <bpf+bounces-51404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4820DA33EA4
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 13:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0351D168017
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 12:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8490221571;
	Thu, 13 Feb 2025 11:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Z0oSvblp"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DA6221706;
	Thu, 13 Feb 2025 11:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739447993; cv=none; b=Kjqabf0qmA/gRbc4Y1v18o2aQNSyjXmtd2ZHsDOjqVZppzbwgY6vznNeRfv/eQWD0nBpMq9rZF7O99gsqbk3ARMiJiQIqdeEzFi6zwAqJLcnD7PmBcS+SNUviW4lWiDMH7IdpJVKIV81qPPBLWY61HME5Hk9UA0mktbeTCvna6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739447993; c=relaxed/simple;
	bh=diI8kyiYTniTU0Xe8e7BeDAadyWzqAaR19wnpNARev8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dOgZbidPTiX9kfTYm5GceJ8zHyfTCfi/p7sIRv74wSRkcK+RTIed+pHqo8fWHE7+swaAArWzEvpcIT222cCoTgWBOzxbZN+zjTxZrrajFaOZpG1zxJwoIctnV9/Bv7Dkd4dt6LO7UBMcI16AyvMivtQcyHuV2pi6TN/mMW/77Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Z0oSvblp; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tiXsa-002IJY-5M; Thu, 13 Feb 2025 12:59:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=mjDeIQ/pGHjWGPnZsYZ5+UIGfRQ2k6pi8wwfapisHgc=; b=Z0oSvblpMI7OOYn7T+KThhrCye
	Ps7+vAqGhdQ7BeH2KO1NNIfEVKf33Uu3tPoYvv9xVS61ZUeRqPNafljhxxIXOCNA3yyj4Af5tCg4+
	qnSgZkFR1oOkDo7dmaDfH5XYLdllSpTEbDyyTcTeNCgwZNrJaqcIZY7lfFznBk2DCZ7GtnCto2C2X
	T05i6ln1u/nkdClbDm/HafdBYSH4KaNKP0/UnkP9rFiIPe+Mbtvbxenno7x4bxLH2A5LRkLRbsMdN
	kQhYcifMHtGz1UC0urZBdGNQY324e7z2qefl+tSdYrwNmOXb7ypFrpQ+U2AZZocxP+EpABfoP73au
	fCj+xGhA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tiXsZ-0004rA-ML; Thu, 13 Feb 2025 12:59:39 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tiXsC-008u87-Pg; Thu, 13 Feb 2025 12:59:16 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 13 Feb 2025 12:58:51 +0100
Subject: [PATCH net 3/4] selftest/bpf: Adapt vsock_delete_on_close to
 sockmap rejecting unconnected
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-vsock-listen-sockmap-nullptr-v1-3-994b7cd2f16b@rbox.co>
References: <20250213-vsock-listen-sockmap-nullptr-v1-0-994b7cd2f16b@rbox.co>
In-Reply-To: <20250213-vsock-listen-sockmap-nullptr-v1-0-994b7cd2f16b@rbox.co>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Bobby Eshleman <bobby.eshleman@bytedance.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Commit 515745445e92 ("selftest/bpf: Add test for vsock removal from sockmap
on close()") added test that checked if proto::close() callback was invoked
on AF_VSOCK socket release. I.e. it verified that a close()d vsock does
indeed get removed from the sockmap.

It was done simply by creating a socket pair and attempting to replace a
close()d one with its peer. Since, due to a recent change, sockmap does not
allow updating index with a non-established connectible vsock, redo it with
a freshly established one.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c       | 40 ++++++++++++----------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 884ad87783d59ef3d1ca84c3a542f3f8670cd463..21793d8c79e12b6e607f59ecebb26448c310044b 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -111,31 +111,35 @@ static void test_sockmap_create_update_free(enum bpf_map_type map_type)
 
 static void test_sockmap_vsock_delete_on_close(void)
 {
-	int err, c, p, map;
-	const int zero = 0;
-
-	err = create_pair(AF_VSOCK, SOCK_STREAM, &c, &p);
-	if (!ASSERT_OK(err, "create_pair(AF_VSOCK)"))
-		return;
+	int map, c, p, err, zero = 0;
 
 	map = bpf_map_create(BPF_MAP_TYPE_SOCKMAP, NULL, sizeof(int),
 			     sizeof(int), 1, NULL);
-	if (!ASSERT_GE(map, 0, "bpf_map_create")) {
-		close(c);
-		goto out;
-	}
+	if (!ASSERT_OK_FD(map, "bpf_map_create"))
+		return;
 
-	err = bpf_map_update_elem(map, &zero, &c, BPF_NOEXIST);
-	close(c);
-	if (!ASSERT_OK(err, "bpf_map_update"))
-		goto out;
+	err = create_pair(AF_VSOCK, SOCK_STREAM, &c, &p);
+	if (!ASSERT_OK(err, "create_pair"))
+		goto close_map;
 
-	err = bpf_map_update_elem(map, &zero, &p, BPF_NOEXIST);
+	if (xbpf_map_update_elem(map, &zero, &c, BPF_NOEXIST))
+		goto close_socks;
+
+	xclose(c);
+	xclose(p);
+
+	err = create_pair(AF_VSOCK, SOCK_STREAM, &c, &p);
+	if (!ASSERT_OK(err, "create_pair"))
+		goto close_map;
+
+	err = bpf_map_update_elem(map, &zero, &c, BPF_NOEXIST);
 	ASSERT_OK(err, "after close(), bpf_map_update");
 
-out:
-	close(p);
-	close(map);
+close_socks:
+	xclose(c);
+	xclose(p);
+close_map:
+	xclose(map);
 }
 
 static void test_skmsg_helpers(enum bpf_map_type map_type)

-- 
2.48.1


