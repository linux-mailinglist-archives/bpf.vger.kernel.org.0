Return-Path: <bpf+bounces-27148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8781B8AA02F
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 18:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15F3DB25899
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 16:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4151916F91E;
	Thu, 18 Apr 2024 16:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbOi+Rvl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC141CD21
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713458114; cv=none; b=DXJDiZpqytzC1RkpJ2KIZuTTGSRXY7WX7zrXAp36lK22ss9j/r9axi2SFznAgKTN3AWziBx5tyq4mK+QU+4WjHPcnWDCPUe9cqhchK7sbyP+v0FgWIMOnazDHqwb13dgPWnxRfIsESPygLs01oOeXTm/ZoVxBe9rq3WucLZUnYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713458114; c=relaxed/simple;
	bh=grzaPSYMMl5f21tVbpRnu0kmJKlI4clC+qm5tYLAAKc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=akD3Ie/CkVG3UwFIDXqOGukJgMuJonIp1fmr6I9K5dbK+tMiHKUwZZ90GTH8GpxnJT83tDlYg+DkMCokC5p5uarfvvCJ91VjfkADhVVFm0ZgmYOa9Ej2+a7f4F2BZsFkEmBfDC6miJJYoTVNp1yincWSDVv8By4sdAO/hYZS4bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbOi+Rvl; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6eb77e56b20so577029a34.3
        for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 09:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713458112; x=1714062912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NNvc08/9wCxlwvv3Y7czFGPPjLWFgGU/4yeYpVs1IhI=;
        b=gbOi+RvlEeRtmhf+uaWJwPRbZ/foPcXJF6M68gvg9HP91zorp4/U0JtUDUSFOm4838
         B1Zq3MsNn/jSiwyeQMwp3WoCSyCyI3Cfr0pJEZsRh7Fg6icpL26Oco6ODfYLHMB7AX3k
         zmYD72F6+ITzNaO4ZtieSnlxjjX52HxNJbPu+0+rW2YIiHWfiRVH9eIVGxnE6Xn1eP9P
         AvJyPoFMTZvVbYf6M6J49hsIKlPGpgkzyEYHItpM4r35Uqq/kgp9JGUlsx+hfR66rb5A
         6jyjHk7Sy7qwHNHGj5UsnhNf3b7OmsBvHK2GSMaGWvJ2KNh1K9/PRSWQOpnNBQ2q+DMR
         DMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713458112; x=1714062912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NNvc08/9wCxlwvv3Y7czFGPPjLWFgGU/4yeYpVs1IhI=;
        b=EkOGAJYAG5Ic+eG8GpDyJrOI7Vk1vOnEtIpsP7BEqAiOWsDs1CBXUnXB9xOSIBSde7
         nmqWg/FhZT1k98H1QVPffgcoeHq1u+ntYJCqblnT4DUx8PAsZQ4ludbk+hDtappXD0bB
         Ga7/ttV5MvfIyheBzP2S5E54U2fKKlvqAjn/k+jzcrqaZboqcEEsMPMVf/M/LG25pKO1
         EFzh/n0dyKQDXfVx0DzY/oCAjdYpm8a8RRBImhjQQpEoMUp9QkWFK4dDdxlPjpe7nAo0
         KrgOu+S+kRm8vL7noViRiQcPjROPAJiF6uIZ7SO/uclGnCYTIP2oMBspmr4ZknNqndfE
         a/yw==
X-Gm-Message-State: AOJu0YzQByKVnL2NqEP0JBiqzAYwLaiiH1pF6NGEqC8sdyXVT93icz9B
	zQ0JlcOCKRJgShKV2TSeLhUTWLTHrMbBBKcjJv8I3g3MszFf+8ubVwVkcA==
X-Google-Smtp-Source: AGHT+IFAeMBP8tAitjI11TL1uV/1gI4haE66d49MMX5MBxQHIJRfV4KHy29pvBSq6jNxtjn6+7lLFQ==
X-Received: by 2002:a05:6830:b85:b0:6eb:7510:92d3 with SMTP id a5-20020a0568300b8500b006eb751092d3mr4099985otv.11.1713458112273;
        Thu, 18 Apr 2024 09:35:12 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:6fe6:94b6:ddee:aa05])
        by smtp.gmail.com with ESMTPSA id i5-20020a9d53c5000000b006e695048ad8sm376391oth.66.2024.04.18.09.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 09:35:11 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v2 0/2] Update a struct_ops link through a pinned path
Date: Thu, 18 Apr 2024 09:35:07 -0700
Message-Id: <20240418163509.719335-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Applications already have the ability to update a struct_ops link with
another struct_ops map. However, they were unable to open pinned paths
of the links. This implies that updating a link through its pinned
paths was not feasible. By allowing the "open" operator on pinned
paths, applications can pin a struct_ops link and update the link
through the pinned path later.

---
Changes from v1:

 - Fix a link time error for the case that CONFIG_BPF_JIT is not
   enabled. (Reported by kernel test robot)

v1: https://lore.kernel.org/all/20240417002513.1534535-1-thinker.li@gmail.com/

Kui-Feng Lee (2):
  bpf: enable the "open" operator on a pinned path of a struct_osp link.
  selftests/bpf: open a pinned path of a struct_ops link.

 include/linux/bpf.h                           |  6 ++
 kernel/bpf/bpf_struct_ops.c                   | 10 ++++
 kernel/bpf/inode.c                            | 11 +++-
 kernel/bpf/syscall.c                          | 16 +++++-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  6 ++
 .../bpf/prog_tests/test_struct_ops_module.c   | 56 +++++++++++++++++++
 6 files changed, 101 insertions(+), 4 deletions(-)

-- 
2.34.1


