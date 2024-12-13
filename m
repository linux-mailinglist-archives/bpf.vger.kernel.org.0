Return-Path: <bpf+bounces-46901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6215F9F1801
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 22:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86F5188B3BD
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 21:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD081922CC;
	Fri, 13 Dec 2024 21:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="S3zL1EGk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7071DA5F
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 21:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734125268; cv=none; b=k3FR8Fj1GkdsyHMUW+FSE0c7fUV7xE0lb4BJ3kth/4Zr8hkTgCVCR3mRyp0x8cWYfjk9qB3lVLtRT/2mlGASISk1UDD8ybnfmMkxHFlARkVTxxtj3WP4YH2ZO/k/pRuHOTCJykr4fQDHkArN8zXgTAMDI1Jrnuv6w1FLeoSg/zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734125268; c=relaxed/simple;
	bh=8p04cm6HMGa8tcLKm+lo0gbX4w9CdC98wP3uiGUmeuU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FDsc/hYqZhryZMxuEyhtS9VnPIXZVJoS2voPhMhNpSz+rViR2oLDKeWZ/FZtG3xYHVbI9Ox6y5Zxxqo/Cx95FgP0+d8ciisbsy2lBVb2tGhb+GruA7OYIBvJsnuvELdARGnySNuuVeTXxTp8KTR3TRqYJedQkFc/D/67Bk4RUxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=S3zL1EGk; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436249df846so15729955e9.3
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 13:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1734125265; x=1734730065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Sp3znFqIlWxsSyc93l0aJ34CsqPvCriRVkUFbbFyOg=;
        b=S3zL1EGkjcKlrvw4zXE7x7bWXJPC8dETLEwuxtrMNxoR4Ld/B5+X/SbS3zFmpmQcO0
         73PCiBp0JfdR1MTdgRrWolEO8EM58Ca07LYGsrxBxkp6iXjSIiSWeyogPicG25KYCiIK
         H9miePf9eo+ETWe7poyu5wBaz2OGVWbZlcL2cQHS0dBzKNVG7kDSHYWWRC+pYcIbGf0g
         atiA/z/l4brE7D7iLgCp/++lrkopXgQiburh9QLwh8U4Z9QKw5Kt+HZ07EzttQH8hPA3
         jQVOeAjI9cL5mFtpBbUZuyy3xlju6WDjuX6xjfYo0CXgFK+lLyI4NDhHq9/8D7qo+kPl
         da7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734125265; x=1734730065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Sp3znFqIlWxsSyc93l0aJ34CsqPvCriRVkUFbbFyOg=;
        b=sab5Z8tl4AQd1vh81AgJOLDTnoDFFIisuA/jsgY8MdhWsIXYlQz7BZoAZdfaDN+zzQ
         tkE1Y97RR1tKoDIAQ0eQFARLKv1tMo9GYdMLVBglSMSTclAFsgX9H0+XuHbJEQzcXl5U
         PpmubRYT3eqT11jaT23180a7/K+LKEtj824e9nOclUrz9UIkEfE6X6m/mCpTHUplQjWC
         wlCjU3ApWmQ8VVyQdA5XekrUPojCX38vEYqNI1670rG1dF33MEewwVt0OQ/dJTqUiCfc
         GnbNpXNCRaybcyNwpnrc4aPNw8EZGODLxHKrxUDPtVuZ074gjvA1taWVkGC+4yf0j8Ms
         FlrQ==
X-Gm-Message-State: AOJu0YxHBlrMOYIfZboyO+o8Jeq02HQQmlkPrWigwwWJ4bCH5kvlLpge
	M6ww92XEYlbsYhREcxKOLlObCVtDY6ZB+XA60vw39E8oCW+KzD8AwbMofTGsWYI9foOTDsookaD
	tfUNZpA==
X-Gm-Gg: ASbGncvbiNIZFIqMtFBQXpWfHZ4ln9UCR1+5IXigmGwlrkGooiLI4oYqC0N22pJPLmp
	NbhlESvk14NrJWFo6n+m2f2Y38kL1EI53Y4WrvTjIQbL4TXMVbnvFmfEkSZHFGwzblcHgVcKrCh
	zdde8Zkj2ZMaJ6wINDtCPWYHPHJYQVkWJX19pCPi0SARbQ2Fccvz4tIlUv1Gg0bzARVi3Wu/J2G
	RQKzemdBPA6hoMekUVeHpIShXkxUEPddQ5njc0=
X-Google-Smtp-Source: AGHT+IGAkD4gQpmlX4bAIuT5yQYCTwMb8VdLnoe1lWK5+LJiDN0u4FFslBp8s/srKJB/pKS8lpnDcw==
X-Received: by 2002:a05:600c:c89:b0:431:44fe:fd9a with SMTP id 5b1f17b1804b1-4362aa6fd6bmr33590425e9.19.1734125264812;
        Fri, 13 Dec 2024 13:27:44 -0800 (PST)
Received: from bobby.. ([2a09:bac1:27c0:58::3b6:40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625706c5fsm60003975e9.31.2024.12.13.13.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 13:27:43 -0800 (PST)
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
Subject: [PATCH bpf v2 0/2] Don't trust r0 bounds after BPF to BPF calls with abnormal returns
Date: Fri, 13 Dec 2024 22:27:15 +0100
Message-Id: <20241213212717.1830565-1-afabre@cloudflare.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A BPF function can return before its exit instruction: LD_ABS, LD_IND,
and tail_call() can all cause it to return prematurely.

When such a function is called by another BPF function, the verifier
doesn't take this into account when calculating the bounds of r0 in the
caller after the callee returns.

---
Changes in v2:
- Handle LD_ABS and LD_IND, not just tail_call()
- Split tests out
- Use inline asm for tests

---
Arthur Fabre (2):
  bpf: Don't trust r0 bounds after BPF to BPF calls with abnormal
    returns
  selftests/bpf: Test r0 bounds after BPF to BPF call with abnormal
    return

 kernel/bpf/verifier.c                         | 18 ++--
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/verifier_abnormal_ret.c         | 88 +++++++++++++++++++
 3 files changed, 102 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_abnormal_ret.c

-- 
2.34.1


