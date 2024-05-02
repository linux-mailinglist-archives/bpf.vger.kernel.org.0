Return-Path: <bpf+bounces-28426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7868B95AA
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 09:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780ED281D3B
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 07:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5B022F00;
	Thu,  2 May 2024 07:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eT1Lxt6O"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F681CABF
	for <bpf@vger.kernel.org>; Thu,  2 May 2024 07:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636557; cv=none; b=LSeMuGsc7pIjJ0ucCoKyUBDnsGrFk5EHOBMoCEs6bh25j6ZwGOVeX/zbYJ8SBNqtM/foOzHTpULTNVFa6ea0u+M+rArP3t8r8fzOxD9PXBgtC2KxcJYfg8XdFLJOYBZUYDH/pkYnOIsec5QvV3hqbhc6edlmEgl9e/BkJ7Y3kDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636557; c=relaxed/simple;
	bh=a1yQUjLv/Wezwq7B2NlgBDrzS6PkOaAvjVoMLhhylVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bmm3b7+7rezi9iPaag9MSMdi/1DxPkeu2XPhVKtbyxUpQD1hOz4tZc57UFR5b4Ri4j3iA9rgpJPGBqhuq30dPiAdGIrixLDV4U6Zdf5bthykR1GZYSwlH0CndirQs3zR1LSavMdqeguu3PXv6lLJSIzCtKgfn5m36fltLGCu0Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eT1Lxt6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459F4C113CC;
	Thu,  2 May 2024 07:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714636557;
	bh=a1yQUjLv/Wezwq7B2NlgBDrzS6PkOaAvjVoMLhhylVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eT1Lxt6OYzyAnPuJ8aQiut2IiDUW+1vw7fN66IWetGYyXrGFo4OLqVQeX45cQZjHz
	 4cEh3RCYDemiIx8Ez9XYQz19YJEe1yafj6AvCr03QsFVHuFVWzF1wCMvpXu+YITPbh
	 54KkHTg8CJefnjD5RE94rJ7mNHKOwKv1ok9MHCBg9nOXjXhoDVqGPWyPPVsT/51dyu
	 fr9eUtjvLZhVRA0U0ZFXxZoPi75rJJS8yG8q3FLl+12XZ9NwRsYulcl7B+nTIBmp8A
	 syviycH/DLjonkTEwCmQbbxgToVRVDHSNX/Vtnd6gMSJG/AqUDq7dj2GrqhuCJjzRn
	 T9nYZxsITRGgA==
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
Subject: [PATCH bpf-next 2/2] libbpf: Fix error message in attach_kprobe_multi
Date: Thu,  2 May 2024 09:55:41 +0200
Message-ID: <20240502075541.1425761-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502075541.1425761-1-jolsa@kernel.org>
References: <20240502075541.1425761-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We just failed to retrieve pattern, so we need to print spec instead.

Fixes: ddc6b04989eb ("libbpf: Add bpf_program__attach_kprobe_multi_opts function")
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 68c87aed8335..a3566a456bc8 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11579,7 +11579,7 @@ static int attach_kprobe_multi(const struct bpf_program *prog, long cookie, stru
 
 	n = sscanf(spec, "%m[a-zA-Z0-9_.*?]", &pattern);
 	if (n < 1) {
-		pr_warn("kprobe multi pattern is invalid: %s\n", pattern);
+		pr_warn("kprobe multi pattern is invalid: %s\n", spec);
 		return -EINVAL;
 	}
 
-- 
2.44.0


