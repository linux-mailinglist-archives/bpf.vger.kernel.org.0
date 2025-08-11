Return-Path: <bpf+bounces-65372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F7AB21502
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 20:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6910627067
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 18:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC3E2E2DD0;
	Mon, 11 Aug 2025 18:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrVb/sau"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16DF7081F
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 18:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754938706; cv=none; b=aA4W+vxCXRNCqdH7cJLxJBh+jyhOeYOBhlzC+FstEU49tZ1Dp/WmteZsVB2TRwzcXbC7HH5RaMEln0ikNcJ6lr9/e7ZBKA72b8S+HsUZbJ7L7K/vYvY2pyHJVRwzozQQu9x0+yE85/C3tJEao2/oBU9u5IMO4HA/6o0nXnGRpKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754938706; c=relaxed/simple;
	bh=g4HuACcTWPhSeL+B5E+pWvj6Q0IqGwfs2lLgCXcrYGw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HOqgQz/EKgaGVkhsViw+HGQkfUZyCuCTQyEmz1iH/FCXSvVt8P1rrIL1jOOoZ15HbqBKuM5TtB45PDeJfjLxfw/Zju5ruo+kRjCf+YPRH3EDMf/FnyeR3RdBG4ayG9P1HmJcEAAkjKAF6Be3hO+XMg9w2K41R5GhQmAe1Ev0Vfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrVb/sau; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b77b8750acso2870823f8f.0
        for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 11:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754938703; x=1755543503; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nDimzsHBzaF1bpfrpQ+H2ZQ4cEId6zLzgkyK2UidYfc=;
        b=BrVb/sauIz+lgZPfwQvF5CsaeUMQr0mNGPAeTUsvHkCnBbOSx9xIfxLxzGSdGHN2AT
         IO3d0aeESNLp/y9HyxTp7dWALdsVANUUpOkPPFuPtIDfhFYdVqGMRZdEAqpXPFKcrSsV
         3h2i62gXb4o3QC4gLrhT5Q1Nw7eGjyQWBiXWeZVDv6/HM1HzZbnTFQkbjsynxLB/71Y8
         +xvlI0FGDpqXSclvJ8i44mMfWFCPnixoYoFd1w4kNfA4bBQsvkbzgZLTJ6uZ3Vb7PxCb
         fR9gYsedNOfIg2BAXvtGA6V512oBwtrTiXljpdeUKSwRbGCV5y897H7JC8ioM1zVeCCH
         7bYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754938703; x=1755543503;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nDimzsHBzaF1bpfrpQ+H2ZQ4cEId6zLzgkyK2UidYfc=;
        b=rRPQ0qX6IuyhB6JjmlkqMSKA0ldzPvVtd0hu/0FNpnmuoSZfo1X4BM0QLakxXkfb1L
         +zBmETlWv13+GxfholydJEo5j35I5zfmgH7mJlHW1r/iOagVScNTkOoF1cQeyBeHGa8e
         vmVy5t6QvR8G3S1NXSdEHmprxIVmF0J72ch+U43tkiSw3nGCiV7ibu/MnKAB+kEamdYZ
         6S9CgHk49wZRk6LPlJOXHtjMwXnQdLW4wDpYAss1XTMgowz1nl8epE1bR++NfvOj9RV6
         gsM0ztpwlvWnNihAoTxeTGEN5jgWDVzw7WYtSp5/Y6XyARFaeSVmucwfb+5fi1Zi5Je2
         yLBQ==
X-Gm-Message-State: AOJu0YxJ7VQwitCrYOP/YKuDhVMlwPYEUNKNMykrgBNWW38qnxv3wM8X
	k+0gT7B9io8OrMWj8BrMuxm0D2ySdtgTAt5IYdSHi+ME5BSmBhweEOxL4xMcdw==
X-Gm-Gg: ASbGnctmr0YWg4wziz7amM+gTau0L4un+wW20IhI7+gc4gcahhl48ECD9asTxnHC/h1
	1Is3Yy+WLiH/1NwTI5uOfifNtaRu9j0aVFaicJoo72Ge8wbxvGJvGOD9ro3Votv799HaiQnkCpr
	goE9XgL+9cH/UpG+M1o0Pm94lbWNaAFDC7Sn3yMTbAICXeM9yp7Eh1QyMTNpoFnlAyI5zJKpd5T
	mYMUi0H4ez0ybiM4kNJnRVccqTmciuGNuG3uLDliqPEwKndRQ6E6jlmwxOVIkCv1htY1jYYAbQa
	8OSh4k+zfUACpTHVy+6dXhnt/wIJHjE1vuNQVPQ/6HzLZdhidh61TW/C+fwkowqDMBnwCnC1jpS
	qiIWwdniVrOTePUQ28wc8vCU+anbsQ5RChMGEDmdvhWHAjzmG8Xx38q1FWMTdl0sac9Yqe2TKow
	o3Bcg83L/mqoYS7RFXyieQaDq70Iy7vw==
X-Google-Smtp-Source: AGHT+IHGVIQ3hqBZWQxI+YBRoqVJW57piYwmky2s78j3NsZWM0Gs5LeCPpfN3epL/rgrs/CLxHNiqA==
X-Received: by 2002:a05:6000:2203:b0:3b8:d8d1:1e72 with SMTP id ffacd0b85a97d-3b911196bbbmr577642f8f.19.1754938702677;
        Mon, 11 Aug 2025 11:58:22 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e000ad9dfde2319be05.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:ad9:dfde:2319:be05])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac51asm42488282f8f.1.2025.08.11.11.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 11:58:22 -0700 (PDT)
Date: Mon, 11 Aug 2025 20:58:20 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next] bpf: Tidy verifier bug message
Message-ID: <aJo9THBrzo8jFXsh@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Yonghong noticed that error messages for potential verifier bugs often
have a '(1)' at the end. This is happening because verifier_bug_if(cond,
env, fmt, args...) prints "(" #cond ")\n" as part of the message and
verifier_bug() is defined as:

  #define verifier_bug(env, fmt, args...) verifier_bug_if(1, env, fmt, ##args)

Hence, verifier_bug() always ends up displaying '(1)'. This small patch
fixes it by having verifier_bug_if conditionally call verifier_bug
instead of the other way around.

Fixes: 1cb0f56d9618 ("bpf: WARN_ONCE on verifier bugs")
Reported-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 include/linux/bpf_verifier.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c823f8efe3ed..d38b5ac6a191 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -876,12 +876,15 @@ __printf(3, 4) void verbose_linfo(struct bpf_verifier_env *env,
 	({											\
 		bool __cond = (cond);								\
 		if (unlikely(__cond)) {								\
-			BPF_WARN_ONCE(1, "verifier bug: " fmt "(" #cond ")\n", ##args);		\
-			bpf_log(&env->log, "verifier bug: " fmt "(" #cond ")\n", ##args);	\
+			verifier_bug(env, fmt " (" #cond ")", ##args);				\
 		}										\
 		(__cond);									\
 	})
-#define verifier_bug(env, fmt, args...) verifier_bug_if(1, env, fmt, ##args)
+#define verifier_bug(env, fmt, args...)					\
+	({								\
+		BPF_WARN_ONCE(1, "verifier bug: " fmt "\n", ##args);	\
+		bpf_log(&env->log, "verifier bug: " fmt "\n", ##args);	\
+	})
 
 static inline struct bpf_func_state *cur_func(struct bpf_verifier_env *env)
 {
-- 
2.43.0


