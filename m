Return-Path: <bpf+bounces-63668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4C5B0955D
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 22:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B195177C4C
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 20:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98545224AFA;
	Thu, 17 Jul 2025 20:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPIf0N7L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6A22248AE;
	Thu, 17 Jul 2025 20:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752782625; cv=none; b=YdMMn+lpaT+1Lb7WYPGeOYz/z+ZUBhQwShet/DsbEbwdscbS7u6N5M9qH8TBRiRE7b/hnyAXkZuIs003AUsuOCw+YK5QXhBSGt9wauHkhDC01lDkXE7qnazv9ccbNYHTjfy7uy0WgzNVYQpFQpubdC9cBw/Z+lrLmAbQV9HClV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752782625; c=relaxed/simple;
	bh=GbbFf4P++LZ5LAjbxnYkefUt6T1cVX6IVZ1E4kcxEUk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=b4UbhMwzI0L9vLGR3IiRcpM3RwdPFrZm2VUHrHbt22hXvxi+Bn1W1h5JrLquCHHjyC0hPR+EctxB/N56lYuZEYXGb5tAJe1aPEhGtW11Xzb60TgZdffsGBqRrbO1czBRbv5CCf4/A5YPbWx3u7c6/Y6FGCu18HHYlkAPbRtY0oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPIf0N7L; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60707b740a6so1834403a12.0;
        Thu, 17 Jul 2025 13:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752782621; x=1753387421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D+hmUjjtNkvOoCL2FgLUC0+cXPvo2NeWyD5bUF7BZQg=;
        b=PPIf0N7LWUahv5LpPkLLj0aFombmprI/mqIOCmC9dpUfy9Hfvq7Oh0Sig1uW2SKSox
         ksqieb7E5rcgHHqO1hBcIEUMbUvO8wYxDRW0F/rla+Ne6uwb8PltWy44AhwOuhNi+PyJ
         MEGodQR+fD9GQGhMU9FY3Tjn81XuAMLm22q624hODvWORronymZ0z08+WQWdrAJcEfTY
         asgXu4T9nYmu9T0zsMp2Yo4H4sX8tm1aY+tBHPvtXOnriwgrfdU7kU9Q8/JVBVo/6Jky
         +8ywhxDS39FhQ7fkbytKG11BzsYlrClkYUY5oBIqZ/aubKh+ubYspRgB/0lqO5Mf3ihY
         XkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752782621; x=1753387421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+hmUjjtNkvOoCL2FgLUC0+cXPvo2NeWyD5bUF7BZQg=;
        b=N2bibGAgXwYCjVm2DpgCskAhh5w0Z8amS1avJwJPEzUFCQiX735ldnVY/wwRBZJDua
         0IpgMj+A4NVpRaAvHhMcUAQqXG/F0sKD27IsBzDeQqyhTJkgtBH9kn9HCM25ve7Jlxnq
         A0H1Rm23f3Mqu7BOuW0MXnjLOh4e6S7yfo3uWBhWON3jJ9o51fe1nRQ6VFyziqhaVDhq
         cGN6X3uoMCDg44VTf9EpoIH8X6pYXxaqi3zfz/Z5EJGO2y7cDk939G+sNsn/Wh3DkLy/
         VP1tHYAbMQd6k0T8Xw5qrCClx30fQStzoIVB2MhVtA1k3Gp+6lfN8aMnqYu362K0vqCO
         3Dqw==
X-Gm-Message-State: AOJu0YzfYABO0NtEYMDXA6vhEl2ta+3TzrRa2iYJOm2Dor2TJlP+aCqM
	l34yav/Tp5a2JKqSewpvEs3q88zKCGqdlJ+lZ5jZaCvP3gO9tKYC2YDaF34VsE11
X-Gm-Gg: ASbGnctCzkE0pvk9I7hYnpW2x2A2yuep1Gq87zHBp54rmNwO3cPjqPEAp+VvUogL10F
	KSxgU4k22QtZgh/gRN88wykKxeZ5vTf90kvrNnJRmj58USd04y5XE+YfOiENrJ2eBsOTRAIwL26
	ZC3ytetOKece9bhI6U4HLT0+1AT9xPs6pfzlfDoTR2s/8nl1/60g9kJ1kVeyE2Rg9KnXHNwdBK8
	BEpAqQWkpMDinECCcFVcVZjTQS/VoaPczEpsLukdry3EaEU0JksBWjSUH2g6unqcZuj3UM+rxqb
	J3GzTDfai+f8nwo29o1z6dHru2nuY1JdSCDc4EKip9yvE+2lUN4tTSPnqMJ+DaklYUPxS9qfpOB
	Nv8wdBNGuoc96jTrUjgT+VCRHrMAPHOkJh1+8Uxeo03XIFkrfYqg=
X-Google-Smtp-Source: AGHT+IFyEmm2ugMzQsrPl2HoBwGozdL2mymVQxFdeNTG/awzFM0Fa477DdUaSmlW7blFO9JtbqHYYA==
X-Received: by 2002:aa7:c583:0:b0:604:e6fb:e2e1 with SMTP id 4fb4d7f45d1cf-61285e05ccemr6532963a12.33.1752782620526;
        Thu, 17 Jul 2025 13:03:40 -0700 (PDT)
Received: from teknoraver-mbp.local.lan ([151.26.31.229])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c9542fe5sm10336821a12.35.2025.07.17.13.03.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Jul 2025 13:03:40 -0700 (PDT)
From: Matteo Croce <technoboy85@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Matteo Croce <teknoraver@meta.com>
Subject: [PATCH bpf-next] libbpf: fix warning
Date: Thu, 17 Jul 2025 22:03:37 +0200
Message-Id: <20250717200337.49168-1-technoboy85@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Matteo Croce <teknoraver@meta.com>

When compiling libbpf with some compilers, this warning is triggered:

libbpf.c: In function ‘bpf_object__gen_loader’:
libbpf.c:9209:28: error: ‘calloc’ sizes specified with ‘sizeof’ in the earlier argument and not in the later argument [-Werror=calloc-transposed-args]
 9209 |         gen = calloc(sizeof(*gen), 1);
      |                            ^
libbpf.c:9209:28: note: earlier argument should specify number of elements, later size of each element

Fix this by inverting the calloc() arguments.

Signed-off-by: Matteo Croce <teknoraver@meta.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index aee36402f0a3..af85989ae2c9 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9210,7 +9210,7 @@ int bpf_object__gen_loader(struct bpf_object *obj, struct gen_loader_opts *opts)
 		return libbpf_err(-EFAULT);
 	if (!OPTS_VALID(opts, gen_loader_opts))
 		return libbpf_err(-EINVAL);
-	gen = calloc(sizeof(*gen), 1);
+	gen = calloc(1, sizeof(*gen));
 	if (!gen)
 		return libbpf_err(-ENOMEM);
 	gen->opts = opts;
-- 
2.39.5 (Apple Git-154)


