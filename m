Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1646738FAF1
	for <lists+bpf@lfdr.de>; Tue, 25 May 2021 08:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhEYGcS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 May 2021 02:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbhEYGcS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 May 2021 02:32:18 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22008C061574
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 23:30:48 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id l16so8614634ybf.0
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 23:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=RNuF3B+Gz0TTWwJCaxiaqqtyHd/VPWjhqbN8roGbjtk=;
        b=nZ+rwX0wdwsNDH7XkyP/nS/3h22+olpkuudYnaz/7dqzInr0L5rqvx1oA5FzZWvGJx
         m215Dt5Wq2uIS5WIXrrCAbbHVZzB6+WnGRRdbdXQPJK53O0GODAt4+k4Al6ehv3Q8Zg9
         lEkzTjMgNWEdZ2Jj7Pe18fZw6rV6KHKYqhtxfoDqZBJc6KQPHInXqEhzxcM7VY+HrAjS
         af0nut8DEbp76G4CaE+CQacNATNX8+6hM3cIcDA1lVdqIYdM06Lko81hxiiScxlNyaGy
         rUH4XV/lYGetQDX8IKmR4OTrowE4b+WBD6MiPYgQ/JSsqhexlg7hCtKH5H8wuBoRFFTy
         Y/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=RNuF3B+Gz0TTWwJCaxiaqqtyHd/VPWjhqbN8roGbjtk=;
        b=lQk3GB89x/SX/Aybu9jRp8yPwXCgdO28btpt2Ny41eNrtR2ZfewWX6WxBJX+V4LOsT
         wANkd3KuiXuD//+t7O4f5SV+cJ5DKlKn7icwY8fGg/u9He0A2bWUxej4Jh5UTA5o0aRr
         ESD1g3KbNCiPZNgOn1DuxdUUe4dj2ZFuCDsDMsOzE3nVklFkkCN+T6C2w3Eb0ItgXi92
         X5Ew28gwav3Vm2+FhYY+kjBz5pAv37xoT+baQ61PTQ1emIhjCHc1zcWADcUBQ60JVIh1
         l/UWmuoPlyXdhnUA9AN8Dyc6OWuVdAOx2AgHjNFDfFRiImfS+t/SH4OraSFSSC1TdY6P
         I/RQ==
X-Gm-Message-State: AOAM5320S4fGcMTOjX4muYuOLhtwARBPWwegD6+Pc6R9Y8n7R+Obb5/j
        4wfKuW2vU4j0FTibXgF9K6yselYVAsclXSxjxKdyd4VALPM=
X-Google-Smtp-Source: ABdhPJy9K+DNGl74B3IVfaSiCa1OwsEfUkViQjME6FkfqrvXDfP2eprtHHsVWo1tXcTxkEeMmqSQmGpTSJn3AQDtXB8=
X-Received: by 2002:a25:3357:: with SMTP id z84mr40169714ybz.260.1621924247157;
 Mon, 24 May 2021 23:30:47 -0700 (PDT)
MIME-Version: 1.0
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 24 May 2021 23:30:36 -0700
Message-ID: <CAEf4BzZSLHhESr6aKPNf97UoAYFWvahQRpAC1dkRy5FUfj_wJA@mail.gmail.com>
Subject: libbpf v0.4 release
To:     bpf <bpf@vger.kernel.org>
Cc:     Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

libbpf v0.4 was just released ([0]). Short description of changes that
went into this release is provided below. Thanks a lot to 30
contributors that sent patches for new features, APIs, BPF helpers,
and, of course, bug fixes. And thank you to everyone who took part in
online discussions, asked questions, raised issues, made proposals,
and reviewed the code!

## New features/APIs:
  - BPF static linker APIs;
  - TC-BPF APIs;
  - subprogram address relocation support (e.e., for use with
`bpf_for_each_map_elem()`);
  - support for extern kernel functions (a.k.a. BPF unstable helpers);
  - ksym externs support for kernel modules;
  - `BTF_KIND_FLOAT` support;
  - various AF_XDP (`xsk.{c, h}`) improvements and fixes;
  - `btf__add_type()` API to copy/append BTF types generically;
  - `bpf_object__set_kernel_version()` setter;
  - `bpf_map__inner_map()` getter;
  - `__hidden` attribute for global sub-program forces static BPF
verifier verification;
  - static BPF maps and entry-point BPF programs are explicitly rejected.

## New BPF helpers:
  - `bpf_for_each_map_elem()` helper;
  - `bpf_snprintf()` helper and `BPF_SNPRINTF()` macro;
  - `bpf_check_mtu()` helper;
  - `NULL` and `KERNEL_VERSION` macros are provided by `bpf_helpers.h`;
  - user-space `BPF_CORE_READ_USER()` macro variants;
  - non-CO-RE `BPF_PROBE_READ()` and `BPF_PROBE_READ_USER()` macros.

## Bug fixes:
  - libbpf will ignore non-function pointer members in `struct_ops`;
  - Makefile fixes for install target;
  - use SOCK_CLOEXEC for netlink sockets;
  - btf_dump fixes for pointer to array of struct;
  - fixes for some of xxx_opts structs to work better with debug
compilation modes;
  - ringbuf APIs fixes and improvements for extreme cases of never
ending consumption of records;
  - `BPF_CORE_READ_BITFIELD()` macro fixes.


  [0] https://github.com/libbpf/libbpf/releases/tag/v0.4.0


-- Andrii
