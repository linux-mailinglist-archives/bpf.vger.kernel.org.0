Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A0E4B0026
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 23:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbiBIW21 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 17:28:27 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235838AbiBIW2Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 17:28:24 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1368DE019770
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 14:27:29 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id b5so3318220qtq.11
        for <bpf@vger.kernel.org>; Wed, 09 Feb 2022 14:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mgM1xpZnMLmgEbXlRNIKS05iOihELWC69IMRvSwJUVQ=;
        b=OY5b3WhJ3JK4Hxltm7LuGN/2ea+tcsSr8kP0PfqkAChZu6afG/CRdyTUEdfVk+nV47
         RKX7asgC4SVV3zQdVyanXsccG1eAjNdTa+PSOKUO7jr+vC0o+ZzSfIGAFxo1boq2fxV7
         h3PCbAPfRyxOyBX5e7obCuXgf8fe2r/bTaWs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mgM1xpZnMLmgEbXlRNIKS05iOihELWC69IMRvSwJUVQ=;
        b=v9+qeehLH5WFQlucpsHFuujY/e88FYEb4pKosnD2rUE7Z5ag0CtnEwL+VUF2XEoVGH
         LhVPNkVdZ/Ige5rUUJGdhMeNuRWKAEVUpjRjQ9Y51L7y1xLdlQp8Ok2ZfduEQ7btA6Rk
         w9nL6HIhFdXss8GLDG0oVKVaLZPKvXNxhmE6DvkWKkxRgBGl0Wx1/d0l5vVGfZ3BxMyj
         /VNbuAgulwkuMwHnCfJRcz61sT5UxVNt4C7y0vh3xYJtYCZeoR3/JtOhCdAvEX3Ee+0l
         34Hhtwbpjf1m6iyvZYR2jg2LK03lZ/FJGERHnYCdTY7kIiQksemW3TR6VXGhjFPoAA5a
         GDPQ==
X-Gm-Message-State: AOAM531m3bOr/pjmBMqbEYQGJofCmiSl09tUJw54s2dKI8+D4i3FmQN/
        l69H8Gnp/3r67fgIEXvzdRrCew==
X-Google-Smtp-Source: ABdhPJyp68FzyeT2405nz56xTJOLB21qZ7rlIt56kmb5cjbQzL7o5YqxEbDo5d34LyNc/De/9+cQHg==
X-Received: by 2002:ac8:5a0c:: with SMTP id n12mr2917995qta.150.1644445648174;
        Wed, 09 Feb 2022 14:27:28 -0800 (PST)
Received: from localhost.localdomain ([181.136.110.101])
        by smtp.gmail.com with ESMTPSA id h6sm9706287qtx.65.2022.02.09.14.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 14:27:27 -0800 (PST)
From:   =?UTF-8?q?Mauricio=20V=C3=A1squez?= <mauricio@kinvolk.io>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Rafael David Tinoco <rafaeldtinoco@gmail.com>,
        Lorenzo Fontana <lorenzo.fontana@elastic.co>,
        Leonardo Di Donato <leonardo.didonato@elastic.co>
Subject: [PATCH bpf-next v6 0/7] libbpf: Implement BTFGen
Date:   Wed,  9 Feb 2022 17:26:39 -0500
Message-Id: <20220209222646.348365-1-mauricio@kinvolk.io>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
v5 > v6:
- use BTF structure to store used member/types instead of hashmaps
- remove support for input/output folders
- remove bpf_core_{created,free}_cand_cache()
- reorganize commits to avoid having unused static functions
- remove usage of libbpf_get_error()
- fix some errno propagation issues
- do not record full types for type-based relocations
- add support for BTF_KIND_FUNC_PROTO
- implement tests based on core_reloc ones

v4 > v5:
- move some checks before invoking prog->obj->gen_loader
- use p_info() instead of printf()
- improve command output
- fix issue with record_relo_core()
- implement bash completion
- write man page
- implement some tests

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
v4: https://lore.kernel.org/bpf/20220112142709.102423-1-mauricio@kinvolk.io/
v5: https://lore.kernel.org/bpf/20220128223312.1253169-1-mauricio@kinvolk.io/

Mauricio Vásquez (6):
  libbpf: split bpf_core_apply_relo()
  libbpf: Expose bpf_core_{add,free}_cands() to bpftool
  bpftool: Add gen min_core_btf command
  bpftool: Implement minimize_btf() and relocations recording for BTFGen
  bpftool: Implement btfgen_get_btf()
  selftests/bpf: Test "bpftool gen min_core_btf"

Rafael David Tinoco (1):
  bpftool: gen min_core_btf explanation and examples

 kernel/bpf/btf.c                              |  13 +-
 .../bpf/bpftool/Documentation/bpftool-gen.rst |  93 +++
 tools/bpf/bpftool/Makefile                    |   8 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   6 +-
 tools/bpf/bpftool/gen.c                       | 624 +++++++++++++++++-
 tools/lib/bpf/libbpf.c                        |  88 +--
 tools/lib/bpf/libbpf_internal.h               |   9 +
 tools/lib/bpf/relo_core.c                     |  79 +--
 tools/lib/bpf/relo_core.h                     |  42 +-
 .../selftests/bpf/prog_tests/core_reloc.c     |  46 +-
 10 files changed, 896 insertions(+), 112 deletions(-)

-- 
2.25.1

