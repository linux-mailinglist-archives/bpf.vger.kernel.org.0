Return-Path: <bpf+bounces-20827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06044844275
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 16:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9934E1F2959A
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 15:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3AB12F587;
	Wed, 31 Jan 2024 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrBKPrsD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AE512836C
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712946; cv=none; b=Oxrg4NyRkLLNo1P9rEeifjLxjt7SkBW2Xh0qk6jGtGMFiwAdsQ9/yUOdlipS+agERvOu9gFpwvU5g3w6BCqaiWW6YUP/duAbSe/a78BYUzICT2aWU/QwOaUrZoR9jyUTiXwqAQ30ezWvz651G054+lgM+B8Ey/xHtlaiY/dpmWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712946; c=relaxed/simple;
	bh=GJ21JTHXYe+0v37BT2RQZiKKXCM1Qqmf3ADdyP0hf+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IJ3WA68duADv5zLaJhqO48FC3y0fd/N3J+7rD0sVO6puMdrb1SyW4lbYp9umH0+mQn2FvOw+/Br1HvvdFsEh9puJtwzUeyFAu7N89VY1SP+sEjU3FkKdK4Z00y+BVci01HWZ+N4PJCC+zNQW7kH7MksIxbsiIrlhWQf6FSysmn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrBKPrsD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d8a66a2976so46501235ad.2
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 06:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706712944; x=1707317744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfA93j+zCEyICFj+8kPtyCRIcBQNWyTBKzbW+zoagdw=;
        b=WrBKPrsDk9ljlRLGN4GtMNLaVea9SROZTRndpbYHYKN9i6CuPn7kzNgobNP01WBTF6
         UWCBXfojePoEui5U20riTOYypfgjD7+e6+hlUxaxBuMwyVzPbm2v4V/iDggprcPdaTi3
         1meAOXxmvEBQ9VEpaDrHeMlWhqdLS1oED8Ev+IaENzDZhr3Dmyu5xB1KzoxG6sThSeQP
         J8j5UC9KFLRzqCHVbrcxpraqI0eKYOBTMHMi/3KGoaloBe3myWk87CcuRCPg4eQMMk38
         h1X+WGDp3Gi2pheUsUklK/zoDj6N02dlOFCupZ85Z/r5i8cGVtEkn0v/3Lf7DEr+SaY+
         OtXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712944; x=1707317744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WfA93j+zCEyICFj+8kPtyCRIcBQNWyTBKzbW+zoagdw=;
        b=IboB9lpLtD7qYdTB9y1HIqv3ebSBJkPdutwtiBAfTu/Drr7BXHK5T8z28bghH+hWwX
         Fmj4YanqNoRZnif4DOHNbfjxt/DPciUAr37BuoYa7atdoyKLXPmlrFaCkOE8qT2lZovu
         8hQO6v4YXDiTyqs5HqHBNywxTUDpK6vuO3LJZu+ybk/43I7QxUNzuuxXBsQwnWIikd5+
         4ZFZPLF9QVxPjUAgeiQMmahqarl++vBQ62RCzVFC+JqinCNvqH+NJ0b8StRS4OWdxUgL
         AdCH6qby4ciiN0uOHepEkx8WBD4HTOYON7QIQx+TAmi7fSfRpikxX0vs1pzovWtIa+iU
         bbAg==
X-Gm-Message-State: AOJu0Yw2qskt6pjl/4UBslA+AAIY6dqth1AP76NoLptuqa3vBwiyUb8z
	hAWwHugfFXhso8CEYl+/4ijpZaJ7ZoR3EPAEOubW2D+s3dkIm778gA/+OQoi4BvFekMN
X-Google-Smtp-Source: AGHT+IFDKR+r2uoNP9w0sjoN0eWDlxt52QG4sTjeNvUCUZKC1csZRC8ErFrPj/h5oZRpGzdl7FNl7w==
X-Received: by 2002:a17:902:f812:b0:1d7:6bac:5f1e with SMTP id ix18-20020a170902f81200b001d76bac5f1emr1489917plb.11.1706712944474;
        Wed, 31 Jan 2024 06:55:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWeXxiANXGcvHBW1bp9OVp6eYeUMu0B7es6i9VEq+wRKemoznPEiqWu+y2imI4T5zHEyBxkp+93xpuUIZBmaDpFgoRbLdAyAn5Mh0SdKHo44X5fX/20QPUZmsnhI+bq49gHEIXBHOkzC1zV3/hoyToscIJuHtcq9ZytnU34KLkNdYWvtu0frDYZGfrbE53WvXE2uNosxvkLz933cfD/ZAcFfPpgrnCVA7UJv00KXwrRAHuLpg+CgdjEQE5N8hCGcRftJso81ItXM+Fc1tk+Vy90i0rFa/aTf9iFj8m69PLUVkR+YZ8zNLtkUyI8WpGRhaLPQ1sZsdoyplVLNSrPm8T1AbTB4cEWHnQh9EMJHBVfkW/iho7fuXLVj/cZKS41Xk7HrlqjRus8wkUNq3w9uLZ3Pah7
Received: from localhost.localdomain ([183.193.177.147])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902a50500b001d8fe6cd0aasm3901335plq.286.2024.01.31.06.55.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2024 06:55:43 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	tj@kernel.org,
	void@manifault.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 bpf-next 3/4] selftests/bpf: Fix error checking for cpumask_success__load()
Date: Wed, 31 Jan 2024 22:54:53 +0800
Message-Id: <20240131145454.86990-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240131145454.86990-1-laoar.shao@gmail.com>
References: <20240131145454.86990-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We should verify the return value of cpumask_success__load().

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: David Vernet <void@manifault.com>
---
 tools/testing/selftests/bpf/prog_tests/cpumask.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cpumask.c b/tools/testing/selftests/bpf/prog_tests/cpumask.c
index c2e886399e3c..ecf89df78109 100644
--- a/tools/testing/selftests/bpf/prog_tests/cpumask.c
+++ b/tools/testing/selftests/bpf/prog_tests/cpumask.c
@@ -27,7 +27,7 @@ static void verify_success(const char *prog_name)
 	struct bpf_program *prog;
 	struct bpf_link *link = NULL;
 	pid_t child_pid;
-	int status;
+	int status, err;
 
 	skel = cpumask_success__open();
 	if (!ASSERT_OK_PTR(skel, "cpumask_success__open"))
@@ -36,8 +36,8 @@ static void verify_success(const char *prog_name)
 	skel->bss->pid = getpid();
 	skel->bss->nr_cpus = libbpf_num_possible_cpus();
 
-	cpumask_success__load(skel);
-	if (!ASSERT_OK_PTR(skel, "cpumask_success__load"))
+	err = cpumask_success__load(skel);
+	if (!ASSERT_OK(err, "cpumask_success__load"))
 		goto cleanup;
 
 	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
-- 
2.39.1


