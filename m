Return-Path: <bpf+bounces-26336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 526CF89E6FE
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 02:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1E4F1F22426
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 00:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C32638B;
	Wed, 10 Apr 2024 00:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqsxDPtk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5255137C
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 00:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712709716; cv=none; b=LvEQEDO7v4xrwMF5bAAy3UwEy409F7gs/lD6ZuT3eIwag0TYnq0lNcTWLwVGH1J5R2TPJKI/rCI8jfvV51OCWzd1GT5ji+QR9KhIaOq68sHhFil2/7v6s33pGs7i8CF/3VuYdkh51BeVIjUeJprNKvLuD6LvCW4gK3LRN3BYcrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712709716; c=relaxed/simple;
	bh=29qOc6LghBSz7WZZWaeUD3d3S+ibDFjpihPomV9jchw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tP+OPKNQ3Hzu6lA0ASNXFRxzrg+SKtyDZeDBW8dI3fmt3FlhPsUwOuaEA44PGD6+8Btx5dSVE/OhN9KkXpeq0csSmKvVUljFvbgRbN3Ppo1wNg1G5bOE1wtnpkST6wCFbmENRpPHFNWOR7OpBpd+KnLg+jybKlR2UPlUT0US3/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqsxDPtk; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c3aeef1385so3510532b6e.3
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2024 17:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712709714; x=1713314514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4TPi7rd0uhbNXFrTKzkRiARs1SALOVUwzlZf1+z4bZg=;
        b=KqsxDPtkUWEellQp+f/ifbKiz/oMMU2f2YpzBIzv+ii3pIQY0+zvCm2c8us+Q395c+
         JlquFQyH2RYUuXDtdigGOqKfi4dK4gde2mNmswneJTP/3n48CpUXA8kmxCgUyUappQqp
         tpWkkrpLYquP3Mt66Gjax0dDnf4zyW/gJSYgQUW+QRFs7sTqfM285EmNVuQkKW971BKp
         0k7B9FdZ+f7ph25HrDBjI3WPwyguYYUMer9Z9rplzdO+ph5k9mERKds9IeTHcDBn5OMf
         TCUVtIzINhYzOOcaNJ1IA7a4sbNR/bBihuqeXT1GLluhJ6NJpnjqhq7NPiMtGeaV2wF+
         L1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712709714; x=1713314514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4TPi7rd0uhbNXFrTKzkRiARs1SALOVUwzlZf1+z4bZg=;
        b=SBd7qsWRFoVTFwb4Bvu3772Jq8A5J2YvAuqp5tnmXFu/G8bJN8N7Cleps2Z6Nwc4YB
         tl6Pz/EOn1DJSwRmxuzkeCREmylGKft8V8Ipdsq6SlexmJ72e8iy8ye6sQCmsGTgNIzt
         wQnE0IBCvDAvAbkxPYcJo+gaZxIoKqGl16UKSLqSaGlazvm0WPEHyc8pmArWoAdVM55n
         WdT9uk+CpWx9gcrr4HhgGevRBH+UHbv7Mt9hgBE7LFUBQ0tUcuiuo850EZfcpGU1m8X+
         pN+sHcAOdCe/XkmgZARgvaNaCeDcilGpeIcUWHpYC6Eqxgwi+8gWBwWipfPaUpafjaho
         00Xw==
X-Gm-Message-State: AOJu0YxpIa8wlp8byBBNokQPYibZ9571KVMagb9I2TD+/snyuBdIvW/s
	4EYaCKCFb4KEbIdpsckVkb/BrC6P9ii6LqChNO5kUIpR/RmmGyzt9Ukg5diT
X-Google-Smtp-Source: AGHT+IFBTHQRrOBkaLSpVdXDEwNqqQ7fvLWlBaOvJu+KPWbgts+8Qjwovu8oADJEnLbi1GCuwJAqdQ==
X-Received: by 2002:a05:6808:2a4d:b0:3c5:ed02:8c64 with SMTP id fa13-20020a0568082a4d00b003c5ed028c64mr934847oib.2.1712709713920;
        Tue, 09 Apr 2024 17:41:53 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:d330:d0dc:41bd:be5b])
        by smtp.gmail.com with ESMTPSA id bf10-20020a056808190a00b003c5fbfe3ac3sm505124oib.21.2024.04.09.17.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 17:41:53 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next 00/11] Enable BPF programs to declare arrays of kptr, bpf_rb_root, and bpf_list_head.
Date: Tue,  9 Apr 2024 17:41:39 -0700
Message-Id: <20240410004150.2917641-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arrays of kptr, bpf_rb_root, and bpf_list_head didn't work as
global variables. This was due to these types being initialized and
verified in a special manner in the kernel. This patchset allows BPF
programs to declare arrays of kptr, bpf_rb_root, and bpf_list_head in
the global namespace.

The main change is to add "nelems" to btf_fields. The value of
"nelems" represents the number of elements in the array if a btf_field
represents an array. Otherwise, "nelem" will be 1. The verifier
verifies these types based on the information provided by the
btf_field.

The value of "size" will be the size of the entire array if a
btf_field represents an array. Dividing "size" by "nelems" gives the
size of an element. The value of "offset" will be the offset of the
beginning for an array. By putting this together, we can determine the
offset of each element in an array. For example,

    struct bpf_cpumask __kptr * global_mask_array[2];

the statement above indicates that there is an array containing two
kptr(s). The "size" specified in the corresponding 'btf_field' will be
"16" (the size of the array), and "nelems" will be "2". If the
"offset" of the 'btf_field' is 0xff00 from the beginning of the data
section, the first kptr is at 0xff00, and the second kptr is at
0xff08.

All arrays are flattened to get the value of "nelems". For example,

    struct bpf_cpumask __kptr * global_mask_array[2][3];

the above array will be flattened to a one dimension array having six
elements.

Kui-Feng Lee (11):
  bpf: Remove unnecessary checks on the offset of btf_field.
  bpf: Remove unnecessary call to btf_field_type_size().
  bpf: Add nelems to struct btf_field_info and btf_field.
  bpf: check_map_kptr_access() compute the offset from the reg state.
  bpf: initialize/free array of btf_field(s).
  bpf: Find btf_field with the knowledge of arrays.
  bpf: check_map_access() with the knowledge of arrays.
  bpf: Enable and verify btf_field arrays.
  selftests/bpf: Test global kptr arrays.
  selftests/bpf: Test global bpf_rb_root arrays.
  selftests/bpf: Test global bpf_list_head arrays.

 include/linux/bpf.h                           |   8 +
 kernel/bpf/btf.c                              |  29 +++-
 kernel/bpf/syscall.c                          |  58 ++++---
 kernel/bpf/verifier.c                         |  26 ++--
 .../selftests/bpf/prog_tests/cpumask.c        |   3 +
 .../selftests/bpf/prog_tests/linked_list.c    |   6 +
 .../testing/selftests/bpf/prog_tests/rbtree.c |  23 +++
 .../selftests/bpf/progs/cpumask_success.c     | 147 ++++++++++++++++++
 .../testing/selftests/bpf/progs/linked_list.c |  24 +++
 tools/testing/selftests/bpf/progs/rbtree.c    |  63 ++++++++
 10 files changed, 353 insertions(+), 34 deletions(-)

-- 
2.34.1


