Return-Path: <bpf+bounces-17365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B25B80C07B
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 05:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CCD91C20926
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 04:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31C61C291;
	Mon, 11 Dec 2023 04:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="WMINwjEM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEEDF1
	for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 20:55:52 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d0538d9bbcso37647865ad.3
        for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 20:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1702270552; x=1702875352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kl4wg1J09lcPpRVdW57uX8PEQktJgyhY3gmEO1BemVo=;
        b=WMINwjEMdz0YJ33dmHAasIetA4dQ6Sfv4GedYvAQuYZ4bHmIpXPd9RfYAQ4E038vfX
         dYvpYHo4ffq3EXnE3efJoyPuwmPTWIMVoxtfbBfQTegnTEwmQJFaOlHjpVE+iol9CLIm
         x9nbhvd4k9sRhSE+XWflcNdVS4etWxzyUb3EWM66AS3CXOnrOgtR5womrJHDqUsonu+m
         qnOYzIyV/Meqp+mIWA0exXyR7Rs+cpGcoa79ENUGK8q8JoK+OCIisi1y/EJzcIVwP+Vh
         N7q2Y/68VMWov5QPE64Xt061N+u7xU7n4CjhmHpFSrVtjd3wvnM3wGYnziLKr4j9ZfRi
         /qjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702270552; x=1702875352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kl4wg1J09lcPpRVdW57uX8PEQktJgyhY3gmEO1BemVo=;
        b=hGRbcyg+tZxtBrGWzYfG5uuifVve+tNv5W85gxZxygJ3T5pIH8dilcYhnygHjNgUTP
         +MKgoi7VemWSB7zdEKnXeM9cnACQbSd40QSOPVO3z7WJx8EgJeDkIqyc60oemdl2dR0t
         C57nrAWRacEbRxKrfJj+Co4tNbLuAKSGkTwnvMoQy2rqaZhkwmHBo/gFD56QAjU+K6S9
         HZ0ihtO4HE9E9thaby589Zh8wUi9fCuAp3BkAh1Pv1SpLn9uR1f7lX45i0ZV2YbtQEE7
         2ujOg4W+59CFpesxBcWZPNEdtz1Jsva/NUIj+rtL0lh2vCjtGrlGcmwuj7zjHqyXXJcr
         oCFQ==
X-Gm-Message-State: AOJu0YxGCbOFohhMBiWniG0/pDF2noTatGS+TI4Jt7qIpABcy+kJawEo
	hrUfaJhQFWpEQfP9v5AKMLZ3wg==
X-Google-Smtp-Source: AGHT+IHuWkmPjE12XCHEO61i5/dytoy32ww7FGStSF9nnNLWWezXsnMaj6wFfeKpkqjVRMXmfnyeqg==
X-Received: by 2002:a17:903:2303:b0:1d0:6ffd:e2c5 with SMTP id d3-20020a170903230300b001d06ffde2c5mr5310259plh.95.1702270552180;
        Sun, 10 Dec 2023 20:55:52 -0800 (PST)
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902b78b00b001d2ffeac9d3sm3300623pls.186.2023.12.10.20.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 20:55:51 -0800 (PST)
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
	bpf@vger.kernel.org
Subject: [PATCH v3 0/4] Combine perf and bpf for fast eval of hw breakpoint conditions
Date: Sun, 10 Dec 2023 20:55:39 -0800
Message-Id: <20231211045543.31741-1-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rr, a userspace record and replay debugger[0], replays asynchronous events
such as signals and context switches by essentially[1] setting a breakpoint
at the address where the asynchronous event was delivered during recording
with a condition that the program state matches the state when the event
was delivered.

Currently, rr uses software breakpoints that trap (via ptrace) to the
supervisor, and evaluates the condition from the supervisor. If the
asynchronous event is delivered in a tight loop (thus requiring the
breakpoint condition to be repeatedly evaluated) the overhead can be
immense. A patch to rr that uses hardware breakpoints via perf events with
an attached BPF program to reject breakpoint hits where the condition is
not satisfied reduces rr's replay overhead by 94% on a pathological (but a
real customer-provided, not contrived) rr trace.

The only obstacle to this approach is that while the kernel allows a BPF
program to suppress sample output when a perf event overflows it does not
suppress signalling the perf event fd or sending the perf event's SIGTRAP.
This patch set redesigns __perf_overflow_handler() and
bpf_overflow_handler() so that the former invokes the latter directly when
appropriate rather than through the generic overflow handler machinery,
passes the return code of the BPF program back to __perf_overflow_handler()
to allow it to decide whether to execute the regular overflow handler,
reorders bpf_overflow_handler() and the side effects of perf event
overflow, changes __perf_overflow_handler() to suppress those side effects
if the BPF program returns zero, and adds a selftest.

The previous version of this patchset can be found at
https://lore.kernel.org/linux-kernel/20231207163458.5554-1-khuey@kylehuey.com/

Changes since v2:

Patches 1 and 2 were added from a suggestion by Namhyung Kim to refactor
this code to implement this feature in a cleaner way. Patch 2 is separated
for the benefit of the ARM arch maintainers.

Patch 3 conceptually supercedes v2's patches 1 and 2, now with a cleaner
implementation thanks to the earlier refactoring.

Patch 4 is v2's patch 3, and addresses review comments about C++ style
comments, getting a TRAP_PERF definition into the test, and unnecessary
NULL checks.

[0] https://rr-project.org/
[1] Various optimizations exist to skip as much as execution as possible
before setting a breakpoint, and to determine a set of program state that
is practical to check and verify.



