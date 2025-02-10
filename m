Return-Path: <bpf+bounces-50912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11052A2E3F4
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 07:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31B833A90BD
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 06:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530B31A23A0;
	Mon, 10 Feb 2025 06:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFIkO2hO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708F61A8F8E;
	Mon, 10 Feb 2025 06:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739167211; cv=none; b=V3b8DZLloG41RS0mjmrOx3ghsK5iRMNXkI6dMTkKaZVldjKwAYgTFOeCq748fRwcxSGQty0TKcn7fJoq0Ui+xcTqB8QnJ4ivzOTcUFaySA8A0vptMRlbS+ZY8Q1ANMdc+s3ysMhzoRgDEb49x44h0Vz73DeCUFupindFDDeEPBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739167211; c=relaxed/simple;
	bh=a4ECPYDwfk63dHhyrW+wHnNNRmnBF5bgFkDjFdSmp2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EFEF5KsCwmkOa0qNFYSQhI41bfwnvX29I62cKpcfxZpL/kDXEXeKvP5FczJ6196h4QV3CKyv8jimyHMZf4U3dUGEK/0DoqTcCBkGYIO3om8WhN7iBf8lLoyJzCiM488gEWTUDJAsRl6hmR4ms/Fu6FBrxt4nPkPw9pYiY4mG23Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFIkO2hO; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fa0f222530so7298451a91.0;
        Sun, 09 Feb 2025 22:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739167210; x=1739772010; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K/Fl6jr3f6WWgFY+GTM3oxPBToNoP/PIu+n5lwCsix8=;
        b=KFIkO2hOkqTlCrLq/S4dOOZnGMUrQImc93i336Ead+IAJOPImYmgGvbX7JUVNQ4i01
         +0BYhbLNkeWnGhmI7NX0R3y2ex+h7o/hJKxLmuEyd3EARk1yrK0plxCL6B5H/zxlKN2Y
         r2tiVIaclrUeYD0iI9UC+dVY+7juvIzN+GrM+JpPp4xZ553nJf6u+SVapybvT3OXYzMJ
         3FfoWt0YM3cd0yaN61PAuVkEO5+kaPRTDJYzD1Ihv4Jws/3taIqVpBFrT/uvpAzTeveq
         Cq4Mq1G15mup/xKsjJqhFEMjL/Tk6J7N0VIb/0DEqtQVCn08WKV1XHrRUn53bMfcimQO
         TBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739167210; x=1739772010;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K/Fl6jr3f6WWgFY+GTM3oxPBToNoP/PIu+n5lwCsix8=;
        b=W9vl3s58DR5XjQr1R5t05lXLn/5eEsmDBEer7/YKMtP1PW6Zp+kA+zPM0ltbcdVYXj
         8FCBekRQxM9i6UFODVk3o/njKKpIPix6h43wzbvruhGNjyMp+XC0OBeUJxDZeKSR8wrt
         xPFtmd/w0W46dpvHxU4a32esDZFbIlb9MHcgsRJyXcXrS8QoVzTwXSFFlZ4aCP+et2og
         MKNSniIWR94GdEQu2EXNcdsF4jiFK24Ammjr6kTeAXIiUDAyQxCBqH+m9wytDQxI4Aon
         nRJ/V+rKxwfKvqdLUlFrFh4h2Qvzze5DuHzwJy3NdZR9KjPdaD34ohfWeoiR8ybvl20l
         wA8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyX+NLqf06y8PrmtHo9LT5FzjAUtAVSM6ctTY/boUVh3yiXIUbzJjifT5EggyPAWXqpjzjhGWRij90W+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyQHRu601rvTPowy4dcT6boEFf7EcekCpBEsSlO/K2C/I3he16
	JCw8dmDcbZHmfs0LCdFwIG32l2/z1zbr0dpIUB/Ltu6Mj9vrF/mZ
X-Gm-Gg: ASbGncuCxdBzNnUUdVQ/gRUQDOS6lwGngWzYMfO6BIDcR3xIjnCa0RX319FS9nOwcg9
	jdiFWeyj8TFHHs74L/k8vx8+XLIJzvARJXlHo4gARlcZSCQQMJLwlf/EHka3LyH1drI+XMxNGhR
	VikFr9jtRfxBYdJOQkCDt+0RwTUFE2TRJx+31CUE8SrjOMGg+XHpfoxL7ARbw7LZ3G964F8/aL3
	NZK8RF85HcQfGUwKyJEtzQQHS/KeHTdEz5vDHn7OAgbGScAHo9RlfR+Z9Y9iApszYNNSR9PhHyQ
	T/s3uNmNi2XkKDkN
X-Google-Smtp-Source: AGHT+IHA4z2IgOPPasPSgVPIyJo5HZe1oRWA5x5B52aNFPs0Of2D/sJuZ1ciasAmOyZjy4nTc6TxpA==
X-Received: by 2002:a17:90b:510e:b0:2ee:70cb:a500 with SMTP id 98e67ed59e1d1-2fa23f563b2mr17621444a91.1.1739167209573;
        Sun, 09 Feb 2025 22:00:09 -0800 (PST)
Received: from localhost ([111.229.209.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa2716c1ecsm5872099a91.25.2025.02.09.22.00.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Feb 2025 22:00:09 -0800 (PST)
From: Tao Chen <chen.dylane@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	qmo@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chen.dylane@gmail.com
Subject: [PATCH bpf-next v5 2/4] libbpf: Init fd_array when prog probe load
Date: Mon, 10 Feb 2025 13:59:43 +0800
Message-Id: <20250210055945.27192-3-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250210055945.27192-1-chen.dylane@gmail.com>
References: <20250210055945.27192-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

fd_array used to store module btf fd, which will
be used for kfunc probe in module btf.

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 tools/lib/bpf/libbpf_probes.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index aeb4fd97d801..e142130cb83c 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -102,12 +102,15 @@ __u32 get_kernel_version(void)
 
 static int probe_prog_load(enum bpf_prog_type prog_type,
 			   const struct bpf_insn *insns, size_t insns_cnt,
+			   int *fd_array, size_t fd_array_cnt,
 			   char *log_buf, size_t log_buf_sz)
 {
 	LIBBPF_OPTS(bpf_prog_load_opts, opts,
 		.log_buf = log_buf,
 		.log_size = log_buf_sz,
 		.log_level = log_buf ? 1 : 0,
+		.fd_array = fd_array,
+		.fd_array_cnt = fd_array_cnt,
 	);
 	int fd, err, exp_err = 0;
 	const char *exp_msg = NULL;
@@ -214,7 +217,7 @@ int libbpf_probe_bpf_prog_type(enum bpf_prog_type prog_type, const void *opts)
 	if (opts)
 		return libbpf_err(-EINVAL);
 
-	ret = probe_prog_load(prog_type, insns, insn_cnt, NULL, 0);
+	ret = probe_prog_load(prog_type, insns, insn_cnt, NULL, 0, NULL, 0);
 	return libbpf_err(ret);
 }
 
@@ -448,7 +451,7 @@ int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helpe
 		return -EOPNOTSUPP;
 
 	buf[0] = '\0';
-	ret = probe_prog_load(prog_type, insns, insn_cnt, buf, sizeof(buf));
+	ret = probe_prog_load(prog_type, insns, insn_cnt, NULL, 0, buf, sizeof(buf));
 	if (ret < 0)
 		return libbpf_err(ret);
 
-- 
2.43.0


