Return-Path: <bpf+bounces-26838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6E08A578D
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 18:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1749BB221F0
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 16:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1619B8002A;
	Mon, 15 Apr 2024 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ksiS3hF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4696F7F7FD
	for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198050; cv=none; b=gVuBlDYLFWLfBdwDLt6t870Dvuzno7r8Shh/51dHyiQYXzP8zBJygD1RQq8Ev/wtgbwLgFv9BfPr+BTJ9nxdUy4ktVKF+CmYRanSl/8dFSuuEaF/DDQEVQgQNY8bXG04kI9Zbt3iL2XJ/QDxdnckqlRmDGTUHNxeCV3uZRlaIyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198050; c=relaxed/simple;
	bh=1zoC3bi6KaCU5EtJaBkjNbuqfFNt91Wb7VubIJIcaL4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ie15IjJV8oc4SGlLZKykUAvuHWFyMlTDNjNuVF9oNX9nY68veVdd5V4ZMj5ng7POmgaIBumfPE2pnNldLknueVtb4jSdegqoOUfvV7mUwVo/WYGQ/WaQRLV5cKX+BRPDPBcFEg4CdnUtxA9olJRrE9nhTU8RV7U9OoKYk62qVY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ksiS3hF; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc647f65573so6308881276.2
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 09:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713198048; x=1713802848; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K1arzZzM3WsRaUONp1y4sZyDHfuKJUnHI7TXwDMLR4c=;
        b=3ksiS3hFsRJ9BBIMV4+o6RVlKQIJ6NUbu0WMBxwffPlJkbzZ+Ks7hUwfFbtO+Q5bHf
         5cwea4zJ/IMv4UMgyUkj9Px5fSZlgyJy9V9MbssZTPrDdvwg2SF9gqBjdhaNAPoHGKfU
         0gKkNEyF11UiZL+yKd2sxxHmcvr2JnJZLo7jEzsIW8A6WcO6blY/B5mioHMSfzCrrkyZ
         kQ8UDmwV7dRDJjxEH29PF1LosROWjmAZj2mXmRr/sh6obNifsW0+VMX5s8pTxC/FDKV6
         v7ExDIJ9jZxQjSYYXmGDVdZJPACV4oXQmJAiws/goSvhPBWMCWwSUT5Ng4zXOZV7izAp
         a5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713198048; x=1713802848;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K1arzZzM3WsRaUONp1y4sZyDHfuKJUnHI7TXwDMLR4c=;
        b=dTsi37T58BLcZscsbizk1fevRmvsAUU8OIlPsZmU7bDhQyHVsRSypjQPdQTrrHF2N+
         +wZB7tdh5FPqZAp6ialZZVfDTGj3fa27vHwObXLMn2CZhI+c+b74mgBNNGTMbvzMpv+G
         X/+ikTXr0Elpd17G0wIBbKJobWSwWM/HFXtFgnYk8vSeE1RSahNg3WgZJkKK6Xf8zD4+
         A99LbQ6qH6Zll+w0HhP24Yps0wBWQDvcBwezfqz5CiAeZHQvHojVCesCRT4stCNb5zUD
         ANxdXV7s78RI6L/WNd/rwKoC1XZHElxtn7iDNQdMzpw92f/srd97M+lMDVJfDls5ePgB
         V4fw==
X-Forwarded-Encrypted: i=1; AJvYcCXPGeXKaF7G8sOvX+R6FO+TRRaKp3khkhs+iuhx9F00AxN7eeZF7m5hgaVzRDrNegAzXs0GDEzuzdOjIcaMVxCYQ8Ct
X-Gm-Message-State: AOJu0YzGDADMn4dl5h6TPiVUw8iYv+Z7LxISx0hCwoTOLqHF+LYc8/5x
	clVRhmXLWiMkn/bXz24Y4JUHjBQfegcA7D1XhQ72bhebqBbkLDDWA/ngEtJ0xruDMCPWqg==
X-Google-Smtp-Source: AGHT+IG5K9apYfcWPZPtdIptSJfI/lmV9B4/LFJ2tYhX7R87dpX23NOUKwOmR1jcniTv1WDXWCZcH4k5
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1009:b0:de0:ecc6:139c with SMTP id
 w9-20020a056902100900b00de0ecc6139cmr3152952ybt.11.1713198048326; Mon, 15 Apr
 2024 09:20:48 -0700 (PDT)
Date: Mon, 15 Apr 2024 18:20:42 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2166; i=ardb@kernel.org;
 h=from:subject; bh=X8zyn046NSpabQR5ICGmu6GxwA3wTXrOLB9VrAXNWLE=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU02+NbiXGuF+9VW9377aD66Imx21S5X4aDGWr1F1zf+X
 nueJzu2o5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEwk+y8jw0ZLI8Yrp1z3srH+
 fZ+zdbHNnKg1Pv5TTqacPywsEPvedQ4jQ0tsQ8U+jnq2b0dLn2hb9btWLPseXlXAobb41OzUdtP vLAA=
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240415162041.2491523-5-ardb+git@google.com>
Subject: [PATCH v4 0/3] kbuild: Avoid weak external linkage where possible
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Martin KaFai Lau <martin.lau@linux.dev>, linux-arch@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Weak external linkage is intended for cases where a symbol reference
can remain unsatisfied in the final link. Taking the address of such a
symbol should yield NULL if the reference was not satisfied.

Given that ordinary RIP or PC relative references cannot produce NULL,
some kind of indirection is always needed in such cases, and in position
independent code, this results in a GOT entry. In ordinary code, it is
arch specific but amounts to the same thing.

While unavoidable in some cases, weak references are currently also used
to declare symbols that are always defined in the final link, but not in
the first linker pass. This means we end up with worse codegen for no
good reason. So let's clean this up, by providing preliminary
definitions that are only used as a fallback.

Changes since v3:
- drop unnecessary preliminary definitions for BTF start/stop
- add Jiri's ack

Changes since v2:
- fix build issue in patch #3 reported by Jiri
- add Arnd's acks

Changes since v1:
- update second occurrence of BTF start/end markers
- drop NULL check of __start_BTF[] which is no longer meaningful
- avoid the preliminary BTF symbols if CONFIG_DEBUG_INFO_BTF is not set
- add Andrii's ack to patch #3
- patches #1 and #2 unchanged

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: linux-arch@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>

Ard Biesheuvel (3):
  kallsyms: Avoid weak references for kallsyms symbols
  vmlinux: Avoid weak reference to notes section
  btf: Avoid weak external references

 include/asm-generic/vmlinux.lds.h | 19 +++++++++++++
 kernel/bpf/btf.c                  |  7 +++--
 kernel/bpf/sysfs_btf.c            |  6 ++--
 kernel/kallsyms.c                 |  6 ----
 kernel/kallsyms_internal.h        | 30 ++++++++------------
 kernel/ksysfs.c                   |  4 +--
 lib/buildid.c                     |  4 +--
 7 files changed, 43 insertions(+), 33 deletions(-)

-- 
2.44.0.683.g7961c838ac-goog


