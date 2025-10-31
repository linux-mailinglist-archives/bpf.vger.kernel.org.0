Return-Path: <bpf+bounces-73113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3A2C23A20
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 08:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27C3C188EA46
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 08:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A99132AABE;
	Fri, 31 Oct 2025 07:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+Lje8q9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A83328604
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 07:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897576; cv=none; b=OOuTftMfzKTt06+1+N1PoQOqC2UeqaMe0+pYCkx+jCiNNfkfmgoNnLClJGuEDFcxJSOYm6OnEBq+57dcMz0+OFqttagBU6fDftntRlF4AmnVMcMfpDr/5G4d3SIPgXH/cQKAVbSTBeX854NOtkZbZqgOKzzfU/Y295PeyNU6+yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897576; c=relaxed/simple;
	bh=oCFU+Jq75hVAWXXdS62XSOnstkhM/oQ6Cc7WTvuNuXk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=baYR8s8oDjLr1s3x1tHGfAWCrlG+ZhEENVMfGBo2YHORqZCvaNUqQAjOj/vgUAedweIB7f1/J9NdpHdMq81F+S5NYDQWDLGAMfI184NIYldTwPRFylcoRqQo3ecHRegPVpnPtXS4USWQt5Bg12eu5k1l/MBNvPduVgA9F/aizZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+Lje8q9; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-794e300e20dso2529921b3a.1
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 00:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761897574; x=1762502374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FIG1gPHWz5YUTSFTq2X6NcEVev5w3QKx2U2b3x+eC04=;
        b=D+Lje8q9jWoTtcKwZvjdKuqVly1M+Md6sLDhgLHf0DrgO9dMPHg/2hbyk7QpiueWyG
         p2LGOlro7LjGr5UG87mVKFmLVMHn1rRH1sx9PUmepKeHzXDvQ1uYM47eRBXxuA58lVSC
         fo+ZijT3OV/Z9c8sWINOd7EkrqT7gDeRlFGv+8PDxBU5XYojLetuyCuTf6jShXB9BjUP
         g3B8igvQlOFtAUv6oHspWDY63J9Cmk4CY/cog34kth9Cw9C7Ixeo5k+6mVX9gau9a0Ru
         1uiEN8uUJB/B4G3C8RCtu3fyzTkvIn5cs3T7l01jVIa+yqqYrcUE0S0V5/xNU6qPs8eb
         XU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761897574; x=1762502374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FIG1gPHWz5YUTSFTq2X6NcEVev5w3QKx2U2b3x+eC04=;
        b=IXC2Aqve7F9YEwVZuBfVQ2zEXMYeX+jD4BrdGyeI0L9SM+N8ZjcKUILtHLyZR/LPn0
         BLzjhOEAhZ6jAlAMGRk1Bpg40Xl3FtnIP2ZmIUgp0H9llIWqUcIsLZVwJ6R1jUCIaVQE
         CkL/Aa1uYQvoiXs6/P5gsgeRBYlN1zGWBRkr082cCKn19hxLV3BE19z5MT+lZT9Nxwlf
         0oDVqAjW0aCFP6/vYt6a4m+Ij/OCshyXNZ6yK4SIjaJ4uFNgej9xxxCUksYfO8Y6vAIA
         pxAvgDQpnkyxJCGSjBZtEs6xeqGFTlSFJrX5Y9917EUUJKc9avu1hwph0yB+/al/VV99
         gTyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0keQ0flXDubCD6Wn47pQthnBXJytDQBmPnHhALug/IDzOlQtEBYLzVagApQFqmtRahRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YypGTkxL2N0ZV/lowGdFYXLmsrnoI7zpvHHcIYaiKlXO+EMiAsP
	PUfpT6dg/r3Mq4ZzT2eGFwUZ3rHnNw41NAD90FplIQz3dJeI3//jlBFL
X-Gm-Gg: ASbGncv9y3F6USZ9gUkYnuWR3dk5UHLgU1iPybhpijl3X0ct0Ds3ucMm83hXY9Adv+u
	cmKifbXmnu1m2S/T3Z6ucom3p7Bi4js+g9klZ5WJQqZvywZoUwrsOe2OLeedNtBfsuBJtXt1Uau
	jbuR0L2ff8bNOSOtfmMnfyUubpV5q2KwyAAEEsdYRAMiRjT4gXGgmDWzCk7O8xnpbXZtkmDkD9N
	rL0P5Sh7YXU1tWAsTdXBYvJK9K/0XuX7gQysfWVOMfbygSQJHacxsVmIb7fTWeyoY6uSHg25pM9
	4yI3ghOPv2m3xTnIMc864PRApfGosDVaGnvfK0Ii/KgYYcMGxuQWo8x7Oa/am6rTU0I1yCDIj9D
	BCQ2ezvXsjFPEWUw9NPTcNG3I0BIDk4gYUnYywsASTa8xsmOsWFsERRHUbTYvt/az6pZVHpthXE
	4eXzKG/9kBk6f4p9q4s4zxmui3xbFe4fuIlJshKpQ=
X-Google-Smtp-Source: AGHT+IHdbZmqsXSWeXv/r8DTnZI3dtQC+Ykx5SbKuHeqzqFtK6HuJVgXOKgrXJEaUHZqapUmILM+JQ==
X-Received: by 2002:a05:6a21:998f:b0:342:a261:e2c9 with SMTP id adf61e73a8af0-348ba48c3d6mr3838807637.8.1761897573947;
        Fri, 31 Oct 2025 00:59:33 -0700 (PDT)
Received: from E07P150077.ecarx.com.cn ([103.52.189.23])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93be4045fbsm1216575a12.28.2025.10.31.00.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 00:59:33 -0700 (PDT)
From: Jianyun Gao <jianyungao89@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [LIBRARY] (libbpf))
Subject: [PATCH v2 0/5] libbpf: add Doxygen docs for public LIBBPF_API APIs
Date: Fri, 31 Oct 2025 15:59:02 +0800
Message-Id: <20251031075908.1472249-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Background:
While consulting libbpf's online documentation at https://libbpf.readthedocs.io/
I noticed that many public LIBBPF_API helpers in tools/lib/bpf/bpf.h either
lacked descriptions entirely or had very minimal/fragmented information. This
makes it harder for both new and experienced users to understand semantics,
error handling, privilege requirements, flag usage, and concurrency aspects of
these APIs. To improve discoverability and self-service learning, I prepared a
series adding consistent Doxygen comment blocks for all currently exported
LIBBPF_API interfaces.

Goals of this series:
- Provide structured @brief, parameter, return, and common error descriptions.
- Clarify behavior of flags (e.g. BPF_F_LOCK, batch operation semantics).
- Note privilege/capability considerations where relevant.
- Normalize wording of return conventions (0 on success, negative libbpf-style
  error == -errno) without changing actual behavior.
- Improve completeness of generated HTML/PDF docs produced via Doxygen.
- Pure documentation; no code logic, ABI, or symbol changes.

Patch breakdown:
  1/5 libbpf: Add Doxygen documentation for bpf_map_* APIs in bpf.h
  2/5 libbpf: Add Doxygen documentation for bpf_prog_* APIs in bpf.h
  3/5 libbpf: Add Doxygen documentation for bpf_link_* APIs in bpf.h
  4/5 libbpf: Add Doxygen documentation for bpf_obj_* APIs in bpf.h
  5/5 libbpf: Add Doxygen documentation for btf/iter etc. in bpf.h

Diffstat (approximate):
 tools/lib/bpf/bpf.h | 2962 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 2941 insertions(+), 21 deletions(-)

Thanks for reviewing.

Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>

---
v1->v2:
 - Fixed compilation error caused by embedded literal "/*" inside a
   comment (rephrased/escaped).
 - Refined bpf_map_* return value docs: explicit non-negative success
   vs negative -errno failures.
 - Fixed the non-ASCII characters in the patches.

The v1 is here:
https://lore.kernel.org/lkml/20251031032627.1414462-1-jianyungao89@gmail.com/

---

Jianyun Gao (5):
  libbpf: Add doxygen documentation for bpf_map_* APIs in bpf.h
  libbpf: Add doxygen documentation for bpf_prog_* APIs in bpf.h
  libbpf: Add doxygen documentation for bpf_link_* APIs in bpf.h
  libbpf: Add doxygen documentation for bpf_obj_* APIs in bpf.h
  libbpf: Add doxygen documentation for btf/iter etc. in bpf.h

 tools/lib/bpf/bpf.h | 2967 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 2946 insertions(+), 21 deletions(-)

-- 
2.34.1


