Return-Path: <bpf+bounces-22467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EF985EC1A
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 23:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277281F247F2
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 22:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93197FBC2;
	Wed, 21 Feb 2024 22:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTYOyMz1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC645232
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 22:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708556357; cv=none; b=FXFt5zZphxptAdCh6erkCcCjWFT4r5sew7MlIx6a29/Rf5oK4imYT7dnPaSuDkGi7eziKWVNnYlznjAJaBMvxkoPttB9QKhaCMoeVnnpd7DnRkU8qMacpQBHh5FlcgMmu5fgvIgmFB/msSzxOlkBTdv9yevlftJUHpGkY+KEvcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708556357; c=relaxed/simple;
	bh=EoF7uIhcEXX9pabP8z91gMAsYYKMJqiXzoW7J0nrxhE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jpCW1PMWNYkj19zsU+NUH75jzj1fDRgSHNpVx4BqYAZoBOIyqwM0X2hHqLoRjHamPSp0WiWdSYmJ0fHc3WBJPZSCu3kY/bFwwpCxuZEdaDWJqIhKQvq2k5YHiWVv1L6+EBTugbJwKKxgl79USMTeQQ14xHDdOVmDsJVm8MUQ768=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTYOyMz1; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6089365e554so6809957b3.1
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 14:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708556354; x=1709161154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AczTUjKSft50HMf0YK95szXpYdd+0mMAF2SbRQWztAo=;
        b=FTYOyMz1ndylYTp4MXH8DiUUioMK7yRAKYvC6x7dB1kpcJC11LU+CLlMeFUMSNecE+
         n1+PKQBsP2052HLExhdypHq8AOupRM5zyVwN9DlbQiziZ53+2pGmbm78SIdI9AnqFJhv
         SoOIYnGurJ/c+ICJoUnpbrHKn/hJJWBjAY/+1v9iwdLYP679gGIkeTtC+AkJxhxtVv6M
         BM+0IioJhe1ppMdVMEAY9NoPamMVqhRg5/Q781H1MEeVdaZXH+XkKChIuhwQzrAuzSKt
         sowhT3U5PNskrZaPtKccMs0za3qt8Si1Q+BjrZISCBKvwJxrDNflTOGO6V+5WBpNTvcu
         enYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708556354; x=1709161154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AczTUjKSft50HMf0YK95szXpYdd+0mMAF2SbRQWztAo=;
        b=uKFBwpvzKyezDZt1VxHUYhnpYWo9EEjqmC2VQ9Yqo+tEKFuo8MKV5lnTcqnNq/t6nj
         RwXbp+s9vfUHkPg/9mPhrvKZpe9e06YElDCT5c2/irlFkGXEi+e7dhByel3c8YydC7t1
         rRYoIlZ8mtywq2JIPygPomFGQlmvj8DWJVOqHkJmiqXNNTh/wo9pJYsY7h0iOBV3Q5U+
         X3ZOoMrbhuwAWCBySh4d1If6Z6SnPR9HjDnWQql+Vznfy24Vw78jRAp/1ykW60/hunZN
         +B9nulExj6LtCV23iuYODn0ra36vLwDdFJBvBd3fdBXKap5i6wxmdC7kasmi+mM9Hgf0
         I3MA==
X-Gm-Message-State: AOJu0YzvTNZT0xLUHMN2UJvUTnGlIqC4o2TxV4yPo8nFRBvOvkCzuE2v
	v9+ghmc3Hv+2FnnVSL3CnzerE7zEyoiV3zd2tS2y8qDifsX8w6xCKQAJJDJx
X-Google-Smtp-Source: AGHT+IHWtFYUzrvU5OnmVCZixQCT+MbErYhQfxDurSesQZmpoHFZMXHI2UykK/mua7vTIOASQLZpvg==
X-Received: by 2002:a81:8d04:0:b0:608:3cb0:4c97 with SMTP id d4-20020a818d04000000b006083cb04c97mr10526551ywg.21.1708556354187;
        Wed, 21 Feb 2024 14:59:14 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:bc3b:b762:a625:955f])
        by smtp.gmail.com with ESMTPSA id s67-20020a0de946000000b006078c48a265sm2820090ywe.6.2024.02.21.14.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 14:59:13 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v2 0/3] Allow struct_ops maps with a large number of programs
Date: Wed, 21 Feb 2024 14:59:08 -0800
Message-Id: <20240221225911.757861-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

The BPF struct_ops previously only allowed for one page to be used for
the trampolines of all links in a map. However, we have recently run
out of space due to the large number of BPF program links. By
allocating additional pages when we exhaust an existing page, we can
accommodate more links in a single map.

The variable st_map->image has been changed to st_map->image_pages,
and its type has been changed to an array of pointers to buffers of
PAGE_SIZE. The array is dynamically resized and additional pages are
allocated when all existing pages are exhausted.

The test case loads a struct_ops maps having 40 programs. Their
trampolines takes about 6.6k+ bytes over 1.5 pages on x86.

Kui-Feng Lee (3):
  bpf, net: validate struct_ops when updating value.
  bpf: struct_ops supports more than one page for trampolines.
  selftests/bpf: Test struct_ops maps with a large number of program
    links.

 kernel/bpf/bpf_struct_ops.c                   | 123 ++++++++++++------
 net/ipv4/tcp_cong.c                           |   6 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  44 +++++++
 .../prog_tests/test_struct_ops_multi_pages.c  |  31 +++++
 .../bpf/progs/struct_ops_multi_pages.c        | 102 +++++++++++++++
 5 files changed, 263 insertions(+), 43 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_pages.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_multi_pages.c

-- 
2.34.1


