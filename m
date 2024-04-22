Return-Path: <bpf+bounces-27407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8C08ACC9F
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 14:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F9D1C20C47
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 12:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F991474B2;
	Mon, 22 Apr 2024 12:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lF6yFE7z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9282414658C
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 12:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713788021; cv=none; b=GBaHxb61LeoX9w6J9KPdO8+t7lIlBdajxX6BUXbICCX4+YmR20MG1DSvEQowO1gVBExgEmXgNiAy2BVrqQTqYTkx+zHxbMPHxripLd6lXVHjZuxNLsJRcWOQucvwFcpLWrqs4UwbKTiYzs3SJT5tsgVjyhZaGixOHsEDzoE+A78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713788021; c=relaxed/simple;
	bh=Zj88zs60vzj7pvwbftgluzpQMCuup6OtVIA0J/hK670=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szudrK2l3ST30yEw0JVWCV8fG2lGG4hmfTGlCPWOI1I7jStwTrVhBZeydNcDmxoa4J6kDSX6BTmnSXqGCqdUggzEbYxMesy3VRPl0ViuDnn4wGIJDKyvgw51UWdJPzn12qZu6fliIjy9fBWoZnVG2BqJKNZNEOVxt+bC+tRRu/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lF6yFE7z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F73C113CC;
	Mon, 22 Apr 2024 12:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713788021;
	bh=Zj88zs60vzj7pvwbftgluzpQMCuup6OtVIA0J/hK670=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lF6yFE7zfiCu42FDy803HqLgb4dc5xvVUgJ83K1qgrNVpuao0wHtPTuTD2N6XnVLV
	 ou5HrmmDCqeYp/1rlnDEI1eA86L1urKKmFJ41epiou4pCzrwTVYZNkZ+MRQiOoYA2u
	 3LxF0+MGn2KhDM+a1pUeR2G7hHdCihEt+8OgrMiGFZLogt+zNOlBhTiF0nZYa0Z6cd
	 DZAlu+DSgEl311oG0aJP10MmwVsKRcbDcg3I/oSL0TujTD6B5RG4EQpSgNkoVMY2jK
	 Z5rmcdvsy6Tn4nkyYfNg52TBNKoRyAm5i+zijYLkBDKx1H9NzhxzYwvpsL0UjnGS0n
	 y46ynvXZV3NWA==
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
	Viktor Malik <vmalik@redhat.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [PATCH bpf-next 5/7] libbpf: Add kprobe session attach type name to attach_type_name
Date: Mon, 22 Apr 2024 14:12:39 +0200
Message-ID: <20240422121241.1307168-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422121241.1307168-1-jolsa@kernel.org>
References: <20240422121241.1307168-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding kprobe session attach type name to attach_type_name,
so libbpf_bpf_attach_type_str returns proper string name for
BPF_TRACE_KPROBE_MULTI_SESSION attach type.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ca605240205f..9bf6cccb3443 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -132,6 +132,7 @@ static const char * const attach_type_name[] = {
 	[BPF_TRACE_UPROBE_MULTI]	= "trace_uprobe_multi",
 	[BPF_NETKIT_PRIMARY]		= "netkit_primary",
 	[BPF_NETKIT_PEER]		= "netkit_peer",
+	[BPF_TRACE_KPROBE_MULTI_SESSION]	= "trace_kprobe_multi_session",
 };
 
 static const char * const link_type_name[] = {
-- 
2.44.0


