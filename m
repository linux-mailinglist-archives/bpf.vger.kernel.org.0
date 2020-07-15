Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73CC1220DB1
	for <lists+bpf@lfdr.de>; Wed, 15 Jul 2020 15:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731482AbgGONJG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jul 2020 09:09:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30641 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731476AbgGONJG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Jul 2020 09:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594818545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KxvBS+x/c3n7X+53Golhdx75/yWdayPMXF8ZysL3UmE=;
        b=AEEBYttX92mQRuDszPB8S+LxkniDE+h3zLgAAvZ/ALgRHt1Pq/JqfzR2klua98IvkvIlb8
        liq2IV0iOjAOde9OKv3vnvcZfG7/Vr23CsX81hmqkhUwJY29XkuTVjqNpxUZeINDRHGCkl
        85qTwcktkux3xE7qBjO3oaEz0v6bacw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-TrE4ruw6PKSqA0PBQ0DY4w-1; Wed, 15 Jul 2020 09:09:02 -0400
X-MC-Unique: TrE4ruw6PKSqA0PBQ0DY4w-1
Received: by mail-qk1-f200.google.com with SMTP id v16so1418731qka.18
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2020 06:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=KxvBS+x/c3n7X+53Golhdx75/yWdayPMXF8ZysL3UmE=;
        b=PKSbuEBT2PsTDG0tPXPU97cC2YxfK42ruYLwpqWbzfKT/rtnePlBskLrYQm6eTR/yv
         TNJhxO2SEaIWsYfK6dMF8I3ib3oMlOf7Q60FmrFElk4EoFsiUjSDvDnfkkqWTtYpjBoH
         H7dKFiChW3Pfpnh5aZFHpfQGMZV6JDHB3DImzmeGRL8ZO+TZa5tWUxrXuK/REZeSIURA
         +mKQgvQDmg8d2SQvpKCVnb42IyT8doTP5I6Q/QYMMmRbrZxFZuB+HNNtZit+/Z4evB3M
         e2V1Hto4FBziPOPnps+VursvfShlG0sAb9cvtRvrP52xp689BBHMPG44iWjULZ8xIVfs
         MxPw==
X-Gm-Message-State: AOAM530Cv8jd/ryinavls8ggHLABzwfStvTDyHB/SVnLN+IonYvqZAqx
        IY99DfSEbqkbVxXQuphbvHECJZqmvCCMW6sWKbf+nTvbl6N2AoAtgC/+jjCfENQmsrcNoad57rv
        HpxUf51VVGQvy
X-Received: by 2002:ae9:e809:: with SMTP id a9mr9419625qkg.315.1594818541867;
        Wed, 15 Jul 2020 06:09:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/O4D7cXIrjdto3G7rXonIZsapZnjMx7Q5d91zuxkwI9PQExlMBvCP55gmTwYS7bHOch6p8w==
X-Received: by 2002:ae9:e809:: with SMTP id a9mr9419591qkg.315.1594818541518;
        Wed, 15 Jul 2020 06:09:01 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id u68sm2583882qkd.59.2020.07.15.06.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 06:09:00 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 52A6A1804F0; Wed, 15 Jul 2020 15:08:59 +0200 (CEST)
Subject: [PATCH bpf-next v2 0/6] bpf: Support multi-attach for freplace
 programs
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Wed, 15 Jul 2020 15:08:59 +0200
Message-ID: <159481853923.454654.12184603524310603480.stgit@toke.dk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series adds support attaching freplace BPF programs to multiple targets.
This is needed to support incremental attachment of multiple XDP programs using
the libxdp dispatcher model.

The first two patches are refactoring patches: The first one is a trivial change
to the logging in the verifier, split out to make the subsequent refactor easier
to read. Patch 2 refactors check_attach_btf_id() so that the checks on program
and target compatibility can be reused when attaching to a secondary location.

Patch 3 contains the change that actually allows attaching freplace programs in
multiple places. Patches 4-6 are the usual tools header updates, libbpf support
and selftest.

See the individual patches for details.

Changelog:

v2:
  - Drop the log arguments from bpf_raw_tracepoint_open
  - Fix kbot errors
  - Rebase to latest bpf-next

---

Toke Høiland-Jørgensen (6):
      bpf: change logging calls from verbose() to bpf_log() and use log pointer
      bpf: verifier: refactor check_attach_btf_id()
      bpf: support attaching freplace programs to multiple attach points
      tools: add new members to bpf_attr.raw_tracepoint in bpf.h
      libbpf: add support for supplying target to bpf_raw_tracepoint_open()
      selftests: add test for multiple attachments of freplace program


 include/linux/bpf.h                           |  23 ++-
 include/linux/bpf_verifier.h                  |   9 +
 include/uapi/linux/bpf.h                      |   6 +-
 kernel/bpf/core.c                             |   1 -
 kernel/bpf/syscall.c                          |  78 +++++++-
 kernel/bpf/trampoline.c                       |  36 +++-
 kernel/bpf/verifier.c                         | 171 ++++++++++--------
 tools/include/uapi/linux/bpf.h                |   6 +-
 tools/lib/bpf/bpf.c                           |  13 +-
 tools/lib/bpf/bpf.h                           |   9 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 164 ++++++++++++++---
 .../bpf/progs/freplace_get_constant.c         |  15 ++
 13 files changed, 404 insertions(+), 128 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_get_constant.c

