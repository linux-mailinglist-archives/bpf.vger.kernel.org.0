Return-Path: <bpf+bounces-19895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAD5832935
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 12:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB6B284F04
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 11:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAC84EB4F;
	Fri, 19 Jan 2024 11:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2LbtVYz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936EE3C464;
	Fri, 19 Jan 2024 11:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705665117; cv=none; b=TIjFtFTnQGVVQvLpxMJCD6YX2lkAtgFl8AVugsBYkq+tHqtDJhI1SwmyVzKmnOXjQLC8F12PPtQzXn96JevBvvpi+dk5A1WdDnuV57dR3JA/6sv0WcVBvPZur0IAWW3lPwgxxpr4NvxQn/AX0cIwPQjLKp3IsXHSe0illv2GU00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705665117; c=relaxed/simple;
	bh=MoJtODAqN8sJeJKdztDG/Icxh9k12Zvo9ZAZFr4LcM0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnLAG9cytEvov0u2LggIS4yLZvCg8Nwcs6iN/0D5dxhQhFhLjLQ4MCO6Y9340rxcj0/2MqM/d/eQwWpTLrS5vZjioCPFSJ8+tF4V2hjC555okn4hmMCLGmzi126kSnu9umXQ12kf+RJfCw4vo4GNszUAy0fRJ0IyiomAFL4ogdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2LbtVYz; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2cad931c50so76767066b.1;
        Fri, 19 Jan 2024 03:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705665114; x=1706269914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N+nGApR6ELoiL3OMjOtT0HdX+6Irdf82XlAS5k3TAgc=;
        b=a2LbtVYzlo/G8CuLOxD3WB36rQZBv5rT/TKRkYE6TjTq199wxR0qBMX0sh4TnbUvrN
         P37EJ5IPQOTl0U+NNFskdwCNmew5kuiKmsBFiLjoltpeRjrkRLnhxZluvxIFhY8IxUXC
         6qXLuAdGKtLG6VdSl02aPhHrodyCRRB/NqmqFhOW1X0umn3JjWJcsrmzbaEGcZD9eLZg
         FPGYwmMaox943G56kiwXSb3FAkfXx3hRAOM89UnKOxsAOc1W3DtDPL/BJKwPC4XwLGyv
         ibk5z665NJNkr7FQtRmqoQ3u/TMf3Ba6n0bim+6NP+r23iimlUSNZOVXGI0PJfAN/D4B
         lz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705665114; x=1706269914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+nGApR6ELoiL3OMjOtT0HdX+6Irdf82XlAS5k3TAgc=;
        b=rlodyU5ZRCuS093+PbVss1hlt3LCpMNGMt+rQfUdw35gP3gAA1nE/ozGuV0qA3CmgX
         Tkdx4aX4JfeqvuufpJT2LCq+6aZhX6UijOCDa1lQvUNhuNKFooPzmi7iA8QGIQ9Zib+1
         /Kadso2m5PQpzYRxHK9bSkTK092NJEuT5sXAXgymPJcGXQ/UDcQY740nQNF4KKgj0fzL
         fxM7N4WI3p9pH2l7vEywvRYSSVuUldMPk6penP87dky4/cRpsR+U5i4ZVHX7IGsKvmBZ
         6BFf63LknXAwnOj4KB/VqZlinFDzn+clzDx66Y87IjKQuJp6SUO3LeSubB9Q3tz0kRdH
         c6SQ==
X-Gm-Message-State: AOJu0Yzu4qCMb+yZlpmWFuh+DQPcP4JV8ESGQF4gnZCkHFC5Z2b+n7pf
	yMI5BSOgQf8puHQqW1m2b6+N70MRH9ikmb9kTsXLrxPKPqRBrfim
X-Google-Smtp-Source: AGHT+IGEV/miycfbkg+BQ7i7fKCuISgbybbjg7HntzF1OrJafyBPtbCPRQOQOnDplN3zrLVJ/ZrAYw==
X-Received: by 2002:a17:906:aeda:b0:a2e:8ab5:7ef with SMTP id me26-20020a170906aeda00b00a2e8ab507efmr1191387ejb.54.1705665113453;
        Fri, 19 Jan 2024 03:51:53 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709061c5200b00a2ed534f21esm3085786ejg.63.2024.01.19.03.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 03:51:53 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 19 Jan 2024 12:51:51 +0100
To: Kyle Huey <me@kylehuey.com>
Cc: Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>,
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
	Robert O'Callahan <robert@ocallahan.org>, bpf@vger.kernel.org
Subject: Re: [PATCH v4 0/4] Combine perf and bpf for fast eval of hw
 breakpoint conditions
Message-ID: <ZapiV-DqX_1tU8ii@krava>
References: <20240119001352.9396-1-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119001352.9396-1-khuey@kylehuey.com>

On Thu, Jan 18, 2024 at 04:13:47PM -0800, Kyle Huey wrote:
> rr, a userspace record and replay debugger[0], replays asynchronous events
> such as signals and context switches by essentially[1] setting a breakpoint
> at the address where the asynchronous event was delivered during recording
> with a condition that the program state matches the state when the event
> was delivered.
> 
> Currently, rr uses software breakpoints that trap (via ptrace) to the
> supervisor, and evaluates the condition from the supervisor. If the
> asynchronous event is delivered in a tight loop (thus requiring the
> breakpoint condition to be repeatedly evaluated) the overhead can be
> immense. A patch to rr that uses hardware breakpoints via perf events with
> an attached BPF program to reject breakpoint hits where the condition is
> not satisfied reduces rr's replay overhead by 94% on a pathological (but a
> real customer-provided, not contrived) rr trace.
> 
> The only obstacle to this approach is that while the kernel allows a BPF
> program to suppress sample output when a perf event overflows it does not
> suppress signalling the perf event fd or sending the perf event's SIGTRAP.
> This patch set redesigns __perf_overflow_handler() and
> bpf_overflow_handler() so that the former invokes the latter directly when
> appropriate rather than through the generic overflow handler machinery,
> passes the return code of the BPF program back to __perf_overflow_handler()
> to allow it to decide whether to execute the regular overflow handler,
> reorders bpf_overflow_handler() and the side effects of perf event
> overflow, changes __perf_overflow_handler() to suppress those side effects
> if the BPF program returns zero, and adds a selftest.
> 
> The previous version of this patchset can be found at
> https://lore.kernel.org/linux-kernel/20231211045543.31741-1-khuey@kylehuey.com/
> 
> Changes since v3:
> 
> Patches 1, 2, 3 added various Acked-by.
> 
> Patch 4 addresses Song's review comments by dropping signals_expected and the
> corresponding ASSERT_OKs, handling errors from signal(), and fixing multiline
> comment formatting.

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> v2 of this patchset can be found at
> https://lore.kernel.org/linux-kernel/20231207163458.5554-1-khuey@kylehuey.com/
> 
> Changes since v2:
> 
> Patches 1 and 2 were added from a suggestion by Namhyung Kim to refactor
> this code to implement this feature in a cleaner way. Patch 2 is separated
> for the benefit of the ARM arch maintainers.
> 
> Patch 3 conceptually supercedes v2's patches 1 and 2, now with a cleaner
> implementation thanks to the earlier refactoring.
> 
> Patch 4 is v2's patch 3, and addresses review comments about C++ style
> comments, getting a TRAP_PERF definition into the test, and unnecessary
> NULL checks.
> 
> [0] https://rr-project.org/
> [1] Various optimizations exist to skip as much as execution as possible
> before setting a breakpoint, and to determine a set of program state that
> is practical to check and verify.
> 
> 

