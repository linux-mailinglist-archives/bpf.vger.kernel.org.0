Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A25C6F3CE4
	for <lists+bpf@lfdr.de>; Tue,  2 May 2023 07:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjEBFIh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 May 2023 01:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjEBFIg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 May 2023 01:08:36 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B839883
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 22:08:34 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so1338868a12.0
        for <bpf@vger.kernel.org>; Mon, 01 May 2023 22:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683004112; x=1685596112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VM7mGIT7omIP4beuxUfTOQ16y00U117MLVbMpgGQk4A=;
        b=UP9HVRoGnL4YxMS9g82SvV2Jxukss5Ti8QNztDzxrO3RJz1Tdxb6l33Y3ORXqEVa1o
         2p/lN62iyJNi7WoxOlPq6+RNkdt6rSZQMnP1LKaBDK8qaXuLijg1ZNm3mQ0CSC3rKtP6
         lUREC5P0CcKiXjddoMAcMdaWSDm7gzIc4t4M1qbB89J+/3mAXgeVFdCeCaH24WoWH91p
         WsaFc4nt+I9iUfFJHaJHQZ98DwEov9XoHqn/II1GGTDb828jEdHSsXspzAWmBfQ1nGfP
         GgHbH2ToCF8FiWJbCgaWhwkCe5KqeW4QjUtF6umq7UsqqWyB0HUB/fnoap0Ndc8BxWS2
         6FvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683004112; x=1685596112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VM7mGIT7omIP4beuxUfTOQ16y00U117MLVbMpgGQk4A=;
        b=B+wbLJ/aXHDi8POUsvm6rmXNxaRyNMP0lJaas9PbvkJUneNXyhGRLEDcO+25hr/gUK
         eFcwqmWYwKFMHXBvkXtbnH4zE2OTfGnnk58uA+D3k+hBa9Yb+FIHnlQ1AL8uzatlwdgN
         c3fTXafXlC5faIfTSkSMsentAiZIU846+HiCbtCPD4cYV0e3X602rjY7A330XVKi/fem
         v7MUNUt7YgdLxNpki8R/jtvdsCrzrtgssviWAa1i2BpQQMhUne79W28I+4oBZFoSeLyo
         oNAtyeInDmKsqmjHbclKlv49nWSy6kd7sbkenrgfWRain/qHS8bpbxYuYJ+YyVkwG/K1
         7pPA==
X-Gm-Message-State: AC+VfDzW+il62CTmAqkJGPbx9fxhzX5j8+6o6SnKJwO2syWfjkrDKFIS
        B9i90Ob2eKGnWLY04sORDmKiq7K1cZdgwItvyr/94KtL9LU=
X-Google-Smtp-Source: ACHHUZ5R8Xb3xNTKtkGKmQMqEzP8ZjXFBnORYdPVR1b8kXqOKKgAwjtq8urLvgNSWmq6sxbOnzc6EUVWg6mgKVz7l1I=
X-Received: by 2002:aa7:cccb:0:b0:504:8a2b:b3c7 with SMTP id
 y11-20020aa7cccb000000b005048a2bb3c7mr8543944edt.11.1683004112372; Mon, 01
 May 2023 22:08:32 -0700 (PDT)
MIME-Version: 1.0
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 1 May 2023 22:08:20 -0700
Message-ID: <CAEf4BzYJhzEDHarRGvidhPd-DRtu4VXxnQ=HhOG-LZjkbK-MwQ@mail.gmail.com>
Subject: [ANNOUNCEMENT] libbpf v1.2 release
To:     bpf <bpf@vger.kernel.org>
Cc:     Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Libbpf v1.2 has been released ([0])!

It's been about 4 months since libbpf v1.1 release, and it feels like
this is the right time to cut another one. This release is a healthy
mix of new features on both user space and BPF side of libbpf, coupled
with a bunch of bug fixes and improvements to existing APIs and
features. There are exciting improvements to libbpf documentation as
well, but more documentation contributions are always welcome!

A big thank you goes to all the contributors that are constantly
making libbpf a better BPF loader library!

Please find the summary of libbpf v1.2 changes below.


## User space-side features and APIs:

- completely overhauled ["Libbpf
overview"](https://libbpf.readthedocs.io/en/latest/libbpf_overview.html)
landing documentation page;
- support attaching to uprobes/uretprobes to functions defined in
Android APK archives;
- support for BPF link-based `struct_ops` programs:
  - `SEC(".struct_ops.link")` annotations;
  - `bpf_map__attach_struct_ops()` attach API;
  - `bpf_link__update_map()` link update API;
- support sleepable `SEC("struct_ops.s")` programs;
- improved thread-safety of libbpf print callbacks and `libbpf_set_print()`;
- improve handling and reporting of missing BPF kfuncs;
- `bpf_{btf,link,map,prog}_get_info_by_fd()` APIs;
- `bpf_xdp_query_opts()` supports fetching XDP/XSK supported features;
- `perf_buffer__new()` allows customizing notification/sampling period now;
- BPF verifier logging improvements:
  - pass-through BPF verifier log level and flags to kernel as is;
  - support `log_true_size` for getting required log buffer size to
fit BPF verifier log completely;
- allow precise control over kprobe/uprobe attach mode: legacy,
perf-based, link-based.


## BPF-side features and APIs;

- support for BPF open-coded iterators: `bpf_for()`, `bpf_repeat()`,
`bpf_for_each()`;
- `bpf_ksym_exists()` macro to check existence of ksyms/kfuncs and
kconfig values;
- `BPF_UPROBE()` and `BPF_URETPROBE()` macros;
- `BPF_KPROBE()` and `BPF_UPROBE()` macros allow fetching up to 8
passed in registers arguments, depending on architecture support;
- `BPF_KSYSCALL()` supports fetching all 6 syscall arguments now;
- LoongArch support in bpf_tracing.h;
- USDT support for 32-bit ARM architecture.


## Bug fixes

- fix legacy kprobe events names sanitization;
- fix clobbering errno in some cases;
- fix BPF map's `BPF_F_MMAPABLE` flag sanitization;
- fix BPF-side USDT support code on s390x architecture;
- fix `BPF_PROBE_READ{_STR}_INTO()` on s390x architecture;
- fix kernel version setting for Debian kernels;
- fix netlink protocol handling in some cases;
- improve robustness of attaching to legacy kprobes and uprobes;
- fix double-free during static linking empty ELF sections;
- a bunch of other small fixes here and there.


[0] https://github.com/libbpf/libbpf/releases/tag/v1.2.0
[1] Full Changelog: https://github.com/libbpf/libbpf/compare/v1.1.0...v1.2.0


-- Andrii
