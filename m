Return-Path: <bpf+bounces-30669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 090D58D049E
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 16:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C01B1F20846
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 14:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3504A169AF0;
	Mon, 27 May 2024 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljaiOn2P"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5052169ADD;
	Mon, 27 May 2024 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819592; cv=none; b=Z24hleKr427PWELOK6gyJSySMc+xUGAPQMuHgWfYWM2TB2WPF2zKwb72RLf5WbnfitB/IuI+ybbeaaTjGoWorl2TOmh6BVfkXlzynCRJWulwz/plKRSMqPX2b/ME2Yhbp3Vw2gbz4DDwoaeQxvTgIjNyS7Dkqd5bROei33XQZ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819592; c=relaxed/simple;
	bh=egnv+4LYG9kf+MAFhOdp1ZtsU4oJCToVCs7HH+OYNpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oz3cOOSxUqMqyzKtk0/HV0ToEUuVl/Q2q1NM9kgRs0hWYd1squ9aFy9Ls65OARW755WV8eIcuADcj/gOBJzrA2rjcGLalFo6n8ITdrejENj/FWBvmG2zfXb6TKt6gBDB91Z0snTVu1Xj50ZELMCbfSJ7G6P0RWFRFsgZZtdW6K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljaiOn2P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51524C2BBFC;
	Mon, 27 May 2024 14:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819592;
	bh=egnv+4LYG9kf+MAFhOdp1ZtsU4oJCToVCs7HH+OYNpM=;
	h=From:To:Cc:Subject:Date:From;
	b=ljaiOn2PmkfYv6gOTLOT8ZuL5QBDlHtu3fs4MPkkJE9MI2Crwt8PZAjPsr6EPaxXd
	 GQ89mz7LsMm81s0zqzkys7anU0pw8znASvtpcUcK8x9FzvhuPCfxVtHKRuArFzGOlL
	 CxOHdl0/vodjnQlVOpYpSKZQHIYE4/1oBJAhdEoI9deU2ZxcRZSByyvcFRqcBu2lB5
	 C7rCIzghfwJ8EnnjUdVjjN+2d8wu+OKRn8f9PDArkt/UyW9c+IkxRtkn3tyQxyxVKK
	 jHJcvf1aF+T0RezMYU2iDwLRf4uc4YDVtu4xfP7s8SwHlILS8dnxDI2VkT6QZ72coC
	 2uwXiCkEdnhwg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 1/6] selftests/bpf: Prevent client connect before server bind in test_tc_tunnel.sh
Date: Mon, 27 May 2024 10:19:38 -0400
Message-ID: <20240527141950.3854993-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.277
Content-Transfer-Encoding: 8bit

From: "Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>

[ Upstream commit f803bcf9208a2540acb4c32bdc3616673169f490 ]

In some systems, the netcat server can incur in delay to start listening.
When this happens, the test can randomly fail in various points.
This is an example error message:

   # ip gre none gso
   # encap 192.168.1.1 to 192.168.1.2, type gre, mac none len 2000
   # test basic connectivity
   # Ncat: Connection refused.

The issue stems from a race condition between the netcat client and server.
The test author had addressed this problem by implementing a sleep, which
I have removed in this patch.
This patch introduces a function capable of sleeping for up to two seconds.
However, it can terminate the waiting period early if the port is reported
to be listening.

Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20240314105911.213411-1-alessandro.carminati@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/test_tc_tunnel.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_tc_tunnel.sh b/tools/testing/selftests/bpf/test_tc_tunnel.sh
index 7c76b841b17bb..21bde60c95230 100755
--- a/tools/testing/selftests/bpf/test_tc_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tc_tunnel.sh
@@ -71,7 +71,6 @@ cleanup() {
 server_listen() {
 	ip netns exec "${ns2}" nc "${netcat_opt}" -l -p "${port}" > "${outfile}" &
 	server_pid=$!
-	sleep 0.2
 }
 
 client_connect() {
@@ -92,6 +91,16 @@ verify_data() {
 	fi
 }
 
+wait_for_port() {
+	for i in $(seq 20); do
+		if ip netns exec "${ns2}" ss ${2:--4}OHntl | grep -q "$1"; then
+			return 0
+		fi
+		sleep 0.1
+	done
+	return 1
+}
+
 set -e
 
 # no arguments: automated test, run all
@@ -183,6 +192,7 @@ setup
 # basic communication works
 echo "test basic connectivity"
 server_listen
+wait_for_port ${port} ${netcat_opt}
 client_connect
 verify_data
 
@@ -194,6 +204,7 @@ ip netns exec "${ns1}" tc filter add dev veth1 egress \
 	section "encap_${tuntype}_${mac}"
 echo "test bpf encap without decap (expect failure)"
 server_listen
+wait_for_port ${port} ${netcat_opt}
 ! client_connect
 
 if [[ "$tuntype" =~ "udp" ]]; then
-- 
2.43.0


