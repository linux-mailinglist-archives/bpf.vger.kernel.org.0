Return-Path: <bpf+bounces-26296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A2989DD96
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 17:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497401C22AF0
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 15:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339E213175F;
	Tue,  9 Apr 2024 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DoVWC4q2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F51130A63
	for <bpf@vger.kernel.org>; Tue,  9 Apr 2024 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674903; cv=none; b=Jj++fu2qO95SlhtPXQgWYWX7xduh8KFBTUp5w008qqi14SOYoysG2R2UbUyBXJGVcZGdj/+3Po8nJRNMiS+a7Nog6YTTiNkYrPubXXHPYL3TqNNUJcGd8vQagNXL9mVdKeI5+UMhwXFi4gV/e1gVOmzlJNqNEnp8p4gv/xeP6LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674903; c=relaxed/simple;
	bh=alFFKiP7O8OXDXrwrinQEc5sBVduOBPmxmITpEnO00Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rVXd16NsietpQjdZBjUp62AsNtqromrhmn2lSbSMQZL8rZtimKmsv0BVT5qZZLxBUbM4XWZfj8Dv3btbI2fOOAarP3urbPcBkQt/+cQz2qWADXRR5xt0aKXj75EQVZLlhbERQps/5lMlsA/ZymrT7giMhbKT6RNAC/HYin1WlsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DoVWC4q2; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-343e46df264so2333448f8f.1
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2024 08:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712674900; x=1713279700; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tfocfhDuzyWI0gzZPzgtgcqFin70HaxvYji+27WTX8o=;
        b=DoVWC4q2NOqBhhc41O2uVHSuJ/yMC5YkEeJOHGGzWx+TO7zr9ViDNe+rAlG+wdndQk
         nJCske8OCx5PxFjoP1GZoPORoE1KZu1dBdf6b53iYN8ESZBuuokmG+7VSAwiSfZO+cUW
         9oUbnNnzzaGh18ayAzLd0NAMcRGV8TSlriXGpE2FWtoc3Q8UEa/NrMj+HZRGp3QGEgA6
         KBECNGU4vzu8L44TIJFLbscw0GmdkWRZ1qOr0BzoguYZ6IGD7Fqz3wZLTQVMiU5GoJ04
         VS6GskQOf00uHpsR0vAgBzPRCuSKZ1VgQtA5CuT6GequamaGwANBwc+ZTlXl9Wxxwo57
         ArmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712674900; x=1713279700;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tfocfhDuzyWI0gzZPzgtgcqFin70HaxvYji+27WTX8o=;
        b=TyuBm877rtpmnQqAcHTNE/JWTUCI/pQPbFbcx0OrzmzBFHEw+Y99YZYE9XM6B/uLlw
         vifOus7lc75/njkF0+tDg/C1ay1nZjDaAXnvCcJ/t0fTVzrVaQG1HuLF7qktLJBM1qYX
         8Etdlhh9BpwwYnlVOiYuCrZNki57zIYRCgNRj+TXyNoGGSsGK0f5/q+cK87GqF8vemaJ
         vHauT06EACxSRutrxD4Hz3OOc70p6X/0ssTd5RirBETDecq1LK90xaJf31IHGI49iHgU
         IoTwD+1GT4LsX7WFfKH4M48HR82ZFCqXTgmE9xVPI5fFevf4QyC9rZFZTD5F3f7NOnkf
         sOWg==
X-Forwarded-Encrypted: i=1; AJvYcCXVQ4vVfzOHu8uFhxFxauuUC6POYHQZTW2UYZoHbCRcuDcQlHL91vWxoCteiS8wj4FMahdGEoxqKFhFa5+NfV0ZOb19
X-Gm-Message-State: AOJu0YyiPISTlH1bvvt83Aowm+RdgocJ0LW5rmNXI6uSAP3qdoVtLj4n
	lUmWyxPii4bEvJWmumBPaLgu3MTSDJSY/qpZ/Zn9U9Ax6ZUuKSGQ5hflZruVUXvRL9wS4g==
X-Google-Smtp-Source: AGHT+IFYuevMhVCNS8J4a0W+Y4P/tX4ObfbT6n8GZHMYJQGV+TZpStj+eAbIHkNNPAqkAizanpcTzDes
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:adf:fcd0:0:b0:343:3f5b:8be5 with SMTP id
 f16-20020adffcd0000000b003433f5b8be5mr25778wrs.5.1712674900036; Tue, 09 Apr
 2024 08:01:40 -0700 (PDT)
Date: Tue,  9 Apr 2024 17:01:33 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1943; i=ardb@kernel.org;
 h=from:subject; bh=vvI7uP53jbbpjHBqTcIzGIhjjZ2G0+4ci+o39TUrohg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU00wkfJaMX8/7u/nL26uVyuuT46dDI7j0x7Ta/W0beLi
 zK9y9w6SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwESS9jP8L0m8H9OefeJLbG/7
 hGtcCW9eBda5aPCvW5W/wpw9al/8R0aG+zYX6vKnHOW6oeDcYh3n9k9mXqGwfnv4p0ifvsL85FN MAA==
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240409150132.4097042-5-ardb+git@google.com>
Subject: [PATCH v2 0/3] kbuild: Avoid weak external linkage where possible
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Martin KaFai Lau <martin.lau@linux.dev>, linux-arch@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>
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

Ard Biesheuvel (3):
  kallsyms: Avoid weak references for kallsyms symbols
  vmlinux: Avoid weak reference to notes section
  btf: Avoid weak external references

 include/asm-generic/vmlinux.lds.h | 28 ++++++++++++++++++
 kernel/bpf/btf.c                  |  4 +--
 kernel/bpf/sysfs_btf.c            |  6 ++--
 kernel/kallsyms.c                 |  6 ----
 kernel/kallsyms_internal.h        | 30 ++++++++------------
 kernel/ksysfs.c                   |  4 +--
 lib/buildid.c                     |  4 +--
 7 files changed, 49 insertions(+), 33 deletions(-)

-- 
2.44.0.478.gd926399ef9-goog


