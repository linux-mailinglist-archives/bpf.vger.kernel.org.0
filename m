Return-Path: <bpf+bounces-347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDB36FF68F
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 17:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A691E2817F7
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 15:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2CE4695;
	Thu, 11 May 2023 15:57:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40722443A
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 15:57:47 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A93BD
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 08:57:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a75194eebso10890344276.1
        for <bpf@vger.kernel.org>; Thu, 11 May 2023 08:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683820664; x=1686412664;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rmh9GuA16p2iajCMfr1h77IyL/RFuwU8XHRCYnx838w=;
        b=jVmPrTukbXDj014CWYXGKSXj7G7A2koGzQXDV/Ahvi6Dz1GwrZQC1m6/f2+anAwh7n
         A9g01XtszNkgOyc43aqaP0xWX3ULW9LkGJQD0/gHSEx5XeJlp348qqIMrW3I8WbEHbrD
         +WW4qrtq1AhCjmWZa8Lan0Y1BxovGxPMeGFSjJKGSz6l1gewnHhFE02mSm3tN0aVpCBl
         iuZhXQM9g6ggl4hVkS7oO+0lZyOx37XC6/gtJeQhHA3UNcbVUg/uZrk8yq9mSlkUU/Wb
         Hn25DLMuhBS8PrJnLwfZYAvEg4VCfe2ybyu5T1E/+MXBq/md52UJBpfq9LomlWNZnRAp
         HjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683820664; x=1686412664;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rmh9GuA16p2iajCMfr1h77IyL/RFuwU8XHRCYnx838w=;
        b=SRaQFUVbeYNYS6yziy6RqRu8oWQ1iwnU+8JXtYLTnZVgjU+b3Yo7CHuAf+9lpk0uLq
         axIMTxLAowk2XT1ahPurLoWsrryYSSfVpj4Ocuyn7wBcQlQQmFgi+ucIqo395J2LoKCx
         iU/vA4FzOPoDl5a8WykTj/YbfJqUHwDuUEOtqCKDcCGKVvKAseyEcljAuU92gVQ/jj+Y
         NOxkThht2xfbfoExYkxbsJpcdGepU+EqEqREzhZuA9VYutVOYs90MJ4GLky10Aa/f6pI
         bqOmZqJW0pFkkdt3oYIj2HZCiVbbKAq6ky1eHI84qSkLG0IdrZE9wMcS1MO0Yzux0wvD
         22kA==
X-Gm-Message-State: AC+VfDymgK8d0XEvA3vekILy/WfZmV2rq1SsTkU3nZUu37Dsi13OrLW/
	vTpk3FeRoWW8OUJ6ptDM8oIDFwsyaOJde1tVVGMEMdKiyXymL3Gr5/omKoNmKHnxiU2GyJhqcBA
	w8ITOnHSXtVBqFBJqkXO9L2qFsyuTKmHpVJC3KDpdbTZEWtuhBA==
X-Google-Smtp-Source: ACHHUZ6p5u9RHk+T4c1j+WQdcUeE/CtP+ltftm9+P3BG0M2iZhNU2lWZPkBHwTGU5i2W4wQ1Ym32rFI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:bfd0:0:b0:ba1:be7d:fbe3 with SMTP id
 q16-20020a25bfd0000000b00ba1be7dfbe3mr13470655ybm.11.1683820664358; Thu, 11
 May 2023 08:57:44 -0700 (PDT)
Date: Thu, 11 May 2023 08:57:36 -0700
In-Reply-To: <20230511155740.902548-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230511155740.902548-1-sdf@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230511155740.902548-2-sdf@google.com>
Subject: [PATCH bpf-next v5 0/4] bpf: Don't EFAULT for {g,s}setsockopt with
 wrong optlen
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

optval larger than PAGE_SIZE leads to EFAULT if the BPF program
isn't careful enough. This is often overlooked and might break
completely unrelated socket options. Instead of EFAULT,
let's ignore BPF program buffer changes. See the first patch for
more info.

In addition, clearly document this corner case and reset optlen
in our selftests (in case somebody copy-pastes from them).

v5:
- goto in the selftest (Martin)
- set IP_TOS to zero to avoid endianness complications (Martin)

v4:
- ignore retval as well when optlen > PAGE_SIZE (Martin)

v3:
- don't hard-code PAGE_SIZE (Martin)
- reset orig_optlen in getsockopt when kernel part succeeds (Martin)

Stanislav Fomichev (4):
  bpf: Don't EFAULT for {g,s}setsockopt with wrong optlen
  selftests/bpf: Update EFAULT {g,s}etsockopt selftests
  selftests/bpf: Correctly handle optlen > 4096
  bpf: Document EFAULT changes for sockopt

 Documentation/bpf/prog_cgroup_sockopt.rst     |  57 ++++++++-
 kernel/bpf/cgroup.c                           |  15 +++
 .../bpf/prog_tests/cgroup_getset_retval.c     |  20 ++++
 .../selftests/bpf/prog_tests/sockopt.c        |  99 +++++++++++++++-
 .../bpf/prog_tests/sockopt_inherit.c          |  59 +++-------
 .../selftests/bpf/prog_tests/sockopt_multi.c  | 108 +++++-------------
 .../bpf/prog_tests/sockopt_qos_to_cc.c        |   2 +
 .../progs/cgroup_getset_retval_getsockopt.c   |  13 +++
 .../progs/cgroup_getset_retval_setsockopt.c   |  17 +++
 .../selftests/bpf/progs/sockopt_inherit.c     |  18 ++-
 .../selftests/bpf/progs/sockopt_multi.c       |  26 ++++-
 .../selftests/bpf/progs/sockopt_qos_to_cc.c   |  10 +-
 .../testing/selftests/bpf/progs/sockopt_sk.c  |  25 ++--
 13 files changed, 330 insertions(+), 139 deletions(-)

-- 
2.40.1.521.gf1e218fcd8-goog


