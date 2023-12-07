Return-Path: <bpf+bounces-17016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A35BE808D7E
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 17:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D7E7282200
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 16:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E3E481A4;
	Thu,  7 Dec 2023 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="VVwDBW55"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75C6BA
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 08:35:14 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1d06d42a58aso9565145ad.0
        for <bpf@vger.kernel.org>; Thu, 07 Dec 2023 08:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1701966914; x=1702571714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWj1IWQKQUAn53hJd+8gzkbOyC7Uc3/+Xnz5vVEOJAM=;
        b=VVwDBW55m0+CDPNtEo5vhp4IUC/kBBuTg9UYkGBv86g2h2uAjCqobJRyhnpOQVvSbG
         qATy2zfqJ6o4+Kkj5+W9rp2Rdv2C7Hsx86tKWmsJTlH3we8umq9P5y+/kqoQn8xTMFSS
         3TSpknLzz1YrQRWyRl7xdHsCusaNWCrP+5IfhGReajs7G54gnc+u+TaBrmUz0vlTH08O
         iUec9Ff9BoKUu3RpIG1XVYA7Fns4e0RAKZB9lk2TWN1yOssf/JchcpWxGguZj1Vo+9Xl
         l1bYLVMtDf5CSkPUtmEsqBWmkLfP47Q6G8AEaXrhQJieSN0+JyOiNTYU5JmQs8r9nBwQ
         ffpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701966914; x=1702571714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWj1IWQKQUAn53hJd+8gzkbOyC7Uc3/+Xnz5vVEOJAM=;
        b=l5w0UK0v0I6vZabUuf4j7kFpLFQjbcIi16DWLxL0HZmTrRpMQsx67xpb360NkVYNIr
         LPGYXTN43nbx5qDgiC3Bc9vRWzO3btDynE7Ebqk2C2e00+GObShOYKLf9/9htlySDgk0
         Tr/M2hPpGKsCzxJriAKA7vN8k4dTRa1T4n4Atz2AFTjkigptEGOYjcS7GuHvvQCVQ+/n
         DYpuffc4FWpDpd5vsfjo6iXGfu4Wh264ylpP/tMdH7YENSMGTbMKa/6mnhwics9tpTc1
         +o/EQFuISjiNKV/HejVMx9UF+VFhOkEH8LqaDVL+43m+x8wi/og7ed5yC/Q78QETun6R
         Ge2w==
X-Gm-Message-State: AOJu0YxE268PCyAPtfA3/uLWrXCwDhwbnamOGHCpgsqkYm08kkeB4k4z
	c9yT/Ao/wvPoD9aSItYbc6FsFw==
X-Google-Smtp-Source: AGHT+IH0TFiITQTxzBEHpxgF8GFh3P2TkSCdMsEPDdMQqCIAwlhGDm2o/wCZc9VUC6HmQ/5p2aYgcw==
X-Received: by 2002:a17:902:b48d:b0:1d0:6ffd:e2ef with SMTP id y13-20020a170902b48d00b001d06ffde2efmr2666645plr.137.1701966914046;
        Thu, 07 Dec 2023 08:35:14 -0800 (PST)
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id iw15-20020a170903044f00b001d1cd7e4acfsm6143plb.201.2023.12.07.08.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 08:35:13 -0800 (PST)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: Kyle Huey <khuey@kylehuey.com>,
	linux-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Marco Elver <elver@google.com>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Robert O'Callahan <robert@ocallahan.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 2/3] perf/bpf: Allow a bpf program to suppress all sample side effects.
Date: Thu,  7 Dec 2023 08:34:57 -0800
Message-Id: <20231207163458.5554-3-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207163458.5554-1-khuey@kylehuey.com>
References: <20231207163458.5554-1-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Returning zero from a bpf program attached to a perf event already
suppresses any data output. By clearing pending_kill, returning zero from a
bpf program will effectively pretend the sample never happened for all
userspace purposes.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
---
 kernel/events/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 19fddfc27a4a..6cda05a4969d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10421,8 +10421,10 @@ static void bpf_overflow_handler(struct perf_event *event,
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


