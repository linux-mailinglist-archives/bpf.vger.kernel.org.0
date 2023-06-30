Return-Path: <bpf+bounces-3773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5080D743753
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 10:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81DBF1C20BDD
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 08:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB465A957;
	Fri, 30 Jun 2023 08:35:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BFDA932
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 08:35:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CB0C433C8;
	Fri, 30 Jun 2023 08:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688114101;
	bh=BOzTSYYk9hcQZWt1tInRxMn1KtcTN4kfX+JokwRYB1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i1LPi8i78Lz+Zue2ZJbLSeQg3VMn0nPtjYhW3xdA4SleoFaGYg3lA7VfzP70uzxx4
	 eYBj3efa+AWVOFO1DccPxx1jJDc62/X9ZguW0wOgmMHR5wF5Ipf4VW8ABt7ZNn69J0
	 l64AickeWixMjZRQi+ZzAgstVSDX/ztQeW1Tt7gqZVnc/LUJKVA+Hf4fWFHcVhwvl1
	 hYYfM7elPenCm0cO3QqMieRmrFpunocIxxlqpXUSoEsK+atintKTENbgHSo9VIiX+I
	 M3a6vHxqvd3CsnSDkkgARFJVsx8NEv7LKdf2gvtIC2bE3E0mWrhOwf+b/lMwJSBTQ2
	 laaqGWrC2GC8Q==
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
Subject: [PATCHv3 bpf-next 06/26] libbpf: Add uprobe_multi attach type and link names
Date: Fri, 30 Jun 2023 10:33:24 +0200
Message-ID: <20230630083344.984305-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630083344.984305-1-jolsa@kernel.org>
References: <20230630083344.984305-1-jolsa@kernel.org>
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
index 214f828ece6b..53dcf25c4878 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -118,6 +118,7 @@ static const char * const attach_type_name[] = {
 	[BPF_TRACE_KPROBE_MULTI]	= "trace_kprobe_multi",
 	[BPF_STRUCT_OPS]		= "struct_ops",
 	[BPF_NETFILTER]			= "netfilter",
+	[BPF_TRACE_UPROBE_MULTI]	= "trace_uprobe_multi",
 };
 
 static const char * const link_type_name[] = {
@@ -132,6 +133,7 @@ static const char * const link_type_name[] = {
 	[BPF_LINK_TYPE_KPROBE_MULTI]		= "kprobe_multi",
 	[BPF_LINK_TYPE_STRUCT_OPS]		= "struct_ops",
 	[BPF_LINK_TYPE_NETFILTER]		= "netfilter",
+	[BPF_LINK_TYPE_UPROBE_MULTI]		= "uprobe_multi",
 };
 
 static const char * const map_type_name[] = {
-- 
2.41.0


