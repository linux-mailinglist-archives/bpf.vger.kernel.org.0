Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADEE421F09
	for <lists+bpf@lfdr.de>; Tue,  5 Oct 2021 08:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbhJEGtC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Oct 2021 02:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhJEGtB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Oct 2021 02:49:01 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE25C061745
        for <bpf@vger.kernel.org>; Mon,  4 Oct 2021 23:47:11 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id cs11-20020a17090af50b00b0019fe3df3dddso1382686pjb.0
        for <bpf@vger.kernel.org>; Mon, 04 Oct 2021 23:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LReiECkU7NMOxG1fc31dEyINrPWgXAoIJLb6r1Endw0=;
        b=i6bdWrp8m1pc/CFiLNUgYNhcyY6DFCy0QZy5la+hxSU1wFoNVKtfuS7r27yR0YDncG
         oY6vISDB1HotQYm+NwcZjmklUWAdDG5B3J804H7pGJ9sjou2m8PWlYBtaHmkwkxdxRtV
         /WUSuxFj6L1d5q9+PmtZ0aV8cFtSFqtt9SBvvPNsnz7kTm9rpX1zJLKsXsH0PjNIiwiJ
         bYJJqHyDe2dfCnsU9JmX08CnP1kiqI8jreuiKNtpx6qTdCVg8rDv+2uyPZn3ZnBRjBnU
         CIURidEpvwlqo9nwtZDJQ9ln5Z8aI6Y7KCGP1zBd4FoL61f6VNuISXjIfqx7jnHu0Hjc
         vvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LReiECkU7NMOxG1fc31dEyINrPWgXAoIJLb6r1Endw0=;
        b=fal3FScVe/8WdO5QIBcncJDYZP3Fx+JNFiIx8iXwrmRsvwkTfWZa72j7PdOvOSEj6T
         z0WMNoRz2Weno0wR3vP/Jqp/YMRrF15b2HMLvqTk7Lz4o0Vr+DU/yoljbIapp9M7pk4d
         dInwl5U1t93LGHEK52p9nVNJINa2COeavrwwxTyJEYyhwjUwdocHgWzIK1O7mt8DkyR4
         gqNsjSvMOgB+QxPufTKHSDpGrMssxQkyLzK3VbN2nBz4j5rhz2rtZqivS3lrZwwB025+
         PulxmB9i51yJEqUvZllME3ZFTvKeUzv23k7PbIgQV1WedFJ+Jwr25kTAIn5MgA4PFtVO
         F5dA==
X-Gm-Message-State: AOAM532phpsZT+O1Pp6jL6/03JFikLn+d9pqtbufaJlhrR651FgKshHS
        0vxFbvOswU6ow8050ZFbUepkzK0pzcvJNA==
X-Google-Smtp-Source: ABdhPJzUBoevV5pQ3OvAWtFHLZQAQUchkV8X3/s6fzF5qbGfX3aFNmgDci3Taae6zWPIzaoinxca7w==
X-Received: by 2002:a17:90b:180f:: with SMTP id lw15mr1858356pjb.210.1633416430537;
        Mon, 04 Oct 2021 23:47:10 -0700 (PDT)
Received: from andriin-mbp.thefacebook.com ([2620:10d:c090:400::5:381e])
        by smtp.gmail.com with ESMTPSA id g9sm7185187pfv.80.2021.10.04.23.47.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Oct 2021 23:47:10 -0700 (PDT)
From:   andrii.nakryiko@gmail.com
X-Google-Original-From: andrii@kernel.org
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH bpf-next 0/3] libbpf: add bulk BTF type copying API
Date:   Mon,  4 Oct 2021 23:47:00 -0700
Message-Id: <20211005064703.60785-1-andrii@kernel.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andrii@kernel.org>

Add bulk BTF type data copying API, btf__add_btf(), to libbpf. This API is
useful for tools that are manipulating BPF, such as pahole. They abstract away
the details of implementing a pretty mundane, but important to get right,
details of handling all possible BTF kinds, as well as, importantly, adjusting
BTF type IDs and copying/deduplicating strings and string offsets, referenced
from copied BTF types.

Also, being a batch API, it's possible to improve the efficiency by
preallocating necessary memory more efficiently.

This API is going to be used by pahole to implement efficient parallelized BTF
encoding.

Cc: Arnaldo Carvalho de Melo <acme@kernel.org>

Andrii Nakryiko (3):
  libbpf: add API that copies all BTF types from one BTF object to
    another
  selftests/bpf: refactor btf_write selftest to reuse BTF generation
    logic
  selftests/bpf: test new btf__add_btf() API

 tools/lib/bpf/btf.c                           | 114 +++++++++++++-
 tools/lib/bpf/btf.h                           |  22 +++
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/btf_write.c      | 141 +++++++++++++++++-
 4 files changed, 270 insertions(+), 8 deletions(-)

-- 
2.30.2

