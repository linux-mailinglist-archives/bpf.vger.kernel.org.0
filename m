Return-Path: <bpf+bounces-5448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A2275AD1B
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 13:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 241D6281E00
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 11:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C7C17AC9;
	Thu, 20 Jul 2023 11:37:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89281174E9
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 11:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43869C433C7;
	Thu, 20 Jul 2023 11:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689853027;
	bh=yhEUIQd1HY6fFBqpdGOt0VwfwP3SAZ4iQq3eIK3JuBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bBjjzI77uBY9iEZ9jlAzXYhrghapcpZ+rfQCZAvB/wjXv783AVPE/Vb/t4gjhkzJK
	 7L9CZPJyktkZrOUdDwzpcA5JS8GOpSmsntsUatRE/E54n4okOK/Kmf0JhNHsw+Xs5/
	 Yrg64k1rS6xcuf5TY1la8V5xuUUaMNlCZxJ68b26mZOu8MM+86veV0HkXnI15nXp+a
	 YUfME0Pxg6zkIQ8McWLrVBnPrnqq1BYbyrmltmPSUcpdz182J5EXaGnjtO6V+KR7QE
	 i9u5SHsx46P+NHb9XNhDivl2+Yr4DnktSfGeA6/JafgrjrxwgazVwEkh1XDeDU54ky
	 BuqqTVuuPLPbA==
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
Subject: [PATCHv4 bpf-next 07/28] libbpf: Add uprobe_multi attach type and link names
Date: Thu, 20 Jul 2023 13:35:29 +0200
Message-ID: <20230720113550.369257-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720113550.369257-1-jolsa@kernel.org>
References: <20230720113550.369257-1-jolsa@kernel.org>
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
index 63311a73c16d..4e758768174e 100644
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


