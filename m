Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FF14100F8
	for <lists+bpf@lfdr.de>; Fri, 17 Sep 2021 23:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241803AbhIQV6t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 17:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhIQV6q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Sep 2021 17:58:46 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B0FC061574
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 14:57:24 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id dw14so7860615pjb.1
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 14:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0L3Co79eXbZdSHPSsqdlTHJLWwo3RxeNzm5QU8NpxzQ=;
        b=nSe5VELbJOPUDc/+S89wDBFV//EA/GRuBylZFE+fWNBdt4kTnpvZf0eeRtnKAk6QGX
         dCDWr5U8MyNqYZADK4DNNqBh2vJJ4uUdWm6kqhfX7dWEsH7Q5WSSUPgFOGsVdXhml+Vw
         2QeO3gW3rR0g3GGgwi+uH7YHlCri69obiRk303uKHI5ZuRTypkxxoBRc6RJHsuAuuE0k
         oddrMq6o43wLOklYCp1QUe6E8BTdRH9tWQVn/JvVC7Vxd8K5eGjAVn4ityNqrQZ+l72Q
         eHkfTE5OcS++wxv7uZ+f5HZMM1lFEvZKFEpfGBBabts4wfzuU0Azt4dRZRMh4gNI46an
         vpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0L3Co79eXbZdSHPSsqdlTHJLWwo3RxeNzm5QU8NpxzQ=;
        b=xttnWyFIqnR2Qb/gp14DMg6cdmNC/As9ejmGeAK04II75NlwWcM1Q/huJRj8djb8Yk
         xat8LqmOPV8zC+ZJ1BAhYEEOmidhKxJfNx51HHkrikcr6K33h53lzmUohvvZOBB0B9bL
         V+A3jIN/bE7i8Ku41LfrQFYJhS30oxX9gdLiFfQwvyVCPj3i/NUVUxEBX0TvntL8VPGN
         P+OSdVV9I4hCjSllepUd+K2DVrmURH2XOj0rgewQqE+OU2hAYuS0a261/b/LKj2RFW0L
         J0IT+KQY7uYWJdcfj+jHwQ8AN7aXDrtZC0cxQJ4Nu8rNS47Ps9d2z9ObXyxQ720+RNiz
         1oAQ==
X-Gm-Message-State: AOAM531AS9K4sJsgsn9pdiRZla/tQDo6wF4icCITL7sENAbp31WtqBEv
        OsqeH9cp6YRqKsuaGAe6j9cjvGl1VvQ=
X-Google-Smtp-Source: ABdhPJx95wYmsq0oLWWTmPWiq9siej3y85+4HH+7fEppnyQV9ONPkAgYiNhBzxCiPrXQ9aMchBmc6g==
X-Received: by 2002:a17:90a:8009:: with SMTP id b9mr14557209pjn.15.1631915843767;
        Fri, 17 Sep 2021 14:57:23 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:500::6:db29])
        by smtp.gmail.com with ESMTPSA id m12sm6411255pjv.29.2021.09.17.14.57.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Sep 2021 14:57:23 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        lmb@cloudflare.com, mcroce@microsoft.com, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH RFC bpf-next 00/10] bpf: CO-RE support in the kernel.
Date:   Fri, 17 Sep 2021 14:57:11 -0700
Message-Id: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Hi All,

This is very early RFC that introduces CO-RE support in the kernel.
There are several reasons to add such support:
1. It's a step toward signed BPF programs.
2. It allows golang like languages that struggle to adopt libbpf
   to take advantage of CO-RE powers.
3. Currently the field accessed by 'ldx [R1 + 10]' insn is recognized
   by the verifier purely based on +10 offset. If R1 points to a union
   the verifier picks one of the fields at this offset.
   With CO-RE the kernel can disambiguate the field access.

This set wires all relevant pieces and passes two selftests with CO-RE
in the kernel.

The main goal of RFC is to get feedback on patch 3.
It's passing CO-RE relocation into the kernel via bpf_core_apply_relo()
helper that is called by the loader program.
It works, but there is no clean way to add error reporting here.
So I'm thinking that the better approach would be to pass an array
of 'struct bpf_core_relo_desc' into PROG_LOAD command similar to
how func_info and line_info are passed.
Such approach would allow for the use case 3 above (which
current approach in patch 3 doesn't support).

Major TODOs:
- rename kernel btf_*() helpers to match libbpf btf_*() helpers
  to avoid equivalent helpers in patch 1.
- bpf_core_match_member() in relo_core.c is recursive.
  Limit its recursion or refactor.
- implemented bpf_core_types_are_compat(). duh.
- decide whether bpf_core_find_cands() needs hash table (like libbpf does)
  or not.

Alexei Starovoitov (10):
  bpf: Prepare relo_core.c for kernel duty.
  bpf: Define enum bpf_core_relo_kind as uapi.
  bpf: Add proto of bpf_core_apply_relo()
  bpf: Add bpf_core_add_cands() and wire it into
    bpf_core_apply_relo_insn().
  libbpf: Use CO-RE in the kernel in light skeleton.
  libbpf: Make gen_loader data aligned.
  libbpf: Support init of inner maps in light skeleton.
  selftests/bpf: Convert kfunc test with CO-RE to lskel.
  selftests/bpf: Improve inner_map test coverage.
  selftests/bpf: Convert map_ptr_kern test to use light skeleton.

 include/linux/bpf.h                           |   1 +
 include/linux/btf.h                           |  89 ++++++++
 include/uapi/linux/bpf.h                      |  33 +++
 kernel/bpf/Makefile                           |   4 +
 kernel/bpf/btf.c                              | 193 ++++++++++++++++++
 kernel/bpf/syscall.c                          |   2 +
 tools/include/uapi/linux/bpf.h                |  33 +++
 tools/lib/bpf/bpf_gen_internal.h              |  13 ++
 tools/lib/bpf/gen_loader.c                    |  85 +++++++-
 tools/lib/bpf/libbpf.c                        |  35 +++-
 tools/lib/bpf/relo_core.c                     | 156 ++++++++++----
 tools/lib/bpf/relo_core.h                     |  18 --
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../selftests/bpf/prog_tests/kfunc_call.c     |   4 +-
 .../selftests/bpf/prog_tests/map_ptr.c        |   8 +-
 .../selftests/bpf/progs/map_ptr_kern.c        |  16 +-
 16 files changed, 611 insertions(+), 81 deletions(-)

-- 
2.30.2

