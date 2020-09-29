Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59B327B95F
	for <lists+bpf@lfdr.de>; Tue, 29 Sep 2020 03:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgI2B3H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Sep 2020 21:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgI2B3H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Sep 2020 21:29:07 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D05C061755
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2020 18:29:07 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id 133so2365962ybg.11
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2020 18:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KXDqDg32X48mO0qdFR04JbCSYmFlsoAW8udyijBvdH4=;
        b=ZjKI6FgCLQdK6a92agZT9Bc6FYs03SDm9SLR68HUR7LrZ5n+HABBMTwVSjIuNIOHDg
         +EB2S5IdWNJ1qlEZtxRK65c6MKRkAOCXVEubU+5uM08tb3v42WUhyRAjRfC6iQM84eg2
         B6r3vchZWcvevbw9KvPgrH9+Y5yB5HZwtzuvC+qoHZhLWs44CkKpIASMOcGJl+UsWCoo
         5OyoueCsJF8CLbTFwXmsPb/q5lNfuzUf1UzF5X3tLV+uCbeuu3pKr/9tLzc9E6AW990X
         kXQVvH6TEuu80GZOJp0l6GIqXBSm51R4JSe+jCz7hpkdWBaNYV0z3wjs1atrFLT6Eim9
         GbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KXDqDg32X48mO0qdFR04JbCSYmFlsoAW8udyijBvdH4=;
        b=mQQEz1jukKQUIsKogTVJpvHa3ixpDnERvDHnCo83Rpcd7WfMMLiHUv268eThVndk1J
         l9BFKqaqJd9Qae/fmtjsFe7nrHEJYeHFdKRghoInAWoHiu7NykFoiiZLvBE5Fe/kO//r
         dNYOctM6mg2V9aGQcXpKSH4Zth+n32rGmD3VuOaNxTXQaX8Tsq1nY2iKQfXFavBcmg20
         q9zZlSlip9rNUFBjfHVFJZADqBRa47NnGjQlGpS6Jf3H/dvuWPSYFv9SrnI+AOUpCSja
         GgoL/WR7da78HOBUWp8m0dnWiG42Rba7IC8Ou0bKF7XanGXZZhTMBeOuXL8HUcVSk2PL
         PGEQ==
X-Gm-Message-State: AOAM530RafWHSwFxHYIxwNTsnkIEJNagmqvM2QHt7wP4yGarhCX3IcXB
        vY0cqW3vcOS0nKWzb1of1M4S8Z0vKts/42iFaEyRym9HkK2zNw==
X-Google-Smtp-Source: ABdhPJzuJTESAba9BzmNQIjM8cPZiUJHeLr7NjjbKY+YrL6xHt/fuYCIyJd0rVCnyvWbQtbgVyaw+Hig93To0G7WauI=
X-Received: by 2002:a25:2687:: with SMTP id m129mr3054028ybm.425.1601342946185;
 Mon, 28 Sep 2020 18:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAMy7=ZVMPuXp6sOTPPtDYZbhan2PZDBUtsTTZ78PikxKMoBm9g@mail.gmail.com>
 <CAEf4Bza00DMqu09vPL+1-_1361cw5HoDyE3pY6hSDkD0M-PGjA@mail.gmail.com>
 <CAMy7=ZVCUJKFA5AbaE3DeyCNsWXffWwcYtA6d5t9R5kgnzPi2A@mail.gmail.com>
 <CAEf4BzaTXz6s2xfV0swvcpKFz=U+K1DzD0+DEHSZ+e4Yf0xxPA@mail.gmail.com> <CAMy7=ZUgWyZNVs6haL4MF2hZ24MuvfE_mEOXopgVZFGF_D8miA@mail.gmail.com>
In-Reply-To: <CAMy7=ZUgWyZNVs6haL4MF2hZ24MuvfE_mEOXopgVZFGF_D8miA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 28 Sep 2020 18:28:55 -0700
Message-ID: <CAEf4BzZ=w++q3VVG8Mox4KsRHfY4P4J7G0Pnse2erWS6=OX3UQ@mail.gmail.com>
Subject: Re: Help using libbpf with kernel 4.14
To:     Yaniv Agman <yanivagman@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 28, 2020 at 5:01 PM Yaniv Agman <yanivagman@gmail.com> wrote:
>
> Hi Andrii,
>
> I used BPF skeleton as you suggested, which did work with kernel 4.19
> but not with 4.14.
> I used the exact same program,  same environment, only changed the
> kernel version.
> The error message I get on 4.14:
>
> libbpf: elf: skipping unrecognized data section(5) .rodata.str1.1
> libbpf: failed to determine kprobe perf type: No such file or directory

This means that your kernel doesn't support attaching to
kprobe/tracepoint through perf_event subsystem. That's currently the
only way that libbpf supports for kprobe/tracapoint programs. It was
added in 4.17 kernel, which explains what is happening in your case.
It is still possible to attach to kprobe using legacy ways, but libbpf
doesn't provide that out of the box. We had a discussion a while ago
(about 1 year ago) about adding that to libbpf, but at that time we
didn't have a good testing infrastructure to validate such legacy
interfaces, plus it's a bit on the unsafe side as far as APIs go
(there is no auto-detachment and cleanup with how old kernels allow to
do kprobe/tracepoint). But we might reconsider, given it's not a first
time I see people get confused and blocked by this.

Anyways, here's how you can do it without waiting for libbpf to do
this out of the box:


int poke_kprobe_events(bool add, const char* name, bool ret) {
  char buf[256];
  int fd, err;

  fd = open("/sys/kernel/debug/tracing/kprobe_events", O_WRONLY | O_APPEND, 0);
  if (fd < 0) {
    err = -errno;
    fprintf(stderr, "failed to open kprobe_events file: %d\n", err);
    return err;
  }

  if (add)
    snprintf(buf, sizeof(buf), "%c:kprobes/%s %s", ret ? 'r' : 'p', name, name);
  else
    snprintf(buf, sizeof(buf), "-:kprobes/%s", name);

  err = write(fd, buf, strlen(buf));
  if (err < 0) {
    err = -errno;
    fprintf(
        stderr,
        "failed to %s kprobe '%s': %d\n",
        add ? "add" : "remove",
        buf,
        err);
  }
  close(fd);
  return err >= 0 ? 0 : err;
}

int add_kprobe_event(const char* func_name, bool is_kretprobe) {
  return poke_kprobe_events(true /*add*/, func_name, is_kretprobe);
}

int remove_kprobe_event(const char* func_name, bool is_kretprobe) {
  return poke_kprobe_events(false /*remove*/, func_name, is_kretprobe);
}

struct bpf_link* attach_kprobe_legacy(
    struct bpf_program* prog,
    const char* func_name,
    bool is_kretprobe) {
  char fname[256], buf[256];
  struct perf_event_attr attr;
  struct bpf_link* link;
  int fd = -1, err, id;
  FILE* f = NULL;

  err = add_kprobe_event(func_name, is_kretprobe);
  if (err) {
    fprintf(stderr, "failed to create kprobe event: %d\n", err);
    return NULL;
  }

  snprintf(
      fname,
      sizeof(fname),
      "/sys/kernel/debug/tracing/events/kprobes/%s/id",
      func_name);
  f = fopen(fname, "r");
  if (!f) {
    fprintf(stderr, "failed to open kprobe id file '%s': %d\n", fname, -errno);
    goto err_out;
  }

  if (fscanf(f, "%d\n", &id) != 1) {
    fprintf(stderr, "failed to read kprobe id from '%s': %d\n", fname, -errno);
    goto err_out;
  }

  fclose(f);
  f = NULL;

  memset(&attr, 0, sizeof(attr));
  attr.size = sizeof(attr);
  attr.config = id;
  attr.type = PERF_TYPE_TRACEPOINT;
  attr.sample_period = 1;
  attr.wakeup_events = 1;

  fd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
  if (fd < 0) {
    fprintf(
        stderr,
        "failed to create perf event for kprobe ID %d: %d\n",
        id,
        -errno);
    goto err_out;
  }

  link = bpf_program__attach_perf_event(prog, fd);
  err = libbpf_get_error(link);
  if (err) {
    fprintf(stderr, "failed to attach to perf event FD %d: %d\n", fd, err);
    goto err_out;
  }

  return link;

err_out:
  if (f)
    fclose(f);
  if (fd >= 0)
    close(fd);
  remove_kprobe_event(func_name, is_kretprobe);
  return NULL;
}


Then you'd use it in your application as:

...

  skel->links.handler = attach_kprobe_legacy(
      skel->progs.handler, "do_sys_open", false /* is_kretprobe */);
  if (!skel->links.handler) {
    fprintf(stderr, "Failed to attach kprobe using legacy debugfs API!\n");
    err = 1;
    goto out;
  }

  ... kprobe is attached here ...

out:
  /* first clean up step */
  bpf_link__destroy(skel->links.handler);
  /* this is second necessary clean up step */
  remove_kprobe_event("do_sys_open", false /* is_kretprobe */);


Let me know if that worked.

> libbpf: prog 'kprobe__do_sys_open': failed to create kprobe
> 'do_sys_open' perf event: No such file or directory
> libbpf: failed to auto-attach program 'kprobe__do_sys_open': -2
> failed to attach BPF programs: No such file or directory
>

[...]
