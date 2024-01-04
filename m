Return-Path: <bpf+bounces-19024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F298243A6
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 15:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62F841C22000
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 14:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A84224EA;
	Thu,  4 Jan 2024 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNoxBh8G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C148224E8
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 14:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6dac8955af0so262761b3a.0
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 06:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704378183; x=1704982983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Db2RqJgqZ+S8VSIeO1ZI+2bO2XD769gXFvXSyfSxIs=;
        b=TNoxBh8Ge0dI3MK33R6oEMJ8S+u7EJXEvEvqs0Dz20bH/svk2edlljdiKCc5T+o7gW
         J//ut7WhBCXq1SmPNnCuK7BTFD1Ts8CD0LAxCF98z7JWj37Nu9IY/DQWvBeLFQ5KHvvo
         RuZSYp9nZiPNL6rye4olm8vE7B4GtODu5JI+WxBG9gX3tiDojb2A98r56ytJyR7eAWuo
         BSC6n0jXgzTBBo9zkTlMcJD/ePZTlPAJJ6mJl+883MEKSnAPKOFx8XiiR0uO9u6ZOChq
         rczcWVqMm7hV59IdsP9kmAy/cr29NCTYC43buh8qxY+/DVl3THcs2nmdTeoUm06ZrCY3
         p79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704378183; x=1704982983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Db2RqJgqZ+S8VSIeO1ZI+2bO2XD769gXFvXSyfSxIs=;
        b=kba7/sYvrezLtxgffMmQpXq9UFO72Eve5BwVugNLYNYnkeFws58E7Vg0UkCzi5eErR
         1uBUBw4qUVa2/NHilwQsayZ/tcB8fjztJrsAD2p+7SYmSdcoNEzxQVxfCWoAeFCJeZsK
         YwwG2glDl/FYSFe++5C2fG3+WQVNvg7P0ILHRYFhGgwZCZceXuwHffGgchIts1TKZ30I
         i7IFgonDP2kdVs1BlXUM79LgrNkyA+wQwIH9Vl6o+woseGLc05CAokk77N42KX6a787H
         Lkt4ODseoB2Nr2Y7JaqRPjd0Qayh/Pv+VTPaN+0Z6v0MjawWbJcT/sk0bTDGLxzxhXTN
         tgLw==
X-Gm-Message-State: AOJu0Yzew/DrNy6t2mXSSUAxOjfG2+xz9OcrPKK6lmKbVE8D75ZnJIKv
	zOTr3/lSh7m5TAu2ukGEKe9dfGQjZ9M=
X-Google-Smtp-Source: AGHT+IFWUM5FyQG9qb8zLm6Lqx6OiB+sdITwj1wLBlsokF7dp2ixCMcEFusWwBlAojxASfF5sqfhSA==
X-Received: by 2002:a05:6a20:e111:b0:195:efa4:de81 with SMTP id kr17-20020a056a20e11100b00195efa4de81mr609600pzb.79.1704378182828;
        Thu, 04 Jan 2024 06:23:02 -0800 (PST)
Received: from localhost.localdomain (bb219-74-10-34.singnet.com.sg. [219.74.10.34])
        by smtp.gmail.com with ESMTPSA id c10-20020a17090a020a00b0028cb82a8da0sm4081507pjc.31.2024.01.04.06.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 06:23:02 -0800 (PST)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com,
	jakub@cloudflare.com,
	iii@linux.ibm.com,
	hengqi.chen@gmail.com,
	hffilwlqm@gmail.com,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 0/4] bpf, x64: Fix tailcall hierarchy
Date: Thu,  4 Jan 2024 22:22:22 +0800
Message-ID: <20240104142226.87869-1-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patchset fixes a tailcall hierarchy issue.

The issue is confirmed in the discussions of "bpf, x64: Fix tailcall infinite
loop"[0].

The issue is only resolved on x86.

Hopefully, the issue on arm64 and s390x will be resolved soon.

I provide a long commit message in the second patch to describe how the issue
happens and how this patchset resolves the issue in detail.

RFC v2 -> v1:
  * address comments from Maciej:
    * Replace all memcpy(prog, x86_nops[5], X86_PATCH_SIZE) with
        emit_nops(&prog, X86_PATCH_SIZE)

RFC v1 -> RFC v2:
  * address comments from Stanislav:
    * Separate moving emit_nops() as first patch.

Links:
[0] https://lore.kernel.org/bpf/6203dd01-789d-f02c-5293-def4c1b18aef@gmail.com/

Leon Hwang (4):
  bpf, x64: Use emit_nops() to replace memcpy()'ing x86_nops[5]
  bpf, x64: Fix tailcall hierarchy
  bpf, x64: Rename RESTORE_TAIL_CALL_CNT() to LOAD_TAIL_CALL_CNT_PTR()
  selftests/bpf: Add testcases for tailcall hierarchy fixing

 arch/x86/net/bpf_jit_comp.c                   | 108 ++---
 .../selftests/bpf/prog_tests/tailcalls.c      | 418 ++++++++++++++++++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy1.c   |  34 ++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy2.c   |  55 +++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy3.c   |  46 ++
 5 files changed, 609 insertions(+), 52 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c


base-commit: 0c14840ae36f8170f06c2fa768203ef5a8e389e1
-- 
2.42.1


