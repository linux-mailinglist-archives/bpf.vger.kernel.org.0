Return-Path: <bpf+bounces-16879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8878071F7
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 15:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57D13B20EE2
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 14:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0886C3DBA5;
	Wed,  6 Dec 2023 14:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="KD0QpYg9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E8D10C6
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 06:13:45 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c09d62b70so42270155e9.1
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 06:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1701872023; x=1702476823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iHqimM7Us6ovxnXsTLw9h2o99DZirqxax9hElWLgFg4=;
        b=KD0QpYg9219MdrJjspgg1M0B6pcOrElD2Cq1bcnzx7v7xQhir4JMkTkLUspS7j+Cfo
         6rITrNu2n9N8iPrEo9UjRtftHwN99IDbUIFMzUaAB7QgVj5L+wOyQI417eyeDVF+2rMp
         xHr0h1CbPHoqXV6OSxy78FalvxYWmXcVIxmMDHeQKYny0uGt6chNijTBsurYTfvNmaxs
         Hkk808yjwyERj4u7NomI/QvBfHpNiu0PdsWMPkQhK9pwMab57CdzF/BezP5rcRkIeF0O
         LvNTdqzoKE6lNy9rPyXIbsF9zHLlPsd4bLhlSiwhC1KrTuz6f2JwpHtY9xdX09QhEY6A
         7/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701872023; x=1702476823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iHqimM7Us6ovxnXsTLw9h2o99DZirqxax9hElWLgFg4=;
        b=boHLwmKbJ3tNrJcp/9kp1yrM20V+xnRQAFs8JxK0sTVFQ5y+uSZ62DN0LMmvWReKPQ
         rPxAj/axqVXdtXxtqse9c3p2v5Ywdtzw54Qr13J7fuEzTG6/j47eSohPg3Q1vpviYWCD
         q80kYlr36pUVHKG1D5EUxKZ8Wt/kAR562DUOapDG8ZPCNPH+Qqmcp1oE1EndRO/CvSWA
         8J6PmLth38eT/Qvzx1V6IaUiVCZIS6Ipwc3ikj4IySS2VtwIu+8Rrv9M9+y06S0LxAur
         68CgTEz/ioRM04RgeE2ci97lvS0ZiaoYr7ewsj14aG32q2NK7x1GAHtYFAyqMhkoPjlr
         JSvA==
X-Gm-Message-State: AOJu0YzlQDlezbB1Ms4XUg12Oea0mP1owLAa6x7UCLJiuwghlHVhYGds
	xek1Z+gSGAa8nh5YVuL/gAGCyQ==
X-Google-Smtp-Source: AGHT+IHgu9au9WC1aoxZYHTRRlUA4kMwGjVDqO8fXv8Klhe8+kQM8UN1ORRhkmkLjJXCH3pBtMNlvQ==
X-Received: by 2002:a05:600c:3b19:b0:40b:5e21:c5c0 with SMTP id m25-20020a05600c3b1900b0040b5e21c5c0mr451034wms.142.1701872023482;
        Wed, 06 Dec 2023 06:13:43 -0800 (PST)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c311200b0040b42df75fcsm22140330wmo.39.2023.12.06.06.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 06:13:43 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf-next 0/7] BPF Static Keys
Date: Wed,  6 Dec 2023 14:10:23 +0000
Message-Id: <20231206141030.1478753-1-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds new BPF Static Keys API and implements it for X86.

The first three patches are preparatory to make main changes simpler. 

The fourth patch adds kernel API which allows to pass a list of "static
branches" to kernel. A static branch is JA instruction which can be patched
runtime by setting controlling map, aka static key, value to zero/non-zero.

The fifth patch adds arch support for static keys on x86.

The sixth patch adds libbpf support for static keys, which is more
user-friendly than just passing a list of branches.

Finally, the seventh patch adds some self-tests.

See the Plumbers talk [1] for more details on the design.

Anton Protopopov (7):
  bpf: extract bpf_prog_bind_map logic into an inline helper
  bpf: rename and export a struct definition
  bpf: adjust functions offsets when patching progs
  bpf: implement BPF Static Keys support
  bpf: x86: implement static keys support
  libbpf: BPF Static Keys support
  selftests/bpf: Add tests for BPF Static Keys

 MAINTAINERS                                   |   7 +
 arch/x86/net/bpf_jit_comp.c                   |  72 +++
 include/linux/bpf.h                           |  34 ++
 include/uapi/linux/bpf.h                      |  18 +
 kernel/bpf/Makefile                           |   2 +
 kernel/bpf/arraymap.c                         |  15 +-
 kernel/bpf/core.c                             |   9 +
 kernel/bpf/skey.c                             | 306 ++++++++++++
 kernel/bpf/syscall.c                          | 100 ++--
 kernel/bpf/verifier.c                         | 103 ++++-
 tools/include/uapi/linux/bpf.h                |  18 +
 tools/lib/bpf/bpf.c                           |   5 +-
 tools/lib/bpf/bpf.h                           |   4 +-
 tools/lib/bpf/bpf_helpers.h                   |  64 +++
 tools/lib/bpf/libbpf.c                        | 273 ++++++++++-
 tools/lib/bpf/libbpf_internal.h               |   3 +
 tools/lib/bpf/linker.c                        |   8 +-
 .../bpf/prog_tests/bpf_static_keys.c          | 436 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_static_keys.c     | 120 +++++
 19 files changed, 1542 insertions(+), 55 deletions(-)
 create mode 100644 kernel/bpf/skey.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_static_keys.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_static_keys.c

-- 
2.34.1


