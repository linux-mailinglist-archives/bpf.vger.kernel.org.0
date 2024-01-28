Return-Path: <bpf+bounces-20509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A5183F442
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 06:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6428728420E
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 05:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0894279F2;
	Sun, 28 Jan 2024 05:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iS7lodvy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE512D51A
	for <bpf@vger.kernel.org>; Sun, 28 Jan 2024 05:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706421270; cv=none; b=bDB/hK3aB50k05FdRfb8gaDkLaaug312ko9KDjsZ1Wd3yZQm95blY2T2/CuKmKghzUQiOA/X5xeYfOo6LscjA3i7Tt2U1YRSdqYQtJ9NnlUtklTcQa2WbcT48uZcQaeu5lIP+o1NENrABW7aahB9vtCxPb50S11rLhvSYj9EcIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706421270; c=relaxed/simple;
	bh=T4a0KkJe3ySw24IAuPysHE97+mezCU60c6pezH3/Qas=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=haYRzt1WVQsgYIjRDFT4hDvxttP79HsI9uQ/2y8ZqMCe1jlWjS8V7UHtkdQQHhbicT+OBbsWp+gIC6Hk1lNlfSqGGqmZn/we7F0uVjKoDgSA4gXfh2QdAppS/8dbtG1lAE8qtyXWSMN6sLZM62hhDQJQQxHgAYj5sx2DAVqR8Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iS7lodvy; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59a31c14100so253207eaf.0
        for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 21:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706421267; x=1707026067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WoMzznv9gs9CVHyNB3sDyYu8pYaEpVdO9qAfTUaEKLQ=;
        b=iS7lodvy3t5Qh83KiRk2C+o90nyiiD0XPE5FagdFsePnYmypF8cHdcz+A7XGNhY9pm
         sDgYBhHQWahhjYmFeqEbEP4QlxQHt9ybJLUg9SDViqmr8i04OW4bHQdi6Svq9EmWpDlt
         396GCnd+fXSIvgzJxAf4pAwwaqYgR8LgBtE9YDV6GyscBD/qbBhJlLKSG1VW6wM8tT4w
         qhbUOfixZs1o1DsfW2vKsbv8FOQqbqimFBEhDIuZNnuAoqnbstoElakQM4RbfTXTiG71
         n4P2xsDZJTVQswtj/gs44tYoO8wIY9zSGX9KJOHInPUJIgHjqAyUaFWtC8MpY4EW65EK
         Of7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706421267; x=1707026067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WoMzznv9gs9CVHyNB3sDyYu8pYaEpVdO9qAfTUaEKLQ=;
        b=dB7oLftHii6rfDu3L7hYnfXzvrLr35uWBuEYmH4LXSjB9MV0/F+t/ayK2z79Ase3Yd
         b118UfyAHJOKPpcdCRxVsZZmHO5WRGQ4dhrqKI+y/XEmN0RQa2vdK/gbtNvs2AilhpDX
         epvWtiz8p/jmvKnYDW68ZgZAqswnAs4T5UQ04LDOcA1t7j/lcYdKHTW30Tc6Nqn7wbnr
         a6iyQsGDeXzl69SL0ICPC2J83RlhP8T+RmVweB/sS65InaYa5zZFDibjh4MjjlAnxsKu
         B7GiTinenHofBMLFIeBH/UYduyIxxIsRWkyPzy8JFUT0fQQgyPGj6N14Qo77t95TVpfV
         cnQQ==
X-Gm-Message-State: AOJu0YxkOzfbwImLwJiwawy8Wd+8BfRNna8AM5r1nYfsgednT8ybGCTN
	bTlpWFHblMPPNAmuSnYXjUJQ76o1KFW0KT/54IsXJXbZzJNMo2GSlXR3dzWagTo=
X-Google-Smtp-Source: AGHT+IF3BhZQ0kd9MaydOR06jsyngD/uQTkBOXKbnxIlTgDR5uNidOeNUBMOv+APKTb+c7/0nhvxaw==
X-Received: by 2002:a05:6358:2489:b0:176:a102:568e with SMTP id m9-20020a056358248900b00176a102568emr3049490rwc.5.1706421266793;
        Sat, 27 Jan 2024 21:54:26 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090ac88c00b0029272682390sm3757020pjt.27.2024.01.27.21.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 21:54:26 -0800 (PST)
From: Menglong Dong <dongmenglong.8@bytedance.com>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Menglong Dong <dongmenglong.8@bytedance.com>
Subject: [PATCH bpf-next] bpf: remove unused field "mod" in struct bpf_trampoline
Date: Sun, 28 Jan 2024 13:54:43 +0800
Message-Id: <20240128055443.413291-1-dongmenglong.8@bytedance.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems that the field "mod" in struct bpf_trampoline is not used
anywhere after the commit 31bf1dbccfb0 ("bpf: Fix attaching
fentry/fexit/fmod_ret/lsm to modules"). So we can just remove it now.

Signed-off-by: Menglong Dong <dongmenglong.8@bytedance.com>
---
 include/linux/bpf.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b86bd15a051d..1ebbee1d648e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1189,7 +1189,6 @@ struct bpf_trampoline {
 	int progs_cnt[BPF_TRAMP_MAX];
 	/* Executable image of trampoline */
 	struct bpf_tramp_image *cur_image;
-	struct module *mod;
 };
 
 struct bpf_attach_target_info {
-- 
2.39.2


