Return-Path: <bpf+bounces-47882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F46BA016B3
	for <lists+bpf@lfdr.de>; Sat,  4 Jan 2025 21:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 858507A1E45
	for <lists+bpf@lfdr.de>; Sat,  4 Jan 2025 20:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23141D5178;
	Sat,  4 Jan 2025 20:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="U6vqF4EO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D86714D708
	for <bpf@vger.kernel.org>; Sat,  4 Jan 2025 20:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736022334; cv=none; b=kCGMFNt7+6nKRM4QpXiZAD59hdT/uQtp7VG7gnHfoN46fxGF62KTsyT/EvPeUsf7Ey0J+WA0I2ENRyU6G7uRp2y6ENu+hTrg4ceg8foli5lDUown7MCR7bDWAYUdOu/fo7gHkTmedJ5WVy1d3LpYuOlXa/k0PRvjFXj7h0sJxf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736022334; c=relaxed/simple;
	bh=mafagfzhEP12oo2FlLNSj74xkQf3q9qe2L1TXsQ3U2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e9xN1zaWKY6qbfXtL5XxzHY93L+ew7CRrP4t3DnpcdDdpGB2RYskihFpSGD0PCMdNn0yuvCg119CjKLFuVcN5ZvFnE3LH+maqU9G9Yusmw3UWZwsUfew6yRHcEtGOvERnIFo/U1oNtOJ/tE5FW2fecbN8MvUhaudpHr0rLe1m6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=U6vqF4EO; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b6f75f61f9so1773972985a.0
        for <bpf@vger.kernel.org>; Sat, 04 Jan 2025 12:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1736022331; x=1736627131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ip6u4H6Qm+AOB0ufX6FO514o+Zbxgltkn9qiW74ogXY=;
        b=U6vqF4EO+9aVG3WPFg0Ak8ho9HPfwaaPDXCF27isKE0NBjKmMs2fiTLGE8IWU346cl
         SqmWQB6DR+IdxGrmRjyPXAKCNai2D2Q71+gkQXnE1KArp3frWGn+xLKeVf7NDTILQc0G
         D8FU8HpzqulLt7Ciybxt4OnRvLiv/xYmWi7fs/XYlVIQq5PEKZVFs5gzsJUP4TFyJBVe
         gPjlI3Aur8aG+y4DBB3DKUQmuAnuxrzv3vLpvJ1Dqyvni5jMalVHmJkaEd39t4bStxyM
         Jrs6k6X9w1OOTl0Hsvsb2RoWIFNljSQisMhHVw0cplN7saWLizGegyx/SnOZHsqjtwFj
         Oa3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736022331; x=1736627131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ip6u4H6Qm+AOB0ufX6FO514o+Zbxgltkn9qiW74ogXY=;
        b=fCBbx/xnL4EIdBXuqOdPhX/q6vOZs+Gvygn6XkuBSo0i2VMLkzxMLfKSRuSzjsY6Qr
         6ovl5WuWkQJARhhnj1a6a6Q655Hl+ck4wwXRH57v6OG4oy9BSADOhi6HnKMRPd8pglOQ
         0E0ErYN+iiG+O/XEfDY6W+Rdhcy4vNDC8B83X7jJm4XGZL+fYTP2cE+9533rvYn+54Ic
         eWAgQUAAL8NGnJMrWCcf5kwbMAe3jFOc3xNak9hc/kH5D8wf3KnvAmgM6TcAMbqMitoO
         5IbR0yrY1Ww1+i6HWKoayggAhZau1dvWOc78SwRCkXa96GFMpLcafp0XesA5ycmYP130
         bU0A==
X-Gm-Message-State: AOJu0YyBXiWo7hVqP5dgFGBd2NbWWGvQu+QyKUKLB9gjgvST7fhQK2iA
	//1Pn33/WqXamN/ifthpyBMWQT7rjY8yir3ZUEP5O4B/4HlrnpzHGMjpV3RLZQ1Dtoz7zILM7ef
	3da0XUg==
X-Gm-Gg: ASbGnctGm7W7xWAXBd7d6q3vidDX4MKpdW6IZaPmO/KgQ6l4KcM0A9QPwp/Wq0TCF7/
	Mq+dk7Evuc4CnkDKhMjeyfN6/0LF0z8uvcwVGVmEEyDDF3UOppUtTQc24WjKNRSv5IavMylpTVJ
	ng1OuZQSXue4DNi8N8PNQWkfFitc++D4fewfsGznhw/VLHTfyMDGlSaHsucXkrM3YeJSLK5f0BN
	9B7teFSDbv16yxK8x9uFDzYvsqzO7KKyCvnWOZMom3z3vYNPMk=
X-Google-Smtp-Source: AGHT+IHPIcazoWCfZMgX987U7H4hchJ+1AGFa96IzRuH0tkb9j8VkpXZObthwzZ0RR34Y9zA5peqUw==
X-Received: by 2002:a05:620a:2453:b0:7b6:ce6e:229c with SMTP id af79cd13be357-7b9ba833574mr9106522185a.55.1736022331007;
        Sat, 04 Jan 2025 12:25:31 -0800 (PST)
Received: from boreas.. ([38.98.88.182])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac30d7e2sm1376162085a.59.2025.01.04.12.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 12:25:30 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v2 0/2] bpf: Allow bpf_for/bpf_repeat while holding spin
Date: Sat,  4 Jan 2025 15:25:26 -0500
Message-ID: <20250104202528.882482-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Tsalapatis (Meta) <emil@etsalapatis.com>

In BPF programs, kfunc calls while holding a lock are not allowed
because kfuncs may sleep by default. The exception to this rule are the
functions in special_kfunc_list, which are guaranteed to not sleep. The
bpf_iter_num_* functions used by the bpf_for and bpf_repeat macros make
no function calls themselves, and as such are guaranteed to not sleep.
Add them to special_kfunc_list to allow them within BPF spinlock
critical sections.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>

Emil Tsalapatis (2):
  bpf: Allow bpf_for/bpf_repeat calls while holding a spinlock
  selftests/bpf: test bpf_for within spin lock section

 kernel/bpf/verifier.c                         | 20 +++++++++++++-
 .../selftests/bpf/progs/verifier_spin_lock.c  | 26 +++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)

-- 
2.47.1


