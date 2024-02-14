Return-Path: <bpf+bounces-22011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B19855094
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 18:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 757D5B2C7B9
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 17:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52D084FDB;
	Wed, 14 Feb 2024 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="cshEGeq4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE4E84A3D
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 17:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932443; cv=none; b=EMZK6hQ5oUXIKndrmtC9FVRUYIp2ma7JZ+os4ljPvL/B2qZRvJ3aD7e2VP1XK7Q/FdMAeEyZx7U5PRbQIXedX1/ax6Gxcr+AFFfdbDLx58BwVx2GLkBuWBHaVLi+Pv9qxrTyMS8IDSGWbsqHT1eMZHqIoTpaSJYu/OhJREI6tyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932443; c=relaxed/simple;
	bh=jgy2rEJspdN//Zbn+lFhBu2O/NSR+ai7CwG74xi36l8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kT8Mo0tPOA7EZJfbbmsi3e+ddIOWm5bYl3nUEVnn5UVnO0gv97E2hERv3wmY0SxiRceiRRiYqnjnvne4+748ET08ZRKi/nfCHB+juIOt89/8FOQ3K0bA+m95PQKyZs5t0Zyw3c7JQFIVoQb5aGIGxViMlsyPb/Jymq1tGJ+JaOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=cshEGeq4; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e0a4823881so41943b3a.0
        for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 09:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1707932441; x=1708537241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jgy2rEJspdN//Zbn+lFhBu2O/NSR+ai7CwG74xi36l8=;
        b=cshEGeq4uL3Qs8a2xF9v32Aot1qFpjiU9PYHrMy484V67zH5QG5Eag1ZAhKCqlxoDS
         qRnHvxx0ziqIVJuh/uyh44DjrnuyfaJSqrVrCe6/7x+aVqtYa2VspoA+F7MCGb4RZiI8
         DkysExi3m8K1YFshThivrZQ0Br8ITpfIexp8uDqTQ+N6s995m1J2TcuyzlLaFcdKTzp8
         3/HiUnPbbqK9a/pOUoj3Cnl1Kf1YLAXAu8jSuoxa/MzW50SlDRE0KvVwWRsQz4Lz1+Tb
         9q5ayMsViQrLEKcFBwLF3HhhmX+6mpLk2jLeKdIV4VbrtvIjXAp/p4oRtO9ATMf7xTyJ
         gHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707932441; x=1708537241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jgy2rEJspdN//Zbn+lFhBu2O/NSR+ai7CwG74xi36l8=;
        b=J7IpP3DcUv0wH8o1sudxEcDQclbJ1N5q8UaieznC8mzBgLjV6FJ1IZq3lcXnZTUavH
         nn7Q8JjUdTbc9r9B7Yroafs4eI7PQvqw3J2QQf0C51GG7Ho73WHc3Z5X/8OGcJQStfMw
         ZEQlDYptPX7ngUL3PeMm5MiDyjpyY3uKz5P8DAFGl/AYz4vrIi7atypDLLt67ruxLhoi
         /EWnmoubCSnJh/BJ1vssqwh6mP6TUTHu8EmjVC5nYDfx5BlUpJ2f9jYd4XccqaeoLbku
         EkHA3c2sfqbJ/SG8mG+jeUZIqM+48gyyWDya+czgu/cnllVPcf6a4QndgJTKBScmjjRo
         57zA==
X-Forwarded-Encrypted: i=1; AJvYcCWjYDeII/aq1QJRdulO7Z+6KKNqGkj0zmccvYC0ZMBBOen8vYMtgWLrGdDsGXuvpO3xfi/gmOdRMvsklBsVB1E0o16i
X-Gm-Message-State: AOJu0YzIs2j2b1MHSMa2mRg8/j5qn0xTZdb1R8VjlhImzqhh3PCUBXLC
	8X5W4UWFI0f0M0V8hoKhybPdjUY8Z+HvJ7W7AeymyJPWQg4lXEd/BGMmsfJFTg==
X-Google-Smtp-Source: AGHT+IH7Z9X7s44wQBzyl/o+Sadii6DzR3/W1a9bf9T8NL4zuOsMyS94PiNUFtbKTsK5eXV3uCTkvQ==
X-Received: by 2002:a05:6a00:b43:b0:6e0:6a38:6ded with SMTP id p3-20020a056a000b4300b006e06a386dedmr4004544pfo.12.1707932440840;
        Wed, 14 Feb 2024 09:40:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUVN3G485IyQtiWXChm4rxS62IFSFeMyx8XXwhMpaCfud4q7qWXuJidif8vl1V9Hs124NvPiZTxGaMlqZdMI5dhmc6KCHLjhSRlciye6v9GYdyS3CfDMwTmdiSIGHWsT0iPK9DMkNdaR0TtPT+TYjKyKb4q3LKMtlqsb1m3QOxbDumQiKXoRwOhI2QQQaVIM9wNJQmSnkbC9/30hWyl88D6rucTDX875kd7bHH7yYYbM+S11ltDJwOsOH/TbIFvQb6XqleXVArQSfCRpEOScN7GxrRpVSrVr5LHB6Rxl4TX/OOWuHV7gIzsSu2t5HGBISID86SAKQKniTHV9/g+7Af+R3UjliQNVg==
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id p5-20020aa78605000000b006e0874cbaefsm9567604pfn.27.2024.02.14.09.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 09:40:40 -0800 (PST)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: Kyle Huey <khuey@kylehuey.com>,
	linux-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Marco Elver <elver@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Robert O'Callahan <robert@ocallahan.org>,
	bpf@vger.kernel.org
Subject: [RESEND PATCH v5 0/4] Combine perf and bpf for fast eval of hw breakpoint conditions]
Date: Wed, 14 Feb 2024 09:39:31 -0800
Message-Id: <20240214173950.18570-1-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Peter, Ingo, could you take a look at this?

----

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



