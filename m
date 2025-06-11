Return-Path: <bpf+bounces-60335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A6EAD5B06
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 17:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 481607A8E92
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 15:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9051A1DDA14;
	Wed, 11 Jun 2025 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BLMetV01"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29219198E75
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749656974; cv=none; b=H3sJmO/4HOlIx6kUFl6H/+BRA9KPHHH4Q7GjlSA/LngQ6EFecK1QUciBapIR6C34s0H1sz1+glg3v1exuzPTkszlKJv44cGH+VioXoRre8Y0iWC1KVwdc7RHvgffJ0XPGihrNjrcuJjt4YmUCnouwVszIm4By1xzu3Sb6+nLec8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749656974; c=relaxed/simple;
	bh=Vsu5Xaf2CfmWYXrEWUU8kTg6xy3/CnahfubB8AomyEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dncJRD9nOpjZrsdcvYkxd2CfccDyNQ8uHadiFb/G4K5K4GAr1MRjBv/suIeI85s0iKBmv5NZ3r2PFI1g9Yus7+jBZ5z/wo42zqDVLhXSK87Dx3X+clSbiW9VqQ7wzQM1/2xFRgNIlZ12hswHopIjCQCr+w52ofYIXiH5Ug7o85Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BLMetV01; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749656960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NkpbyMsiJRwWnx6iOR+RLlbhyzNlbJ3e38I3A+4NmfI=;
	b=BLMetV01lS4FXWjpoxALr+a7Mi0irlvKqYcAZBywjBIwgNGKzGMwf6SP0SwobrqhyTbR8H
	NQ/nTgeRdr9+LbZ4t/A+vxRUTO28kF4R6uvFYTrAwmTj5i/qgFhOAX9bHiICSohUcwmfK3
	WvRPHYKGvp0Puq6S/5gBm2Q5AFHG7m4=
From: Tao Chen <chen.dylane@linux.dev>
To: kpsingh@kernel.org,
	mattbobrowski@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next] bpf: clear user buf when bpf_d_path failed
Date: Wed, 11 Jun 2025 23:48:58 +0800
Message-ID: <20250611154859.259682-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The bpf_d_path() function may fail. If it does,
clear the user buf, like bpf_probe_read etc.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/trace/bpf_trace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0998cbbb963..bb1003cb271 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -916,11 +916,14 @@ BPF_CALL_3(bpf_d_path, struct path *, path, char *, buf, u32, sz)
 	 * potentially broken verifier.
 	 */
 	len = copy_from_kernel_nofault(&copy, path, sizeof(*path));
-	if (len < 0)
+	if (len < 0) {
+		memset(buf, 0, sz);
 		return len;
+	}
 
 	p = d_path(&copy, buf, sz);
 	if (IS_ERR(p)) {
+		memset(buf, 0, sz);
 		len = PTR_ERR(p);
 	} else {
 		len = buf + sz - p;
-- 
2.48.1


