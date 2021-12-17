Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2B7479472
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 19:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhLQS5G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Dec 2021 13:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240550AbhLQS5B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Dec 2021 13:57:01 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAADC061574
        for <bpf@vger.kernel.org>; Fri, 17 Dec 2021 10:57:00 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id n7so6047641uaq.12
        for <bpf@vger.kernel.org>; Fri, 17 Dec 2021 10:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KGTZabGEEK1L7pAQxxN6eDoiEEbmeCxeZZ7RBokUcp0=;
        b=HdMRkiXdF+PUCiu2F0TK7ILbbKPiI0t1wUtRaTlwFP2tg3Iucrxo+j+jL9aHLJbGch
         E6aChQkCR63Rknk4iDwwvoOjl+LXgzR6X5VzzKknwW/3/dksNXg0GYPVqegXfByvFmLI
         iQG2bQ+myLZZBd8jCTxuWZEfDtIRD1kvfGH1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KGTZabGEEK1L7pAQxxN6eDoiEEbmeCxeZZ7RBokUcp0=;
        b=rZZclZ43KP6AOSBFB02HlYHvwUXqnbD60AoT3VGYkygk74pbj098rSb1UA+6yJjm4Z
         VV+yXmfH0E4VIbhtSpVlSFVhHi7sU9HbLKpXGR3iCNnfT18QwPMXmuu+HIkSyZPU656I
         6nsh6w/6Slc4Efv6cBjX3SoBCXcnJprv8pkUgOmpa2goos+Z45VidnKMXQGa+y5paYs4
         tqlJHJPNFEROwwIkv1LpVeYAyPe3LG+nsrrtDXRYtUwDdeoUZwg0A2hcGi9pMrXojilF
         2gmkBKTgN8GlHt5zmSD+NYZmODs+U+MYUEt7CmEena/OHXvQrkm9L2dHVOQbpTQNbDmo
         RtsQ==
X-Gm-Message-State: AOAM532eyXSiaf8HrlVCvuNA8MQLNLNifNNsT3sgAPmJBdLplZAoAb0V
        6rMT2QPPnfnoDv1otUbHGAM/rw==
X-Google-Smtp-Source: ABdhPJy1Nj+PtBPZhbhEStwXGKVRuXeMBPHWkJ4j3ch4d93lPTvoSPRNUPVup8QJHiLxyCLe+ZRa0g==
X-Received: by 2002:a67:df90:: with SMTP id x16mr1789289vsk.52.1639767419121;
        Fri, 17 Dec 2021 10:56:59 -0800 (PST)
Received: from localhost.localdomain ([181.136.110.101])
        by smtp.gmail.com with ESMTPSA id l125sm1382575vke.40.2021.12.17.10.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 10:56:58 -0800 (PST)
From:   =?UTF-8?q?Mauricio=20V=C3=A1squez?= <mauricio@kinvolk.io>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Rafael David Tinoco <rafaeldtinoco@gmail.com>,
        Lorenzo Fontana <lorenzo.fontana@elastic.co>,
        Leonardo Di Donato <leonardo.didonato@elastic.co>
Subject: [PATCH bpf-next v3 0/3] libbpf: Implement BTFGen
Date:   Fri, 17 Dec 2021 13:56:51 -0500
Message-Id: <20211217185654.311609-1-mauricio@kinvolk.io>
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
it's not available on kernels before 5.12.

It's possible to use CO-RE in kernels without CONFIG_DEBUG_INFO_BTF
support by providing the BTF information from an external source.
BTFHub[0] contains BTF files to each released kernel not supporting BTF,
for the most popular distributions.

Providing this BTF file for a given kernel has some challenges: 1. Each
BTF file is a few MBs big, then it's not possible to ship the eBPF
program with all the BTF files needed to run in different kernels. (The
BTF files will be in the order of GBs if you want to support a high
number of kernels) 2. Downloading the BTF file for the current kernel at
runtime delays the start of the program and it's not always possible to
reach an external host to download such a file.

Providing the BTF file with the information about all the data types of
the kernel for running an eBPF program is an overkill in many of the
cases. Usually the eBPF programs access only some kernel fields.

This series implements BTFGen support in bpftool by exposing some of the
internal libbpf's APIs to it.

This idea was discussed during the "Towards truly portable eBPF"[1]
presentation at Linux Plumbers 2021.

There is a good example[2] on how to use BTFGen and BTFHub together
to generate multiple BTF files, to each existing/supported kernel,
tailored to one application. For example: a complex bpf object might
support nearly 400 kernels by having BTF files summing only 1.5 MB.

[0]: https://github.com/aquasecurity/btfhub/
[1]: https://www.youtube.com/watch?v=igJLKyP1lFk&t=2418s
[2]: https://github.com/aquasecurity/btfhub/tree/main/tools

Changelog:

v2 > v3:
- expose internal libbpf APIs to bpftool instead
- implement btfgen in bpftool
- drop btf__raw_data() from libbpf

v1 > v2:
- introduce bpf_object__prepare() and ‘record_core_relos’ to expose
  CO-RE relocations instead of bpf_object__reloc_info_gen()
- rename btf__save_to_file() to btf__raw_data()

v1: https://lore.kernel.org/bpf/20211027203727.208847-1-mauricio@kinvolk.io/
v2: https://lore.kernel.org/bpf/20211116164208.164245-1-mauricio@kinvolk.io/

Mauricio Vásquez (3):
  libbpf: split bpf_core_apply_relo()
  libbpf: Implement changes needed for BTFGen in bpftool
  bpftool: Implement btfgen

 kernel/bpf/btf.c                |  11 +-
 tools/bpf/bpftool/gen.c         | 892 ++++++++++++++++++++++++++++++++
 tools/lib/bpf/Makefile          |   2 +-
 tools/lib/bpf/libbpf.c          | 124 +++--
 tools/lib/bpf/libbpf.h          |   3 +
 tools/lib/bpf/libbpf.map        |   2 +
 tools/lib/bpf/libbpf_internal.h |  22 +
 tools/lib/bpf/relo_core.c       |  83 +--
 tools/lib/bpf/relo_core.h       |  46 +-
 9 files changed, 1086 insertions(+), 99 deletions(-)

-- 
2.25.1

