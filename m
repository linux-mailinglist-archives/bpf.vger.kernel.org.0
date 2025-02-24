Return-Path: <bpf+bounces-52391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D4BA428FA
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 18:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76E6B19C1CF4
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 17:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4672673AB;
	Mon, 24 Feb 2025 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lKSG3ALO"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8152673A3
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416555; cv=none; b=lSPO6kWIp++BQH1TgeER7mBGIX9gB2+0gO/ubWDe3Vc1/1tNlPQ5lbdBgBr5nvy9JxwaMjkDvVCph6KFS30Uo4megs+TZ3vhUFVxCHNkuxXe+iCQ9BV0jUPKA/SW9kB7TMBKPMzFketscxVpX8n+85pk4108o+pg86ubXxFS1GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416555; c=relaxed/simple;
	bh=aG8o/kahVF1tm5V+3pDDlV1oJXm/dksJNGytP15/dhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S18s6P8rR5k1o+fgUGlybUtc7lbOif4ZmwDfWdTBFXzh2rsmeIzDnx2HZJ3MUhZdGb90xEkIFLQJZNlLAM3GvxlLfqJ5ZEP8dbxZAslcAt+LJz8G4tDs7kUlHrH0yGGJDny05SIp+IGb9HQHmyz/4COsiXsedzrUqnWNGdwGfZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lKSG3ALO; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740416552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7PGzrKBqkUWVbwyFTBIov9XC7SmgDrzD5PuL2n2Yx4M=;
	b=lKSG3ALOVcqBH1KgzjTr1euc/9OJwGCjz5RM3AN/1TuYVq8tQBSbRo91P3booy2s4BDbiU
	HtOhUDXeT3cwhignhs5lYMWWfo5Q480JdYieUP+7uIT13jyqEVFRJ6eoTBjA8PuAixSfnZ
	Ikp/S5ya+lttt1/bBwv6sOpVkVxg1mc=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	qmo@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chen.dylane@gmail.com,
	Tao Chen <chen.dylane@linux.dev>,
	Tao Chen <dylane.chen@didiglobal.com>
Subject: [PATCH bpf-next v8 2/5] libbpf: Init fd_array when prog probe load
Date: Tue, 25 Feb 2025 00:59:09 +0800
Message-Id: <20250224165912.599068-3-chen.dylane@linux.dev>
In-Reply-To: <20250224165912.599068-1-chen.dylane@linux.dev>
References: <20250224165912.599068-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

fd_array used to store module btf fd, which will
be used for kfunc probe in module btf.

Cc: Tao Chen <dylane.chen@didiglobal.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 tools/lib/bpf/libbpf_probes.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index a48a557314f6..de2b1205b436 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -102,12 +102,13 @@ __u32 get_kernel_version(void)
 
 static int probe_prog_load(enum bpf_prog_type prog_type,
 			   const struct bpf_insn *insns, size_t insns_cnt,
-			   char *log_buf, size_t log_buf_sz)
+			   int *fd_array, char *log_buf, size_t log_buf_sz)
 {
 	LIBBPF_OPTS(bpf_prog_load_opts, opts,
 		.log_buf = log_buf,
 		.log_size = log_buf_sz,
 		.log_level = log_buf ? 1 : 0,
+		.fd_array = fd_array,
 	);
 	int fd, err, exp_err = 0;
 	const char *exp_msg = NULL;
@@ -214,7 +215,7 @@ int libbpf_probe_bpf_prog_type(enum bpf_prog_type prog_type, const void *opts)
 	if (opts)
 		return libbpf_err(-EINVAL);
 
-	ret = probe_prog_load(prog_type, insns, insn_cnt, NULL, 0);
+	ret = probe_prog_load(prog_type, insns, insn_cnt, NULL, NULL, 0);
 	return libbpf_err(ret);
 }
 
@@ -448,7 +449,7 @@ int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helpe
 		return libbpf_err(-EOPNOTSUPP);
 
 	buf[0] = '\0';
-	ret = probe_prog_load(prog_type, insns, insn_cnt, buf, sizeof(buf));
+	ret = probe_prog_load(prog_type, insns, insn_cnt, NULL, buf, sizeof(buf));
 	if (ret < 0)
 		return libbpf_err(ret);
 
-- 
2.43.0


