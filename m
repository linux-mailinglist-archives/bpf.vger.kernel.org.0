Return-Path: <bpf+bounces-45735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E71919DAC26
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 17:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA4E2811D5
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 16:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD0D201020;
	Wed, 27 Nov 2024 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7vp2WRU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665DC200B8B
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 16:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732726738; cv=none; b=QLZybHp3P8z+VEOx0nV3wwkSy5WFAKwO5iYIUX1aZZUEVoIPFJPELUAquF3DL0hlzV6Rn7EFhB5qCIf1t0MxK4p/70mDv5pe4CkvbZo4DYRGr/g+qIbrlDZuAvd+uBRN3vSF/uapb36q0iQi4//HL/ehp/9zgt2R+MnIVfSKxoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732726738; c=relaxed/simple;
	bh=nh4dH5NlTiDfgbb3waHbwKlrhlaqFszmKXwUltb3VZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxN7J/NH6Hezkt/c73ztibG8oL72ioymK5jfQPgeKob0MG+EU6YuAXVO9RsdbjbD5DMw4JEM66Bxa2TFghvtTpMxmhNf1pRgReb7HXWZUpTM0qLDhsx5iMxCLDxoVPzej5ni3y79/Rsnj6n6vWzd8VxiHevt5siIzEm9V0jP/I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7vp2WRU; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-434a852bb6eso15692965e9.3
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 08:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732726734; x=1733331534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJwbhPzqxw6PiVwLVYiGAIa2hOssPAZ0gOhNr1j2YRU=;
        b=f7vp2WRU3JtGEAGVEopfhVYotRk+zo49qo9j0nFVcHuUrD8vc6CSb71BZ63sI0FrYp
         0SpAF9FNntIbv6aOztXx8nT5s/a1ELLZBxUNwxwXLoFqs1jLxEbNRW/BDzQ2XWjRug0Z
         M8cU7RSU9kKelsnS0juRL73uNPp9n2rAaTzpRjFDI9tdlN4LRW0J82f6AVvJ90vQJbWo
         bwbLhUVrqtsmBu02Qaf0Hp661Row1N10LqUyx/dzHQO9n0P4IR54EzooppOriha9I/ia
         wOglOetBGroJBF9IobZA7PlogYu6aogDhqS8ppkh6oBP6ZqVLpN1DjR9YW0uXE/y+As0
         zoAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732726734; x=1733331534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJwbhPzqxw6PiVwLVYiGAIa2hOssPAZ0gOhNr1j2YRU=;
        b=INXwxfKOgZ/59Iwzr55+dQnqJ2j16BSwlTwvNiBYNts8dK7CGeEyTzVDczOWo/3e44
         FfG1qljlOK6VjLyHex/G5LLQSM+SGJfuobjT562HfL25ySQTo5JDTo1Pz3ogtd70NmvP
         NnpNfgG0H9xpWX5bQsHaTB4Ed8jxl86lWiymFwDiyA6jgvnN1GyB7aW08Qk49hKY9SfF
         mr5OmkIMVGlnaGyTToqem5zZL9XGP2EjTaTmaUZZHLgjDw3BS1Z7lwnXk1+bCN8Nmj8f
         oAk6WHjCFNwFk8v6GUFh6rDYO7fdJn312WYJ7yFpnLvdb2FvH8g101RnXgaOcaDwSrB5
         5ugw==
X-Gm-Message-State: AOJu0YyTtsSbe/bKwTdKwMRbuTMXih+imqzD/lvEeJN61hpf5Ojc4/sV
	fBH3WunHfI+/jSJYxAR3xctIYNwiJtfz6DbYsROoDuxxbG+67K7/SEi5QIBIfNA=
X-Gm-Gg: ASbGncsrNQg+F/FNnrwNgt5r4MCqVYsbrxTIKOTGL2hAfQEU5MbkH7tQamzHOxecEzz
	eYeVrI0bxlqXNfYSbvguYeiE2MHnQagLbetxq8RBIQC8EPBoAlzxr0bqP9oY++17TN3DGeC1Dd7
	N3sg2OjG+4tENOAznUIBridOmc+JUmhd7I6+Ud9injgm9pG19Hx6ZPLnOZjpm8fyhTNmlUi6lag
	mQ0Xte8oWBCH5w5srYAm9UZeBX9FY/GSGO+jRmtwQlS1nnuuApfRm4JDlja4hmgjbJr6txpUAhX
	/A==
X-Google-Smtp-Source: AGHT+IFvdHLvAUd+rGUV54h0brZjraZupZOnreXgfkSg6/X0hfPojrTmtpCPrNUYO4GLmDp0kA7WJQ==
X-Received: by 2002:a05:600c:1c93:b0:42c:b9c7:f54b with SMTP id 5b1f17b1804b1-434a9dcfdb4mr38651465e9.16.1732726734364;
        Wed, 27 Nov 2024 08:58:54 -0800 (PST)
Received: from localhost (fwdproxy-cln-020.fbsv.net. [2a03:2880:31ff:14::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7f9b33sm26377995e9.43.2024.11.27.08.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 08:58:53 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 6/7] selftests/bpf: Expand coverage of preempt tests to sleepable kfunc
Date: Wed, 27 Nov 2024 08:58:45 -0800
Message-ID: <20241127165846.2001009-7-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241127165846.2001009-1-memxor@gmail.com>
References: <20241127165846.2001009-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1228; h=from:subject; bh=nh4dH5NlTiDfgbb3waHbwKlrhlaqFszmKXwUltb3VZs=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnR0+58WGn3gS6E0MxEsrWKBVooyTUjx8ax4WgHL+x cqnsw7WJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0dPuQAKCRBM4MiGSL8Ryq96EA ChVVMeaATs9qNaEeaC9B1PMbyLAj3izXPx3mmnXg+DxZdobCJ5uOv4q5glpRsLY7BTAWERHEtm+XD8 hUIt5BqsxNaAYtE4LWK4ltOhpwGZkhEZY3xHKv9qMRSiVjRWRHOAX1VFDulRmK5IWzsPN1ZwURay/a NDkJLf0QlkjXFeSkfuHHUWmaZw+c6m8tpfe29DMH1vI5Ecwz7mLdbKp6jWa21mSypGtET0OZYYPvZO P6fmDVZgMHnwsl2ymUaPYajpNhmbOUNKJmvLcETay2kmu5dSBQNku5FtnjT6Yq9uj3Ec9cHWEpqFTX xWoq9mI8nT5L+6vLhLoIYPkX9v9+D9RCa+ZCH3PNpLnNP31IHCgwgwXchuz10XF58J4DOxgPARqoBF K/YZ6TbORJvDrk7h/hE2XoE+kPB3s5o4aspqw7i6Af8VftoDhffj2ofTTdU8GIsfDlUTg8xdz+xxR7 Boha2pFbZ8JNszVNN0cAz5ilOqhi8vhZ0FIoqTXeZZA1k0yuA9hWl7S8Aexq2433mr/eMIGlWMaoMx vvXvdrpBjNhmZGv4fziiaTp9w30HyHCtNQYLNtCH2IPGIDmCVoxJFfjW47HqH4yUzTXgWOdyIHOLwU r56RPrbOQ1eYMozP5fhBQxjDbz9iQ74y0c7HIxfC+DIBvVicojImy0AVqzZA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

For preemption-related kfuncs, we don't test their interaction with
sleepable kfuncs (we do test helpers) even though the verifier has
code to protect against such a pattern. Expand coverage of the selftest
to include this case.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/progs/preempt_lock.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/preempt_lock.c b/tools/testing/selftests/bpf/progs/preempt_lock.c
index 5269571cf7b5..788cf155d641 100644
--- a/tools/testing/selftests/bpf/progs/preempt_lock.c
+++ b/tools/testing/selftests/bpf/progs/preempt_lock.c
@@ -113,6 +113,18 @@ int preempt_sleepable_helper(void *ctx)
 	return 0;
 }
 
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("kernel func bpf_copy_from_user_str is sleepable within non-preemptible region")
+int preempt_sleepable_kfunc(void *ctx)
+{
+	u32 data;
+
+	bpf_preempt_disable();
+	bpf_copy_from_user_str(&data, sizeof(data), NULL, 0);
+	bpf_preempt_enable();
+	return 0;
+}
+
 int __noinline preempt_global_subprog(void)
 {
 	preempt_balance_subprog();
-- 
2.43.5


