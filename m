Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 632EAA3552
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2019 13:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfH3LAx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Aug 2019 07:00:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42696 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbfH3LAw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Aug 2019 07:00:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id b16so6506481wrq.9
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2019 04:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=tzqgVqkwgF/KCEzpq5kudUbw0OX0oPLacHJ2iZv9bCk=;
        b=GYVOZL1YmhxxrNRSGB6gLWgzBctRRnIiIwbmibm0I2ZRcNPIzIJDR4stGdPoKeTneK
         yMmw6EBZuZOXbo3HR1c/mMQ/ZSvaJw7obaxvZliq9AXlQU5tDn+O6zfY7+02isGZqP5g
         4IDIgvOrR3syN//a5YybvkNWEzhyDFK4wVPvTIyVXA4Y0Tk27cVdv/aE4715pB5VIP7k
         YPL93N8Q1h7y68bvN7Xb1aQIElmQCBo6G/4DC71sdnRIGkPRkGKOV3L+HuAzDOJPfr/t
         tG2YeiXKNrX+NfTc8KcRVv+90XxWu7MRuzARojMVjwLssXQUQvF8gSI3DJ/082NZ7kH2
         HlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tzqgVqkwgF/KCEzpq5kudUbw0OX0oPLacHJ2iZv9bCk=;
        b=TcpGefn39k/miSaSB2DGfrb/Ci8wsiCS87BJQj5WV7TTocvssXmBMiAb9k9lcjnJrP
         vN+2Jm2rHphniayI8Mo3Pi/G1+zb/EEAi8az2Ol888W3GVzUog11nmu+MaLYyxNC9ywZ
         5q3c2vLCBQxlvgVn64u94bRKXIBwPtYYfwPDIa5KW0uupFGmd7ZbYoBskxxCZ+w8+7SZ
         qLZ/6qhXOaGUCA/Ksn15kQcv8l8J+nrWLzoSm0zMyfZyOlbXO9J//4goHfKtTsc0IDtv
         6DfENcXtorivxLw/i18BNy/mrE+Wy3ftAR7Hl6e/XQRE4rxaRqrr0Ob5yIVvRoYS+JRi
         4ihw==
X-Gm-Message-State: APjAAAXwkHRekkIbH6O8jteLL1KpFardqfTpJjV9slmT5hPQ7DeAElmN
        gvZUy3toz+05FF5cJjlcwfo7Fw==
X-Google-Smtp-Source: APXvYqzOjuLr3NvKa7DLct2H8Fz6Ov2dhUXvCVMZ03wpXp4dnrGfdYGX5NLvyYNOxQqIe+r6vgCgFg==
X-Received: by 2002:a5d:51c7:: with SMTP id n7mr17060204wrv.73.1567162850501;
        Fri, 30 Aug 2019 04:00:50 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id t198sm7848083wmt.39.2019.08.30.04.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 04:00:49 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH bpf-next v2 0/4] tools: bpftool: improve bpftool build experience
Date:   Fri, 30 Aug 2019 12:00:36 +0100
Message-Id: <20190830110040.31257-1-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,
This set attempts to make it easier to build bpftool, in particular when
passing a specific output directory. This is a follow-up to the
conversation held last month by Lorenz, Ilya and Jakub [0].

The first patch is a minor fix to bpftool's Makefile, regarding the
retrieval of kernel version (which currently prints a non-relevant make
warning on some invocations).

Second patch improves the Makefile commands to support more "make"
invocations, or to fix building with custom output directory. On Jakub's
suggestion, a script is also added to BPF selftests in order to keep track
of the supported build variants.

Building bpftool with "make tools/bpf" from the top of the repository
generates files in "libbpf/" and "feature/" directories under tools/bpf/
and tools/bpf/bpftool/. The third patch ensures such directories are taken
care of on "make clean", and add them to the relevant .gitignore files.

At last, fourth patch is a sligthly modified version of Ilya's fix
regarding libbpf.a appearing twice on the linking command for bpftool.

[0] https://lore.kernel.org/bpf/CACAyw9-CWRHVH3TJ=Tke2x8YiLsH47sLCijdp=V+5M836R9aAA@mail.gmail.com/

v2:
- Return error from check script if one of the make invocations returns
  non-zero (even if binary is successfully produced).
- Run "make clean" from bpf/ and not only bpf/bpftool/ in that same script,
  when relevant.
- Add a patch to clean up generated "feature/" and "libbpf/" directories.

Cc: Lorenz Bauer <lmb@cloudflare.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>

Quentin Monnet (4):
  tools: bpftool: ignore make built-in rules for getting kernel version
  tools: bpftool: improve and check builds for different make
    invocations
  tools: bpf: account for generated feature/ and libbpf/ directories
  tools: bpftool: do not link twice against libbpf.a in Makefile

 tools/bpf/.gitignore                          |   1 +
 tools/bpf/Makefile                            |   5 +-
 tools/bpf/bpftool/.gitignore                  |   2 +
 tools/bpf/bpftool/Makefile                    |  28 ++--
 tools/testing/selftests/bpf/Makefile          |   3 +-
 .../selftests/bpf/test_bpftool_build.sh       | 143 ++++++++++++++++++
 6 files changed, 167 insertions(+), 15 deletions(-)
 create mode 100755 tools/testing/selftests/bpf/test_bpftool_build.sh

-- 
2.17.1

