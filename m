Return-Path: <bpf+bounces-28247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A79B8B7031
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 12:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1411F21AA4
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 10:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013E612D765;
	Tue, 30 Apr 2024 10:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifDCvrpN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A0012D74D;
	Tue, 30 Apr 2024 10:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714473824; cv=none; b=RwqURF5cor/wp9I0yByxy4Jj9vTsmF7iROKWihe5e5HwwjYqY8sy/adaskCoYlNG6tvTk4b7cZ+cVqI88DBevz5YcNtl27mPSUOr5/XlLMxP9RMGBUX6opfO90rYj2gW7+MZciSIdEHLn5AybwkbCV8TeOlwPwUVweTu+NloKOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714473824; c=relaxed/simple;
	bh=4M62uKbJjJpbp48Z33RrSvgDZmn03G5iR1xlxAVnPMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ni6HkmncsxAbBDBiQA0d2leUGKJlJg1Epn9UYoENPAkC5Skb1bgzIfbWaNblPmgcKKxr1STZipg7ULdShkixqB8SFrkEdJxsDMp7YqYi+P/R01F9L4lYstFr5mBtiiFNJqL64VfNBjDot8hXxVa+PnHeNssr3oJu0Sk3VhL5b38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifDCvrpN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF36C4AF1C;
	Tue, 30 Apr 2024 10:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714473824;
	bh=4M62uKbJjJpbp48Z33RrSvgDZmn03G5iR1xlxAVnPMY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ifDCvrpNhZFSHfxWm/v7XMNPAeGlZ9T0gqfQOn4+TYYFlhmFbBFiEzbQy6nZvO5fe
	 Plamzt3vHEMOsEa0r2VNpNntbo2UD9c4+hGXQr6XTGYIVQO9NGNvCE9qdYCTC9/zUA
	 /Mo/YhQ9YW1ITXJO/28abiE67diVegaHqwMQ6/pxU5RKz4uzuT5ywwASvLKmOIc6bK
	 PRFhPzROKzvUFT5YzpP9PPBAjKCcIN29mQXuFmrmRDPIXlDeVFTFydbPvHWgtOqEe5
	 DmXlbRZZ7nX0kJrerKXcLhzeH71CGR30Hq48cUxWuITTtDQEaQsNAbapaRv0mMuzMC
	 30NCnSuycGLAw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 30 Apr 2024 12:43:26 +0200
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: drop an unused local
 variable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-bpf-next-v3-3-27afe7f3b17c@kernel.org>
References: <20240430-bpf-next-v3-0-27afe7f3b17c@kernel.org>
In-Reply-To: <20240430-bpf-next-v3-0-27afe7f3b17c@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714473809; l=740;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=4M62uKbJjJpbp48Z33RrSvgDZmn03G5iR1xlxAVnPMY=;
 b=qxKGCgVmXoRpWZXc6rzS3G33goRV8NDVHOEjRqixiJUHAaLMZAkWomh6jDSmRaC8/wUWFHkxc
 ZldfzVkRELfCHB+OnO71VChr0jYnPLxYMKJc1SP+H0U63KkhD03azMq
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Some copy/paste leftover, this is never used

Fixes: e3d9eac99afd ("selftests/bpf: wq: add bpf_wq_init() checks")
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v3

no changes in v2
---
 tools/testing/selftests/bpf/prog_tests/wq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/selftests/bpf/prog_tests/wq.c
index c4bacd3160e1..99e438fe12ac 100644
--- a/tools/testing/selftests/bpf/prog_tests/wq.c
+++ b/tools/testing/selftests/bpf/prog_tests/wq.c
@@ -36,7 +36,5 @@ void serial_test_wq(void)
 
 void serial_test_failures_wq(void)
 {
-	LIBBPF_OPTS(bpf_test_run_opts, topts);
-
 	RUN_TESTS(wq_failures);
 }

-- 
2.44.0


