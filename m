Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 469BD837A2
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2019 19:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733054AbfHFRJE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Aug 2019 13:09:04 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:54948 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbfHFRJE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Aug 2019 13:09:04 -0400
Received: by mail-pf1-f202.google.com with SMTP id y66so56300429pfb.21
        for <bpf@vger.kernel.org>; Tue, 06 Aug 2019 10:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fodY2dzKWC74TgSsGgftnxUr1VYkPfXdI8RTegnFuRk=;
        b=r84moShAnq8ZODRu8Ppxe/AnbMkG6A8qz/leBCVE8PK3BELVVmv3/6ur3KoD3hhP9i
         N5iqxTEHdVEiHnkXgznyKOabDQij28vvebQB5XK6yKso1QIAXAvM3Jk3Nr15xBUjStSO
         1hVzIm3jL+TCjTDNczpzfqQinOqBLYBpb88Zbbf5sutplQ3EHCv056Tu0yo9M74LXk4/
         L0xNzWeyabdasFWz0fUxa++z5XNK1+rzU1L0JVA+iWYorwTfvichhe0y2BkGiqlqv4+F
         kv0ihungc7Snj/GCianP0/JxsF6YZl5DesFSLef3TYq34uxEdZvN27ParvTd7vO6BZNO
         MaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fodY2dzKWC74TgSsGgftnxUr1VYkPfXdI8RTegnFuRk=;
        b=WzJtXQAJ7kHRn9FZSIY2VOq0Kn+ekXTmVwJmIIKqilW52w5ff8dLUtyFDkzZbG2Kfm
         tUO8EJ3GUJuQCrIGmpXYR1oAADatQqZhZ0IPmFntiy7GIpPKbv+8IAPjahCve1jrRQNA
         7/MBERYPdhzMLYX9UinS1H48+Mpgrj95r4vcWT0xqZSVW5pcwEOWqP3p1dhTOb2wL/Q/
         DsVHZbL5XlP+mK4M2Xyngld+RwyEhpPdnTWd+vqbNkdV2WMP4aVpcs3rIJebm0nxrPQi
         43NPtHqeaguoYJNKsyNHtSa2tP2q+6/JflTPJ09O4xbCvRlN2D8Gc22fZD6qRfQMYV/o
         SyHg==
X-Gm-Message-State: APjAAAXlbl3eqzF44CcJxZ9X15T47BL6qeLKPpgiu3N9xSJs27rrmylt
        gc+4lTRnsv2ZPLaHJdAMi7Sr4YM=
X-Google-Smtp-Source: APXvYqzQmePQDeTVqOz77ZYRh3icQhQSGh7PuEYW6YpTXDzp5x3sKCoa0cM1bamIxFUrr5ks8khn8Us=
X-Received: by 2002:a65:5144:: with SMTP id g4mr3963306pgq.202.1565111343589;
 Tue, 06 Aug 2019 10:09:03 -0700 (PDT)
Date:   Tue,  6 Aug 2019 10:08:58 -0700
Message-Id: <20190806170901.142264-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH bpf-next v4 0/3] selftests/bpf: switch test_progs back to stdio
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
