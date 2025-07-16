Return-Path: <bpf+bounces-63417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE19B06FE2
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 10:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A71554A258D
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 08:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C9A290092;
	Wed, 16 Jul 2025 08:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fwNMCtyd"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165A128C5BD;
	Wed, 16 Jul 2025 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752653228; cv=none; b=tB3m/q1sT1kUahC62ali4q6P0BsLuZArsNz0GTQAt4wq+oLtWmsZVPRe23O52F/ERkynE3O9PEXA0NGMP6ZxDFM5tP+OYiBFpalvAvWaUOR2dS//RV+WkerbNG6b9nLLVBc96Vin77UryQm+HNHlirG/pvgG15bVkGyqn9F4s8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752653228; c=relaxed/simple;
	bh=ayHxBpN4uGhC/b6g9nomt23oIGGuXUEzuv2DpL/gQU4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qAzRbNPrfdB4Xwvdly9A/AJDL1WYeazb80NxI5dAVocfY3axZoxJpd57VfvUgPu2bgmMPRAnleI7sDPO5LiuLHhzXUFBWukXOzWCo1mVLLqRCve0bs4x5v4g/H9V1RdeibDmh4G+JcjyQ34ha9+GsplOfoxJixiQRedOYJjYtQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fwNMCtyd; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=CJ
	xtrUA6I85xMEwIipsLs6KMnjyjrsdi+D/HQcTK1yU=; b=fwNMCtydjtPZeXORTW
	p/adGYuIQTQ5r2KPBASIfzVzQZdE50pJ53OvSCdL2w4hYBHU2WQt9DYJGjngpa0k
	XqX7mcU7uxp6pcQxPhy5tiQTwlsT4tZF7UPlmrjtmrh77ACWjOacFjd3JZXdmZXl
	Hh93uei/nNeg10CFkLauGSBwE=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBnzbt4XXdoH4BLFA--.60318S2;
	Wed, 16 Jul 2025 16:06:17 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] libbpf: Fix macro redefined
Date: Wed, 16 Jul 2025 16:06:16 +0800
Message-Id: <20250716080616.1357793-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnzbt4XXdoH4BLFA--.60318S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw4xJrWDCr1fKw4xZr1kZrb_yoW8Kw1Dp3
	48A34Fkr1rXF4rJw1UJw4Yvw15Wr1vva18tF1kAw4UCws5Xws3Xr18KFy5t3s3WrWUWwsx
	ZFnxK398Ar18ZrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07USzuZUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiZQGMeGh3XPQRZwAAsR

From: Feng Yang <yangfeng@kylinos.cn>

When compiling a program that include <linux/bpf.h> and <bpf/bpf_helpers.h>, (For example: make samples/bpf)
the following warning will be generated:
In file included from tcp_dumpstats_kern.c:7:
samples/bpf/libbpf/include/bpf/bpf_helpers.h:321:9: warning: 'bpf_stream_printk' macro redefined [-Wmacro-redefined]
  321 | #define bpf_stream_printk(stream_id, fmt, args...)                              \
      |         ^
include/linux/bpf.h:3626:9: note: previous definition is here
 3626 | #define bpf_stream_printk(ss, ...) bpf_stream_stage_printk(&ss, __VA_ARGS__)
      |         ^

Therefore, similar to bpf_vprintk,
two underscores are added to distinguish it from bpf_stream_printk in bpf.h.

Fixes: 21a3afc76a31 ("libbpf: Add bpf_stream_printk() macro")
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 tools/lib/bpf/bpf_helpers.h                | 2 +-
 tools/testing/selftests/bpf/progs/stream.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 80c028540656..56391a7bee48 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -318,7 +318,7 @@ enum libbpf_tristate {
 extern int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *args,
 			      __u32 len__sz, void *aux__prog) __weak __ksym;
 
-#define bpf_stream_printk(stream_id, fmt, args...)				\
+#define __bpf_stream_printk(stream_id, fmt, args...)				\
 ({										\
 	static const char ___fmt[] = fmt;					\
 	unsigned long long ___param[___bpf_narg(args)];				\
diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
index 35790897dc87..1d0663d56c0a 100644
--- a/tools/testing/selftests/bpf/progs/stream.c
+++ b/tools/testing/selftests/bpf/progs/stream.c
@@ -29,7 +29,7 @@ int stream_exhaust(void *ctx)
 	/* Use global variable for loop convergence. */
 	size = 0;
 	bpf_repeat(BPF_MAX_LOOPS) {
-		if (bpf_stream_printk(BPF_STDOUT, _STR) == -ENOSPC && size == 99954)
+		if (__bpf_stream_printk(BPF_STDOUT, _STR) == -ENOSPC && size == 99954)
 			return 0;
 		size += sizeof(_STR) - 1;
 	}
@@ -72,7 +72,7 @@ SEC("syscall")
 __success __retval(0)
 int stream_syscall(void *ctx)
 {
-	bpf_stream_printk(BPF_STDOUT, "foo");
+	__bpf_stream_printk(BPF_STDOUT, "foo");
 	return 0;
 }
 
-- 
2.43.0


