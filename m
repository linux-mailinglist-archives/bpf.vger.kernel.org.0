Return-Path: <bpf+bounces-13471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DE87DA0EB
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 20:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A738E1F2393E
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 18:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BFA3D986;
	Fri, 27 Oct 2023 18:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="BzISbJzd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K9RaMJh6"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E673CCE8
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 18:46:54 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49004128;
	Fri, 27 Oct 2023 11:46:48 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 8FA965C0225;
	Fri, 27 Oct 2023 14:46:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 27 Oct 2023 14:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1698432407; x=
	1698518807; bh=2fjiakLITSCXGyl83edKCDEBKH//aAV9purn7c7fwtY=; b=B
	zISbJzdokjCVKc7AaNFqcoQ4CyM1uafVunTRXmeK/8SkZGJYHuIh3gGYjYvelhia
	8FAks34jTt9U9RatVynlmEMQN/2kN1DtFeaYkmMs4Y1/TOBk03leFmd20ezAi3tf
	8nsyW7UCooG0IJm3iyFsBHHbWVU+FooruSGAEskYu54TttWAT4/CMSJYK9HyoMwM
	o7yMgqBdnQKOXfM/7qb6c2AG3PzuvMU/DqD+zTlTKDQNTu3UQhQXYwYyafOa+/lp
	DYs0vYJMNPXs2eYjcdvQlFmyPoNuOxoabGjAcJYemYWsOoJW+/1YYkEvf72SLzDV
	KIdlHZ2p8tsIUCa/9URKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698432407; x=
	1698518807; bh=2fjiakLITSCXGyl83edKCDEBKH//aAV9purn7c7fwtY=; b=K
	9RaMJh603U0B8Q69kyC5341nRwbxYA9Nybte5ysHVXdILhCt0FPX5F28sRfPTFqs
	ISw6GWa1I+V5Ue54wE0Kg+g+naF+LD3ROAqO3SJug/qc/bUhhl+/9EYSwZhQyxkH
	HIxOys7H+PY587lYNWGw3hvC3/zvNJlGajrooOzHXPNxbrrrlb4FC40vV9UV+Cgo
	DY/75ZBXO8MQcNHW60a0Xnpjv9tA0RP4nqCWMtNLfNoF5v73CcaB3pwqBI1Q2Aku
	05Y9m9Lr8brTQvrC3zSB7SnxCT/Bc6V4unoTRbN7eJniEpW1bgoowDGjvKrF1pEh
	qbWqJJ3hvq5lcmLY/8DWA==
X-ME-Sender: <xms:lwU8ZW11Yb53VW8nwcboQllEhYYXHIi9cjPnB_W4K0uJc2gqzNqfew>
    <xme:lwU8ZZEJca1vbGDUpWFoO-gdk9bn9VvMwrNgJVpSXOf5VsoUtiUeCfwX7TdZuzYA3
    _naQ1SnI3HRJBJKsw>
X-ME-Received: <xmr:lwU8Ze6wxe57-VVBYZ9aM7Fu6T50KOoaEENjz3J3kLNtWm_B4JMPEL80E-WnnK5Ka3xzGo8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggddufedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:lwU8ZX2VbQsiIgTBheTuvICIJe68E5tEBA4pVY3q6Da731U0a4S-VA>
    <xmx:lwU8ZZG4dsNEZlqgVDYYYu_RIT16vxyFd7fnhB_siJ-kPRrQuOmBDw>
    <xmx:lwU8ZQ948Ufy_gZuNetNO_cIcQwWi1D9nxrSBOtObhAVqX4bz7Q26g>
    <xmx:lwU8ZSLby36rDG6CqP6RAHymEk3-hhM7IYekSVELxjDiuJ6LXMMqTw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 14:46:46 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: andrii@kernel.org,
	ast@kernel.org,
	shuah@kernel.org,
	daniel@iogearbox.net,
	steffen.klassert@secunet.com,
	antony.antony@secunet.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devel@linux-ipsec.org
Subject: [RFC bpf-next 3/6] bpf: selftests: test_tunnel: Mount bpffs if necessary
Date: Fri, 27 Oct 2023 12:46:19 -0600
Message-ID: <f72e76f4fcfb6498562ce859b6d2e6f15e2bd435.1698431765.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1698431765.git.dxu@dxuuu.xyz>
References: <cover.1698431765.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, if bpffs was not already mounted, then the test suite would
fail during object file pinning steps. Fix by mounting bpffs if
necessary.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/test_tunnel.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_tunnel.sh b/tools/testing/selftests/bpf/test_tunnel.sh
index 85ba39992461..dd3c79129e87 100755
--- a/tools/testing/selftests/bpf/test_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tunnel.sh
@@ -46,7 +46,8 @@
 # 6) Forward the packet to the overlay tnl dev
 
 BPF_FILE="test_tunnel_kern.bpf.o"
-BPF_PIN_TUNNEL_DIR="/sys/fs/bpf/tc/tunnel"
+BPF_FS="/sys/fs/bpf"
+BPF_PIN_TUNNEL_DIR="${BPF_FS}/tc/tunnel"
 PING_ARG="-c 3 -w 10 -q"
 ret=0
 GREEN='\033[0;92m'
@@ -668,10 +669,20 @@ check_err()
 	fi
 }
 
+mount_bpffs()
+{
+	if ! mount | grep "bpf on /sys/fs/bpf" &>/dev/null; then
+		mount -t bpf bpf "$BPF_FS"
+	fi
+}
+
 bpf_tunnel_test()
 {
 	local errors=0
 
+	echo "Mounting bpffs..."
+	mount_bpffs
+
 	echo "Testing GRE tunnel..."
 	test_gre
 	errors=$(( $errors + $? ))
-- 
2.42.0


