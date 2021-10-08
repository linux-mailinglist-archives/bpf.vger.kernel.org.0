Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068884260D9
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 02:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbhJHAFL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 20:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhJHAFJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Oct 2021 20:05:09 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835D4C061570
        for <bpf@vger.kernel.org>; Thu,  7 Oct 2021 17:03:15 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id h3so1390556pgb.7
        for <bpf@vger.kernel.org>; Thu, 07 Oct 2021 17:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u65WAkEy3rcOnzaKiih4umZsmZbVyHDnJ4ljDx7jVSo=;
        b=nkUG9XKJSMZksNgiNFbZsRPPFIgLjDXzbHhrufyamPsm5U7kUmBWAI9vJ6cDG9EZjF
         e5JimJTa1rz5jX+KeizaMj3bmAz0QwouhOJATWqTJqHbnKRIzyiJn5P2a5Wsrucw3T8Z
         eJXjgT48eep65Wicwqm0jmDmEgL+aoldUYLODp5PzqQxkU5AKweH/FPxmAEID/2A4rfH
         YcAmk9/94pgZR443lnx772QtcfU4qCeo7fvwSPl9FbgvqfxgfMWxFpxszp5DiMirkW0G
         3F1LSZkLeXQjK5GpJGzz4KrOU+Aul3m28gHSAEz+Hs9fnKs9OVLmfsk6dvk/V5p+lccU
         KcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u65WAkEy3rcOnzaKiih4umZsmZbVyHDnJ4ljDx7jVSo=;
        b=3MyNUPojZN0GPSYM83Q1BMdo8TjpBl7mM5QPhrXdF8hBsNSC10O84DV1bJgTpaGOD4
         AkrqUOPAxC0QdJ27O7KdLfPCcIyD4epy5WNlB45xFM3W5LtrU4Q1yj2lPRoCMu9d9jc8
         vnc7RR8/oTSN09B+Z0x9b9f4O/Y5JHEEzTa6bTcqYrap+HYjlwNg95CaMzHwu6Gl1iUi
         WavCwA7X4R8fL+rY4v1/Pefcbq4NB6/QFeJvRsOujpFYcz37OFlUUhkgFSefN/zafnEt
         2eK036om2feN3EEtxzKiQB4/S1G6CxuhA0ZRKKu0DPN8VeGWt0gScoMhJZ9XKx/a3KbB
         Rl3A==
X-Gm-Message-State: AOAM531RhPSilYdPkY5SKbXgTLzOcCdnCe9cEkNnBCILFnMTKjw/Ylis
        9VI27+slc0HY/DUnYcvsVkqN50KNqPc0cg==
X-Google-Smtp-Source: ABdhPJxH6Sf+BBTSutgCFCST4rJdUoLnx+23a+EUZEuc6z3qVFjThTMVfjHs2XfVVn3SvP6E4P1L9A==
X-Received: by 2002:a63:2d46:: with SMTP id t67mr2051432pgt.15.1633651394514;
        Thu, 07 Oct 2021 17:03:14 -0700 (PDT)
Received: from andriin-mbp.thefacebook.com ([2620:10d:c090:500::e050])
        by smtp.gmail.com with ESMTPSA id z13sm256495pfq.130.2021.10.07.17.03.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Oct 2021 17:03:14 -0700 (PDT)
From:   andrii.nakryiko@gmail.com
X-Google-Original-From: andrii@kernel.org
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com
Subject: [PATCH bpf-next 00/10] libbpf: support custom .rodata.*/.data.* sections
Date:   Thu,  7 Oct 2021 17:02:59 -0700
Message-Id: <20211008000309.43274-1-andrii@kernel.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andrii@kernel.org>

This patch set refactors internals of libbpf to enable support for multiple
custom .rodata.* and .data.* sections. Each such section is backed by its own
BPF_MAP_TYPE_ARRAY, memory-mappable just like .rodat/.data. This is not
extended to .bss because .bss is not a great name, it is generated by compiler
with name that reflects completely irrelevant historical implementation
details. Given that users have to annotate their variables with
SEC(".data.my_sec") explicitly, standardizing on .rodata. and .data. prefixes
makes more sense and keeps things simpler.

Additionally, this patch set makes it simpler to work with those special
internal maps by allowing to look them up by their full ELF section name.

Patch #1 is a preparatory patch that deprecated one libbpf API and moved
custom logic into libbpf.c where it's used. This code is later refactored with
the rest of libbpf.c logic to support multiple data section maps.

See individual patches for all the details.

One open question I have is whether we want to preserve this convoluted logic
of concatenating BPF object name with ELF section name for new custom data
sections/maps. Given their names are always going to be pretty long, it might
not make sense to drag this convention along and have kernel-side map name
differ from user-visible map name. See patch #7 for details on this.

One interesting possibility that is now open by these changes is that it's
possible to do:

    bpf_trace_printk("My fmt %s", sizeof("My fmt %s"), "blah");
    
and it will work as expected. I haven't updated libbpf-provided helpers in
bpf_helpers.h for snprintf, seq_printf, and printk, because using
`static const char ___fmt[] = fmt;` trick is still efficient and doesn't fill
out the buffer at runtime (no copying), but it also enforces that format
string is compile-time string literal:

    const char *s = NULL;

    bpf_printk("hi"); /* works */
    bpf_printk(s); /* compilation error */

By passing fmt directly to bpf_trace_printk() would actually compile
bpf_printk(s) above with no warnings and will not work at runtime, which is
worse user experience, IMO.

But there could be other interesting uses for non-trivial compile-time
constants nevertheless.

Andrii Nakryiko (10):
  libbpf: deprecate btf__finalize_data() and move it into libbpf.c
  libbpf: extract ELF processing state into separate struct
  libbpf: use Elf64-specific types explicitly for dealing with ELF
  libbpf: remove assumptions about uniqueness of .rodata/.data/.bss maps
  bpftool: support multiple .rodata/.data internal maps in skeleton
  bpftool: improve skeleton generation for data maps without DATASEC
    type
  libbpf: support multiple .rodata.* and .data.* BPF maps
  selftests/bpf: demonstrate use of custom .rodata/.data sections
  libbpf: simplify look up by name of internal maps
  selftests/bpf: switch to ".bss"/".rodata"/".data" lookups for internal
    maps

 tools/bpf/bpftool/gen.c                       | 158 ++--
 tools/lib/bpf/btf.c                           |  93 --
 tools/lib/bpf/btf.h                           |   1 +
 tools/lib/bpf/libbpf.c                        | 887 +++++++++++-------
 tools/lib/bpf/libbpf_internal.h               |   8 +-
 tools/lib/bpf/linker.c                        |   1 -
 .../selftests/bpf/prog_tests/core_autosize.c  |   2 +-
 .../selftests/bpf/prog_tests/core_reloc.c     |   2 +-
 .../selftests/bpf/prog_tests/global_data.c    |  11 +-
 .../bpf/prog_tests/global_data_init.c         |   2 +-
 .../selftests/bpf/prog_tests/kfree_skb.c      |   2 +-
 .../selftests/bpf/prog_tests/rdonly_maps.c    |   2 +-
 .../selftests/bpf/prog_tests/skeleton.c       |  25 +
 .../selftests/bpf/progs/test_skeleton.c       |  10 +
 14 files changed, 713 insertions(+), 491 deletions(-)

-- 
2.30.2

