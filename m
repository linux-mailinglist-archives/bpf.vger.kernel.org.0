Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1620A8207C
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2019 17:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbfHEPk6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Aug 2019 11:40:58 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:46616 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbfHEPk6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Aug 2019 11:40:58 -0400
Received: by mail-pl1-f202.google.com with SMTP id k9so46484877pls.13
        for <bpf@vger.kernel.org>; Mon, 05 Aug 2019 08:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2x05NJzRBxAgvVOllXn3alCW8vnfUBvAPstMLvDWM7c=;
        b=bynFntyDG6vxmRv17Ri6M/YvC9mMVLd0Vnc0lVnk9eTvbPzMeXulY55RiWJuUXhOKL
         40l4rOrT7s4bAXBYQFFQ6w3M944K3IE1fT4Gd8TmZC3/IDoghhKobvPuDhuGneC4jR/V
         MN2yUwA4Nj24rnikNurWSX0wod/+fQZ9OlGXtEAiNutWYE7vwFakIUIDPsrYkag+YBrK
         C0tyUAc5ehdzYmGuu06IRw1sdQYEqo5wY4wNJCEbDrrXt/XLrr/nw+WD7mY4l10OU65y
         r29IedxX1zf9s1ArKbn2VBOoc3vm+qRnrFhukD0x+v35U4M9M5lLJEnTl48NJKDRZ4pP
         lmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2x05NJzRBxAgvVOllXn3alCW8vnfUBvAPstMLvDWM7c=;
        b=Vb/8wdGXlb6HAyWDpcI3Q06DUBGu2ZOeq+WlRmNvZ2P799tMAhaeEx9gTD/rCSzJ1/
         oo4SPL1iAtN55/BaBVNhdXAnZSxI6U+Jut2zLL5tHbaKhZff/Wwj+8nuE3nd6jJaDxEB
         fU48icYZv5KEqkMHKpPe+/K1DSa+8mTCekyZ1/uLnllJXJzH9YG/NYSLX7QJxMUztA5I
         9oG/rB/miNamoSuIYhyeU5q3dDrbTc+mTlx64wpRj5Jonyqw/U2CfNRu+IgniWMgZLrP
         AiZIjGUGt6c/geckbpi/UCILTeIaakP0ouansnLJMGYH9/NvvHHDtYWyT+w+KIDSdSPM
         QvTg==
X-Gm-Message-State: APjAAAXyVbd+8tBUa7U34qlN9mzPqkR+K4/lFrv69nU6GM03zmtsmcOx
        4VAuKTPUDwf84viLEAkGDURb6fw=
X-Google-Smtp-Source: APXvYqx5AcurOPux+I93ieBh5a1gzf/6tIOd0gaZs5dHC3TkcW2NvbgH7ooO3UQzsd8/Lfs7Gxbzmis=
X-Received: by 2002:a63:1046:: with SMTP id 6mr140549546pgq.111.1565019657053;
 Mon, 05 Aug 2019 08:40:57 -0700 (PDT)
Date:   Mon,  5 Aug 2019 08:40:52 -0700
Message-Id: <20190805154055.197664-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH bpf-next v3 0/3] selftests/bpf: switch test_progs back to stdio
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I was looking into converting test_sockops* to test_progs framework
and that requires using cgroup_helpers.c which rely on stdio/stderr.
Let's use open_memstream to override stdout into buffer during
subtests instead of custom test_{v,}printf wrappers. That lets
us continue to use stdio in the subtests and dump it on failure
if required.

That would also fix bpf_find_map which currently uses printf to
signal failure (missed during test_printf conversion).

Cc: Andrii Nakryiko <andriin@fb.com>

Stanislav Fomichev (3):
  selftests/bpf: test_progs: switch to open_memstream
  selftests/bpf: test_progs: test__printf -> printf
  selftests/bpf: test_progs: drop extra trailing tab

 .../bpf/prog_tests/bpf_verif_scale.c          |   4 +-
 .../selftests/bpf/prog_tests/l4lb_all.c       |   2 +-
 .../selftests/bpf/prog_tests/map_lock.c       |  10 +-
 .../selftests/bpf/prog_tests/send_signal.c    |   4 +-
 .../selftests/bpf/prog_tests/spinlock.c       |   2 +-
 .../bpf/prog_tests/stacktrace_build_id.c      |   4 +-
 .../bpf/prog_tests/stacktrace_build_id_nmi.c  |   4 +-
 .../selftests/bpf/prog_tests/xdp_noinline.c   |   4 +-
 tools/testing/selftests/bpf/test_progs.c      | 131 ++++++++----------
 tools/testing/selftests/bpf/test_progs.h      |  12 +-
 10 files changed, 83 insertions(+), 94 deletions(-)

-- 
2.22.0.770.g0f2c4a37fd-goog
