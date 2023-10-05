Return-Path: <bpf+bounces-11448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ED97BA1C2
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 16:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 1F2D8281EAD
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 14:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18302AB57;
	Thu,  5 Oct 2023 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mM4/XYuM"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA952374C
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 14:58:51 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9946BBB4
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 07:58:50 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-690ba63891dso904728b3a.2
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 07:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696517929; x=1697122729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pqfpSY1aVtsn6fOb6FOW9kIOOmYh3Io5YuyAAxD0Xm0=;
        b=mM4/XYuMcc6RSXEOGi4g4q//AMKTt045gHMSJc+pE6GjoQNrTcv+A+bKd/vinsWXDZ
         FniFB10vlq1NSUNIZgjy0P3kcNe1TEJOVpkbmyA11Bj4ToG+e4idYfkTcDwHaQQY08I5
         Bqe3Da26FHpTK+zFIxJLP1cEMedOObLWFqIcaYrcHbnbdmXr88jPSRwpRtXeQgbRkaYN
         7R5rNcQyibqWvKL73iDfbuFolDMAkth/wseN6rkL9FK/GTy6fCgXes2FPBNGMQJ7pGea
         4G2SxEORx7mxttYBhlSDjm+z15wqaoKU/iOfCkf5edpc5u/nBULTPpl4o2XjdMzhPePs
         5f2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696517929; x=1697122729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pqfpSY1aVtsn6fOb6FOW9kIOOmYh3Io5YuyAAxD0Xm0=;
        b=OVbGNou3LhsMiaf36zlkd+1d9i8HZmvyBY2txwy0JqTaK+VbexPdhyZ72GyRqp0tO2
         ph8Je/wEo/1mbef4rL/Eo06r2UcaC0jh/gTKI8E83Fn/p08GOa4nxQutyijJTjIEI6d7
         CuaZ4KEGyJoANzF+DI6VDtrX43edQVzswm1bRwiOAxwz/kL6ZQ2/+DmC/lDcLGJqX7ep
         SDcTApR3mO5GSmIDz1kG0BnJ1hhd30+r1ib4Tiu+NbcpvEgPMwOY/r36eDdBxB0PdI8i
         yaETA1Z5i24F3zM4d1659E6lCFD6w/OgmhoyxredpgEZCK+RnI0yvS/nVbzaHgTeKVFQ
         LMjA==
X-Gm-Message-State: AOJu0YwcEtxKlfPvnjx/TcnLIbuC8O31zZ5mRzBodjtl01bI00M76iLF
	OBk/2rqwLDWFYMVUHvGovUj7vyWdEexVuA==
X-Google-Smtp-Source: AGHT+IG2kFS9zt6YGMQa0vp2RDfNKE204o2ZqA9SNQMPAuug90BU3bLJ3HFd+RFnKI7Uo2zUv3N2Ig==
X-Received: by 2002:a05:6a20:948a:b0:15d:7af9:5642 with SMTP id hs10-20020a056a20948a00b0015d7af95642mr4326777pzb.28.1696517929305;
        Thu, 05 Oct 2023 07:58:49 -0700 (PDT)
Received: from localhost.localdomain (bb119-74-148-123.singnet.com.sg. [119.74.148.123])
        by smtp.gmail.com with ESMTPSA id q1-20020a170902a3c100b001c61512f2a6sm1819930plb.220.2023.10.05.07.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 07:58:48 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next 0/3] bpf, x64: Fix tailcall hierarchy
Date: Thu,  5 Oct 2023 22:58:11 +0800
Message-ID: <20231005145814.83122-1-hffilwlqm@gmail.com>
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

This patchset fixes a tailcall hierarchy issue.

The issue is confirmed in the discussions of "bpf, x64: Fix tailcall infinite
loop"[0].

For resolving details, please read the next patch.

Currently, I only resolve this issue on x86. The ones on arm64, s390x and
loongarch are waiting to be resolved too. So, the ci pipeline fails to run for
this issue fixing.

[0] https://lore.kernel.org/bpf/6203dd01-789d-f02c-5293-def4c1b18aef@gmail.com/

Leon Hwang (3):
  bpf, x64: Fix tailcall hierarchy
  bpf, x64: Load tail_call_cnt pointer
  selftests/bpf: Add testcases for tailcall hierarchy fixing

 arch/x86/net/bpf_jit_comp.c                   | 136 ++++---
 .../selftests/bpf/prog_tests/tailcalls.c      | 384 ++++++++++++++++++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy1.c   |  34 ++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy2.c   |  55 +++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy3.c   |  46 +++
 5 files changed, 603 insertions(+), 52 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c


base-commit: 2e7e9faf9a5d46788bf7a4d07c6c1caf57367d23
-- 
2.41.0


