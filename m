Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B708D29E08E
	for <lists+bpf@lfdr.de>; Thu, 29 Oct 2020 02:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbgJ2BXA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Oct 2020 21:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729909AbgJ1WEG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Oct 2020 18:04:06 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05E6C0613CF
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2020 15:04:05 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id r21so149295uaw.10
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2020 15:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=CdW40nYadQLqv6cb7mCz4sTrno0A47FG3PBCzX7v7CU=;
        b=c4yr+D92WuPp96ZSV0c8nFdLLLxszLAkvuvRgHEWAZ2GddAP3egj3rHisDXQiX7NHI
         qPJ9alhRarN04Ve4l6Wil24bkvBTZgbPNNuCY4g3oJ2qiCd1iz6DGJJMGkvuUxQhRCsu
         H3tXu414dZTiO5MxYW9KmyL1kps7isoOg5B1j65PLzMvW8XL/Fi0+xO6hJzMIbiTCuTV
         9wePPK8LxZXFRgF8I0DL/bJFVZzkqv3T2tbhaDMH39rzB9frwpeRkuNR4DoD5Znoce1V
         eg0z7QI8CVwfczmBIKE8Q/SF7FCwtkOYEe9fvYasC5LCvvGWZTOlLmQRzUU3oWqDwylJ
         tk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=CdW40nYadQLqv6cb7mCz4sTrno0A47FG3PBCzX7v7CU=;
        b=i6mwAYcF+XU0KVuUWnEg3RLPiouwAbHN1d0wMCuZBJ6Fe2IcUzQ49AzCo/2m42RIf5
         WjWRLo/Zz1cZs5F15y3mQ3Qyg+MHEYaWL7B0UkxzOEqKj/6XQD5VDT24hvEJjtyTbL1V
         Rr0xMTL7D/SSU8DZq/aupUBoDRr7zclYG4Bk0llW+9THDSQ5iTVhpY/yn5YXMCRZcqUX
         6gruPcJc+tLPQfRDk2L88GfIzhfNa0w0hvyDT7CAjifKz4MqauVLM7xG7Q6Qvg6uW4Hy
         nlkYsoKwKRB+xIJgg5mtAT5KOxSGGaBfg/k2TMHzxwEX/jSpQMd9FWQ1KA+7rWnarn9D
         JYeA==
X-Gm-Message-State: AOAM530MYt1wLgGtaLhoLhaI16cCakHFa6EsDe2F0pY79mRnCVez18QA
        1QLiFHxS5OWXhUGMdiiR9PJmPoVSiBbe7ozF5FoxVZi/QelGLQ==
X-Google-Smtp-Source: ABdhPJwDKbnCr0296sxTih51p120CRfNj370FV+iPvb3EokXerTJmvvNPYAOuuYM60PxKh626fAlR76VahUf5L4YbN0=
X-Received: by 2002:a25:da4e:: with SMTP id n75mr394457ybf.425.1603907275407;
 Wed, 28 Oct 2020 10:47:55 -0700 (PDT)
MIME-Version: 1.0
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 28 Oct 2020 10:47:44 -0700
Message-ID: <CAEf4BzZZAm_jFtPwmrxowVgmUQn-TJMpGBtVOtVepSsxe8S19w@mail.gmail.com>
Subject: libbpf v0.2 released
To:     bpf <bpf@vger.kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi all,

I've just cut v0.2 libbpf release on Github ([0]). I figured it would
be a good refresher on what went into libbpf for this release cycle. I
apologize if I missed something important in the summary, though. And
if you see any problem with this release, please report ASAP.

## New features/APIs:
  - full support for BPF-to-BPF function calls, no more need for
`__always_inline`;
  - support for multiple BPF programs with the same section name;
  - support for accessing in-kernel per-CPU variables;
  - support for type and enum value CO-RE relocations;
  - libbpf will auto-adjust CO-RE direct memory loads to adjust to
32-bit host architecture;
  - BPF_PROG_BIND_MAP support, .rodata will be bound automatically if
kernel supports it;
  - new APIs for programmatic generation of BTF;
  - support for big-endian and little-endian endianness in BTF;
  - perf buffer API additions allowing better integration with polling
libraries (`perf_buffer__buffer_cnt()`, `perf_buffer__buffer_fd()`,
`perf_buffer__consume_buffer()`);
  - `bpf_prog_test_run_opts()` API;
  - `bpf_program__attach_freplace()` API.

## New BPF program types supported:
  - sleepable fentry/fexit/fmod_ret/lsm BPF program.

## BPF-side changes:
  - libbpf will automatically fall back to `bpf_probe_read[_str]()` if
`bpf_probe_read_{kernel, user}[_str]()` are not supported on older
kernels, so it's always safe to use `bpf_probe_read_{kernel,
user}[_str]()` in your application and not worry about kernel version
compatibility;
  - `bpf_d_path()` helper;
  - `bpf_per_cpu_ptr()` and `bpf_this_cpu_ptr()` helpers for working
with per-CPU kernel variables;
  - `bpf_copy_from_user()` helper;
  - `bpf_load_hdr_opt()`, `bpf_store_hdr_opt()`,
`bpf_reserve_hdr_opt()` helpers;
  - `bpf_skb_cgroup_classid()` helper;
  - `bpf_redirect_neigh()` and `bpf_redirect_peer()` helpers;
  - `bpf_seq_printf_btf()` and `bpf_snprintf_btf()` helpers;
  - `__noinline` convenience macro;
  - `bpf_tail_call_static()` wrapper.

## Deprecations:
  - BPF program's "title" terminology is deprecated, please use
clearer "section_name". New API `bpf_program__section_name()` added;
  - `btf_ext__reloc_line_info()` and `btf_ext__reloc_func_info()`
(used by BCC) are deprecated.


  [0] https://github.com/libbpf/libbpf/releases/tag/v0.2


-- Andrii
