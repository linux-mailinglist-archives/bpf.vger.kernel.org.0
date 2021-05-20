Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1581C38B07A
	for <lists+bpf@lfdr.de>; Thu, 20 May 2021 15:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239027AbhETNwl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 May 2021 09:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241592AbhETNwg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 May 2021 09:52:36 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD2EC061760
        for <bpf@vger.kernel.org>; Thu, 20 May 2021 06:51:14 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so14954049oto.0
        for <bpf@vger.kernel.org>; Thu, 20 May 2021 06:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=QoJKNoGZkLVWx0eGjPbY8LJ6NfNL4w7xAI12ZqlaAHQ=;
        b=lAL6lpHaFTBHyGDiCOoo4teX9fcwQ2J2thK2sXa0hBhw4ztp+z1CCtLwbIWDrOcLbQ
         UViEv7rVp2D0edakm3eRMeDn+lSc+VpPi8nSc1lsBYCgBEP12rJVVL1oq8PJ2wg01S9f
         Gadjssxhsfi2RgR+UsvwZrC1/XRIjfF01jX4oytHpQYy3HsPp9ToPkUnwxkCW4lBqAly
         zSPYUAjofBi5rA3LK9e+qe0YSv521SiwGlWMhYXO6LOnPLZOKzYi9aw5KaYhHUKCYHGj
         G9Bi0jtaQXtsD+58Io6kTwtx2UAgcmciQrEZq5qOVkseD5ruSXbZcClkLL1qJ+jeHNqB
         AHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=QoJKNoGZkLVWx0eGjPbY8LJ6NfNL4w7xAI12ZqlaAHQ=;
        b=pUU5XCycCaILQ9IjPc5PNllPPG9imHDO932/GuPXFfDnSL2nUAiYzw4BlcsPWkDTm5
         J/5fMtHk4X1LA+GgJO/HwQrXtCGHWchvXURnCLAbiXiqhV2IxtEwQ18f8ifeyMwQkafK
         STd2lvLjMjLPYB5M0PVk3Px01BvNEovnvENz98Ry6+CB+6NS0cCndzxJpHUlL24MyPeN
         qAECZh63ch4uLan99t67dTXh4p7uIdXLHV9HC+OL+cxkycGNEScdlHmIQOreYSTTmWta
         rJRuga2T0h+KRgrNuqYOKKf51StHk5Yw2aDLEoH2WRhKVOg5s8fOBkMJtd/hKFuusAli
         HvrQ==
X-Gm-Message-State: AOAM532lC2EThu4d5ZvRY/ozpBd0UOqOdX2CZhN47PPA700P2+3P3ZMU
        sGnAQUhLNSOrvsz833gTBdtNf+TWhYiRpGS18fswA7bb4boE5FwU
X-Google-Smtp-Source: ABdhPJz67cGvGu69skBiSN6x005PF7+y4xxC1MQ0vAqDxwg7ksNn3OghNs9VED2b8vbGTgq+nRmAcHdYg24lqls6WKo=
X-Received: by 2002:a05:6830:14c5:: with SMTP id t5mr3948220otq.266.1621518672996;
 Thu, 20 May 2021 06:51:12 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 20 May 2021 19:21:01 +0530
Message-ID: <CA+G9fYtvmr09BwE79QzNxiauQtUD7tZhCAbVVH3Vv=anaqt-yA@mail.gmail.com>
Subject: bbpf_internal.h:102:22: error: format '%ld' expects argument of type
 'long int', but argument 3 has type 'int' [-Werror=format=]
To:     bpf <bpf@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, ast@fb.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The perf build failed on i386 on Linux next-20210519 and next-20210520 tag
 with gcc-7.3 due to below warnings / errors.

In file included from libbpf.c:55:0:
libbpf.c: In function 'init_map_slots':
libbpf_internal.h:102:22: error: format '%ld' expects argument of type
'long int', but argument 3 has type 'int' [-Werror=format=]
  libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__); \
                      ^
libbpf_internal.h:105:27: note: in expansion of macro '__pr'
 #define pr_warn(fmt, ...) __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
                           ^~~~
libbpf.c:4568:4: note: in expansion of macro 'pr_warn'
    pr_warn("// TODO map_update_elem: idx %ld key %d value==map_idx %ld\n",
    ^~~~~~~
libbpf.c:4568:44: note: format string is defined here
    pr_warn("// TODO map_update_elem: idx %ld key %d value==map_idx %ld\n",
                                          ~~^
                                          %d
In file included from libbpf.c:55:0:
libbpf_internal.h:102:22: error: format '%ld' expects argument of type
'long int', but argument 5 has type 'int' [-Werror=format=]
  libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__); \
                      ^
libbpf_internal.h:105:27: note: in expansion of macro '__pr'
 #define pr_warn(fmt, ...) __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
                           ^~~~
libbpf.c:4568:4: note: in expansion of macro 'pr_warn'
    pr_warn("// TODO map_update_elem: idx %ld key %d value==map_idx %ld\n",
    ^~~~~~~
libbpf.c:4568:70: note: format string is defined here
    pr_warn("// TODO map_update_elem: idx %ld key %d value==map_idx %ld\n",
                                                                    ~~^
                                                                    %d
  CC      /srv/oe/build/tmp-lkft-glibc/work/intel_core2_32-linaro-linux/perf/1.0-r9/perf-1.0/cpu.o
In file included from libbpf.c:55:0:
libbpf.c: In function 'bpf_core_apply_relo':
libbpf_internal.h:102:22: error: format '%ld' expects argument of type
'long int', but argument 3 has type 'int' [-Werror=format=]
  libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__); \
                      ^
libbpf_internal.h:105:27: note: in expansion of macro '__pr'
 #define pr_warn(fmt, ...) __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
                           ^~~~
libbpf.c:6192:3: note: in expansion of macro 'pr_warn'
   pr_warn("// TODO core_relo: prog %ld insn[%d] %s %s kind %d\n",
   ^~~~~~~
libbpf.c:6192:38: note: format string is defined here
   pr_warn("// TODO core_relo: prog %ld insn[%d] %s %s kind %d\n",
                                    ~~^
                                    %d

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-next/DISTRO=lkft,MACHINE=intel-core2-32,label=docker-buster-lkft/1030/consoleText

--
Linaro LKFT
https://lkft.linaro.org
