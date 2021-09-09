Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8129540578A
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 15:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351107AbhIINhL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 09:37:11 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:47028 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355892AbhIINdJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 09:33:09 -0400
Received: by mail-ed1-f54.google.com with SMTP id j13so2656932edv.13
        for <bpf@vger.kernel.org>; Thu, 09 Sep 2021 06:31:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I5+aT377LpweaJxo8y40u82o1xDS2ZChVCugghsh6kg=;
        b=fcURRixg1R2nvWpz6f9jf0A332EfLinka23PMnCvzQGsOljgmzx89gOEiNFnKmtFuX
         7MnkWpdAwHOrjRsJV42uNqipaWfTfWbE4ANINd0yZO3re9SlBztcd1HJpZBo0h0ZJyeY
         WBdG9/8b+xK2zyEULsRkKA7R+pOOHJ15Fvf8/lUmgc7TfpbbPeAOnhiB8QKjF4L9fr6R
         HTsF3ZiJeNheh+tgaUS7bPyAumKLOsAuvqVRV+YzzRTRYk4q6gtnZFKKke5rvq+LFt4H
         cH+URhS899KkXWxV6nPkecehLFrtwmb4J3k59ops0gq5TPoSyDi0+L5kuamgz9AmhOH4
         zlUA==
X-Gm-Message-State: AOAM533bG0fgBXT4JEmcmFSZIqmxZMHWsTdpgrYSPdvJqfd6S6gbpTQm
        7h0NicJyouJ0uTVazy+Z2c35gb/oc1Q=
X-Google-Smtp-Source: ABdhPJwUWbaupzU3iiFXPS9499hkNzPXQ9/FuOr7ufOOpiIYbKJjCjJqzAKjCX5nGwLQSs/HK03JsA==
X-Received: by 2002:aa7:cb55:: with SMTP id w21mr3089427edt.378.1631194318781;
        Thu, 09 Sep 2021 06:31:58 -0700 (PDT)
Received: from msft-t490s.. (mob-83-225-149-177.net.vodafone.it. [83.225.149.177])
        by smtp.gmail.com with ESMTPSA id am3sm959030ejc.74.2021.09.09.06.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 06:31:58 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [RFC bpf 0/2] bpf: kernel CO-RE relocation
Date:   Thu,  9 Sep 2021 15:31:51 +0200
Message-Id: <20210909133153.48994-1-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

This series is a preliminary work to move the CO-RE relocations in the kernel.
This is the first step to have signed BPF files, since userspace instruction
patching makes any verification ineffective.

The first patch just copies the relocation code from tools/lib/bpf/,
the second one refactors the whole code so to build it in kernel.
It builds with a single warning, which can be suppressed by switching to
dynamic allocation:

  kernel/bpf/relo_core.c: In function 'bpf_core_apply_relo_insn':
  kernel/bpf/relo_core.c:1457:1: warning: the frame size of 2776 bytes is larger than 1024 bytes [-Wframe-larger-than=]

To really use this code and do the the relocations done in kernel, we will
need an API to pass the relocation informations along the BPF file, so don't
consider this patches for inclusion, but just as a first step toward the
full work.

Matteo Croce (2):
  btf: copy relo_core from tools to kernel
  btf: adapt relo_core for kernel compilation

 include/linux/btf.h    |   65 ++
 kernel/bpf/Makefile    |    1 +
 kernel/bpf/btf.c       |   45 +-
 kernel/bpf/relo_core.c | 1457 ++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/relo_core.h |  100 +++
 5 files changed, 1630 insertions(+), 38 deletions(-)
 create mode 100644 kernel/bpf/relo_core.c
 create mode 100644 kernel/bpf/relo_core.h

-- 
2.31.1

