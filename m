Return-Path: <bpf+bounces-22356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0877A85CD65
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 02:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 227AB1C22CB7
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 01:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3673C3D8E;
	Wed, 21 Feb 2024 01:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C35CeE5E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1D65666
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 01:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708478626; cv=none; b=Q9vdcWV0V2KadId+Y752Z+A6M9JBRM5LU9vk4el0EaEThSPAjixsknqG7sQNHRVSYKIg8v3NRq5OzSaoL4gwZ7wJ20t6m1OwFFXY1QS5RNi8G5rblQ4NCe8vCXGjruFgZowRLUucjcRcp7b/Lbim92VFqNMYOP4065ykaCAtr9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708478626; c=relaxed/simple;
	bh=M5b56MvbFN2+F8bzMhnHm+a+BVYzgfH5WrJpBurD9N8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nO3bTFy0wVVeBodo2LFlChlZH1sXigjSdOmkt+R4AOuipEJ5jxD8GKgTK+fIdu51POPOE1FOBrK+mjWponkk7HcRrLu+//4ud58e+qDT6+m5mrGCuR0VrTaFCC4q+uAQzWCrOERX681zoqgO0LlDXv3V6g7YOb8984SCiqQMYPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C35CeE5E; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-607d8506099so59700537b3.0
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 17:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708478623; x=1709083423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WHHQj0Zeq5xAzYjYuMIobC7y/QzOmrc3C5mSoGi5804=;
        b=C35CeE5EmKXIo0DwAaXeH+52/rxCXtHwGFHnyO4518qVqk/qeJTPly4Kt4f18n5RjF
         ypAPnsNb/1cORJYmM5V438oaxdDZe2q2z4ZgzX1TEkr+aG5+JK2OBG1wVHdcmPO+30r0
         btmxcoEWdYSZElPcs5krJtk5OCQvvhsDOXQhnIEbeYe7qnpwI82sdatTKmbPuP3Cftfi
         hArdTd4Di7+t6oIY0yQFEJXv5H7xGWiuf9num3kOfPNIG4ibCemszWwyy//XDLp7gqU3
         T9jEI0xX6ipFNJqxJ1N8jRgF4ybeAopy6PvrsuT1ILahrsSfLF9wAFMnpG2fq8OJ9diH
         bN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708478623; x=1709083423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WHHQj0Zeq5xAzYjYuMIobC7y/QzOmrc3C5mSoGi5804=;
        b=e9LvDzeXX3wQR2hC9WceETGpdNe8ibB63xZbjo8KonjOPckKJxZFmQwED91jF1Bm22
         T4dyxuREEVVM6qFwB9Ft71UuIiJTTeCbOGr/lmRoRPrhC1HAKjJLv5qVQcqKQdgbhg7q
         8lz4ZLAGN42h3P1bWF55mqJjD077ML5KPbnthPLElUVhKcrZHe3rSQp5H+Skevnv6uy4
         OHyIVBv5qmOyv/xxan+GjVtdxjz6fkCj47JFwTdHzEfXVLYOBZB+Z6DwLX+s9DHszbPu
         iGMDWfSx/pMeMzsSmGWGHwHqBalo3shBn9qz3jt/rZ8P30hOo/0SvE+l+ClWt0tJM6Pu
         2izg==
X-Gm-Message-State: AOJu0YzChFQ6slV47TeGYNv2UUZGNj9M89y9/lXkaVepgrWm1T3ZTrLO
	v8A1VqqBrKlrm+jjiWAUFSHJUjRkktpmZYn5cHPkdPEG5Zafvh5/ye3pOsA0
X-Google-Smtp-Source: AGHT+IE6mpF789u+N/nQiOapxyHKadxA97YbFpYnrEV9jafqsZqFAdMVrFJxk0Y+taR8uyHeHgJR2Q==
X-Received: by 2002:a81:a145:0:b0:607:9e4b:f0eb with SMTP id y66-20020a81a145000000b006079e4bf0ebmr15031138ywg.29.1708478623409;
        Tue, 20 Feb 2024 17:23:43 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:26eb:2942:8151:a089])
        by smtp.gmail.com with ESMTPSA id j64-20020a0de043000000b00607ef065781sm2396801ywe.138.2024.02.20.17.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 17:23:43 -0800 (PST)
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
Subject: [PATCH bpf-next v3 0/5] Create shadow types for struct_ops maps in skeletons
Date: Tue, 20 Feb 2024 17:23:24 -0800
Message-Id: <20240221012329.1387275-1-thinker.li@gmail.com>
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
v2: https://lore.kernel.org/all/20240214020836.1845354-1-thinker.li@gmail.com/
v1: https://lore.kernel.org/all/20240124224130.859921-1-thinker.li@gmail.com/

Kui-Feng Lee (5):
  libbpf: expose resolve_func_ptr() through libbpf_internal.h.
  libbpf: set btf_value_type_id of struct bpf_map for struct_ops.
  libbpf: Convert st_ops->data to shadow type.
  bpftool: generated shadow variables for struct_ops maps.
  selftests/bpf: Test if shadow types work correctly.

 tools/bpf/bpftool/gen.c                       | 229 +++++++++++++++++-
 tools/lib/bpf/libbpf.c                        |  60 ++++-
 tools/lib/bpf/libbpf_internal.h               |   1 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  11 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   8 +
 .../bpf/prog_tests/test_struct_ops_module.c   |  19 +-
 .../selftests/bpf/progs/struct_ops_module.c   |   8 +
 7 files changed, 328 insertions(+), 8 deletions(-)

-- 
2.34.1


