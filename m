Return-Path: <bpf+bounces-41985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5451499E27F
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 11:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8A91F232C8
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 09:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A591E0DB0;
	Tue, 15 Oct 2024 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iz9uYGXX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCA41D9A45
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983487; cv=none; b=UA+mwLzzURH2FM5yvDVqnn/7ElYVwgX6tDhuOyQ5Zc9nSm6B3Q856ByTlGU/Ct+/to7Ee0b7+YUD5cDYh7qFtCzeHnrC140HQb2ietqpsRDHabcfk/F4luHfKH7FeIhz3bSnPiweAiP8lSl7PG6qw6Gs3zjP2zrpGqGkZEOn9mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983487; c=relaxed/simple;
	bh=duof+l519DJRmJt0vEL9iIZDscSPcBGOX2moFFwv8XE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLkDajXZ06rYH0CG+IvZDPWfRSbv6PBfcXZrm+v5iLIKuDtDPY67WAaAGIItIqC5psaWK7zTwDV1lYbOz5REZYm3J3hrifq28DkzGY3e5c7z6wFJcQBLrwu5iygimq+CH1ONK+rO8fmMR5BR6cWti9rJQXACarZfbG5dm5aoqIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iz9uYGXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76C6C4CECE;
	Tue, 15 Oct 2024 09:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728983487;
	bh=duof+l519DJRmJt0vEL9iIZDscSPcBGOX2moFFwv8XE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iz9uYGXX4P9tdPXJaUlqeqnMZIECehXoyvYgIo0xZHAD6xz1bx6DmLfCqCku9ds9x
	 GtNAWQmX//uIjOf7yx6TB3Lx2nmX3G+3ZApDiJCjT0pm2ishuzO4qq2AlYL7xa8k5s
	 blS4HM1XDhOxF0GuKGy8NCx4TJzNDukR4ePxfgxpJvVi2t29cYVMIHeYc70AFerNnW
	 vAQv4dxrUYoarc2zsntzvqHwYF6wHPXmYPstRy/YCpNK9HVA8k59PD66y4RHQbCfMs
	 rBj0UwnGp2XAdOF2bmG7O+Co0yoTpHFd9Ged5fQzVp5Exxhs7YG5acJz5k82lhEV9f
	 lvQePrrxOjaDQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>
Subject: [PATCHv7 bpf-next 03/15] bpf: Allow return values 0 and 1 for kprobe session
Date: Tue, 15 Oct 2024 11:10:38 +0200
Message-ID: <20241015091050.3731669-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015091050.3731669-1-jolsa@kernel.org>
References: <20241015091050.3731669-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kprobe session program can return only 0 or 1,
instruct verifier to check for that.

Fixes: 535a3692ba72 ("bpf: Add support for kprobe session attach")
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/verifier.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f514247ba8ba..5c941fd1b141 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15915,6 +15915,15 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 			return -ENOTSUPP;
 		}
 		break;
+	case BPF_PROG_TYPE_KPROBE:
+		switch (env->prog->expected_attach_type) {
+		case BPF_TRACE_KPROBE_SESSION:
+			range = retval_range(0, 1);
+			break;
+		default:
+			return 0;
+		}
+		break;
 	case BPF_PROG_TYPE_SK_LOOKUP:
 		range = retval_range(SK_DROP, SK_PASS);
 		break;
-- 
2.46.2


