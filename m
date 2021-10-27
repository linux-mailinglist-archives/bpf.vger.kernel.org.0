Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B95143D2F9
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 22:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243972AbhJ0UkG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 16:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243973AbhJ0UkG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Oct 2021 16:40:06 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438F1C061570
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 13:37:40 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id k29so2646117qve.6
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 13:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SdAiVGVouInpRAEvlVQylNyvtDI5I/rdZXNDoIN7jYA=;
        b=DvrCh0gD2z7IpaPJaANTdHrSlTGk9hjmrzWpR1hjhGWd5D5f5m2nYUc1G4yn3CtOA2
         DQpYLpPwjpzlj3mUMhFPErKa7MkXKD/e70KvICQ9FcKQmG3Hkvh1zxyCNzdbphT9Ng7g
         ulD5p1a4QlQXywAsx/AxPKRBTlAI+46LzPtZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SdAiVGVouInpRAEvlVQylNyvtDI5I/rdZXNDoIN7jYA=;
        b=nW5YN7TPwCplqF91Ba6XwK5WJjxFUKSBZhSkJ2OyXkOY5XLlcVlBDgBuOmVMHjT80F
         tdsdC42V5rMeH8YgdCAWRbI7B8XqLxgclwG2blRz9aS4KHhhIgdftVUaoaH0B0SOC/he
         pJ/STDWrsO/3cBGabu5YKuBBONerkE7TJCbDRfvzKaL1Gh1z0bP5t4dZCpXxA0hvqNeY
         soqrsDv99pkdLpi0+lFVhaAYbf6AF29O2BVxuK5Ke4/riNoHSbgTBE0e5fLBbi5UFja8
         ftr26uuG71OsHvzz4BaS3x2vNrIqJBL8hCPv5gIvw3f4FoJxqQgtYfv3K8ZsL3HZVVV8
         FVfg==
X-Gm-Message-State: AOAM533zLzRYlo/4tjCpCOWvuKPf0O9Odb7v/9QotkkudkN0HjHGjM84
        Fe7TGApZ/Fzs5wTieJwCIq/LJA==
X-Google-Smtp-Source: ABdhPJwbepQ4ntPds+9nZmsQ4ZKUNp8ZbpsZVcTue//qwFI+KN/U5pBbPcDZOQWDE54u0/amZVmkCA==
X-Received: by 2002:a0c:8e8e:: with SMTP id x14mr30983687qvb.67.1635367058569;
        Wed, 27 Oct 2021 13:37:38 -0700 (PDT)
Received: from localhost.localdomain ([191.91.82.96])
        by smtp.gmail.com with ESMTPSA id 14sm696790qtp.97.2021.10.27.13.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 13:37:38 -0700 (PDT)
From:   =?UTF-8?q?Mauricio=20V=C3=A1squez?= <mauricio@kinvolk.io>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Rafael David Tinoco <rafaeldtinoco@gmail.com>
Subject: [PATCH bpf-next 0/2] libbpf: Implement BTF Generator API
Date:   Wed, 27 Oct 2021 15:37:25 -0500
Message-Id: <20211027203727.208847-1-mauricio@kinvolk.io>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

CO-RE requires to have BTF information describing the types of the
kernel in order to perform the relocations. This is usually provided by
the kernel itself when it's configured with CONFIG_DEBUG_INFO_BTF.
However, this configuration is not enabled in all the distributions and
it's not available on older kernels.

It's possible to use CO-RE in kernels without CONFIG_DEBUG_INFO_BTF
support by providing the BTF information from an external source.
BTFHub[0] contains BTF files to each released kernel not supporting BTF,
for the most popular distributions.

Providing this BTF file for a given kernel has some challenges:
1. Each BTF file is a few MBs big, then it's not possible to ship the
eBPF program with the all the BTF files needed to run in different
kernels. (The BTF files will be in the order of GBs if you want to
support a high number of kernels)
2. Downloading the BTF file for the current kernel at runtime delays the
start of the program and it's not always possible to reach an external
host to download such a file.

Providing the BTF file with the information about all the data types of
the kernel for running an eBPF program is an overkill in many of the
cases. Usually the eBPF programs access only some kernel fields.

This set of commits extend libbpf to provide an API to generate a BTF
file with only the types that are needed by an eBPF object. These
generated files are very small compared to the ones that contain all the
kernel types (for a program like execsnoop it's around 4kB). This allows
to ship an eBPF program together with the BTF information that it needs
to run for many different kernels.

This idea was discussed during the "Towards truly portable eBPF"[1]
presentation at Linux Plumbers 2021.

We prepared a BTFGen repository[2] with an example of how this API can
be used. Our plan is to include this support in bpftool once it's merged
in libbpf.

There is also a good example[3] on how to use BTFGen and BTFHub together
to generate multiple BTF files, to each existing/supported kernel,
tailored to one application. For example: a complex bpf object might
support nearly 400 kernels by having BTF files summing only 1.5 MB.

[0]: https://github.com/aquasecurity/btfhub/
[1]: https://www.youtube.com/watch?v=igJLKyP1lFk&t=2418s
[2]: https://github.com/kinvolk/btfgen
[3]: https://github.com/aquasecurity/btfhub/tree/main/tools

Mauricio Vásquez (2):
  libbpf: Implement btf__save_to_file()
  libbpf: Implement API for generating BTF for ebpf objects

 tools/lib/bpf/Makefile    |   2 +-
 tools/lib/bpf/btf.c       |  22 ++
 tools/lib/bpf/btf.h       |   2 +
 tools/lib/bpf/libbpf.c    |  28 ++-
 tools/lib/bpf/libbpf.h    |   4 +
 tools/lib/bpf/libbpf.map  |   6 +
 tools/lib/bpf/relo_core.c | 514 +++++++++++++++++++++++++++++++++++++-
 tools/lib/bpf/relo_core.h |  11 +-
 8 files changed, 579 insertions(+), 10 deletions(-)

-- 
2.25.1

