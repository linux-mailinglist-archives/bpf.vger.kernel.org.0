Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B860E9012
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2019 20:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbfJ2Tj0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Oct 2019 15:39:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45170 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731791AbfJ2Tj0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Oct 2019 15:39:26 -0400
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B10DB81F25
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2019 19:39:25 +0000 (UTC)
Received: by mail-lf1-f69.google.com with SMTP id s30so2820044lfo.9
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2019 12:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=d/Pc7QsL4lvgbELw6g41imazIQiOAZ4tJtg9GFoS4vU=;
        b=GRpQBFaXxZkEfrS1YJNhgy/jo/ZuAaLmuFkkfg3xraySroNIvd9cHjtDB2F3P34wRb
         QB3tYqwBRKQNevLC+Msdt2zCehCRbjLqCL3Cn0SGDB0rGtPMEt8Wb7A7J1c4C/aTZt0u
         JY9yz0xMNaGTLeX/nDTpQ211/MxUb6a+Ch2ulwBadhY1wkBftPJj8/E+rxBLaRChJank
         6wPg+H5A1UDwdSOXI/0Do0Ld6JAUAM7B9H+z0UxaS1V8Sx5BEXzoVv/nneE2hyZovQlJ
         NQIzkpX/j+I/DALYVIIEh+TSx0UEQE5Z3N72PxDqrrPv0YSpJizDzVvyKHt+8quaejn6
         2Q9w==
X-Gm-Message-State: APjAAAUdBwtIcExqV9lkF7irLsxF71Yo9p+sqRPFj6bjbyfoo4RVOVfj
        QaWnpHKKv3ZVh2Lii7MZuZ+Mghm7yXESL41ODJy88naVqMf4dfmoIRg/mHdSQ/OOjPbWm6JJjN1
        nJrjs5Qp71UrK
X-Received: by 2002:a2e:858f:: with SMTP id b15mr3852618lji.68.1572377964248;
        Tue, 29 Oct 2019 12:39:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzKInxynTre5phfJrA0E+0XeD2BXlDFFCDVbTsvwIbPRmQoUQpPLwmKk2f0CGTBkvdKKwD0CA==
X-Received: by 2002:a2e:858f:: with SMTP id b15mr3852605lji.68.1572377964049;
        Tue, 29 Oct 2019 12:39:24 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id f1sm6416114ljk.77.2019.10.29.12.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 12:39:23 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 50DD21818B6; Tue, 29 Oct 2019 20:39:22 +0100 (CET)
Subject: [PATCH bpf-next v4 0/5] libbpf: Support automatic pinning of maps
 using 'pinning' BTF attribute
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Tue, 29 Oct 2019 20:39:22 +0100
Message-ID: <157237796219.169521.2129132883251452764.stgit@toke.dk>
User-Agent: StGit/0.20
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series adds support to libbpf for reading 'pinning' settings from BTF-based
map definitions. It introduces a new open option which can set the pinning path;
if no path is set, /sys/fs/bpf is used as the default. Callers can customise the
pinning between open and load by setting the pin path per map, and still get the
automatic reuse feature.

The semantics of the pinning is similar to the iproute2 "PIN_GLOBAL" setting,
and the eventual goal is to move the iproute2 implementation to be based on
libbpf and the functions introduced in this series.

Changelog:

v4:
  - Don't check key_type_id and value_type_id when checking for map reuse
    compatibility.
  - Move building of map->pin_path into init_user_btf_map()
  - Get rid of 'pinning' attribute in struct bpf_map
  - Make sure we also create parent directory on auto-pin (new patch 3).
  - Abort the selftest on error instead of attempting to continue.
  - Support unpinning all pinned maps with bpf_object__unpin_maps(obj, NULL)
  - Support pinning at map->pin_path with bpf_object__pin_maps(obj, NULL)
  - Make re-pinning a map at the same path a noop
  - Rename the open option to pin_root_path
  - Add a bunch more self-tests for pin_maps(NULL) and unpin_maps(NULL)
  - Fix a couple of smaller nits

v3:
  - Drop bpf_object__pin_maps_opts() and just use an open option to customise
    the pin path; also don't touch bpf_object__{un,}pin_maps()
  - Integrate pinning and reuse into bpf_object__create_maps() instead of having
    multiple loops though the map structure
  - Make errors in map reuse and pinning fatal to the load procedure
  - Add selftest to exercise pinning feature
  - Rebase series to latest bpf-next

v2:
  - Drop patch that adds mounting of bpffs
  - Only support a single value of the pinning attribute
  - Add patch to fixup error handling in reuse_fd()
  - Implement the full automatic pinning and map reuse logic on load

---

Toke Høiland-Jørgensen (5):
      libbpf: Fix error handling in bpf_map__reuse_fd()
      libbpf: Store map pin path and status in struct bpf_map
      libbpf: Move directory creation into _pin() functions
      libbpf: Add auto-pinning of maps when loading BPF objects
      selftests: Add tests for automatic map pinning


 tools/lib/bpf/bpf_helpers.h                      |    6 
 tools/lib/bpf/libbpf.c                           |  383 +++++++++++++++++-----
 tools/lib/bpf/libbpf.h                           |   21 +
 tools/lib/bpf/libbpf.map                         |    3 
 tools/testing/selftests/bpf/prog_tests/pinning.c |  157 +++++++++
 tools/testing/selftests/bpf/progs/test_pinning.c |   29 ++
 6 files changed, 518 insertions(+), 81 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/pinning.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_pinning.c

