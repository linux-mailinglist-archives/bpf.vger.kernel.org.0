Return-Path: <bpf+bounces-9428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9143C797768
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 18:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC9F1C20C90
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 16:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE9E134C4;
	Thu,  7 Sep 2023 16:25:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BAD12B6A
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 16:25:15 +0000 (UTC)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F13AAD17
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 09:24:54 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-53fa455cd94so888387a12.2
        for <bpf@vger.kernel.org>; Thu, 07 Sep 2023 09:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694103812; x=1694708612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dtiwktbF06zdW84B3KfuIGOfxurm/7WZ4sZDBeOrwXM=;
        b=IXlXT2CwWH95OhRAFvQfIDegMV28DxBI/3FCoEEeMSJ1qTjdoORI+2y9q+/Y7ooKir
         w7NgNIIb79Wi+fftE4qc0FOXYYJKZ+8hnERVQl8jFYFGkcRSA1dFc+mE1L2vet87tZDr
         9Jc8VLKpKbvCnIRvuaXcd/mjpzguSXX0grlbKNlOCIayvicHs7bKQR/GKzpvtw7nnsmG
         xptVAc9ZBDUhq+c9s7PMsm3c81bTMOFqQgL1+NEXqLuwH4mpX2Y/Dz9jxls5lkMrjfR4
         eqflgj5i3fbC+6P59J6vWTAIZ0pD5vKukvRYtkPSbZhC46467UjSxRGVVPQOII12AeBe
         1olA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694103812; x=1694708612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dtiwktbF06zdW84B3KfuIGOfxurm/7WZ4sZDBeOrwXM=;
        b=WFTIYTPRxSRq0kLskUWT86zkIQiB9AekA5GtIh18DTjfdNzThmz1Fvv1q2RR/fzmHO
         5K6//u2URkFZ20NUPnrECq/9snRUQAVjnZfC7B6/UUGOb5L0YeLETOnjqe8wmuamYcg1
         xLmc+jptOhROKiP3qFx2946vcht1szVz9wslAQTsVbHWZ/08f2PxHxp7K4Yad6j4j/3e
         +1itSojSOHU0GXsBVjy+hUlA0JLa+bIUuYVN5xtMZWZdDCX8buKAYNX+10QfOajpukIQ
         QHFCzDCUou81M6ItfKVtP+aBmniyzjRtHW0I/9pSrLKzATzCNe82TuMVZz2/DL18ASBv
         YkcQ==
X-Gm-Message-State: AOJu0YwJFIXrIAfj93cE+8mCCVNAQ2vOFv8bL3TxrkGJ3CRwqs1atYho
	Qt0ZEHAbHY7Mzuac3rgO4ROvp8Ov67WIsQ==
X-Google-Smtp-Source: AGHT+IF7yYSiIF04SIufxciqiPaszWdYUpImojf6ajby0qTBkK1RuRrZSmjGgSco/0vMiKKgd+muNw==
X-Received: by 2002:a05:6a00:b87:b0:68b:4e07:1358 with SMTP id g7-20020a056a000b8700b0068b4e071358mr18186595pfj.11.1694065389763;
        Wed, 06 Sep 2023 22:43:09 -0700 (PDT)
Received: from ubuntu.. ([43.132.98.117])
        by smtp.googlemail.com with ESMTPSA id q7-20020a637507000000b00570574feda0sm11860963pgc.19.2023.09.06.22.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 22:43:09 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alan.maguire@oracle.com,
	olsajiri@gmail.com,
	hengqi.chen@gmail.com
Subject: [PATCH bpf-next v2 0/3] libbpf: Support symbol versioning for uprobe
Date: Tue,  5 Sep 2023 15:12:54 +0000
Message-Id: <20230905151257.729192-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
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

