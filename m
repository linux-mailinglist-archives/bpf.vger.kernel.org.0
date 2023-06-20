Return-Path: <bpf+bounces-2885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0A673665E
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 10:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 681D6280FB0
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 08:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2B6C125;
	Tue, 20 Jun 2023 08:36:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9A6AD56
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 08:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1877C433C0;
	Tue, 20 Jun 2023 08:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687250204;
	bh=h//siKybRBzMTZgE+8dt4NYeHULN+9EGiD1YACvFZDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MPAK2AzzmGcS73XYJqKszO4y8q13fFVoahcpij8v0zLRmhdEFzxTWzsJzo1H7cxVC
	 cPL162TRhJCJr8tmsjokx2wQ80wjoS9bS4O6AS7JgSOiZYTTklxS4p3r3i4vKGSmNW
	 J1ba1Y5lrGN1TdWeJWrtpPKkaiJMTGw/21ZjTrpPa4/N8B2+6O00h8pwwkmVEjrQbm
	 4gcZXZn5bxXjq4fP2MA1X9GREIPViLmSL7fP6Va6Z024VB5nT99NRsJPkVKR2iPEAS
	 3aas/3Avkb0Kqzz0ZhF2tqiI8FP942CelPl5kDvNaaW2ku9KiMCRJx4wl07hpimOIz
	 tNvlA0tlAG5VQ==
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
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>
Subject: [PATCHv2 bpf-next 05/24] libbpf: Add uprobe_multi attach type and link names
Date: Tue, 20 Jun 2023 10:35:31 +0200
Message-ID: <20230620083550.690426-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620083550.690426-1-jolsa@kernel.org>
References: <20230620083550.690426-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding new uprobe_multi attach type and link names,
so the functions can resolve the new values.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 47632606b06d..af52188daa80 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -117,6 +117,7 @@ static const char * const attach_type_name[] = {
 	[BPF_PERF_EVENT]		= "perf_event",
 	[BPF_TRACE_KPROBE_MULTI]	= "trace_kprobe_multi",
 	[BPF_STRUCT_OPS]		= "struct_ops",
+	[BPF_TRACE_UPROBE_MULTI]	= "trace_uprobe_multi",
 };
 
 static const char * const link_type_name[] = {
@@ -131,6 +132,7 @@ static const char * const link_type_name[] = {
 	[BPF_LINK_TYPE_KPROBE_MULTI]		= "kprobe_multi",
 	[BPF_LINK_TYPE_STRUCT_OPS]		= "struct_ops",
 	[BPF_LINK_TYPE_NETFILTER]		= "netfilter",
+	[BPF_LINK_TYPE_UPROBE_MULTI]		= "uprobe_multi",
 };
 
 static const char * const map_type_name[] = {
-- 
2.41.0


