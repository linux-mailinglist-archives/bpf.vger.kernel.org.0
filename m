Return-Path: <bpf+bounces-79566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6686DD3C0A6
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 08:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 617E84F7A1D
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 07:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFB53A7850;
	Tue, 20 Jan 2026 07:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhaGX7TJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4236A3A7832
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768894260; cv=none; b=YlhtrajM5x9fa6v7kUGDEF+V6+4Go7VrYoqKNr/Og0afsLPeGujbio7rjmEQnGQj3V/mgMSlPGyNxV0Ft3UAazCvgC3S4xUCw8+9WjgguEoSBLIgyTAwh5PatLrbKirJMqo7fT+HDBa7NgPaonMwuQcOQiyVknju9cMYxpu7xTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768894260; c=relaxed/simple;
	bh=TH+y/5eR44Gi6eHkf0DOaqZcfV5F48oCEnf4e49LNwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bbf2P+LX8k9PxDLqR+HZitYkWEbSsEd1lcMo5Kr6lnU6VHxHQyJVnssPeEE7rm+1ddtPYwr6J0YZKpDvPgkpn2AbZFTgidfoSogRFjdCFlWGVZKFg7k6PO8mJ2DTSPaLW5wC2T5JjFIKMn1wGCusw7wmbk+SkhRsfmhX0vLV/xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhaGX7TJ; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-81ecbdfdcebso2979010b3a.1
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 23:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768894258; x=1769499058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=akH5HXotpzW47WqMXlXGnxoszL9Ij3pR5J2SVW4ssXI=;
        b=AhaGX7TJNQAVHd7jStTmWvVtTmfZLWcE3Il/6qZ7ZiNRaR0GIbrQf9OD1OsX0d9+Gg
         QUhxZvJcfm3jc0kvivAuXdXDdCb/gsAUScy7iy5xyUSfRGjFz6SzrwKdVdci0lzIlhnj
         iZXm0jkGTgkx4+oZ+D2EVK8iQWVs1UhlKrfFy8kaVjmZNCPEkSTpv0YOWxKOg/oFCW05
         PDFg+Ka4QrH0TlYrXz4R/Nn90GjDtnL9/M6R5b1Y+1l5Q7m1Fs1R9ojTMGeXXXB27dQE
         v2SuMgWPwie+W4kiWyUYMRYc2GL94XxrUUiQ20Kz8tQrf5v2FM3978/jdszbZ/5w4xOw
         TjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768894258; x=1769499058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akH5HXotpzW47WqMXlXGnxoszL9Ij3pR5J2SVW4ssXI=;
        b=SJ9d6c1lunUShIRbgq6LLOK0wXItMcNb4oQ69t4pYOLzuzhP7q45UZI+aeaNcfoene
         xoaWolXxqv9RnqmsrQfC+Zs9+5u7z0oKKdugxLgKcGVS6FNbx667rrQRwH66N+Jji9mZ
         F6jwFgwG8iDF7jIV+j1a1s+22Z5z24CQ9b9RGKausr3Ma6N8opKxyhSFaHgcn2qW6ozg
         v9O7NnsyID1oVFIMvHDxhl+RdMB7diWUm4BGoIHEdl6ufGv631gd/GCppRX65pvRQYw5
         hezrlH/gjB/BJaOalyfsJBXqcbHJIan3YAjbK4XRhrGmITOe2XgFSS0C2yvSlKBuTGAm
         GYQA==
X-Forwarded-Encrypted: i=1; AJvYcCWiR/HYtSoh1vAki3HrOxQxqQrdDc0CJOXIfx7Dk1CtIy9jJqkQ1axTCHwik2JS4VWiIlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR/06341qoGo3DzZyo4C3fKTUlmzOc7v5BLKgD6ztoLiYuh7fr
	lENQKhqMchuRGNtfl948DuMBMgzenw6UxtqqSGFNKhjhbKNtVm1tusEG
X-Gm-Gg: AY/fxX6aUm8tONn05u/nI02IXKy8XNBel87rV+1aWSsX0/YPtUltznXh4NVS5RMn8HL
	QTO3zhc4Nhw2/2Y02H8diCODzkpyS+OFEZctQtnJsp6bLu3zxcNmDHIjJj1CKaLVsRKkntjzvEt
	S3Y7ft7rIcUKr9hKyGhyU2Si8/uoxycn6+cNBtr+KD+LO/JW0GoNXoUfhbO2B6syS16cnEcGa+S
	MvfcemPAxLikd+M+CjN/kk08bq+TU82ilS8WmKEk0HUVna3IMy99mwi7Xexoc6FvQP2wSXToWZF
	2IOVvsoTBnxmlhDLllsFtZMLnpOsGXheVgtm0LZAbyzSqDw5k7HhX2wn5qojPbE7DgoJUxSkNLe
	MEE6xeu6BnbKuoV1vPhQIs7a30y9aHyNBMnFsFcsicqd6uWECXECOsK9zDDAlvsUWg99B1xpcaH
	p4/GXXkAsU
X-Received: by 2002:a05:6a21:4d14:b0:366:14b0:4b03 with SMTP id adf61e73a8af0-38e00d6e972mr12419808637.63.1768894258319;
        Mon, 19 Jan 2026 23:30:58 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf2363e5sm10822395a12.4.2026.01.19.23.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 23:30:57 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org,
	yonghong.song@linux.dev
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 0/2] bpf: support bpf_get_func_arg() for BPF_TRACE_RAW_TP
Date: Tue, 20 Jan 2026 15:30:44 +0800
Message-ID: <20260120073046.324342-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support bpf_get_func_arg() for BPF_TRACE_RAW_TP by getting the function
argument count from "prog->aux->attach_func_proto" during verifier inline.

Changes v4 -> v3:
* fix the error of using bpf_get_func_arg() for BPF_TRACE_ITER
* https://lore.kernel.org/bpf/20260119023732.130642-1-dongml2@chinatelecom.cn/

Changes v3 -> v2:
* remove unnecessary NULL checking for prog->aux->attach_func_proto
* v2: https://lore.kernel.org/bpf/20260116071739.121182-1-dongml2@chinatelecom.cn/

Changes v2 -> v1:
* for nr_args, skip first 'void *__data' argument in btf_trace_##name
  typedef
* check the result4 and result5 in the selftests
* v1: https://lore.kernel.org/bpf/20260116035024.98214-1-dongml2@chinatelecom.cn/

Menglong Dong (2):
  bpf: support bpf_get_func_arg() for BPF_TRACE_RAW_TP
  selftests/bpf: test bpf_get_func_arg() for tp_btf

 kernel/bpf/verifier.c                         | 32 ++++++++++++--
 kernel/trace/bpf_trace.c                      |  4 ++
 .../bpf/prog_tests/get_func_args_test.c       |  3 ++
 .../selftests/bpf/progs/get_func_args_test.c  | 44 +++++++++++++++++++
 .../bpf/test_kmods/bpf_testmod-events.h       | 10 +++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  4 ++
 6 files changed, 93 insertions(+), 4 deletions(-)

-- 
2.52.0


