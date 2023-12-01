Return-Path: <bpf+bounces-16363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B37AB800763
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 10:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 707BE281AAA
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 09:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D64B1DFC0;
	Fri,  1 Dec 2023 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jx/VPp5a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DC113E;
	Fri,  1 Dec 2023 01:47:07 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d04c097e34so2721295ad.0;
        Fri, 01 Dec 2023 01:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701424026; x=1702028826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MSQwZzhnajRqkX+xa7n/aRnDDu+LcQrNX6wmLbUqn44=;
        b=Jx/VPp5as8p7jfndZ1ntJXI8DVhs/Nar9iA710vRvi64Lve5VsKR+AlHog5Sv2q5dz
         uwp203cNSxBRln5Y5kPA/RUVw5/MfljEp73DD/hecDKdjJtR5SM2F1iGfACAO0JO2ebO
         toFTOjK72fe8VJYuftGmTlVpJMeP0w9RjiBUpq3fPKdMcB50Tt7oFr7pHOjmWW+W6NAt
         5RtWuL6RUCIgfcRfemroCDw6PqpWh4SuHnl1yMWRcYmu7ws+HuDf8Gch2JIC/lIINpJj
         KX1ERlAvIITPuzEMGLdtmuqMUrNRVBmLae6uuN4uSQelunPDja6c03f10qES2Zq5nVOb
         /Nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701424026; x=1702028826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MSQwZzhnajRqkX+xa7n/aRnDDu+LcQrNX6wmLbUqn44=;
        b=g5v1PbyEdP+XSJgbM1oh2yyVC2ePIYRDgh4jlAV1gLzFWRf7K08y2R9wcV1yHAOe4L
         CQ8fVBAQKLy43RK/t8Zb5Hj+fusRwezThNKhZc4Ee333CXs9N/+7pmuKkAUYhu5IZhb9
         v8bVmpkFfxsY8Y7dTiH+Xf2Agf7XK0q1m+tKsg/WbToBjSpF5Egu/VZ5hiagk/Pnoz1F
         vp9mp5XONBISn1P/QJV8NznNBiE68DuM6HscF8sa1uPBaNWsZn7QYM5OxgiOv+1JQBP3
         aEEaVW7scXFmn4Z9jwB4Y9GEBeVJVl0uiOCpuRz+/V7HMLsUI5IJiI7zY18TchUZE9dv
         01bg==
X-Gm-Message-State: AOJu0YzcggN2bKIHBwryQi0uv92X83fOZ/CwWKY505jt4A2RYkOmJQG8
	RPZ/8+FDU+8sg8NeEH3xNWw=
X-Google-Smtp-Source: AGHT+IGmotwUO4OKYMRU7spFszJBT86c3qy/herBn8J5gOFNgpuPDtjJOMaHjQCwebSs4WVxmj2u7w==
X-Received: by 2002:a17:902:8485:b0:1cf:fb96:9692 with SMTP id c5-20020a170902848500b001cffb969692mr13632650plo.12.1701424026350;
        Fri, 01 Dec 2023 01:47:06 -0800 (PST)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902b78600b001bdd7579b5dsm2875534pls.240.2023.12.01.01.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 01:47:05 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	omosnace@redhat.com,
	mhocko@suse.com,
	ying.huang@intel.com
Cc: linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	ligang.bdlg@bytedance.com,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 0/7] mm, security, bpf: Fine-grained control over memory policy adjustments with lsm bpf
Date: Fri,  1 Dec 2023 09:46:29 +0000
Message-Id: <20231201094636.19770-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Background
==========

In our containerized environment, we've identified unexpected OOM events
where the OOM-killer terminates tasks despite having ample free memory.
This anomaly is traced back to tasks within a container using mbind(2) to
bind memory to a specific NUMA node. When the allocated memory on this node
is exhausted, the OOM-killer, prioritizing tasks based on oom_score,
indiscriminately kills tasks. 

The Challenge 
=============
In a containerized environment, independent memory binding by a user can
lead to unexpected system issues or disrupt tasks being run by other users
on the same server. If a user genuinely requires memory binding, we will
allocate dedicated servers to them by leveraging kubelet deployment.

Currently, users possess the ability to autonomously bind their memory to
specific nodes without explicit agreement or authorization from our end.
It's imperative that we establish a method to prevent this behavior.

Proposed Solution
=================

- Capability
  Currently, any task can perform MPOL_BIND without specific capabilities.
  Enforcing CAP_SYS_RESOURCE or CAP_SYS_NICE could be an option, but this
  may have unintended consequences. Capabilities, being broad, might grant
  unnecessary privileges. We should explore alternatives to prevent
  unexpected side effects.

- LSM 
  Introduce LSM hooks for syscalls such as mbind(2) and set_mempolicy(2)
  to disable MPOL_BIND. This approach is more flexibility and allows for
  fine-grained control without unintended consequences. A sample LSM BPF
  program is included, demonstrating practical implementation in a
  production environment.

- seccomp
  seccomp is relatively heavyweight, making it less suitable for
  enabling in our production environment:
  - Both kubelet and containers need adaptation to support it.
  - Dynamically altering security policies for individual containers
    without interrupting their operations isn't straightforward.

Future Considerations
=====================

In addition, there's room for enhancement in the OOM-killer for cases
involving CONSTRAINT_MEMORY_POLICY. It would be more beneficial to
prioritize selecting a victim that has allocated memory on the same NUMA
node. My exploration on the lore led me to a proposal[0] related to this
matter, although consensus seems elusive at this point. Nevertheless,
delving into this specific topic is beyond the scope of the current
patchset.

[0]. https://lore.kernel.org/lkml/20220512044634.63586-1-ligang.bdlg@bytedance.com/

Changes:
- RCC v2 -> v3:
  - Add MPOL_F_NUMA_BALANCING man-page (Ying)
  - Fix bpf selftests error reported by bot+bpf-ci
- RFC v1 -> RFC v2: https://lwn.net/Articles/952339/
  - Refine the commit log to avoid misleading
  - Use one common lsm hook instead and add comment for it
  - Add selinux implementation
  - Other improments in mempolicy
- RFC v1: https://lwn.net/Articles/951188/

Yafang Shao (6):
  mm, doc: Add doc for MPOL_F_NUMA_BALANCING
  mm: mempolicy: Revise comment regarding mempolicy mode flags
  mm, security: Fix missed security_task_movememory()
  mm, security: Add lsm hook for memory policy adjustment
  security: selinux: Implement set_mempolicy hook
  selftests/bpf: Add selftests for set_mempolicy with a lsm prog

 .../admin-guide/mm/numa_memory_policy.rst     | 27 +++++++
 include/linux/lsm_hook_defs.h                 |  3 +
 include/linux/security.h                      |  9 +++
 include/uapi/linux/mempolicy.h                |  2 +-
 mm/mempolicy.c                                | 22 ++++-
 security/security.c                           | 13 +++
 security/selinux/hooks.c                      |  8 ++
 security/selinux/include/classmap.h           |  2 +-
 .../selftests/bpf/prog_tests/set_mempolicy.c  | 81 +++++++++++++++++++
 .../selftests/bpf/progs/test_set_mempolicy.c  | 28 +++++++
 10 files changed, 192 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/set_mempolicy.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_set_mempolicy.c

NOT kernel:

Yafang Shao (1):
NOT kernel/man2/mbind.2: Add mode flag MPOL_F_NUMA_BALANCING

-- 
2.30.1 (Apple Git-130)


