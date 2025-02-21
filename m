Return-Path: <bpf+bounces-52216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23998A40279
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 23:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C050D188BD72
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 22:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BFB253F0B;
	Fri, 21 Feb 2025 22:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjEbQguj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A88C2046A7
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 22:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740176049; cv=none; b=oTpSS+IPWKic5pHF30EUXWwJ0ALEqCAOXzocB/SFbq2heKRGC98Cjcynpx7EBSrTH/ZRw6GF9OOnjSIKwzdfaW0/rN7MpipEDni9TdZuINjUx+W4EMG64d74iP6IdzB532QWNGkfZvsz0NxlV3rgeappYKoOU5+nFk5B5R6yEgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740176049; c=relaxed/simple;
	bh=YQkNTrFrv5pK2DTguftrhYDZpWftdqO0CCUr+t8+d9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RRT9MGdHKdjMRVWtgcvuVpritsH0cnuWzVDEMS/PdVBkLYfvd08ZXoQJLTftNZ68feuplT8NG9kJBU//c+LdZzjYTc2OtIHnTZK+Rjmr3S7I/gahdQ99O//BOrQUiR8ay4+wz7tk2L4cORZPqm0UHlaybq2ynzJsIQOGUEVAYo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjEbQguj; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so18082195e9.3
        for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 14:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740176046; x=1740780846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hhtHQIEJNZ40wYZE9AvNxokgDLRDjITURy4OFLnmdq8=;
        b=ZjEbQgujOZg2dWBtATY1iHJZxJ+TDtI0Q1H61QHfyPYO01Cckr8MHFsiWyHMISmKkG
         XvA0biW+FXX7xxseuxCpU6N+rZfVIQEJIX9uoSH5kX9VTwssYUG1Q3C7IE4WWoAAhpP7
         xqn0zFA0ijObDhwpuTLI77pWbgjx0z1vj94moLT6EakFuMBfH+iCQw570Py+BeAh3qzN
         ktMqMi4bgdT3sV29o1G+jGMoFz/bEm/0bvB3cQdPerneLlpW98lS+1lJkKeJFQEZh4wm
         0DQ7bcMV5dpnYHBaOUk8054fUqapzF7pjvK2lwKYy+DI2h/NNH22WSbs+KJXXpdAQUw6
         WsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740176046; x=1740780846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hhtHQIEJNZ40wYZE9AvNxokgDLRDjITURy4OFLnmdq8=;
        b=bhyhCAcse0zUNMyOHNbwT4sdkQz5eHOcL+8q3ANKgGKdpzFPdfuByRCHC1PyvNWlrs
         4eKc0nxq5IjYBdeLCUfkhTQaVx+Y+vkBQt2KDkrIdb2IVwOa7jwahn1MAe286j0tkTQY
         G9k6l0Rk+jdMrtBOWa6TR8IMoX5N4qk+S8o1tn/nafV0g10hbInYvF4nJojGjUvm2OqW
         y7TsoKaK3I/SwLICQpYF6//V2zEBy9fKkEeLvS5VYYeLXD/87r8FuonTJeBzNEAAEYkT
         uFPdT8LPsGinbzbgcnaG7esAf8wycG8TaUnZr8EYNW9ekzdN55TNlONFJPCpgacAzcV5
         Wkgg==
X-Gm-Message-State: AOJu0Yw3QoJdP/inghe4B2/fS5bwuCHwt3snkFDsduFPfjtbtMw5l11D
	n1jXaPDu3vPvlXxKqAjvKNGWqelrkql5z//4Cf520N6m5oCIzqK6n6MAUQ==
X-Gm-Gg: ASbGncv7GSOrmpY5hmSfCwO2k6n+bAZh4lMFUsruCxOeNQMXqux0GcQVpFswTX4mPW2
	euTLgsE3hJADWjS3Lj0spkfdPa3oyXaGIPr5pF4kx6+TJVOmluMMI74nbQsDN+tF8O7A7GWduBd
	UPn6cumOGKAsx1p7KlXp/ZuGBowDOJ1dlbqQI2MKzrDilSH8vIwi0zdIquhGnBt6MqS65DXrSQi
	BjVI3jGgt8E2EzR1iwITnjG8PBPEnlLd5SrWLyD/A/6o/wuxMpb2z9PmaIwSOyrhqdtN7pifRd6
	lC4ry4wz2cFhZR7gRqm7TGMns9f3hcysXobaG9oTR7Pqr1eZv1TYb5Av1dy7eruX61xV2ENF02a
	7KKZedQpRmOj0D8e0ymLVLDGWijgTokk=
X-Google-Smtp-Source: AGHT+IEJNLqBMhiCqJUkq7+7cs4rop8GSzKa0nHmAWAcQsR93vj7TrJo9iJnCT5Krv3qYZSX+qSlJw==
X-Received: by 2002:adf:fa82:0:b0:38f:2f88:b034 with SMTP id ffacd0b85a97d-38f6f085dd5mr3554821f8f.42.1740176046024;
        Fri, 21 Feb 2025 14:14:06 -0800 (PST)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7fe6sm24070707f8f.86.2025.02.21.14.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 14:14:05 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 0/3] introduce bpf_dynptr_copy kfunc
Date: Fri, 21 Feb 2025 22:13:57 +0000
Message-ID: <20250221221400.672980-1-mykyta.yatsenko5@gmail.com>
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

 kernel/bpf/helpers.c                          |  75 +++++++++++-
 .../testing/selftests/bpf/prog_tests/dynptr.c |  21 ++++
 .../selftests/bpf/progs/dynptr_success.c      | 112 +++++++++++++++++-
 3 files changed, 199 insertions(+), 9 deletions(-)

-- 
2.48.1


