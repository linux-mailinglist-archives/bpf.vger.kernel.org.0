Return-Path: <bpf+bounces-45773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846679DAFA4
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 00:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63125164147
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 23:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820A120409A;
	Wed, 27 Nov 2024 23:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEBimnW6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2EB20408D
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 23:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732748517; cv=none; b=W1frM3MoGEcLRgoij298ZXtSxVoftg45hJgFVT7wjOrzJRl/czSN1jOXFvkAOeHc+NzImGn4SYy0eaHaft/NRQaGn+JzrFn/G7icDSt7MgLoF1KWfhLdzc7Fin3gC7UnnB59ct9C8xJ/H0V4S1hosDixxVfDkpbtXwwXjdH2QJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732748517; c=relaxed/simple;
	bh=VVSnnd5PPxsbyeRoUs9dYQOdFuOdcxqauXYXxOFgJNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4yV/G8Nnbe2C/7sWwJKVOT70/jY6bR0MG6d09OD3FDdox7WSoayR353OB6kE1XAbpTWQ/rFk4zK+WZfKhW4BEqWH5Xvfm05BwofDc1qMAFkkH31Z/55r8P25CAFJNY27aWiEXPRY1lRAmdty98ZP5NaCQePIbmrapYsVZUeb9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEBimnW6; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-434a9f2da82so1498195e9.2
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 15:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732748513; x=1733353313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLqPTyADr8UAmbhI/kaJVTbXI0NNMl4IlBiwUNjwiMQ=;
        b=VEBimnW6YfGz+zBBICZV2A+iILT5HkZtdFqDUAy85mMKZYagxRL6SiPw3MSNkdEHcs
         o3xgn3GUk7pOroMsbKcmmqNYkd2RhdLEqGWrTyZUce//MoHVLsOx0Us03QwoCwiFjmr6
         3KP+iGvQ39c9PS1/INpPBtpmUSlt5l0v9Yda4vpEEBLtl4S9FC53/sNXbL3oXh9t8I7x
         UtX5kfl8YinHoA+Qa7QPEiWoK/B4wFb67h4mxbgTvIlZCsWtpfM6wU8Jm53lFJHmSgys
         Y4fKjCaOHyA2EzGsmv5XxvtGAF1+xCJDsRFfQPpL5I+XxUOMPrwM+9PFVLS+S0cBYOa3
         9sOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732748513; x=1733353313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLqPTyADr8UAmbhI/kaJVTbXI0NNMl4IlBiwUNjwiMQ=;
        b=hVVkzwo85BDWU4tlnLg5EkS+xuHSQoI4hnMM53HMScKiGvp6RJ5ZWDL7yOXXCeq/ls
         /hhEeVDZ/U+X+7Toi2F1X0MpwDQoHiuIyN9Jm2aw9aPwqlv8cDKSmvyqMAGK6upZ7KL3
         B8KU2sfQJNPDt9GkZlWNNYULAcN48c4xVPiM+/uDR5bGQ0p1dCd8ZgqBhbsAKVKH3U7E
         sPwSepEKQqgdhq7n7NlMYzF/wFP9Ww4fWDCsiP4IVs4e6tmEAyYSiWqIt6axW7cm7oXo
         gVk4RLJRER/zznezC51ywWuF75ScGFzQgecG+z3RNvwuLLfdgaTvF+22jSHByNx0/ZcN
         hILg==
X-Gm-Message-State: AOJu0Yw2sJYxGg688Is9vmEuHtU2aOgSKDUUTQGIjPq4xRHB+mx+46mt
	SMuAMXjiViTVvKjk1ldIv7WSNb7z076rsmFucH17rFUJnox4GhKSRZOpgeBPzPw=
X-Gm-Gg: ASbGncvzj4UlHi5+2GvoPAnTvP6tzIdcDHWYEUaHROIrbtqPwwx6KlFkbjUgycwslN3
	s7hpQVBNRl3luz3FH10LSE14sKkVMykx5ahcaVidswKUpsxOKLJIMfOMR/ygQUvvBFrs3JUMak9
	FMU8jq+sW/tYb2zNqwkGTdwuz6q8rkiDKNhZ0YMbUPJqYrcGmOuXYEVctdEZCq8YIJeVXi0+JBQ
	LYGXO5ZbYIGCcX3o/FA0+wt2LVwZvfjiL45u1Jqe8TuAcH5QyZnm4g+MVZyJkJoBNgq9Z8aUBf1
	Zw==
X-Google-Smtp-Source: AGHT+IHN+Cidx40D5mLs3P8xxVwfZK7zGudhyYwAaK1sMtxkVZ4YCJnVDHaJ1RsR44I+xV7ptEa/PQ==
X-Received: by 2002:a5d:6d0b:0:b0:382:450c:25ee with SMTP id ffacd0b85a97d-385c6ed74c9mr3963807f8f.40.1732748513195;
        Wed, 27 Nov 2024 15:01:53 -0800 (PST)
Received: from localhost (fwdproxy-cln-116.fbsv.net. [2a03:2880:31ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd68b41sm64763f8f.74.2024.11.27.15.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 15:01:52 -0800 (PST)
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
Subject: [PATCH bpf-next v1 3/3] selftests/bpf: Add tests for iter arg check
Date: Wed, 27 Nov 2024 15:01:47 -0800
Message-ID: <20241127230147.4158201-4-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241127230147.4158201-1-memxor@gmail.com>
References: <20241127230147.4158201-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1360; h=from:subject; bh=VVSnnd5PPxsbyeRoUs9dYQOdFuOdcxqauXYXxOFgJNg=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnR6TVDgupXJk+tPJ6UVIPrYB0L6XfIHP2RWidRQMu D7PPcPeJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0ek1QAKCRBM4MiGSL8RyrRED/ 95/0GEJa3X9Rp8guWEJewBYHId8jXZTZ4REvhIrNj4WhVaH9r8EoPRPI3MvF+4ohP58pjhGatV/+5v 8kX+oSR7apenfG9YoaQPz1bCrbaFB07G/1kHV0oNMFy2JbYc+gEVEwh+INA8GzQBR7Im0IdaxGEf1+ Jq6siMA6gJTAEw+ZD0Qgxnevx9+ZWE0nTfLSb4gUj2PQxVTZ0ibbWeW2MiuJ7EeU6rG7PaxgVTl2fw EKqcv4TlGKxJoYEbZ+Xdz3e28Z/XFRfFlv8Ss9VnU7A8HAk5kaNTQgaIJ7ZKCBbQin/AfItSw3A6Tg 5RHCinBqPQlQnYtI/WITSs/Gxac2Lrg4If+Bo+/8DMfumIMPgsNHZGsAdn2iDiLJerAv9vO+KfPI+o OUES2s45fft+CJAbbeduMiikeAFOFwb0nMjwdRt3isOtK0eSw2LthK4Ov9knnfdVzSSd7VTxsGieLO GV1x/wnPfEC/nRfbSAFAgFKTGgxMT4yjrijZYPAmrpbb7pCtVS03Gp5kegxMcd5JYbe+8lSe8XNP2+ eZ6ERp4/mIkZtyaKKSYciTHw/1WPG7tRAJVFqRq7U5zILEsACUfZJ322RU//if7Y4+vPBnmDm8ue9Y DeE44b7YxkTAX5SW3YT8o7NReqS2gyW+9yN5fDS9RuFMULEqljqGFPpftt8w==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add selftests to cover argument type check for iterator kfuncs, and
cover all three kinds (new, next, destroy). Without the fix in the
previous patch, the selftest would not cause a verifier error.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/progs/iters.c | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index ef70b88bccb2..7c969c127573 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -1486,4 +1486,30 @@ int iter_subprog_check_stacksafe(const void *ctx)
 	return 0;
 }
 
+struct bpf_iter_num global_it;
+
+SEC("raw_tp")
+__failure __msg("arg#0 expected pointer to an iterator on stack")
+int iter_new_bad_arg(const void *ctx)
+{
+	bpf_iter_num_new(&global_it, 0, 1);
+	return 0;
+}
+
+SEC("raw_tp")
+__failure __msg("arg#0 expected pointer to an iterator on stack")
+int iter_next_bad_arg(const void *ctx)
+{
+	bpf_iter_num_next(&global_it);
+	return 0;
+}
+
+SEC("raw_tp")
+__failure __msg("arg#0 expected pointer to an iterator on stack")
+int iter_destroy_bad_arg(const void *ctx)
+{
+	bpf_iter_num_destroy(&global_it);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.5


