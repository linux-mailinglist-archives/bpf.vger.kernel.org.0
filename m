Return-Path: <bpf+bounces-46283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 125B79E7531
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 17:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C217F28B309
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 16:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0154220D4F1;
	Fri,  6 Dec 2024 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrutUvGY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B336C2066EE
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501459; cv=none; b=Yd6zP9qNRnCSJEz80qFIXnzNN9ojj8d0ljlegUjVh7Kk4ZVxdb8CDxcwfIs+cXgcFzcTatRzpmuHsqAWqXMS8lXcHE4qadGaHbnk5fGieqhWoicTi5h0uRvYKGBB6YqJjkoBSxh+/gUvdjASdAOGm16PWdA6zxClOisGfmGgG2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501459; c=relaxed/simple;
	bh=FO6nifgHpoGd8cD6mRtvbRKDswUIYtGFfoi3dDKwlgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e5StvMYuPJPo1ebW7uXXeKHzxfxWAbwTIJ5Y3vqtCA+OvLuqhpLXDqFSO29ZuID/m4Pj4kgj+Uc5ley+c9rNuDAEIkN2A/psYKLSp/ddazJiom65UeEsXfiQMpjuBJ7xMT6JmNVzsZ9hd59DdD3xBlnz/1g/GK3vAAAltdo0eCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrutUvGY; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-434aafd68e9so15966355e9.0
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 08:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733501455; x=1734106255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s7eIB4/+ne1QsFiIlTAQHw6bG0WHjHAaTvuTdYOoHHI=;
        b=WrutUvGY7w5tmzDeavtVoBoyHmMPDSJDYXJOh34Sb59oZxX2v16aUcUVNp223newXi
         4uogdLEU1H8AphcVjFjViP1UN193Uq+bC6Z7mTryqOQPb+DUIX7Jhq2KqlCB4N3dQuHV
         2HaaG+8YoEqAf/NpHbeSu41hD207eqsixBL3eWup4sf0xBa1kIBOs5/i7/U0JVj4WduQ
         rWvCzapVuHfIw2wnYWJNnTA8wc1AO6nrNRJOjVvbN8VGtv/WVL8PIdzx8Gah48sAhZsq
         Rb1N6yBNYFwn/VEdCQ9XjXURdXOTpwazRY3xLZX/7JKxnem/Wiy7nyOd9lTi3Z9zvY7s
         y4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733501455; x=1734106255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s7eIB4/+ne1QsFiIlTAQHw6bG0WHjHAaTvuTdYOoHHI=;
        b=GODaXLaO1KefL+rwAxG6tU9JyfyDjVM7Qt5U3sBZL3hLXI7iJXdZXvDDTzWqJauGtU
         10v4pAjnD0r8mE6nhjvnKxT0DwhiEHk6Q9G+MCxx5M7oC2076I5xQkoGQ9ALu19nUDRG
         q5GKnCL67vdVDJ5NO6PabgXV06RsKKQ/60rRrV2DBCOW6PLFUcfVjR5EbUVSKuL9Q5bu
         mF6N1mmjiCRQre9uHncmeAgXTPhupRdA+zZoQOWHAW8AGCXXR923q7dpR/Gpq39I7FW9
         oAHZh24aTtaW7ou3rBIqxVynkhqHcEJVPsjEdPe5QtDKOKiOT60dtaXvxk8rdd4194/z
         jY4A==
X-Gm-Message-State: AOJu0Yz+6X6LU8tFx9KxsZVRK2+Zz8WalSyZrvRI9ZkiO4AD70sMwpdw
	aLv0RiA+FzOGX5GvBqOcZW3ywtnHPjWx6wbWNWzaLlAdqoYorsDHv6cMqoMVx0Q=
X-Gm-Gg: ASbGncu6DEGXJwmfIxu4Q5DhGVj5y7w7/pNFCTtke6r4O0hx+wIH5V20TwHVdxx6vdi
	oBjG52nknJjiMYvXS4gvg8Bs9eMS5vRtrUHvXWnnpjs3Vy0om7UsAj0zeqm1CaQjV3Osn6yCSZz
	/EkJJa7jKFgN3b2RS3qq4REwglOOVFMahUSXgt9De0Tq3x8Z719BRW06MR2mUGIdmLoJ/TF4y0e
	Llg0Fw1SGf5Vb3xOUCI9ctOUyfEf6SkFZS1M9HGA5wKPo461z5nTm5oANyYkHQmtQ/vwIGWqbp7
	tA==
X-Google-Smtp-Source: AGHT+IGGZCM7mFuyvPFJHXY/Qt7gTGW9L8Ae7MvmHd6s1F1pdQ++MYQH5/0Ny/2idzaJic/1mwOdGA==
X-Received: by 2002:a05:600c:46c7:b0:434:9c1b:b36a with SMTP id 5b1f17b1804b1-434ddeb51femr33915065e9.13.1733501455079;
        Fri, 06 Dec 2024 08:10:55 -0800 (PST)
Received: from localhost (fwdproxy-cln-028.fbsv.net. [2a03:2880:31ff:1c::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861fd468f4sm4898014f8f.60.2024.12.06.08.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 08:10:54 -0800 (PST)
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
Subject: [PATCH bpf v3 0/3] Fix for raw_tp PTR_MAYBE_NULL handling
Date: Fri,  6 Dec 2024 08:10:50 -0800
Message-ID: <20241206161053.809580-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2744; h=from:subject; bh=FO6nifgHpoGd8cD6mRtvbRKDswUIYtGFfoi3dDKwlgw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnUyEskujT75S0tl1+7eQf/x23XgBe5JN5lrT+1U/e UoiPJ82JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ1MhLAAKCRBM4MiGSL8RylZ8EA C9EEEgu4OyW8361vwSAEQrHrb6gQWhaBOdjhhTt17E849U/QGoeQ+d0ZB73Qkl3apVLfVbFIeKPTJQ YfMeFDK/69WiaJhK4iQTujtYndy+BRbr1w8vfoRMmRPp6hbPkKDHLcDXfHSdyV78nKYWSfFQjafUFH 0yAXLzHi7hQEkAlSYY9yVDUzPcNXmUifAlw2WEPVSlLIP2z3+jeP1WUwvqP6+QGI5HKkHBGY/1G6WL 4Bs51himFRtRNf/ELaNu8f43sZPT6LzGkAH1xWjXuNSubMLtsE7uVHa2wTGUeU/sR1uNwBPFHd49mv 4v039IcR90jt2lRyqC9c2fXbLmbNRExwVmzybDLpcv3RA/Qdj1FODO4w1CTBJl0e6ky1ZeNNaEd9H+ +Y6itjahqVQoNSnhkkIa84GmrTiV0Yc+B5WDBrsfe7vvJ2zdPlHNhGwioxFwPNwtSr+17icjKzYzmO j66LUMiN2wPl+Wl0QvijikC5u05IsvnJZxHjZnRHd6qmMmaEtHVLjrphY/5fd8Lp/W+PAVKq0C8lGb F8Gj4bI2V7vXGK6+AWkCjBhS3D+74J3PJdqZxHisDaAaPfMt0ooqND7tb7Mab+wVlljvgc6RGI2zmL NQSbtkWBf7OQnJbkBjly5da0cMzWfx/wF9SH1SvRumyZNcHoxeu5MB09MNig==
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

Another production program hit a case where generic code it was calling
into would perform a NULL check, while the program knows and is written
with the knowledge that the raw_tp arg can never be NULL.

In earlier versions before the raw_tp change, verifier would never walk
the path where raw_tp arg was seen as scalar zero, but now it will,
hence code in the program that operates on the raw_tp arg later on will
fail on dereferencing a scalar.

Provide a fix to suppress the warning for raw_tp args, and not mark NULL
checked raw_tp args as scalars. We will follow up with a more generic
fix to handle such patterns for all pointer types in the verifier, which
currently involves playing whack-a-mole with suppressing such LLVM
optimizations and reworking BPF programs to avoid verifier errors.

Changelog:
----------
v2 -> v3
v2: https://lore.kernel.org/bpf/20241205223152.2434683-1-memxor@gmail.com

 * Add Acked-by for Patch 1
 * Add fix for scalar dereference issue
 * Roll both fixes into one, as second fix undoes first
 * Fix nits

v1 -> v2
v1: https://lore.kernel.org/bpf/20241204024154.21386-1-memxor@gmail.com

 * Fix eager unmarking bug (Eduard)
 * Generalize approach, always unmark NULL when off == 0 is checked
 * Make NULL check noop if operand has off != 0
 * Do not reset id when treating as noop
 * Trim comment (Alexei)
 * Adjust selftests

Kumar Kartikeya Dwivedi (3):
  bpf: Suppress warning for non-zero off raw_tp arg NULL check
  bpf: Do not mark NULL-checked raw_tp arg as scalar
  selftests/bpf: Add raw_tp tests for PTR_MAYBE_NULL marking

 kernel/bpf/verifier.c                         | 44 +++++++--
 .../selftests/bpf/prog_tests/raw_tp_null.c    |  6 ++
 .../selftests/bpf/progs/raw_tp_null_fail.c    | 90 +++++++++++++++++++
 3 files changed, 133 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/raw_tp_null_fail.c


base-commit: 5a6ea7022ff4d2a65ae328619c586d6a8909b48b
-- 
2.43.5


