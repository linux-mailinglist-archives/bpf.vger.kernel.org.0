Return-Path: <bpf+bounces-75169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3DCC748FD
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 15:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70A754E9018
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 14:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E71E33DEE7;
	Thu, 20 Nov 2025 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uvNo5V8N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425B12FE045
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763648464; cv=none; b=Ec+CDsOTozW6PDtM/+5EaKsh6Ilnps+WvaVopfypBwvPLqu3ZD/Dishvys57+/M0TjrxHSLAv1IfGSBZcJuPJJoVcun0q9A2MemWedKaqpn8r5/uX0U1faOETu3ycsQEEYfp8bAuUrEKB1dek9A8lb640dGOYp1Es7L3PU1i+54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763648464; c=relaxed/simple;
	bh=npKtL42Zbn688w2JWikPTfOZQQB4J4cWoQOD0/A1SSU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RMXXFScW+q51BMyH8HC9qXVGuPJjEVz+BvgxIIC0hIJOV0UoPk9GODY3IxsOYIdkL5/R5x31sOXTyIydhQT5q6fTtvPM3BOpHZhxCSb3Q0bR8PluPrqbWR1hYOqHBwniVi43LoPTN64h3M4W/EW8Vkf4k06h7MSPx1fGsO+Wn4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uvNo5V8N; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-6430b32e97dso1025986a12.0
        for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 06:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763648462; x=1764253262; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n6DTrx76GdebBIy9nQ0JqaQSfym5vrwd+zc+oXl+nn8=;
        b=uvNo5V8NmU9/i56YewpNL9CZhaf+jXXR/XYd2l9zHAw9H315DKCLsOckuz8mN45jEc
         PbJ2z6eL+SGppbjedax/3UydaM9g7GJBRoRl5RIEVq3sgf6Fgi+iPG6lfuMnCsQWHBvE
         bAFb4W63nHLKOwZ1E2tOmh6e9B1jBcsxZB4FNAWeqHyFCBBadMZC9FVhQhOfcuWqPxJI
         oN9I6GulLwzkKJ8gj1j4lpgsVtnXrlieeHBCUWt5xDt9BLLHRgdKwv27NaHyb5r24FxD
         535XsIXFSbOewgEN0zrv2rimXn6lozf0SUaY8D5yzs2/TsS1FTqS/vyqQzIItMleoAC2
         7o5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763648462; x=1764253262;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n6DTrx76GdebBIy9nQ0JqaQSfym5vrwd+zc+oXl+nn8=;
        b=wgT2tEb5zxfFWUMy4k18fGl66/MSM4dLSUbDU1tw0gjvjv39L7Yc+Gf7w7J9jvTkcN
         MzFy5+G5IH3rPN9O4mqUO03JoUeNf61L3iLNn7xlsz4bveuYTtS73bS0wQ0qbbuOenmG
         2JaggrKmdZ8NVyzWLjzaoCR5qO3Sjt6vnaIEYtr8yRqG6sN6VMf93IBVMAB9L5moV18E
         MJ/Ku6VARN/l2oXfx/d20lhn04P58oPi9mF1kZ10wrRF0HyrEPk/51Pp7FrylMi/MTXF
         qjvGZyQAaQasPh5KX0S3UfrpxBZHCNBOntCQEBwnuQtylKwi2mloTTVQ+ko+S8lF3afl
         yMdA==
X-Gm-Message-State: AOJu0YyqUDM2l5sTocMPkhR+LLhC0ZduV3H0ZSTZIXk5dBzz40J2lIzP
	xrgdfenWgjeMaf8PMQrdx5jbBK7Tg/+mJcJ7Ho0oK9AVjGAw1JOqGrt72W5fCXT11925zrvJoD4
	aL3JEcmYWrgcNZGcZVYZlvzUUvDkq2GvDdBYzZ4A1XovdwKPXBJkcQTuShzijYQ/XV3X5N8EnM3
	/ikGIjuVCXt2uakEDfuw68bJH17sC8MNMNqz8vVpHqLr5wi4TyFk/OfaL1aP42EuzStiQhsA==
X-Google-Smtp-Source: AGHT+IEYu9eHcspPdylNA3L5l733k3wmjKpHc0Ec+mPoUxVE3vDnyQXs9WblLLVwHlBLmuPlGnTeWvAxow84leZpOTpY
X-Received: from edbes15.prod.google.com ([2002:a05:6402:380f:b0:641:3344:d26c])
 (user=mattbobrowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:2687:b0:640:9b11:5d65 with SMTP id 4fb4d7f45d1cf-64536478b25mr2765450a12.24.1763648461520;
 Thu, 20 Nov 2025 06:21:01 -0800 (PST)
Date: Thu, 20 Nov 2025 14:20:59 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251120142059.2836181-1-mattbobrowski@google.com>
Subject: [PATCH bpf-next] selftests/bpf: skip test_perf_branches_hw() on
 unsupported platforms
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, 
	Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"

Gracefully skip the test_perf_branches_hw subtest on platforms that
do not support LBR or require specialized perf event attributes
to enable branch sampling.

For example, AMD's Milan (Zen 3) supports BRS rather than traditional
LBR. This requires specific configurations (attr.type = PERF_TYPE_RAW,
attr.config = RETIRED_TAKEN_BRANCH_INSTRUCTIONS) that differ from the
generic setup used within this test. Notably, it also probably doesn't
hold much value to special case perf event configurations for selected
micro architectures.

Fixes: 67306f84ca78c ("selftests/bpf: Add bpf_read_branch_records() selftest")
Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 tools/testing/selftests/bpf/prog_tests/perf_branches.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/perf_branches.c b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
index 1d51ec5f171a..0a7ef770c487 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_branches.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
@@ -128,11 +128,11 @@ static void test_perf_branches_hw(void)
 	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
 
 	/*
-	 * Some setups don't support branch records (virtual machines, !x86),
-	 * so skip test in this case.
+	 * Some setups don't support LBR (virtual machines, !x86, AMD Milan Zen
+	 * 3 which only supports BRS), so skip test in this case.
 	 */
 	if (pfd < 0) {
-		if (errno == ENOENT || errno == EOPNOTSUPP) {
+		if (errno == ENOENT || errno == EOPNOTSUPP || errno == EINVAL) {
 			printf("%s:SKIP:no PERF_SAMPLE_BRANCH_STACK\n",
 			       __func__);
 			test__skip();
-- 
2.52.0.rc1.455.g30608eb744-goog


