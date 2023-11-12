Return-Path: <bpf+bounces-14914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4AA7E8EF1
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 08:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FF66280CC9
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 07:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9F45CAF;
	Sun, 12 Nov 2023 07:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLBVwpyH"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBFA5397
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 07:35:06 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65AF2D77;
	Sat, 11 Nov 2023 23:35:04 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c9b7c234a7so30563995ad.3;
        Sat, 11 Nov 2023 23:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699774504; x=1700379304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hTE/8bAfe9m2x3uZl0zATPmiaV/MvY+WvngHd7GFoLg=;
        b=FLBVwpyHz9+XzAl/swsRXeg54bC+Zp4Ik0I6GdrnCMOw6V0IUseDoj1Sp9r38U0PuW
         t8R9rccbbohmFAHlTrpHVNnSiRoFy85XFz9zbTQ55Z3STxM1q+DTmfMrEUZ72x8L8Kq9
         tnfubKpf4fUA+h+KyW/McK7JMDAXLmPwgwH7ZlNncJb7xHqVge+r37VospMbhlAlsQ0Q
         V1e7JLSj9/aX4GgtRPrWV2V8889Zd9hZkZc86ALoZ3mXf9L7OVGhgJR87KW6S24GG1BF
         bp6fZ8B9EyKend71s5iS9QwwBE6U4bm7HOSOzCjwP9DA8cyaIfReTMGEOPK4ZG6c1pH1
         noDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699774504; x=1700379304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hTE/8bAfe9m2x3uZl0zATPmiaV/MvY+WvngHd7GFoLg=;
        b=ReUZ+F+HeRqq8Vn8rHGnh55gH33Ww3TO3+dZckbevXKNlhaLXkNuAk/wULQyYx/ZYn
         odAEI1KxZoCqIkDZ95FLyRNprxdc926N9uE0G/TsEtpv8tVNtPci+QeYrZYW4GEp+I+A
         q39e0VcdvX3T+Pm47l54/gPc6BiY7IeD7otvFLvAvGQ7iKYBvSAPagvDMQhXX48st1UW
         UYNqTSxGSSAh7FKZdpk+R5XsUqhYDg4u+cX6RC5Gz8PLmjxoHyKG0FatA9ljmT22rpHg
         zS1IUDCY/8Z92P08oh39n1VVGMO9fOMA32i9IiCRGFqDOEU9LJK787XDHXArp7sasMlt
         cbsQ==
X-Gm-Message-State: AOJu0Yypv9DKUpwYhg0Z62FTb6jhvAJIeNU+pAHtHIpzQR3t0HO6lhRD
	cGfSt9TgJRFAFuxyjUsn1Cjs3HVzektC7tUz
X-Google-Smtp-Source: AGHT+IEOhLam9DwI+UQW5ovCf1qGG2QFJv6o6NvB0SmJkGtdtaNwnDhDO5OZmwkM0jQ4jQhz4FuozA==
X-Received: by 2002:a17:902:cec1:b0:1cc:543b:b361 with SMTP id d1-20020a170902cec100b001cc543bb361mr5542234plg.43.1699774504223;
        Sat, 11 Nov 2023 23:35:04 -0800 (PST)
Received: from vultr.guest ([2001:19f0:ac00:49b3:5400:4ff:fea5:2304])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c10600b001ca4c20003dsm2217394pli.69.2023.11.11.23.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 23:35:03 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	ligang.bdlg@bytedance.com,
	mhocko@suse.com,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH -mm 0/4] mm, security, bpf: Fine-grained control over memory policy adjustments with lsm bpf
Date: Sun, 12 Nov 2023 07:34:20 +0000
Message-Id: <20231112073424.4216-1-laoar.shao@gmail.com>
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
indiscriminately kills tasks. This becomes more critical with guaranteed
tasks (oom_score_adj: -998) aggravating the issue.

The selected victim might not have allocated memory on the same NUMA node,
rendering the killing ineffective. This patch aims to address this by
disabling MPOL_BIND in container environments.

In the container environment, our aim is to consolidate memory resource
control under the management of kubelet. If users express a preference for
binding their memory to a specific NUMA node, we encourage the adoption of
a standardized approach. Specifically, we recommend configuring this memory
policy through kubelet using cpuset.mems in the cpuset controller, rather
than individual users setting it autonomously. This centralized approach
ensures that NUMA nodes are globally managed through kubelet, promoting
consistency and facilitating streamlined administration of memory resources
across the entire containerized environment.

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

Yafang Shao (4):
  mm, security: Add lsm hook for mbind(2)
  mm, security: Add lsm hook for set_mempolicy(2)
  mm, security: Add lsm hook for set_mempolicy_home_node(2)
  selftests/bpf: Add selftests for mbind(2) with lsm prog

 include/linux/lsm_hook_defs.h                      |  8 +++
 include/linux/security.h                           | 26 +++++++
 mm/mempolicy.c                                     | 13 ++++
 security/security.c                                | 19 ++++++
 tools/testing/selftests/bpf/prog_tests/mempolicy.c | 79 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_mempolicy.c | 29 ++++++++
 6 files changed, 174 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/mempolicy.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_mempolicy.c

-- 
1.8.3.1


