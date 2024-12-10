Return-Path: <bpf+bounces-46490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 359309EA71B
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 05:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 387381654E6
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 04:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C321322617A;
	Tue, 10 Dec 2024 04:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NX0pZ2j8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFECC226180
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 04:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733803883; cv=none; b=dy1AuXazmDoe4v7Y3v1FuE34ztoOgZWF/X2Kaa91/hPokCfg5JeUXyHXz4PN4VrcaUZIsEchCvU64i8+cOGn2O9b2knIg+Vi16AC0W24W1Zo/6I+Aw6I7Vv7o+jd2FUkRG6r+Xw/P4vetbr4I+KaquoaTucs7AaDkXDh9iduwN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733803883; c=relaxed/simple;
	bh=WU76+cksynlmlH8ydZBIUgNFS+SY2OPnYi1ZiU7RNF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dnc6THI12UO6giAjwWuNiyC2oU2ku7jPTZ63QwvuJJ9qJqfBIQO8nv+bwgAng7nbkbHXWql95DF1rlmiwLC+ejDki7b09HmHXO9ABs0X3iqz2Y8Dc1cwYZ6WF4bTF+19I2jTDa01uCLJAeCFmX6ONbLlXnZTNLVj4EUbatGX5M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NX0pZ2j8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21644aca3a0so20053365ad.3
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2024 20:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733803881; x=1734408681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0KYVZnEf1s3QKS8ZQMoh9wsEnzWG4BHfJNUsHf/R2k=;
        b=NX0pZ2j8MFep7oGiZKC9vm5YP69NV8iqgVlk+H8h7VSHiQoxuskNRnfCVE3mCoCjkA
         yUv97Xh5zxQ4lqL2qk93/fSpYvzp2vLvTkGubssBhziDriG3e+2h4nhNqogDZIMJlz7v
         uHZWgPmSzxxuLmSOQKRAdYJwdzQ2p6bW/SrMZp6YQIQejWFxqsYXs8g9NnwZo4y3Ful/
         YLttKO0D+rfWc0ECgoW7DgVikzKlKR/W7zBq6xkRqKAguLCuCItbUFZhiibb4Bmj7JMv
         0GQg83vXOctSzYLzLFRXas9xo4rDDBI8LuMK9cN9VtmgIM9rRUQcOZzDf5ubYUU1DING
         q1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733803881; x=1734408681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0KYVZnEf1s3QKS8ZQMoh9wsEnzWG4BHfJNUsHf/R2k=;
        b=bDxjOUBuIIL2iQ7k1OsnP2D/4TmQd9UGQts0grOmUIWML36+yxRwJlX46LIJJvtBZv
         J9Dm+QTHf8UvWTUP1IgKHgEoruddPIF113iGuYvqWHxjuIET70bqSIblSa+U+NeB1ZxE
         D4EHyNfO2gzUqhq+JfxgYTdGm0RZm1OfQbOrCKF5AqEKWaQYCCDwksNq4aBf4+q6vqhG
         g70vvVXDJkOq5cd/yajjww5XHPJx7ZKCiBRvIbG11DNi/ZXUaHOBXErLW2v6ex9LE1uI
         fvv2YCeFAyrYWUkRGHyNbAFa/kmCLPOP416wW6/3Kgw2F21T7X1mEehGXfkpE8gC98ao
         dHRg==
X-Gm-Message-State: AOJu0Yzf/xELBc6PYfgr6ybS0PmrlOIA6C+9zbzdfhEhQ03iIqROUld4
	kjM6YCeT4bW4nqjOCL2iuCn3qiHRfWd7VXkdwG6Ve+u8R5wIHHhEB72jIQ==
X-Gm-Gg: ASbGncuMvigObs7b/VLOue9/XyXLmH8L9iABnpkyYGe7VTLNcM9uhhVo5TS+3udmlqK
	OyQFFbn6I+B9U48FpTv69GLwQAE0D3Z0zqkjcrvB9LK+uwru8DR2pvV5zaEMmK/2cf3LeBzXRxr
	p/BbYfXg+sFEm39jRoNnE1dNrB6yMJQmwXthjPb47z9UTAPrRTy+y1+ZOTG5y3E5SNoUxUWuTQ5
	hNppSrh2G7IR4ug2Iogyi7lRpmcdGzc4nmY39uGvOC1R0WY7A==
X-Google-Smtp-Source: AGHT+IFzDhtP8nbAL+z30keWlB9m+08dZxFBC8CgXWUmAS6DTFL9DRZulSfXshp5qP2Zk2sjf/xDeA==
X-Received: by 2002:a17:902:d547:b0:215:72aa:693f with SMTP id d9443c01a7336-21669fc6680mr43609205ad.9.1733803881069;
        Mon, 09 Dec 2024 20:11:21 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21631d6b3b8sm44296265ad.136.2024.12.09.20.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 20:11:20 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	mejedi@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf v2 8/8] selftests/bpf: validate that tail call invalidates packet pointers
Date: Mon,  9 Dec 2024 20:11:00 -0800
Message-ID: <20241210041100.1898468-9-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241210041100.1898468-1-eddyz87@gmail.com>
References: <20241210041100.1898468-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test case with a tail call done from a global sub-program. Such
tails calls should be considered as invalidating packet pointers.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_sock.c       | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/testing/selftests/bpf/progs/verifier_sock.c
index 51826379a1aa..0d5e56dffabb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
@@ -50,6 +50,13 @@ struct {
 	__uint(map_flags, BPF_F_NO_PREALLOC);
 } sk_storage_map SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
 SEC("cgroup/skb")
 __description("skb->sk: no NULL check")
 __failure __msg("invalid mem access 'sock_common_or_null'")
@@ -1065,4 +1072,25 @@ int invalidate_pkt_pointers_from_global_func(struct __sk_buff *sk)
 	return TCX_PASS;
 }
 
+__noinline
+int tail_call(struct __sk_buff *sk)
+{
+	bpf_tail_call_static(sk, &jmp_table, 0);
+	return 0;
+}
+
+/* Tail calls invalidate packet pointers. */
+SEC("tc")
+__failure __msg("invalid mem access")
+int invalidate_pkt_pointers_by_tail_call(struct __sk_buff *sk)
+{
+	int *p = (void *)(long)sk->data;
+
+	if ((void *)(p + 1) > (void *)(long)sk->data_end)
+		return TCX_DROP;
+	tail_call(sk);
+	*p = 42; /* this is unsafe */
+	return TCX_PASS;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.0


