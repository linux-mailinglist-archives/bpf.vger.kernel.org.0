Return-Path: <bpf+bounces-26598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEBB8A235F
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 03:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1258C1C2138D
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 01:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EDC6AD7;
	Fri, 12 Apr 2024 01:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="h78Qsxjb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D153B4C70
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712886642; cv=none; b=PorzKYoIJrM1qD4rSNKLBn6pl/DXhZAgje+x6PksFLq4DgIR2KUsjYK9iEkbfdbQuGzE6xB6rQB8zTtlKXUL+F7WouAEyh0D2juPo0uslH8BdlrFkbfXkwj/bOOOXQwL0kyBiNwJlYE6GNs7EYgDCsa4L/HqL9w500VMGMRznTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712886642; c=relaxed/simple;
	bh=RKfWMjr5Qx55FeibUP0Tdl8Z8rvHwRWMq761t6ZocyU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QhoD2J4anXn2wQy1qOF6yz5AyReaQe2tfRYpqbPlR6oTtwGUFvtQnV5AJ/9Z1NlUttZEOzhCHVa5bapMp21QY4B45ABG0js/X6Iod82PZvVum3WMGqyXgGJFIa3glcccZ7XsywnUpIgST8O/45RDssAKkaiWUp39w6weIPIoWZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=h78Qsxjb; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-78d683c469dso30742485a.1
        for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 18:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1712886640; x=1713491440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RKfWMjr5Qx55FeibUP0Tdl8Z8rvHwRWMq761t6ZocyU=;
        b=h78QsxjbzPkO/ItaWrTyIkFan3/dyp94gMjCEpJH+Zvh1erJ2w5qSgko4G9vzet6Jh
         yOe6LZmESQn50cwnYr0S9ENNQFSzKePUIY7yTirD8CyOmZmun11yd1oiCS2Ynklmybcp
         v/wCgavYj02iCwJ6IlUSE0OHvXDnATLZEKExoJRkb5ilhtaDrIefqnyMFgGKuMMYbU+i
         X00WeKDOBlL50XwfXR1c+yebDg1QJtEvrVPwKmO/ShtGqOzBmeDGKp5yM2sNFh6LO77a
         OWptLaKGcVsRBi88GP0vB7u9+yjyQNBMx0JNpPh5FkMvisSNKrBhs/zimRkYxRaZ9SxT
         qQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712886640; x=1713491440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKfWMjr5Qx55FeibUP0Tdl8Z8rvHwRWMq761t6ZocyU=;
        b=b5g14UkQ/jzs8LTinsNGtO8dj92YCKE56XqC7U01T4KpdiHdPxHfKa5lI4D/c9e6Re
         tcTnPOkwsqk+zZG2zmh8KHYkBsmYFCAUFwglFiwkEE8e6LajUOwGIJ40FnDU3m3XC7mP
         gLN3KCaXQm2CVhAXP4DZ2Y5wt0i37oc2WU1d/Vg3ODokk3KkeXDnseFQXanvPbvqYKxb
         5HXYhLuGInY0oVue+M1xCBu1GRHWn+1idbviyTnecmX7Ppib0aYRMdUp2w7ZdGHFx+EM
         bLxxFPejXXTZKHt0DAWvMcPUsWQD7jkkl3Bm+4s8tjNc42Al8t5/RamzjArybLSXoVLI
         kSOA==
X-Forwarded-Encrypted: i=1; AJvYcCXx2bJ2tJWz2yH7hHCYPNmIz8TYDqCsRQO/qBIVdIIzDmH0TCfXHPnQRPzRiLrHQ3ag4vzvpQzIyE1+4HQiyNGsHK/3
X-Gm-Message-State: AOJu0YyzUTfS5OZo4iqbRwn/QGvDVs0+lPz2pW+B+gA+zeOlf5lIkV9s
	dl6iNRbExQxqWjtQ2q8pmoOaXbtVRMnJ1+hjgMVrTwdo/jYpzXtrkwUTo6OKRw==
X-Google-Smtp-Source: AGHT+IEGFAJCUIz0qOFVbQF9We1/gUwvWByxa1EsnJiVP7yOg9G4RuZdQ2KksmDUL1kOxZcOvJDljQ==
X-Received: by 2002:a05:620a:14a1:b0:78d:5700:2ce0 with SMTP id x1-20020a05620a14a100b0078d57002ce0mr1227193qkj.68.1712886639804;
        Thu, 11 Apr 2024 18:50:39 -0700 (PDT)
Received: from ip-172-31-44-15.us-east-2.compute.internal (ec2-52-15-100-147.us-east-2.compute.amazonaws.com. [52.15.100.147])
        by smtp.googlemail.com with ESMTPSA id f10-20020a05620a15aa00b0078d76c1178esm1756677qkk.119.2024.04.11.18.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 18:50:39 -0700 (PDT)
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
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Robert O'Callahan <robert@ocallahan.org>,
	bpf@vger.kernel.org
Subject: [PATCH v6 0/7] Combine perf and bpf for fast eval of hw breakpoint conditions
Date: Thu, 11 Apr 2024 18:50:12 -0700
Message-Id: <20240412015019.7060-1-khuey@kylehuey.com>
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
https://lore.kernel.org/linux-kernel/20240214173950.18570-1-khuey@kylehuey.com/

Changes since v5:

Patches 1, 2, and 3 are added to address Ingo's review comments.

Patches 4 through 7 are the previous patches 1 through 4.

Patches 4 through 7 add Andrii's Acked-by.

Patch 5 fixes Ingo's comments about punctuation and newlines.

v4 of this patchset can be found at
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
before setting a breakpoint, and to determine a subset of program state
that is practical to check and verify.



