Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CB94943D5
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 00:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344198AbiASXZ4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 18:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343864AbiASXZ4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jan 2022 18:25:56 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72A4C061574;
        Wed, 19 Jan 2022 15:25:55 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id n137so4892808iod.4;
        Wed, 19 Jan 2022 15:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iAKE4TbwEnWW9P/l0sFHSeFQZ7mxDsF2QHnyWEWHbIg=;
        b=aPlS00iKM/gSiQvfV8T4cSxLWJ07savgunAxxpzFsgJx+bpBfkiCYPGm14Wr6GUoyJ
         vecn8le4JB5aNrXArDs7KC3uszhf3G5PTEj/lHmvWmufgf097sc50pGsAGhuYUvWj5Ut
         hWwzbZg5MTQM7fD2rkKjdulotq3ext64V5h0c9JC+ubLgInOzAfgf2+DEgozDCZLhMz9
         44NQBUWMuBu0GSn7QoMC+L5kCKpUB2RNRR3zoRtz6VCj/aI+xFrGMaHtjv0iuwn84PyF
         UXh+XHIT1r4KP5bc22d1UOOAOfJeUaiKcaFN8bcHSynV1OzSujCV/sqSDvHKJS4h3i1F
         r6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iAKE4TbwEnWW9P/l0sFHSeFQZ7mxDsF2QHnyWEWHbIg=;
        b=6cYE+i2zlBdqj/uAjdnk/ift1nFmaYYSWCDur9zAMz+LzabWfDDS/H6mZrckmvO53R
         4Po8th+1CZPLgXf87ZTUMpmfVjibHzOXSmw1OnPrP7XLGe3CGa+H6VlCQUO8IHrS8rj+
         WcWAUHLzpMm0vSm7/hvBn6nCqTYZNMI6q644Zrx7NKvTbm/sohFcA5lSV+3YUvKymcqE
         NC8BoqvZQHYgkHaha58Pra7/fXe1TZ2JVSEH2/kzvHkWaM5jLoO9wOvjZtdHsgR+avgt
         Ket/nb7vCg8RtUmRqYbghDO60BuEnAM0i2HUo7CXwvAKQQbZcAJvqMmLz9mx95vI1Ky1
         aueg==
X-Gm-Message-State: AOAM530XpQ713hHrQx+NK0YavRAqg7ftoJaxfSo8WOdhgwz2b3BwNr/u
        QVI9HGHHgInXZgirP3dfuiVc+SwJzxU4UshlskQ=
X-Google-Smtp-Source: ABdhPJwDz2v7AtFCg4FjrrZwRoV7MJ6pAhJrLj/RGxU5fLOqgoQQ4j88psM5aBXQ6gDG35TxnUYYnlq2PLIfX8UMCDs=
X-Received: by 2002:a02:bb8d:: with SMTP id g13mr15855346jan.103.1642634755101;
 Wed, 19 Jan 2022 15:25:55 -0800 (PST)
MIME-Version: 1.0
References: <20220119230636.1752684-1-christylee@fb.com> <20220119230636.1752684-2-christylee@fb.com>
In-Reply-To: <20220119230636.1752684-2-christylee@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 19 Jan 2022 15:25:43 -0800
Message-ID: <CAEf4BzZHqBUt6hWN8isjdteO3MSHDMAsQpwn+19pTQEX1w_y=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] perf: stop using deprecated
 bpf_load_program() API
To:     Christy Lee <christylee@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Christy Lee <christyc.y.lee@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Wang Nan <wangnan0@huawei.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 19, 2022 at 3:09 PM Christy Lee <christylee@fb.com> wrote:
>
> bpf_load_program() API is deprecated, remove perf's usage of the
> deprecated function. Add a __weak function declaration for libbpf
> version compatibility.
>
> Signed-off-by: Christy Lee <christylee@fb.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/perf/tests/bpf.c      | 14 ++++----------
>  tools/perf/util/bpf-event.c | 16 ++++++++++++++++
>  2 files changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
> index 573490530194..57b9591f7cbb 100644
> --- a/tools/perf/tests/bpf.c
> +++ b/tools/perf/tests/bpf.c
> @@ -281,8 +281,8 @@ static int __test__bpf(int idx)
>
>  static int check_env(void)
>  {
> +       LIBBPF_OPTS(bpf_prog_load_opts, opts);
>         int err;
> -       unsigned int kver_int;
>         char license[] = "GPL";
>
>         struct bpf_insn insns[] = {
> @@ -290,19 +290,13 @@ static int check_env(void)
>                 BPF_EXIT_INSN(),
>         };
>
> -       err = fetch_kernel_version(&kver_int, NULL, 0);
> +       err = fetch_kernel_version(&opts.kern_version, NULL, 0);
>         if (err) {
>                 pr_debug("Unable to get kernel version\n");
>                 return err;
>         }
> -
> -/* temporarily disable libbpf deprecation warnings */
> -#pragma GCC diagnostic push
> -#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> -       err = bpf_load_program(BPF_PROG_TYPE_KPROBE, insns,
> -                              ARRAY_SIZE(insns),
> -                              license, kver_int, NULL, 0);
> -#pragma GCC diagnostic pop
> +       err = bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, license, insns,
> +                           ARRAY_SIZE(insns), &opts);
>         if (err < 0) {
>                 pr_err("Missing basic BPF support, skip this test: %s\n",
>                        strerror(errno));
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index a517eaa51eb3..48872276c0b7 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -33,6 +33,22 @@ struct btf * __weak btf__load_from_kernel_by_id(__u32 id)
>         return err ? ERR_PTR(err) : btf;
>  }
>
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wunused-parameter"

perf is using __maybe_unused to mark unused args, it's cleaner than pragma

> +int __weak
> +bpf_prog_load(enum bpf_prog_type prog_type,
> +               const char *prog_name, const char *license,
> +               const struct bpf_insn *insns, size_t insn_cnt,
> +               const struct bpf_prog_load_opts *opts)
> +{
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> +       return bpf_load_program(prog_type, insns, insn_cnt, license,
> +                               opts->kern_version, opts->log_buf, opts->log_size);
> +#pragma GCC diagnostic pop
> +}
> +#pragma GCC diagnostic pop
> +
>  struct bpf_program * __weak
>  bpf_object__next_program(const struct bpf_object *obj, struct bpf_program *prev)
>  {
> --
> 2.30.2
>
