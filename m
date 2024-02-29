Return-Path: <bpf+bounces-22995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B22386C139
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 07:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179F91F21296
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 06:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575B947F7C;
	Thu, 29 Feb 2024 06:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bK2WN4KM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4157847F63
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 06:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709189129; cv=none; b=o2c1I+pjLH+UPGK9tgAwcoQCke1LNsBCEr686b7YrODJw2wLJe5iGQ2FhQVAb/C+O1ULPF5kvuQQSNDTO0+Oxm+/MU609YGyT00Yeu7QsJOVhEh1DtO47rxiVD09VwlUlcx3K7NbXTdccfhs7mOQ+8bFhOet8U1Sbrsla8YDeJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709189129; c=relaxed/simple;
	bh=LogjUEEoU8bQ48lxTe5h5ql7QlVwKTsNY9qwG2vGzs4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WcKs0QQOoJYv56eInBJzNmD+2YJ4fkjj9vv4ITbskin3IFYdJpNgobYdmyclrDeZvZK98wmIDHe0OJZma2enJQybEU2wR/lQQftHaqfd2VnD7nApophpxmtd//hOQbXkkvNErPxd7lWTGzRromwbfz334BkH/iQYvryxV73IWsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bK2WN4KM; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-608841dfcafso6019847b3.2
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 22:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709189126; x=1709793926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bSOlWwUo4Z+4YtVwvkQ7d5Cbf5M80lRK7V5U9iFJ0tE=;
        b=bK2WN4KMs6A0y5RVgVAxmQTpaVUlsCfzk65Lrct7znJ8FcBU2CFLnW6glkwSp75ckN
         5f6ID5E0PYgdbbng2AhBH37eexe4ZB+Or+AmQgHFQOQnotVA4YwAmPz7+hAptAK56b1Z
         DYYkVACAeRnEaU7LO+yAYQF8pHwkba46AxGV9sZULYFzYHvHkCxZXGD8FaTPAHbZcNUa
         tsvyXq6exz0WNjBe28oi0+Y5Ie8bmSW1DhKndce0FJEoZ/8ZBv0q50smlM/3QD4TLQqQ
         TgqLs6xyWxwciRYihHfVFVzOpOpAQlXju9Yccmwkf2PUkDDBPXEe/Ehqx25BbxgWerGD
         b4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709189126; x=1709793926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bSOlWwUo4Z+4YtVwvkQ7d5Cbf5M80lRK7V5U9iFJ0tE=;
        b=iHnCikqf4VTFHNstbcU0MDHM+cyvDEEFPL1ixfhbu/gY8FwrUP+O+eigUX269bLhSJ
         GU5/lNquHtQ6Oai/MTKiXxWhQIq0fdcAHZe8AnmvpLLo5wZP4+VAZkU9tWq15L8prGRD
         Bs66YhwkluQwICs6SiDh2Qd8DS3n/KXC9IbBjN89h43V4bdyoW/y8UfLYcsn3MNcUxqS
         37zMHdpTg8srosVuz3otuQNxvFjVyfqOuJ0HM+ZLJ4F4AQD40qy4tc4TUD0GCxesoFw2
         45qTbw6ZNM7VkAw2+wcn0yxa2CQUynalGU2h8E3Rll3pcOBbOKO9SYbAPs39VcMgJP4k
         iU8w==
X-Gm-Message-State: AOJu0YyBFqKWpg/hODJoW+2/ZGDe9oe+Gf+SEonjdQvSROSjE5qv+on1
	zBlFgwPt4LtdbxeScvJ5okUl42uhWubOI/jxAhmd71X5iKLiSAAVKOkbmC0I
X-Google-Smtp-Source: AGHT+IFehRs6k5HJ8DDEQKONkwsRP/3Kvum5E/fl8WhuBb/hgqnRaQWlgb3oJLkvmZBgJQm6aswvVw==
X-Received: by 2002:a81:9814:0:b0:609:1d39:1e97 with SMTP id p20-20020a819814000000b006091d391e97mr1437026ywg.19.1709189126413;
        Wed, 28 Feb 2024 22:45:26 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:bc86:35de:12f4:eec9])
        by smtp.gmail.com with ESMTPSA id p14-20020a817e4e000000b006048e2331fcsm208581ywn.91.2024.02.28.22.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 22:45:25 -0800 (PST)
From: Kui-Feng Lee <thinker.li@gmail.com>
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
Subject: [PATCH bpf-next v6 0/5] Create shadow types for struct_ops maps in skeletons
Date: Wed, 28 Feb 2024 22:45:18 -0800
Message-Id: <20240229064523.2091270-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
    	struct my_skel_testmod_1_bpf_testmod_ops {
    		const struct bpf_program *test_1;
    		const struct bpf_program *test_2;
    		const struct bpf_program *test_maybe_null;
    		char onebyte;
    		char __padding_4[3];
    		char __unsupported_4[8];
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
Changes from v5:

 - Generate names for shadow types.

 - Check btf and the number of struct_ops maps in gen_st_ops_shadow()
   and gen_st_ops_shadow_init() instead of do_skeleton() and
   do_subskeleton().

 - Name unsupported fields in the pattern __unsupported_*.

 - Have a padding field for a unsupported fields as well if necessary.

 - Implement resolve_func_ptr() in gen.c instead of reusing the one in
   libbpf. (Remove the part 1 in v4.)

 - Fix stylistic issues.

Changes from v4:

 - Convert function pointers to the pointers to struct bpf_program in
   bpf_object__collect_st_ops_relos().

Changes from v3:

 - Add comment to avoid people from removing resolve_func_ptr() from
   libbpf_internal.h

 - Fix commit logs and comments.

 - Add an example about using the pointers of shadow types
   for struct_ops maps to bpftool-gen.8.

v5: https://lore.kernel.org/all/20240227010432.714127-1-thinker.li@gmail.com/
v4: https://lore.kernel.org/all/20240222222624.1163754-1-thinker.li@gmail.com/
v3: https://lore.kernel.org/all/20240221012329.1387275-1-thinker.li@gmail.com/
v2: https://lore.kernel.org/all/20240214020836.1845354-1-thinker.li@gmail.com/
v1: https://lore.kernel.org/all/20240124224130.859921-1-thinker.li@gmail.com/

Kui-Feng Lee (5):
  libbpf: set btf_value_type_id of struct bpf_map for struct_ops.
  libbpf: Convert st_ops->data to shadow type.
  bpftool: generated shadow variables for struct_ops maps.
  bpftool: Add an example for struct_ops map and shadow type.
  selftests/bpf: Test if shadow types work correctly.

 .../bpf/bpftool/Documentation/bpftool-gen.rst |  58 ++++-
 tools/bpf/bpftool/gen.c                       | 237 +++++++++++++++++-
 tools/lib/bpf/libbpf.c                        |  50 +++-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  11 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   8 +
 .../bpf/prog_tests/test_struct_ops_module.c   |  19 +-
 .../selftests/bpf/progs/struct_ops_module.c   |   8 +
 7 files changed, 377 insertions(+), 14 deletions(-)

-- 
2.34.1


