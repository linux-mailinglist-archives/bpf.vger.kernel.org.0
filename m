Return-Path: <bpf+bounces-26360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9A089E907
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 06:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A891F22F01
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 04:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B344C8E2;
	Wed, 10 Apr 2024 04:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQ+WTVxy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FBE8F44;
	Wed, 10 Apr 2024 04:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712723882; cv=none; b=P1b7j84Xdjy8yZ7nFEYrP4ghSl1w4xYHXsaFpsavh2D2dvegW0OG4HtFrYZwGNPxPaT2OFiYb/VO9L/GEGnNg67/4lNMNJzfkamog6Vqq0cuy3Lmfzir7y/ZQ8eTEAJVU4EufiLjMammpamyTe2jyoZEnH+pAPj5w2IGVQtpqyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712723882; c=relaxed/simple;
	bh=J0UScVBRlk/e4+RNWwr7TLOzzdH0Oc58gx0hIRgRxcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lf1a+najN5JheTM/NvFVnto2PrHlKlO3euJkevZDkqkmGHLFrfqBclZZ+v8OfdHMvpS5PmT26nq8epos1D4ok0Ge83rh3cAO0RD/uutsRPmxd+/kJOaB6ia6Njsumn4DX3ssdg1PyVZHsIfwKGuIB2EX0cKsgubgNqDxCgEgBjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQ+WTVxy; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a51a1c8d931so589131766b.0;
        Tue, 09 Apr 2024 21:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712723879; x=1713328679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jm0JxZnb/pakogDNODxljR3KWZzk+j8pV3D1TFW1krA=;
        b=VQ+WTVxy1DEO+/g5LWVJNBDTygUz+E8MUdgKM1DXozCUz7RJOAaFRwV/N8Mqcmq1g4
         HilDyRVrIR/ADsD2kae73N8b1TwPkAJNxUGjzerXhpx9uqQ6qsIVHglarFKMQoEAvvlC
         1zjrH9AVsOva5JwDnTc1OhY8MKVX35ulEWxFLmtBw62rXR3GGgP7qQSGmwPFduwcmWSs
         LxRAo6Gfi1xvZiFafc1Vx3q+cmA4jOs3HJkXw/NeWaF6y/CtB1T8YmF4qQYqwwP20NI6
         SwJsJey0Gf64rJzQYaBSCgUM9vfoh/zLv9h0dB8apl6mYdezd2jEczmKJjV1C72Lm36O
         ZHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712723879; x=1713328679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jm0JxZnb/pakogDNODxljR3KWZzk+j8pV3D1TFW1krA=;
        b=HgF2eKJFY8XCyIkYamRh+ZRFw1/EbjGNQY8ygLc19zeadCYoRSoUvbvMSxen52BV2l
         D+RoX7/p+NvapfGnfXRmRdU6fUcjIV7W1HmagnHWfLPabH0UvbKDFzev9RCb4MHWrv32
         SLPpzI6uL7k3VrwyELioxmuCODzUlzDLe+Vag8/w4YW/BtMbDtIkgryzTsBXiZkIfpfF
         qHNIkJk99fkT/BawARHY1AZgopx7eHAE3WgO2Jx22fqXI/uBFXM/oujIWmKj1wpfmM/q
         ftejrskdUTmBXeefWknC01ee6E3xUFAqtR+Dw+TWJhbQJbCQnF50lyty8Rz4yvCocr3Z
         tzTw==
X-Forwarded-Encrypted: i=1; AJvYcCXJdYyxK01LRahv4gsKF0gU29XznacpXpTGFUSS0kRp+0+0hDJ/FLf06WUchL62igHieYynbXTe+dSa8kRNrK6yLUAU6+nCQl7+VeKZszaUozzQihPsleE9xnnyS6dxXg63
X-Gm-Message-State: AOJu0YzpDw9iez5fiLfhb9tzl43HBkVZWotPVppuVWzOJBUzKU1WdIaJ
	vzWKX2Y1KPBcQny/Nvo/hkTUCFX7+wfMv7Gnpg6Xzmx/IRfHfIzK
X-Google-Smtp-Source: AGHT+IGYAgmktYepGxQFDDL7nr0LOPJPRI/X8Uqsna37nY6dc4Lg1uDSowTGfuvpoKIPSN0B7OESAw==
X-Received: by 2002:a17:906:5a95:b0:a51:d2e1:695b with SMTP id l21-20020a1709065a9500b00a51d2e1695bmr817026ejq.49.1712723879020;
        Tue, 09 Apr 2024 21:37:59 -0700 (PDT)
Received: from gmail.com (1F2EF1A5.nat.pool.telekom.hu. [31.46.241.165])
        by smtp.gmail.com with ESMTPSA id dm10-20020a170907948a00b00a3efa4e033asm6463372ejc.151.2024.04.09.21.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 21:37:58 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 10 Apr 2024 06:37:56 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Kyle Huey <me@kylehuey.com>
Cc: Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Marco Elver <elver@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Robert O'Callahan <robert@ocallahan.org>, bpf@vger.kernel.org
Subject: Re: [RESEND PATCH v5 0/4] Combine perf and bpf for fast eval of hw
 breakpoint conditions]
Message-ID: <ZhYXpNu0c/rcjf0r@gmail.com>
References: <20240214173950.18570-1-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214173950.18570-1-khuey@kylehuey.com>


* Kyle Huey <me@kylehuey.com> wrote:

> Peter, Ingo, could you take a look at this?
> 
> ----
> 
> rr, a userspace record and replay debugger[0], replays asynchronous 
> events such as signals and context switches by essentially[1] setting a 
> breakpoint at the address where the asynchronous event was delivered 
> during recording with a condition that the program state matches the 
> state when the event was delivered.
> 
> Currently, rr uses software breakpoints that trap (via ptrace) to the 
> supervisor, and evaluates the condition from the supervisor. If the 
> asynchronous event is delivered in a tight loop (thus requiring the 
> breakpoint condition to be repeatedly evaluated) the overhead can be 
> immense. A patch to rr that uses hardware breakpoints via perf events 
> with an attached BPF program to reject breakpoint hits where the 
> condition is not satisfied reduces rr's replay overhead by 94% on a 
> pathological (but a real customer-provided, not contrived) rr trace.
> 
> The only obstacle to this approach is that while the kernel allows a BPF 
> program to suppress sample output when a perf event overflows it does not 
> suppress signalling the perf event fd or sending the perf event's 
> SIGTRAP. This patch set redesigns __perf_overflow_handler() and 
> bpf_overflow_handler() so that the former invokes the latter directly 
> when appropriate rather than through the generic overflow handler 
> machinery, passes the return code of the BPF program back to 
> __perf_overflow_handler() to allow it to decide whether to execute the 
> regular overflow handler, reorders bpf_overflow_handler() and the side 
> effects of perf event overflow, changes __perf_overflow_handler() to 
> suppress those side effects if the BPF program returns zero, and adds a 
> selftest.

I suppose this optimization makes sense.

Patch quality still needs to be improved though - see my review comments.

Thanks,

	Ingo

