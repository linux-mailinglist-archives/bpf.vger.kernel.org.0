Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DDC24A982
	for <lists+bpf@lfdr.de>; Thu, 20 Aug 2020 00:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgHSWkg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Aug 2020 18:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgHSWkf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Aug 2020 18:40:35 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69D7C061757
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2020 15:40:34 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id d19so17382qvm.23
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2020 15:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=EvVX+342SXuaBchy3/trMWGY/3AxdBYSkIWLg0jDdX0=;
        b=WC45bL657ajNciULhddNw2JgJ3L33JA7MxGDn+WyCv9HIfw/NxIXHtYJgr5s/NQ+Au
         GQ1KnB/WhKjdtqvnAl+B6R9wOUaRCRhVl1RHzge9cE3ZT/WHNrcuhe1r6pY7ssjl640n
         oxMKCcMjdCzO1jSde2y84+mogDdCbH+boQ3kaD0nUm+lHMC4aar+44tEwgmFGnx693Nb
         ICm6Amk423FRPU9gp28mVjfus4Z6p0jXbuCrv1kRmSE40AzDs70Kxz736HfHvezfbH48
         1JXBKXM2g/UV/HI8d2ml9An0tBUUZlxGSZxpA/dsSqWtd8Ayn8oyjUdJIFPaybef7IS7
         FP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=EvVX+342SXuaBchy3/trMWGY/3AxdBYSkIWLg0jDdX0=;
        b=tD60HRnGE+rBuRzKpw8D7cWlLIlkXnEMaWUYsdMbjFNstwja4pysy5A8JSDevMTn+Q
         7cJ7gbW/xh2B4JaHO7Tb0PJznTsaNTjxuoJ1qYoGSH7AqidWCtBcZty9sA7igpcrngtD
         hAPocVfDhxuOXR6rahHgTNzBPnIjNOKkPS+4AcWCwp1DmevjfHpgCCFweISU64W1cwVS
         DCkWwSnGCdIbsY6j/ZwJSzZkmcbiJouqdjNAIRSvlJpkoS2E0uCTyAjSSVPrPXor+Mx0
         9fKGXE02s02QiraSYRpdYrwTqnGgJttFukQVLgTMd2beio5arQne0PkvAfnQwggncz/R
         lZAA==
X-Gm-Message-State: AOAM531va5MQV02i9zs4qV0RDUmLJVgTS2u5kIIEwUriSI8qjFTq+9DU
        noUq8miBKX9Oh5nnQ/c+12VpdKLN92A=
X-Google-Smtp-Source: ABdhPJxXcTQc4F9HjvdGQaSU0zuQOKiQ7mlX9TYnvGKi6DOmfJ4Myqy4u5T27jdfalORwFRyTn4kdYrF4no=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:f693:9fff:fef4:e444])
 (user=haoluo job=sendgmr) by 2002:a0c:c248:: with SMTP id w8mr450623qvh.157.1597876834030;
 Wed, 19 Aug 2020 15:40:34 -0700 (PDT)
Date:   Wed, 19 Aug 2020 15:40:22 -0700
Message-Id: <20200819224030.1615203-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH bpf-next v1 0/8] bpf: BTF support for ksyms
From:   Hao Luo <haoluo@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Hao Luo <haoluo@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Andrey Ignatov <rdna@fb.com>,
        Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch series extends the previously added __ksym externs with
btf support.

Right now the __ksym externs are treated as pure 64-bit scalar value.
Libbpf replaces ld_imm64 insn of __ksym by its kernel address at load
time. This patch series extend those externs with their btf info. Note
that btf support for __ksym must come with the kernel btf that has
VARs encoded to work properly. The corresponding chagnes in pahole
is available at [1].

The first 5 patches in this series add support for general kernel
global variables, which includes verifier checking (01/08), libbpf
type checking (03/08) and btf_id resolving (04/08).

The last 3 patches extends that capability further by introducing a
helper bpf_per_cpu_ptr(), which allows accessing kernel percpu vars
correctly (06/08).

The tests of this feature were performed against the extended pahole.
For kernel btf that does not have VARs encoded, the selftests will be
skipped.

[1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=f3d9054ba8ff1df0fc44e507e3a01c0964cabd42

rfc -> v1:
 - Encode VAR's btf_id for PSEUDO_BTF_ID.
 - More checks in verifier. Checking the btf_id passed as
   PSEUDO_BTF_ID is valid VAR, its name and type.
 - Checks in libbpf on type compatibility of ksyms.
 - Add bpf_per_cpu_ptr() to access kernel percpu vars. Introduced
   new ARG and RET types for this helper.

Hao Luo (8):
  bpf: Introduce pseudo_btf_id
  bpf: Propagate BPF_PSEUDO_BTF_ID to uapi headers in /tools
  bpf: Introduce help function to validate ksym's type.
  bpf/libbpf: BTF support for typed ksyms
  bpf/selftests: ksyms_btf to test typed ksyms
  bpf: Introduce bpf_per_cpu_ptr()
  bpf: Propagate bpf_per_cpu_ptr() to /tools
  bpf/selftests: Test for bpf_per_cpu_ptr()

 include/linux/bpf.h                           |   3 +
 include/linux/btf.h                           |  26 +++
 include/uapi/linux/bpf.h                      |  52 +++++-
 kernel/bpf/btf.c                              |  25 ---
 kernel/bpf/verifier.c                         | 128 ++++++++++++-
 kernel/trace/bpf_trace.c                      |  18 ++
 tools/include/uapi/linux/bpf.h                |  53 +++++-
 tools/lib/bpf/btf.c                           | 171 ++++++++++++++++++
 tools/lib/bpf/btf.h                           |   2 +
 tools/lib/bpf/libbpf.c                        | 130 +++++++++++--
 .../selftests/bpf/prog_tests/ksyms_btf.c      |  81 +++++++++
 .../selftests/bpf/progs/test_ksyms_btf.c      |  36 ++++
 12 files changed, 665 insertions(+), 60 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_ksyms_btf.c

-- 
2.28.0.220.ged08abb693-goog

