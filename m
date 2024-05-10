Return-Path: <bpf+bounces-29366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 463468C1AC7
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE426B23E66
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4402012F398;
	Fri, 10 May 2024 00:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b0cX6bvo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A65A12F58B
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299815; cv=none; b=mrtsNRocl9FfuZ5OS/XODWFuxKFaI8caUgRygWSjdk0ceYWVeT4ivlpOPAvZo1ANo5Kjn8FkRjkPY9i4DxsuGfrqrBixalBqN1mqsMYogCZj5kfFC//K7gIMvcILAZn5WKjYPWm6Zs3OvQHkbzpHGvpIh6piNCdZsMSfO0TJ8zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299815; c=relaxed/simple;
	bh=t7ujw6ogf0jUcAdkgIoNqmn1k5m4g1U5LVlkiwe+0wQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E4dZHzxDDteRUmF6g9yV5lnf/gaZh4fsHdJZZmzKEpf4Wg9vFEDNjvIHLdztjHYGtTuRryZPEeWP1uTZdkAmn6K5GYrsQFvULk5NQH7dlaJq0Ckf+AXIJm4vTdHVm+rtQB5nbReF1EN/qYLz4rF3J47wd4h5cW26zxEccMrecns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b0cX6bvo; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61dfa4090c1so21176507b3.3
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299813; x=1715904613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tmh402qCNlwXH2YaTj4ydVf0xBV6O03FHXYL91hE1gk=;
        b=b0cX6bvoD6sn/fkb07XDfxADzxD0dps2Vk0zSdRoifl2zFS0eyV2d884nLY+odey4Z
         fe6LEElgEJDzEylNKrtX9arZMP9wzq5hHro2aW3+fczo/AtG8+fK3j0hXTD0C0twe4Dk
         pVDu0cSlQ2Ri3lgCUvPnsudvm97K0XtTuJeUimY2WtuaT0efYInn6if5y3tgpitjh66L
         scFoUlM++38slVVgNBiO7k8urIldQ/cr54VTJNH9kaWrIF3q9lNsoiKEwXZg32VKtwj/
         E0c6lhb0b1m2AFQ6ucB5AmmxcDIJnnZjD3vQQf8Hx6AbX4zqzrw1kE5lPk1F6oEOB3Qg
         ebZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299813; x=1715904613;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tmh402qCNlwXH2YaTj4ydVf0xBV6O03FHXYL91hE1gk=;
        b=JmpZ0fnIOk8EMLT9RdKyIGPxGroDXCwHNHZdJwcwyDQmdFWCNgzxXf2bYUYV74QgAI
         iDuYOc+CDIoxPXHE+osNDXu9phqMdEkOSniu4s9UMqyF1FdtfkFgBWEDgk+akv+FGoap
         46TilcrE0xCEREibBW45mq4DBdH29KAASWS16scRJm7/FvZmyz6+mVeRbyFKhydYzPZD
         V5JKY+FGeBLGZKC9ZOOjIBI4YOlZZsDpszviUbXRecAcpdvR9wQQZkhw0EeZikBQbLDE
         v2+nT9u6P3Ky7fpZHSXuRfm9JyY80YYtPowI29+Uz8ePSlvjxS76TY0A1Pv0dwZTyRWL
         EidQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUoqOMOnk3jPMNp67p2HB6Oh5KYISz/jUCw1+wqKiTKEzFGW8tXqUPFLCXclEk8J11ATIp64BzRiQLrBYqQjlGSqhP
X-Gm-Message-State: AOJu0YzBUmrdakmfPC5shiuOsAICMu2cg7PbL+TjRIGGAiVXeYYW2ng5
	UmMg2DcLCQR5V30J45Yvq6auewF1uqUMQwCr9ZMCDuXPyjrvPo4yJpB0OjLUbyjkZS6Y14okifp
	eBQ==
X-Google-Smtp-Source: AGHT+IG3cHhi3l/PsMh03xlUUaL0xaqZZdF1Mw4jw0r1lBZXsRFFIr6qUwnHrRToq2hjUiJ8fGM23U+/biY=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:6211:b0:618:8bdf:9d56 with SMTP id
 00721157ae682-622afffb2b1mr2643407b3.7.1715299813350; Thu, 09 May 2024
 17:10:13 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:42 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-26-edliaw@google.com>
Subject: [PATCH v4 25/66] selftests/landlock: Drop define _GNU_SOURCE
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
index 6b5a9ff88c3d..eec0d9a44d50 100644
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
2.45.0.118.g7fe29c98d7-goog


