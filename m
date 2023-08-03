Return-Path: <bpf+bounces-6802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA82576E194
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 09:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64450281159
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 07:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4AC11CB2;
	Thu,  3 Aug 2023 07:35:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE619450
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 07:35:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B327EC433C8;
	Thu,  3 Aug 2023 07:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691048135;
	bh=r6c2A5lJbrpkgWz+ZJ8Q0j5JelsZXiEoA5aRhiukCb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tOD1+En9HtQQwjpFBqTAAp7TlmNY+95Yr+udAsZEajF2xOLmzc0O5ePT1Vy6b6NZj
	 WFKC8M3juoa1EfJ2BNQ9LDP6m9tPxnmdAB0wI5Xwvsp0O5DeIbTDij5Eovjc5+2P9I
	 +1cbQhLl31JXpsUox/Uu3V4FwSBEvzCiYk4fXg7BxT3o80IBcHnx3hynbdkcxZpkzE
	 ozFT4qIrY0bmClZygM9Qq9+hZSpKRDXJmfC4fLmNuPlFRslllzVvX5ybGr9cXQg3m8
	 O6k2YcEdyQMH02AOhInD6Sz/JX8BWozuuIkvoZZj3OAC8H38FHJm94l4PPCYYcF7XO
	 9VCalcolV90LA==
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
Subject: [PATCHv6 bpf-next 07/28] libbpf: Add uprobe_multi attach type and link names
Date: Thu,  3 Aug 2023 09:33:59 +0200
Message-ID: <20230803073420.1558613-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803073420.1558613-1-jolsa@kernel.org>
References: <20230803073420.1558613-1-jolsa@kernel.org>
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


