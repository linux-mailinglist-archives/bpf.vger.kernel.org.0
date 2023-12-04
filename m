Return-Path: <bpf+bounces-16629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DBB803F1A
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 21:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40FC8B20B13
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 20:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8E633CF8;
	Mon,  4 Dec 2023 20:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="k1eHOOIj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1E9101
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 12:14:25 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-58d08497aa1so3571908eaf.0
        for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 12:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1701720865; x=1702325665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6c7W+Z0n44cx31K9z6TknZvQ8WpPWuGgMuK2rK3kYgI=;
        b=k1eHOOIjZWC+jz6H4eR7N1oP4jhctprLaO+KIUwjlmlkiW7c0V7YZ6v+8vvTxr2EwE
         rxcZCCbSwXtjG4jfE8Uf2CnCgieuULs0EO3NpvVuk6txOJKidgJqbk7lFfKOWC9dDdQ9
         k09hV2lQyDPTzDKG7iVSEwTpNbHVIDtV09U6BfIszxtybx+fhNiL7IjWoQSDDFkA1/pW
         IiabBMclV/iwW41PR9S8vz1KyzXgCZlyaAPHnK0d846aoMlVFhgV7pOT/9tB3UEJRpb7
         ItOl2w5LmspBJc/rKJbsrh+dD90S9LeYZ5qmRF/i19hGu0uMybS16/wy0Ct5giulVX9Q
         JyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701720865; x=1702325665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6c7W+Z0n44cx31K9z6TknZvQ8WpPWuGgMuK2rK3kYgI=;
        b=F0clv5WIU36amIzKjIdv1YRSqpskaC9SgSOqMXPOuv4rgFOAMy8EwNeucDekZMQUAE
         vo3o7APKf87gl0ibd0pCCt+gJheiYBGzoCwI8GX1NzJxApzrG1B7gqvWuFwnN+yk5n0l
         1+LQ31i5xWrv9pPJ9jD6OTX8Lko/hzUzuj6bGH97GbMPapZBtV9Qqx1zAD62gGv/BHHK
         e6HnxUVz3zy/V9eOxqwD7VHLldXAwW9s1pIlHmOHd23iHE4Trq9zYQrHvIyiLjExP6+l
         2+GLuRxvHk/0cno75qht700quhnmbfgOHUbSbb4ntI/WqKfnaILmsmk0fyvSh5CFFgaq
         W2pA==
X-Gm-Message-State: AOJu0YwfY253h4Ecq/kFkLiplW+brRZ4rqgpdum1NXv9m5QaSkmdvp0z
	hlzbOHXkDum6Vii9T2kh8F2Krg==
X-Google-Smtp-Source: AGHT+IG/K86ebDBCHf8O0u2HkrIeBkifZWBUyzEDU/F2m0TUx1B/C3gGG8NPHiawXlUugm7PuLe5pQ==
X-Received: by 2002:a05:6358:5208:b0:170:40b1:88ac with SMTP id b8-20020a056358520800b0017040b188acmr992899rwa.65.1701720864819;
        Mon, 04 Dec 2023 12:14:24 -0800 (PST)
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id n7-20020a63f807000000b005b529d633b7sm7894060pgh.14.2023.12.04.12.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 12:14:24 -0800 (PST)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: Kyle Huey <khuey@kylehuey.com>,
	linux-kernel@vger.kernel.org
Cc: Robert O'Callahan <robert@ocallahan.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 1/2] perf/bpf: Allow a bpf program to suppress I/O signals.
Date: Mon,  4 Dec 2023 12:14:05 -0800
Message-Id: <20231204201406.341074-2-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204201406.341074-1-khuey@kylehuey.com>
References: <20231204201406.341074-1-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Returning zero from a bpf program attached to a perf event already
suppresses any data output. This allows it to suppress I/O availability
signals too.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
---
 kernel/events/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index b704d83a28b2..34d7b19d45eb 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10417,8 +10417,10 @@ static void bpf_overflow_handler(struct perf_event *event,
 	rcu_read_unlock();
 out:
 	__this_cpu_dec(bpf_prog_active);
-	if (!ret)
+	if (!ret) {
+		event->pending_kill = 0;
 		return;
+	}
 
 	event->orig_overflow_handler(event, data, regs);
 }
-- 
2.34.1


