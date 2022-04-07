Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECF04F8AEF
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 02:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiDGWdT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Apr 2022 18:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbiDGWdR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Apr 2022 18:33:17 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417C33616A
        for <bpf@vger.kernel.org>; Thu,  7 Apr 2022 15:31:15 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2e642be1a51so59483137b3.21
        for <bpf@vger.kernel.org>; Thu, 07 Apr 2022 15:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dqxIaiuwYB3bO0Dv4QbRVtEexvrTpqg03foYHPZyS8U=;
        b=fk7Me382LQwIaP+R5dmK/llWrb7kvT/CdnLDRt7o+SSM0Tvurx8VFRRGyOnJu1nvJZ
         NURDoDsCMqbPmjO5UuL8Dc3SRB0kPcuVu7A8k5i43AH/ERRywxyYVMSvYuz787UvEUPl
         kwEManMb42eKLcLrZY5ME07w4YdL54kKQYYZ6zWROIJOTScbdFSv1u2OQBYL0agaSyDN
         e64K7oOn8WOdwEhYJbrFDwheIl3nKr1FNjuPEMC6LqPHOMFdUE1fFQQqjJdpRTCqZaBE
         pa3vWNCG43BOU/Bhtw+qoR90mSpSbVCrGRMeCkEOQ7WPAEa4LJsNACjkTY/1a9t4m+fh
         roOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dqxIaiuwYB3bO0Dv4QbRVtEexvrTpqg03foYHPZyS8U=;
        b=6bcCZZ9nSttDkQYmLKlY4JhizLEcTAzJ5t/pqPX6GsKRYLbu9zQZIFoMpnkCawS4vL
         teLIoxV1sj6LSTNxDwV+DEvrF72sfTDlfS+D4+P0msH2wD6u7uHUlFUBMIC7KhVnR+7u
         qG74APSGm/W/vlip3rQ42SjrwDgHUp+xhVN9UwWqEN0UWBRDuaZ/5Ne11v/PssnVAkFD
         BMPSlLF1NAbNUjJ4xJ1ZA/kVQ4iM+FBhwzRar6YUs6ZIFfzQrGXEQ3LdaDMArs/SlFOp
         vb2/0wC7JxwqglBRlKBUGVP17qiohtJ6CYk+IHmixLGUUVC+xsvyMHQkH7c5lVEJeCf8
         zlaQ==
X-Gm-Message-State: AOAM530OALUV0kJOAm8Da9HMcI5vsESMbb13mM5udH/XCxiL8vQgzoyr
        7AP7LLsoub+Ex/sQ8O4OdGLdwI0=
X-Google-Smtp-Source: ABdhPJzGkuMTQLmGDG3SUnc2GiKndxn1d7tTsJgnSePZLKTRrViJJRUbSfAj3Gv9QWxcWdtI2rw91CU=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:9e25:5910:c207:e29a])
 (user=sdf job=sendgmr) by 2002:a05:6902:30d:b0:63e:c44:6006 with SMTP id
 b13-20020a056902030d00b0063e0c446006mr11565426ybs.367.1649370674525; Thu, 07
 Apr 2022 15:31:14 -0700 (PDT)
Date:   Thu,  7 Apr 2022 15:31:05 -0700
Message-Id: <20220407223112.1204582-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH bpf-next v3 0/7] bpf: cgroup_sock lsm flavor
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>, kafai@fb.com,
        kpsingh@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series implements new lsm flavor for attaching per-cgroup programs to
existing lsm hooks. The cgroup is taken out of 'current', unless
the first argument of the hook is 'struct socket'. In this case,
the cgroup association is taken out of socket. The attachment
looks like a regular per-cgroup attachment: we add new BPF_LSM_CGROUP
attach type which, together with attach_btf_id, signals per-cgroup lsm.
Behind the scenes, we allocate trampoline shim program and
attach to lsm. This program looks up cgroup from current/socket
and runs cgroup's effective prog array. The rest of the per-cgroup BPF
stays the same: hierarchy, local storage, retval conventions
(return 1 == success).

Current limitations:
* haven't considered sleepable bpf; can be extended later on
* not sure the verifier does the right thing with null checks;
  see latest selftest for details
* total of 10 (global) per-cgroup LSM attach points; this bloats
  bpf_cgroup a bit

Cc: ast@kernel.org
Cc: daniel@iogearbox.net
Cc: kafai@fb.com
Cc: kpsingh@kernel.org

v3:
- add BPF_LSM_CGROUP to bpftool
- use simple int instead of refcnt_t (to avoid use-after-free
  false positive)

v2:
- addressed build bot failures

Stanislav Fomichev (7):
  bpf: add bpf_func_t and trampoline helpers
  bpf: per-cgroup lsm flavor
  bpf: minimize number of allocated lsm slots per program
  bpf: allow writing to a subset of sock fields from lsm progtype
  libbpf: add lsm_cgoup_sock type
  selftests/bpf: lsm_cgroup functional test
  selftests/bpf: verify lsm_cgroup struct sock access

 include/linux/bpf-cgroup-defs.h               |   8 +
 include/linux/bpf.h                           |  24 +-
 include/linux/bpf_lsm.h                       |   8 +
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/bpf_lsm.c                          | 147 ++++++++++++
 kernel/bpf/btf.c                              |  11 +
 kernel/bpf/cgroup.c                           | 210 ++++++++++++++++--
 kernel/bpf/syscall.c                          |  10 +
 kernel/bpf/trampoline.c                       | 205 ++++++++++++++---
 kernel/bpf/verifier.c                         |   4 +-
 tools/bpf/bpftool/common.c                    |   1 +
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/lib/bpf/libbpf.c                        |   2 +
 .../selftests/bpf/prog_tests/lsm_cgroup.c     | 158 +++++++++++++
 .../testing/selftests/bpf/progs/lsm_cgroup.c  |  94 ++++++++
 tools/testing/selftests/bpf/test_verifier.c   |  54 ++++-
 .../selftests/bpf/verifier/lsm_cgroup.c       |  34 +++
 17 files changed, 914 insertions(+), 58 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_cgroup.c
 create mode 100644 tools/testing/selftests/bpf/verifier/lsm_cgroup.c

-- 
2.35.1.1178.g4f1659d476-goog

