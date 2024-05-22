Return-Path: <bpf+bounces-30210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 951918CB783
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 03:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B87D11C215F9
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3463F14AD2D;
	Wed, 22 May 2024 01:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hQ0ZI31+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AEB14AD03
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 01:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339647; cv=none; b=X3cvnsgMbbvF9yMovzG+Jb1ZvwZBcO9JlLZ1TMNlEnFjmc/ldGgmRXHMSzwhYTwK4AqrnwMc/lU9QDkrNSNRKNA5VNud1DuQgsdHKJo6Qtr3StBX22Te7kSb2vt8IL8kPf4af4ciXg3FBA8XN6sVJLRC87mlu0RjWOT3if799bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339647; c=relaxed/simple;
	bh=oZHnJqF/9E2YIXhg1q+wA7AGZkR9jjztSz586c2e7v8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NW7P37caAlPwgU9n2R6l8gSMXClhG11zCG3bTRDYOXvXIXBS+nhyv7CfWGPqjlcPLHQvWJRX8hwHsUaeiIMXwbMNEye9s40456TNb0cOGZnH46yEb9zoz+hkHmvgIteDZBNIZTQbDvHjfF3vijRHoPI0C40Q/M9HJvIduchFGkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hQ0ZI31+; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df4dc93d0d3so975390276.2
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 18:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339645; x=1716944445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KXwO0L9UP+8QZMVBOIJm+VyqQgH3dRfMq6r9an6EFTA=;
        b=hQ0ZI31+PI92Wa16vTGi4Z6AmTRZGh22mi3WSbUCq/zybAnHu+iZ7VaKwAufsHWghw
         bb46FOzo2TGGucsuxtAljSeGj0/GCmu9vnOlW7+FHAL6Epw4vx3UN+uh8DcUCYvkCxMs
         fcyqk/r951weiedysZUn0GeXkphXWJFri773ocZL2cBrsmpSGLeh6JfbgvxomqHFxTbK
         vfGGhRPt4klpAigLPUnzyC7ePmJE8FjmGKYqBMvotsP3+ReEkgNXAqL4i46ePBSq+sf0
         9mUM50fDQhW5qg9g7iWFzdF1rrP/iWsw6E//SPuHsCbRBwrDLTIY7E+KnEmJRjlt/big
         cJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339645; x=1716944445;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KXwO0L9UP+8QZMVBOIJm+VyqQgH3dRfMq6r9an6EFTA=;
        b=iuLbedBafG7u25y3YKzjq+I4lp7gYjUz8YFrIRsaxBu589AS33iX2ES9h3NZMKRIbN
         gD0TnsELA3Wvn96Aoa3ejcp9t1YvFe6Nj/7WmPsztnef1/sgKz5v+Ng+SJFwIJogxYLl
         PrCiNOtia49UhSybu/4oPC7hwBRm6YRE/uz6heugnd0PhWU+nrFfVNnOFvD1VsMofvSx
         SjEHIq/dT2X/Pg1KS34MLOYn0u/7RGUeTGwKnp2IwfjJ97M5IlXMwPJenFLnI2R3iN0V
         Rorsdaej4n1lNbEBIR9WZCJSPN3I/Y99MF9SaxcVlon4aJWOY/fFFzdg/h7hZXR7UgvB
         r5Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVqgHBHpIWvZgjj5upE1XgO7XGnCWEqkFdLZC2W/wgLuMS6iCfi3S0tR6C8D3szlg6KLVfwXVGQh/2RFWJ9QvwqKF6G
X-Gm-Message-State: AOJu0YyNf2zusHCpGovRzvGedI1JJ86PT7P+DBNSCv6zIcdT4I85YUjA
	wDVu/TRJsGFyKAJRyPSqO4tFKTao+PY/RRb7KjjrhFVCe5LRCkR5vCtGPjL02YmUotLM25t1rlK
	2kw==
X-Google-Smtp-Source: AGHT+IGq5EkCYZMZ8kSZUDy4QXD5Fy/Txkil5cxAziOoCq+wpprVpOx9voNzKq36ByPvzM1vyjQE12KOztw=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:1143:b0:dc6:e5d3:5f03 with SMTP id
 3f1490d57ef6-df4e0ab187fmr228918276.4.1716339645152; Tue, 21 May 2024
 18:00:45 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:13 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-28-edliaw@google.com>
Subject: [PATCH v5 27/68] selftests/lsm: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>
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
 tools/testing/selftests/lsm/common.c                 | 2 --
 tools/testing/selftests/lsm/lsm_get_self_attr_test.c | 2 --
 tools/testing/selftests/lsm/lsm_list_modules_test.c  | 2 --
 tools/testing/selftests/lsm/lsm_set_self_attr_test.c | 2 --
 4 files changed, 8 deletions(-)

diff --git a/tools/testing/selftests/lsm/common.c b/tools/testing/selftests=
/lsm/common.c
index 9ad258912646..1b18aac570f1 100644
--- a/tools/testing/selftests/lsm/common.c
+++ b/tools/testing/selftests/lsm/common.c
@@ -4,8 +4,6 @@
  *
  * Copyright =C2=A9 2023 Casey Schaufler <casey@schaufler-ca.com>
  */
-
-#define _GNU_SOURCE
 #include <linux/lsm.h>
 #include <fcntl.h>
 #include <string.h>
diff --git a/tools/testing/selftests/lsm/lsm_get_self_attr_test.c b/tools/t=
esting/selftests/lsm/lsm_get_self_attr_test.c
index df215e4aa63f..7465bde3f922 100644
--- a/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
+++ b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
@@ -5,8 +5,6 @@
  *
  * Copyright =C2=A9 2022 Casey Schaufler <casey@schaufler-ca.com>
  */
-
-#define _GNU_SOURCE
 #include <linux/lsm.h>
 #include <fcntl.h>
 #include <string.h>
diff --git a/tools/testing/selftests/lsm/lsm_list_modules_test.c b/tools/te=
sting/selftests/lsm/lsm_list_modules_test.c
index 06d24d4679a6..a6b44e25c21f 100644
--- a/tools/testing/selftests/lsm/lsm_list_modules_test.c
+++ b/tools/testing/selftests/lsm/lsm_list_modules_test.c
@@ -5,8 +5,6 @@
  *
  * Copyright =C2=A9 2022 Casey Schaufler <casey@schaufler-ca.com>
  */
-
-#define _GNU_SOURCE
 #include <linux/lsm.h>
 #include <string.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c b/tools/t=
esting/selftests/lsm/lsm_set_self_attr_test.c
index 66dec47e3ca3..110c6a07e74c 100644
--- a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
+++ b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
@@ -5,8 +5,6 @@
  *
  * Copyright =C2=A9 2022 Casey Schaufler <casey@schaufler-ca.com>
  */
-
-#define _GNU_SOURCE
 #include <linux/lsm.h>
 #include <string.h>
 #include <stdio.h>
--=20
2.45.1.288.g0e0cd299f1-goog


