Return-Path: <bpf+bounces-29372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A728C1AE5
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEFB91F25128
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8570B134407;
	Fri, 10 May 2024 00:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vAdy8RqK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264A313342C
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299836; cv=none; b=Xfu9ux9ic7SwG3XLglyMqzZUAItd0kCNSMkLouD9NpSSSeZt/smwV8v2ae2ZEZrWUjy3tlI2nVcpRfJHh75l9yB1yx2JNIYv3RtXkXHYZDc4oYmUnnFMlQlTQklfQ/Lc7V67jYyKHHrNDnG2Gdo5nQz3kwWPY9/6DiOGWa1B634=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299836; c=relaxed/simple;
	bh=CgsUAoxPLiPX8UXSGEfYBMmnWIxR3wtc1giA2eIVBK4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pl7z44o3MIFhEppcj8xaK2tFmh/O7cZ3zjF8297WPf1JoS0y9MsGU3Vo5I3k/MaZBj1FNbMCMT7hgGAaaew0HXzZrjVtz82umsygBaMVIGVoxHjrwOc+PgvZmA31fFR+p/tA4owGKShqmsACJjGVsuwBb3QOVhdtA/2Gv4tpf+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vAdy8RqK; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1ecd9a80d84so19380905ad.0
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299832; x=1715904632; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YRD5r/wA6LFuHwfkjrFKP2eh4q2idhPkvQWQq1X7Wzo=;
        b=vAdy8RqKtA8cXge89/O9eEvRkV7lAN2DSHC+Ovo7RIJu7TqcajV4Ph8hYrALLfi0U3
         FolfHCtqg3ynsgB1EY59zlZIkKjYTrJS8MDH1n8fze3VLhACdXvUWhHrZIQkoFAd3Eic
         jxgl3Wq/CKMY4WdZBmcMpPqP++26e9g2d3BBbRVgmEmKtiBQBcfV0ivRVi2jcW0HvHAw
         Hqah7fKoJqPuSQbvuz6i3F/nlMB2id58nBMb86URfK9N1MTwAt7q5lYPcnN+Qe2DEmsj
         37ZPFKL1JZHnpSAgf+alogSdg2+LMu4gfGPgaD6aKRQjq1OBLZl3adiH0Z8AD5vFKMQr
         fZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299832; x=1715904632;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YRD5r/wA6LFuHwfkjrFKP2eh4q2idhPkvQWQq1X7Wzo=;
        b=jUT2mNObU+5yvHIgaICnFWeLSLJwtIHUqNM213leU9W+E6aLi+uiqCiZco1kB32oJe
         v+JiWW3hHRKHrAuGW7pW0NBhviMTLOQmuVxtcan+TeLfgYGgm/E7uq3qHi10xs1tT4uZ
         y3Hbmb3nnALgmRtL4l59lRzoHf89vURMtrwjpnxSGrheD/xE3Y3Bn46BwWxMDxlL2LuL
         mBRzP7Ac2Dkquz2AnrUqzXsBKaISvXsYOqMyXOqw58BvfdKzTNdpAViygTXTU6jEyY0+
         ruUTsqZbN2VI2Np9q3rxLthYaiJlRLfBYS27bO2+ygpYC9tJB++zSqikI5XyuX5Emsv+
         5X2w==
X-Forwarded-Encrypted: i=1; AJvYcCWeM1jW/fMDEL1wGkV3voKMhTm8udLilHn385aiYTStBOQLXtV7qzaS6bkvqFEzXXoR2nvBVmpyIPmFut5Upx4kjYFJ
X-Gm-Message-State: AOJu0YyApcYHAH5y1iPJPCE27DCJ6wmvXDnY5Rt9ILZuTdS1V8t27gfc
	OGAang96Mjpi3YZvOol8Ya9GbzTtK5NkO1+4qsGjPiKhQrcfBFlpLgtsdGJHClFVWNUxj1GJ+Hb
	jrQ==
X-Google-Smtp-Source: AGHT+IEDzJ9OdHaeOmAYQvvoFk5BGCHVLxfMsZPnMjHHpRLYJIvs9vIsDj5Z7+M16ZLAYicM/PHIiZdIM+s=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:854b:b0:1eb:f1fd:d481 with SMTP id
 d9443c01a7336-1eefa9e32dfmr121525ad.4.1715299832494; Thu, 09 May 2024
 17:10:32 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:48 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-32-edliaw@google.com>
Subject: [PATCH v4 31/66] selftests/mount: Drop define _GNU_SOURCE
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
 tools/testing/selftests/mount/nosymfollow-test.c          | 1 -
 tools/testing/selftests/mount/unprivileged-remount-test.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/testing/selftests/mount/nosymfollow-test.c b/tools/testing/selftests/mount/nosymfollow-test.c
index 650d6d80a1d2..285453750ffc 100644
--- a/tools/testing/selftests/mount/nosymfollow-test.c
+++ b/tools/testing/selftests/mount/nosymfollow-test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <limits.h>
diff --git a/tools/testing/selftests/mount/unprivileged-remount-test.c b/tools/testing/selftests/mount/unprivileged-remount-test.c
index d2917054fe3a..daffcf5c2f6d 100644
--- a/tools/testing/selftests/mount/unprivileged-remount-test.c
+++ b/tools/testing/selftests/mount/unprivileged-remount-test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 #include <stdio.h>
 #include <errno.h>
-- 
2.45.0.118.g7fe29c98d7-goog


