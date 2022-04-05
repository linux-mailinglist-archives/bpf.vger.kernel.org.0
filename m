Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63814F4D90
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 03:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445891AbiDEXqA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Apr 2022 19:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577588AbiDEXMd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Apr 2022 19:12:33 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48C1F844B
        for <bpf@vger.kernel.org>; Tue,  5 Apr 2022 14:44:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b6-20020a5b0b46000000b0063dcbfa6dd3so321096ybr.2
        for <bpf@vger.kernel.org>; Tue, 05 Apr 2022 14:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Y3boLJhnsnsX21RxEJ5dbfl+5imWo3Z17WnpkTr+aec=;
        b=kiINLgYgk8+neprx3cxKEu/hgrZy0GjmVu62OtEH6+4huoJOm/rTKY/W8vmyaWXCv8
         7H5tO+nbtdeXtVl1GtLseqWflh+S/JHhxtPAPQO3fcoumT7+mvcmKvBRTpdBx81MzS3n
         TOKC+hoCGBHKkFtpkmrXwi8eyoXpNgGIoage6PNMAqZ8kRYcUl7Z+/XuLA8dGYhxX+V3
         55DqHuMebW3aTuv7O0d4aXZiAT0cXHSLNqfEqAOB9jwxbDppt8+Quz2mKS4teJbEFL4l
         z78ALvUndePGswYz8B2vDMCjBO9Jw4mMH6XuSNSAqXDCw6gqkI/pgHdLzXcAqs+bCKhY
         nyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Y3boLJhnsnsX21RxEJ5dbfl+5imWo3Z17WnpkTr+aec=;
        b=aND+YLgxLOa+wroisHWI60aTFQURwCcCKQC3rjRC5GFAGtYrk4JWEFG0fl3Drf9EQd
         ujhrJvYVFMdK41arogYYzZhcO7FFUorjmHVHdOJpolXfc4uIjyihwFy7VmrAjcF6rHna
         vRUl8z1PXvp08xpyxebM4mmc9vwWBU8+ty0AKUq/ahKGc6CvdoWKOZ1PUyW1Kh5DBfW1
         AMe5YkFMXHG6NEIv7tMdUt6KPX6t+KJuojS/x3sL5/rqZXwqa5kcQTyv7eGsVH0m3K5B
         w78yMYTVRHHTeRObX/pZGdv89SY+vbzafv0iTHBjgRmZFJpNGqCLjHZ33DoHf8jlbi9E
         NsgQ==
X-Gm-Message-State: AOAM531gyIK+T2zNxdleAfrofGQGV3YLtzyV/zZMt9Bro1YF4VJUi8Al
        F/CfeFE9JmMRt7b2sV6HKrWWXak=
X-Google-Smtp-Source: ABdhPJxiP2tCmr6iQpjkbYbORTJcwwwRFgZsSZ4os+YthLUmWORLtK39qI75Qhc8a/m5HXT2aYTkTes=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:73b5:ffab:2024:2901])
 (user=sdf job=sendgmr) by 2002:a25:af41:0:b0:633:905f:9e9b with SMTP id
 c1-20020a25af41000000b00633905f9e9bmr4347275ybj.77.1649195025088; Tue, 05 Apr
 2022 14:43:45 -0700 (PDT)
Date:   Tue,  5 Apr 2022 14:43:35 -0700
Message-Id: <20220405214342.1968262-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH bpf-next v2 0/7] bpf: cgroup_sock lsm flavor
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
 kernel/bpf/cgroup.c                           | 209 ++++++++++++++++--
 kernel/bpf/syscall.c                          |  10 +
 kernel/bpf/trampoline.c                       | 205 ++++++++++++++---
 kernel/bpf/verifier.c                         |   4 +-
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/lib/bpf/libbpf.c                        |   2 +
 .../selftests/bpf/prog_tests/lsm_cgroup.c     | 158 +++++++++++++
 .../testing/selftests/bpf/progs/lsm_cgroup.c  |  94 ++++++++
 tools/testing/selftests/bpf/test_verifier.c   |  54 ++++-
 .../selftests/bpf/verifier/lsm_cgroup.c       |  34 +++
 16 files changed, 912 insertions(+), 58 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_cgroup.c
 create mode 100644 tools/testing/selftests/bpf/verifier/lsm_cgroup.c

-- 
2.35.1.1094.g7c7d902a7c-goog

