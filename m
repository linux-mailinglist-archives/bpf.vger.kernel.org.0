Return-Path: <bpf+bounces-19889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DDC83284F
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 12:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663C51F22DDA
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 11:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192004C60C;
	Fri, 19 Jan 2024 11:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZIC6tbO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958E01D690
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 11:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705662351; cv=none; b=LQsHfZBmpOEJHBHoVjc8Gcmh8fTTRGVTQQDCipBFqFypWVoFDssG4XThA0lsswT0C8nsqAatTYfo3eZmShKxckcCg5JIkg5pvsQGBpKyLortuM2MUYrcyfGNOC765BJah/CguZSCZ8TYAs5P3zmhzZGg8xGaMos6/LFcu/dlFdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705662351; c=relaxed/simple;
	bh=U4eDzzWCFm2He28k8q+/MSGBPbaMfcu8WYHJ6wVEoPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mz+pfDhiCppI1OO1rbmoEdB+iEzk9IG/Pt+kSLPfyPjcuE9pajffe3Jm4++wW7wv6pypBv7pN6b7VFeDscL97lJ4RUcjq8QK3AkbfbJUjc4Nj0ycAc9NFFZhuZgXV+kZYDaP7A3gGJEGEZr9THVLPTAZ3fRKAYiALFWqwLc797k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZIC6tbO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F53C433F1;
	Fri, 19 Jan 2024 11:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705662351;
	bh=U4eDzzWCFm2He28k8q+/MSGBPbaMfcu8WYHJ6wVEoPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MZIC6tbOEk/wSJXLHEDGUn7gUwWE8rqgrajgSi1htHxCnpu7PwZ2VGzLOyrbtMxjw
	 NIkO/AtMduevsJhrZmpdbFm6AbSuLEJ+8mINenP0yXoa4U7hyOMKDyTY9WYbS9XNvR
	 P0Verpj8Dm86Ns2Wao2JcyEJ7Cpd8nWieYNWCpTtSYkr9VHAyM3ai5TRJjHmdpq7Y7
	 a9CxOmHLNdMriQlvBWixbJxL4knAA5A8sxvjEbDvDYkdaFUb9eVlL6dNN4T3D/wKrc
	 avRRzY7vYLLTIOBiRUA3WZ+lQ6uXz+vAFBp8bzVKsrjMjITSdkSocGRqEBumUdWT+o
	 2qklS1UeuY+3A==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>,
	Quentin Monnet <quentin@isovalent.com>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>
Subject: [PATCHv2 bpf-next 3/8] bpftool: Fix wrong free call in do_show_link
Date: Fri, 19 Jan 2024 12:05:00 +0100
Message-ID: <20240119110505.400573-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119110505.400573-1-jolsa@kernel.org>
References: <20240119110505.400573-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error path frees wrong array, it should be ref_ctr_offsets.

Acked-by: Yafang Shao <laoar.shao@gmail.com>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
Fixes: a7795698f8b6 ("bpftool: Add support to display uprobe_multi links")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/bpf/bpftool/link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index cb46667a6b2e..35b6859dd7c3 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -977,7 +977,7 @@ static int do_show_link(int fd)
 			cookies = calloc(count, sizeof(__u64));
 			if (!cookies) {
 				p_err("mem alloc failed");
-				free(cookies);
+				free(ref_ctr_offsets);
 				free(offsets);
 				close(fd);
 				return -ENOMEM;
-- 
2.43.0


