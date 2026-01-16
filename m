Return-Path: <bpf+bounces-79196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF48D2D0C4
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 08:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13997303C981
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 07:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F352D47F4;
	Fri, 16 Jan 2026 07:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCDTJ2dR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759A8277C86
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 07:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768547873; cv=none; b=obzZ6q+b/n4NVtNetTophTQR0i6N/1MIsW6rOolfG8Ib87FoEthIr4kI1lg7Ph/D5rq2bDigWfWDyho2M1SONtHhpuAGp8SFbyHn/XgWhhev1nU8wGL/002hHePgFZX8Zzwk0oMGjxwkXrjRRnHyv/6ONrk98fwbA98/Hnwji7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768547873; c=relaxed/simple;
	bh=Z93SUl7nMLrO2bqrwRew+vNiuicAAkaUil6fIQl8jh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ohoL31fk//bt1N/a88rNN3UEHKrJTVumdUu7FVr5dQz2gQ3XpG7kKteEF2GMAq/tm5hrZ99TE2QVRwK+KdI/2tM65Ire9m8JVmqqPpIgm/2bvU5ivO2CE6kNjuBvj0ZRJ6ET8jAlo9hFW7UhxgcTUxg/cayrkzXRnbfiWZX+EWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCDTJ2dR; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a3e76d0f64so14104255ad.1
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 23:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768547872; x=1769152672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5xPODHYPomoRZ00DJDJzyRPo7BF3mCMV2J77rSXUqtQ=;
        b=LCDTJ2dRdfknhOnOt/FNB9AgS9TOoda6UYZM8z3GBAW4FB1fLlvbf+i94cBgZuHHlH
         JxXZIX8E4P1+x/WjWDOAH9IiKBcG6DUu4K2DawJiHZn7FRhg5E1c7Sm9/+KnbYSTIQwi
         wTxHztpOvUGttApLXTZDVZrnJlczCwd+MElm65CI9ChwiO100F7QUV8rycvwDEsO81FT
         dMBulDQPykgwXjxDHwfsn1KWJEQbUXLajhe+/xfhPQf5cAYYuKPJOsyIeiSMIt+IoQ4O
         HMTeT8WaTgpmikQsJtBGP5KxK7/4bvVj6yohv5Mt38qTb01aAE5saZld/S2kxeprYpMb
         aSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768547872; x=1769152672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xPODHYPomoRZ00DJDJzyRPo7BF3mCMV2J77rSXUqtQ=;
        b=U3UBnWCwXX9YI5e2g9NYTVJwYxibFoWS3c/nTP0+JGKevdNJqAd6UV4WRYIcMafx6B
         jYP0h3C40p7bwyrWJir4PTOEC8RRpj+OfMkJOHvQ85RuO5aZlbCwsOqAvvvHelOBVMxj
         R5lbrA7W5m6J15uJTfRnkSt9Y42w6acgou3a8ZWzslMUh1ksIj7+QFpHw0J8nTsNGV4z
         BGAK0cqnsAVFcjZk+2Yyatw5XIkT68hKufCLNVPRk0PzVGda/xa6gmMS+j0QIwSNT06g
         m6sI9bk71B8BJhKrb25r8ScjopplIcXrvuXLFEtX4pDz0qG4OnVyW7pwcPIT+BKBDsNp
         2bNw==
X-Forwarded-Encrypted: i=1; AJvYcCXhb8aCGhcFENcf5khIvwQgcbd6reCIOBM9Zb5monlvHwamX7NKzAxOPmRSh5tGrEjS2xI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+uCIticDDYAYQcbkGLNsOeKXHuN+2QJRdgT8VETYCHAFmtf4g
	INQWAZNAngxIhIBdMURJKdruTRf2ZiIrXrHIbFYtfcN/nZbVFb8pY5Zvwyk0pIVsR4c=
X-Gm-Gg: AY/fxX5SRuiZxMmjdWKXhD06C1FOa8IWvdFGXV4gaXdPxxBApncBX3efVuZ60IuEwBQ
	rjKyg8ZwWnBn1scXjBTC/8k9d5exmKrGpGq7l2fSmIyYRu+YPtYx2IGWOpoaEx89st0/3MAUX6H
	clHsVOF1wvo1ZpePFwRrplmvXvp+XJKw3oe8Md/otsyP/gqzIRWOfQHkFgUWvL07cSKyKjG047r
	be0igERyJMXy1lhpbSrkzmqR8NuDnz6HXCsRK2N3TXvvVM5Acc7BVfWktopfUdx4RqkKNldF2yI
	J4LCbo1D6U1x2lSqEOg8cTVDnkVf+xW925VTD6DjEOqDj3C1cD4qg78XLOHjjdnx86KZylZ3bJm
	5FehLYsEcli3OIefjIRXG31bmumz5YX8Q3ARE83T2/2HzgkyoK95zPlDCSOu7MsNpioH0rZQ88Z
	81hNpXotorsHi8WaloNg==
X-Received: by 2002:a17:903:2f07:b0:2a0:eaf5:5cd8 with SMTP id d9443c01a7336-2a7009919c4mr48883165ad.9.1768547871787;
        Thu, 15 Jan 2026 23:17:51 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce2ebsm12508275ad.32.2026.01.15.23.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 23:17:51 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
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
Subject: [PATCH bpf-next v2 0/2] bpf: support bpf_get_func_arg() for BPF_TRACE_RAW_TP
Date: Fri, 16 Jan 2026 15:17:37 +0800
Message-ID: <20260116071739.121182-1-dongml2@chinatelecom.cn>
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

Changes v2 -> v1:
* for nr_args, skip first 'void *__data' argument in btf_trace_##name
  typedef
* check the result4 and result5 in the selftests
* v1: https://lore.kernel.org/bpf/20260116035024.98214-1-dongml2@chinatelecom.cn/

Menglong Dong (2):
  bpf: support bpf_get_func_arg() for BPF_TRACE_RAW_TP
  selftests/bpf: test bpf_get_func_arg() for tp_btf

 kernel/bpf/verifier.c                         | 36 +++++++++++++--
 kernel/trace/bpf_trace.c                      |  4 +-
 .../bpf/prog_tests/get_func_args_test.c       |  3 ++
 .../selftests/bpf/progs/get_func_args_test.c  | 45 +++++++++++++++++++
 .../bpf/test_kmods/bpf_testmod-events.h       | 10 +++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  4 ++
 6 files changed, 96 insertions(+), 6 deletions(-)

-- 
2.52.0


