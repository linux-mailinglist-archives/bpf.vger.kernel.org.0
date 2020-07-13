Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF0521E133
	for <lists+bpf@lfdr.de>; Mon, 13 Jul 2020 22:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgGMUM0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jul 2020 16:12:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21000 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726793AbgGMUM0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jul 2020 16:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594671144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1RwxXsjn0kMFv31yMlNBtF+bPKg72+QxQSNd3tyZBvg=;
        b=EcXfdTi7yWU3DSBqG4U0PZ/5V+d6ca6My6R0D/ZxMXyOWpUEKED3JioESmxusIlDgGbwxm
        eKEM2VQVCkbMs/J50e6DXuGBH9I+TmZzeA1i1/+/usNxNrtQhaZY+exdjIrn2nSCpqBygO
        589MHBTW4aQhDCELMA2UsAE+z7cDz0c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-NApRvmVRNQ6cXYTYHq2M7w-1; Mon, 13 Jul 2020 16:12:22 -0400
X-MC-Unique: NApRvmVRNQ6cXYTYHq2M7w-1
Received: by mail-wr1-f70.google.com with SMTP id f5so18593045wrv.22
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2020 13:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=1RwxXsjn0kMFv31yMlNBtF+bPKg72+QxQSNd3tyZBvg=;
        b=kmSaMmWgxuj594L0ljid6ryJoSFst8o5WKByxsc0H0YfCYHXeobU0klHoTmOQgzwA6
         doEtqrsOuyQ691BnxD6HuUY9VmST0X1E21LD0sGGCJjiWAR5dZ9PlbrOFeggV6+nC0QW
         NiRrIVIyB2H9E6GB9KN9bw7dYD743Oc3ftrRALD1gnEfTNRRlw0RWIcdYc5VzTLXIfFg
         szZ+FLp4AKIIF7w5TRAtK//VHRnti+ZsZn4k7vyF+VZDAg7JQqUyDCDcGGCzYP/OcXFm
         9U5jl3yZ2KZPM9Kufw1lijAdw6R2Cd4mg4BaEljftSLiEZ2LV6PfD/AgcbZKvNTej7gO
         YD7g==
X-Gm-Message-State: AOAM531UOfOjljCYxM8AQHHHt+qc4sqH7QPgE432Wy80qDgvyUW/vptq
        1oCYOF+ZtdptQiJ4NgaHOvDD8sd/anqxm8n6JByvefbQeLO57VrHJhmeD7iSmgPCjtNOQ3BPjzz
        lyjDCUWl7etwd
X-Received: by 2002:a05:600c:2907:: with SMTP id i7mr1045916wmd.40.1594671141348;
        Mon, 13 Jul 2020 13:12:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2ztAxwKgUe7vMX5wdsGVpmT5wGPKkXgBtHfkIyaFywOLDCLk7OsSNFSQNk3aeQaCdLS4+JA==
X-Received: by 2002:a05:600c:2907:: with SMTP id i7mr1045901wmd.40.1594671141112;
        Mon, 13 Jul 2020 13:12:21 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id u17sm24472248wrp.70.2020.07.13.13.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 13:12:20 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C76131804F0; Mon, 13 Jul 2020 22:12:19 +0200 (CEST)
Subject: [PATCH bpf-next 0/6] bpf: Support multi-attach for freplace programs
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Mon, 13 Jul 2020 22:12:19 +0200
Message-ID: <159467113970.370286.17656404860101110795.stgit@toke.dk>
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
 include/uapi/linux/bpf.h                      |   9 +-
 kernel/bpf/core.c                             |   1 -
 kernel/bpf/syscall.c                          |  96 +++++++++-
 kernel/bpf/trampoline.c                       |  36 +++-
 kernel/bpf/verifier.c                         | 169 +++++++++--------
 tools/include/uapi/linux/bpf.h                |   9 +-
 tools/lib/bpf/bpf.c                           |  33 +++-
 tools/lib/bpf/bpf.h                           |  12 ++
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 174 +++++++++++++++---
 .../bpf/progs/freplace_get_constant.c         |  15 ++
 13 files changed, 460 insertions(+), 127 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_get_constant.c

