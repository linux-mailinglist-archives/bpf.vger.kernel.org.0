Return-Path: <bpf+bounces-11922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05A67C580C
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 17:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06BFE1C20CAF
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 15:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCCA208AD;
	Wed, 11 Oct 2023 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joNvXrSH"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CAC208A5
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 15:27:39 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1E998
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 08:27:37 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c9a1762b43so26238235ad.1
        for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 08:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697038057; x=1697642857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=64Z4x6ukUPpDEtdavmCNh2ZUoIRmjwxl5HBoqHNsom4=;
        b=joNvXrSHHah88mgrwUTiwFRQAYeBiBSJYIbi8Wx2rqL/h9PsdDEepFe+gVbq/u7MDD
         pFSjbr4XNNYQ930Bf7bNOayWgjI8YqEWs4Ms++en58gYUUqQDIfpz6XQCz2ucaOe3q2K
         YhsJ+lydF2mrn1Z8PVLY1vN9xIAJJ4vrHvsEY6JijfDkkfrTxVGjQMgQ9t9pEqYWRgXc
         Nz3uFA/T0QMCdx5FOKhnb9XfPe1BWPl3GTWNeOZIK73azSD1xngCiK9iNEqHAUswk3Wz
         lBvtxH06N642+6eDVZ+bgO8g+79FUzEqKy6sA+P9wfmhL+rrouLsry1tidDxEmuHJNew
         5l6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697038057; x=1697642857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=64Z4x6ukUPpDEtdavmCNh2ZUoIRmjwxl5HBoqHNsom4=;
        b=YZLMt+50HHHjMxfCPcL86P1iIDE4vzD3PvRiS72EEIjZRWV5mBJ1T9ZKE2ZUt682IE
         nvTKOY6Ch/aEuqPwV3NBja4p+bCyq45GjkrLeaGx+lqmtlB+RuNyfvtkezvW3RGy4XbW
         UUTu2TsoGtD3EByn/JpJNRDWC9Fgf5jzdabZ93fh8M2bzjNPJjTP0FXux3R4aPwL+cxH
         bsXTJ05uFv0f4jGSzYxcI7g82YarNdAnIDM0Dcsu2o68hJMc7y/m1+Cc2+JJZgNWw4l4
         51+Rg6bvQCMUcqNL69iFqb7+wDzDEE9pAfVlv8T9UQgFq8Y+DKIL8+LW9qii4pIjcyli
         cAhA==
X-Gm-Message-State: AOJu0YxKt5Z9WEN2YxeIYqBnVaB3l9EhOalOLJj3I8w9q+UR3pTrrb36
	s9NF8vewhugZas2aiGHYRfTBQP+SAA0gMQ==
X-Google-Smtp-Source: AGHT+IFwy1Pi1hqLcn+KeVBBC5/loJl9hzHMlqGVErIAcJmsQx25osTMoX5dNG/pBkNXQ1US6261ZA==
X-Received: by 2002:a17:902:a404:b0:1c3:323f:f531 with SMTP id p4-20020a170902a40400b001c3323ff531mr18231758plq.20.1697038056914;
        Wed, 11 Oct 2023 08:27:36 -0700 (PDT)
Received: from localhost.localdomain (bb119-74-148-123.singnet.com.sg. [119.74.148.123])
        by smtp.gmail.com with ESMTPSA id jf3-20020a170903268300b001c755810f89sm14092070plb.181.2023.10.11.08.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 08:27:36 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com,
	jakub@cloudflare.com,
	iii@linux.ibm.com,
	hengqi.chen@gmail.com,
	hffilwlqm@gmail.com
Subject: [RFC PATCH bpf-next v2 0/4] bpf, x64: Fix tailcall hierarchy
Date: Wed, 11 Oct 2023 23:27:21 +0800
Message-ID: <20231011152725.95895-1-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patchset fixes a tailcall hierarchy issue with a better solution than v1[0].

v1 solution stores tail_call_cnt on the stack of bpf prog:

    |  STACK  |
    +---------+ RBP
    |         |
    |         |
    |         |
 +--| tcc_ptr |
 +->|   tcc   |
    |   rbx   |
    +---------+ RSP

v2 solution stores tail_call_cnt on the stack of bpf prog's caller:

    |  STACK  |
    |         |
    |   rip   |
 +->|   tcc   |
 |  |   rip   |
 |  |   rbp   |
 |  +---------+ RBP
 |  |         |
 |  |         |
 |  |         |
 +--| tcc_ptr |
    |   rbx   |
    +---------+ RSP

With this change, it requires less instructions to resolve this issue.

For more resolving details, please read the following patches.

The issue is confirmed in the discussions of "bpf, x64: Fix tailcall infinite
loop"[1].

Currently, I only resolve this issue on x86. The ones on arm64, s390x and
loongarch are waiting to be resolved. So, the ci pipeline fails to run for this
issue fixing.

Hopefully, this issue on s390x and arm64 will be resolved soon.

v1 -> v2:
  * address comments from Stanislav
    * Separate moving emit_nops() as first patch.

Links:
[0] https://lore.kernel.org/bpf/20231005145814.83122-1-hffilwlqm@gmail.com/
[1] https://lore.kernel.org/bpf/6203dd01-789d-f02c-5293-def4c1b18aef@gmail.com/

Leon Hwang (4):
  bpf, x64: Emit nops for X86_PATCH
  bpf, x64: Fix tailcall hierarchy
  bpf, x64: Load tail_call_cnt pointer
  selftests/bpf: Add testcases for tailcall hierarchy fixing

 arch/x86/net/bpf_jit_comp.c                   |  99 +++--
 .../selftests/bpf/prog_tests/tailcalls.c      | 418 ++++++++++++++++++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy1.c   |  34 ++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy2.c   |  55 +++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy3.c   |  46 ++
 5 files changed, 606 insertions(+), 46 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c


base-commit: 644b54d80d572438a815c05b1bab2b7871e1e5a1
-- 
2.41.0


