Return-Path: <bpf+bounces-16628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCB4803F17
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 21:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C9A2811F9
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 20:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5FD33CEF;
	Mon,  4 Dec 2023 20:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="Mcb6mQer"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D33CE
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 12:14:23 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-35d7ddcab70so1571335ab.3
        for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 12:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1701720863; x=1702325663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H8NnWWG7H7nc5jyaZv4mKNHAF15RKAHvf+fSH/2yUjk=;
        b=Mcb6mQerwYqW2OjeWmcG3e2+zg0z4m7JzjKHPfVZajVp2Jaz+6KLr7Zr7D7Pr39bGt
         NBx03i5m2trIOn4tXXlRuTwtnux6LZcPKxrBz/5Rae/m0WN6UWEKkZ75TvG7zO1FuIQR
         q/1zuxxfMAmt0AxvEoRrpeEc+9EJDHJDyp7yxZcCO9Prs+hZagYyZ9OuMbmI1SXSrFhM
         HIKZBCaUHbFTRZt+6QO7Alc0l89FjvIDkx1zmdXa499PVmy+NadrF281rG+RCLAecWpl
         oqFSLcEDabi4u5BxUlv0C3w6ZvtINbBJS0US5s9t832LE1KTrd/SlH6JEn3eyyMndzvr
         POrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701720863; x=1702325663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H8NnWWG7H7nc5jyaZv4mKNHAF15RKAHvf+fSH/2yUjk=;
        b=nzJzS/sfHxdssmzYPLsj/kmPy1kwiSZTzC9FCa5GKrw3qAjvGEI3YPvZzY0C+I/xmy
         KBxWmO54Uy+T0KQNDTg7dYsw3kRdzH+lHLknbKiJRrmdkJ/8ds0KMcUXSPnXrbWrPv7i
         L53WyHciXLEM/808/EH7kQtFDjpB01mIiIhZkPc8y/tiuhG0lGyw4Efk36+MkjgHKTUe
         PgkvfA/AffmIDszbF1Rnk/QKPfcY8/TeahCJRCRjhAQBcgZeEeLQp2HSA3xmpOb1a0w4
         yM0MOLxBkZFOIAHMQiZjVw1T8l/yU6PB4XAC2RhqNrOoYcGW6nNlfS60wuhL93c6aaem
         K90w==
X-Gm-Message-State: AOJu0YyqIHz3biViL/YEosqs44daS41mIysv/iAIaccBSqNtOdf5iJk7
	YCo912W80AB9a0MwN7XTwyplyQ==
X-Google-Smtp-Source: AGHT+IHKIFlEYfyVLPyh5Ok1N7q0Jpq4RxGeFjP0PY+F7s1OyioqN3CRbgraLtxNb6cVMvg3dQt0Vg==
X-Received: by 2002:a92:c5c6:0:b0:35d:59a2:bc0 with SMTP id s6-20020a92c5c6000000b0035d59a20bc0mr2482644ilt.86.1701720862923;
        Mon, 04 Dec 2023 12:14:22 -0800 (PST)
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id n7-20020a63f807000000b005b529d633b7sm7894060pgh.14.2023.12.04.12.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 12:14:22 -0800 (PST)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: Kyle Huey <khuey@kylehuey.com>,
	linux-kernel@vger.kernel.org
Cc: Robert O'Callahan <robert@ocallahan.org>,
	bpf@vger.kernel.org
Subject: [PATCH 0/2] Combine perf and bpf for fast eval of hw breakpoint conditions
Date: Mon,  4 Dec 2023 12:14:04 -0800
Message-Id: <20231204201406.341074-1-khuey@kylehuey.com>
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
an attached bpf program to reject breakpoint hits where the condition is
not satisfied reduces rr's replay overhead by 94% on a pathological (but a
real customer-provided, not contrived) rr trace.

The only obstacle to this approach is that while the kernel allows a bpf
program to suppress sample output when a perf event overflows it does not
suppress signalling the perf event fd. This appears to be a simple
oversight in the code. This patch set fixes that oversight and adds a
selftest.

[0] https://rr-project.org/
[1] Various optimizations exist to skip as much as execution as possible
before setting a breakpoint, and to determine a set of program state that
is practical to check and verify.



