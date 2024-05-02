Return-Path: <bpf+bounces-28425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 332828B95A8
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 09:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2BE1F211CA
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 07:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBF023775;
	Thu,  2 May 2024 07:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzBlAOoK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080921CABF
	for <bpf@vger.kernel.org>; Thu,  2 May 2024 07:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636547; cv=none; b=KBqd+m7yZflNEQvR9f6m9QWnp5yoP3OKNvgEL1KoaxssLwx8svOBmMik1Cxpye/bn9u8AtgqwiurPuuJZINbmN0K52Xy2N2iydAbzCdqeTrO501ZaAjkyLzbCIkInCumPct1SaZG5EPgtySE0u8dnyb8aO4sARpmAC/GbZMda+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636547; c=relaxed/simple;
	bh=nNGpSxY5SpqRyrkjFP3vSGt+DLTDDxQ0JBKfzNT+SlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tA3Bg85T0i8lEW2OxO0HFseVo9iRydz+JisB8kyZSU1AyZAkVmGNCl1JcW2VQ2ITnY0sluOHwMWEjv1FXWMIxiseAdtmKnXdSXeE64N4vG5GhXfivOqqWzbpWf2F0kB8XpldRyrt1yCiZXHFAWqkKMlbejypiZ80nl5teY5akbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzBlAOoK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A4CC113CC;
	Thu,  2 May 2024 07:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714636546;
	bh=nNGpSxY5SpqRyrkjFP3vSGt+DLTDDxQ0JBKfzNT+SlE=;
	h=From:To:Cc:Subject:Date:From;
	b=XzBlAOoKn2ZrWWgFdA84pZE0VdNmezTQtWMwuF8nM8zrDM9CsT8UB+lx97c9nSCBC
	 9EZY4ffAsI2Rmc/WVTIy31N9FSDcBIfhzkekkthyKBUhiAn9E4j1v4oiYy4ovSY5hO
	 Uqnja/sUh6n+6tpdthonRWe3kfL2E1OF7q/WmsEg9SNZaUdCjXMwm3613wUYpDH/GZ
	 vP8v2PJfGjIELYCLRTCil3fExJqlKfQpbuudbLSKoRI9dwMOiamFOZhuRNTofP+sLi
	 CLVQjnpVOaesrmxFPKnDd7ABsctt5tZeHLVNocfO0RVrFQw2jTEfiJrEGuk8RQDy7D
	 Jw7BgdoSBNC3g==
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
Subject: [PATCH bpf-next 1/2] libbpf: Fix error message in attach_kprobe_session
Date: Thu,  2 May 2024 09:55:40 +0200
Message-ID: <20240502075541.1425761-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We just failed to retrieve pattern, so we need to print spec instead.

Fixes: 2ca178f02b2f ("libbpf: Add support for kprobe session attach")
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4ffc8873d1ad..68c87aed8335 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11605,7 +11605,7 @@ static int attach_kprobe_session(const struct bpf_program *prog, long cookie,
 	spec = prog->sec_name + sizeof("kprobe.session/") - 1;
 	n = sscanf(spec, "%m[a-zA-Z0-9_.*?]", &pattern);
 	if (n < 1) {
-		pr_warn("kprobe session pattern is invalid: %s\n", pattern);
+		pr_warn("kprobe session pattern is invalid: %s\n", spec);
 		return -EINVAL;
 	}
 
-- 
2.44.0


