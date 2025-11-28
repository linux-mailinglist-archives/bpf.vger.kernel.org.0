Return-Path: <bpf+bounces-75732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 129C9C933F9
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 23:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC7E3A8530
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 22:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1828B2E7161;
	Fri, 28 Nov 2025 22:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ObyN1uex"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C507123771E
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 22:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764368855; cv=none; b=ZsYFJP70WWFj9q2aziktozU8v37sCLJHsy5zvv8CR0q2hhpS7svw2ZGUgih/W9Gtdd61mPx4WRlKTC18ZZs77NUABMF7coT0cZl7pTgoebVSbS6WsTurFMN6XqFINCX57eP8M8DN2xCeSoHwgwv2f0jSyFNXnIaeVuqRYe2FaY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764368855; c=relaxed/simple;
	bh=JX0o+gm3xx81oqa0eTkLZHo6ONFpwD4veDJzYGki53U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O5rxYHAcvY7T4swmRaLTDDPjTWZP2kS3S5ETN9BXWdt6GKRPAOJs3IQ5DrLMhFWJlzrNEveiZJmvSYfn6xIQO5MD7JLJa/68VyQHFARNP8RA5oHDDyn37fTZx6/GD0S8SvZsdiLeW5fTKQjXyoCQWjp6CwNxflxTamMg60Ct1Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ObyN1uex; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E9BD91A1E0E;
	Fri, 28 Nov 2025 22:27:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A76F460706;
	Fri, 28 Nov 2025 22:27:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EADFD10B02591;
	Fri, 28 Nov 2025 23:27:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764368849; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=gJFuWuF1PYpp3arAX/2vf8j40Ht8TZE3eBL5QYj1HQY=;
	b=ObyN1uex6n/75zyEUaZwm8Po7G68WyyPUFxZtWS55ZvsAgoHFVF2GpAwyGfKvJSq12vHPt
	PwEvgjXwqO4KXmBnWS+vKPfX+CGDfQttPd6aHFJvi8zSW71XdxMHIUXdmS3WPYzMKtrF7E
	KCnLewrIpjcp/ojU7msV9iyOjmvk6/ZXi7ZLker2Y1M4l+LM5VMFxMCZpQKRW5T8s0Jtn4
	mwhl6e5JUV3qTKWfhHB47UJYuN8Pxveuzz4FAsblqUBuU9BEH6uiNUlUj67eGVVEezPstM
	yDqcl/ndtc/nuX4mfxXZwmp2zySUdpMFG0BTU+LwnYPVsmFLaimjS6bkwRjjnw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH bpf-next v2 0/4] selftests/bpf: convert test_tc_edt.sh into
 test_progs
Date: Fri, 28 Nov 2025 23:27:17 +0100
Message-Id: <20251128-tc_edt-v2-0-26db48373e73@bootlin.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMUhKmkC/zWNQQqDMBBFryKzbkomiSBd9R5FRM1YB9pEkhAsk
 rs3SLt8vM/7B0QKTBFuzQGBMkf2roK6NDCvo3uSYFsZlFQtSi1FmgeySWgaO+qstmgI6ngLtPB
 +hh4wbYtwtCfoq1k5Jh8+50PG0/9i+I9lFFK0Vpux7ZRGY+6T9+nF7jr7N/SllC/QYruhqAAAA
 A==
X-Change-ID: 20251030-tc_edt-3ea8e8d3d14e
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Hello,
this is a (late) v2 to my first attempt to convert the test_tc_edt
script to test_progs. This new version is way simpler, thanks to
Martin's suggestion about properly using the existing network_helpers
rather than reinventing the wheel. It also fixes a small bug in the
measured effective rate.

The converted test roughly follows the original script logic, with two
veths in two namespaces, a TCP connection between a client and a server,
and the client pushing a specific amount of data. Time is recorded
before and after the transmission to compute the effective rate.

There are two knobs driving the robustness of the test in CI:
- the amount of pushed data (the higher, the more precise is the
  effective rate)
- the tolerated error margin

The original test was configured with a 20s duration and a 1% error
margin. The new test is configured with 1MB of data being pushed and a
2% error margin, to:
- make the duration tolerable in CI
- while keeping enough margin for rate measure fluctuations depending on
  the CI machines load

This has been run multiple times locally to ensure that those values are
sane, and once in CI before sending the series, but I suggest to let it
live a few days in CI to see how it really behaves. 

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v2:
- drop custom client/server management
- update bpf program now that server pushes data
- fix effective rate computation
- Link to v1: https://lore.kernel.org/r/20251031-tc_edt-v1-0-5d34a5823144@bootlin.com

---
Alexis Lothoré (eBPF Foundation) (4):
      selftests/bpf: rename test_tc_edt.bpf.c section to expose program type
      selftests/bpf: integrate test_tc_edt into test_progs
      selftests/bpf: remove test_tc_edt.sh
      selftests/bpf: do not hardcode target rate in test_tc_edt BPF program

 tools/testing/selftests/bpf/Makefile               |   2 -
 .../testing/selftests/bpf/prog_tests/test_tc_edt.c | 145 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_tc_edt.c    |  11 +-
 tools/testing/selftests/bpf/test_tc_edt.sh         | 100 --------------
 4 files changed, 151 insertions(+), 107 deletions(-)
---
base-commit: 233a075a1b27070af76d64541cf001340ecff917
change-id: 20251030-tc_edt-3ea8e8d3d14e

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


