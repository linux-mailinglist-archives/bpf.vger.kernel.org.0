Return-Path: <bpf+bounces-22787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2530A86A0FA
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 21:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F6B287407
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 20:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFA314DFF3;
	Tue, 27 Feb 2024 20:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zs7KvVdz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43060134B1
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 20:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709066792; cv=none; b=NfHK7a6hpyLzk1hivcEGrwHEBQpO2FdiUF1fGCUbJ2W1sNgwyz4Y5xfud5iNdMxk+RW5ET9tFMgjdUhIYhBEIaIH+sPq54h9INBP25Hr2XMmqzHOeuJp8MwC0a8B1LYLMk+QKVKrxJN2UApos2/cByecGIHaDxrtiu6HzhZoYZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709066792; c=relaxed/simple;
	bh=/joQqdAv2wfzGwZLGDG0j9iXhmtEiHei0eT+pOnyWEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=komFaWz/Xs+g7rXMQRD0eqaHNnMOPUx2Q62opgQ9oIlVGnIsJwZamyYUa18sv8vsZsrdvN6YcUkor9ob4PoWFTkOHHzWOU4O/d04LPXo+KkGFM2NsDTZXEHR8vFqL2AQeNfZ780Q2xwTFrlX8mUzJM4ocrGVAT4ncR+m9lfHj1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zs7KvVdz; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3ee69976c9so595247466b.0
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 12:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709066789; x=1709671589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tBnGlGIt2ylfpR2i/27xHdGwHTyohFAS8bh2RbgwH8E=;
        b=Zs7KvVdzrjxVqA1vLtO+j0zWX7Pf9hY7BjH8pdJNsexKAlwfA/lOUR2FkewNr4hpZ3
         +DnOE0cm/N9zF46G0vM4YC477SgjsiY1pv7TCv2ind+0z4rxyiabc5bKNa5l6IYvMPxY
         OlzivOmZdaEIu7kBxibr2Jp/MEyWxvCW4OSklCFnhpJAcOjv7dzM+4nnAlzjayrP/7UL
         SSMGlQp6M4X+CnTLv6wQuWczis/1NLWFkVFKgw+CvXfpUF6EIFXZQPmV14+JfvyeWReY
         vLs8FJaIHfogePg12VYbrkxqPou0qYcTTrIb7FmBprLqSHz6H2uGIBGysjakNW4m67VK
         7p2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709066789; x=1709671589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tBnGlGIt2ylfpR2i/27xHdGwHTyohFAS8bh2RbgwH8E=;
        b=DTztOVl9x/ul1NUY3Gjbw7g+vbW9KZQq/mEUFESQkkBZoKsAME+LigQy8Iy2kNighI
         wDrnLEHLrb0S98TUF+f7bI4clqRcecLs4tXeLYIooU6WaEL3YxL2xM6wXkGQxVVWmMMd
         hRZGfMT2K2jn5q85NonMhZQn33EgLKMRwDCxZx6m7RmkDgY0sJRX6m4YdlVB/+tQ8EQm
         hUZ2t04f3Up2E4zY/0u0uXXptpCxEccOqBHj1e14CUyPmVrdIbqPNTbwuOk9ihvI2phy
         fKxbU+XF4xf0W3QJWNVQMw750V8Z6IK2OYSfBYKB1VHlxD1LSbsnezCw5Z3aZciyc9A4
         kFkA==
X-Gm-Message-State: AOJu0YzK7xGSsQjOprrn/nnB7DY595m4Q773UY9aAu7gJjou5ghrI5cV
	6xT0kaTD5IOmmJ6Amq04go6EsU2YRhE1+97mrawEGGPU0qN4DSaXdscXJ72TkBI=
X-Google-Smtp-Source: AGHT+IGTCmaESp2U1lfA6O4N98SmOEuavBOq15+Q6dJ7xKD6h04vJ+inB9X8J/T2OCex8hgIet/6xg==
X-Received: by 2002:a17:906:b115:b0:a3f:5b9b:a17b with SMTP id u21-20020a170906b11500b00a3f5b9ba17bmr6831678ejy.53.1709066788553;
        Tue, 27 Feb 2024 12:46:28 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id hb13-20020a170906b88d00b00a3d9e6e9983sm1119832ejb.174.2024.02.27.12.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 12:46:28 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	void@manifault.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 0/8] libbpf: type suffixes and autocreate flag for struct_ops maps
Date: Tue, 27 Feb 2024 22:45:48 +0200
Message-ID: <20240227204556.17524-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tweak struct_ops related APIs to allow the following features:
- specify version suffixes for stuct_ops map types;
- share same BPF program between several map definitions with
  different local BTF types, assuming only maps with same
  kernel BTF type would be selected for load;
- toggle autocreate flag for struct_ops maps;
- toggle autoload for referenced struct_ops programs
  when autocreate flag of struct_ops maps is toggled.

This would allow loading programs like below:

    SEC("struct_ops/foo") int BPF_PROG(foo) { ... }
    SEC("struct_ops/bar") int BPF_PROG(bar) { ... }

    struct bpf_testmod_ops___v1 {
        int (*foo)(void);
    };

    struct bpf_testmod_ops___v2 {
        int (*foo)(void);
        int (*bar)(void);
    };

    /* Assume kernel type name to be 'test_ops' */
    SEC(".struct_ops.link")
    struct test_ops___v1 map_v1 = {
        /* Program 'foo' shared by maps with
         * different local BTF type
         */
        .foo = (void *)foo
    };

    SEC(".struct_ops.link")
    struct test_ops___v2 map_v2 = {
        .foo = (void *)foo,
        .bar = (void *)bar
    };

Assuming the following tweaks are done before loading:

    /* to load v1 */
    bpf_map__set_autocreate(skel->maps.map_v1, true);
    bpf_map__set_autocreate(skel->maps.map_v2, false);

    /* to load v2 */
    bpf_map__set_autocreate(skel->maps.map_v1, false);
    bpf_map__set_autocreate(skel->maps.map_v2, true);

Patch #7 ties autocreate and autoload flags for struct_ops maps and
programs, I'm curious if people find such bundling useful and in line
with other libbpf APIs.

Eduard Zingerman (8):
  libbpf: allow version suffixes (___smth) for struct_ops types
  libbpf: tie struct_ops programs to kernel BTF ids, not to local ids
  libbpf: honor autocreate flag for struct_ops maps
  selftests/bpf: test struct_ops map definition with type suffix
  selftests/bpf: bad_struct_ops test
  selftests/bpf: test autocreate behavior for struct_ops maps
  libbpf: sync progs autoload with maps autocreate for struct_ops maps
  selftests/bpf: tests for struct_ops autoload/autocreate toggling

 tools/lib/bpf/libbpf.c                        | 105 ++++++++++----
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  25 ++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   4 +
 .../selftests/bpf/prog_tests/bad_struct_ops.c |  42 ++++++
 .../bpf/prog_tests/struct_ops_autocreate.c    | 136 ++++++++++++++++++
 .../bpf/prog_tests/test_struct_ops_module.c   |  32 +++--
 .../selftests/bpf/progs/bad_struct_ops.c      |  17 +++
 .../bpf/progs/struct_ops_autocreate.c         |  42 ++++++
 .../selftests/bpf/progs/struct_ops_module.c   |  21 ++-
 9 files changed, 383 insertions(+), 41 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
 create mode 100644 tools/testing/selftests/bpf/progs/bad_struct_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_autocreate.c

--
2.43.0

