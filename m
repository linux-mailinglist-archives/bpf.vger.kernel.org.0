Return-Path: <bpf+bounces-15648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D75A7F48B3
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 15:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EDDDB211D4
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 14:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7922A4C3CD;
	Wed, 22 Nov 2023 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBBIpDfd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF09101;
	Wed, 22 Nov 2023 06:16:19 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6c34e87b571so5506235b3a.3;
        Wed, 22 Nov 2023 06:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700662579; x=1701267379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gEFaC38G2s27p4sRXGudzDSfRCeLNbnrtzWPTvuPOrE=;
        b=mBBIpDfdRD158dyCUhvkxm5a2zMAI2AGBY+utO481YikNmyh2u2LN2hBXRy7cYDZmp
         NS80YyDNow07pRvew+e6gs+IODlJR/syxKbfxFOkq9RA0KlHKdQ5I3yYRlP2XC8ktsRB
         TloJD+DyZv4PVwAwhinSuvpHqvHiHV+GwnszxdOBKcjdXzZdxwFZr5a2I8z8CiE2AWMk
         N0KKujncAL4j73A55rgltObNu+r+dxdINGMfnEtGIaOWlkVAGONF3P2VE3p48xxuRYrX
         ELyv8GWEvoj9maO6Wf/mwHeTNJLYJdx8nPSbYstr/q60vrTiWBR5qkJOjX9pOL/BZJas
         d+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700662579; x=1701267379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gEFaC38G2s27p4sRXGudzDSfRCeLNbnrtzWPTvuPOrE=;
        b=l4BofyLpjjzr27wahjhHogFdBEbdHA9E/Y+N8XaGVqcdvAkUG2OLn5cEDRSRSRAbYG
         0Wep4j9gedlp72wv2tI/8yYjgtM4vHhoMJyo93ClXRj+GZ+I2fPZOx7Ql73jWDS113xG
         7RfiNcgSwaZmIqqSgCdgm1b7nagseIfTTcGV6mTY56FjKWvpWPi1zQgLIRppWdiVk52Y
         vYDGR3hcy2SOFUBoyd/5myhJKadKqz7dZwXRO6xbC2+/UfcV7onPUhqDw7EkkzarlDMI
         WHlGwT7tVYAEX6UzQjQtQ4z/2VEB2OxUIY7iFZqVNDSXVXa79HCY13CWOHRDSequkZoE
         zVSQ==
X-Gm-Message-State: AOJu0Yyb4LK5sK9d+MvWK5hSBb7vy4cha0Z4Swga3i4w3o/mEkuNtb1v
	W0UX9Kzm7dgUdAMJsznX7r3KrE85TRROkd6n
X-Google-Smtp-Source: AGHT+IFhmaA9eJSUL6Bl04UTu5jGhNUgNaEDGcrXHRztOb4CKetZJ/zl0FEet0evFRzuIE+jA8PGEA==
X-Received: by 2002:a05:6a20:7207:b0:187:58b0:337 with SMTP id y7-20020a056a20720700b0018758b00337mr1586648pzb.11.1700662578496;
        Wed, 22 Nov 2023 06:16:18 -0800 (PST)
Received: from vultr.guest ([2001:19f0:ac01:a71:5400:4ff:fea8:5687])
        by smtp.gmail.com with ESMTPSA id p18-20020a63fe12000000b0058988954686sm9356260pgh.90.2023.11.22.06.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 06:16:17 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	omosnace@redhat.com,
	mhocko@suse.com
Cc: linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	ligang.bdlg@bytedance.com,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v2 0/6] mm, security, bpf: Fine-grained control over memory policy adjustments with lsm bpf 
Date: Wed, 22 Nov 2023 14:15:53 +0000
Message-Id: <20231122141559.4228-1-laoar.shao@gmail.com>
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
============
In a containerized environment, independent memory binding by a user can
lead to unexpected system issues or disrupt tasks being run by other users
on the same server. If a user genuinely requires memory binding, we will
allocate dedicated servers to them by leveraging kubelet deployment.

Currently, users possess the ability to autonomously bind their memory to
specific nodes without explicit agreement or authorization from our end.
It's imperative that we establish a method to prevent this behavior.

Proposed Solutions
=================

- Introduce Capability to Disable MPOL_BIND
  Currently, any task can perform MPOL_BIND without specific capabilities.
  Enforcing CAP_SYS_RESOURCE or CAP_SYS_NICE could be an option, but this
  may have unintended consequences. Capabilities, being broad, might grant
  unnecessary privileges. We should explore alternatives to prevent
  unexpected side effects.

- Use LSM BPF to Disable MPOL_BIND
  Introduce LSM hooks for syscalls such as mbind(2), set_mempolicy(2), and
  set_mempolicy_home_node(2) to disable MPOL_BIND. This approach is more
  flexibility and allows for fine-grained control without unintended
  consequences. A sample LSM BPF program is included, demonstrating
  practical implementation in a production environment.

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

[0] https://lore.kernel.org/lkml/20220512044634.63586-1-ligang.bdlg@bytedance.com/


Changes:
- RFC v1 -> RFC v2:
  - Refine the commit log to avoid misleading
  - Use one common lsm hook instead and add comment for it
  - Add selinux implementation
  - Other improments in mempolicy
- RFC v1: https://lwn.net/Articles/951188/

Yafang Shao (6):
  mm, doc: Add doc for MPOL_F_NUMA_BALANCING
  mm: mempolicy: Revise comment regarding mempolicy mode flags
  mm, security: Fix missed security_task_movememory() in mbind(2)
  mm, security: Add lsm hook for memory policy adjustment
  security: selinux: Implement set_mempolicy hook
  selftests/bpf: Add selftests for set_mempolicy with a lsm prog

 .../admin-guide/mm/numa_memory_policy.rst     | 27 +++++++
 include/linux/lsm_hook_defs.h                 |  3 +
 include/linux/security.h                      |  9 +++
 include/uapi/linux/mempolicy.h                |  2 +-
 mm/mempolicy.c                                | 17 +++-
 security/security.c                           | 13 +++
 security/selinux/hooks.c                      |  8 ++
 security/selinux/include/classmap.h           |  2 +-
 tools/testing/selftests/bpf/Makefile          |  2 +-
 .../selftests/bpf/prog_tests/set_mempolicy.c  | 79 +++++++++++++++++++
 .../selftests/bpf/progs/test_set_mempolicy.c  | 29 +++++++
 11 files changed, 187 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/set_mempolicy.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_set_mempolicy.c

-- 
2.30.1 (Apple Git-130)


