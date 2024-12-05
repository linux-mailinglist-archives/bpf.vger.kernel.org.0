Return-Path: <bpf+bounces-46182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4A89E60A7
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 23:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B952836D9
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 22:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C7F1CDFAE;
	Thu,  5 Dec 2024 22:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdffC2By"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648431A76A4
	for <bpf@vger.kernel.org>; Thu,  5 Dec 2024 22:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437918; cv=none; b=ob2CAHJ5hEbcQ3pUuD68l3LJvYpdd3pqT3z5eYEUzQ1as3KKJ9Rciq/T5/uVXhtLGIge3GdnOmzw2y94bWhE9XiCNEMr/w8TWBiLhtFHxnuimKplKcqBzvVZhvB07PeE2RMmx2JW4DTCe01xuGROvt6ICnN/CuvOR10iOfQvnfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437918; c=relaxed/simple;
	bh=w05KthImMab2AQ9C4vfI09FyaM0iKZ5qqEIgYfWgw/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MxNFPjJa+kjsySga/8vhtttbqjOlV23DY8z5h6LzFG0kfBKLCD3EdZIDr9jXXDogBY3/NqCgs5FJukWK2c7SDmHqLIjP5Z2ZkspC7h3oi7cFOpU2zSkpkD/tXmRJmWma/fTcfFvQMWTUZ2HqI7433VP80PvzhDZX82P7X+sP9y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdffC2By; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-434a8640763so10661765e9.1
        for <bpf@vger.kernel.org>; Thu, 05 Dec 2024 14:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733437914; x=1734042714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9X7x0uqR40njalUaCCLr8cmtT8nnkXUlmS7o9ek2B/g=;
        b=MdffC2ByoxY3hiCyMWsW/N6c72V7RrQRA6j+to/tgr03rJ8p1tz8UHiVNqyvSBGOoN
         FfQ81jUwUGu3UGTlIl/VCB0LlAZW16JeC70qdSNcgrJvno2HdlZUxIRa29YGwd1v7NCv
         jU+QmHlWxZkGYW7r1zBbfX4NRJc8JfePDZBTZYBudiIg/dP044//jTCHNYkhHgX3eViJ
         KLm3RYWhdM9b3e2UGc1e3SZQ/MakpCYX0qEDDBwJaGIwgegbB25l4pPxz3T7s0Xk/vie
         thJW4DDlx+YQtV9aXL8TQEZVVtSOGzZcFdS76KQJ0aoHWajKcSwYFm2cpzWPHUtj8m28
         6aQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733437914; x=1734042714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9X7x0uqR40njalUaCCLr8cmtT8nnkXUlmS7o9ek2B/g=;
        b=Ca2a7xaiaFG+t9FXgmxnwn2sxAc7aUZ2QMR+nuwS0RrccIYKNWPydVOgN/daiSMFPE
         abVaNtcQHPmplKgyNJOXkryl7vVFdCmNUwUji4pb10jjqzphzajS/AqWs8FlIpGXSSdH
         cduRqDCU4W8Aa0vxTgBi0qIYhrHAbuCcv5/SGbGIcJRl9vrMo0+I+bzrZDaN5cuLk2eA
         9fX1ZM9693Sw9dt6RPNg4SAOmqaBQ36dK5JzU+Nna551BZWLNYitqw4kZIVUNtT8Ycuk
         MVjNqSzTDCF3/mIlq8noRRmybmL25foBIWtVmufQ3af0ZHV/WNWOuBfwyAEGUJLjEA/7
         4imA==
X-Gm-Message-State: AOJu0YyPmQjsZk0F+3dDdwxwSsIyOPQbw405tHUQTf+4XfzABLMXm7mF
	f3ft0DeyrieuxcZBOqiJUx56aLbRbr+gCSlMrnCRlstvf2oiw7SeNv5YGoQmv8A=
X-Gm-Gg: ASbGncuTAswr+OCWZT5s0mm3V4V3HfeOaPnPoyEYoU0iQ57YAIz2G2NeP4mbgONNEOP
	hGJrp7WfRCfCIv+Dz1hN6q65L3TOU+9+MwDZ/59BEfcFFMVdq0vRMgkbwLqOYtbHoLMxtdUGloX
	LgJZxxvUR5L0WU7F2FjTAOGmJ4S8k+Cpm7WKkQcdoo/sKFGWrzohaHN3iAD9t9qIgpJCVN3ylF6
	ANhR0BuQiRpvjzE9ay9JLPb69s9PhhmFj0vYjBSmsjjgjpcJfYO7ESx09x61/Witc7zMYsW/oC+
X-Google-Smtp-Source: AGHT+IHxP6OfEcY4mEBZnegDjgxDkk1urdKMidj90rvgA2YLbExqX3WsCxj2RGLl1+3Tqsy6/SAdbA==
X-Received: by 2002:a05:600d:8:b0:434:a5d1:9917 with SMTP id 5b1f17b1804b1-434dded69b3mr6332655e9.21.1733437914185;
        Thu, 05 Dec 2024 14:31:54 -0800 (PST)
Received: from localhost (fwdproxy-cln-006.fbsv.net. [2a03:2880:31ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5273b1dsm73843665e9.15.2024.12.05.14.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 14:31:53 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Manu Bretelle <chantra@meta.com>,
	kernel-team@fb.com
Subject: [PATCH bpf v2 0/2] Fix for raw_tp PTR_MAYBE_NULL unmarking
Date: Thu,  5 Dec 2024 14:31:50 -0800
Message-ID: <20241205223152.2434683-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1954; h=from:subject; bh=w05KthImMab2AQ9C4vfI09FyaM0iKZ5qqEIgYfWgw/0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnUii03YIg0/oJ4DqD4b6pRcvb7Jb2D7c31hP02Pkv xEjoA5aJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ1IotAAKCRBM4MiGSL8RykHvD/ 9T+cqE7agZyoj4JO5ujGK2JR04r/W4qmGVulhxW1Yw+A7yd8HUaOuIyrR3+cfwM2Xmrcx1DOe0eOFB i3UfNek7W5IxBkPn8+nG5F7PgwwlQmqmHdHmBvx8saATB1JIZkmkF22psQlWZTb1dQRXBHAdOSxUjU xFuompl4eop6krFYiggtZUKh4XGl4T2gP5YdDLtFPCKXUxAgGaJ40LolDL1/viZWEgMh9byduJTKZ/ AIcJdlXhs56C1MhQTtwglbQuxEPwZ6W7lJ0REYcQE3+jt0Q/Yh+vbIGRsQggQmQ0bhdnNlyBHpMx32 SwHEy2TTI+Ru+PgyQb0SbRfxEtafJN4mM/hy/7oHhqGeJIxunfJhCJ+ynXwaMWtoB7vEf6xi0f8GgJ 4rZR8N0oiK0X57ODzuTanWtQI0l8Yh2PnfpSEMEh8Q8HMeSTEJMgqtm1CEWfwhhq70M+qfRtK5MV6J pVTTJjIVCVnzXcjMVhLEMVQx3H6GaFN8tdPjv6qOQ3+88neb734J3WRyqH1FdAHCAUOZCwRfn8JgME wCmVYZL5tN22SEKn8WoGs+49LP4dUowHqF5YkSSySEsG8pfLAT+rOvSLZji8u6bGNavpNVhsDqsr05 MRD0pnsAUg2ojmH2Y3ndHUHYsZAV2VAanlqeTtHlqdV5hIf661+imj0I62tg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

A production BPF program had the following code produced by LLVM.

r0 = 1024;
r1 = ...; // r1 = trusted_or_null_(id=1)
r3 = r1;  // r3 = trusted_or_null_(id=1) r1 = trusted_or_null_(id=1)
r3 += r0; // r3 = trusted_or_null_(id=1, off=1024)
if r1 == 0 goto pc+X;

After cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL"),
the production BPF program began throwing a warning in the verifier
because for the code above, when unmarking null mark from r1, the
verifier will notice another register r3 with same id but off != 0,
which is unexpected, since offset modification on PTR_MAYBE_NULL is not
permitted, but the aforementioned commit relaxed that restriction to
preserve compatibility with non-NULL raw_tp args.

Provide a fix to suppress the warning for raw_tp args. We will follow up
with a more generic fix to handle such patterns for all pointer types in
the verifier, which currently involves playing whack-a-mole with
suppressing such LLVM optimizations and reworking BPF programs to avoid
verifier errors.

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20241204024154.21386-1-memxor@gmail.com

 * Fix eager unmarking bug (Eduard)
 * Generalize approach, always unmark NULL when off == 0 is checked
 * Make NULL check noop if operand has off != 0
 * Do not reset id when treating as noop
 * Trim comment (Alexei)
 * Adjust selftests

Kumar Kartikeya Dwivedi (2):
  bpf: Suppress warning for non-zero off raw_tp arg NULL check
  selftests/bpf: Add raw_tp tests for PTR_MAYBE_NULL marking

 kernel/bpf/verifier.c                         | 38 +++++++--
 .../selftests/bpf/prog_tests/raw_tp_null.c    |  6 ++
 .../selftests/bpf/progs/raw_tp_null_fail.c    | 80 +++++++++++++++++++
 3 files changed, 116 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/raw_tp_null_fail.c


base-commit: 5a6ea7022ff4d2a65ae328619c586d6a8909b48b
-- 
2.43.5


