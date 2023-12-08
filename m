Return-Path: <bpf+bounces-17117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D4E809EC7
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 10:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13C0E28179C
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 09:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88F1111BA;
	Fri,  8 Dec 2023 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0veBBsu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118EF10F9;
	Fri,  8 Dec 2023 01:06:42 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6ce94f62806so1165707b3a.1;
        Fri, 08 Dec 2023 01:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702026401; x=1702631201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2IrPOz/8by0LW+ZXpdHmOYEBXgQ83FE/Z1Ywlb/RzOI=;
        b=g0veBBsuUhPQIXZ8LT7oRF8U7nuZcKuEBOaZe3qtS2QeGCVR60zQqCRR4FG4kdIO/6
         3dH5fTF+vaWwXXGY5oB3W+dEWWJ9CdEg++POQi/ogtDsc9m3JRrhJjwqi1B9dvllnokY
         i+YOsetVmhbwaxvbL+Oa7eGIzQLUimLlqetd4djBNbIjXp+f4vH1rnakOYkRHt3+w/lZ
         v3QwEi84qgxjloUx2LokMEO9a2YM9p/Cyu9taIz8joV2CiRK+IpQgJr8rP3XAWw+Opz3
         hWkgFBYnrYaTdBGO9QGfPj7kY5Nd8gaNEft4JxXXcWl+Kwq9JOdmO+TXm97gKlqqktpO
         gA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702026401; x=1702631201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2IrPOz/8by0LW+ZXpdHmOYEBXgQ83FE/Z1Ywlb/RzOI=;
        b=DJNnbAuPGEfRWwvq4pcYsu/QDWu4p9IEERNt+4JJAPs+A9KGcaYEjGzUBQY9Ox/X+g
         tyRkIGEW8maGhOUBOZi0SSrDbrUxmUuMqrCWyfe1xCa0pNXpH06t/9wXym6H23UYBeRu
         xDNLonLVy2O5dl4JAu3H5dAehLgRPOL5xhPjak9l0WDCXkKp4f9r+wg7SEXGvQpSACmr
         inhQEwlMmwT1HTzpSHXxgn0EzS/4VS3UaiTSjWFre2Wzrk4rhVNsK1W6iNFqO1+YO4n6
         lyWzgtQfcy5eIQ4wkd8lyuf530KQPZKr7ftrNg3yw4PeBuiCpZP8WEOCxiyhi4WJ2fYW
         NT+w==
X-Gm-Message-State: AOJu0YwbwWXOwEhEju5Krb+DKZnZzFwGf4jTn/dc7CjFGMHUAqQ17k1p
	bKmsphX3Vz11YBwqJPHpJ0A=
X-Google-Smtp-Source: AGHT+IEwloQVBHKHPc8WxeOFsYuvL2ue3OBRhlcDaSIfQfrh9R50XJLjGOUuLw9YoK21Peh8o4hT0w==
X-Received: by 2002:a05:6a21:a5a7:b0:190:53f9:43ff with SMTP id gd39-20020a056a21a5a700b0019053f943ffmr134571pzc.45.1702026401492;
        Fri, 08 Dec 2023 01:06:41 -0800 (PST)
Received: from vultr.guest ([2001:19f0:ac00:4055:5400:4ff:fead:3bd0])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902ee5500b001d057080022sm1188173plo.20.2023.12.08.01.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 01:06:40 -0800 (PST)
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
Subject: [PATCH v4 0/5] mm, security, bpf: Fine-grained control over memory policy adjustments with lsm bpf
Date: Fri,  8 Dec 2023 09:06:17 +0000
Message-Id: <20231208090622.4309-1-laoar.shao@gmail.com>
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
- v3 -> v4: 
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

 .../admin-guide/mm/numa_memory_policy.rst          | 27 ++++++++
 include/linux/lsm_hook_defs.h                      |  3 +
 include/linux/security.h                           |  9 +++
 include/uapi/linux/mempolicy.h                     |  2 +-
 mm/mempolicy.c                                     |  8 +++
 security/security.c                                | 13 ++++
 security/selinux/hooks.c                           |  8 +++
 security/selinux/include/classmap.h                |  2 +-
 .../selftests/bpf/prog_tests/set_mempolicy.c       | 81 ++++++++++++++++++++++
 .../selftests/bpf/progs/test_set_mempolicy.c       | 28 ++++++++
 10 files changed, 179 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/set_mempolicy.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_set_mempolicy.c

-- 
1.8.3.1


