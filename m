Return-Path: <bpf+bounces-22530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B328605A5
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 23:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F641C21464
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 22:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8B4131722;
	Thu, 22 Feb 2024 22:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWeI5TMn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1C31DA22
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 22:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708640790; cv=none; b=UY7oOBnZWwi45MxdYrwy8tzfpcmzZ+6Y17bgQIuscM7fvg7q4LHpW5rQ3qPsZZg9TxOpnOEqdWuUFwzgmX+2GZGn3W7vjW9Sxfces4hT14IQttwh0Qs0mQzTZvqcwrlAwZafxSlBBXLdGg9XFG3pqbkMbdREx7KVhnMz0ViVdao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708640790; c=relaxed/simple;
	bh=jIMazotd9o/C58ocgkQdxMBuE97EZirWeIQ4wSe8S8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=INZB5ARivodjLjU+TNIXlZyhX3pwRxnmsOUohEP6mdAus1V9c3C0o7aYLCm3luJlXWSR+P3i0BETmGj56M9uN040HkRZxBePWvUl0QxsJYU8x3IsnQZJzNnmFBo6DT0ONbKKhlst+YQl6IDj/AveWxV4mc4C5li8t6qn2cglV/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWeI5TMn; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-608a1deb6d4so2686267b3.0
        for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 14:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708640788; x=1709245588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VcFclr5WEKAbbVB3L0zml1lsm/R+EqnOEaH/qAEmXcU=;
        b=lWeI5TMnnaf0zIqNii01WCIjlwYeTfF/609j4rNR2x8jIwQW/9+3jbwEviG8BTreHu
         o8e+kHG2azUdkc2ci8BfONN9Qnc2AGmHgrCV84wnNUGVWLV1XGOxBEK0xbcdX9DFRNSz
         8rQ6cps+ivVkKJuUXI2HVyOe0ET1ffqQSuojIYcWN2t+7OZ5Uf5h0HnRt5VKmcilXjb1
         hHS5BMgvLmKKoEluda63pOVjzIy6dlTn8EvSA4iZtMSOAEWWRRqVJ3+UThegU5/Nm3aA
         OQ20qfJU1lAWBVNvH1YgkbHfn5evvSUVl1JQmQwIJNazPEB2oeG8j8dEUb6FC00rgW1H
         dAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708640788; x=1709245588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VcFclr5WEKAbbVB3L0zml1lsm/R+EqnOEaH/qAEmXcU=;
        b=L7WYvWgdFZygUC0W/ObTfQNT01jkpdyp5gPew/FwTQdgsx5MzzCfSI77ibscGleziY
         +xsjo2Wm3sQPnG0svASMaTbdRRva1ln24deOGAFtWDQYS7VXtVhrGF8Wp/0VPW9OIHyx
         QhLC2t1wwXYW/vd1EhSfA1+BH9/v9WEn/lQoug7B/db1FjQEWST7zVXBEm58mlH+ovRv
         J69rW8dhGAV10S3qIuQ3WRqm6iI8yjqqBax0QdXDSWB5wYAYsTjV/KYuzmPznge0JKfP
         DrLQ/KgT/kD8NXOJX6dTJYpboKExI3a46+a6C1Pr27pqGJa8oESzZDOpSe3LEzI5FmN5
         V2Jg==
X-Gm-Message-State: AOJu0YzuNyVkxWp9vvSZVsd9t593TYlKdTyf4UK9u6DQtI2K/wPrprL5
	85oFrkJEJyI1pOZolxO+kjF0CSywEEmlU9OrbBqbkJxH0Nr0v/wh7im/9Go4
X-Google-Smtp-Source: AGHT+IHX3K9F7/WylGJoCiYoBQAvX5g6jr5T6evCaWjuSzLIblImGMSGbTkBhkGwR3U0Mq8sbnG//w==
X-Received: by 2002:a0d:cb48:0:b0:607:775b:f041 with SMTP id n69-20020a0dcb48000000b00607775bf041mr615137ywd.0.1708640787535;
        Thu, 22 Feb 2024 14:26:27 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:34d2:7236:710a:117c])
        by smtp.gmail.com with ESMTPSA id e129-20020a0df587000000b00604a2e45cf2sm3280666ywf.140.2024.02.22.14.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 14:26:27 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	quentin@isovalent.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v4 0/6] Create shadow types for struct_ops maps in skeletons
Date: Thu, 22 Feb 2024 14:26:18 -0800
Message-Id: <20240222222624.1163754-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

This patchset allows skeleton users to change the values of the fields
in struct_ops maps at runtime. It will create a shadow type pointer in
a skeleton for each struct_ops map, allowing users to access the
values of fields through these pointers. For instance, if there is an
integer field named "FOO" in a struct_ops map called "testmap", you
can access the value of "FOO" in this way.


    skel->struct_ops.testmap->FOO = 13;

With this feature, the users can pass flags or other data along with
the map from the user space to the kernel without creating separate
struct_ops map for different values in BPF.

== Shadow Type ==

The shadow type of a struct_ops map is a variant of the original
struct type of the map. The code generator translates each field in
the original struct type to a field in the shadow type. The type of a
field in the shadow type may not be the same as the corresponding
field in the original struct type. For example, modifiers like
volatile, const, etc., are removed from the fields in a shadow
type. Function pointers are translated to pointers of struct
bpf_program.

Currently, only scalar types and function pointers are
supported. Fields belonging to structs, unions, non-function pointers,
arrays, or other types are not supported. For those unsupported
fields, they are converted to arrays of characters to preserve their
space within the original struct type.

The padding between consecutive fields is handled by padding fields
(__padding_*). This helps to maintain the memory layout consistent
with the original struct_type.

Here is an example of shadow types.
The origin struct type of a struct_ops map is

    struct bpf_testmod_ops {
    	int (*test_1)(void);
    	void (*test_2)(int a, int b);
    	/* Used to test nullable arguments. */
    	int (*test_maybe_null)(int dummy, struct task_struct *task);
    
    	/* The following fields are used to test shadow copies. */
    	char onebyte;
    	struct {
    		int a;
    		int b;
    	} unsupported;
    	int data;
    };

The struct_ops map, named testmod_1, of this type will be translated
to a pointer in the shadow type.

    struct {
    	struct {
    		const struct bpf_program *test_1;
    		const struct bpf_program *test_2;
    		const struct bpf_program *test_maybe_null;
    		char onebyte;
    		char __padding_3[3];
    		char __padding_4[8];
    		int data;
    	} *testmod_1;
    } struct_ops;



== Convert st_ops->data to Shadow Type ==

libbpf converts st_ops->data to the format of the shadow type for each
struct_ops map. This means that the bytes where function pointers are
located are converted to the values of the pointers of struct
bpf_program. The fields of other types are kept as they were.

Libbpf will synchronize the pointers of struct bpf_program with
st_ops->progs[] so that users can change function pointers
(bpf_program) before loading the map.


---
Changes from v3:

 - Add comment to avoid people from removing resolve_func_ptr() from
   libbpf_internal.h

 - Fix commit logs and comments.

 - Add an example about using the pointers of shadow types
   for struct_ops maps to bpftool-gen.8.

v3: https://lore.kernel.org/all/20240221012329.1387275-1-thinker.li@gmail.com/
v2: https://lore.kernel.org/all/20240214020836.1845354-1-thinker.li@gmail.com/
v1: https://lore.kernel.org/all/20240124224130.859921-1-thinker.li@gmail.com/

Kui-Feng Lee (6):
  libbpf: expose resolve_func_ptr() through libbpf_internal.h.
  libbpf: set btf_value_type_id of struct bpf_map for struct_ops.
  libbpf: Convert st_ops->data to shadow type.
  bpftool: generated shadow variables for struct_ops maps.
  bpftool: Add an example for struct_ops map and shadow type.
  selftests/bpf: Test if shadow types work correctly.

 .../bpf/bpftool/Documentation/bpftool-gen.rst |  58 ++++-
 tools/bpf/bpftool/gen.c                       | 235 +++++++++++++++++-
 tools/lib/bpf/libbpf.c                        |  60 ++++-
 tools/lib/bpf/libbpf_internal.h               |   2 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  11 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   8 +
 .../bpf/prog_tests/test_struct_ops_module.c   |  19 +-
 .../selftests/bpf/progs/struct_ops_module.c   |   8 +
 8 files changed, 387 insertions(+), 14 deletions(-)

-- 
2.34.1


