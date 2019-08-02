Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 439247FF59
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2019 19:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391662AbfHBRRN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Aug 2019 13:17:13 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:56704 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391630AbfHBRRN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Aug 2019 13:17:13 -0400
Received: by mail-yb1-f202.google.com with SMTP id c7so111990ybc.23
        for <bpf@vger.kernel.org>; Fri, 02 Aug 2019 10:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=J7AQaFXwu5WiKwAQvAEm/CM8Y6RcUQxdCxDS3Eq2sUw=;
        b=v/q12+Le9fyg0uq6BK05Y39eA0dWg1KO/5dRPk6UfAV7wqGJiyCZ9MWPelH9blhgch
         QDtblH9daSOxT5jO+rpP7GVcVFoegsWnx2LcW0E7YjA7ecw6z/svZ63XuROEXVFr1ZXm
         eTXBTzzaHH0PLqVsHjBeEebfyi5LW6Reg1zG7xAkCmOIssEmkVE7/JPUrsqxfXYWCG6H
         18ghk/hWSNm1ZtproyxszTn4bCjfks+dTVoF7gUNoB5Jnzemja4bwmWdX75V7LOuY/7f
         WnYbTEjVYHaohk6xL+li5tCfCv/cLMc1QIJFVsxI359+rPbKDOPboJ2rp4idrzmdATNj
         gRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=J7AQaFXwu5WiKwAQvAEm/CM8Y6RcUQxdCxDS3Eq2sUw=;
        b=skbaKa+D7a4j2OJWZk1PIR6c8Sr07awA6Eq/U3TJ7zOlQgdoJQHcftC4GfHASwnmDM
         OmjrYUPRXsqVdsCvHGrZy/TmdeGZpak5qGz8/fVpdnTM+tpji2794rZHF4ziA/GOFzlw
         fMpgfOT0ZAF+Omc3opUBTNsopITGGf7rS2QxqQN94fZW0njsiUqYkeKzSnGsMhfzATlr
         Zf8uo9Az0a0Npy6p5y9Y5+d68wOz6rJFpHFgN9bXYoYJ7fsa+WiCxqQ58BWRQ/flq+ER
         bmWl+iyI5nszRBmDQkrCD2aNC8OOFulJXhstvZBl+446x4Cy7aQ3TYKHsc8Azng6e2Ns
         5HRg==
X-Gm-Message-State: APjAAAV2N+fPTTs31HxCAVEfAJMzBk6JRvVANYvcsGB91CqQKMkSvLMn
        9QIBIP6vb+orw9vnTXEiGxnnFpg=
X-Google-Smtp-Source: APXvYqwlIvMtaIvnsp9MX7ClvMzS6jG9pV6QwcoPrxTdIr75wIzUgTmlA5jE8buoKuUaYKoy4mMKAgE=
X-Received: by 2002:a25:56c6:: with SMTP id k189mr88721912ybb.41.1564766232294;
 Fri, 02 Aug 2019 10:17:12 -0700 (PDT)
Date:   Fri,  2 Aug 2019 10:17:07 -0700
Message-Id: <20190802171710.11456-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH bpf-next 0/3] selftests/bpf: switch test_progs back to stdio
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
 tools/testing/selftests/bpf/test_progs.c      | 116 +++++++-----------
 tools/testing/selftests/bpf/test_progs.h      |  12 +-
 10 files changed, 68 insertions(+), 94 deletions(-)

-- 
2.22.0.770.g0f2c4a37fd-goog
