Return-Path: <bpf+bounces-19857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A5A832286
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 01:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A58BEB22F83
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 00:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC4081E;
	Fri, 19 Jan 2024 00:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="h1YdhG/u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5817F7
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 00:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705623252; cv=none; b=P4h9u1Ale/XQCiqXFxNBPLwNjgZ0jNwwbt/kU5Ood6acBLe3E8QvwhG/Xg329gUk8rQQSIv2aEewFigUlVXRDsGPegmqSa/Qg66jzH9eue4BrEE9m6ZVcVCjor+GQrVmNILCNoRR6wWYLImONVNHfwdR8l8m+F8hPveZIajd0AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705623252; c=relaxed/simple;
	bh=vylMAwKjOKQHziaAu87Qiy3rOLrs3/9n8l6rCdO/DPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fxALXxL/O1tGrA2HlY40vfSfuAJdkSbYwCbe0VtkaOh2Al1ufxrf6eKfosbY/dPQAfr3fu3nZnJhMMEqoopeNeQJMioATRaptd7ad1BUFRJfooeDpa8rPr7YHQ3rw2f8mWmpTL32ThXtzXnZxRuNhM+EA3dsiSAo5zFKS8cC78s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=h1YdhG/u; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d41bb4da91so1733555ad.0
        for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 16:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1705623251; x=1706228051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vylMAwKjOKQHziaAu87Qiy3rOLrs3/9n8l6rCdO/DPQ=;
        b=h1YdhG/uV4V/7dPA2x3YbN229M0X7P6v2zSSe+uXUiHIMdatP0XlCzFYCbUuJ1G46x
         dahGIt5fNpfWQIDjHYneNEpnnDm8eNnOe3NLKmg7eXk1dy0GT7cHDXLi5hvnTQ8ZOxpl
         fr9O02KY9+W7dkAHDBXid5Q0VTLlPXsvyNXiwW1lPKBrDoEPlZ2TzItOOLl7vh/Bvpog
         AwNHnWikEHg7/lg0QpQDYjhSq2fghMAb2tq1WyWT9tRY14EmXUMq34II00IqZezZGca8
         OGiGlP9Z+LehY/t/sQcTBKvS9Han7yzEx6ruH93EJa735+PgjJqodlwIYEuitepwwQP6
         bLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705623251; x=1706228051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vylMAwKjOKQHziaAu87Qiy3rOLrs3/9n8l6rCdO/DPQ=;
        b=dD4ukPtRkp5qxP01+K97IaMWzDruDanDX/k52nBBOFRlF6ZKhYoLhnDPd6b3USEFiS
         9cyVbXbV1oTnhhjnhp97WCBQmY4Pszj5wy2/biJGLPUnVD1K7oyByw+Uo5NlJTFtg/v7
         5gkT24KopgU0Soe/enlvvmUDEOVJWPBnzC0gMoz+C0ewtQXfoR7PXYWzhTNED+uqAElJ
         ZMffaEF4IkfU6hzMz9fIq7I0yQCXr7/oolv/m80SgKURc/OudSHEbveLfU2A2ZKC1rPe
         ZXksxQxkJxKaaMKL+ZiC4VB10LUpDZBqmBCNI6FJX6MQhmvwCWqdQ4VU5J05uyrG5mDK
         N0iA==
X-Gm-Message-State: AOJu0YwGSvUH1jt2cxu/VOaMKc1SI6UEjczbHJT6/azGd1Z1gx1c5yGq
	REfQxIkDtEcjxMUxHNLC6pT8bqRTEiHl29iLXbbGWYXqZjcje3mANrny8H6hOA==
X-Google-Smtp-Source: AGHT+IEujyYsUJGmW1OBKfiKKsRFXPX9ujLaJT4F5AN6NV2hBr7LLUYW0WtDMX5ex7jj9bZP6/c4ew==
X-Received: by 2002:a17:902:f68b:b0:1d4:4482:83c7 with SMTP id l11-20020a170902f68b00b001d4448283c7mr1774551plg.117.1705623250639;
        Thu, 18 Jan 2024 16:14:10 -0800 (PST)
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id mj7-20020a1709032b8700b001d1d1ef8be6sm1921238plb.267.2024.01.18.16.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 16:14:10 -0800 (PST)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: Kyle Huey <khuey@kylehuey.com>,
	linux-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Marco Elver <elver@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Song Liu <song@kernel.org>
Cc: Robert O'Callahan <robert@ocallahan.org>,
	bpf@vger.kernel.org
Subject: [PATCH v4 0/4] Combine perf and bpf for fast eval of hw breakpoint conditions
Date: Thu, 18 Jan 2024 16:13:47 -0800
Message-Id: <20240119001352.9396-1-khuey@kylehuey.com>
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



