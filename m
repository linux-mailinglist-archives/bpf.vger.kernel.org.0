Return-Path: <bpf+bounces-30204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF1B8CB761
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 03:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 272721F213F7
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6365146D64;
	Wed, 22 May 2024 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P3UqdnQR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49A01474CD
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339632; cv=none; b=Sm8r1EjzDYjrBnexxVi+VzjSZbF1d0K5ZdeHkZZS1EvAs2p/0zu7Ay+7oaB+0apfjTo90+E2M3S4P3KhAbfeRpvoXbUCCl1vac5C2ZdnZG8JlNZ6CGw4TYTyGuaWSQ9dJyVVN8Xjx76K+tBaqjVoXdQckK8qS8dL3vUhFkSoTAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339632; c=relaxed/simple;
	bh=dvwJtXLo89BRunIsgfbX0Q3xKjn6Yo5orBzSPFtXyy8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cpo5Q0mj/wg9BRLdF7XDAcashOjF0e07nEy5JpsXLg2sjHnarHj6kRZmhAN09Frd3AiRTLh9DuIGAaAiIU1vTLx8yXS4+1IGkHkYTJiyJAn2pJHAi+QUvhhpegKCcH9aEqFzLhMzPMwohJvggvn4FLVViGQmcx75tFnrSDsyevU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P3UqdnQR; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1f31eadc3a7so1333835ad.1
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 18:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339630; x=1716944430; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XgrygNW8FFpQrXyNymzaa0urS9281wEmpt9DzZAFNUw=;
        b=P3UqdnQRfgOynmmjYRrF0zB/krSqkn+l35vukzrNoJbfnyE4MpaIhrL0Wltr+Bf1r1
         7ZSVHmFY08lE46qqNI5nzR2mx02ZV3d/qH92789QWEDbwTEiMHjB69yQpRvpn4mWZ8OI
         F0u3R2ES20XrOrsnAIq3/z1AN4rOilcXPA+6lHoKBz7h2J7YmQdtawKaMjmZk4XSQsgP
         gwVO7ZCI4hnVTTqdpzckkwJiQWA7GU4ylSu4DhS4agwXOH39cG9/TRNFrRQKZj1jmBHB
         gn8H+QdIuhXHz+IU4Y0xknVfjmG+ow9xCaWbJadDLrTO3dsx85KnuQBfyses7ImVFQfw
         EoIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339630; x=1716944430;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XgrygNW8FFpQrXyNymzaa0urS9281wEmpt9DzZAFNUw=;
        b=S4YL2Amg00Vzyp/6iNRi6T7gfX5KSHURxIW69DgJ90V7FiIMIjEZThLHAshyzyCN5r
         cusGZKsS726N01JnOhFZnVtpg+ET1Nh2tgypXS/6B2S/1okSbTe5l+GPkFOqh+jP0/Qf
         hJI7q/53OLCDCx25r8FbHEpQ0iwGNn3HNTNitqMmxQC1+asCIwGtyAVLdBMLvxtzmL1f
         /NqME2qIqPXwOIc4KFbflf1Q0oWU110fY7OLnMQw8CKXfdpom0NuGQuhZolR5aOeOyM4
         7Sxz7F2wuqRaH6IM38hCOWDXocVo4ZxxHsYL9otnstaC2oGy4UujQtcVDjTTrE/PAVkT
         tJqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpw+XSU7EzP1NGzEj6iQviojdynYNjnnXiWVTnE6FunPfwpMzNa92V6ruVwZEG/y/G7ETrW/RFgMRyqQISOGefdhTg
X-Gm-Message-State: AOJu0YwZmm1kPqSeEPKyjyPolu3y0f7pVuEzIyWnOJU2FJS7xFYJ1N9H
	v3wG1J/kEWCAdH4NGwwgu1VSUVsFBzYfdFZSC+10QI1ZB9tVbxpAaLj/uS3t1w1RLQ/OlelLz75
	VCw==
X-Google-Smtp-Source: AGHT+IGqHThcRUahWbcFDersReMiS//nm+v/RIRKei4uwQwaSYbb3yGxofUUHSGZKuMDuE2fmv9rxHnFGrE=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:d4c9:b0:1f3:317:50f3 with SMTP id
 d9443c01a7336-1f31c7f68f9mr273175ad.0.1716339630262; Tue, 21 May 2024
 18:00:30 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:07 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-22-edliaw@google.com>
Subject: [PATCH v5 21/68] selftests/futex: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/futex/functional/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index a392d0917b4e..f79f9bac7918 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 INCLUDES := -I../include -I../../ $(KHDR_INCLUDES)
-CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE -pthread $(INCLUDES) $(KHDR_INCLUDES)
+CFLAGS := $(CFLAGS) -g -O2 -Wall -pthread $(INCLUDES) $(KHDR_INCLUDES)
 LDLIBS := -lpthread -lrt
 
 LOCAL_HDRS := \
-- 
2.45.1.288.g0e0cd299f1-goog


