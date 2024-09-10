Return-Path: <bpf+bounces-39438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 894D7973824
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 14:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC0F289201
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 12:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C22191F9E;
	Tue, 10 Sep 2024 12:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRMu7Oz2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE7C1EB2F;
	Tue, 10 Sep 2024 12:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725973117; cv=none; b=GvhohFbuVhUVkfNA03EldEuGABw8BYK7yoNTlheupTzuM/UteO7Wway98QlrAw6rEkmgyJplFy1domxJ5kMOkJh09PIBzgX5aoMnbrg21a9FOMrEoyOOhSI4g8ZMLuFO4vqaRZw8M4bdRlT9gsrF4lG4hmfs1wAKNcmt8sgO8PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725973117; c=relaxed/simple;
	bh=5gPskckxp1UZ/XMepxRnnd8/OYzrY0Fe4nPWYZHp+Cc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OHMqRAdc0lFzyN1oxmR2vFaT6yYs+M30WFMciXB0oqRKYSApK7OVwNmpRr/uFBY8md1zFAK2PySI55nKLi1apW9vAXlx3/X+Jh9Yw6h2zwUVYY8X4HLeVo7h2Q1NJHFrsw3G7tcGC2E/CUcB2RBOOpBPE6+fnZ/MyU5XeSOFT6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRMu7Oz2; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d8818337a5so4659085a91.1;
        Tue, 10 Sep 2024 05:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725973116; x=1726577916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xyel3imRxFpwdfOO24O3J/3zDsAOJUckvL1hBK+vtmY=;
        b=XRMu7Oz2EGuyVnuZy5stnnOJ7Cd1NtYdoAcP+3jwOJti2EqxtoDqzm2sX1XQvBKGQy
         fyxXvAV34GIfcWB2DgodUg3BjU0PUBwsE4SJ6uH9PK3RsQDUY8C0BOHXWvNi0Lws4HxD
         lcRv2YXAb1MDjSa2OCLqoct86HWYnaFTh92M++QkuAg5+u9h2RuyCNPhPEUTtH6g7fPC
         J5z3l49rOaKFXOuiKJkx86VHx0uLM2S5tRWS2JXzrbv1NZcOqdrxGlT+1bZU/h5z/0bB
         yt1IPydLGDVsRLnxXILFdb8UGvfsCMZY8erD7hbnXW73ZzKRpqg4hoZViXZoA9HFq5yQ
         G1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725973116; x=1726577916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xyel3imRxFpwdfOO24O3J/3zDsAOJUckvL1hBK+vtmY=;
        b=EwpGUs4+SMFW+dJFKeSD9LZFVX/H9jRvWQawZdXO+DogQeZhBQwhE/vIqIwYbfSdVK
         SNbWoPzUdZmJfyU265YOr/2pCvGmhbIheTuEgf46VdJ/1M7i5qdskjEkh76T5HWpYn1i
         +W8/F/Qv3gqxsEeDUfIakPQodelI/E6qFYzIW64fCYDlMGvIYXmy0sWklHQy9lGa1xeT
         rR4mYFIyaiL+wLfZb+YIS9NnrU3kJqlU7EKKg4PHJ1hzm8MRnRtzjnU5OBkX6OVFe31V
         0ajJukpPswZ1kssg0Yui8WRm0HFvSyJx1Q3jegyeAUAoeyA4SSQblYh9/yOgoE0GVxiI
         H0Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVMl3f3IGAYOGr95o1wOdOYVq3O/YLyxmYIbGRF8y4PHwC/6x5nEUE3VHhVjqZrUj6PW/Um5FzLLTH9moPL@vger.kernel.org, AJvYcCWRnqX28FuSTHT8TQeqkGt2yQV636may/tooyamdP2OqW7GaEO3Oqr5aH2o2KhdoCfRtqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQGm9ZkbirITimQfzeHxzbNepIZG8oMeFry0V3VSgceyQ1tTfF
	oFbwX1lu088NAAAd8NVmIMTH/LTd8Q5hwu0ynGYKBiOTL4Hrre8g
X-Google-Smtp-Source: AGHT+IE7ob/q4REwITMiP9KAyvcXSHODWgpuTUkOwhOiNL+e1rPHjMwDYF+qlOzPcYjq25Bw5ZM+Sg==
X-Received: by 2002:a17:90a:2c4a:b0:2d8:719d:98a2 with SMTP id 98e67ed59e1d1-2db671989damr4480758a91.7.1725973115573;
        Tue, 10 Sep 2024 05:58:35 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db04988470sm6301628a91.54.2024.09.10.05.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 05:58:34 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: qmo@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] bpftool: Fix undefined behavior in qsort(NULL, 0, ...)
Date: Tue, 10 Sep 2024 20:58:26 +0800
Message-Id: <20240910125826.3172950-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When netfilter has no entry to display, qsort is called with
qsort(NULL, 0, ...). This results in undefined behavior, as UBSan
reports:

net.c:827:2: runtime error: null pointer passed as argument 1, which is declared to never be null

Although the C standard does not explicitly state whether calling qsort
with a NULL pointer when the size is 0 constitutes undefined behavior,
Section 7.1.4 of the C standard (Use of library functions) mentions:

"Each of the following statements applies unless explicitly stated
otherwise in the detailed descriptions that follow: If an argument to a
function has an invalid value (such as a value outside the domain of
the function, or a pointer outside the address space of the program, or
a null pointer, or a pointer to non-modifiable storage when the
corresponding parameter is not const-qualified) or a type (after
promotion) not expected by a function with variable number of
arguments, the behavior is undefined."

To avoid this, add an early return when nf_link_count is 0 to prevent
calling qsort with a NULL pointer.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 tools/bpf/bpftool/net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index 968714b4c3d4..13e098fa295a 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -824,6 +824,9 @@ static void show_link_netfilter(void)
 		nf_link_count++;
 	}
 
+	if (!nf_link_count)
+		return;
+
 	qsort(nf_link_info, nf_link_count, sizeof(*nf_link_info), netfilter_link_compar);
 
 	for (id = 0; id < nf_link_count; id++) {
-- 
2.34.1


