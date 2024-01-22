Return-Path: <bpf+bounces-19985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D6F835AEF
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 07:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1437BB24F77
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 06:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7266AAB;
	Mon, 22 Jan 2024 06:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="GaKCRbBm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FD063A0
	for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 06:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705904746; cv=none; b=L+Y4FIpZFzmaw5mpiCnEr3e1PDT8TVe/cqOeW7Y304wPgzBZBvzrP46zyy2hysH73zFQyN7SbtvczQ7NyJoIExQtbQdhhZs10XVMdCjn4ZCO+XYsWyBU8bemXND4zcIRDZHZloC9OySoTeK5XlXkPx+x6PL14yRiSfmvtmj4NRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705904746; c=relaxed/simple;
	bh=rgcXrf6x3g0AFfGNeTRNVD9JonbOcksFUg50spIVZ1E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ms4qxHA/X7iaNbombp1LZsfng3mk+j981onGmBrglA6XHlcuJRHrsItBBkf8ZS4KXxUKglrKMh/jLwhcjCxcd4+4rNIUQAGe8y0CiMLDded3lW3mVPN7qNNaxZrVS/A50leAQJTg4yyNDnIQJnVFJvR7rJ7BY9lNaRwPU5bNbVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=GaKCRbBm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d711d7a940so23454715ad.1
        for <bpf@vger.kernel.org>; Sun, 21 Jan 2024 22:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1705904744; x=1706509544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rgcXrf6x3g0AFfGNeTRNVD9JonbOcksFUg50spIVZ1E=;
        b=GaKCRbBmdWASrYHXtHLCoCpAwzCarsvomL64rWU76mmnCJ12npJBMU6BuiD23yhtwj
         7/rJVsGDsxFjgiMHuMDkpQ8g+R4YY0CKLwxZ8O2t/m6aDwBeOiKicusclDLhumopNYhk
         PkmCp2nJUeQ5Mdr5aa20OMdwyKwfWJOUPtMNoEv4gXKi08e7ZYogXyLs4vxZb+Qfjtqb
         /KvpjnBHUgS+ia8N6wYwCRzFKYppyckhofU6LZ9Q9vio3oS1grJeFG98TbjYFlqkJhug
         d1OOBvGFrdt6u9iIadBlWyVuBPqyFH2JmjgxsBWkgBKmiL2nYB6huNL7FcfjSgAYk9Vs
         JP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705904744; x=1706509544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rgcXrf6x3g0AFfGNeTRNVD9JonbOcksFUg50spIVZ1E=;
        b=rHthSBdlYsWeVsSqt+lROjGg1ZiaJgBjN1XGqCWLjky/m9ibx/3K+Fzr/YcXDSj3xB
         Be2diRBsLd0tzQ5fYd365jI2f2x3WdHtsX5zU8Bnk6iK9HNT0S9wh9VOhM55NmfGb5iN
         hWgko6XWXWmWG0PXWhmh8KI0Wmo91u+MhrR3MgGeFqGzOJL9MG+ddMCX75FbfkZH6dvd
         exg18agngX22v+znIr+aHpU/UPH+ppN/egJEw8P4UWAesjHgySBlBe/+xGvmVqi+kt65
         kuKVczdKa1puICeg+TKfvG+UXERhiXtmnuN0czno3zCrEYz1F3enW/RPpvA5t4pAppby
         VVaw==
X-Gm-Message-State: AOJu0YypreJ/He4dw/0DYeBK8wPJBT+IsTUoPyzWYKRsxHV9KsZl+mD9
	+Ou8LruRHZHumvylcLPELKV5eoIdqQzldV41UnGuh6mpYg5twyy8KC2+rHsl2g==
X-Google-Smtp-Source: AGHT+IFUuXuEScIDSh9Tq9jk8/5jxgySvjvuLJrRYEI0gJK1vz8AWdp5b5A93FcLTNQtcaCBy1yI4w==
X-Received: by 2002:a17:902:b088:b0:1d0:c7f:8eed with SMTP id p8-20020a170902b08800b001d00c7f8eedmr3966816plr.58.1705904744001;
        Sun, 21 Jan 2024 22:25:44 -0800 (PST)
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090282c500b001d7248fdc26sm4317771plz.69.2024.01.21.22.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 22:25:43 -0800 (PST)
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
Subject: [PATCH v5 0/4] Combine perf and bpf for fast eval of hw breakpoint conditions
Date: Sun, 21 Jan 2024 22:25:31 -0800
Message-Id: <20240122062535.8265-1-khuey@kylehuey.com>
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
https://lore.kernel.org/linux-kernel/20240119001352.9396-1-khuey@kylehuey.com/

Changes since v4:

Patches 1, 2, 3, 4 added various Acked-by.

Patch 4 addresses additional nits from Song.

v3 of this patchset can be found at
https://lore.kernel.org/linux-kernel/20231211045543.31741-1-khuey@kylehuey.com/

Changes since v3:

Patches 1, 2, 3 added various Acked-by.

Patch 4 addresses Song's review comments by dropping signals_expected and the
corresponding ASSERT_OKs, handling errors from signal(), and fixing multiline
comment formatting.

v2 of this patchset can be found at
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



