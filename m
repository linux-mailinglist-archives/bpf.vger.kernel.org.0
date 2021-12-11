Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F481470F27
	for <lists+bpf@lfdr.de>; Sat, 11 Dec 2021 01:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhLKAHN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Dec 2021 19:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244143AbhLKAGr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Dec 2021 19:06:47 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92491C061714
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 16:03:10 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id v203so24913836ybe.6
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 16:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FmZU9HcBkKVoL9kFc+2qcuQNvuzot61+7QgseZq9qBE=;
        b=b1ZdRt4xge9mDTMtFbGV9DVOG3v8pGG3KW3qM3UrgZbr59OpOTbMXJhP6SztNJr/Gf
         xD/x7//WbD7nC1pdHaSF2zFZXP2tmwMFLpM4tJro277LE3FsVeG9KCtup383yUe/K9Bx
         dyYoQuLnEp0IerOx32ILXXAAbD9/b6Z+CknnhV6/6S6s/avABaRBXAqNTNcfF7M1KWXI
         y7GTeRpsIB/fP0XdjK/jKp8l6lVMLoOtMuTOrBhMO+SnZNrOMRSQo3qsC/FQCMYq7cL5
         egG+RLoF1gBSmjqpzh2+boiH4K4t97hP1xj4vH1StTdei7dpQ6reehLFt/66hWIwxYf2
         coQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FmZU9HcBkKVoL9kFc+2qcuQNvuzot61+7QgseZq9qBE=;
        b=m04Gj216+lbc4HZVNyJLibHMzX2wteE3T5QjWd3o0CyVsfpIrPud6DXAoEQ5r/6MZn
         1aBU8cUWTGi6BBQdP03HOMQZKupVMn0NSz1noy381KVzrq/hugUHm0IS3wU1RQnt9Xxx
         ml8p+Tg911HNSXiZjKAUrJx9i3Qi4aefvbmPnCpFt/O1jxZn+uYDissGufM9chIVVGfh
         V5BHU2Nz4xHBNBoQEqElgs88VhEHzfWSYkoC2yBotBd+XvfLPDZC3CtHI+rAG1XRkCXw
         EcgGppHZmQumfGvRnEInr3NLSqWGcPkWUg94MLHITfXKrauS+ZpJsLsiKmpN5T9Erjc4
         zFeA==
X-Gm-Message-State: AOAM53184NXVZ8vlJ6wCqXUfKq4OucbMyXX7WHGpxPA/9+1gv3x3WxS3
        V2KaDepIv5IQGr8QKnqKmo+xt5eLu0oQMHLa2diRgakIx0fkUQ==
X-Google-Smtp-Source: ABdhPJxfm0CiiKnseAQ9zIfU5Cq4MrTQJLNmquZG1IDhwe4t6yTtXdVOVki5n0wJyrbQ/Gk3PXN32k+bEQxhDio07q8=
X-Received: by 2002:a25:cf46:: with SMTP id f67mr17657750ybg.362.1639180989493;
 Fri, 10 Dec 2021 16:03:09 -0800 (PST)
MIME-Version: 1.0
References: <CAEf4BzZS02bE+qZfmOP-DqyRsLMxXjePs+DsT_i5wtO6J6eW+w@mail.gmail.com>
In-Reply-To: <CAEf4BzZS02bE+qZfmOP-DqyRsLMxXjePs+DsT_i5wtO6J6eW+w@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 10 Dec 2021 16:02:58 -0800
Message-ID: <CAEf4BzaXZWt778zYFqWtnEz+eog9JEAmJtXUUypLn2vh9z-eZA@mail.gmail.com>
Subject: Re: [ANNOUNCEMENT] libbpf v0.6 release
To:     bpf <bpf@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        grantseltzer <grantseltzer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 1, 2021 at 5:01 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> libbpf v0.6 was just released ([0]). This is a pretty big release with
> both new features and a whole bunch of API deprecations and clean ups.
> So please take a look and give it a try! And please report any issues
> and bugs we might have missed during preparation of this release.
>
> I'd like to also call out the documentation effort started by Grant
> Seltzer. Thank you! I encourage everyone to contribute to this effort
> so that the libbpf v1.0 release documentation is in a great shape.
>
> Thanks a lot to all the contributors sending fixes and new features
> and all the users asking and answering libbpf and BPF questions,
> adopting and testing libbpf, and overall improving the BPF ecosystem!
>
> ## Important updates towards Libbpf 1.0
>   - a first big batch of deprecated APIs; compiler will let you know
> or grep for "LIBBPF_DEPRECATED". Please also double-check
> https://github.com/libbpf/libbpf/wiki/Libbpf-1.0-migration-guide.
>   - documentation for a bunch of APIs added, available on
> https://libbpf.readthedocs.io/en/latest/api.html;
>   - libbpf version APIs added: compile-time
> `LIBBPF_MAJOR_VERSION`/`LIBBPF_MINOR_VERSION` and runtime
> `libbpf_major_version()`/`libbpf_minor_version()`/`libbpf_version_string()`;
>   - stricter logic for `SEC()` definition handling (opt-in until
> libbpf v1.0); see
> https://github.com/libbpf/libbpf/wiki/Libbpf:-the-road-to-v1.0#stricter-and-more-uniform-bpf-program-section-name-sec-handling
> for details.
>   - function name will be used when pinning if
> `LIBBPF_STRICT_SEC_NAME` strict mode flag is specified;
>
> ## New features and APIs:
>   - support custom `.rodata.*` and `.data.*` data sections;
>   - `bpf_program__attach_kprobe()` and `bpf_program__attach_uprobe()`
> supports older kernels now (don't forget about `bpf_link__destroy()`
> when you are done!);
>   - `BPF_MAP_TYPE_PROG_ARRAY` can be initialized statically with
> syntax similar to map-in-map initialization (see
> https://github.com/libbpf/libbpf/commit/472c0726e84d821186a315889c885b23895b155e
> for an example);
>   - libbpf-less "light" skeleton gained new capabilities and got a
> bunch of fixes;
>   - BTF support for `BTF_KIND_DECL_TAG` and `BTF_KIND_TYPE_TAG`;
>   - new `bpf_prog_load()` and `bpf_map_create()` APIs supersede a
> whole zoo of to-be-deprecated APIs;
>   - support for writable raw tracepoints (`SEC("raw_tp.w/...")`) added;
>   - `btf__add_btf()` API for appending entire contents of BTF to
> another BTF object;
>   - `bpf_program__insns()` and `bpf_program__insn_cnt()` to access
> underlying BPF assembly instructions; can be used for inspection or
> BPF program cloning.
>   - a bunch of older APIs (`perf_buffer__new()`, `btf__dedup()`,
> `btf_dump__new()`, etc) were modernized to use OPTS infrastructure.
>
> ## BPF-side APIs and features:
>   - unstable BPF helpers (kernel function calls) support for kernel modules;
>   - `bpf_trace_vprintk()` helper and corresponding `bpf_printk()`
> macro enhancements. Note, `bpf_printk()` will now attempt to use
> static global functions, so on very old kernels this might break
> existing programs. Please `#define BPF_NO_GLOBAL_DATA` before
> `#include <bpf/bpf_helpers.h>` if that's the case for you.
>   - `bpf_get_branch_snapshot()` helper;
>   - `bpf_skc_to_unix_sock()` helper;
>   - `bpf_find_vma()` helper;
>   - `SEC("tc")` added as a replacement for `SEC("classifier")`.
>
> ## Bug fixes and compatibility improvements:
>   - libbpf now guarantees that all FDs for BPF programs, maps, BTFs,
> and links are strictly greater than 0, which is important for some BPF
> UAPIs;
>   - no need to use `__uint(key_size, ...)` for special BPF maps (e.g.,
> `BPF_MAP_PERF_EVENT_ARRAY`). Libbpf automatically downgrades
> `__type(key, int)` into key_size, if a map doesn't support BTF types
> for keys and values;
>   - endianness fixes in `BPF_CORE_READ_BITFIELD_PROBED()` macro;
>   - `btf_dump__dump_type_data()` improvements for handling unaligned data;
>   - various fixes and improvements found though fuzzing and sanitizers.
>
> **Full Changelog**: https://github.com/libbpf/libbpf/compare/v0.5.0...v0.6.0
>
>   [0] https://github.com/libbpf/libbpf/releases/tag/v0.6.0
>
> -- Andrii

I've just cut libbpf v0.6.1 bugfix release, fixing two issues that
hopefully not many people will run into. Please see [1] for details.

  [1] https://github.com/libbpf/libbpf/releases/tag/v0.6.1
