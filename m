Return-Path: <bpf+bounces-17015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9782808D7C
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 17:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A0628228F
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 16:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6261246B9F;
	Thu,  7 Dec 2023 16:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="EvNyROlM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E275312D
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 08:35:10 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d048c171d6so9640375ad.1
        for <bpf@vger.kernel.org>; Thu, 07 Dec 2023 08:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1701966910; x=1702571710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xogDwySrHiRFAfCXEnCaVWOOT+dvRIT71JwIoqFZVtE=;
        b=EvNyROlMdIw6MNUH1GZ8AGOS2+s0uTw1QVqATc5+52zV4QJbOMhAvINSslxxGT+dWX
         ERKSagQJmdK27Ss4Xjf+iALF3GVnFnOjXO7CP4x+mQjZWiVcfm8X2+d8FnT7Tr4i2JLQ
         WiGlx5TrDJTYq6oa/ERU1wbHrkRnSHtAzI9Jqx3Z/3OFkrbg33Xs0/+xFIs85Je+3tw5
         hrkDgd5d8R4rvmxblbs0G5TBoUXbdsdkx7XwiKhVEYSETsIlZYDWKSaQMS8UQ3ZolQ8H
         b436MQZM8hJVNAqvAR0KphhM/mtRxzbfRSDp6KSrGgRcX9vVnWaPtoShI8PtEXol2n3/
         HyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701966910; x=1702571710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xogDwySrHiRFAfCXEnCaVWOOT+dvRIT71JwIoqFZVtE=;
        b=moIyYYn3NJZGuoHODqjTqFMREamSk6ZA28tr4W8QVapFd1yjApRqP9lRxnwTSkOTtx
         So9zlz+s8JeOiyCzskrp0wm9INTJQ+0J0A/5sR8O6J3wauHrgdnP234aIXWd7iVqVkJP
         A9U7l/bQTQt8qdrC5myEr7LW1O/BJsJye47L7xTSX4XIavYVWZKsPizM+4N6SqRzTXtg
         xMtvgv8fV8Gw+WA2l4wzAMHIJVU+gwZTg+ux/Pz6M2vwqdKYFn/v5jJoTwNe2CiVp0JT
         XMTK4gp0JNbHYs2LywVFvgYkbRVUhLXaZfl3SZEfEWzB3/BYy1yuumHIHquYYZXcPbux
         lHEA==
X-Gm-Message-State: AOJu0YyOdLsM3CE6Xgm/aQxoqnfXEwJ4Ja0pdxNFoqWvo5zSCiOqSdJl
	z4LrXa0bY6IWGKsT1GQwc9eUyg==
X-Google-Smtp-Source: AGHT+IHDpr3J9ROCjcF7G8HNLiXYI3MOZmTU2nKq/6Yj5bUt+LRMeq4AgUhu5fv1ZeE2pDR+CZuKZw==
X-Received: by 2002:a17:902:a711:b0:1d0:6ffd:9e2e with SMTP id w17-20020a170902a71100b001d06ffd9e2emr2493195plq.128.1701966910194;
        Thu, 07 Dec 2023 08:35:10 -0800 (PST)
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id iw15-20020a170903044f00b001d1cd7e4acfsm6143plb.201.2023.12.07.08.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 08:35:09 -0800 (PST)
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
Subject: [PATCH v2 0/3] Combine perf and bpf for fast eval of hw breakpoint conditions
Date: Thu,  7 Dec 2023 08:34:55 -0800
Message-Id: <20231207163458.5554-1-khuey@kylehuey.com>
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
suppress signalling the perf event fd. This appears to be a simple
oversight in the code. This patch set reorders the overflow handler
callback and the side effects of perf event overflow to allow an overflow
handler to suppress all side effects, changes bpf_overflow_handler() to
suppress those side effects if the BPF program returns zero, and adds a
selftest.

The previous version of this patchset can be found at
https://lore.kernel.org/linux-kernel/20231204201406.341074-1-khuey@kylehuey.com/

Changes since v1:

Patch 1 was added so that a sample suppressed by this mechanism will also
not generate SIGTRAPs nor count against the event limit.

Patch 2 is v1's patch 1.

Patch 3 is v1's patch 2, and addresses a number of review comments about
the self test and adds testing for the behavior introduced by patch 1.

[0] https://rr-project.org/
[1] Various optimizations exist to skip as much as execution as possible
before setting a breakpoint, and to determine a set of program state that
is practical to check and verify.



