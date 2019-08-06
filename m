Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7C683823
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2019 19:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfHFRpc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Aug 2019 13:45:32 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:42824 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfHFRpc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Aug 2019 13:45:32 -0400
Received: by mail-qt1-f202.google.com with SMTP id e22so13926103qtp.9
        for <bpf@vger.kernel.org>; Tue, 06 Aug 2019 10:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fodY2dzKWC74TgSsGgftnxUr1VYkPfXdI8RTegnFuRk=;
        b=sJp6t5IXcqUT96dkjKtLTK1tR0k3v3HlH03pwxfrO9VwvFVXMi61PXgndw5gvuZ+eR
         0PTbTRxefBsk57MkTfNxGI+p7bQGcjWJ1bcTcTl+gAELcjaCTK9rqmRkWVJeX48YQ+Hh
         EJI4wllb7DvbpDwcVfuIfSHocMex5vwh+zPYUzonTYyAv3ngi14Qq2m/6JFmcxZcc0Qf
         oIOx7AcY7aq7gR5dmZ+5FDE1QILLqdRvp7TCdVMUXhq4atMii/3KK2oncnNRGnQuSnNJ
         Pd4Y8Cmh+fhnEk5vCmveTMR2WOfrGbmg638Znr/brYpLYjQZogsVYiOcm0m7Vv8rEhf8
         /CYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fodY2dzKWC74TgSsGgftnxUr1VYkPfXdI8RTegnFuRk=;
        b=s0sEKeAk0a3GNWjr+Yjip5YSxDTIiT5S4NrFvhhSXaWSZCFBmziKqlfN3spsQSO/jo
         AlCiWRKEYJ6eRqf2vsX6qRb/WQMowgBL9LHCZGcde1EcosdzS16sIULOraHhDJ0QkDo/
         Uo+ECL6f2bJU8TLMrvsxDgQ2g4yyqG2o4ok8iPOb18E6Y+OXFpRoEaZWf5yv3D/c0OGE
         BLAijJQlEt+mm5/8jiRCWbL12iTX0zotB2V8EyJWbIfJDfs3kZ1ntpdH5LVzNtqNI0tl
         ToAk7LImijm5vMDQ12gc/HOdy76zdlw02lt4Z+030Dqw2g5Uw4qejEOKp4EhBxGAY9m7
         8uHg==
X-Gm-Message-State: APjAAAV/KYsB8YIVd2ukYIcaP1IYHXLSgyqEBEkQx//PwdqlgC6qSG5s
        jJbDjp6ilNIDtoidmSzYtKUehTE=
X-Google-Smtp-Source: APXvYqzMFWmE9FM0OF+TrYwRTR3HyYzta9/3RP95AyiFEzJQu1m3vxJsxc7JsJ1xxdUKxOb+B2ghXJ8=
X-Received: by 2002:ac8:27db:: with SMTP id x27mr4387846qtx.4.1565113531481;
 Tue, 06 Aug 2019 10:45:31 -0700 (PDT)
Date:   Tue,  6 Aug 2019 10:45:26 -0700
Message-Id: <20190806174529.8341-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH bpf-next v5 0/3] selftests/bpf: switch test_progs back to stdio
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
 tools/testing/selftests/bpf/test_progs.h      |  13 +-
 10 files changed, 84 insertions(+), 94 deletions(-)

-- 
2.22.0.770.g0f2c4a37fd-goog
