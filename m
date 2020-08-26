Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97AD42530F7
	for <lists+bpf@lfdr.de>; Wed, 26 Aug 2020 16:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgHZOL0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Aug 2020 10:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbgHZOLY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Aug 2020 10:11:24 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9338DC061574
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2020 07:11:24 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id u126so2199300iod.12
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2020 07:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=/nw3FcUEgr0lhOmD3rZKcfwZyZn+zattzOLSTXV7QNM=;
        b=wML9k+pEA9GNWPshK5NFdQ8H+dYbE7H+2LDBO5kTl0tLn3qZs5Bj84JaSkiT2olHHY
         8owRuQSLNPSRDOH1SR3Qwb3NauNusOXUGy9A3lTWQvR/R9Jj8eJcE7juq4CPICnvqfIb
         lnGstWuEKh42fPxkoMptmxsi+bvWeGXwTdeon2CF49b31rF8gLSvJ3cq3VQELmMVd+3X
         FwW4h4/nXxHq+x8EKsvIHhlHYt6Pe/8xOX8MEPuygwPZ9tb+4+Vadq61z5eSQ6GtDLdT
         hyInA0ZIraLEtd9UT94Nc2VT8JfO+yAZGNzwA0faMasj5UvwCBW8YDOYH/y5EDAkyOpA
         cp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/nw3FcUEgr0lhOmD3rZKcfwZyZn+zattzOLSTXV7QNM=;
        b=LtJF0QpKilBa/s6YEGyRXQKy6EH4XlZUBFcCLZxKnI4v6vON12tAcwcRqSbdv9CaB5
         kLFZJmhPjcjjF3n+8emzm/TEFHMZHUXhiipClLhtPMiuaRejARkF0pBCpcr8facznnis
         QLByANHqpIO/Tu82Lx9ZyLz5K1PMf1I0sdeB/rwmbgOoicbsBz8W/apzBlERoWYTApkM
         m2eR0o3AcVsKGCpHeHCqNDR1zzKBghjLcKEJh1z80oOJO+YpltoFIt98XweIUH8g4yWB
         qHJjgDJtps3bMCc272M7fN+n8EjroKjGoLZSeaRBfSaDD8Q+DzD9qwCNIOoOyO4Vy/tP
         ding==
X-Gm-Message-State: AOAM531NRsoYo3VVRDYqFCAvVYwk+uX8o8uf5RgPZAJWgnp+ucsEoUKw
        JY3qmJIAcBHgbKU5qfqKW9b0EvbqkT5eVMlFK9i0TvHDOrIYYPnF8fs=
X-Google-Smtp-Source: ABdhPJwDF5h21bQXJEWRjXvl8abIpRcfTFrsYppkWfRQbTV2oEipNcLS/uHMg+iyC9Sl3STZM6Dhz4TJJkvqFTSXw+E=
X-Received: by 2002:a05:6602:2c08:: with SMTP id w8mr13557613iov.38.1598451083542;
 Wed, 26 Aug 2020 07:11:23 -0700 (PDT)
MIME-Version: 1.0
From:   Borna Cafuk <borna.cafuk@sartura.hr>
Date:   Wed, 26 Aug 2020 16:11:12 +0200
Message-ID: <CAGeTCaWAs9gX_Y17gXJhSVvsbuJF2aD3Tfi9+79JmndF2ERmOw@mail.gmail.com>
Subject: perf event and data_sz
To:     bpf@vger.kernel.org
Cc:     Luka Perkov <luka.perkov@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Jakov Petrina <jakov.petrina@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi everyone,

When examining BPF programs that use perf buffers, I have noticed that
the `data_sz` parameter in the sample callback has a different value than
the size passed to `bpf_perf_event_output`.

Raw samples are padded in `perf_prepare_sample` so their size is a multiple of
`sizeof(u64)` (see [0]). The sample includes the size header, a `u32`.
The size stored in `raw->size` is then size of the sample, minus the 4 bytes for
the size header. This size, however, includes both the data and the padding.

What I find confusing is that this size including the padding is eventually
passed as `data_sz` to the callback in the userspace, instead of
the size of the data that was passed as an argument to `bpf_perf_event_output`.

Is this intended behaviour?

I have a use-case for getting only the size of the data in the
userspace, could this be done?

To demonstrate, I have prepared a minimal example by modifying
BCC's filelife example. It uses a kprobe on vfs_unlink to print some sizes
every time a file is unlinked. The sizes are:
 * the `sizeof(struct event)` measured in the userspace program,
 * the `sizeof(struct event)` measured in the BPF program, and
 * the `data_sz` parameter.

The first two are 62, as expected, but `data_sz` is 68.
The 62 bytes of the struct and the 4 bytes of the sample header make 66 bytes.
This is rounded up to the first multiple of 8, which is 72.
The 4 bytes for the size header are then subtracted,
and 68 is written as the data size.

Any input is much appreciated,

Best regards,
Borna Cafuk


[0] https://github.com/torvalds/linux/blob/6a9dc5fd6170d0a41c8a14eb19e63d94bea5705a/kernel/events/core.c#L7035


example.h
--------------------------------
#ifndef __EXAMPLE_H
#define __EXAMPLE_H

struct __attribute__((__packed__)) event {
    __u16 size;
    char filler[60];
};

#endif /* __EXAMPLE_H */


example.bpf.c
--------------------------------
#include "vmlinux.h"
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_tracing.h>
#include "example.h"

struct {
    __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
    __uint(key_size, sizeof(u32));
    __uint(value_size, sizeof(u32));
} events SEC(".maps");

SEC("kprobe/vfs_unlink")
int BPF_KPROBE(kprobe__vfs_unlink, struct inode *dir, struct dentry *dentry)
{
    struct event event = {};
    event.size = sizeof(struct event);

    bpf_perf_event_output(ctx, &events, BPF_F_CURRENT_CPU,
                          &event, sizeof(struct event));
    return 0;
}

char LICENSE[] SEC("license") = "GPL";


example.c
--------------------------------
#include <stdio.h>
#include <bpf/libbpf.h>
#include <sys/resource.h>
#include "example.h"
#include "example.skel.h"

#define PERF_BUFFER_PAGES    16
#define PERF_POLL_TIMEOUT_MS    100

void handle_event(void *ctx, int cpu, void *data, __u32 data_sz)
{
    const struct event *e = data;

    printf("Userspace: %u | BPF: %zu | data_sz: %u \n",
           e->size, sizeof(struct event), data_sz);
}

void handle_lost_events(void *ctx, int cpu, __u64 lost_cnt)
{
    fprintf(stderr, "lost %llu events on CPU #%d\n", lost_cnt, cpu);
}

int main(int argc, char **argv)
{
    struct perf_buffer_opts pb_opts;
    struct perf_buffer *pb = NULL;
    struct example_bpf *obj;
    int err;

    struct rlimit rlim_new = {
        .rlim_cur    = RLIM_INFINITY,
        .rlim_max    = RLIM_INFINITY,
    };
    err = setrlimit(RLIMIT_MEMLOCK, &rlim_new);
    if (err) {
        fprintf(stderr, "failed to increase rlimit: %d\n", err);
        return 1;
    }

    obj = example_bpf__open();
    if (!obj) {
        fprintf(stderr, "failed to open and/or load BPF object\n");
        return 1;
    }

    err = example_bpf__load(obj);
    if (err) {
        fprintf(stderr, "failed to load BPF object: %d\n", err);
        goto cleanup;
    }

    err = example_bpf__attach(obj);
    if (err) {
        fprintf(stderr, "failed to attach BPF programs\n");
        goto cleanup;
    }

    pb_opts.sample_cb = handle_event;
    pb_opts.lost_cb = handle_lost_events;
    pb = perf_buffer__new(bpf_map__fd(obj->maps.events), PERF_BUFFER_PAGES,
                          &pb_opts);
    err = libbpf_get_error(pb);
    if (err) {
        pb = NULL;
        fprintf(stderr, "failed to open perf buffer: %d\n", err);
        goto cleanup;
    }

    while ((err = perf_buffer__poll(pb, PERF_POLL_TIMEOUT_MS)) >= 0)
        ;
    fprintf(stderr, "error polling perf buffer: %d\n", err);

    cleanup:
    perf_buffer__free(pb);
    example_bpf__destroy(obj);

    return err != 0;
}
