Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216204A5201
	for <lists+bpf@lfdr.de>; Mon, 31 Jan 2022 23:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiAaWFc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 Jan 2022 17:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiAaWFc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Jan 2022 17:05:32 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AEAC061714
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 14:05:31 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id g15-20020a17090a67cf00b001b7d5b6bedaso488602pjm.4
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 14:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oN/LqmjLJnGQt+Ryqemsw+i70qnxsONKSr1Yo6p2PkU=;
        b=Ns759+6J20OZ6F/SZNEeXGfr7Ji8HFe0ul0o/jmQplpZa85UOet4hVJ/VWLvF1mKi7
         we6PwbmLH/dRILK9W50WZQksnfC19aUcvWLtRF91mTuoGJXMDgpSchxF5FfqkoaQVzun
         8bhq3+uwgWQAviN9Rmmz4NipLkhbl72D5kyWd8X46/J+Ol1htaw9QzheQbVEIwkaIY8O
         5JGKCS1GwIt+6HyNBag6h43INtOQTczTdvYq58lBK5m3jL2ynCIHFjhZ5ziYM7qVDn7A
         A85WKehlBDJP7MZ3SSwJtt3ywgFD+QKY5zBFNkJn2MDdQH86VDZcHNKUaD9LPf5mF5QX
         ea0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oN/LqmjLJnGQt+Ryqemsw+i70qnxsONKSr1Yo6p2PkU=;
        b=Iw9rdd9HyYlyITLXfP8OEgRNNzUFA6ol4TkSHF7Srzwyw2rmlaDtez4/aGI/UXs7di
         SZ8xiS9Xi+gn33BttRY0YcnsqWkSoxKq0IsZeW1Mvw3uD05ZfgiUlVQE0A0wE4EysGQk
         Mf0HGhsm3tkoFQN5tAqI9w7X01RlJ+UkH1spQjTH8UvV941odaMcpgGmfq782a6hJDX1
         0jNByuC69Iqvo4sZni2agVlXjYWI/40+aSjYKI2qZc7cvPPpwZNb+0psN0S+lwVA8srC
         XB40mthjvO1sZGgHjjraatxJ5lWpH0v84AI4bnMyyyh5ASY3dMyxr1hbVlzxuaIvM4RI
         MndA==
X-Gm-Message-State: AOAM531dslti5CmMoo/QgWKsh8BktU0ysTce4RPXhRCdBjHvDLUavMoY
        C2x0Mbf/wFZkhh+gKYK/yas=
X-Google-Smtp-Source: ABdhPJzq8rAzVpFAbrMXnOBT/hgkupW7Mt76ip+mps8C+w1aNvlEDQzrVv7VgZ0IjbAQHpaXiZfLnw==
X-Received: by 2002:a17:90b:3b46:: with SMTP id ot6mr31084367pjb.179.1643666731015;
        Mon, 31 Jan 2022 14:05:31 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:78b6])
        by smtp.gmail.com with ESMTPSA id l191sm27552700pga.65.2022.01.31.14.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:05:30 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH bpf-next 0/7] bpf: drop libbpf from bpf preload.
Date:   Mon, 31 Jan 2022 14:05:21 -0800
Message-Id: <20220131220528.98088-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

CO-RE in the kernel support allows bpf preload to switch to light skeleton
and remove libbpf dependency.
This reduces the size of bpf_preload_umd from 300kbyte to 19kbyte and
eventually will make "kernel skeleton" possible.

Alexei Starovoitov (7):
  libbpf: Add support for bpf iter in light skeleton.
  libbpf: Open code low level bpf commands.
  libbpf: Open code raw_tp_open and link_create commands.
  bpf: Remove unnecessary setrlimit from bpf preload.
  bpf: Convert bpf preload to light skeleton.
  bpf: Open code obj_get_info_by_fd in bpf preload.
  bpf: Drop libbpf, libelf, libz dependency from bpf preload.

 kernel/bpf/preload/Makefile                   |  28 +-
 kernel/bpf/preload/iterators/Makefile         |   6 +-
 kernel/bpf/preload/iterators/iterators.c      |  28 +-
 .../bpf/preload/iterators/iterators.lskel.h   | 428 ++++++++++++++++++
 kernel/bpf/preload/iterators/iterators.skel.h | 412 -----------------
 tools/bpf/bpftool/gen.c                       |   7 +-
 tools/lib/bpf/skel_internal.h                 |  70 ++-
 7 files changed, 527 insertions(+), 452 deletions(-)
 create mode 100644 kernel/bpf/preload/iterators/iterators.lskel.h
 delete mode 100644 kernel/bpf/preload/iterators/iterators.skel.h

-- 
2.30.2

