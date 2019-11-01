Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A247CEC0CE
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2019 10:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbfKAJxA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Nov 2019 05:53:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727666AbfKAJxA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Nov 2019 05:53:00 -0400
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E23C34E8B8
        for <bpf@vger.kernel.org>; Fri,  1 Nov 2019 09:52:59 +0000 (UTC)
Received: by mail-lj1-f197.google.com with SMTP id v16so1642086ljh.11
        for <bpf@vger.kernel.org>; Fri, 01 Nov 2019 02:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=bUMEVvjsDg4NLEuvGgXAJxxFoYgda9ta8kXkBAkKZWc=;
        b=N8qu+S6AoivH+Voi5/g1XFPkARFiUyiYmRea3OV3KqymU3XA7jrrNQbDwTK77lKVgc
         ILRkHhiZ+vFZIMyu6fIGOcvRyixOVOeEFZRRrnVMQkN4JC3aN7TyJeGzctTBNY+sd5Hk
         DyuSK+yUGp0aaxuk03rDLBR0MultsPctYbGxZYqJdqMwnjKgI3GxK567nGXBZk5eVXXo
         l1RdGzzOrrh8V0B7lrbunz/x4//LZB5i6SmUrHmrMgFBpgKmUhHNrJYAZBNSMIU8RWxH
         b8DbZ9AewecGxOd4bcJllFI86pR7NhxpHT5UmTiymj0e2V5X23wlkrgE1LNCKRKFsmDO
         OnGw==
X-Gm-Message-State: APjAAAVkueP3FPtjY4e0l9snRdl6tOR2W+nKNbEtTc4lvRgzC7AXjjOV
        Np6bJAJnEG3I/GTHOv/a3YYrk4dA+ZGvbgStqqAn2xIMk6WMhqVgJL82KNuy/CPRA/MSFFYTfe1
        FR9qqwTZPP8MI
X-Received: by 2002:a2e:874e:: with SMTP id q14mr353429ljj.105.1572601978426;
        Fri, 01 Nov 2019 02:52:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwfauGwIPycGNE1ve3E4wbBZHxPFveS9jCM0be7CxN+DgF7VKG4SuTz8dcjlmErIBxSRX2Nuw==
X-Received: by 2002:a2e:874e:: with SMTP id q14mr353423ljj.105.1572601978248;
        Fri, 01 Nov 2019 02:52:58 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id 71sm2623960lfh.87.2019.11.01.02.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 02:52:57 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8CF1B1818B5; Fri,  1 Nov 2019 10:52:56 +0100 (CET)
Subject: [PATCH bpf-next v5 0/5] libbpf: Support automatic pinning of maps
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
Date:   Fri, 01 Nov 2019 10:52:56 +0100
Message-ID: <157260197645.335202.2393286837980792460.stgit@toke.dk>
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

v5:
  - Don't pin maps with pinning set, but with a value of LIBBPF_PIN_NONE
  - Add a few more selftests:
    - Should not pin map with pinning set, but value LIBBPF_PIN_NONE
    - Should fail to load a map with an invalid pinning value
    - Should fail to re-use maps with parameter mismatch
  - Alphabetise libbpf.map
  - Whitespace and typo fixes

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


 tools/lib/bpf/bpf_helpers.h                        |    6 
 tools/lib/bpf/libbpf.c                             |  385 ++++++++++++++++----
 tools/lib/bpf/libbpf.h                             |   21 +
 tools/lib/bpf/libbpf.map                           |    3 
 tools/testing/selftests/bpf/prog_tests/pinning.c   |  208 +++++++++++
 tools/testing/selftests/bpf/progs/test_pinning.c   |   31 ++
 .../selftests/bpf/progs/test_pinning_invalid.c     |   16 +
 7 files changed, 589 insertions(+), 81 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/pinning.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_pinning.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_pinning_invalid.c

