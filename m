Return-Path: <bpf+bounces-14865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAAE7E89F5
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 10:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70601C2098C
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 09:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EAF111B0;
	Sat, 11 Nov 2023 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khPAwfcf"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E19E79C1
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 09:00:41 +0000 (UTC)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26013C3C
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 01:00:39 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-565334377d0so2169739a12.2
        for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 01:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699693239; x=1700298039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N7aDjCm6516towkc8s0NY2Xk/cCkvCpRM+cHbg6i96Y=;
        b=khPAwfcfGB+YwX5m1/ghbqOl8BZGUwsuyT/AmPzRREdtanw8/uJUGtp/m0mfuWisco
         Y8euSHJKC6w80pbJFSCcMcYlz0RU/XIG9+S/jW8ZVhpvU3GQU4SdF7+FBb3DP0GWfBHd
         zChkKSK2atSgMHUH+fRVTFve4/YK/H9pQfVzDXzzghCslp9SitQoFxEqC/pF0G7X2KwI
         k+LMhSs08f/FVU9cjjXfHWGNIiu8X5Tx+KZed/g3gcfyAMIew4T3Spdm52WpIdvLHYUW
         n/Dr50cbuo8gE3Hix3rxVZ7AKit5nw7Kz1Nci0YI0qMJH7uQssQq+updjq3mYpFRBbck
         5dPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699693239; x=1700298039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N7aDjCm6516towkc8s0NY2Xk/cCkvCpRM+cHbg6i96Y=;
        b=R4XFsz9+oNrGT68SzG7qbD2m+9eOCZktwm3f4QxGs8h2FgUoAenX6tIt14POHx9CML
         IMk5wedp32R9wxTNWUksKcurO3AX+jsaYQ1cNE1RiTTkMMo1fYU8qg/vfQ0gyy+KrbMc
         MGO2SWR5SCBKXcQYtmwNbtAwjrrg2qgCr3CHB7LmsyOuUSflSaTtYLRhzuSZuRscsP6H
         6iMoAq4W3ofpf5jgsFs1orEEaBOMytgaT23tu+TcZdv1UCQQCEdgmdqHwcY6NkDSedm9
         t8rwjihiwuNgKDwV4UcD+Kmn9iZm4JMyLLMfiFXYk4bbamPz+LPmVUI3cqEoae/yb3xX
         bH7Q==
X-Gm-Message-State: AOJu0Yzb5kt7vzWpzWzmdNNeVDUEs3wJIQR5FTDMpYsmULN46w+U5E2H
	9F7dAfeNer2Y4eGe/x2ntoq5Kf3eGXFNL5YI
X-Google-Smtp-Source: AGHT+IGa/MS1lIF7CKGN2ODLIjC6k9nV4TWzf7nrTzzTWBLin1YBAKnVS6WLslCBGfnzeyxFwNhFNg==
X-Received: by 2002:a05:6a21:6d87:b0:136:faec:a7dc with SMTP id wl7-20020a056a216d8700b00136faeca7dcmr2172952pzb.11.1699693239356;
        Sat, 11 Nov 2023 01:00:39 -0800 (PST)
Received: from vultr.guest ([45.63.84.83])
        by smtp.gmail.com with ESMTPSA id fh38-20020a056a00392600b006b2e07a6235sm894254pfb.136.2023.11.11.01.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 01:00:38 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	tj@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 bpf-next 0/6] bpf: Add support for cgroup1, BPF part 
Date: Sat, 11 Nov 2023 09:00:28 +0000
Message-Id: <20231111090034.4248-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the BPF part of the series "bpf, cgroup: Add BPF support for
cgroup1 hierarchy" with adjustment in the last two patches compared
to the previous one.

v3->v4:
  - use subsys_name instead of cgrp_name in get_cgroup_hierarchy_id()
    (Tejun)
  - use local bpf_link instead of modifying the skeleton in the
    selftests
v3: https://lwn.net/Articles/949264/

Yafang Shao (6):
  bpf: Add a new kfunc for cgroup1 hierarchy
  selftests/bpf: Fix issues in setup_classid_environment()
  selftests/bpf: Add parallel support for classid
  selftests/bpf: Add a new cgroup helper get_classid_cgroup_id()
  selftests/bpf: Add a new cgroup helper get_cgroup_hierarchy_id()
  selftests/bpf: Add selftests for cgroup1 hierarchy

 kernel/bpf/helpers.c                               |  20 +++
 tools/testing/selftests/bpf/cgroup_helpers.c       | 116 ++++++++++++---
 tools/testing/selftests/bpf/cgroup_helpers.h       |   4 +-
 .../selftests/bpf/prog_tests/cgroup1_hierarchy.c   | 158 +++++++++++++++++++++
 .../testing/selftests/bpf/prog_tests/cgroup_v1v2.c |   2 +-
 .../selftests/bpf/progs/test_cgroup1_hierarchy.c   |  72 ++++++++++
 6 files changed, 353 insertions(+), 19 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup1_hierarchy.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c

-- 
1.8.3.1


