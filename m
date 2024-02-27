Return-Path: <bpf+bounces-22749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C252386857E
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 02:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5B641C22D43
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 01:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A375B4A1E;
	Tue, 27 Feb 2024 01:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWHbF5nl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17A74689
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 01:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708995881; cv=none; b=aH1jlZb7EyHALF+3BXOec2thwfQyZTqbgaCnxXkmuOMIeJH5CL8Tv1W4CMrze5JW2kpng5vjRTR1dQZ2QZZAvOl3zZ2SjdEng/AGSYDs79ipGeuy9D9rTaJF2g3D4W07f7aAK/2dsXg+ycUx7GrF+FMYIa37KiZagOAi4JIBnzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708995881; c=relaxed/simple;
	bh=3XowdxNxAmtok1BvgTDq7tssQrc8P58iamx7oy2PjZA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oVnt51N7bf6vI9KxE2swcqTMb/ApjCeqhLa6I/oB+QBH3EOUrx72lna5g6szlPQ+5g+b2AE14YwOANypIgKRZvfv6aitR66xPTwhetrx0hif0Zv3NelQGQIMSiTdDQQD2w+wrALvGEvKB5YrMNT1TEewm1rYyQKm7LCN1qQQkxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWHbF5nl; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-607c5679842so37683767b3.2
        for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 17:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708995878; x=1709600678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D5Si9N6BGM6nbyBCoIjq/b4rWs8n5OyR+EwV6gHHQ24=;
        b=UWHbF5nlGpnYrJCh01uEk9Oe00ywhT4SmpIV1bCWP10K4gq8mK6BhMlUDesQPUxldh
         EIzTtjaqL5mBcsSO2SD2G5NXicjeNY9nETQAxDccyJnPZdvDopLuWfAvYeOTrFgCrux0
         MXFJASgY1U1nLcIjUtghsW07Cjjq8WLvNS9TCTGvaHX9G7NwQ2wbpIxUVUAWx/cF13yk
         piZI00F3rYCU7qd1iGjL70OTXHVDeZAAlbjTLdVYqP2QfUETfwKdtjkjaHztzyQCUNHn
         es0IsirKWX6eiRqjOnIK30LABbw+EeK6JNAGu1Pc6Dz+Tg2Zh0jFfCiELdRIXYag9eSw
         zA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708995878; x=1709600678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5Si9N6BGM6nbyBCoIjq/b4rWs8n5OyR+EwV6gHHQ24=;
        b=JsB7QIclms8+GTtzpdxjeY7jjWmg7QMZ742/EL70/QPfRSzKfQ20NSQhcoL+iA1Iza
         zeQjMYEuK0ZU1siIDzQQKzBni6F5MmSl0gch1NKb6Yo6AMQI4PahfK0K+q4vJMOIPiUK
         8/hfe3Oudp5OjFAICYIPf9FGpOzV2VR+9o6AwjGYbdnHcph2snpEWqv73Ivz8yT1qF5i
         sci//vv4MWKUkPwLY3fNW1teqgosw1b+8Lj0+y5eJ80KQCjseWGKBoVaCjIfgJkG0Ks+
         AP2Mo3ywcDKoC8dAHhNqQx3wRllqZI8EMn/lf+OLJl9Wa8dlpF8SPhoHjF4k7RdvdeSU
         DT2w==
X-Gm-Message-State: AOJu0YzCanUqTGJIicnyTWtYLVTSnR7TBkxIGhRtr4ZyJdgFhAql6eZt
	T46Hsz0GE+dPYR3eDvfcTGVnh1KTwuPhM+vSDTAfBaeCZFmkSOf0ke1scMkw
X-Google-Smtp-Source: AGHT+IGRC+tz5gAWMCeVdyjGRk6Qg2MYBaWMujtO5BNQT7C2+WOShDX78HbF2jOCLK3/j1qqNlhxww==
X-Received: by 2002:a0d:e297:0:b0:608:e172:6702 with SMTP id l145-20020a0de297000000b00608e1726702mr870161ywe.42.1708995877720;
        Mon, 26 Feb 2024 17:04:37 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:5f7:55e:ea3a:9865])
        by smtp.gmail.com with ESMTPSA id l141-20020a0de293000000b00607f8df2097sm1458818ywe.104.2024.02.26.17.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 17:04:37 -0800 (PST)
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
Subject: [PATCH bpf-next v5 0/6] Create shadow types for struct_ops maps in skeletons
Date: Mon, 26 Feb 2024 17:04:26 -0800
Message-Id: <20240227010432.714127-1-thinker.li@gmail.com>
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
Changes from v4:

 - Convert function pointers to the pointers to struct bpf_program in
   bpf_object__collect_st_ops_relos().

Changes from v3:

 - Add comment to avoid people from removing resolve_func_ptr() from
   libbpf_internal.h

 - Fix commit logs and comments.

 - Add an example about using the pointers of shadow types
   for struct_ops maps to bpftool-gen.8.

v4: https://lore.kernel.org/all/20240222222624.1163754-1-thinker.li@gmail.com/
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
 tools/lib/bpf/libbpf.c                        |  28 ++-
 tools/lib/bpf/libbpf_internal.h               |   2 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  11 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   8 +
 .../bpf/prog_tests/test_struct_ops_module.c   |  19 +-
 .../selftests/bpf/progs/struct_ops_module.c   |   8 +
 8 files changed, 354 insertions(+), 15 deletions(-)

-- 
2.34.1


