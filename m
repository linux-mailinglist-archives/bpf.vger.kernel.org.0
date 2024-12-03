Return-Path: <bpf+bounces-45968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F579E0F77
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 01:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16D4C1623EC
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 00:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C60C5684;
	Tue,  3 Dec 2024 00:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ey+XRiGo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575F0163
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 00:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733184165; cv=none; b=FT7Im4+zP8lad7XpfkD9dcDcr+NlmxXo2O1ugpwKjoicl9Cnj9kIiLmHzmjnDfkHHIGP9vsCWDoLe1xesOsxQx79rNb7Egr7xJ2O5usPnmQtXk8LPGl7d0PPd/qvonH7f6imPQPmZdILccw1g7uIZbKu2DFla+L+ITaCoYXVUxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733184165; c=relaxed/simple;
	bh=JWUUneYv8eJXdEpOFXY3L9UGkUO5U1v8sN6VQXEEKsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4FxbKD8qeTMIb/SU31dtImT2zSkkIAoBCej65rkhEglbSc+L319jw/GadmoXr+TqTAu53c9C7j4/247REZKVhI0rk4tHBoyGJR28QYi2pcwPqidtt2P+M4vmXcrKsg0mNrE/+cCgnOGsfu/VGvNLPJFgFrDy8otDHSg1qTk8BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ey+XRiGo; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-385e27c75f4so1905408f8f.2
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 16:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733184161; x=1733788961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhEj9lKl0l+ZK/B6XyOtKPhCvG1ZAco08kS83oLl0e8=;
        b=ey+XRiGotVmm0zsxPCFMfyMIF+jaj3j0gvhcww/DfdE34W7wq4KMGm+TDPu/frut7I
         sRiuLaaE1RuEhGP2jOm5X+DrvB87ztjl8GXBVBkGrmYj1aoqoHDVTYE+5p9eKZZQRfMn
         wjDNT6ZxE1+qiIH1PQMf7xSHf0mT5EQA8mQWy7vZb2lq5cQ9GxRgoil9ZRCMcBYnhx1Q
         9OkpcdaSBuoGtr00rnbKzdjdx2B9EN7XSS4iFj4V+CM4J42I9ORL9iLqynxOXUhXET8F
         IP+0y3UOzaPJap+901/G+71WXGbmxMMh+fLEEztxfO5zis8cLXK9U53vdvwLRvOb1qtz
         s0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733184161; x=1733788961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VhEj9lKl0l+ZK/B6XyOtKPhCvG1ZAco08kS83oLl0e8=;
        b=Fuf9Yp+1cckAShnSKj6p8rzfnl+SMaGNVga7ddhG+FCDRK+Yx7jRcDVn4g0FG/zQX8
         hUrTpl0i29e+HS+EwqN9NHWjydQqt5Y7whJZaYTZCZXeLFk+VgXjVfOhxsofbEfFPn0G
         ToH+TkfUFAb/1So80qOJofdnRaZ/tSciVwXAt6Q/1jLqx3Z6savYdl2rGw56/yyAUz+j
         uSf/3sk8mDYZZDcpZ2Rtv/uGcYjRWwZTl+01ZSRFJlEG0DyJe/R8R3ulAFivBIw+EKFa
         Y2ZT+dW4+Tfl9pxkgGwtYAWd/Rc9ZcgH5xaDF2T/bWp6LCmApdfvPysF7eh32YVafWvC
         AhbQ==
X-Gm-Message-State: AOJu0YzdHTTXYO5rDq7cxhul4WhkVO0imlOXHgdY00r0bGlzeIy9tofh
	cXk3NusiQfFe6PbKPL7R/8SO3iquft6AJO34va1NgPJOEI6TZvSeOWrkzt5zJ7g=
X-Gm-Gg: ASbGncsnErLwvgUFNBfI8RFjWSaRr7QjPLlrKBzJkIkOqUUViW3zmErtpjq4RigwsI5
	NJQqJ2XEJKKkFYC68kMJq3vZFmFQLMcTu01tj+DF2cK2aQykXGf3Lyby4pjPN4Zz6iyd/JLVUgT
	oosVOGKvKUSko5QxJGcA3yvhHibOqVwn5zuLjaQ1HFqKmniNyyQwok9hB0mH89hsu5X++HQ5Zv9
	0kn1ZQh59Qb7Gp1+f43JMgqtYCuOlkWMZAD50kQDt3++rvEXxb+kun5At9QAAU9DEB8TSkd+mfQ
	PA==
X-Google-Smtp-Source: AGHT+IELrHUMKIKA3wimZOPqBQNXk2BY3Tbc/uz9Z0dsQdwnx3HZPnXLxUt5M25aKGwXjaMIDBJPwA==
X-Received: by 2002:a05:6000:787:b0:385:f2a5:ef6a with SMTP id ffacd0b85a97d-385fd3cdefcmr372139f8f.15.1733184161029;
        Mon, 02 Dec 2024 16:02:41 -0800 (PST)
Received: from localhost (fwdproxy-cln-112.fbsv.net. [2a03:2880:31ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385d80a77a0sm12144266f8f.58.2024.12.02.16.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 16:02:40 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Andrii Nakryiko <andrii@kernel.org>,
	Tao Lyu <tao.lyu@epfl.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mathias Payer <mathias.payer@nebelwelt.net>,
	Meng Xu <meng.xu.cs@uwaterloo.ca>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>,
	kernel-team@fb.com
Subject: [PATCH bpf v2 1/2] bpf: Ensure reg is PTR_TO_STACK in process_iter_arg
Date: Mon,  2 Dec 2024 16:02:37 -0800
Message-ID: <20241203000238.3602922-2-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241203000238.3602922-1-memxor@gmail.com>
References: <20241203000238.3602922-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2564; i=memxor@gmail.com; h=from:subject; bh=Djrxmk+fGDtdvKlSWe5XHFPJVv1Xd5kIuafvO72r/6Q=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnTkjd72yQM6U+cfoac/xp/F/Xg52i+yWCQ7IsgEjM HhtEHqiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ05I3QAKCRBM4MiGSL8Ryrj7D/ 9xF2jW1a8Nb6PwLxKt9wnhlSYhMTSchQuPZ6E9eW3DJQIpTsGyS3on1mpqJyTeeEn8J5treYUKRRZx nMxnsoD2PCrZvqT96FTPJX+WSLEVhqZzG2b8o9K4uWbA9Xi48PiT4dxd+RNW6GtzgDFec5prIjp086 sLbvqzEUeORFiPSypXUQTAZ3p7csC1YlQZCuVpd8jKXBr5Nj6by0Dk6pTnZ0J4o6C2GToHtdyftohk pKnWneFSqOPE58Di3nKdt4rMUWlG8w67ITZig74cuPe4P7ASt4oIAYx0AiOw3ac1akblmx1Ieg9mKp FeLIEXDTXbqoCblzPDP6EgAOh0FFfeXa+rIOEvB2yN9bH/WwqkvNS0AEV7iSjvHhra1dBNfT/ex+to 300i/3v13AikEErxIYbULW1DsJhww0JFAMk4YOhJPTJq4rX/ComfZkRtw8h+d8FWnT1qgwxQkxEHRT V07KQlasnJY5rUOdn0oAzJLdcb6wNamMdlLjZsivuh79EI97QGTuF48kS8dbdIQaL+sEKEAE+q5jKf ty5tjlW+oCn7jQFSIOMLM0SuIZ1O6cBEfDEhY0fVI+eiIukvWchOVtIlOQbBYt/BwGNmK9rFQWLFf8 Sy/3k6OhZR4lrRJSHdE6OQIoyVyIfP1Hxwem4mYh6UQ+QI/ZVKPU9y0BcUiw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

From: Tao Lyu <tao.lyu@epfl.ch>

Currently, KF_ARG_PTR_TO_ITER handling missed checking the reg->type and
ensuring it is PTR_TO_STACK. Instead of enforcing this in the caller of
process_iter_arg, move the check into it instead so that all callers
will gain the check by default. This is similar to process_dynptr_func.

An existing selftest in verifier_bits_iter.c fails due to this change,
but it's because it was passing a NULL pointer into iter_next helper and
getting an error further down the checks, but probably meant to pass an
uninitialized iterator on the stack (as is done in the subsequent test
below it). We will gain coverage for non-PTR_TO_STACK arguments in later
patches hence just change the declaration to zero-ed stack object.

Fixes: 06accc8779c1 ("bpf: add support for open-coded iterator loops")
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
[ Kartikeya: move check into process_iter_arg, rewrite commit log ]
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c                                  | 5 +++++
 tools/testing/selftests/bpf/progs/verifier_bits_iter.c | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1c4ebb326785..358a3566bb60 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8189,6 +8189,11 @@ static int process_iter_arg(struct bpf_verifier_env *env, int regno, int insn_id
 	const struct btf_type *t;
 	int spi, err, i, nr_slots, btf_id;
 
+	if (reg->type != PTR_TO_STACK) {
+		verbose(env, "arg#%d expected pointer to an iterator on stack\n", regno - 1);
+		return -EINVAL;
+	}
+
 	/* For iter_{new,next,destroy} functions, btf_check_iter_kfuncs()
 	 * ensures struct convention, so we wouldn't need to do any BTF
 	 * validation here. But given iter state can be passed as a parameter
diff --git a/tools/testing/selftests/bpf/progs/verifier_bits_iter.c b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
index 7c881bca9af5..a7a6ae6c162f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
@@ -35,9 +35,9 @@ __description("uninitialized iter in ->next()")
 __failure __msg("expected an initialized iter_bits as arg #1")
 int BPF_PROG(next_uninit, struct bpf_iter_meta *meta, struct cgroup *cgrp)
 {
-	struct bpf_iter_bits *it = NULL;
+	struct bpf_iter_bits it = {};
 
-	bpf_iter_bits_next(it);
+	bpf_iter_bits_next(&it);
 	return 0;
 }
 
-- 
2.43.5


