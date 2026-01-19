Return-Path: <bpf+bounces-79399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B28D39C67
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 03:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 047153008885
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 02:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0941D2459EA;
	Mon, 19 Jan 2026 02:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kF43OmrW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B2215746F
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 02:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768790264; cv=none; b=n8M6oR/J4J7pl08lBAkEBD3QyJdFlnniIcxfeWIhYuUGdPMxq3islacU+LOjz6LvwWlkwtlgGrbbN4PQ5OsEfmHaUMSNdLnBPasmBUW44ESkP8aJXq75gzXXuDNnUOZp/RHRMIeyKOcZ44/eVfmu6R++iwNfZx+GkmhESMTpZBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768790264; c=relaxed/simple;
	bh=vE4UtI7vsbPwN5O8TTJQLR2y0P2gdea4s1NbUI9fIOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eou4nHghtB1SnnTwQLttUX7tA3NKTTHxmNqp0VBip6OEsJekZKDCAkW/tOdYnqsL1isY3RI907nBH4qMR4XKWXejv4dK84OdI4V06jx9QDpcHX/D0XIa7jUppv2pkLq0PW5w1UkWT24VbvBL13xDHILXeGAbnlaQJ/ui2LLIP6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kF43OmrW; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-81e98a1f55eso1915920b3a.3
        for <bpf@vger.kernel.org>; Sun, 18 Jan 2026 18:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768790263; x=1769395063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AXD7gkLP0fle4I19z7dPAe1rEcwBG5fmCSuAh6ILdaQ=;
        b=kF43OmrWd0S9EqfALeJnEIEsBmdNc3Pa8JH4A+HAcmisuL5ToejBuQMhpmgR6Xwvik
         jvBQQ1+O9hzqUtPPAgLFA63oF82c1cR0qhTEFmlRP49w38+uAyqUwQL5PxMkrNER12Yi
         QWWnPxp60DdyTkDrNh0/45IB1PFdBn7jMPKFCiPvVO0m3rd6T5xTim0i6jHTV1ZGPUrq
         cmYoQs7KSTCRbnsOz7p7Gu+hvDiY7uRJ3YuPtGu0I/TCzEJkKL/+qgyaAmHrbOG5cDzD
         vDwkMS9aiQdQYkZ/4gHqlLuitzc6Nx6zYchx+ZY1na7WzBAQjAXh4OqKLiepNn5e+Xak
         LMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768790263; x=1769395063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXD7gkLP0fle4I19z7dPAe1rEcwBG5fmCSuAh6ILdaQ=;
        b=L0EwN58slo31zgx12u25liSQVmgdpGX+ntkYbr/yXcFJHjJ0yp/ulqYrzJpObL2sw+
         oMBUPaXezQXlRcTKtd5W9Mf03mx+7bCO2bORPZRTfUN/dAzHp+j6QVM2z1JbmYn/gUvd
         +j7nfFJSpluGW1oWvxw/4JjpiAC/aJgHLBCzKHg+dH71f1nGHg+ug8scVRsHpJqDqQuT
         9wXWrqMYjFEr+KMPcrk85WqGn0Cg3eAdslIxt8r/KWASpi7gt15OPFO7tzrTdILSFhLw
         J54zbAef+/8tFJ2txchufpw51f2EK0U8J8DSsGkm0bLc1gZXbBxXLoRhMXcySqfAANUx
         DjFg==
X-Forwarded-Encrypted: i=1; AJvYcCWNj6ft+wI024O1hgu9ptB6FWdJ03ht9/F8u7laMBMLfBPULd18HATtHd8MewG2VnBzDWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuRNnCyoZTPZ8B7fUNV8DL9lfcS/AaCfIFGvh/aTZmDJhHciSP
	6TTvw2vPSLogXFTA3VIgLBwIuNaSjlpCsI3H51uTgmPd+26Kl+v2iASd
X-Gm-Gg: AY/fxX6dPX+8k4/7JY1t4U5T3s6aJtVXmZtK70H1HLAwqIPUAFEz0WfeCsE35bNucGG
	Ry7QGeOQOmDKDm0eNl8y4fHZCPlAA/X7GYvH5rZR0jlAJIWpPtDcEsLq5anyQO0u37rQrAY1nKY
	64zljNSWNzkaV7bIy/A1Kum65Npt8ftSJulbxbdwBzui7PyLBPdlFVDGf85skb9wIYGGcbD4QJK
	bD1h3A2vavgH/nDiB4K31VtiGBtFtyN0yuCEC8PEhyzPXTJwmCM30ZKp5LXzudyyeFUbZHkVQoa
	w8W25OxY2oVQkzRnAsqczb3YsqArN1Ik+1wuj70q9+feYore8TblMVU8/LGUT60GSJPaEjRiRln
	whu5lzv72n4UOGMjW9fy6bkrnSIBhgf6O2C53OqRPL46GA59G8YKeupXYMljZNA86B+RWLVA1GP
	J2c066BF3D
X-Received: by 2002:a05:6a21:101:b0:366:14ac:8c70 with SMTP id adf61e73a8af0-38e00da3cabmr7501977637.70.1768790262809;
        Sun, 18 Jan 2026 18:37:42 -0800 (PST)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190c9ee9sm77154645ad.22.2026.01.18.18.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 18:37:42 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org,
	ast@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
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
Subject: [PATCH bpf-next v3 0/2] bpf: support bpf_get_func_arg() for BPF_TRACE_RAW_TP
Date: Mon, 19 Jan 2026 10:37:30 +0800
Message-ID: <20260119023732.130642-1-dongml2@chinatelecom.cn>
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

 kernel/bpf/verifier.c                         | 32 +++++++++++--
 kernel/trace/bpf_trace.c                      |  4 +-
 .../bpf/prog_tests/get_func_args_test.c       |  3 ++
 .../selftests/bpf/progs/get_func_args_test.c  | 45 +++++++++++++++++++
 .../bpf/test_kmods/bpf_testmod-events.h       | 10 +++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  4 ++
 6 files changed, 92 insertions(+), 6 deletions(-)

-- 
2.52.0


