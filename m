Return-Path: <bpf+bounces-9617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8082179A10A
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 03:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FE6E1C2087D
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 01:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18F017E1;
	Mon, 11 Sep 2023 01:51:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD03C17C8
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 01:51:14 +0000 (UTC)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE5A123
	for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 18:51:12 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-5733789a44cso2431974eaf.2
        for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 18:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694397072; x=1695001872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NIrD4OGErky22B7izh4VK4AVlF8VD64f1X+KTKExVRM=;
        b=RhlGLn4Pq4smXTjmiTQinkFDJwAEo/c2nVrfq8/P4AwN1ZEFsP8ahucQZX1WRR6XLx
         OutmgaIrsZTya4EZBMDxdiV8ZQ9SVqq1UxlaDOj9Op3eaTtEDJg46kJgNSHOSPug1mkE
         VMNueUiVEMH/K2rxLUS7K/KDaP3ek7O5XosfzvM7Yx3qNUx/GO3MvO5XW4voU1PiorUZ
         uwBKJAJD1HiH6qOzC/sKXsaum/1r4Sf01ZxVj93oX190MQtbscZWFGLGJdmLQIQncnCX
         JDcFuQiqXUVtDR5qegdc3XjrUCCj2zhbDQgwOjK7UFSzF1uWrqObdXXgYtJpACOfChlk
         +wPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694397072; x=1695001872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NIrD4OGErky22B7izh4VK4AVlF8VD64f1X+KTKExVRM=;
        b=i6w5Tye55Mta0H8+Xdnarmoo6xS7k+RQJizeIBzlVxQk6W+Wa6AScWgzQ5NAqhl9g4
         5GQHJPscQZ11fTIoTvjNYcVeo4Do8Pm9nobVWZnH2/3C5Qty7GHwUiN1IKDZ4pAAFa73
         DZ27gY4bKz2u65DzcSm4qW2nu2VFJ2dG2PFztG1E68t+KGgXODQbpTXT14/P3dTIvtvC
         rKL06DDAAa15Da4VOA/NDZacMvoHdgMANE0iPhd2pa7SaySxB78xXIkxNnZ64gP7+/70
         mVNdUK0Lgbn+fTgxVAHtYseRndmzOCI5ENzhsjXMUTqAgPIqslt9bhnIe7xdmb6g9iOT
         y16A==
X-Gm-Message-State: AOJu0YxHE+ZhWgEd4tUiZZGQQj35/bt/zd/rDxzWJoTEe61c5qpTKJ+O
	l4uMKwTZlfvAWFCAjvEKo80iw9WUWxmIJA==
X-Google-Smtp-Source: AGHT+IEXgI6hOsRKh+5pS8SgULTaO3UKKVX6pxBDi6hFJIvhwpxMCsSlI/THBCuwE/emgdqbBPV0/A==
X-Received: by 2002:a05:6358:71d:b0:135:43da:b16d with SMTP id e29-20020a056358071d00b0013543dab16dmr9250451rwj.11.1694397071555;
        Sun, 10 Sep 2023 18:51:11 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id z14-20020a63b04e000000b0056365ee8603sm4375699pgo.67.2023.09.10.18.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 18:51:10 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alan.maguire@oracle.com,
	olsajiri@gmail.com,
	hengqi.chen@gmail.com
Subject: [PATCH bpf-next v3 0/3] libbpf: Support symbol versioning for uprobe
Date: Mon, 11 Sep 2023 01:50:49 +0000
Message-Id: <20230911015052.72975-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dynamic symbols in shared library may have the same name, for example:

    $ nm -D /lib/x86_64-linux-gnu/libc.so.6 | grep rwlock_wrlock
    000000000009b1a0 T __pthread_rwlock_wrlock@GLIBC_2.2.5
    000000000009b1a0 T pthread_rwlock_wrlock@@GLIBC_2.34
    000000000009b1a0 T pthread_rwlock_wrlock@GLIBC_2.2.5

    $ readelf -W --dyn-syms /lib/x86_64-linux-gnu/libc.so.6 | grep rwlock_wrlock
      706: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 __pthread_rwlock_wrlock@GLIBC_2.2.5
      2568: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 pthread_rwlock_wrlock@@GLIBC_2.34
      2571: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 pthread_rwlock_wrlock@GLIBC_2.2.5

There are two pthread_rwlock_wrlock symbols in libc.so .dynsym section.
The one with @@ is the default version, the other is hidden.
Note that the version info is stored in .gnu.version and .gnu.version_d
sections of libc and the two symbols are at the _same_ offset.

Currently, specify `pthread_rwlock_wrlock`, `pthread_rwlock_wrlock@@GLIBC_2.34`
or `pthread_rwlock_wrlock@GLIBC_2.2.5` in bpf_uprobe_opts::func_name won't work.
Because there are two `pthread_rwlock_wrlock` in .dynsym sections without the
version suffix and both are global bind.

We could solve this by introducing symbol versioning ([0]). So that users can
specify func, func@LIB_VERSION or func@@LIB_VERSION to attach a uprobe.

This patchset resolves symbol conflicts and add symbol versioning for uprobe.
  - Patch 1 resolves symbol conflicts at the same offset
  - Patch 2 adds symbol versioning for dynsym
  - Patch 3 adds selftests for the above changes

Changes from v2:
  - Add uretprobe selfttest (Alan)
  - Check symbol exact match (Alan)
  - Fix typo (Jiri)

Changes from v1:
  - Address comments from Alan and Jiri
  - Add selftests (Someone reminds me that there is an attempt at [1]
    and part of the selftest code from Andrii is taken from there)

  [0]: https://refspecs.linuxfoundation.org/LSB_5.0.0/LSB-Core-generic/LSB-Core-generic/symversion.html
  [1]: https://lore.kernel.org/lkml/CAEf4BzZTrjjyyOm3ak9JsssPSh6T_ZmGd677a2rt5e5rBLUrpQ@mail.gmail.com/

Hengqi Chen (3):
  libbpf: Resolve symbol conflicts at the same offset for uprobe
  libbpf: Support symbol versioning for uprobe
  selftests/bpf: Add tests for symbol versioning for uprobe

 tools/lib/bpf/elf.c                           | 150 ++++++++++++++++--
 tools/lib/bpf/libbpf.c                        |   2 +-
 tools/testing/selftests/bpf/Makefile          |   5 +-
 .../testing/selftests/bpf/liburandom_read.map |  15 ++
 .../testing/selftests/bpf/prog_tests/uprobe.c |  95 +++++++++++
 .../testing/selftests/bpf/progs/test_uprobe.c |  61 +++++++
 tools/testing/selftests/bpf/urandom_read.c    |   9 ++
 .../testing/selftests/bpf/urandom_read_lib1.c |  41 +++++
 8 files changed, 361 insertions(+), 17 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/liburandom_read.map
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_uprobe.c

--
2.34.1

