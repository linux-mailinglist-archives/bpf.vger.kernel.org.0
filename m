Return-Path: <bpf+bounces-73139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 813A5C23FDD
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 10:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB3E3188FE20
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 09:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CCD32E6AC;
	Fri, 31 Oct 2025 09:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="01K1rCA1"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8CD32D0EE
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 09:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901317; cv=none; b=hZ4pZR8Onw/Hnq4498ncJsraRgg2z+rUaNHCCUMRTtKukhMleuKSz5pxG29N4nOG3dz0LNUKjcVskdY+E2JxXxYkISRcIkySwVaeWZPbzhBQQVKHbIVS+h4lsjUxILT2yqyjJMp2mmXgWeWH/J2ax+NB7jw2DPZq7Fe163L5Cjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901317; c=relaxed/simple;
	bh=mqvC6RlbP3oeEflL7AIfw7ofEo2NITuMjz5Yg98lAwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LUitZN19dZzg1scihOiCIfKTFUwMdNkDfaKI/fMwqaUaDIljjUDxNowexXODLDCX1e6N7tHauuUJhKelpSu/fyInSAM5fO4EDthce56QDlapikTSI6YhCIsw4REtKmOWm/BWfICd1lZ8BCvBiQZpHLbCkxDydrbm/C/P8nWWC+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=01K1rCA1; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0643AC0E94E;
	Fri, 31 Oct 2025 09:01:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8229260704;
	Fri, 31 Oct 2025 09:01:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CCB3A1181083D;
	Fri, 31 Oct 2025 10:01:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761901313; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0dcDKq9UuBF20o0hyNzb1Nz3YZY3Z4xE5wso7h6K0Sc=;
	b=01K1rCA1W+aEl0wk61vycso2DndXwdNGIeDX8edqTDo0yicG1WoV+arUK21ttnUpUW13JZ
	CY5VaWWXoxoZP3+hclLqf3r6sF8bBRkXuLgun0QKW92EkwnZSHRCSAIfSPJ5C3WKo5eFh7
	2uJvgesb1oaxuN08rqH3dhrhgc1HOalZjgrm+TO2dP7SQ7ayfoWqxgkbCBDhm6/5kXj7FM
	evRBCgofpMNmwW2MzAKQPm7zuR6WdHsAPpxZU4G2+dFamfWruI2RQI0wtqohxkzNGsIxRV
	SxlvHKOeXPx1SNwTCeWVWR8jl0oIXz9JEmntQtMAp6Jvm93x/76SVPCYHg0Vvw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Fri, 31 Oct 2025 10:01:41 +0100
Subject: [PATCH bpf-next 1/3] selftests/bpf: skip tc_tunnel subtest if its
 setup fails
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251031-tc_tunnel_improv-v1-1-0ffe44d27eda@bootlin.com>
References: <20251031-tc_tunnel_improv-v1-0-0ffe44d27eda@bootlin.com>
In-Reply-To: <20251031-tc_tunnel_improv-v1-0-0ffe44d27eda@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

A subtest setup can fail in a wide variety of ways, so make sure not to
run it if an issue occurs during its setup. The return value is
already representing whether the setup succeeds or fails, it is just
about wiring it.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
index cf2e088bfe8e..1d8d38e67f8b 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
@@ -666,8 +666,8 @@ void test_tc_tunnel(void)
 		ret = build_subtest_name(cfg, cfg->name, TEST_NAME_MAX_LEN);
 		if (ret < 0 || !test__start_subtest(cfg->name))
 			continue;
-		subtest_setup(skel, cfg);
-		run_test(cfg);
+		if (subtest_setup(skel, cfg) == 0)
+			run_test(cfg);
 		subtest_cleanup(cfg);
 	}
 	cleanup();

-- 
2.51.1.dirty


