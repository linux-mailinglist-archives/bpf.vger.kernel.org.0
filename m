Return-Path: <bpf+bounces-29367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A71DE8C1ACA
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C5CA2834D7
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E263A12FB36;
	Fri, 10 May 2024 00:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ECzZeLfH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B765A12FB03
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299818; cv=none; b=mBpNKhxaoA7FEsscrw3AbI2OzKhj/tQ3vidzi7CSNmh8g8RYtCbi4jlpa7CTGuC80Jsm72qURWT77uOAN1MGzR/VR3RVeSufl/fSfpMU0F7ge8iKnvzsNXs8Gbf4GX/FoSNZUy4BoW9txXhP/3vkFOy9Te4bEAcreBizwnSF37o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299818; c=relaxed/simple;
	bh=krFmheiwe+bhOpalC+42tJGQSEuBBbvPVyXoXXo7LPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D1Fqdgic7prPIYXBA0l1OPrKeVliYWWoBAGKFVlnIlRVNqbHOsI1pnXe3MMikYXBF5XUxE2T0nLJWCrnl/7aiFVZ41zd1vrCKonaCAXVWbUuIye+QArVO/x45f/K25ByByLPRR05jdY1gBo6QINp2ZkwfSRjT6n+v3FFV0+Eoyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ECzZeLfH; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b58c1d014bso1242260a91.1
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299816; x=1715904616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tCYOcoi79dGlWA0zgP2ejSPuqCPcThdX6+6Ym86nj5Q=;
        b=ECzZeLfH6bdfyaVt7HV23vNvjRtthWaR5rDSkD3q1suoOqMzuTM1FueqdSA+Xgp0/s
         rO02TowQpqWRjgyB1N7T/ICLXzlRjN0By/hpqcSf6QuUQzoZevmjwcS5BndovKq0cYxu
         8shDH7iadoXHmsBdaO7JbU4ssdlt4wgLHvnsuMxMNWo/a13hxX1ZxaDYazkfT/Xe13N3
         bAPfHtrGMwrizC43hc5xTtB0POOdbS2Jam2PF+BnAbR2BJNhoMnrL6cWiyBdrf2DhDmK
         5unsR/qJVuHB92PsHHgxfTGpKYmoQwfKNF2qCtrwtv9klvusduBRvkbZw8OZO8ukUOiB
         oVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299816; x=1715904616;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tCYOcoi79dGlWA0zgP2ejSPuqCPcThdX6+6Ym86nj5Q=;
        b=GwCjpndaWndiXGvOd6xx/MvbgZ7MEg0sMok/OBKtoV0go3E26RfoIgj5GhNE5Ar8Dr
         JcQridb6J9+qU71HNgRNi+ozwdA8qq1mZfLAqPCwduW5BIT5/pvbK8TFIS/fJWv/70no
         Kt+Q6UzsgvK8Iw2H3yRd2JUGuvcMbnbZQk1wr8ALvAHeLm5u2IunRvPnAJhquaMI4YNe
         ujb9Ilgt51Hu6yhkctVooa6+XStJVcdPjqckpnDh60UEylZdrJLfGeuVLsa/9MJkMBdR
         catnU4NADF0q7HTE0tf3i9Wnv4cqEEmVSsYomv+UhzxAeerDbn38Vj7yLre204Zo3jVE
         /2mw==
X-Forwarded-Encrypted: i=1; AJvYcCUsR8Tt0CV8mzmABJreYSQ8EZuk61E++8A6bAunC4qkJ992gkaysMrz3q8IE0pIpYUgZ+0W4mV3Z5S+lqlxyFh19/s6
X-Gm-Message-State: AOJu0Yw+kdz9CsE2akyCOSbkEqorOkgZcwXH7uK/glCerDSS+M5S+R8i
	KfxZALSUudgNYaZVKhWUyp9rABX689QHwDVPg5bqZYJE0hHW45H2lEkDUYTJBARcwtAdlNk7Ux1
	RCw==
X-Google-Smtp-Source: AGHT+IF9aZrvH9iVwela8h8gnuxSKtgNwX9HeGP3w0cBXhyQMMnBKIlrQWbDb+A4TrctySesXZTy2+mRcOk=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90b:1850:b0:2b6:208f:a441 with SMTP id
 98e67ed59e1d1-2b6ccd85d53mr3578a91.7.1715299816087; Thu, 09 May 2024 17:10:16
 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:43 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-27-edliaw@google.com>
Subject: [PATCH v4 26/66] selftests/lsm: Drop define _GNU_SOURCE
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
2.45.0.118.g7fe29c98d7-goog


