Return-Path: <bpf+bounces-51854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC882A3A69C
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 20:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDF7D188B0B2
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 19:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F2F1E5209;
	Tue, 18 Feb 2025 19:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYYFpmGV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07C11E51E8
	for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 19:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905275; cv=none; b=eIdQwB2qYbn8SaomDNoS3kjDMkzXcPFjbVVQ7EeJW0qGQCSXmgNrOAA7PNEbhDbAA1jCGGEDuQUXyGD7AB1ka4EP4R5if9Jus5Rh9B3Hjt5qxSI0yFcUHwJJJLVwzJRe47WQo8rSIcP58DNuNT3Duw9IbBYp+Oov1D7YeWK+h+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905275; c=relaxed/simple;
	bh=Yi/9//OkDaRp8pvRP7izxrqO6AKP7FeUWflKjxyK/4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fbNVsez2roHnLX448cpZyGhPt3ESkg91Th/0w1ohMDRWoyrN5ytj6HZo/ZBHCBsS8yL9Y+Sq5HlmQiCnJcxfg6OsfS6biNseBON2igyDEoujlJLc27xdIPcnE7YBvIJrlpxigaIlnc2L3QCdFNlxf7AIW89k7fB57tkT7MVGbRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYYFpmGV; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e033c2f106so5120729a12.3
        for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 11:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739905272; x=1740510072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7xYHFAUFBvKckgoJlr2r/QqfB2fpseNN7m2/Q8yZTR4=;
        b=mYYFpmGVLzYkt5t7PG8cJQuq4WqC5sRehWeef4iDeo1YtCiV2wXJWZ2+gpPQmGC3qI
         8D2uSHL5hTOaWEDxgT4A1ULxqcghU7cCq5hvTMqgKRE75FKG1WIlvTrx5ZdKF94jGo5u
         LjEfK/smaT9AGFwlfQ0/W9ksr2fDXYi92RQCK5Z/XyWd64utH9JA8OWFvb4UWRD1/YFW
         fty9W/zVu8DW1yRbcijywaE2SiamWSQ5KQ31gIVkYCn+/XmeabvCDU/aw1+9tHurI178
         2kUo5Q02/ezhxxFoFygtUoCSXiOqcTv7G0Pe1o0mBqCPthrAqQFsBR7fJo0QK3SxhxDG
         dP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739905272; x=1740510072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7xYHFAUFBvKckgoJlr2r/QqfB2fpseNN7m2/Q8yZTR4=;
        b=GqAzmPI0zoyOBAB391C70C+PL9fRuQbmoxCFO8eQzCZjz6qs0XToxrnRyjG3D4Mprl
         oNvKLzaqa50o/TVT1n1sUHHYwbq4yhoa95MbEpf7f7L8MMyoyqDnIANAzhNQqTfMiDXr
         WXwe1YlcdssuOmBEoI3Q4wPF0BB4ZlJLXr+BhfSUAdxHDQELHn60QnT3MP1Q2BMo1JiP
         qV3rcbbhN+F/g+pH9m6by21y0/2iappzwAsyW/kSgTE4hmR/iT8qNlmxtBnRXNsyhEAd
         nWu4ykKevz3Ndpfy7M/WmMn9Z3E3Zee0IkbaIfTMnUMr/hD3zvvHjezJ5/7H655w5Ber
         pxgg==
X-Gm-Message-State: AOJu0Ywi8NTv20V/wCr2wSAfpkHQ6wu8dBkyS6gHHyAo2tKZYk8QGxQf
	DLHanuL/PgMW6w0NWywj92fdmgNfj35gGU5UM5R4K4pbkb7QB6bTZmzjYA==
X-Gm-Gg: ASbGncsZAzMCCjNYncz1oNPnQRz0rXmSiwvgTzuSFNm3BGHH9nCPHAIGqJ2bYxnxpsy
	tYJaAKoqT6PAFdpvF62wQjdtIwD589LcxcLFz9mu0nqNV+CR/RASSRcLL7zSUxoypI1g87A7Fqz
	+BK+Rw/viEmsWynvQYqEA4695Fl+YqmZ4AOgvkJad+4OMjfhrs1EWScZrcacKTHh7kWO1ryx75Z
	VoZ4V/BT1m7d9qTl8msieLFrUDAb4GGs4rnkGX9PzSkdDNGUBhImNYJr2TPz0N4eo1ymdsI7S1G
	jJJlv6wx5ZDpAOVxTmX16qnD6NrRrw==
X-Google-Smtp-Source: AGHT+IGxREfftQSHmt3S6c3DyB7VK0sJg87tehmTtL8+XuUrWLGIWBru8Uk/YyIbTFv81cEeokkrYA==
X-Received: by 2002:a05:6402:4609:b0:5dc:5a51:cbfa with SMTP id 4fb4d7f45d1cf-5e035ff96f1mr37378053a12.6.1739905271898;
        Tue, 18 Feb 2025 11:01:11 -0800 (PST)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::4:4cdf])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e02ebeaaa1sm6248540a12.5.2025.02.18.11.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 11:01:10 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next 0/3] introduce bpf_dynptr_copy kfunc
Date: Tue, 18 Feb 2025 19:00:24 +0000
Message-ID: <20250218190027.135888-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Introduce a new kfunc, bpf_dynptr_copy, which enables copying of
data from one dynptr to another. This functionality may be useful in
scenarios such as capturing XDP data to a ring buffer.
The patch set is split into 3 patches:
1. Refactor bpf_dynptr_read and bpf_dynptr_write by extracting code into
static functions, that allows calling them with no compiler warnings
2. Introduce bpf_dynptr_copy
3. Add tests for bpf_dynptr_copy

Mykyta Yatsenko (3):
  bpf/helpers: refactor bpf_dynptr_read and bpf_dynptr_write
  bpf/helpers: introduce bpf_dynptr_copy kfunc
  selftests/bpf: add tests for bpf_dynptr_copy

 kernel/bpf/helpers.c                          | 57 +++++++++++++-
 kernel/bpf/verifier.c                         |  3 +
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  8 ++
 .../testing/selftests/bpf/prog_tests/dynptr.c | 25 ++++++
 .../selftests/bpf/progs/dynptr_success.c      | 77 +++++++++++++++++++
 5 files changed, 166 insertions(+), 4 deletions(-)

-- 
2.48.1


