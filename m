Return-Path: <bpf+bounces-30209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 155158CB77D
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 03:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD09C282B11
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0BC14A622;
	Wed, 22 May 2024 01:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vJYVpxHb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A34314A4ED
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 01:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339644; cv=none; b=MHCxm8ZUncQrh+26eOsVxESgMnuy7Q0m0sEwAmoTr8fkXi0RpClpntqBB/jGmREy+4Jl9xxc2eqYlbfrTwhF3D78TU9Mhu0wdOWaAtl3vgJy1xZDB7j60+Cxm6NRqnp8F+N9PleHKk/fBPBPRwu5pYEPsUey6o0HNgPPu/7N1Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339644; c=relaxed/simple;
	bh=vAK1SjmRfYckscjlF9bXWhC3HCJDYSUy2bAKb7cYeUU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i/4xCceuF3soCKld3vGRmae1NKzYcg6LMr2GQUKnXEzSF4UVBmh1at0N53JhJvs55hApq1SqHMO0s8A6oZFAKugAB5QTt8Ii/yHgEWA7X5qeKWKPmRMBCTtPeKhwTc35fSwMdAU5hTMZ52hORJql8RZPmYza5xfdlG6Orhm0mT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vJYVpxHb; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dee902341c0so14977867276.3
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 18:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339642; x=1716944442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/APWv0oI9augsnZmJefO/JsxQIQ0ybcPp2DpgllRB2k=;
        b=vJYVpxHbNpMCtVLkULj7a0AiLkDP3WEjoB1PYaXRdsr7Y78aa0OfFnbNQ62980dRyl
         7gaEmHRWZhpSGbrF2Op3Mt/ir2jQx/PWSLFquxH/BP/CIwQFmtxh9vtrr8sKU7rnx7z+
         YjCPWhBTgx5XcOQqsNtbSZwh6HVnXUVcMjg4vHVZN2gcBbM6N9HBivTbWgLY/RtZ+huX
         OiqTCH/CAlDqeGSvY3UpLzUbBZDX7UD4ls7lkFPVbX1S/fj+nP6Q53hRpaYV5cFrfuSJ
         13plBQqRG95v/6J24DA/xQobdh8kWYbP1gOPPir/YzhYi0eAUenTq2mvTJY//12GtFZU
         +geQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339642; x=1716944442;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/APWv0oI9augsnZmJefO/JsxQIQ0ybcPp2DpgllRB2k=;
        b=RENqlum2GlCkB6EiGDoflzJM221P2Mhec3I/4A7KNsD2Qw13a4gRUibgk7qV62rj8k
         Y8+gsOAZvE2oxIzx+JN398OAAZoSZxSsvmvft0IWTDo0KuPN+otfGOcavYKKFkv8R4Tq
         lyhzI+vYgSiLCY34++UWyx9TUxkpt7DNVAbaHtxsGgihNFpgSOfeNsOdOG9aZgzYPq9h
         pTLaCNJM1Q4BRDVrPrkq3hHg7Y/bKtkBbavq3kD4NCXD47kXPqotMb1HnkRIDycFawpC
         uXoQ6LPWufbCximap22WmfGdMN7z5I3tSYteJFJuM4jIrAxpeGNfVCqc359RZVFBQNWl
         mTsw==
X-Forwarded-Encrypted: i=1; AJvYcCXvX3nstf+EgX+yb1fD6xymF9dokjRjlz1KJQp8kGu/50LJcH0B6ViZ1bog7x2coczB6IIWJqodd0Q90fsyLWao6wjx
X-Gm-Message-State: AOJu0YxJQ8uiQGKCS8y/3erCguQQ/obaw736Q0lZwWN7lXwV1GDC0OZr
	JnWdINcPL4lTAR6JMVJbzuxX8pOSoG68oFEd9dUE62RYUtZDRQrBnPciujHPIQEQ/CFtYPQOACD
	BWw==
X-Google-Smtp-Source: AGHT+IGAclX451NumcxAy9NMEz+qq9f2aWZhVVXFDpvWXMuYKe4iFyqjOFjW34/TGUUo4ozk/aBl3VFiCKo=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:1205:b0:dee:6f9d:b753 with SMTP id
 3f1490d57ef6-df4e0ac5d4fmr74410276.6.1716339642289; Tue, 21 May 2024 18:00:42
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:12 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-27-edliaw@google.com>
Subject: [PATCH v5 26/68] selftests/landlock: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/landlock/base_test.c   | 2 --
 tools/testing/selftests/landlock/fs_test.c     | 2 --
 tools/testing/selftests/landlock/net_test.c    | 2 --
 tools/testing/selftests/landlock/ptrace_test.c | 2 --
 4 files changed, 8 deletions(-)

diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/s=
elftests/landlock/base_test.c
index 3c1e9f35b531..c86e6f87b398 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -5,8 +5,6 @@
  * Copyright =C2=A9 2017-2020 Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
  * Copyright =C2=A9 2019-2020 ANSSI
  */
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/landlock.h>
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 7d063c652be1..a30174e2e053 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -6,8 +6,6 @@
  * Copyright =C2=A9 2020 ANSSI
  * Copyright =C2=A9 2020-2022 Microsoft Corporation
  */
-
-#define _GNU_SOURCE
 #include <asm/termbits.h>
 #include <fcntl.h>
 #include <libgen.h>
diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/se=
lftests/landlock/net_test.c
index f21cfbbc3638..eed040adcbac 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -5,8 +5,6 @@
  * Copyright =C2=A9 2022-2023 Huawei Tech. Co., Ltd.
  * Copyright =C2=A9 2023 Microsoft Corporation
  */
-
-#define _GNU_SOURCE
 #include <arpa/inet.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing=
/selftests/landlock/ptrace_test.c
index a19db4d0b3bd..c831e6d03b02 100644
--- a/tools/testing/selftests/landlock/ptrace_test.c
+++ b/tools/testing/selftests/landlock/ptrace_test.c
@@ -5,8 +5,6 @@
  * Copyright =C2=A9 2017-2020 Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
  * Copyright =C2=A9 2019-2020 ANSSI
  */
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/landlock.h>
--=20
2.45.1.288.g0e0cd299f1-goog


