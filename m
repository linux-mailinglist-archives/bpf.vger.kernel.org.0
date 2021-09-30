Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAD841D8D2
	for <lists+bpf@lfdr.de>; Thu, 30 Sep 2021 13:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350410AbhI3Lfo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Sep 2021 07:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350389AbhI3Lfo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Sep 2021 07:35:44 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADB8C06176C
        for <bpf@vger.kernel.org>; Thu, 30 Sep 2021 04:34:01 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d6so9462916wrc.11
        for <bpf@vger.kernel.org>; Thu, 30 Sep 2021 04:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4zv1FXe5CObD34uZcG8NuCHBjmVhk/xzFwcoGbeLT9M=;
        b=EmAXTPCTEqxfNQggl8CqjistCYgWkAHu0tmQzRIkOmKQRANs6pDIsh8JZR88HuEfHe
         3J6VF42SoYo2rAWazC72bHu/P05P46MbofCSdg7l5hJOSGreJb0hvXxDLcitSkcFiy4f
         /WNJ1YOROVCO+QnS71Zs7UCz2plInablQNHBpJBitCtRRloIIh7w1u5OkyQ2XrCIyGbd
         +ewI5pkxfioo+jzaEGEfPXDgGUPmrtywsA8jTJ4Wia8tTarQ+QcNbVhjp3GthTmCOExu
         cotiXGYSu3uRDlCef/ZckJ37KdTSDteFQ7GmfJwc0g6IWbIOGPrHzLFp6b4LJ/wF1v4P
         vegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4zv1FXe5CObD34uZcG8NuCHBjmVhk/xzFwcoGbeLT9M=;
        b=3TzaxDGFbBUu9FjhIl7U9mISt27C1WEJBUT6w2v83cQtUazpgSv+VReL679VzWM+O8
         bQ/G4ePb7QQPEXTMnbpaClwtmD5lF4zMrDW3se6jbIsy5vjN1cATBynHoXgVd2o/8Dxk
         tmmC/W79CLeDgU/S7iR29X5KG9/YZLxQzvkR8oeY+TcAGQzYWk4J1EmJJ6MWGT20XqUi
         hUfWg2Lf7s8Uxn8XOBSAsn34L8tki6AH2GNd3r04HdvG4359F0xMzUWY/+K0Z+/zgOMe
         T03NlF+b+t/Ifc9upYc6f8Q/mXa7Tbrn823jzX1Vvjp9S9kZoyCRUFhN4OXWqwABANnD
         AkGA==
X-Gm-Message-State: AOAM533+6yag3C+t7OlYsJl0HEFmTC+rClnd6NDBZnQ6sLVbuDpU21ct
        zYAuhHK3T6XYQmUNvLarVkud1A==
X-Google-Smtp-Source: ABdhPJyIL1gEwyZXHsk3/1CGeP4ONcnuuME/+XPB8vcCxufkwQM2IMrUVUlcPD67UCH9caAmhujFdw==
X-Received: by 2002:adf:a10f:: with SMTP id o15mr5591331wro.286.1633001640287;
        Thu, 30 Sep 2021 04:34:00 -0700 (PDT)
Received: from localhost.localdomain ([149.86.91.95])
        by smtp.gmail.com with ESMTPSA id v10sm2904660wrm.71.2021.09.30.04.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 04:33:59 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 0/9] install libbpf headers when using the library
Date:   Thu, 30 Sep 2021 12:32:57 +0100
Message-Id: <20210930113306.14950-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Libbpf is used at several locations in the repository. Most of the time,
the tools relying on it build the library in its own directory, and include
the headers from there. This works, but this is not the cleanest approach.
It generates objects outside of the directory of the tool which is being
built, and it also increases the risk that developers include a header file
internal to libbpf, which is not supposed to be exposed to user
applications.

This set adjusts all involved Makefiles to make sure that libbpf is built
locally (with respect to the tool's directory or provided build directory),
and by ensuring that "make install_headers" is run from libbpf's Makefile
to export user headers properly.

This comes at a cost: given that the libbpf was so far mostly compiled in
its own directory by the different components using it, compiling it once
would be enough for all those components. With the new approach, each
component compiles its own version. To mitigate this cost, efforts were
made to reuse the compiled library when possible:

- Make the bpftool version in samples/bpf reuse the library previously
  compiled for the selftests.
- Make the bpftool version in BPF selftests reuse the library previously
  compiled for the selftests.
- Similarly, make resolve_btfids in BPF selftests reuse the same compiled
  library.
- Similarly, make runqslower in BPF selftests reuse the same compiled
  library; and make it rely on the bpftool version also compiled from the
  selftests (instead of compiling its own version).
- runqslower, when compiled independently, needs its own version of
  bpftool: make them share the same compiled libbpf.

As a result:

- Compiling the samples/bpf should compile libbpf just once.
- Compiling the BPF selftests should compile libbpf just once.
- Compiling the kernel (with BTF support) should now lead to compiling
  libbpf twice: one for resolve_btfids, one for kernel/bpf/preload.
- Compiling runqslower individually should compile libbpf just once. Same
  thing for bpftool, resolve_btfids, and kernel/bpf/preload/iterators.

(Not accounting for the boostrap version of libbpf required by bpftool,
which was already placed under a dedicated .../boostrap/libbpf/ directory,
and for which the count remains unchanged.)

A few commits in the series also contain drive-by clean-up changes for
bpftool includes, samples/bpf/.gitignore, or test_bpftool_build.sh. Please
refer to individual commit logs for details.

Quentin Monnet (9):
  tools: bpftool: remove unused includes to <bpf/bpf_gen_internal.h>
  tools: bpftool: install libbpf headers instead of including the dir
  tools: resolve_btfids: install libbpf headers when building
  tools: runqslower: install libbpf headers when building
  bpf: preload: install libbpf headers when building
  bpf: iterators: install libbpf headers when building
  samples/bpf: install libbpf headers when building
  samples/bpf: update .gitignore
  selftests/bpf: better clean up for runqslower in test_bpftool_build.sh

 kernel/bpf/preload/Makefile                   | 19 +++++++---
 kernel/bpf/preload/iterators/Makefile         | 18 ++++++----
 samples/bpf/.gitignore                        |  3 ++
 samples/bpf/Makefile                          | 36 +++++++++++++------
 tools/bpf/bpftool/Makefile                    | 27 ++++++++------
 tools/bpf/bpftool/gen.c                       |  1 -
 tools/bpf/bpftool/prog.c                      |  1 -
 tools/bpf/resolve_btfids/Makefile             | 17 ++++++---
 tools/bpf/resolve_btfids/main.c               |  4 +--
 tools/bpf/runqslower/Makefile                 | 12 ++++---
 tools/testing/selftests/bpf/Makefile          | 22 ++++++++----
 .../selftests/bpf/test_bpftool_build.sh       |  4 +++
 12 files changed, 110 insertions(+), 54 deletions(-)

-- 
2.30.2

