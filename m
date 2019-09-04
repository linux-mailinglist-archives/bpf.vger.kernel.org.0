Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2092A94E7
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2019 23:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbfIDVXD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Sep 2019 17:23:03 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36900 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbfIDVXD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Sep 2019 17:23:03 -0400
Received: by mail-lj1-f194.google.com with SMTP id t14so199327lji.4
        for <bpf@vger.kernel.org>; Wed, 04 Sep 2019 14:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=y0/K/3NHW2BoW66hjF3E64lXnccuPIx+Txfbqzf3jL0=;
        b=e4KCsujIe59XNJPsOgxhHEmYvS6Ir/WAdxo1GJhGHE/R3+AjBK2RgqtyTX3IZyINrf
         SRreCzQZEnn0Yq8Wtj1O65F1SFMziACSlVSQCqda7Bh2FAcpMMUbrNGrjCaBJj9Zs4Ib
         OuBXJPEFa3+9pMFMo7zbfu76utYP3aIKNBrbRWQ6M+zBO7HmbHg4RrESIbDQapxTQ+c1
         hLH3lRY0zxCVAUmNOE73sfln/v46G/JKY5aY8q8Ida9BNUwgRAlBkTpd99zCRrZURLSt
         00nL2H4XqV0cpyNBcr7DamsSvkZTS5zQmVLP7Iqc+4QDVhEp+crY/7PKZWNKycVzq0V2
         fkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y0/K/3NHW2BoW66hjF3E64lXnccuPIx+Txfbqzf3jL0=;
        b=RhwJi9dqNwllcGaM+brq7XCrm5eK6k7GOaom+Tmvtfew4Ia2YRWpS4c54UY8Oo4Yfx
         lL19LzcM85xUhkNut7w1G0Z9ZWcwlYWo8K7Iw2I4d6i47rtFXwR4HaAmJLKEEixxrlcX
         XomPAxpnqd28d8JJqSePNmtB/PS9H9w0UmY/sfftVzmmq3MKC6mJ3SW8YvwIPXidf4oK
         tHM789D9BMkjLaLCHgY7sZalPoTcjJq4leLtiDte0a95K4FVXehS7TF5UWRKWd9TL8Mp
         kBMM8S8NEwZBYuqD4eydgpDKLWU7C/ZLQhG3AMQS0xsE3MvH2ws1ffZaju2aG5SKIy7Q
         wrCQ==
X-Gm-Message-State: APjAAAWz+4fgT0M/vV2eBqrXQ/L4vF2sVX5ATFv7S0qPCENKOkcCrEIB
        l6xjv0kQZpXcExNJ8CpveYkNNA==
X-Google-Smtp-Source: APXvYqxRpzRoAAkk3MuHOz0pYKzdu098OV1QWuP6crUl1RenkK0czy8yKZ2lfl5cQtYl5dgLJMMYOg==
X-Received: by 2002:a2e:9882:: with SMTP id b2mr3706041ljj.225.1567632181203;
        Wed, 04 Sep 2019 14:23:01 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id s8sm3540836ljd.94.2019.09.04.14.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 14:23:00 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH bpf-next 0/8] samples: bpf: improve/fix cross-compilation
Date:   Thu,  5 Sep 2019 00:22:04 +0300
Message-Id: <20190904212212.13052-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series contains mainly fixes/improvements for cross-compilation
(also verified on native platform build), tested on arm, but intended
for any arch.

Initial RFC link:
https://lkml.org/lkml/2019/8/29/1665

Besides the pathces given here, the RFC also contains couple patches
related to llvm clang
  arm: include: asm: swab: mask rev16 instruction for clang
  arm: include: asm: unified: mask .syntax unified for clang

The change touches not only cross-compilation and can have impact on
other archs and build environments, so might be good idea to verify
it in order to add appropriate changes, some warn options could be
tuned also.

Ivan Khoronzhuk (8):
  samples: bpf: Makefile: use --target from cross-compile
  samples: bpf: Makefile: remove target for native build
  libbpf: Makefile: add C/CXX/LDFLAGS to libbpf.so and test_libpf
    targets
  samples: bpf: use own EXTRA_CFLAGS for clang commands
  samples: bpf: Makefile: use vars from KBUILD_CFLAGS to handle linux
    headers
  samples: bpf: makefile: fix HDR_PROBE "echo"
  samples: bpf: add makefile.prog for separate CC build
  samples: bpf: Makefile: base progs build on Makefile.progs

 samples/bpf/Makefile      | 177 ++++++++++++++++++++++----------------
 samples/bpf/Makefile.prog |  77 +++++++++++++++++
 samples/bpf/README.rst    |   7 ++
 tools/lib/bpf/Makefile    |  11 ++-
 4 files changed, 197 insertions(+), 75 deletions(-)
 create mode 100644 samples/bpf/Makefile.prog

-- 
2.17.1

