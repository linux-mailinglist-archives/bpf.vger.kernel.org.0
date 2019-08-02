Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB8180219
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2019 23:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbfHBVLM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Aug 2019 17:11:12 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:50918 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfHBVLM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Aug 2019 17:11:12 -0400
Received: by mail-pf1-f202.google.com with SMTP id h27so48998059pfq.17
        for <bpf@vger.kernel.org>; Fri, 02 Aug 2019 14:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3dxbmYEhw+rCqvWay2j/TQjWw8okzeOVx0ueDyRuULg=;
        b=DlMTuoinxcf6KR/pUJT8KazzJhslqNfKEynU9O45xbs1K0yojtRwXbMzEts/u+ifJJ
         UbGAel/s7cK8TmxYxbE46egVs2AXs7LD/Vy8Zz/ah8ABFuqeg3+xnv5tkYv/0dyXrqs/
         wsnj1faq9+fXKezYgDT7Iw17m2PDL3G0D2vyHQYCOgwjGAn1hOlWenu6cSmAyQKOClzt
         lx0cz5irsgHhBXXGjsq7nF+W/k/Xd9Y05wlu86Bh7VH5evAfxMn/K1ajdjpv0+48nKgb
         iQaAUiHBvYQh6gHt/rLwXGhs9agYf+5/ncL09aH+RzblkjbiJcP4uG4rpJgUGwZaxpka
         DQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3dxbmYEhw+rCqvWay2j/TQjWw8okzeOVx0ueDyRuULg=;
        b=muR+MtxOG/tS9i55dNLi9PT2vVn9l6P8//J/YcvdqixrxXLP9k4p0du4jJQcpIuoGx
         MYYQxdwRqk73/kRQpa+rjwOBHlkFGHxRdNXZOHzmfSpMi3diUd9xMXRKFr85Fs+aRRLv
         mW4Mw+LpzK40JELnJ+d5S6J8Cc/+CaYRD4lUKYaEvS9pqcoKLy7WA4umV+sudxNrWjdn
         ECkQjPtSVzSgdGgvQoKUB/SD7pdPrlwSdYB0FJZKH4CtBZwS+t7+Gx47m885I3/BzZbP
         z5owmpASXMJhamE+l51RudndW7LtK98Xzpqdg7A++TkcELP7ODGLKJOnvVW8WMUg/2t4
         svwQ==
X-Gm-Message-State: APjAAAUHHwlirXiHe8Jyq+vxt9/sU7u9voeoCuY1gx/OHXZu644WIBrI
        nhQ8zlj+g2q+qk1Cohms99WWYfw=
X-Google-Smtp-Source: APXvYqxAWopCpPz0eVit3/wNRDfqL+5YCKxF8IAaNmhn2xw+CGiBnZ89nrcFse8WxRhYEmW6e2o5Acc=
X-Received: by 2002:a65:620a:: with SMTP id d10mr79714806pgv.8.1564780271226;
 Fri, 02 Aug 2019 14:11:11 -0700 (PDT)
Date:   Fri,  2 Aug 2019 14:11:05 -0700
Message-Id: <20190802211108.90739-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH bpf-next v2 0/3] selftests/bpf: switch test_progs back to stdio
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
 tools/testing/selftests/bpf/test_progs.c      | 140 +++++++++---------
 tools/testing/selftests/bpf/test_progs.h      |  14 +-
 10 files changed, 90 insertions(+), 98 deletions(-)

-- 
2.22.0.770.g0f2c4a37fd-goog
