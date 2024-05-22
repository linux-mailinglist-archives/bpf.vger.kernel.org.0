Return-Path: <bpf+bounces-30243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 238E48CB832
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 03:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2807280FAB
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F4B15AAB8;
	Wed, 22 May 2024 01:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2aZuf6au"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9AD158DD0
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 01:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339748; cv=none; b=dLv+Zc2ifOV/6uyX9cllXIFr75dTPxkAS8+1mcdm0tJ0JeCOGevjVejCu/0RftOlTHUfOmd2SfQTBTB3WZdyAJXk9Pbky11B2Dhl8siZ1dXRrRyNrgGf9AL5bkrvjms/KMfWWkwDYUGVxXG4FtpWRguVdjxyJPOJcHZhrpY7APg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339748; c=relaxed/simple;
	bh=EB/j6UJypAPanDLZb2I0KEJMnVzQCxSyO8B/qmHrSYc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dxBkBk+mqQYvbbnC60uSNFVPbGbgBiVSy9oEbrAy12u0zn1vfV0uuwUW+yeugGfzFOpmAGITfCFOo3vRocVKVElrzcj3vozJgeoMFa0ImzCsC1RG0dE/5YuXZ/3aLS+RNHsaT0xQNxOAEZyeGBpEHa1tcr45qP4oUWKpY7r4vhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2aZuf6au; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1f2dba0679aso54230495ad.3
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 18:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339745; x=1716944545; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dm1RYHlP0yY8z+cx1ACTtX9tqSUF2UuvA0/IyJOdLP8=;
        b=2aZuf6aueSZmbQ5iwuelzjjoGKTOUfcQbw8QvThA7XvRQ9hnkctUcCccItmg941epE
         QxbQYjXS68EJU+XJL0yGEsQO0EbHbsy5AQh/LpmsrlR/yaLZ5gAyQMpinjZk9aYxQSQC
         T6SXIF0czwHWxG+4uaDRI993WoAwR3rORGcpTrgbhsen/KleiT1HkogIilOpuOTnVTuo
         3H5tIMH1gWUZqG0e83QkgOTNezwvEyNnnAnUyESqgzPtRCj1gLlvfXcVu3+HSHazf/Qd
         p33m/zaA/Td4UmjtKIokJL2vi69hJZ4v3yXMqoFbCI4SGMODnjVq9CvMnniRnyhIsYrT
         dD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339745; x=1716944545;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dm1RYHlP0yY8z+cx1ACTtX9tqSUF2UuvA0/IyJOdLP8=;
        b=IHWk+ELmuW+L5FYhF84A/Po4O7cgaWIsWrymZcuOdohFMQi1kKFj+p9DqOkSTljtwO
         RV7sj0xDV81cKRP7uYtNRA0SpTUXh6f/moGu7UEJY2lyJmC+XmdYxoRl7kM1qDsVJFs+
         qDbzEOF3Ylb+KYfovQ/tbQ6m6yUFkaYV3qfDmXGjGe4pBecCa1xmtaPNwAtD5+qOl3eA
         79kAXlG2Cp7+OXmeETV76Gn2PRFIZjZxbcm3lIJaV2iy35ufDlkhYaxeJ7+BVpoVCmIx
         O5S19tdUG1d9KARnCpjC9FYKrkPkrz8PYmysEtt6J36JbTZ7dpuHrTyEcO1IzknXcb+4
         VYBw==
X-Forwarded-Encrypted: i=1; AJvYcCVXr7y/ne2YSWQ4Pyzae5GQMlLAjeaWtXqMxMFaP9Qo+c0WNJAtqzSuAZCqNxLIqp4F5+7waHcG1UKeZreIa7iMUQRh
X-Gm-Message-State: AOJu0YxF2amRokgHTSiDsCKL620BpxJsBwmzeQav+gY/eIlsWDlXfmOz
	CQtNw/e9s7XTJtfXU5jAs0PcBDkPy0KxNv5o5SIK/H151mFV/lvjCtTIxL82YoQ5K2GqtccZzWA
	kow==
X-Google-Smtp-Source: AGHT+IFlPItv3KQjRVyD08JVklH4KtCoAvfm4Lf6y215FzRt97XcDClrNcaWNS3yMHJbFTWQCPvk6KGG8pM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:ce85:b0:1f3:665:9043 with SMTP id
 d9443c01a7336-1f31c7f3f98mr17625ad.0.1716339745033; Tue, 21 May 2024 18:02:25
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:46 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-61-edliaw@google.com>
Subject: [PATCH v5 60/68] selftests/thermal: Drop define _GNU_SOURCE
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
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 .../selftests/thermal/intel/power_floor/power_floor_test.c     | 3 ---
 .../selftests/thermal/intel/workload_hint/workload_hint_test.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.c b/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.c
index 0326b39a11b9..ce98ab045ae9 100644
--- a/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.c
+++ b/tools/testing/selftests/thermal/intel/power_floor/power_floor_test.c
@@ -1,7 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
-
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
diff --git a/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c b/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
index 217c3a641c53..5153d42754d6 100644
--- a/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
+++ b/tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c
@@ -1,7 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
-
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
-- 
2.45.1.288.g0e0cd299f1-goog


