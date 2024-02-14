Return-Path: <bpf+bounces-21938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9C885415E
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 03:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5AC61F254D7
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 02:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7EB6127;
	Wed, 14 Feb 2024 02:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfbv4ATp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509065398
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 02:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707876526; cv=none; b=dvh6WMbtwS+FBseAk6QraPbpInSG/sJQq93XSsMXHwTsyMF/s3tzNz1/iVbrgdng8fR7pd+MlBH/JUw8XovIPA0qJp5sLx8Wr8PWNjYTyBP1LB8v947waxUbztx1PA1Fe76vFtjRQmDHeXbRr6fuMt03gDCDd4H1hjZqJj0TkIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707876526; c=relaxed/simple;
	bh=Ys7s7ZBGpYQnQ0nEndc5n58eyi/CggRcGIYeuRt4KOo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s2TFABonoKTMvxg2Xl7L2TXLk8KBUyOtnZwV1R57HrrqoM2L1eT/PyoCJEH3NVBISw+Vst1R6hUApWaOLKp75tnl5nMCEB3VXKhyrCWbU5ss75gaSVrPTPBRigoi64t+khXXbXa19QzzSCsYP8AjZdT4UwvYz4s24mWlyZL+AxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfbv4ATp; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcbf82cdf05so2000604276.2
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 18:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707876523; x=1708481323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TCgZX1+CQK8ogRd8t4S+2yn4ysSPNIerYQ9SWOBp17Y=;
        b=dfbv4ATp9Vm7lCa74xTrni455gxWVOEsJ4ZDI3BJXMXpVEKlS9KdExHE7VLYLMPuAZ
         VZ0K4hLUfVabSSyooAavOLQvK94/IddGQCiKcJ6t9Q6QnU6kl03a8/7ZMPEEJ7X6KxRx
         F1QhPTru1Uy8t/tz6EXF2AWbVbLut6zSyC/gZ7fklfYGCDUAvimTn3yCV8oHEvKaNYTB
         NCpIKKu+14xWPh6MVK0SRBPgtwOFbpH0Jhki+r9Wj9er6w6yK9rOmRTMXhY/+Tyr1ZcQ
         E/vIHT3+b0xO3HdKt9vnC4n5e1iNyHZ4F93wp+IK+M7I+MitnQm4qYtcs+gZubpnOtAK
         ta7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707876523; x=1708481323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCgZX1+CQK8ogRd8t4S+2yn4ysSPNIerYQ9SWOBp17Y=;
        b=DQQ4NC4XqTnTBunj6f8VUe+9cKOffnnjjGyW2li5uhpbbzARoFJ0mL6YL8nDqVHlbP
         BZRP8vG0xqvdLCoI3C9FESJIL8OhjP+SKdTdrc9S/8XkH59eVv5S539YZSahXMtiHSDW
         qldokJNgVr4gAky/OeK6GgeCJeTI/0C/43TjICtxApJxyDr6LiTSjNYF60NRQKUX3gHP
         fbRqBPHATX5c7OO0BihJc5NrqFr1u5xzcTlk7gTPliMhX8Opk80jmw/b6lcpzcp9BPc5
         Yju7S1HkCw4TyqnW9H/Z3+W3XA1FYomScHa2wquLdQRT3yk3XQdN8ioOBQkJFtdXjCiw
         GlgA==
X-Gm-Message-State: AOJu0Yx5BglqWnCti/cOMm2LNkjXVd8DiphArJyYRD954lTdZomkbfA5
	XdRiGG8fOPsHGbIS/A+644wy2EU/xz+yEdU2cLNmncZRCplhde+Scsuz1l+1
X-Google-Smtp-Source: AGHT+IEdK4N182/bddJeD5l4IOuj/UNg7Sx22MQ5DGOQ3Ri0PvQFV8Kf+icwJWUxBkhSBI4thOdcJA==
X-Received: by 2002:a25:5f4d:0:b0:dcd:72f7:15b8 with SMTP id h13-20020a255f4d000000b00dcd72f715b8mr1060241ybm.11.1707876522632;
        Tue, 13 Feb 2024 18:08:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW5haCepyYDLVZC/6nEsgsa6QTr3pB9b9src+09IPkJULHa0jbE+8iXSkztzFoGeUJXXBKEPxn7peKwY7ege5NNpi/k6593gIZ+O2qOfu5uKMi2kqzFfxdwEUKAt/jreTaTz2xLPOvRw/gr4BmouRh/A0oy59TZLw43rL9QrVl9i5hSqU3uE9UsxbpJkhg52I112iF12v+CeG4SgHbOgoTmZXKhxska3Xqv/Tt4IDes/zjcyqUfgg==
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:966f:7edc:e6e6:cd97])
        by smtp.gmail.com with ESMTPSA id s17-20020a258311000000b00dc2310abe8bsm1894752ybk.38.2024.02.13.18.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 18:08:42 -0800 (PST)
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
Subject: [RFC bpf-next v2 0/3] Create shadow variables for struct_ops in skeletons
Date: Tue, 13 Feb 2024 18:08:33 -0800
Message-Id: <20240214020836.1845354-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

This RFC is for gathering feedback/opinions on the design.
Based on the feedback received for v1, I made some modifications.

== Pointers to Shadow Copies ==

With the current implementation, the code generator will create a
pointer to a shadow copy of the struct_ops map for each map. For
instance, if we define a testmod_1 as a struct_ops map, we can access
its corresponding shadow variable "data" using the pointer.

    skel->struct_ops.testmod1->data

== Shadow Info ==

The code generator also generates a shadow info to describe the layout
of the data pointed to by all these pointers. For instance, the
following shadow info describes the layout of a struct_ops map called
testmod_1, which has 3 members: test_1, test_2, and data.

    static struct bpf_struct_ops_member_info member_info_testmod_1[] = {
    	{
    		.name = "test_1",
    		.offset = .....,
    		.size = .....,
    	},
    	{
    		.name = "test_2",
    		.offset = .....,
    		.size = .....,
    	},
    	{
    		.name = "data",
    		.offset = .....,
    		.size = .....,
    	},
    };
    static struct bpf_struct_ops_map_info map_info[] = {
    	{
    		.name = "testmod_1",
    		.members = member_info_testmod_1,
    		.cnt = ARRAY_SIZE(member_info_testmod_1),
    		.data_size = sizeof(struct_ops->testmod_1),
    	},
    };
    static struct bpf_struct_ops_shadow_info shadow_info = {
    	.maps = map_info,
    	.cnt = ARRAY_SIZE(map_info),
    };

A shadow info describes the layout of the shadow copies of all
struct_ops maps included in a skeleton. (Defined in *__shadow_info())

== libbpf Creates Shadow Copies ==

This shadow info should be passed to bpf_object__open_skeleton() as a
part of "opts" so that libbpf can create shadow copies with the layout
described by the shadow info. For now, *__open() in the skeleton will
automatically pass the shadow info to bpf_object__open_skeleton(),
looking like the following example.

    static inline struct struct_ops_module *
    struct_ops_module__open(void)
    {
    	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
    
    	opts.struct_ops_shadow = struct_ops_module__shadow_info();
    
    	return struct_ops_module__open_opts(*** BLURB HERE ***opts);
    }

The function bpf_map__initial_value() will return the shadow copy that
is created based on the received shadow info. Therefore, in the
function *__open_opts() in the skeleton, the pointers to shadow copies
will be initialized with the values returned from
bpf_map__initial_value(). For instance,

   obj->struct_ops.testmod_1 =
	bpf_map__initial_value(obj->maps.testmod_1, NULL);

This line of code will be included in the *__open_opts() function. If
the opts.struct_ops_shadow is not set, bpf_map__initial_value() will
return a NULL.

========================================
DESCRIPTION form v1
========================================

Create shadow variables for the fields of struct_ops maps in a skeleton
with the same name as the respective fields. For instance, if struct
bpf_testmod_ops has a "data" field as following, you can access or modify
its value through a shadow variable also named "data" in the skeleton.

  SEC(".struct_ops.link")
  struct bpf_testmod_ops testmod_1 = {
      .data = 0x1,
  };

Then, you can change the value in the following manner as shown in the code
below.

  skel->struct_ops.testmod_1->data = 13;

It is helpful to configure a struct_ops map during the execution of a
program. For instance, you can include a flag in a struct_ops type to
modify the way the kernel handles an instance. By implementing this
feature, a user space program can alter the flag's value prior to loading
an instance into the kernel.

The code generator for skeletons will produce code that copies values to
shadow variables from the internal data buffer when a skeleton is
opened. It will also copy values from shadow variables back to the internal
data buffer before a skeleton is loaded into the kernel.

The code generator will calculate the offset of a field and generate code
that copies the value of the field from or to the shadow variable to or
from the struct_ops internal data, with an offset relative to the beginning
of the internal data. For instance, if the "data" field in struct
bpf_testmod_ops is situated 16 bytes from the beginning of the struct, the
address for the "data" field of struct bpf_testmod_ops will be the starting
address plus 16.

The offset is calculated during code generation, so it is always in line
with the internal data in the skeleton. Even if the user space programs and
the BPF program were not compiled together, any differences in versions
would not impact correctness. This means that even if the BPF program and
the user space program reference different versions of the "struct
bpf_testmod_ops" and have different offsets for "data", these offsets
computed by the code generator would still function correctly.

The user space programs can only modify values by using these shadow
variables when the skeleton is open, but before being loaded. Once the
skeleton is loaded, the value is copied to the kernel, and any future
changes only affect the shadow variables in the user space memory and do
not update the kernel space. The shadow variables are not initialized
before opening a skeleton, so you cannot update values through them before
opening.

For function pointers (operators), you can change/replace their values with
other BPF programs. For example, the test case in test_struct_ops_module.c
points .test_2 to test_3() while it was pointed to test_2() by assigning a
new value to the shadow variable.

  skel->st_ops_vars.testmod_1->test_2 = skel->progs.test_3;

However, you need to turn off autoload for test_2() since it is not
assigned to any struct_ops map anymore. Or, it will fails to load test_2().

 bpf_program__set_autoload(skel->progs.test_2, false);

You can define more struct_ops programs than necessary. However, you need
to turn autoload off for unused ones.

---

v1: https://lore.kernel.org/all/20240124224130.859921-1-thinker.li@gmail.com/

Kui-Feng Lee (3):
  libbpf: Create a shadow copy for each struct_ops map if necessary.
  bpftool: generated shadow variables for struct_ops maps.
  selftests/bpf: Test if shadow variables work.

 tools/bpf/bpftool/gen.c                       | 358 +++++++++++++++++-
 tools/lib/bpf/libbpf.c                        | 195 +++++++++-
 tools/lib/bpf/libbpf.h                        |  34 +-
 tools/lib/bpf/libbpf.map                      |   1 +
 tools/lib/bpf/libbpf_internal.h               |   1 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   6 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   1 +
 .../bpf/prog_tests/test_struct_ops_module.c   |  16 +-
 .../selftests/bpf/progs/struct_ops_module.c   |   8 +
 9 files changed, 596 insertions(+), 24 deletions(-)

-- 
2.34.1


