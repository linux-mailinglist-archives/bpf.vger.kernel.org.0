Return-Path: <bpf+bounces-61422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC297AE6F3B
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 21:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1F63ABE9A
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 19:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14562E763C;
	Tue, 24 Jun 2025 19:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxFEIO86"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9117626CE17
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 19:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750792220; cv=none; b=HGNhPxsykYv50+n/5QHKlnzupc2dAjnBVGvzYqmVLUwvShioFySaWvajJjAgsevCjKiBSCj1ZUt2/XJ4B0n8X+6bmPpNzgGJgWNGCU/XVG0bp6xwRtkNtwDtkaAjkt9/yc2dsi/QsxmcSMTK/I8ddwUZ+R80MDwX4V8b3tTSGGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750792220; c=relaxed/simple;
	bh=bqaq/52d9OD/mO+3Kh9STVP5L6n9kRmmkQE35EirZf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SquMmIW+ytgT6eBZnK0nxz704vQxryxBGOEh9BgL+APYjJQwXqsDifldC+/h7rJtBDVdDi8lW7WRwdVC0HvXKuIAp8SOI3ZYf3OiG+odCs0c5UTFruX4d02d1BV09wyvQvtOA7KrKpOtbPc2YaDGSjkhOfuzjhlSzsiOl9h3emQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxFEIO86; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e819aa98e7aso817356276.2
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 12:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750792215; x=1751397015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GMu96dmqoXgf7fx8UyYzbGgEVFzqBMJJL4GLBC+G7Fc=;
        b=jxFEIO86qAKbApE90Msrp1wWogbts+uXo6s1/XGAX28afr6Iv8si1f62/hL0vK6UOk
         Cdj0DOkw7umuJRQAsy2zvabJJkv39kHZftEPh446NQ49jM5SYAItv5ZYbGNqs0S0MTgN
         nejh3xeKMzc4CpIAJ/0GLHmSLxrZLPXLGgzLMEHr7xhHVyTQPHm/Eed1KzoRAcntbWue
         rPm3WfrOMTv37X1/ApJP2MbzIpakWHXKM0QCifr1pKlISFAJCcT/M90Kwegekx/j8mo4
         2UVnF2Mh2y98cJG+y7dnQy+kVfn8rqAejwswKadcWeHrDmJDXgO53MKNWnLxgVboRwI8
         u+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750792215; x=1751397015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GMu96dmqoXgf7fx8UyYzbGgEVFzqBMJJL4GLBC+G7Fc=;
        b=Iewz8Vp/dkxGtYMdI4kcRszyyNQlBS2o5WXBNVc4NUBQ6QQLvCkAlxp6/mjvo8+4Qd
         8fae63W+n1bFlal3+nS/N5iwf5KNSCAqGRxoCJ2uDWcM5yyfXZBfDeMsMi9CP84G6OHb
         b3U6YQNqKQQzwn/xeV5iV8LLP3Ffm9PKBkiPmDs/OIQL2ZFID+k8hcYI5t1jgTCYTh8x
         TtWnT8lBcxK5JBXelf5Hm4uXuUH38TQ3/WliW5uzk/kMO+k+nSyImD5zIeiaGZED6i3R
         y/m1tnmjgxBIZykW06zs6z/ycPcmv2OrsfZgiujVYkgiXVE6KyeAPiysizH1vVM8ztZ1
         vyEA==
X-Gm-Message-State: AOJu0YwD03qXhc7TkLDaPwDKYBZwOQqJx+M+b5xN0yk32JGWWXr3b/XM
	A0xcraemuel9HPCDVcKgbJ2R71Ov+9WuhqSMok6YKTCA0vUBVVjbM/YsjrRkcF+O
X-Gm-Gg: ASbGncsyelrcQaVx0UiX+fubMaX5xRsleX2lM1He3qXh7DIRI5MOLohyAS++02NpsKS
	4Xch/dt6ejnxMcxjnDD8n0+GMYy4cAjVWlRS7h3QaWguOSn6mLObNfEKv010Tjxu25eXrRWwrL4
	Qu8Dly0BqkpRQD7EVdyLo+pzXgMmLW6QegmhYmMVtyPJ6IEr8iw7XrmD1UaFZnusPO/F5kQyHK7
	jSZYbj463f3cPAdH0io5FWpIY+c0y1cA0QNjG5/L+cPZXYBF74F24kvjmuAQSxsHP6bUD886/8P
	YPUY0dF738vs6XjuVuncXqpnEvQLLJUbDxhC5uW2ClxJfz0NHqLwDw==
X-Google-Smtp-Source: AGHT+IF8P9mD1Nce35w1SArJh2n1ZVeNqM6r69efIrEwy7ZkXv0hvkfebntQ7x4c5uvaHHDwEFyefQ==
X-Received: by 2002:a05:6902:2e09:b0:e81:8972:f1b5 with SMTP id 3f1490d57ef6-e842bd13653mr21779082276.37.1750792215284;
        Tue, 24 Jun 2025 12:10:15 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:54::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842ac93e78sm3214064276.38.2025.06.24.12.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 12:10:14 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v1 0/4] bpf: allow void* cast using bpf_rdonly_cast()
Date: Tue, 24 Jun 2025 12:10:05 -0700
Message-ID: <20250624191009.902874-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the moment pointers returned by bpf_rdonly_cast() have type
"pointer to btf id", and only casts to structure types are allowed.
Access to memory pointed to by returned pointers is done through
BPF_PROBE_{MEM,MEMSX} instructions and does not produce errors on
invalid memory access.

This patch-set extends bpf_rdonly_cast() to allow casts to an
equivalent of 'void *', effectively replacing bpf_probe_read_kernel()
calls in situations when access to individual bytes or integers is
necessary.

The mechanism was suggested and explored by Andrii Nakryiko in [1].

To help with detecting support for this feature 'enum bpf_features' is
added with intended usage like below:

  if (bpf_core_enum_value_exists(enum bpf_features,
                                 BPF_FEAT_RDONLY_CAST_TO_VOID))
    ...

[1] https://github.com/anakryiko/linux/tree/bpf-mem-cast

Eduard Zingerman (4):
  bpf: allow void* cast using bpf_rdonly_cast()
  bpf: add bpf_features enum
  selftests/bpf: allow tests from verifier.c not to drop CAP_SYS_ADMIN
  selftests/bpf: check operations on untrusted ro pointers to mem

 kernel/bpf/verifier.c                         |  79 ++++++++--
 .../selftests/bpf/prog_tests/verifier.c       |  19 ++-
 .../bpf/progs/verifier_mem_rdonly_untrusted.c | 136 ++++++++++++++++++
 3 files changed, 216 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_mem_rdonly_untrusted.c

-- 
2.47.1


