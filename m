Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC162A2BB0
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2019 02:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfH3Auo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Aug 2019 20:50:44 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33076 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfH3Aun (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Aug 2019 20:50:43 -0400
Received: by mail-lj1-f194.google.com with SMTP id z17so4856615ljz.0
        for <bpf@vger.kernel.org>; Thu, 29 Aug 2019 17:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=xMuXLxwuJeSWopT/f8dXFbI5jVuji3StpvlKwxHupj4=;
        b=rnr4X0TQdkwszhW4r53DgSGbfSyqjshLRLQ9ru9r0hiQjF6Pmzl6cFSGIXGZDyX8FM
         kO4l69Gy3FILbmNq5bSUGsIpaZ9XaIHD/+YK6HPdgABmplST2YZNTLJo9RawuaCo+ute
         7rBOt9fScpmIQdED0bS9ysnX6D/5oXmASshjL3akOMkCpUlDb0m3RuUipo7CfFf44g5O
         NT/ccLrrYb5iZAFECZ3wB98QbOk+AWPIlhlBT8BwE0+tWyGIst3jCLaW5eI5KnWey2hK
         qT8PWkNXjiYDmWcUscqudRpRLzArq1rvEq/ytQzRBj7ZXjV1OCAHSjD94QTSqLHQkDUW
         ogiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xMuXLxwuJeSWopT/f8dXFbI5jVuji3StpvlKwxHupj4=;
        b=dMCyPcM8eSw5WO5nNZIiYNaZb1Wq2A5SXyKLesTvTiDE6xzGKRO4vuRVUoJh7CsK33
         FqO4DWg8eiD+bFThPYy1hBKu3uQOzq3rrrz/Emq7xAYzVUTN54gJ8dWMmvmXel7Wqa0g
         jca3nRPOh9ZOVoOXVZikWRSyTdBzzfDUSq2+Bx1EhEIuGR6owertXlOUIs8/SSn4zjB6
         oO0S5TI5C6r+RsHe2UQOisE8MjQG6dwv7gsCrNvp8HA274XhUPx+V5nJa0tRlX2yFr0U
         vKwwvOjYWKRlIGQfTv3vGkAH2xB+S/UWBn2ayp56jOfW7P5/HQZOD2H+MMGDrr2SVkRC
         wW3A==
X-Gm-Message-State: APjAAAVDZdYl/DM+gZ9S+ZYaS92eReftZ4WxYzrO+k5ZcqNjobHsb++8
        zri7eEKiHFVsdHM81no3rgvXGQ==
X-Google-Smtp-Source: APXvYqxL710fHxqeBsIPyilVGaM4NIUyDBx68X3IEtdE/LKXFPKtMM8GtBcX4pfo/aWdd1ZNaV62/g==
X-Received: by 2002:a2e:9d9a:: with SMTP id c26mr7203774ljj.56.1567126241817;
        Thu, 29 Aug 2019 17:50:41 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id f19sm628149lfk.43.2019.08.29.17.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 17:50:41 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     linux@armlinux.org.uk, ast@kernel.org, daniel@iogearbox.net,
        yhs@fb.com, davem@davemloft.net, jakub.kicinski@netronome.com,
        hawk@kernel.org, john.fastabend@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH RFC bpf-next 00/10] improve/fix cross-compilation for bpf samples
Date:   Fri, 30 Aug 2019 03:50:27 +0300
Message-Id: <20190830005037.24004-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series contains mainly fixes/improvements for cross-compilation
(also verified on native platform build), tested on arm, but intended
for any arch.

The several patches are related to llvm clang and should be out of this
series or even fixed in another way, and here just to get comments:
  arm: include: asm: swab: mask rev16 instruction for clang
  arm: include: asm: unified: mask .syntax unified for clang

Also, only for armv7, there is one more problem related to long and
void type sizes for 32 bits, while the BPF LLVM back end still
operates in 64 bit, but that's another story.

Smth related not only for cross-compilation and can have impact on other
archs and build environments, so might be good idea to verify it in order
to add appropriate changes, some warn options can be tuned, so comment.

Ivan Khoronzhuk (10):
  samples: bpf: Makefile: use --target from cross-compile
  samples: bpf: Makefile: remove target for native build
  libbpf: Makefile: add C/CXX/LDFLAGS to libbpf.so and test_libpf
    targets
  samples: bpf: use own EXTRA_CFLAGS for clang commands
  samples: bpf: Makefile: use vars from KBUILD_CFLAGS to handle linux
    headers
  samples: bpf: makefile: fix HDR_PROBE
  samples: bpf: add makefile.prog for separate CC build
  samples: bpf: Makefile: base progs build on Makefile.progs
  arm: include: asm: swab: mask rev16 instruction for clang
  arm: include: asm: unified: mask .syntax unified for clang

 arch/arm/include/asm/swab.h    |   3 +
 arch/arm/include/asm/unified.h |   6 +-
 samples/bpf/Makefile           | 177 +++++++++++++++++++--------------
 samples/bpf/Makefile.prog      |  77 ++++++++++++++
 samples/bpf/README.rst         |   7 ++
 tools/lib/bpf/Makefile         |  11 +-
 6 files changed, 205 insertions(+), 76 deletions(-)
 create mode 100644 samples/bpf/Makefile.prog

-- 
2.17.1

