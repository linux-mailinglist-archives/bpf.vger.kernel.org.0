Return-Path: <bpf+bounces-30238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 018088CB818
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 03:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0616281580
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF9F15884C;
	Wed, 22 May 2024 01:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="huLa982i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D8F157A4F
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 01:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339735; cv=none; b=VVXCQnJoVihin83bluC1X7zYZKU0CBtvdp0u8+E+IdgrKQ+wdDOmzirf+seXN/jQK61IF9x1k/8k6KYRtZQEfN6Tsj/8Y9ssZdQVfNcBHbwUGoy9M1Hys38K4f0KB3GmM1eyRPIanUmIyd/OV9wYBP9wUbtOmIm1l72ztjg6wGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339735; c=relaxed/simple;
	bh=cNihbrzeHXKylEz/SCN9dJ+kYGl2jhozgZowklGSBnU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KzbMCN6LwvtuP69SnAgRJz2wl7M8sb/hjWlzAPhePulMidcD/wDzDVt+F3IVMdscVYAItPRV4gT5vQN0snFYuUYAgWnIQJluduT9Ql3oTbRiRnDOU5NFn3WIeLcB38RPqMDowl0RPD5PIzahQ9eDsv/Z+GOuV2oR6NNoM+at5pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=huLa982i; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6ece5eeb7c0so11692798b3a.2
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 18:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339733; x=1716944533; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NAsd/Ppca2ejRhM9/9MWOjE3ktFAjB1L9G3cs3vun20=;
        b=huLa982ip39nhYcAJ+yjNXdol3toF+VODR4r88JoAy3HWw8LngTRTJYRVjiMvFraBx
         684LfoMT38IpJgArwassPpy3tQYzS0k7xDRR2HVtM9tvs5ywB1Mm7TG+DXKbVec9pf7J
         vjGjRtxs7UpdCh/r+rAqIHjNtp/v96nphwVRYiz6wuwDOv+jd5D0rdr2dsS+aTvNm+EG
         VFGqHFYitUmPQjMqhIW0zNCvpPhBdUEAPY4Vj06xA1CObBPWwDc3a1K2RUI9VtL6Gic5
         kfnJsw/BDFvmJuAq2bAhomirpC8Ao/hbEff86KrUbO7pWaMREBoAshq1A99ZHiAPwknT
         5OBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339733; x=1716944533;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NAsd/Ppca2ejRhM9/9MWOjE3ktFAjB1L9G3cs3vun20=;
        b=dUlJE87X7F4JfSlYjwgCBgTini5oG+X8pbfWHe943xzJqBc6SjWCpymQ6p4Rl5uvvN
         6YF07ErEvhpzavEfgAHnVP0EZsrd8l92UM936Ju/+FWKHD1HVHuBxPbCCumYcG74+md8
         LHWERy2fyyViRy3p5ih9NJ/2nW93in938bV97SGD0HnOusUnYTZ3S2qVjq3GAxTU6O2I
         MYMIHX/rcH0nrg6syTsFudQxgu5divGRF6UaRjKD9BCBmDDscy3m25NysR9xL9BqZmg4
         kdSDIWlAVkF0pVGw2h+YYKf9xmaQ+gKadgEE597ddAJkXgboh6bhGWUfnl0meW/flN9D
         Hq7A==
X-Forwarded-Encrypted: i=1; AJvYcCW4SIPdgvG11QqXfJl+U7W1f2gcEERqY26OM3l4ohi5yk9yu83Y3t1XvfZ8I0N/fTWp5LK2X95eE0iwEQbTwN4Xz8bP
X-Gm-Message-State: AOJu0Yx2Xur8kJOc/y7MHi7UYuKAsvf/3+n5cvnpQCG+Q5nmezJQ5dIV
	Kej9WbUNarBfewpDKe/tbYZBgcL4/Pzn25w/65Pn604Za4bdotfB/CnthlNq+eWxmUlMR3HJviD
	Fcw==
X-Google-Smtp-Source: AGHT+IHH7wkPUdUjgwa1/oOxKhUosXdZXQHCdxIhj9UD0tOKCukjPqh+CALUTfw2/d4x2W06CEkVNYszUyc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:aa7:8888:0:b0:6f4:9fc7:d21e with SMTP id
 d2e1a72fcca58-6f6d643e499mr24375b3a.5.1716339732719; Tue, 21 May 2024
 18:02:12 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:41 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-56-edliaw@google.com>
Subject: [PATCH v5 55/68] selftests/seccomp: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/seccomp/seccomp_benchmark.c | 1 -
 tools/testing/selftests/seccomp/seccomp_bpf.c       | 2 --
 2 files changed, 3 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_benchmark.c b/tools/testing/selftests/seccomp/seccomp_benchmark.c
index b83099160fbc..3632a4890da9 100644
--- a/tools/testing/selftests/seccomp/seccomp_benchmark.c
+++ b/tools/testing/selftests/seccomp/seccomp_benchmark.c
@@ -2,7 +2,6 @@
  * Strictly speaking, this is not a test. But it can report during test
  * runs so relative performace can be measured.
  */
-#define _GNU_SOURCE
 #include <assert.h>
 #include <err.h>
 #include <limits.h>
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 783ebce8c4de..972ccc12553e 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4,8 +4,6 @@
  *
  * Test code for seccomp bpf.
  */
-
-#define _GNU_SOURCE
 #include <sys/types.h>
 
 /*
-- 
2.45.1.288.g0e0cd299f1-goog


