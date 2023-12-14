Return-Path: <bpf+bounces-17816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13955813090
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 13:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEAB31F22025
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 12:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92554E624;
	Thu, 14 Dec 2023 12:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elxbenkZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA80115;
	Thu, 14 Dec 2023 04:51:42 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1d34a6b3566so11717285ad.2;
        Thu, 14 Dec 2023 04:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702558301; x=1703163101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oj0iJvkscsu8K8KTKJIWnYWXUHTwTNv0Yge5CoUg6vU=;
        b=elxbenkZ39V/BVDtXBENcOxvQ7Qg24U/Zr4DJvk33OoIVYepvdqJT/vN69rqxM3pbN
         nfwQtUf714P27+SAuCLmPrZJXLqAj6/kV/hPgQ94QioKv5FI5U5/MFtwd1j9jjEEolx6
         V4eL+yKfVh7tt4mQY1LWNjFRwJi/h3naTn4/SDZpEm3/CNR4a/xB/PIk/I+gynyedrap
         c4biU+vK6opQk6j/ehQJLuFFmmAhVGTY7G/9qTlWMQDDMWMeb2E8UcNVqDwbmtTlzm/Z
         DQKDNsXSN0afV0ASGQShQsfmvIkMGIhiIB/IpPVHuderUqQfszka2sNCePOSdfPmBRcm
         Dp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702558301; x=1703163101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oj0iJvkscsu8K8KTKJIWnYWXUHTwTNv0Yge5CoUg6vU=;
        b=GiFcedw0MAiR4k1s9oA6wdLphdR0GzuTIifEXRorlTiGOe+xYgFwJIgwCCGwqt3YTL
         uZwpny8BWeS7MRfAPbgACsWneMFKGWgprxL4EvdGuCRhSmyE3YLmcvvyLM8Fr2VC/npk
         xCQpSm6GXifW8tQT238w/uWnzQFotd+irlAPhWY+naoeE5cBsTeRcER2CT2YacXqCJGk
         xXoKqia4r/G7vGlfcb4d3BQUcZCrcyA0YBsfa2PBxO+Z1F4FTWNHBUf7jgZiwRVaS6nm
         ZdyswrHteI/8O1UPgD1n0bcauALxJPkb2wBgQs2GnwvcwU7iPy3qoMQHxb2Fj89y1tDT
         K4UQ==
X-Gm-Message-State: AOJu0YzlLPp+JtLbjqJ+QPNDT+5sBZMH0BAnJqEAc4nuiFliciQrdFq9
	xD3PruoAgwm4JKyeFt0/ZJg=
X-Google-Smtp-Source: AGHT+IFs2hng0mwsEvoC+hm8RAbM12yZWcwi7bTtTSObTgxyW6oPlqzYS1I/1EkUf9p4JKo1OFsXzQ==
X-Received: by 2002:a17:902:7004:b0:1d0:6ffd:ae23 with SMTP id y4-20020a170902700400b001d06ffdae23mr4335630plk.138.1702558301453;
        Thu, 14 Dec 2023 04:51:41 -0800 (PST)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id jj17-20020a170903049100b001d36b2e3dddsm1184528plb.192.2023.12.14.04.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 04:51:40 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	omosnace@redhat.com,
	casey@schaufler-ca.com,
	kpsingh@kernel.org,
	mhocko@suse.com,
	ying.huang@intel.com
Cc: linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	ligang.bdlg@bytedance.com,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 bpf-next 0/5] mm, security, bpf: Fine-grained control over memory policy adjustments with lsm bpf
Date: Thu, 14 Dec 2023 12:50:28 +0000
Message-Id: <20231214125033.4158-1-laoar.shao@gmail.com>
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
- v4 -> v5:
  - Revise the commit log in patch #5. (KP)
- v3 -> v4: https://lwn.net/Articles/954126/
  - Drop the changes around security_task_movememory (Serge) 
- RCC v2 -> v3: https://lwn.net/Articles/953526/
  - Add MPOL_F_NUMA_BALANCING man-page (Ying)
  - Fix bpf selftests error reported by bot+bpf-ci
- RFC v1 -> RFC v2: https://lwn.net/Articles/952339/
  - Refine the commit log to avoid misleading
  - Use one common lsm hook instead and add comment for it
  - Add selinux implementation
  - Other improments in mempolicy
- RFC v1: https://lwn.net/Articles/951188/

Yafang Shao (5):
  mm, doc: Add doc for MPOL_F_NUMA_BALANCING
  mm: mempolicy: Revise comment regarding mempolicy mode flags
  mm, security: Add lsm hook for memory policy adjustment
  security: selinux: Implement set_mempolicy hook
  selftests/bpf: Add selftests for set_mempolicy with a lsm prog

 .../admin-guide/mm/numa_memory_policy.rst          | 27 +++++++
 include/linux/lsm_hook_defs.h                      |  3 +
 include/linux/security.h                           |  9 +++
 include/uapi/linux/mempolicy.h                     |  2 +-
 mm/mempolicy.c                                     |  8 +++
 security/security.c                                | 13 ++++
 security/selinux/hooks.c                           |  8 +++
 security/selinux/include/classmap.h                |  2 +-
 .../selftests/bpf/prog_tests/set_mempolicy.c       | 84 ++++++++++++++++++++++
 .../selftests/bpf/progs/test_set_mempolicy.c       | 28 ++++++++
 10 files changed, 182 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/set_mempolicy.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_set_mempolicy.c

-- 
1.8.3.1


