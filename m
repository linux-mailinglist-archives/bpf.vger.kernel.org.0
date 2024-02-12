Return-Path: <bpf+bounces-21735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BEC85172A
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 15:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3B328371E
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 14:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC083B189;
	Mon, 12 Feb 2024 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aveoCYaZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E063A8F2
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707748732; cv=none; b=uTFHwhZ0sPqKgGcuT0vXegAE+KcBEhDWOa6th/nmYRfp0VE4wC5drCg9EkpuPOh27JgqHmLhJ0D7iSryEGTCjaSi6PZ6frVHgU5/YJ7PcCmmBVk3pZ6up2+wnAZ2bvyfm3e88ZWWL1rvUDoKPHFxCouUGFw7ENaCx12ZAjEWF5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707748732; c=relaxed/simple;
	bh=Yc8ceEFAMlycLqwVYsm9vIOOXtOO6I2qjtCJFX9oBaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nHerFzI65Mvfqbigl/8TmkrMTbEvqPLWQUktX501fpTnK3860Jvc0J4kumceoGr2bCHJjhDkTBBg6UDfy9lteE5xClwT3iDPWeglfzOTE2S370LHgxeO017hpRfwFsHIVGJjdG5Y8ynPXoxXlIrfa4YZUaIKUMj+t01sTwSOFks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aveoCYaZ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3ca40db065so99732766b.2
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 06:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707748728; x=1708353528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UCVswzWHlPY8KNSzlKinQMb8Ol7fvZKzpdAP7x2wgE0=;
        b=aveoCYaZaghThqTNMjzbsdYk4BEYUaqDBb3Bi3L+Vh35gOR3xJQDn34k4e2FmqgjOm
         1S4OXSU13RvvEdH6HYEeqLTKGWDMoBTl7EMEf18mtdetJ3WWMUYAoPUkT/LZyqgyU9XF
         RvUBhZEZWN881GqPFmD7FroRtzw3o3/Jyx60B1YzDlmbfrqlocZ55SbjXaHLZVDP7ElH
         x0V7iCWT01oHRsarcKhQK2Mdo/XIypEH1d8yTMmT6JzpKNxcLSBpCpN4HQ+NlX3GZjZZ
         BbucxjMBvv47AQ7FZl+OJGfUt2rkNpnjB2wh2COC4++d0QX+uXIstWQFL+rJOHZDrYSi
         41+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707748728; x=1708353528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UCVswzWHlPY8KNSzlKinQMb8Ol7fvZKzpdAP7x2wgE0=;
        b=PN0vkJ0EKZUM4kGK5SxJNjEko2+6A2c6SxIAWSKI3ctr4VJfCsX4agTC3e3yflcfPa
         nY/tT6FK+97V1EVtFUIUJ8IkMXLq3MabaiCkMVMr5bg2M8QQw3kdkEspdbTO7ZOyF5rL
         l+jzUCDxDiBKoYkIoiLEm32bezczu3y+aN8k5996wyBaJmRq3irax0UHi6hk7n3ilQ+k
         tzJZqejpIaDqHAhhmGncQbliCXthCGp8H2VWvBjev78ndeYGBNvtb78nAnQ7fYObrTNJ
         0VLVF3lPJ5wJUS8w/B2yyQIcmUbK4mLAGYoabPWA5d/T/WQUYIVoUv6e0rzdv3+p2Wgy
         hr6w==
X-Gm-Message-State: AOJu0Yx9n+v/tI3Umn0Qhvbv589aJCNSFRnduGaMUhw+e9dLKsk5W5io
	ZXjbUFCHjcEyEi3MDGEUepZUGOhLxqLZTMVNh0MlFSz2ROHKuFDyqcKdwfzp
X-Google-Smtp-Source: AGHT+IEdsEBr9YnQIndq54ggvf/+/tdLUL/G22VOSeolpn6VCozLsMS1NPHOE/lnQP+tlBamnJctOQ==
X-Received: by 2002:a17:906:2b11:b0:a3c:8f4c:ec5a with SMTP id a17-20020a1709062b1100b00a3c8f4cec5amr2431852ejg.30.1707748728338;
        Mon, 12 Feb 2024 06:38:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVRFyNdRmnrI56/3dx7QUefjzjs57XDJDIjTpqrTat4pAyajiOLgUWz5f4ruyVgpr9T0RDzZfdPHXec5UUU8dLhEeZe1fAl6TznusNB7EuQTtTq8DLG+2uv37V6j723a8rvtHVMVey6FqmmQuUvPyxUiC+tDupTmdBSnpheORl5W8LbgXK0cKYpov1jbc4iSbb7liEiYk31tXNn4TtUIXkyrfKZDlmhf/aQo9QTFGypz0PtEGLKaFlB0CFA7tA=
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id k3-20020a1709061c0300b00a360ba43173sm266918ejg.99.2024.02.12.06.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 06:38:47 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	kuniyu@amazon.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 0/3] check bpf_func_state->callback_depth when pruning states
Date: Mon, 12 Feb 2024 16:38:29 +0200
Message-ID: <20240212143832.28838-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch-set fixes bug in states pruning logic hit in mailing list
discussion [0]. The details of the fix are in patch #2.
A change to the test case test_tcp_custom_syncookie.c is necessary,
otherwise updated verifier won't be able to process it due to
instruction complexity limit. This change is done in patch #1.

The main idea for the fix belongs to Yonghong Song,
mine contribution is merely in review and test cases.

[0] https://lore.kernel.org/bpf/9b251840-7cb8-4d17-bd23-1fc8071d8eef@linux.dev/

Eduard Zingerman (3):
  selftests/bpf: update tcp_custom_syncookie to use scalar packet offset
  bpf: check bpf_func_state->callback_depth when pruning states
  selftests/bpf: test case for callback_depth states pruning logic

 kernel/bpf/verifier.c                         |  3 +
 .../bpf/progs/test_tcp_custom_syncookie.c     | 83 ++++++++++++-------
 .../bpf/progs/verifier_iterating_callbacks.c  | 70 ++++++++++++++++
 3 files changed, 126 insertions(+), 30 deletions(-)

-- 
2.43.0


