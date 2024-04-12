Return-Path: <bpf+bounces-26616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5DA8A2B9D
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 11:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93FF71F2301F
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 09:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DD752F92;
	Fri, 12 Apr 2024 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwbru7gt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F4F535DC;
	Fri, 12 Apr 2024 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712915707; cv=none; b=eWsJC28D7UQWWfYHoEO5G5uqgRwKoSvB2ckpGj/sVQGWW/odaZgrzevUcuEJtsaXpq5AjIsmSxd7hdHAg7Yuen3o0He7VOYGfJQlXKkC/JVJeUgaEohVbN+wDkBgNKmaZY0wPYovuoTcPNS0pWVvW/WnJ1Jn+L8Z58B6wWx+ae4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712915707; c=relaxed/simple;
	bh=MxCP72ppniCUwq/Q6jnueZ8iwN0KI8bkGQ/p/fDaVws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpGcBHQi5ktkW4nixlDJZweHMU4fAHWW0Scd/uxi5vrpM1+pnKURbhplyNGVJJnSKS5JokB5BLLPdr8EiuvvvvrB5CMufsJv3uYAthqS/YUCiOfAgn1fAYNWpEKSgL/J2EV8BmnTrJqIkSl2yaMC9twXF3w/VFlm7NqXDRKZM9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwbru7gt; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e37503115so576130a12.1;
        Fri, 12 Apr 2024 02:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712915703; x=1713520503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V6GO2vbzaTzYvoUcV4Qpl0H9TBLeVNlexEEn9hFraCw=;
        b=fwbru7gta6k+X/lIIpKhMDd/u6Zv8CZvGwN5LJNPAC06+hptYFIlEFC4L1h+J/UfdZ
         vhFI6+9KeYaqkzYOHw7wssdjab7soF/YQ7eDbKp4E8E5fGavwF3SQoJyS5GjFm3gWy1Q
         i3OhcPx80GE50AgVO9eN5KexPyJD9hF6CzISQ9mOuWA5QvzcWtAKGKYMs7WWY+H9T9Nm
         DZhHJjDzwByG9Mqnw/apngWRUTrHuaXLLjNHXOMTKJ0G0zHb0V7DYbZ6lshU1F37P2DC
         jVwnPkWna/rrVAkjqAiwD7o9KHjeu7jBbQd1fzPBMv2RK1RYNEDUkoUuomejz/H1od1i
         f5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712915703; x=1713520503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6GO2vbzaTzYvoUcV4Qpl0H9TBLeVNlexEEn9hFraCw=;
        b=NPaVglt3ch5vBMzYIMgpoFr541v1+ZaT9oE0sitIbAMIoMdq2n0ewH+v4hmP0zWI5+
         NaOXPAWbWfhgYagnLhNLbPGM9zupYR2oHPgMgkJVyBN/9ZqdUJ3tbCWYXbciugDKaSyG
         kWxK+81PQhOh0QDl/t6HBriOLpAsl0FUAWIWN0xWYCPT4FVwafOR4MwLZ7Qz/mfQmuRN
         YGeNeJXahHtr3H/vDMHSOxu/mfzRQNE31wMfjEO0zKkBss/mJBi+L4dXiJtqdUeu8pyM
         YNHoUqmXQWCNzlaLvv+WaLNGDjzmEToGOYY2oYyGSUyfG4KsAuA/mVGolRGQ5fM+gJul
         o41g==
X-Forwarded-Encrypted: i=1; AJvYcCX5ia0WQ0t/rew5N7BaIoYMvwzEi4wN+9/HtKXzQ15X1TVYLIOp0WSYuDb7tmq5nfLVfQDy3qfFb9dEn/F+21WYKP+YN0gFVXaYvXfkGEGsy+eReRB9H21wMswOHN18YynX
X-Gm-Message-State: AOJu0YzJ4ZlZhqte869J0lZL7j11Io2cJ4MzpG/E9DQREcGTdCM6GjyH
	bLtcKw2fek1HQ+PKGxMN/BQOpp/U/MJHMV6gN9v3Q5D5n9afGD4S
X-Google-Smtp-Source: AGHT+IGnk62JGdMQa/B7hDMdZpD/yfiPhQr3f+cJw9cDK3woWaOPl9ouq7KgndTx/SGys6Fc5mFNZw==
X-Received: by 2002:a50:aa9c:0:b0:56e:2ff3:bb89 with SMTP id q28-20020a50aa9c000000b0056e2ff3bb89mr1383824edc.28.1712915703327;
        Fri, 12 Apr 2024 02:55:03 -0700 (PDT)
Received: from gmail.com (1F2EF1A5.nat.pool.telekom.hu. [31.46.241.165])
        by smtp.gmail.com with ESMTPSA id 14-20020a0564021f4e00b0056e78dbfe13sm44670edz.32.2024.04.12.02.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 02:55:02 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 12 Apr 2024 11:55:00 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Kyle Huey <me@kylehuey.com>
Cc: Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Marco Elver <elver@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Robert O'Callahan <robert@ocallahan.org>, bpf@vger.kernel.org
Subject: [PATCH 8/7] perf/bpf: Change the !CONFIG_BPF_SYSCALL stubs to static
 inlines
Message-ID: <ZhkE9F4dyfR2dH2D@gmail.com>
References: <20240412015019.7060-1-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412015019.7060-1-khuey@kylehuey.com>

Otherwise the compiler will be unhappy if they go unused,
which they do on allnoconfigs.

Cc: Kyle Huey <khuey@kylehuey.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2212670cbe9b..6708c1121b9f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9638,21 +9638,21 @@ static void perf_event_free_bpf_handler(struct perf_event *event)
 	bpf_prog_put(prog);
 }
 #else
-static int bpf_overflow_handler(struct perf_event *event,
-				struct perf_sample_data *data,
-				struct pt_regs *regs)
+static inline int bpf_overflow_handler(struct perf_event *event,
+				       struct perf_sample_data *data,
+				       struct pt_regs *regs)
 {
 	return 1;
 }
 
-static int perf_event_set_bpf_handler(struct perf_event *event,
-				      struct bpf_prog *prog,
-				      u64 bpf_cookie)
+static inline int perf_event_set_bpf_handler(struct perf_event *event,
+					     struct bpf_prog *prog,
+					     u64 bpf_cookie)
 {
 	return -EOPNOTSUPP;
 }
 
-static void perf_event_free_bpf_handler(struct perf_event *event)
+static inline void perf_event_free_bpf_handler(struct perf_event *event)
 {
 }
 #endif

