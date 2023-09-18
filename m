Return-Path: <bpf+bounces-10245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE457A409A
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 07:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF2E61C20965
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 05:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02A6522C;
	Mon, 18 Sep 2023 05:50:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C571A15D4
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 05:50:12 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC27121
	for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 22:50:10 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68fbb10dea4so3078287b3a.3
        for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 22:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695016210; x=1695621010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/WJtZJ7A+MviBhAxktc4mylQzGlAyUurHJKKPuHnFwA=;
        b=B5f8XQ9cJJ5KXUAaf5OzEN8caSDux7bvSbyZd7ZDjCvU43/PP/gSypL+Y4aUzscKiA
         aVHGrEV/dGErML3+P//c8ic54TS2rWzmDm7Dx+jbrXjY227FMnY8nbY2w4wMMje+oUQT
         QSYYksBDTmRcC1wvMwuRakoXecRpBQJ5i24qEk/rLMsgjp/e+RC6IYwkobnCRVztk6HM
         JsNpf1SzgHbMalAYG9Xn/LF8P77AU23uv0HqsHtL398cRqEJ3Rjwe67XaNN+zklViVdz
         rLo00ydyptQheSt3w5cSZeqFKsSo4qFXuMP423b2lRL6U+jJEe9EynaFY5b0Ypt0okOU
         bgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695016210; x=1695621010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/WJtZJ7A+MviBhAxktc4mylQzGlAyUurHJKKPuHnFwA=;
        b=bBB6uuChuSzyCggVkQgG+2xBFNxUO25SsLq48xo7zs2I2uEFzF+CvCNYAo+7HyjCKu
         o6ANIRuuIXzPRxIpkyJAUSf+iz6/Lw2q+5Now/J9HG1yOwqEPkH4+eJEs1f4qtfxybyF
         wdTHSfOAV9P6glfLffL6Q8He2G8h2e/fuUDUHdTQQWzKBnGIIEN6GYXYptJD7Fmak0tX
         Yz8saJEef5c8WIGK1+k0PPj9pmwHrsbLJNS+w2W6XIQh+YuKJTkOYuF2doPL/LBUIoxR
         T725W5fo+s7yt7P9tJFg8zj2W6IhoobzbLUyL5MTjo/GXUvosAX/AIR/6ZxRH37Yt8h7
         xnvw==
X-Gm-Message-State: AOJu0YxjwltcoRyl3AmGqHGxiQ7CTjxp0cSQSx0RyPuuAJl8W2k3OpE9
	/OBu3+gJjMrPrlM6eZ/5iAQ7OLywsxLc/A==
X-Google-Smtp-Source: AGHT+IEIt7Bxo3AJmqlDWJuKESydz6vWaMYAfwhDjEERIjhPlKOBXFwW9hVk10OpGpqYMaBiL5OoCw==
X-Received: by 2002:a05:6a00:c90:b0:68f:e0f0:85f4 with SMTP id a16-20020a056a000c9000b0068fe0f085f4mr6383572pfv.25.1695016209630;
        Sun, 17 Sep 2023 22:50:09 -0700 (PDT)
Received: from ubuntu.. ([203.205.141.25])
        by smtp.googlemail.com with ESMTPSA id i15-20020aa787cf000000b006877a17b578sm6374496pfo.40.2023.09.17.22.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 22:50:09 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alan.maguire@oracle.com,
	olsajiri@gmail.com,
	hengqi.chen@gmail.com
Subject: [PATCH bpf-next v4 0/3] libbpf: Support symbol versioning for uprobe
Date: Mon, 18 Sep 2023 02:48:10 +0000
Message-Id: <20230918024813.237475-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Level: *
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

Changes from v3:
  - Address comments from Andrii

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

 tools/lib/bpf/elf.c                           | 139 ++++++++++++++++--
 tools/lib/bpf/libbpf.c                        |   2 +-
 tools/testing/selftests/bpf/Makefile          |   5 +-
 .../testing/selftests/bpf/liburandom_read.map |  15 ++
 .../testing/selftests/bpf/prog_tests/uprobe.c |  95 ++++++++++++
 .../testing/selftests/bpf/progs/test_uprobe.c |  61 ++++++++
 tools/testing/selftests/bpf/urandom_read.c    |  15 +-
 .../testing/selftests/bpf/urandom_read_lib1.c |  22 +++
 8 files changed, 337 insertions(+), 17 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/liburandom_read.map
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_uprobe.c

-- 
2.34.1


