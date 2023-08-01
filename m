Return-Path: <bpf+bounces-6560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 131DE76B771
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 16:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43A9F1C2084C
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 14:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3456253B6;
	Tue,  1 Aug 2023 14:29:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB9925172
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 14:29:28 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814AF1712
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 07:29:27 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-686efa1804eso4094148b3a.3
        for <bpf@vger.kernel.org>; Tue, 01 Aug 2023 07:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690900167; x=1691504967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dzUDq+8u7ms+V2tLcleeJtdT26GHWBF4eVU/17kNe7M=;
        b=JD8U1F2n+jFyS133ihx+Oj0W9g6rBmZ8HF1u2Rhhd4TLWib/TLAsV59uSIfEtmAHTS
         9LOAhXpkYkVIzIHCmaFNjYJMPnn5R7P+ubnd5Rvq4WcaPCgs6RrQyca2AdY8tqCqsnCG
         8fBI0YsyM9/U+S1+UjgwlLeY+z4X0g9Zkv/uuzxD/a6ZU3wy8Ad18XMZ40fJUxdvOVCC
         47YB6dvZjanfpixRCmXTYGi3D5Gs07pSI8y/q+Jf/5LxiG4sVzFuBcTGm1WaAOm2IDHE
         PMRtbmmEcZaVcIUuooBojI7TlvOtP2MzJGpuQodrpz3r77sC6pkg4sFHxBlLSozLIAC3
         QjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690900167; x=1691504967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dzUDq+8u7ms+V2tLcleeJtdT26GHWBF4eVU/17kNe7M=;
        b=Beph5EouVCOfwbkg3uNV5bjMSKvWRBxbkSYAqkeiyoRv7JxThqPB6dMBmO3EItNqlg
         29RmcIUp2DQ8xC5Bulm0oMCQ4Z/zpFIloSCut33zOOgu9Fl0iGWUV3YQZ0HzZOKT8btA
         M97QsNjN/9mhYbuy3dpu9Cbl6y8Zn9pyGyiuYIaWTQS4lLRMu5vhaQJ+utStAtrsdgFf
         q6T7ZkSWEUhlH0o/w92vJaQ4Mw8sU+3AfNk4K0lUBi7W+B1ZdxAwlUJVWf3JeBT6JMp5
         9oH18YYwgh1bqEcBp1NH2RnVNrLNInMKVc/VfTIjXx3JhtJx6sOrH6vi8JCX/2GeP00/
         IiSw==
X-Gm-Message-State: ABy/qLbmiNC628JgBvybFIL31qsaTkMqL62mDVfdEnUXhz7tf6y2QZMR
	iOzxVLMxkfKZAt5/GykGAxBPS8emFQVCpVOy
X-Google-Smtp-Source: APBJJlE/lP5A3XAibZcr7AE/HCNPQbEGuEaA9B8vN871Az4zxEkUeqon2tNVH/HH7zXZlTNC6y8kzA==
X-Received: by 2002:a05:6a20:3ca3:b0:13d:ea25:9656 with SMTP id b35-20020a056a203ca300b0013dea259656mr5830608pzj.60.1690900166829;
        Tue, 01 Aug 2023 07:29:26 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:1409:5400:4ff:fe86:cf7a])
        by smtp.gmail.com with ESMTPSA id n2-20020aa79042000000b00686a80f431dsm9391491pfo.126.2023.08.01.07.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 07:29:26 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 0/3] bpf: Add new bpf helper bpf_for_each_cpu 
Date: Tue,  1 Aug 2023 14:29:09 +0000
Message-Id: <20230801142912.55078-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Some statistic data is stored in percpu pointer but the kernel doesn't
aggregate it into a single value, for example, the data in struct
psi_group_cpu.

Currently, we can traverse percpu data using for_loop and bpf_per_cpu_ptr:

  for_loop(nr_cpus, callback_fn, callback_ctx, 0)

In the callback_fn, we retrieve the percpu pointer with bpf_per_cpu_ptr().
The drawback is that 'nr_cpus' cannot be a variable; otherwise, it will be
rejected by the verifier, hindering deployment, as servers may have
different 'nr_cpus'. Using CONFIG_NR_CPUS is not ideal.

Alternatively, with the bpf_cpumask family, we can obtain a task's cpumask.
However, it requires creating a bpf_cpumask, copying the cpumask from the
task, and then parsing the CPU IDs from it, resulting in low efficiency.
Introducing other kfuncs like bpf_cpumask_next might be necessary.

A new bpf helper, bpf_for_each_cpu, is introduced to conveniently traverse
percpu data, covering all scenarios. It includes
for_each_{possible, present, online}_cpu. The user can also traverse CPUs
from a specific task, such as walking the CPUs of a cpuset cgroup when the
task is in that cgroup.

In our use case, we utilize this new helper to traverse percpu psi data.
This aids in understanding why CPU, Memory, and IO pressure data are high
on a server or a container.

Due to the __percpu annotation, clang-14+ and pahole-1.23+ are required.

Yafang Shao (3):
  bpf: Add bpf_for_each_cpu helper
  cgroup, psi: Init root cgroup psi to psi_system
  selftests/bpf: Add selftest for for_each_cpu

 include/linux/bpf.h                                |   1 +
 include/linux/psi.h                                |   2 +-
 include/uapi/linux/bpf.h                           |  32 +++++
 kernel/bpf/bpf_iter.c                              |  72 +++++++++++
 kernel/bpf/helpers.c                               |   2 +
 kernel/bpf/verifier.c                              |  29 ++++-
 kernel/cgroup/cgroup.c                             |   5 +-
 tools/include/uapi/linux/bpf.h                     |  32 +++++
 .../selftests/bpf/prog_tests/for_each_cpu.c        | 137 +++++++++++++++++++++
 .../selftests/bpf/progs/test_for_each_cpu.c        |  63 ++++++++++
 10 files changed, 372 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/for_each_cpu.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_for_each_cpu.c

-- 
1.8.3.1


