Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5404C406E4C
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 17:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbhIJPiU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 11:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbhIJPiU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Sep 2021 11:38:20 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A1DC061574
        for <bpf@vger.kernel.org>; Fri, 10 Sep 2021 08:37:09 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x27so4866790lfu.5
        for <bpf@vger.kernel.org>; Fri, 10 Sep 2021 08:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Pc/PUaq87LiD3QwqMnF/CxyEYQRKuHl538WiaGGrXl4=;
        b=woDYOB4SbkUXQ22Zw/0yWGzi+vHagfTj8BKlMCDYizIMNHjn/ReJKswjuAr3MK3BOr
         s6fF7useUqXWpRC9nyu911LEQ3m9Kqf56VXtYBE01phn/KJjubjLixHFLrLIjWWFEYHY
         B/+PR7uybrQJqpwMZXwJljJOdQ9eu9FrMuXdtiUe18oTD/CiNIi7BgQtUmRZnYhC+gmR
         S4iorMUTlcrZM2h2z2zkHcmXT2kaY5NEYWMSxxVdHJ3/P4VQo5PiNNbFRYiM9Uud+gPo
         kem98jXX4lR/hrlkCnigRYwVAp+1IbG5ZLAtl5YBnRU66u/HXI2BjgAyTMkc8yDTbQ2W
         njCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Pc/PUaq87LiD3QwqMnF/CxyEYQRKuHl538WiaGGrXl4=;
        b=rufqawV9lGL5Jp6ZTC0N88f2kxUlCAQxDvbkA8ykDqUeZF9WmIlohrNjwrt+e24faD
         FsAXrqZuEhOTQMhUgc5RAdPtGDR+akvnkgg6HlOVVI59pxqBUVyufrRS2INydIwWENex
         xOLBgn3BUfXV+QJhXchJlnxYrrOP42wb3AcYdUagfIShLkw4GMB7BsQGZHnuU3SIOZrk
         iwLl8POmnEhNib1FA8pDdWHhbS62yXvKsDZhQA1awsW7a8TMCvYbozzp/xPVf688V9ap
         QwynD2SEoqxusfOnjzFxHPn8z2Ve8muiD+apRX2zFPdtict+NfeBOpCQVt1OCthMiQJ6
         odrA==
X-Gm-Message-State: AOAM533qYN2BvixRp0YNyx1MQgnOfiqF3u+Sh+oD4wz+SsCO94gQn4Si
        HHkbkklTJXZOybU6tvcPvfVvGfZzf3MvQIeW+5ToCcuryVuwXQ==
X-Google-Smtp-Source: ABdhPJzd1yn09DgmD3Qi7tddAvpQbEMjMVmV+OTXxOYe9k5vxhJqytrYu/r1qgjB+tPEwWDubGmKlEOn/Vmr9cpIEA0=
X-Received: by 2002:a05:6512:10cc:: with SMTP id k12mr4189588lfg.410.1631288227497;
 Fri, 10 Sep 2021 08:37:07 -0700 (PDT)
MIME-Version: 1.0
From:   Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Date:   Fri, 10 Sep 2021 17:36:56 +0200
Message-ID: <CAOjtDRUnjONzDgtov-ugXejL-TUGwLgyQ50Q1uJqFSH=1q0QUg@mail.gmail.com>
Subject: BPF_PROG_TYPE_CGROUP_SOCK bpf_sock ctx member direct access and
 BPF_CORE_READ return different values
To:     bpf <bpf@vger.kernel.org>
Cc:     =?UTF-8?B?RGFyaW8gQmFyYcSH?= <dario.barac@sartura.hr>,
        David Marcinkovic <david.marcinkovic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

while developing some cgroup socket programs, we have noticed that
some BPF_PROG_TYPE_CGROUP_SOCK programs return different values when
the bpf_sock context is accessed, depending on how they are accessed.
One example of the issue would be access to ctx->family in programs
that attach to BPF_CGROUP_INET6_POST_BIND and
BPF_CGROUP_INET4_POST_BIND. A direct ctx->family access returns the
correct value, while BPF_CORE_READ(ctx, family) returns random values.
The BPF C program and an example userspace C loader are attached
below, with an example trace_pipe output.

So far we have looked at the generated BPF byte code with llvm-objdump
and everything looked fine there, the main difference being in the way
the access is done, as expected. The BPF_CORE_READ macro expands into
a bpf_probe_read_kernel() call with arguments wrapped in
__builtin_preserve_access_index. bpf_probe_read_* helper calls are
supported for BPF_PROG_TYPE_CGROUP_SOCKS so that shouldn't be an
issue. Next, we looked at libbpf debug output, where everything looked
ok too. The part of the output with relocations is attached below.

We have tested this with various kernel versions, including 5.10, 5.11
and 5.13 on x86_64 and 5.11 on 32 bit ARM. The issue appeared on all
of those kernels and architectures.

At this point we're not sure what to look at next so any ideas on what
might cause the issues or suggestions on what to test next would be
greatly appreciated.

Regards,
Juraj Vijtiuk

example.bpf.c
----------------------------------------

#include "vmlinux.h"
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_core_read.h>

SEC("cgroup/post_bind4")
int cgroup_post_bind4_prog(struct bpf_sock *ctx)
{
    u32 family1 = 0;
    u32 family2 = 0;

    family1 = ctx->family;
    family2 = BPF_CORE_READ(ctx, family);
    bpf_printk("family1 = %u, family2 = %u\n", family1, family2);

    return 0;
}

char LICENSE[] SEC("license") = "GPL";

example.c
----------------------------------------
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/resource.h>
#include <argp.h>

#include <bpf/libbpf.h>
#include <bpf/bpf.h>

#include "example.skel.h"

void read_trace_pipe(void)
{
    int trace_fd;

    trace_fd = open("/sys/kernel/debug/tracing/trace_pipe", O_RDONLY, 0);
    if (trace_fd < 0)
        return;

    while (1) {
        static char buf[4096];
        ssize_t sz;

        sz = read(trace_fd, buf, sizeof(buf) - 1);
        if (sz > 0) {
            buf[sz] = 0;
            puts(buf);
        }
    }
}

int libbpf_print_fn(enum libbpf_print_level level,
const char *format, va_list args)
{
    return vfprintf(stderr, format, args);
}

int main(int argc, char **argv) {
    struct example_bpf *obj;
    int err = 0;
    struct rlimit rlim = {
        .rlim_cur = 512UL << 20,
        .rlim_max = 512UL << 20,
    };

    err = setrlimit(RLIMIT_MEMLOCK, &rlim);
    if (err) {
        fprintf(stderr, "failed to change rlimit\n");
        return 1;
    }

    libbpf_set_print(libbpf_print_fn);
    obj = example_bpf__open();
    if (!obj) {
        fprintf(stderr, "failed to open and/or load BPF object\n");
        return 1;
    }

    err = example_bpf__load(obj);
    if (err) {
        fprintf(stderr, "failed to load BPF object %d\n", err);
        goto cleanup;
    }

    const char *cgroup_path = "/sys/fs/cgroup";
    int cgroup_fd = open(cgroup_path, O_DIRECTORY | O_RDONLY);

    struct bpf_program *prog = obj->progs.cgroup_post_bind4_prog;
    obj->links.cgroup_post_bind4_prog =
bpf_program__attach_cgroup(prog, cgroup_fd);
    err = libbpf_get_error(obj->links.cgroup_post_bind4_prog);
    if (err) {
        fprintf(stderr, "failed to attach BPF program %d\n", err);
        goto cleanup;
    }

    read_trace_pipe();

cleanup:
    example_bpf__destroy(obj);
    return err != 0;
}

trace_pipe output
----------------------------------------
Chrome_IOThread-26477   [006] d..2 385580.114654: bpf_trace_printk:
family1 = 2, family2 = 1747691712
<...>-144100  [004] d..2 385594.936690: bpf_trace_printk: family1 = 2,
family2 = 0

libbpf relocation log
----------------------------------------
libbpf: loading kernel BTF '/sys/kernel/btf/vmlinux': 0
libbpf: sec 'cgroup/post_bind4': found 2 CO-RE relocations
libbpf: prog 'cgroup_post_bind4_prog': relo #0: kind <byte_off> (0),
spec is [2] struct bpf_sock.family (0:1 @ offset 4)
libbpf: CO-RE relocating [2] struct bpf_sock: found target candidate
[24518] struct bpf_sock
libbpf: prog 'cgroup_post_bind4_prog': relo #0: matching candidate #0
[24518] struct bpf_sock.family (0:1 @ offset 4)
libbpf: prog 'cgroup_post_bind4_prog': relo #0: patched insn #9
(ALU/ALU64) imm 4 -> 4
libbpf: prog 'cgroup_post_bind4_prog': relo #1: kind <byte_off> (0),
spec is [2] struct bpf_sock.family (0:1 @ offset 4)
libbpf: prog 'cgroup_post_bind4_prog': relo #1: matching candidate #0
[24518] struct bpf_sock.family (0:1 @ offset 4)
libbpf: prog 'cgroup_post_bind4_prog': relo #1: patched insn #12
(LDX/ST/STX) off 4 -> 4
