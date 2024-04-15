Return-Path: <bpf+bounces-26754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B41CE8A4990
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 09:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC2F1F225DF
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 07:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1854E2C85C;
	Mon, 15 Apr 2024 07:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h1Or4cib"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3D9364A0
	for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 07:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713167926; cv=none; b=VBZARUTlsEVPgafcnPK9wzBWJoW7uZQ3FfZJkdn7oGcIEjov5UwkeX84uYOqz7IPSM6l2PECquQh83NxHhgQqDNfZOBuJoXfTLb39UudLoHXQUh1BRypE8epE+OT4QgVB42xShZhLj/WHMf+Zg9quOg64LL2Y1YBEEROK2bohFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713167926; c=relaxed/simple;
	bh=AaOEJmAesxHkCrpa7wm9hW8XplE/i3Ygw2sfhbRJ8i4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hyHOpNlVrb8RC4Vd0B6zZQxQLfrWBvTRVVNDwGq9VV0LdbKv2bnhHmTJj//yMyRGfYS6tt6EzFoJvgIFMWi5xckRY/Kzc5jk3bkde2eEG72Z5SGTmGQbBvzicrxXiC9FX7bjyjIb8UMP9pL0zQzno5SQO+Mjb/+OFNJeT45UwFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h1Or4cib; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-417c92b77e1so12550195e9.1
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 00:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713167923; x=1713772723; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fVltvWd3i2k+Cq0VFQS9D3dwHDvzmZCXT49WSh27v1A=;
        b=h1Or4cibs6nn2R2ZvezIzptQgkY9EGpSHiJp9+adrO7teA4JHW7zrKKV8IdrhT3TWj
         apvXujGg8z2N+kSOhSmQfJUYh24ItMGEppI64yaunJvB3kTJrgHa2fqPeEPewI8wA7IL
         PtlKg7XCK5ZIyjHuHYSNzmmO9BzZmXK3IwBhY6shJ1PujP9NaaP/n/NPk5PSoUArM2R1
         Bafpu1nvOskO2u0jyMmQ+sop3paMvpKndGrU47mlzNy8pSfEQwSyJnkG+Ij5vV1AuHjj
         1qFaWfJ8gQYyGJN6tJWijHVvejOa+azBn5+Z412YdDU3uf+88Em0edjLIlZEaXfOp/c3
         bDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713167923; x=1713772723;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fVltvWd3i2k+Cq0VFQS9D3dwHDvzmZCXT49WSh27v1A=;
        b=ijb9XK0cx+5FKWSsU7gCl83It1ztBc9aJOCGSMgXnz13YDphOycieDX5638Xq8FoEh
         ZvRkZwSRSXRRzONfjD6VzcLy4C1uYZ3ATsJe5g2pUjbctQD2xZ1pG642itPILLRUNRxr
         yI/WV8eo5BKLzepR9T6ReYpkL7WeGDu9p1F3RUhIryI2GnPnh9vmkyrlcCKJI+7tmJ1J
         nU5fPEh7LDxp6mwucZL4vDhG4dqyjwhx6Bp2FERvhL159ljswIg50v7Cv0S8DwFvwIFo
         pPn6uoPpsciO9W+FQhIJoa/xqU3pPrQbVNy616AYRjCJ6qg5e3Md70xsJqf2QGPHVn4B
         27vg==
X-Forwarded-Encrypted: i=1; AJvYcCUSO0rd0yExa1F+l0TWj3Fx5Ou49CJx/vYUJOC1s8Il+t53TDmyGhVzk8f1XGw1jLfct63mIH6xbgeBDiF3+BzpPcN1
X-Gm-Message-State: AOJu0YxrGTYD8/84Nb2pH5lehfF6dLpWPQaOgL5b7NjorbcDDpyoNRVN
	TdxKOacAa0nwGtGT/38WHIbNfJ0mnOj04mTpgEII3itwXB7DJzYgaEKQnqEb0WQzLQatWQ==
X-Google-Smtp-Source: AGHT+IGkWKcVCCQxlHp+FuowlJwsRPk61JubA1nRMZgo8wS592ZlQTbvD4F+g823HOmT3UKPLtn2m5Bh
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:35cf:b0:418:2b36:91a2 with SMTP id
 r15-20020a05600c35cf00b004182b3691a2mr211190wmq.3.1713167923708; Mon, 15 Apr
 2024 00:58:43 -0700 (PDT)
Date: Mon, 15 Apr 2024 09:58:38 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2069; i=ardb@kernel.org;
 h=from:subject; bh=wWpMCnM5h853IHZhxEFlnMrbX7tmMSr5ixfw0ic0NDc=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU3mnt45mb65d4MaoySjbwqwXNkyeU1ZTtSLab6rPy2L7
 FRr9JHqKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABM5PpeR4eAS+ScrZktfn/74
 lvsrznzJkPhwoe7Wu/om1bHvNy7+oMDwP8udm7/g6KoN4urM84x9Nx0r17d+dTvga3fijn7nhU9 yOQE=
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240415075837.2349766-5-ardb+git@google.com>
Subject: [PATCH v3 0/3] kbuild: Avoid weak external linkage where possible
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

 include/asm-generic/vmlinux.lds.h | 28 ++++++++++++++++++
 kernel/bpf/btf.c                  |  7 +++--
 kernel/bpf/sysfs_btf.c            |  6 ++--
 kernel/kallsyms.c                 |  6 ----
 kernel/kallsyms_internal.h        | 30 ++++++++------------
 kernel/ksysfs.c                   |  4 +--
 lib/buildid.c                     |  4 +--
 7 files changed, 52 insertions(+), 33 deletions(-)

-- 
2.44.0.683.g7961c838ac-goog


