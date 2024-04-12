Return-Path: <bpf+bounces-26658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5188A379B
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 23:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE401F23C53
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 21:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A82153BC6;
	Fri, 12 Apr 2024 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiPlq98t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE61153505
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 21:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956100; cv=none; b=dowvXk46pYlEdTCwB1IzmUBwSYlN3hVai5Jthr4+9pZEeJPEQxvE8oECPA05tC4g0VfwGHYrzjE+lOBN87O8VVw6N+43LVBodN7AQL6M0e4PS05qOXlKv8RNPC9Osz5C3T2mkLtW/KuIFg9pgo8YGenaTQgIf+N3ouGBJjJe+Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956100; c=relaxed/simple;
	bh=dBiu0IhGg472VE2Lsb1pDHiKS2D2uNEMotB19dfCkWw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MtExtqJBMoE7IYuFigWIbypZg5tAdRMpYAVQzpt8E6GnS5NbSqd8+QstZyR4ZH0CZvqow1R9TsKEjlu28iIOfVQqOvq3oVTSP1mvB66nYAyNG9Sqs+gutAs7I6eF+yyThs2T1aNAAOfG8b0gH6t48k4ar2wEaprJ9caATBbvB3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TiPlq98t; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6ea1f98f3b9so762316a34.1
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 14:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712956097; x=1713560897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7U5piH3M/0hNHfuQLdJbmsjP3K/JxQ8ObvKpXTIpx70=;
        b=TiPlq98tc3tCCBcdRimebgZvTmEhozgRgcw5rR7/7TJg0w0AKEgJAr8jU+pnAVZUqn
         FNQILOV5aokg+biqT9TgzQDUZCgc7CbvPHacYlt7BaDWC13fNLAVEc7rDkXpd7vaDV55
         a8FX6ZXBm0m0IPHotz6cT7l/4XaUMh1TawX9U1wD2gX82k5w4KkKAVmoRoucZ+hajhlO
         n837J5AXr84F6e/RDq10G0dwDyatNgC6kzlxoL50FKBVs3gsEg3rDAh7VIUiTM3hTJ8b
         gjEzRVgCWIB/nOYsvHVZHNWCd9cakTMtjYXY0A+5FGZ82XnXEdfiF7qMDpVf4iMBDRu7
         LU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712956097; x=1713560897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7U5piH3M/0hNHfuQLdJbmsjP3K/JxQ8ObvKpXTIpx70=;
        b=LOKiOfC/2wBpF/2st+An1oMX3U3UIt/63iDcySX1x4z19jXiP3yDBnF8YI0rndRa1i
         qU7N1UomitrXrNQAMOCx3tEupT7hQI8TBpgcRCnaARoJWO3C/llsU8ulw54Em5K1/yck
         22Gx9mpd64PHMdI+2/fNlQThJLShI9gqP4UyX5dY495q1XPKivxeXIFLY0Qd/YmAr8lH
         44vanKejloXffc3tdybFfboUSNZFJK1b8s/Z2sOev0LUXj/bAz0RXuX6IW1Lv8oeYDtl
         M6k60rY5r2iTmziXPOpQcM9ZjW7LHAn3SIa6GHFrxatnjgGuD8QKcZZStee8JmzO+Tj3
         6zvQ==
X-Gm-Message-State: AOJu0YxTdZbiSMMVFIAkyuytPRrWKLncBPJSXXwEdt3MwImL1Egv4Sm4
	Z8AVpblO+5h8gRYApQKg8fRDYbHeoI+Y41P8zgii0N14o31kZ/9I/l216w==
X-Google-Smtp-Source: AGHT+IEzUZ+TeJTbUD/p4R4TCzrxRSEJk/z7ydM620SZQD2Bw2TIVQ90bn3NHVQlMk9B3SeKvV0YAw==
X-Received: by 2002:a05:6870:9627:b0:22e:e26e:73ad with SMTP id d39-20020a056870962700b0022ee26e73admr3643856oaq.58.1712956097522;
        Fri, 12 Apr 2024 14:08:17 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:a1a1:7d97:cada:fa46])
        by smtp.gmail.com with ESMTPSA id pk22-20020a056871d21600b002334685aedbsm1015117oac.11.2024.04.12.14.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 14:08:17 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 00/11] Enable BPF programs to declare arrays of kptr, bpf_rb_root, and bpf_list_head.
Date: Fri, 12 Apr 2024 14:08:03 -0700
Message-Id: <20240412210814.603377-1-thinker.li@gmail.com>
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

---
Changes from v1:

 - Move the check of element alignment out of btf_field_cmp() to
   btf_record_find().

 - Change the order of the previous patch 4 "bpf:
   check_map_kptr_access() compute the offset from the reg state" as
   the patch 7 now.

 - Reject BPF_RB_NODE and BPF_LIST_NODE with nelems > 1.

 - Rephrase the commit log of the patch "bpf: check_map_access() with
   the knowledge of arrays" to clarify the alignment on elements.

v1: https://lore.kernel.org/bpf/20240410004150.2917641-1-thinker.li@gmail.com/

Kui-Feng Lee (11):
  bpf: Remove unnecessary checks on the offset of btf_field.
  bpf: Remove unnecessary call to btf_field_type_size().
  bpf: Add nelems to struct btf_field_info and btf_field.
  bpf: initialize/free array of btf_field(s).
  bpf: Find btf_field with the knowledge of arrays.
  bpf: check_map_access() with the knowledge of arrays.
  bpf: check_map_kptr_access() compute the offset from the reg state.
  bpf: Enable and verify btf_field arrays.
  selftests/bpf: Test global kptr arrays.
  selftests/bpf: Test global bpf_rb_root arrays.
  selftests/bpf: Test global bpf_list_head arrays.

 include/linux/bpf.h                           |   8 +
 kernel/bpf/btf.c                              |  28 +++-
 kernel/bpf/syscall.c                          |  59 ++++---
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


