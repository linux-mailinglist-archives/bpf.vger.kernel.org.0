Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C212A4A54A1
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 02:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbiBABYT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 Jan 2022 20:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiBABYT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Jan 2022 20:24:19 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B8AC061714
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 17:24:19 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id p63so18446364iod.11
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 17:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GPzDRFhI8dEV1K62qS8fdrcCWOLIUlLzR+DRf7FGUCs=;
        b=K3BVzvxeCUB5IuI6e+kx0syWnyV8Lv/iO8FGPTKrJA0zkmgK1rQ/b/D3jxdLzd2o4h
         MCvBZeDbUGwto/o6lhrou9rrBCh4HnE+LDMJfeC37YBI3nx4LMzRPoQKFGZ/qe/M127q
         ZS7vQszD1qxRvpkW5OxECv7zDum+/AtQmSg9N5GL1L9B891ab1KRg+Eib2Q3NTt9phoI
         jatT9CDMIsU3m03C66Z5OK4lSrsoUTh8P+wK304HM6LgB118m7HR0nB/q0MYy+93xhl+
         NqTdtVt757BqGrcwqebHXCguG5/bckh7IXhVQF75Y3alDVouMDgdXnCIBIormfosmCas
         4psA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GPzDRFhI8dEV1K62qS8fdrcCWOLIUlLzR+DRf7FGUCs=;
        b=c9gFxy3D38N/KNPTukbM9Zjs7U5Dt9pkIBR4etAi35OjeJlwHsKEddGHjBH5RlLjf2
         Q8i3oR21mv11hi0PHOY/BmlDWNvdCH8Vuhz7sWQVEkDAymZr2Loz5BoyHbjqj+8T8JQl
         MRUfADazSrv5+nIzUEqMTsoi63uWZQtnBWe6YJV1F/opNepva8ziMb7qph9dmInvBxmj
         xPI3mQIV6wz8xdMXetdYOG314gyEE0Z3ZquyUmH21ga0VeyfKzDFyfKgRLPPglbtrUIx
         408jIs5rPDdQ80yNfN5xSQ5aTrEOF62H0S1fOUiUXpUMClWdeOUDrP/F6avC6gJ/kT8Y
         rDPw==
X-Gm-Message-State: AOAM530SiNzphTMonft0bKGnl9KkLMRijQiCD+pS7FJLnduk4CQNbrOg
        Z/vt2lDYLbUqZEWOKoOaOrQud3lo2vjrXWg5GQqy36ebg5o=
X-Google-Smtp-Source: ABdhPJwZofauqkWbeUkYd5Uu/clCkI0Z/a5xSfFUnh1oRDBCL2Mu9Kzy5XoPhdvGQhlBSmOxN1Ni1oagS1IhC4x/kZk=
X-Received: by 2002:a05:6638:304d:: with SMTP id u13mr10045490jak.103.1643678658406;
 Mon, 31 Jan 2022 17:24:18 -0800 (PST)
MIME-Version: 1.0
References: <20220128012319.2494472-1-delyank@fb.com> <20220128012319.2494472-2-delyank@fb.com>
In-Reply-To: <20220128012319.2494472-2-delyank@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 31 Jan 2022 17:24:07 -0800
Message-ID: <CAEf4Bzbg50Ki=ii-Y0AqzpyQnAUEc5qGLx7LW5yGebDeb540BA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] selftests: bpf: migrate from bpf_prog_test_run
To:     Delyan Kratunov <delyank@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 27, 2022 at 5:26 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> Signed-off-by: Delyan Kratunov <delyank@fb.com>
> ---
>  .../selftests/bpf/prog_tests/atomics.c        |  86 +++---
>  .../testing/selftests/bpf/prog_tests/bpf_nf.c |  10 +-
>  .../selftests/bpf/prog_tests/fentry_fexit.c   |  33 ++-
>  .../selftests/bpf/prog_tests/fentry_test.c    |   9 +-
>  .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  |  33 ++-
>  .../selftests/bpf/prog_tests/fexit_stress.c   |  26 +-
>  .../selftests/bpf/prog_tests/fexit_test.c     |   9 +-
>  .../prog_tests/flow_dissector_load_bytes.c    |  27 +-
>  .../selftests/bpf/prog_tests/for_each.c       |  32 ++-
>  .../bpf/prog_tests/get_func_args_test.c       |  14 +-
>  .../bpf/prog_tests/get_func_ip_test.c         |  12 +-
>  .../selftests/bpf/prog_tests/global_data.c    |  25 +-
>  .../bpf/prog_tests/global_func_args.c         |  13 +-
>  .../selftests/bpf/prog_tests/kfunc_call.c     |  46 ++--
>  .../selftests/bpf/prog_tests/ksyms_module.c   |  23 +-
>  .../selftests/bpf/prog_tests/l4lb_all.c       |  35 ++-
>  .../selftests/bpf/prog_tests/map_lock.c       |  15 +-
>  .../selftests/bpf/prog_tests/map_ptr.c        |  18 +-
>  .../selftests/bpf/prog_tests/modify_return.c  |  38 +--
>  .../selftests/bpf/prog_tests/pkt_access.c     |  27 +-
>  .../selftests/bpf/prog_tests/pkt_md_access.c  |  15 +-
>  .../bpf/prog_tests/queue_stack_map.c          |  43 +--
>  .../bpf/prog_tests/raw_tp_writable_test_run.c |  16 +-
>  .../selftests/bpf/prog_tests/signal_pending.c |  24 +-
>  .../selftests/bpf/prog_tests/spinlock.c       |  15 +-
>  .../selftests/bpf/prog_tests/tailcalls.c      | 245 ++++++++++--------
>  .../bpf/prog_tests/test_skb_pkt_end.c         |  15 +-
>  .../testing/selftests/bpf/prog_tests/timer.c  |   9 +-
>  .../selftests/bpf/prog_tests/timer_mim.c      |   9 +-
>  .../selftests/bpf/prog_tests/trace_ext.c      |  28 +-
>  tools/testing/selftests/bpf/prog_tests/xdp.c  |  35 ++-
>  .../bpf/prog_tests/xdp_adjust_frags.c         |  34 ++-
>  .../bpf/prog_tests/xdp_adjust_tail.c          | 114 +++++---
>  .../selftests/bpf/prog_tests/xdp_bpf2bpf.c    |  16 +-
>  .../selftests/bpf/prog_tests/xdp_noinline.c   |  45 ++--
>  .../selftests/bpf/prog_tests/xdp_perf.c       |  19 +-
>  tools/testing/selftests/bpf/test_lru_map.c    |  11 +-
>  tools/testing/selftests/bpf/test_progs.h      |   2 +
>  tools/testing/selftests/bpf/test_verifier.c   |  16 +-
>  39 files changed, 727 insertions(+), 515 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/atomics.c b/tools/testing/selftests/bpf/prog_tests/atomics.c
> index 86b7d5d84eec..12ecb3ae5c28 100644
> --- a/tools/testing/selftests/bpf/prog_tests/atomics.c
> +++ b/tools/testing/selftests/bpf/prog_tests/atomics.c
> @@ -7,18 +7,20 @@
>  static void test_add(struct atomics_lskel *skel)
>  {
>         int err, prog_fd;
> -       __u32 duration = 0, retval;
>         int link_fd;
> +       LIBBPF_OPTS(bpf_test_run_opts, topts,
> +               .repeat = 1,
> +       );

for simple case like this you can just keep it single line:

LIBBPF_OPTS(bpf_test_run_opts, topts, .repeat = 1)

But, it seems like the kernel does `if (!repeat) repeat = 1;` logic
for program types that support repeat feature, so I'd suggest just
drop .repeat = 1 and keep it simple.

>
>         link_fd = atomics_lskel__add__attach(skel);
>         if (!ASSERT_GT(link_fd, 0, "attach(add)"))
>                 return;
>
>         prog_fd = skel->progs.add.prog_fd;
> -       err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
> -                               NULL, NULL, &retval, &duration);
> -       if (CHECK(err || retval, "test_run add",
> -                 "err %d errno %d retval %d duration %d\n", err, errno, retval, duration))
> +       err = bpf_prog_test_run_opts(prog_fd, &topts);
> +       if (CHECK_OPTS(err || topts.retval, "test_run add",

let's not add new CHECK*() variants, CHECK() and its derivative are
deprecated, we are using ASSERT_xxx() macros for all new code.

In this case, I think it's best to replace CHECK() with just:

ASSERT_OK(err, "run_err");
ASSERT_OK(topts.retval, "run_ret_val");

I don't think logging duration is useful for most, if not all, tests,
so I wouldn't bother.


> +                      "err %d errno %d retval %d duration %d\n", err, errno,
> +                      topts.retval, topts.duration))
>                 goto cleanup;
>
>         ASSERT_EQ(skel->data->add64_value, 3, "add64_value");

[...]

> diff --git a/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c b/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c
> index 4374ac8a8a91..cb0bcd9bb950 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c
> @@ -9,38 +9,43 @@ void test_fentry_fexit(void)
>         struct fentry_test_lskel *fentry_skel = NULL;
>         struct fexit_test_lskel *fexit_skel = NULL;
>         __u64 *fentry_res, *fexit_res;
> -       __u32 duration = 0, retval;
>         int err, prog_fd, i;
> +       LIBBPF_OPTS(bpf_test_run_opts, topts,
> +               .repeat = 1,
> +       );
>
>         fentry_skel = fentry_test_lskel__open_and_load();
> -       if (CHECK(!fentry_skel, "fentry_skel_load", "fentry skeleton failed\n"))
> +       if (CHECK_OPTS(!fentry_skel, "fentry_skel_load",
> +                      "fentry skeleton failed\n"))

You didn't have to touch this code, you could have just kept duration
= 0 (which CHECK() internally assumes, unfortunately).

Alternatively, just switch to ASSERT_OK_PTR(fentry_skel,
"fentry_skel_load"); and be done with it. As I mentioned, we are in a
gradual process of removing CHECK()s, I was actually surprised how far
we've progressed already:

$ rg CHECK | wc -l
2024
$ rg ASSERT_ | wc -l
1782

At some point we'll do the final push and remove CHECK() altogether,
but it doesn't have to be part of this patch set (unless you are
interested in doing some more mechanical conversions, of course, it's
greatly appreciated, but I didn't yet have heart to ask anyone to do
those 2000 conversions...).

>                 goto close_prog;
>         fexit_skel = fexit_test_lskel__open_and_load();
> -       if (CHECK(!fexit_skel, "fexit_skel_load", "fexit skeleton failed\n"))
> +       if (CHECK_OPTS(!fexit_skel, "fexit_skel_load",
> +                      "fexit skeleton failed\n"))
>                 goto close_prog;
>

[...]
