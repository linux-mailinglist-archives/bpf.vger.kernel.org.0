Return-Path: <bpf+bounces-79177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BF8D2AFBF
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 04:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B50EA300D92A
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 03:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0CC33769A;
	Fri, 16 Jan 2026 03:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+bXTpyK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C10523EA83
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 03:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768535436; cv=none; b=PaVW5pyjvPVPiDFlVYpEteWw1Oe/Pmzz7yjVoOmCTpf4Z+TU5G/Yu05Ly76XzDKvIPNHX4Xp16Rp93oklDgTA1UxZ3XbvvwRLg6AiKmof1rHBsqW1ZoGWK+DldVYTIznycH15js2yYyYwxFMjL9CSbJ4JqhE+Gzcp9fo3z2Tn68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768535436; c=relaxed/simple;
	bh=W5vHBekSY53Vj7NOebsIaB44z4J+hbyazQnXmcWOrXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TxaqwIiZO1xQRG9ZLWej2PeKNlK3mPdzEIcFeNwePZ4wicrOUsocc/8OUBMd8Nd/83sAUwc8E4TAuLJuE4rIBCNZuyixYelG/4BxMwmIOe9TtTMO1t1p8uNhn1jGRMXgz/ygc0GRnh7kaBJ5hfNW5uxjxiI4D9WlWuUdvL7bxpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+bXTpyK; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c551edc745eso769605a12.2
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 19:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768535435; x=1769140235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I4Nw1xHIHRTPBZ6KLjZI9nX2i+deS8eDOs2dsUOkwu0=;
        b=H+bXTpyKC+a0lHXxHs0bDv6NOkgPGAhlB1njlc76p7Z4fonjj/E4FvtY3Ow1HgsqGm
         yfpAHfr6QphQg7E8Ie61hnv6oMO3OOhI0qWY0+LKs051ry+xpwCEw6nYl26hSAOhOKwH
         GvtQQXCSMbOQ55+toZYCXaQbkxCk38t3q2I/dW5TzoxUQhoCTS4efWkbe/kPqk7Ne+RQ
         x+wpWTu0dySyJHfHAEnktVBD6VMxjPWGJNQcSM61nODCUkFOKx6KPJqQrfItadVygw9p
         3SJ1gVbp4VZ0m3yu1tayhcvgzmVJK4odfKkYHhQuw3zygLjTHbmC0QxRrmPbpaEEKtI1
         ByzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768535435; x=1769140235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4Nw1xHIHRTPBZ6KLjZI9nX2i+deS8eDOs2dsUOkwu0=;
        b=Vxiv4B0FN7DdW731fK2NFsL6im4tUBwMaK8ecmnQP3PSPxySTezhbKBJogCfydgzAV
         1+KdaOgmxKHpgRYhmMcCyyvRiMWTUXHM55vlKB5k9mSPkZy/Xvgb12JhJgVyw2+EMcJ5
         F+40zOAnIJV7Nz34SW/80yt70O/pUV3qh+YfzSZguH6AGse6qF2EkBqIYmC5XO0tGBWJ
         SMRTiJHpvnxiKMOfjf5GtCpibLCzh6nzetGYhj56tVZkkGKyQovFZ4CfAedrRZOX5jI3
         XPAgzxe14k/jrcKpBe/HA18wbOMtQ3mBgjvhfFMltsHFhkzpFkfHcd+3To1OvThepGqE
         G54Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+3rT6oZdrfhmLKYqkE6ZQFZurPoLIvmbeMq5Wva78sGcGKoI3hT4NvYEQIFvaGP3Drhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGnzkLnHHWT9PsIeJqNnTtGOZ0oHDv8gxA2UuVlSPC+aWfeO1D
	iJGfoN8649O8rYrtqjZg/qGBpsLdDEw38JQRbQXsRqWmREzMDcAkG4mk
X-Gm-Gg: AY/fxX6P9jYM83UnnuBAyV+NY0kR9/nOtDR/Pg8qXxPITRZzrvzXipZbx69YPqvC7R+
	ELGVrS9+Uy20DfVnmy9f43byoOBCrZh9RCsrC663gbfAvO/4MSa3Tiu8nRQZb9Um0vfrCLNdI21
	BcMSNNmJ9Nth/RQqDZDnLjj/w7hakqw4aP1qgxKe8g0DOmRbTxrYTaoRn6jJWful6nodh5Iophb
	k4pO+49ctJrESnUCNOx99Fk6RdWm/WQBEYqu3nUobfyiyiy8PDn+vye/90J7qJf1lPyqdzmHOOm
	3waXzjjqtXkZTX+T/rOK9VE9xY3hTh/hrZoDWT2Wmh7km1W67qvEu/tRJSIOcYDL0BRU9wTtqNh
	kMzFJkOl4GkoS/0VMipb2rprTNKl4bDPQHFh0taucJ/EmhYYuDKI1d0mr8Yn2ShKCV5LzxqrnaY
	kwY06yuoE=
X-Received: by 2002:a05:6a21:683:b0:38d:e676:6da4 with SMTP id adf61e73a8af0-38dfe5bedf6mr1791438637.11.1768535434866;
        Thu, 15 Jan 2026 19:50:34 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf37c9d7sm684504a12.35.2026.01.15.19.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 19:50:34 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
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
Subject: [PATCH bpf-next 0/2] bpf: support bpf_get_func_arg() for BPF_TRACE_RAW_TP
Date: Fri, 16 Jan 2026 11:50:22 +0800
Message-ID: <20260116035024.98214-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support bpf_get_func_arg() for BPF_TRACE_RAW_TP by getting the function
argument count from tracepoint prototype during verifier inline.

Menglong Dong (2):
  bpf: support bpf_get_func_arg() for BPF_TRACE_RAW_TP
  selftests/bpf: test bpf_get_func_arg() for tp_btf

 kernel/bpf/verifier.c                         | 28 ++++++++++--
 kernel/trace/bpf_trace.c                      |  4 +-
 .../bpf/prog_tests/get_func_args_test.c       |  1 +
 .../selftests/bpf/progs/get_func_args_test.c  | 44 +++++++++++++++++++
 .../bpf/test_kmods/bpf_testmod-events.h       | 10 +++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  4 ++
 6 files changed, 85 insertions(+), 6 deletions(-)

-- 
2.52.0


