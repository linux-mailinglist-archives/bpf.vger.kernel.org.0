Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6884030EBAC
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 06:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbhBDFAR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 00:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhBDFAQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Feb 2021 00:00:16 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F4FC061573
        for <bpf@vger.kernel.org>; Wed,  3 Feb 2021 20:59:36 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id d6so1457451ilo.6
        for <bpf@vger.kernel.org>; Wed, 03 Feb 2021 20:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/lQmrDTgLz24XaXqLLB73+kpuF5pSC7Vbfo3CJZ8ORY=;
        b=mNuRpeL3rxPPma2Bp9e1L2PFXMmYxkqYz8pk/iAj2Folcp4n9GtYpmDTePC4/D9qts
         42XGSK0m+mpwzkE1lawe6PugdBYTZwyn0Z8XyzLNVjH9N3/jkXUQeJELHn0Xn5nt/h1Q
         jPeclSOyFGtqQ8aObuQ/TvsQmmh4GSgqQhSlGp03P+XvA/46uNSrkwfAIS1eEFR9pN9o
         uKTClM7kYU7T89j8kQ/sKrkPyQD/9nLmzrbigNUW3W6rOaQX7sHbOSBoXrkFRU++J6Ds
         o67FhiqgJjEi5y9+E/AzJhZrywtBVOArwYmvfUKyZnU2Umu/SsP83vmUJRlyhArP7tuL
         G5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/lQmrDTgLz24XaXqLLB73+kpuF5pSC7Vbfo3CJZ8ORY=;
        b=gguToeJzvKLSFqdMTm+LuZJ36Fc4JCZ6abDoRMGt0pQFg3HzIridMMWdbFHgCOqAep
         4ygCLqXTL9lGsupHXvHdzVMZaCPjtI+CRGPyRx5gVwV1+48K/3+Ze3eeOuuau3WdcL9F
         O1ahHY8S9K2FsuUwmsrzYbT1YyUdAJnH7k11mSfafpB99/sqqU0Ck05tKDiv5DoBVey9
         yPM/klq++5oot1huB8MdORJMeXoZHkXVFn0vwFtbpg7IKhwSTViHWvFIEIVYp3snggP6
         T063uI+JTwXJV/VCYQ4GyWBD6nkuRkC1A2uUgZYqYAAoVq/b3UYoTPUNsA7YEqMPFf7H
         p6rw==
X-Gm-Message-State: AOAM533Xb0unwOTneRSwtHenBp08Ol9QDp4QmF3iKtcuXY6pprjyuR+X
        wIuB1aYDyIECjBg/Rn61HslHi12quPzaVxrE+Yz7aH1k/X8=
X-Google-Smtp-Source: ABdhPJyoJ2U0zfT0UjSarifKiGrO23RWt+s4TP/GJBqsi3Ki2WD4AhoiAT+ZIar0fUcvltv5lRTqyOvemGE6AUB/pe4=
X-Received: by 2002:a05:6e02:1c8a:: with SMTP id w10mr5656533ill.127.1612414775830;
 Wed, 03 Feb 2021 20:59:35 -0800 (PST)
MIME-Version: 1.0
References: <20210203232331.2567162-1-kpsingh@kernel.org> <20210203232331.2567162-3-kpsingh@kernel.org>
In-Reply-To: <20210203232331.2567162-3-kpsingh@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 3 Feb 2021 20:59:25 -0800
Message-ID: <CAEf4Bzb4LzUPkA0SB3W2iri42=4Pv3CveWb+-a6rAJU772HvQA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf/selftests: Update the IMA test to use
 BPF ring buffer
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 3, 2021 at 3:23 PM KP Singh <kpsingh@kernel.org> wrote:
>
> Instead of using shared global variables between userspace and BPF, use
> the ring buffer to send the IMA hash on the BPF ring buffer. This helps
> in validating both IMA and the usage of the ringbuffer in sleepable
> programs.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/test_ima.c       | 23 ++++++++++---
>  tools/testing/selftests/bpf/progs/ima.c       | 33 ++++++++++++++-----
>  2 files changed, 43 insertions(+), 13 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_ima.c b/tools/testing/selftests/bpf/prog_tests/test_ima.c
> index 61fca681d524..23fb4c9e80d1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_ima.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_ima.c
> @@ -9,6 +9,7 @@
>  #include <unistd.h>
>  #include <sys/wait.h>
>  #include <test_progs.h>
> +#include <linux/ring_buffer.h>
>
>  #include "ima.skel.h"
>
> @@ -31,9 +32,18 @@ static int run_measured_process(const char *measured_dir, u32 *monitored_pid)
>         return -EINVAL;
>  }
>
> +static u64 ima_hash_from_bpf;
> +
> +static int process_sample(void *ctx, void *data, size_t len)
> +{
> +       ima_hash_from_bpf = *((u64 *)data);
> +       return 0;
> +}
> +
>  void test_test_ima(void)
>  {
>         char measured_dir_template[] = "/tmp/ima_measuredXXXXXX";
> +       struct ring_buffer *ringbuf;
>         const char *measured_dir;
>         char cmd[256];
>
> @@ -44,6 +54,11 @@ void test_test_ima(void)
>         if (CHECK(!skel, "skel_load", "skeleton failed\n"))
>                 goto close_prog;
>
> +       ringbuf = ring_buffer__new(bpf_map__fd(skel->maps.ringbuf),
> +                                  process_sample, NULL, NULL);
> +       if (CHECK(!ringbuf, "ringbuf_create", "failed to create ringbuf\n"))
> +               goto close_prog;

nit: could have used ASSERT_OK_PTR()

> +
>         err = ima__attach(skel);
>         if (CHECK(err, "attach", "attach failed: %d\n", err))
>                 goto close_prog;
> @@ -60,11 +75,9 @@ void test_test_ima(void)
>         if (CHECK(err, "run_measured_process", "err = %d\n", err))
>                 goto close_clean;
>
> -       CHECK(skel->data->ima_hash_ret < 0, "ima_hash_ret",
> -             "ima_hash_ret = %ld\n", skel->data->ima_hash_ret);
> -
> -       CHECK(skel->bss->ima_hash == 0, "ima_hash",
> -             "ima_hash = %lu\n", skel->bss->ima_hash);
> +       err = ring_buffer__poll(ringbuf, 1000);

nit: given data should definitely be available here, could use
ring_buffer__consume() instead and fail immediately if data is not
there

> +       ASSERT_EQ(err, 1, "num_samples_or_err");
> +       ASSERT_NEQ(ima_hash_from_bpf, 0, "ima_hash");
>
>  close_clean:
>         snprintf(cmd, sizeof(cmd), "./ima_setup.sh cleanup %s", measured_dir);
> diff --git a/tools/testing/selftests/bpf/progs/ima.c b/tools/testing/selftests/bpf/progs/ima.c
> index 86b21aff4bc5..dd0792204a21 100644
> --- a/tools/testing/selftests/bpf/progs/ima.c
> +++ b/tools/testing/selftests/bpf/progs/ima.c
> @@ -9,20 +9,37 @@
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
>
> -long ima_hash_ret = -1;
> -u64 ima_hash = 0;
>  u32 monitored_pid = 0;
>
> +struct {
> +       __uint(type, BPF_MAP_TYPE_RINGBUF);
> +       __uint(max_entries, 1 << 12);
> +} ringbuf SEC(".maps");
> +
>  char _license[] SEC("license") = "GPL";
>
>  SEC("lsm.s/bprm_committed_creds")
> -int BPF_PROG(ima, struct linux_binprm *bprm)
> +void BPF_PROG(ima, struct linux_binprm *bprm)
>  {
> -       u32 pid = bpf_get_current_pid_tgid() >> 32;
> +       u64 ima_hash = 0;
> +       u64 *sample;
> +       int ret;
> +       u32 pid;
> +
> +       pid = bpf_get_current_pid_tgid() >> 32;
> +       if (pid == monitored_pid) {
> +               ret = bpf_ima_inode_hash(bprm->file->f_inode, &ima_hash,
> +                                        sizeof(ima_hash));
> +               if (ret < 0 || ima_hash == 0)
> +                       return;
> +
> +               sample = bpf_ringbuf_reserve(&ringbuf, sizeof(u64), 0);
> +               if (!sample)
> +                       return;
>
> -       if (pid == monitored_pid)
> -               ima_hash_ret = bpf_ima_inode_hash(bprm->file->f_inode,
> -                                                 &ima_hash, sizeof(ima_hash));
> +               *sample = ima_hash;
> +               bpf_ringbuf_submit(sample, BPF_RB_FORCE_WAKEUP);

no need for BPF_RB_FORCE_WAKEUP, notification should happen
deterministically. And further, if you use ring_buffer__consume() you
won't even rely on notifications. Did you see any problems without
this?

> +       }
>
> -       return 0;
> +       return;
>  }
> --
> 2.30.0.365.g02bc693789-goog
>
