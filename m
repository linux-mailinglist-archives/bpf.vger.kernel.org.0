Return-Path: <bpf+bounces-19801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0316C83163C
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 10:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B9BA1C209CA
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 09:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E0B200A0;
	Thu, 18 Jan 2024 09:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5LeSz2W"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955721BDFD
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 09:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705571699; cv=none; b=PGwJYjqiEDnmwIXIYAEfPeOS5R5bKcPOEobt3NiatzSk1BQBjsm28Bgy4S7I77QJp3dxkzI2J8FBJTWP3HqoII+1/l2jUUW3CXxCkNnFo9X2UoZ004UeipbEtbx1p9nUlLcUm0WHCGHGJd1isi6uBzr9wLJQvHSZgziJ1xKafPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705571699; c=relaxed/simple;
	bh=sD6sFiP1ARpihYE09l9b5H1x3RwRMSAeKvwG4AV5qWg=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=gKHjIBLzH80Pa9ibq6NV0ZTafbKdrDU5heY4zngIkxg0DS0/NiBz8WsHJP3oA50DeeAXgodwtPCUFS2Qb6G+uoM+Fqc6ftzRHWAj7fZAZZSWVMwKplhZqurIdTsh/+aPfYKDJtj/54kSXcYVcyk7KEZNQaftSiRKm1s58kTkp5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5LeSz2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA66BC433F1;
	Thu, 18 Jan 2024 09:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705571699;
	bh=sD6sFiP1ARpihYE09l9b5H1x3RwRMSAeKvwG4AV5qWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K5LeSz2WghoP5j7CqSpaX/E7CNUzJDgP0k8OS8yT3KAFVgGqrdttGo5yfWSG+JiGI
	 VvNfOwCzl+Mpz2KWVwPX3NObnx+Yqck7hnpb5tqRltsGjikbfDaNm4TLB5FEi5Nk2A
	 weu0ptwdjNSnVma4wiEGRAiJLM+kNieI16nRUFTORdDhXRMgdyxKZAG8WM5IFn85vv
	 1W1Sg5BC74hUuJA8rVXZ9d19HWP/0n4Du7vMoc/njmSbg78y2M5CzPO/w+CcXgBRrQ
	 aA4+0KyHn7sbaS0jhngDhsOQwo7Vsti1UHVjYsjcMkdUAtmnXFoqmepHgCzAddDD88
	 6/uOEk/mEytQQ==
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
	Yafang Shao <laoar.shao@gmail.com>,
	Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 3/8] bpftool: Fix wrong free call in do_show_link
Date: Thu, 18 Jan 2024 10:54:11 +0100
Message-ID: <20240118095416.989152-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118095416.989152-1-jolsa@kernel.org>
References: <20240118095416.989152-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error path frees wrong array, it should be ref_ctr_offsets.

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


