Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C88254306
	for <lists+bpf@lfdr.de>; Thu, 27 Aug 2020 12:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgH0KB6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Aug 2020 06:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgH0KB5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Aug 2020 06:01:57 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F4DC061264
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 03:01:56 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id s2so5215176ioo.2
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 03:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DmlgmExUh+M/e0ZmdGdxbVLOjH6bDwAGSLhzMUWq0tU=;
        b=pgAZboKEzbfahLARVXoTEGrLBzFUFLIBgxjdDchIwIC6MVLsppba99VgnSWt8beiFN
         UGj7Tip2IYeZ/wZLEqv/cIIoe09MGCyBYU4BXu5N1+WVSJxtmh6tXEpoXJsV3M6WOLEV
         yNBTyYepzVMWK8xcGkib4sRJdDyuUhReBWE8i2T0bXVM2U+BgBuZWBqPSv0hQZKiO7Ap
         Vm3zu0JTdJFpTWy3rHvdeHJ0YCwtgjONzw4ZVUDZug9z2q1rFIgXWSWTh1GKrreP5VIH
         KCKOFDOmS3TVN9klWmCTllc8j7pwiM3ouqKNB1sWM7IUEatsuT1WzUNaIREBO0Dc+QuP
         Meow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DmlgmExUh+M/e0ZmdGdxbVLOjH6bDwAGSLhzMUWq0tU=;
        b=Vp9Vvrskvz0jio/WpEUF0m4sKgQ2MBOnOHa228sTEr3tX7fvvU8OZ4+7z/dI16S1g1
         +Ddgit3zMdLGsiCiTTCLwwc6nQt2ezAEqTMh5f02lCBJ2HPf1uca9VjEFWTQpLNN5QO4
         E4z4dwnA9h53FI0ASm3zR6Ck10VVcLG+XwNa0dNqOTWg9EEul75B7dvk/s61NKYxdBqv
         u6NjeUZ5dd3YpZ9tatzpE768CF9qnGSvYX2hHWx8uwHaE+3kvvxD6640wmJTkQE/TPIp
         uCqf7krhw4eMo/mHrJtKanuB6cOPYOgh1cNbH8p6jqONBC5PgzT/QMYp7FYwAUSY2zgz
         bDzQ==
X-Gm-Message-State: AOAM533dBpp6H4CJJ7l1SHquB2txK/GKhwdm2KiKES/bYaynnB6agRhr
        lW3opVbrKFdqqB6US0kjEGWIIHkkzWMc86W97sTXBQ==
X-Google-Smtp-Source: ABdhPJxrmw46FXk4LUhtL/W8Evq/YzgGs3xUGnkq3VKWLlVBHIvz2V66TST2AgB/ks+PBylmAH8hdA5tOb+QT7oA0MU=
X-Received: by 2002:a05:6638:3f2:: with SMTP id s18mr6809296jaq.26.1598522516048;
 Thu, 27 Aug 2020 03:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAGeTCaWAs9gX_Y17gXJhSVvsbuJF2aD3Tfi9+79JmndF2ERmOw@mail.gmail.com>
 <e21c4dd9-9336-017f-752e-5b83704d86bf@fb.com>
In-Reply-To: <e21c4dd9-9336-017f-752e-5b83704d86bf@fb.com>
From:   Borna Cafuk <borna.cafuk@sartura.hr>
Date:   Thu, 27 Aug 2020 12:01:45 +0200
Message-ID: <CAGeTCaUtECKWZP2UpbeHNhrJgWRQkh0yfUimGnWVF4Q=K1iYkg@mail.gmail.com>
Subject: Re: perf event and data_sz
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Luka Perkov <luka.perkov@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Jakov Petrina <jakov.petrina@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 26, 2020 at 8:45 PM Yonghong Song <yhs@fb.com> wrote:
>
> On 8/26/20 7:11 AM, Borna Cafuk wrote:
> > Hi everyone,
> >
> > When examining BPF programs that use perf buffers, I have noticed that
> > the `data_sz` parameter in the sample callback has a different value than
> > the size passed to `bpf_perf_event_output`.
> >
> > Raw samples are padded in `perf_prepare_sample` so their size is a multiple of
> > `sizeof(u64)` (see [0]). The sample includes the size header, a `u32`.
> > The size stored in `raw->size` is then size of the sample, minus the 4 bytes for
> > the size header. This size, however, includes both the data and the padding.
> >
> > What I find confusing is that this size including the padding is eventually
> > passed as `data_sz` to the callback in the userspace, instead of
> > the size of the data that was passed as an argument to `bpf_perf_event_output`.
> >
> > Is this intended behaviour?
>
>  From the kernel source code, yes, this is expected behavior. What you
> described below matches what the kernel did. So raw->size = 68 is expected.

I understand why this size that is stored in `raw->size` is needed.
What I don't see is how the value is of any use in the callback.

>
> >
> > I have a use-case for getting only the size of the data in the
> > userspace, could this be done?
>
> In this case, since we know the kernel writes one record at a time,
> you check the size, it is 68 more than 62, you just read 62 bytes
> as your real data, ignore the rest as the padding. Does this work?

The `data_sz` parameter seems a little pointless, then. What is its purpose
in the callback if it doesn't accurately represent the size of the data?

>
> bcc callback passed the the buffer with raw->size to application.
> But applications are expected to know what the record layout is...

I'm afraid that wouldn't work for the use-case, our application should be able
to read the raw data without having to know the record layout. It has to be
generic, we handle interpreting the records elsewhere and at another time.

>
> >
> > To demonstrate, I have prepared a minimal example by modifying
> > BCC's filelife example. It uses a kprobe on vfs_unlink to print some sizes
> > every time a file is unlinked. The sizes are:
> >   * the `sizeof(struct event)` measured in the userspace program,
> >   * the `sizeof(struct event)` measured in the BPF program, and
> >   * the `data_sz` parameter.
> >
> > The first two are 62, as expected, but `data_sz` is 68.
> > The 62 bytes of the struct and the 4 bytes of the sample header make 66 bytes.
> > This is rounded up to the first multiple of 8, which is 72.
> > The 4 bytes for the size header are then subtracted,
> > and 68 is written as the data size.
> >
> > Any input is much appreciated,
> >
> > Best regards,
> > Borna Cafuk
> >
> >
> > [0] https://github.com/torvalds/linux/blob/6a9dc5fd6170d0a41c8a14eb19e63d94bea5705a/kernel/events/core.c#L7035
> >
> >
> > example.h
> > --------------------------------
> > #ifndef __EXAMPLE_H
> > #define __EXAMPLE_H
> >
> > struct __attribute__((__packed__)) event {
> >      __u16 size;
> >      char filler[60];
> > };
> >
> > #endif /* __EXAMPLE_H */
> >
> >
> > example.bpf.c
> > --------------------------------
> > #include "vmlinux.h"
> > #include <bpf/bpf_helpers.h>
> > #include <bpf/bpf_tracing.h>
> > #include "example.h"
> >
> > struct {
> >      __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> >      __uint(key_size, sizeof(u32));
> >      __uint(value_size, sizeof(u32));
> > } events SEC(".maps");
> >
> > SEC("kprobe/vfs_unlink")
> > int BPF_KPROBE(kprobe__vfs_unlink, struct inode *dir, struct dentry *dentry)
> > {
> >      struct event event = {};
> >      event.size = sizeof(struct event);
> >
> >      bpf_perf_event_output(ctx, &events, BPF_F_CURRENT_CPU,
> >                            &event, sizeof(struct event));
> >      return 0;
> > }
> >
> > char LICENSE[] SEC("license") = "GPL";
> >
> >
> > example.c
> > --------------------------------
> > #include <stdio.h>
> > #include <bpf/libbpf.h>
> > #include <sys/resource.h>
> > #include "example.h"
> > #include "example.skel.h"
> >
> > #define PERF_BUFFER_PAGES    16
> > #define PERF_POLL_TIMEOUT_MS    100
> >
> > void handle_event(void *ctx, int cpu, void *data, __u32 data_sz)
> > {
> >      const struct event *e = data;
> >
> >      printf("Userspace: %u | BPF: %zu | data_sz: %u \n",
> >             e->size, sizeof(struct event), data_sz);
> > }
> >
> > void handle_lost_events(void *ctx, int cpu, __u64 lost_cnt)
> > {
> >      fprintf(stderr, "lost %llu events on CPU #%d\n", lost_cnt, cpu);
> > }
> >
> > int main(int argc, char **argv)
> > {
> >      struct perf_buffer_opts pb_opts;
> >      struct perf_buffer *pb = NULL;
> >      struct example_bpf *obj;
> >      int err;
> >
> >      struct rlimit rlim_new = {
> >          .rlim_cur    = RLIM_INFINITY,
> >          .rlim_max    = RLIM_INFINITY,
> >      };
> >      err = setrlimit(RLIMIT_MEMLOCK, &rlim_new);
> >      if (err) {
> >          fprintf(stderr, "failed to increase rlimit: %d\n", err);
> >          return 1;
> >      }
> >
> >      obj = example_bpf__open();
> >      if (!obj) {
> >          fprintf(stderr, "failed to open and/or load BPF object\n");
> >          return 1;
> >      }
> >
> >      err = example_bpf__load(obj);
> >      if (err) {
> >          fprintf(stderr, "failed to load BPF object: %d\n", err);
> >          goto cleanup;
> >      }
> >
> >      err = example_bpf__attach(obj);
> >      if (err) {
> >          fprintf(stderr, "failed to attach BPF programs\n");
> >          goto cleanup;
> >      }
> >
> >      pb_opts.sample_cb = handle_event;
> >      pb_opts.lost_cb = handle_lost_events;
> >      pb = perf_buffer__new(bpf_map__fd(obj->maps.events), PERF_BUFFER_PAGES,
> >                            &pb_opts);
> >      err = libbpf_get_error(pb);
> >      if (err) {
> >          pb = NULL;
> >          fprintf(stderr, "failed to open perf buffer: %d\n", err);
> >          goto cleanup;
> >      }
> >
> >      while ((err = perf_buffer__poll(pb, PERF_POLL_TIMEOUT_MS)) >= 0)
> >          ;
> >      fprintf(stderr, "error polling perf buffer: %d\n", err);
> >
> >      cleanup:
> >      perf_buffer__free(pb);
> >      example_bpf__destroy(obj);
> >
> >      return err != 0;
> > }
> >
