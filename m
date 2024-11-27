Return-Path: <bpf+bounces-45756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 208B29DAED2
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 22:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA03166157
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 21:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50687202F8A;
	Wed, 27 Nov 2024 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctmej+df"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE5E7DA81
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 21:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732742431; cv=none; b=hvvBnDoQbM1bV2zJz/lSAh9eCZT4wba9WoKYZZDJeOA2Yfp2Xvl8dJ+eWtkRVTGmzTB2sH8cc9/vr3l8x30+u7/gc2HS4E4BMRP1QcrC/ox+xOdmK28WG5mrk+a6tWAPu8Y9ZBLhcx+0YPDHJFwXafPc6J6i6pqN8bMAJnJqsWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732742431; c=relaxed/simple;
	bh=QKz+Pi/jdQVtzNhZQXkUzzYKq9ZFXCmxu1u7+WglZZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ewtAIuV333C7YHRzgDrkmALA4JXPw+xHZ+NRQ6MZc6TW01Yc1IQOBKaPjI3UFdruJH+Wt2ErV6+bq2L4fx73XCSkW8ibAeUXuyzYkiLfRPSeExpbgwKAQ+P3E1jhpwvFDdM7rqhYrxrYEu/GsBIWznIi+S2mj3dnCgA2iu7sK88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctmej+df; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-3824a089b2cso110827f8f.1
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 13:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732742428; x=1733347228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tRd2XjzVlIE2JZXbWQjzuUnJ1MdCDwZUNxTUMZKuCDA=;
        b=ctmej+df/wnZ0FDuPHLdUZdT0K+bJi1x8R8aZOZL7veG5YuGlL/BI7Gf5roTjfoZF0
         RkIMgsDNDf4hHZfE4tLcD79aLJxI/dNK7oyOjQv+06a85xsbhzszJZp8iZkPEtOZKYxz
         N6V2Fg7Jc0jTj/4JKrpjRabDYOzl/v0jAJc2CoV0T/bI9EmkG6Wq11cO88QbaTxuPSVi
         IeZ7GFNazyu+ppmZewxzlI1EANGHQ9WHIjkpcDja4uCWVhaCqSWizNrOmNluapZ51fli
         DeAo/Qjy2tIrbtx/01ovBf+IBcIJcBYfGrq33h6qDvBSw5g76n5srIuZ3Sw/tjccXJcb
         gf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732742428; x=1733347228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tRd2XjzVlIE2JZXbWQjzuUnJ1MdCDwZUNxTUMZKuCDA=;
        b=BDw4ovII9wKKT2JUBwlAdqEGtEDZFnFmrk/I9ccPjAHrKgbW+fTPj6BYAvUiHU+EhN
         +fYbhdOf5B94uXwR+5uw1+bdeyjOaAiVttT+RMUFC0AzCkGRNXCnXf3X9BZ6x1rEcGiU
         fsOa14EH+RvALDPrf2yMYvaQzjPVXqNlDTrz/slNQurssTTdwDaGN/eLnLvVQZx8LcOI
         cuYKezZTPweeKqe6V0/yAcuJ1GqyduIlAHoPscEvsrZ/MDJXlTQYe/BYDpXG3df8mczW
         qUKOGEFGlyLAscO2YFhcZS/9/dDClMnBDpfyMUza7dVP/tz+Bdfwu7ZHBPqU6aYUnA7P
         CxLQ==
X-Gm-Message-State: AOJu0YygUq6h5yKioPmunzQIFMfTYv4FC121n9b+YEMMQMGhKB4kQMO7
	3mVxgDXDxP+Ztb+m89QaHtImT1FnE/9rDVzkRnwPfjaVtF9Vza2b2dZn/6GbRNc=
X-Gm-Gg: ASbGncsNnnMlKEQfu39DtlN9pUg3oXlpGf8VSFq/KwdL/JehVTWcH21BMC/XWJcG2jC
	d/vSEukYpFq5yGRmDS4qz7FGIcpo4J6qUI0xIvp9ejv04gSkoL9bN11K/VOj1ihJ9T4FIzpDK+4
	zr8bMEJTpafQy/gN7Hx9H+Ust/Y72yZ+sZF/UmIWCp765N4Y8LGLXWaeomznCFdGLb/zax/1zqO
	bErrQPPLzqqo9WKJV0vxDX+DjePDAzUTqGzC+9QJbVNh7RHk+7wLffq41uoNXuz8QyyT03WypUQ
	jQ==
X-Google-Smtp-Source: AGHT+IHzcQ2Lgcx/KC0dr86Rv8OL0zBIVGhha3dhDhdkZRKJ+cRUDZqU/qbTEi+9kND5aH/Ro8lHkg==
X-Received: by 2002:a05:6000:1ac9:b0:382:3527:a147 with SMTP id ffacd0b85a97d-385c6eb6625mr4120601f8f.1.1732742427492;
        Wed, 27 Nov 2024 13:20:27 -0800 (PST)
Received: from localhost (fwdproxy-cln-024.fbsv.net. [2a03:2880:31ff:18::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbc4130sm17122396f8f.65.2024.11.27.13.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 13:20:27 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tao Lyu <tao.lyu@epfl.ch>,
	Mathias Payer <mathias.payer@nebelwelt.net>,
	Meng Xu <meng.xu.cs@uwaterloo.ca>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: [PATCH bpf-next v2 0/4] Fixes for stack with allow_ptr_leaks
Date: Wed, 27 Nov 2024 13:20:22 -0800
Message-ID: <20241127212026.3580542-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1191; h=from:subject; bh=QKz+Pi/jdQVtzNhZQXkUzzYKq9ZFXCmxu1u7+WglZZI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnR40BOIvpquZrLWg3td9o7HCSIFlilI2+7t04tgaf P8J8Vw+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0eNAQAKCRBM4MiGSL8RyqDSEA DBgivBHAeW0YmModnCI32xkb4SIRQQ+JBO46Ya2F7T0ytY3ClXV4L1GbWO2zMDO00f7R5SbVMfjvIr xyrwBDlHTWsoJVKIV+cy1PHWguZfLBYJ3OGKBk1hvEipTlI+TfV7/iRJoOMhbjAHqzYVoZ/pWMiQ7n e6hk46T7zU6aPHDc44rJYKyLQqn9W2ZrgheAi7HeOEDP7O7GFz0SOrOUGXemYVRSmYDB6O5AJH31DS mPHbvcqw1SDqrb3AqPavZ30HfyQ61OSIi3r3tHVgOgVlKxyqpe+tp9b4IbuJv+Oe7DZD3Q3Koifta4 tMIv+ZRudDkXGbtlqZv/fIGJo+KpLa9Smz8DwSQDpe2s8z7n90VRudnlYOL/1dX5ukcjx7erzcldeC Xro9R7t9ZbzdvSUEmWGGYYhYeMHCQaUgF0u3ihkHtSNxCaDE7UJCAqgl0ngDtxAlIqb7snBuEEXLOR AOG5WAY5J1L9n8aVahMEoHbMRWWOKJ/yXuyZSYQX5FYUiXnxgTSts5kvtMfGz07ADvU5SOnGBLhDUL ptulVbVRjyzylbust4uura2HtXnrbft2PREtjW6wIJ+M8LzOzFOfMitSM+/riZtZ26ssQe4Tf2IMyi XOYMz+oGn6ZPfyaxGaIXm2XT0a3UPZzAzuKtHUMMwfiTUlB8YEa17kam83mA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Two fixes for usability/correctness gaps when interacting with the stack
without CAP_PERFMON (i.e. with allow_ptr_leaks = false). See the commits
for details. I've verified that the tests fail when run without the fixes.

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20241127185135.2753982-1-memxor@gmail.com

 * Fix CI errors in selftest by removing dependence on BPF_ST

Kumar Kartikeya Dwivedi (3):
  bpf: Don't relax STACK_INVALID to STACK_MISC when not allow_ptr_leaks
  selftests/bpf: Add test for reading from STACK_INVALID slots
  selftests/bpf: Add test for narrow spill into 64-bit spilled scalar

Tao Lyu (1):
  bpf: Fix narrow scalar spill onto 64-bit spilled scalar slots

 kernel/bpf/verifier.c                         |  3 +-
 .../selftests/bpf/prog_tests/verifier.c       | 41 ++++++++++++++++---
 .../selftests/bpf/progs/verifier_spill_fill.c | 18 ++++----
 .../bpf/progs/verifier_stack_noperfmon.c      | 36 ++++++++++++++++
 4 files changed, 82 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_stack_noperfmon.c


base-commit: c8d02b547363880d996f80c38cc8b997c7b90725
-- 
2.43.5


