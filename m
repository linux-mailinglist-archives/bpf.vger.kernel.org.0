Return-Path: <bpf+bounces-33517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2C191E597
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 18:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476CC1F21D9D
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 16:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E8416E869;
	Mon,  1 Jul 2024 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFzSXf4r"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CE916DEA8;
	Mon,  1 Jul 2024 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852181; cv=none; b=EuG5S//dPA1vPoUmDvJez4a4fjLhylxgt5RmZ08RLvXFO/4I8UPcVLv4WyZdBeuvBVLyCUgJHY6ERpJj4I38P/oKEWRBloiPQeE50Ys+HzrNSrTi4PTUvioR/vQ/l3tqfcuRjRpZRH2KgpW/CTldElp6dI/qBcaHL7dbI9+AdJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852181; c=relaxed/simple;
	bh=gG84DeAaodLa3Fp+CwvCwEEBgnOJ9khtc9sE+yhKlT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHU6O3qF+qp+bBye8/pjLu2DHuAG3wagVAfEyus9vvancuxqi73vIlS2UypngAHigtv+NJaY5Ac+Dvwx1g/gr4cwk2uX240FHNq/mN0tP8EuxATrHeZkDpZHW2DlitF2AK5Qpc/0yH54VHSMWSm17rWrh1iyd5AkYOkuwnKGMjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFzSXf4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52112C2BD10;
	Mon,  1 Jul 2024 16:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719852180;
	bh=gG84DeAaodLa3Fp+CwvCwEEBgnOJ9khtc9sE+yhKlT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WFzSXf4r9phWB8cBrmkGepdyAmDwyHcUIyWUgnnN1T0JbG1PGgLneVKyLiDpEOrZf
	 CnHaGM5NNPKrPFT1UTKa3yhnM2H3pfIpksPE6iZWRxZSgsbUi9ad6XxxtXN8WwS7Ss
	 gaxOWSf1uPwiyHLWRS0UN30vBIEazbbSXKC0YNQl1yvdM4RhZB8CSiVS70K3tqvULx
	 2BBGinCaYRMUTt4G+QFor8KngpSawteWTz1vEE60fIViciUVjj68DSQtUsVtHct5FC
	 38MBZMT3kLb4TIcroy6FcBzit7FuzkbkfzKvCsGEFmlxHfCuun3hDKpx5EpmMahNbo
	 n+cVmDUze1RIg==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv2 bpf-next 5/9] libbpf: Add uprobe session attach type names to attach_type_name
Date: Mon,  1 Jul 2024 18:41:11 +0200
Message-ID: <20240701164115.723677-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701164115.723677-1-jolsa@kernel.org>
References: <20240701164115.723677-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding uprobe session attach type name to attach_type_name,
so libbpf_bpf_attach_type_str returns proper string name for
BPF_TRACE_UPROBE_SESSION attach type.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 492a8eb4d047..e69a54264580 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -133,6 +133,7 @@ static const char * const attach_type_name[] = {
 	[BPF_NETKIT_PRIMARY]		= "netkit_primary",
 	[BPF_NETKIT_PEER]		= "netkit_peer",
 	[BPF_TRACE_KPROBE_SESSION]	= "trace_kprobe_session",
+	[BPF_TRACE_UPROBE_SESSION]	= "trace_uprobe_session",
 };
 
 static const char * const link_type_name[] = {
-- 
2.45.2


