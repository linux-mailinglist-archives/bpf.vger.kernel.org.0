Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5048F48C600
	for <lists+bpf@lfdr.de>; Wed, 12 Jan 2022 15:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354117AbiALO13 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jan 2022 09:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354119AbiALO1Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jan 2022 09:27:16 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDEEC06173F
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 06:27:15 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id 15so3018483qvp.12
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 06:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dGrDRx1rcy0ce53oUnzKiQwTF3mWEK6Bn8+R11Hu+ho=;
        b=bdAjmvGEXSMTN30DKKTfHN8Nb7y6WN/Ouo+tDRl8ZTplETVbxywZHZACkalKnNMgoU
         +zeaeMSXCDvTTgkgiuQgcX/D369HvuqdcsPWhCmJ9xZTVmncPw+HaSpfjtjmjNeFYmFV
         TMVPv1o2Ndahvslvjzz0iCKLLisTE+zm18KaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dGrDRx1rcy0ce53oUnzKiQwTF3mWEK6Bn8+R11Hu+ho=;
        b=0PFfT1T9Irkv6JHEmRt5T8lLFTJ0QFRafQwzsORFpB/dAAvIdkrOkvwWEdngEI8FAH
         s7p3gbkZxl4Juhh3SPdezF13BmXiJTXbwtFGPVnzcYPxg8hecw1EaXV3oowOisDpchip
         hto8H87Poi2WwtVqZiH3KfnxeIrOU1KclIjfpNA/NMwcAkRO4qHYVrD1E3GdzuXvUs/0
         ZwZIBRw4mTVD9LEN31riazYOK/EdxTX21mqdZIGXRPpb4VrmK1eHAhCwrW8N2wuaMUcF
         CdQem8Z/SkyzhulrX7VTnoWhfznqWpy7Yfi4zt+EvDTuCgonFyeucxOkeDYaokFdIiOI
         uUgQ==
X-Gm-Message-State: AOAM532g+6KIMi217lw/4VhdEEhORBVpSm2WH4IC0d19J0uiVsXCeKn3
        N34v6jgmfdUbWoMZEz1vzRf/YQ==
X-Google-Smtp-Source: ABdhPJzG+6VjubNwrVY4HfHMxhPzks1lZQaXysb/ixVt+dhEvHGY49NmgxRyEke0W670nQJybRZzfQ==
X-Received: by 2002:ad4:5d68:: with SMTP id fn8mr5806317qvb.76.1641997633925;
        Wed, 12 Jan 2022 06:27:13 -0800 (PST)
Received: from localhost.localdomain ([181.136.110.101])
        by smtp.gmail.com with ESMTPSA id h11sm8776690qko.59.2022.01.12.06.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 06:27:13 -0800 (PST)
From:   =?UTF-8?q?Mauricio=20V=C3=A1squez?= <mauricio@kinvolk.io>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Rafael David Tinoco <rafaeldtinoco@gmail.com>,
        Lorenzo Fontana <lorenzo.fontana@elastic.co>,
        Leonardo Di Donato <leonardo.didonato@elastic.co>
Subject: [PATCH bpf-next v4 0/8] libbpf: Implement BTFGen
Date:   Wed, 12 Jan 2022 09:27:01 -0500
Message-Id: <20220112142709.102423-1-mauricio@kinvolk.io>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

CO-RE requires to have BTF information describing the kernel types in
order to perform the relocations. This is usually provided by the kernel
itself when it's configured with CONFIG_DEBUG_INFO_BTF. However, this
configuration is not enabled in all the distributions and it's not
available on kernels before 5.12.

It's possible to use CO-RE in kernels without CONFIG_DEBUG_INFO_BTF
support by providing the BTF information from an external source.
BTFHub[0] contains BTF files to each released kernel not supporting BTF,
for the most popular distributions.

Providing this BTF file for a given kernel has some challenges:
1. Each BTF file is a few MBs big, then it's not possible to ship the
eBPF program with all the BTF files needed to run in different kernels.
(The BTF files will be in the order of GBs if you want to support a high
number of kernels)
2. Downloading the BTF file for the current kernel at runtime delays the
start of the program and it's not always possible to reach an external
host to download such a file.

Providing the BTF file with the information about all the data types of
the kernel for running an eBPF program is an overkill in many of the
cases. Usually the eBPF programs access only some kernel fields.

This series implements BTFGen support in bpftool. This idea was
discussed during the "Towards truly portable eBPF"[1] presentation at
Linux Plumbers 2021.

There is a good example[2] on how to use BTFGen and BTFHub together
to generate multiple BTF files, to each existing/supported kernel,
tailored to one application. For example: a complex bpf object might
support nearly 400 kernels by having BTF files summing only 1.5 MB.

[0]: https://github.com/aquasecurity/btfhub/
[1]: https://www.youtube.com/watch?v=igJLKyP1lFk&t=2418s
[2]: https://github.com/aquasecurity/btfhub/tree/main/tools

Changelog:
v3 > v4:
- parse BTF and BTF.ext sections in bpftool and use
  bpf_core_calc_relo_insn() directly
- expose less internal details from libbpf to bpftool
- implement support for enum-based relocations
- split commits in a more granular way

v2 > v3:
- expose internal libbpf APIs to bpftool instead
- implement btfgen in bpftool
- drop btf__raw_data() from libbpf

v1 > v2:
- introduce bpf_object__prepare() and ‘record_core_relos’ to expose
  CO-RE relocations instead of bpf_object__reloc_info_gen()
- rename btf__save_to_file() to btf__raw_data()

v1: https://lore.kernel.org/bpf/20211027203727.208847-1-mauricio@kinvolk.io/
v2: https://lore.kernel.org/bpf/20211116164208.164245-1-mauricio@kinvolk.io/
v3: https://lore.kernel.org/bpf/20211217185654.311609-1-mauricio@kinvolk.io/

Mauricio Vásquez (8):
  libbpf: split bpf_core_apply_relo()
  libbpf: Implement changes needed for BTFGen in bpftool
  bpftool: Add gen btf command
  bpftool: Implement btf_save_raw()
  bpftool: Add struct definitions and helpers for BTFGen
  bpftool: Implement btfgen()
  bpftool: Implement relocations recording for BTFGen
  bpftool: Implement btfgen_get_btf()

 kernel/bpf/btf.c                |  13 +-
 tools/bpf/bpftool/gen.c         | 849 ++++++++++++++++++++++++++++++++
 tools/lib/bpf/Makefile          |   2 +-
 tools/lib/bpf/libbpf.c          | 127 +++--
 tools/lib/bpf/libbpf_internal.h |  12 +
 tools/lib/bpf/relo_core.c       |  79 +--
 tools/lib/bpf/relo_core.h       |  42 +-
 7 files changed, 1012 insertions(+), 112 deletions(-)

-- 
2.25.1

