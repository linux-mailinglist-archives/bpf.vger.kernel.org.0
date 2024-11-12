Return-Path: <bpf+bounces-44595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 882469C4F93
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 08:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C4AAB25AF3
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 07:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99F020BB49;
	Tue, 12 Nov 2024 07:37:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from cmccmta3.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5639D20ADED;
	Tue, 12 Nov 2024 07:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731397032; cv=none; b=rqr6HtMiXALLvfqme7SWZzTn9Bdc4ZrfzRBts4UtNJsHZ2aGa1hQNxROlTmLDM+4pOtpcK9I07yf7edi8ZcocUeXFyE990g3h6zwxi4ebOipo4jf/842UdR4ZXT0XKSJi7ck2HgLk2SbcbkLQKvv7ghKSzmyOEozb1iXW6mGkLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731397032; c=relaxed/simple;
	bh=RsvRD2b/+78gwa4Dmk21x5+fQX25aqCJmIaqjGECiSc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j8d35vYx4zJuqqcKJv0+7u0Ytn3bovgCVu/JnuMbd2swOcoEQpFG2+rax7P8KwEi0n/RfQUpQqF8mO6+FfuNl27duUIk4U8n0q3DCZmpCbIboUZo2bKwfDS8wo7VVRWHqvUj82BAeEsrFYJ4SChhKueLqD0N474BFNdDBqweoZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96733059f3b5-133ca;
	Tue, 12 Nov 2024 15:37:04 +0800 (CST)
X-RM-TRANSID:2ee96733059f3b5-133ca
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46733059fb2e-34fce;
	Tue, 12 Nov 2024 15:37:04 +0800 (CST)
X-RM-TRANSID:2ee46733059fb2e-34fce
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: andrii.nakryiko@gmail.com,
	qmo@kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	luoyifan@cmss.chinamobile.com,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH] bpftool: Cast variable `var` to long long
Date: Tue, 12 Nov 2024 15:37:01 +0800
Message-Id: <20241112073701.283362-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <CAEf4BzYgqb=NcSCJiJQEPUPhE02cUZqaFdYc4FJXvQUeXxhHJA@mail.gmail.com>
References: <CAEf4BzYgqb=NcSCJiJQEPUPhE02cUZqaFdYc4FJXvQUeXxhHJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the SIGNED condition is met, the variable `var` should be cast to
`long long` instead of `unsigned long long`.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
---
 tools/bpf/bpftool/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 547c1ccdc..d005e4fd6 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -289,7 +289,7 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
 			} else {
 				if (btf_kflag(t))
 					printf("\n\t'%s' val=%lldLL", name,
-					       (unsigned long long)val);
+					       (long long)val);
 				else
 					printf("\n\t'%s' val=%lluULL", name,
 					       (unsigned long long)val);
-- 
2.27.0




