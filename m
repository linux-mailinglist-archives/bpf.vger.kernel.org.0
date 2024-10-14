Return-Path: <bpf+bounces-41852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC32A99C7C9
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 12:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0EF283362
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 10:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026A91A4F03;
	Mon, 14 Oct 2024 10:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b="NLkXpl5S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7241D19F132
	for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903360; cv=none; b=olEhXbV6SsI+vF5UFqpzYL4CpRAWRZfzcXmylTYPFABkCtS7mOjai9XS7FcYBuzTnU9IzapdVdzQKBdx4sKXyWFb59Sg1luZZZ/XtABpBUs1F3+MmIN1HwR5MfgUbBaQxCM45bPynO6POCD+cMs/LH+Jvx1rEkvFUjPBLGbqjxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903360; c=relaxed/simple;
	bh=d4Qr4AjT7Xd00ji85JRmuuL9Aoxga68U1RIJfLMdJFY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zhsxi9LszvMMhSP+c8/ouZSCITW4VMPiB2bfhsh3rZeyjiP5chtkwjIdrhCI+9Z6xVq7WjiftSSt/RxvZU5COd/KNL7i8PyuHaRplbOpkJA5LmvctUGXVkxZ1ocKd/rbpC+J4LoySDnPlBQqjMkLpJxp1VGhLWyoe6GB39RSW9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com; spf=pass smtp.mailfrom=siteground.com; dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b=NLkXpl5S; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siteground.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a0084f703so209240066b.3
        for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 03:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=siteground.com; s=google; t=1728903357; x=1729508157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8VhoQQlsdOW+j2gNjFhwHrTCn0XGC6/cV7C1/fx1L2U=;
        b=NLkXpl5SZVDeAiDOVlPexLxAX4+scj3+7gj0HVBJF46OGLaZTMFdjKkpJ95gpFL/eX
         eNc8tAyqM8aEs+OPS02sxxNxcw3Cgq94wwvICs89epxCDcy/a22HBEXQBsRd+/pjiiNp
         +ucd6T6TWXYLWcMnLrmlpeAsPwulh6mi8+qNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728903357; x=1729508157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8VhoQQlsdOW+j2gNjFhwHrTCn0XGC6/cV7C1/fx1L2U=;
        b=oXFCtsDAS9SnlCKo6u2yb4RxjFN+rbSSVEh+Tr3l5jrHHClD/aie1pr/nzX067nwMV
         UfW59U8ktLlehuMG6ekUJ2LlhVcwygEpQMxZcXatviAFbT8US2E7Pw4wPtkiDMSWO87h
         MN33iDBx0fY8kKOVeV2WQbb8Pg81lfB1T9uKmFAwIXwbdnHlim6HTCIkVkPrc+ZH5M6V
         fi3jNhbHg4NAN8pkqH9IDq0nZidl6zhjxdRhIz3v3LUYNsFtPaHZjJGjkM6Y0qlB6g5Z
         mZ1Ve+B4aZ0SOjEk/zKxR6/dEUBJCXEJnjE+GqN3budCuMJL1Ug4LjSfyJ72JhANnSeY
         St/g==
X-Forwarded-Encrypted: i=1; AJvYcCVjeaz8ilxu8vQ/oAW+TAmpU/6VvuEkKmi20WrkF6gRQB5LgMgGeLQDXCk2UWKn9qxveVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8KEYz+5hch7H5/GpwRvpRJ9fuXEUcaA16tKAbjlpJu6c5bPcN
	kyWXKDIENfbBY0YvPJW8MikCBZxDxNtAbXWziWJxTn1orxEAbU/pXQFuWf/dcHo=
X-Google-Smtp-Source: AGHT+IE5t0jQ8WVCTHJGWzk2yr3/oUErwuKEBUuMMhMEHLmEPekgBLhQIxUYc4utHv0Lh8GgqlpVzQ==
X-Received: by 2002:a17:907:3f1d:b0:a9a:161:8da4 with SMTP id a640c23a62f3a-a9a01618eaemr472409766b.55.1728903356794;
        Mon, 14 Oct 2024 03:55:56 -0700 (PDT)
Received: from Dimitar_Kanaliev.sgnet.lan ([82.118.240.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a0c95c80asm159996866b.144.2024.10.14.03.55.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Oct 2024 03:55:56 -0700 (PDT)
From: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
To: Yonghong Song <yonghong.song@linux.dev>,
	bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
Subject: [PATCH 0/3] Fix truncation bug in coerce_reg_to_size_sx and extend selftests.
Date: Mon, 14 Oct 2024 13:55:38 +0300
Message-Id: <20241014105541.91184-1-dimitar.kanaliev@siteground.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses a truncation bug in the eBPF verifier function
coerce_reg_to_size_sx(). The issue was caused by the incorrect ordering
of assignments between 32-bit and 64-bit min/max values, leading to
improper truncation when updating the register state. This issue has been
reported previously by Zac Ecob[1] , but was not followed up on.

The first patch fixes the assignment order in coerce_reg_to_size_sx()
to ensure correct truncation. The subsequent patches add selftests for
coerce_{reg,subreg}_to_size_sx.

[1] (https://lore.kernel.org/bpf/h3qKLDEO6m9nhif0eAQX4fVrqdO0D_OPb0y5HfMK9jBePEKK33wQ3K-bqSVnr0hiZdFZtSJOsbNkcEQGpv_yJk61PAAiO8fUkgMRSO-lB50=@protonmail.com/)

Dimitar Kanaliev (3):
  bpf: Fix truncation bug in coerce_reg_to_size_sx()
  selftests/bpf: Add test for truncation after sign extension in
    coerce_reg_to_size_sx()
  selftests/bpf: Add test for sign extension in
    coerce_subreg_to_size_sx()

 kernel/bpf/verifier.c                         |  8 ++--
 .../selftests/bpf/progs/verifier_movsx.c      | 40 +++++++++++++++++++
 2 files changed, 44 insertions(+), 4 deletions(-)

-- 
2.43.0


