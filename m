Return-Path: <bpf+bounces-47984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC19A02EC0
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 18:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B5813A45D6
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 17:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5545B1DE89C;
	Mon,  6 Jan 2025 17:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IX7JZdOz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6A5155391
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 17:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736183849; cv=none; b=rFKdwnzKfN1wGoFsn2/gdOPemylOE/5i+alBKGYen0c/Ux6CuUbL8VSIfmQ9+dwnFPpDXNeqhghbb6zgc30/MCic7EG9zF3qAUwT8EHzr+e3WpfediEMkoHNufb1MyXRY8rsfBVeDGepZDRXdfRRwA7ChqgCLm+QzVF0PgaV8ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736183849; c=relaxed/simple;
	bh=MdM00t21rMuIIkPWOUPvMbENbmQIu0z9Tg4MR5Fy04s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qciMiizx0P17VCNpJnAiOrqmM1x0gJDl/Uq3Zf9cWpDlaWIwiT9P+TNWqgAUFmgaEIIB2e8fI5TnGnbwOgJN8j+UVmD+jt9Ja0o3M88oVFOoRVRmI5igji3cJUzODBOS7LPxojYHL32KLo9LF3k3nwlMmBtImJ9KiByoZYsDclM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=IX7JZdOz; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43675b1155bso138956415e9.2
        for <bpf@vger.kernel.org>; Mon, 06 Jan 2025 09:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1736183846; x=1736788646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HZUP75MvgdBZE7PNd9/qOeWcztcIfAnd7GRToVk1ql8=;
        b=IX7JZdOz77w8Jx4vAqjQAjaSQTfRiBOpjdiycn6rxkGQ0t20YakYjrVPbtgS5kNh4w
         LTWduoqq8HzRNyx7g5HjSBz5nNrJouDwMj5iTaTq+mIG4GJ/vwOnJ2RaLJJBwIyDQi1+
         JHiVTWjSkWVMel4XMwdh+HxpC0O4qMECpa9T9aLQVIu0UAVtUBVdfOhXRM9cRBp6D9+I
         WX7pazEedsqEPSEO4ufumeWYOErQr0HpAGYiNylYh6HjwN2aCqkVtSuicwvv3OGF4nlU
         xQOR6l+Fq1cjs+Td/CJwvs7XrdwQZizYrvFmRLpQ0SwhYwrSrkA3yrasm/0jHJ2Xkj3L
         B7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736183846; x=1736788646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZUP75MvgdBZE7PNd9/qOeWcztcIfAnd7GRToVk1ql8=;
        b=EVQxfJ7gbOn9iBQk+ENC48lLEWSzdPso1MRG6/W8pchxqEiHzhfoVtDmyTMSHwhWTo
         X5UJUUSxrGXvoegzpjcpfI2kJp/pIJCLWN6M+gO2cIbtdmygWYGgcsSZhOcvzNd+rS4t
         B4/w+1LbcamOLEs6eqilsGlcnHC2szlHOTo6mTnoMwK6ouOAEWSQRL9nG6BCuCWxRMga
         lAeYH8wXFDENxMZz6+ypoeyRsuuTnm8bZj58w0xP/NreSPOEdlS8qwOg+uDZVuzjqFxU
         MniGjH/AWVgG/OXsZ8JxzAv8R/fDmZ/ZksvbelutjhvymXEPJ5ENXwf+NbIEdU4eMwsF
         m7iw==
X-Gm-Message-State: AOJu0Yy1Dx058O+QsOlnjHB7n2kGp+a2Bcg9jXGRKIPtAIo+r+R3Ms80
	EfLK1wgm6VrhdB67SKggBIgrx4QU7Z0p78Lo0KVzQTNVCIn1fh/1Bs0IT85tHiLLMY6Y7ZMnv7M
	ri0dPAg==
X-Gm-Gg: ASbGnctuQmrQp/fuNt+DEcb6MnG8KFykr9oWT+ot6Rk7MzF9A1G8nka+Ym7Uiv8StHA
	Rppbdm6/XZVQKNTCUDHEEKpxGu0sblVWC0OV99V+sh78JsIDTwv6VEc5gkG9UQkTFpHGoFsJRdd
	/Xw+l6e0YWhOOvHtjPdBDeXxc1W7LoQUlh6bCEG6NVnRHU4b/cxgrpN/ixQxsUgzSXUSJTCC+Z6
	XYLmQ7aVw5nae5XF/cnKVZ838RGyILyZpZ5cA==
X-Google-Smtp-Source: AGHT+IFC/7sEfT3wW6c14LTo4ZwO7TEl7M0PVpcB0TOQXnwWsodkRygson07OpDkpLyQ6spCdSLOcQ==
X-Received: by 2002:a05:600c:4588:b0:434:fff1:1ade with SMTP id 5b1f17b1804b1-4366864413dmr493191075e9.13.1736183846016;
        Mon, 06 Jan 2025 09:17:26 -0800 (PST)
Received: from bobby.. ([2a09:bac1:27c0:58::241:2f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c828bd3sm47658263f8f.10.2025.01.06.09.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 09:17:25 -0800 (PST)
From: Arthur Fabre <afabre@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	kernel-team@cloudflare.com,
	Arthur Fabre <afabre@cloudflare.com>
Subject: [PATCH bpf v3 0/2] bpf: Account for early exit of bpf_tail_call() and LD_ABS
Date: Mon,  6 Jan 2025 18:15:23 +0100
Message-ID: <20250106171709.2832649-1-afabre@cloudflare.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A BPF function can return before its exit instruction: LD_ABS, LD_IND,
and tail_call() can all cause it to return abnormally.

When such a function is called by another BPF function, the verifier
doesn't take this into account when calculating the bounds of the return
value, or pointers to the caller's stack.

---
Changes in v2:
- Handle LD_ABS and LD_IND, not just tail_call()
- Split tests out
- Use inline asm for tests

Changes in v3:
- Don't handle just r0, model abnormal exits as a branch that exits or
  falls through.
- Try to use C as much as possible for the tests.

Arthur Fabre (2):
  bpf: Account for early exit of bpf_tail_call() and LD_ABS
  selftests/bpf: Test r0 and ref lifetime after BPF-BPF call with
    abnormal return

 kernel/bpf/verifier.c                         |  84 +++++++++----
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_abnormal_ret.c         | 115 ++++++++++++++++++
 3 files changed, 178 insertions(+), 23 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_abnormal_ret.c

-- 
2.43.0


