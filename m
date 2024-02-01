Return-Path: <bpf+bounces-20902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C10984502C
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 05:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA111C2319C
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 04:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C04D3C49B;
	Thu,  1 Feb 2024 04:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WP8fgFma"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CC33B78D
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 04:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706761294; cv=none; b=hERjYmSVc7guyhYX9qNhXYMF/YwNKeyyGJjtLd+Ix9whQOtzIBSnKduZEcSV8YJldmUEgUUbdRdBf276UoJPXbKLwYKjE7GweeHQLSc2Cnv2ly+HgDbyUgUfyVR46+BkCv+IlJwaNHFliIre0QFg6VHxOfZs+Wj5rN7h/5fnHqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706761294; c=relaxed/simple;
	bh=XU5PGSxoKSfgmoxEeAMnJYVKcZEFNE5w1yXreQ4Wi4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YvVlinklfjwsivZII8aQnponONk4gkq3J47tkcElxwH9HzSoUrIi27XbyaR7CJs3VEo3E13yyRHnUoSsiECVNnnw5LX91+IDboxZUay5iGBZFiWfdY8RLIROJKwdevcoLfCOrtOhmdUoh/SlBkCRtS12bLESfWnN/uTpRIZYsj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WP8fgFma; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-55efbaca48bso557809a12.2
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 20:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706761290; x=1707366090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyEdEXxYMF4SNG+EY6o6CSJuRU5QFMRjr7Kwq62OyVE=;
        b=WP8fgFmas55n7ba6rYbhYsUAAnRoRfsI7vHMrgYiZ1tBkjTjeqbiGlfoYZ6aPzRr5H
         H8FCB0WHWzXEBO5yTpwPArqGpi9mpZjTsI8UGL5buDiO7JiEE9gQZcphzuuqF/GJ0NHu
         a/RpGJ/LUXz9FYa8/DUeJSDLmMW+Z1LqbqDYpI6JP1Vcxsb8N6wxD6uhWmADpNTlyll/
         UgA7HldKrNV5ggFv7pUNztyq2fTNAOzBR84qyfuIaLdFCj6XUrwg9GtXd4yuVRq2qCp2
         mLsGAeG9IO1apu11sx9Wj4atG9QXrdjP/uDps6ubfFr82x0+xfpGhR/qoK0Q9Pj73r96
         3ueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706761290; x=1707366090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GyEdEXxYMF4SNG+EY6o6CSJuRU5QFMRjr7Kwq62OyVE=;
        b=RBtTDloYvc7EnfUsvhA9Al+BGmfsY71Lv1/0urpIprrayLfWrzVq4LdV0SuxF4l3PV
         BHymz4VT2K0d+p1D6QFnraZX/Y1Iy4NCjDXD8ocwRZOtf9JjjBtdDcki9Zh88wDuV3wU
         flJ12xwQb0sYf+qshz3zbs7fBhacxEVsCunWjOonuZ681WwrtAltRgBz/1OUF7Y3j/1C
         hMAxFfFYrsZfuzjvtdFzZbH6vv3LrRoGMFy5mniV4gBZd2DmtIpaqBuTLmyASjpSt/0C
         TMf3bVlAVjOxoF1/UznnEoQd2XhUa46ILxtBbgfqFRBRySCG7C9Uxkrfn496W9H0UzBy
         TzaA==
X-Gm-Message-State: AOJu0YzEq8yNzeuHRjsGu9CSb9wwC544VuZ+cBcHUhnZeGuTkykys6E1
	L2dTTKtRFDK2tMSMrmXiZfwrLL6XdusH+AQE1stZMgk3e5J/nISmXvEBo0IUqr8=
X-Google-Smtp-Source: AGHT+IH24qSOuEDBYxTjv2EVFOtnaCEH2b1/dkbUjlEhjt9LN8fC2YRrObbswCvZpe/u1cNg3+NenQ==
X-Received: by 2002:a05:6402:160d:b0:55f:3fe8:3178 with SMTP id f13-20020a056402160d00b0055f3fe83178mr2610094edv.16.1706761290100;
        Wed, 31 Jan 2024 20:21:30 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id p14-20020a056402500e00b0055c67e6454asm6501337eda.70.2024.01.31.20.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 20:21:29 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>,
	Raj Sahu <rjsu26@vt.edu>,
	Dan Williams <djwillia@vt.edu>,
	Rishabh Iyer <rishabh.iyer@epfl.ch>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: [RFC PATCH v1 13/14] bpf: Make bpf_throw available to all program types
Date: Thu,  1 Feb 2024 04:21:08 +0000
Message-Id: <20240201042109.1150490-14-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240201042109.1150490-1-memxor@gmail.com>
References: <20240201042109.1150490-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=810; i=memxor@gmail.com; h=from:subject; bh=XU5PGSxoKSfgmoxEeAMnJYVKcZEFNE5w1yXreQ4Wi4c=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBluxwQ7rRmTvy4QqZ8xAsYFZUQkUlXvyM5/l/zf lNXNoDQWguJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZbscEAAKCRBM4MiGSL8R yq0yEACtwdNhCCsjd1yLbef5wHJaU1k2VtAfB+I7WXlz/cb72xbf4kzvtBxhwMVuomFkmXuMMIT zbarRJAYGhG6DxiThT/BfAZ95y5E5ODJXCU7593QvvQz6IJR6zJkxh3T/MSnrBQ28am+GLi+GJp WakBCKzlV97MFhhrZaH/dj5F+E+Sq6cB0KGpC65ETyG7fpVPFNY3cL8BERh5DZpnatOGLpN6+j8 iAn9g7IrYZWgA38UPjC9sG2mNXiGJntFRCqtJQLUwJFIEB6krxbzCk0EI7eoLUMtarrY43V0ySG 76j78CZI5Kc/k1dA1dWBZNdUwcagqTmuveZ/28gG0F6NMcxGHmFw+2/9G499zPmlLsAtEfb+e/H RkfAh+fDq+tEJoi9AHPq1pa/PIW8Kxku5xiHvAI7ZNdFOdWcihKGim/ufTgaNBoXF6tSlhCxDb+ L1AUnus8dRSbynfc6d3NCo6ylEXjP2LFolcXMqvjrBU2T3MO3R3VuEhMBkAZxWJAHsR07fw+t8q +W9kih5n80LPcEA9uPbopqBJSxsfCRPy2YQ1oAnB1377j3u904cW35LW7/WGoSeW58NpwdcYZUn sQQZuhdhWYK+pAjK0lgiwCJjNZz9KxASE5a7RAJBQyvbnZTDrWl8Juba/1nX7swmEShVQmtQPyu 6912xNoFbza2c4g==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Move bpf_throw kfunc to common_kfunc_set so that any program type can
utilize it to throw exceptions. This will also be useful to test a wider
variety of programs to test the cleanup logic properly.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/helpers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e1dfc4053f45..388174f34a9b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2729,6 +2729,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
 BTF_ID_FLAGS(func, bpf_dynptr_size)
 BTF_ID_FLAGS(func, bpf_dynptr_clone)
+BTF_ID_FLAGS(func, bpf_throw)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.40.1


