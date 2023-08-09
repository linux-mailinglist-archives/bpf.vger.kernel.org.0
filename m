Return-Path: <bpf+bounces-7299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117DA7755AC
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 10:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 420951C211A4
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 08:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96721800E;
	Wed,  9 Aug 2023 08:35:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943C0613E
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 08:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B185C433C8;
	Wed,  9 Aug 2023 08:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691570157;
	bh=r6c2A5lJbrpkgWz+ZJ8Q0j5JelsZXiEoA5aRhiukCb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QFiegpIMuV1w46iPVbxQOfNo/SnYZEWSHiDmODygdtWLvCNu24nezb4XM/kCyNgF/
	 7mv/oP3R4faTXrzqwNLA0j9wARVjlZQLDvbZpFfUMSC9JryMrmnzK+OgetEdcMRuqC
	 vp218jDT5iQcWnTxDfg/0n56mVIYZoO5SluQCXf31ZUVn/hbIEFukhUEiRfmYYWlvL
	 bz4uyP40HV09yngdPElFAt8La/NXmtUzOqoZHjaDqRvFcn3DhnhwB3ku3WmbDLSLZt
	 hQhUF6CPsmLBwXpg1yjK0BCfKot+CZjduuPejA9v6INSTF2sg22Tt3yWrGd5G1GwuV
	 0NY3BkUflH5fQ==
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
	Hao Luo <haoluo@google.com>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCHv7 bpf-next 07/28] libbpf: Add uprobe_multi attach type and link names
Date: Wed,  9 Aug 2023 10:34:19 +0200
Message-ID: <20230809083440.3209381-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809083440.3209381-1-jolsa@kernel.org>
References: <20230809083440.3209381-1-jolsa@kernel.org>
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
index 17883f5a44b9..2fc98d857142 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -120,6 +120,7 @@ static const char * const attach_type_name[] = {
 	[BPF_NETFILTER]			= "netfilter",
 	[BPF_TCX_INGRESS]		= "tcx_ingress",
 	[BPF_TCX_EGRESS]		= "tcx_egress",
+	[BPF_TRACE_UPROBE_MULTI]	= "trace_uprobe_multi",
 };
 
 static const char * const link_type_name[] = {
@@ -135,6 +136,7 @@ static const char * const link_type_name[] = {
 	[BPF_LINK_TYPE_STRUCT_OPS]		= "struct_ops",
 	[BPF_LINK_TYPE_NETFILTER]		= "netfilter",
 	[BPF_LINK_TYPE_TCX]			= "tcx",
+	[BPF_LINK_TYPE_UPROBE_MULTI]		= "uprobe_multi",
 };
 
 static const char * const map_type_name[] = {
-- 
2.41.0


