Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A77C539530
	for <lists+bpf@lfdr.de>; Tue, 31 May 2022 19:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346160AbiEaREv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 May 2022 13:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238234AbiEaREt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 May 2022 13:04:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B1C8DDCC;
        Tue, 31 May 2022 10:04:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0BFD8CE1796;
        Tue, 31 May 2022 17:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47727C3411F;
        Tue, 31 May 2022 17:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654016684;
        bh=j6s+IalVNYTBUA6wgYGP0AcZEJmrt0aOpCnaWU1k1AI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P3682zCCL69GcHpwMCjJpBaQnRgMtwuXh9+cfVEf+V0w9cxd9vwV19GSXvldWAK2o
         Eg4KqpuDdUEW5NAEwwjsqOL8duStTFknbbT4gQaEbEKvgIByScXX1Aij/+UWCSQKDP
         SioFa9jae6NIbvqHviJpXhYhfXCjJTy/cceXJET9Bb6yrVmNIDjeB010xxLVpJ8CGs
         g52qgh3FJxYzHVFCCK9/9+5cCuYmWF+QSIsxTea6LyGPK2Nsrz566/v06hJQanRYm3
         nbHmdO8gQr+czBrOLi3lWukECTWe/iK7Of9YCv0GqMlXt41zeeMdkS0hGR1FZcN4mg
         Af1Iayvp1AiPg==
Received: by mail-yb1-f180.google.com with SMTP id f34so11926203ybj.6;
        Tue, 31 May 2022 10:04:44 -0700 (PDT)
X-Gm-Message-State: AOAM532gnAQHvq+hUbLa2bFvFLdUoesu89CtVjxOKXfea5OXwO4dLO9m
        BTai0LkbuMCrN98Dmtks/DlH3D/EMXPoibHcgHU=
X-Google-Smtp-Source: ABdhPJzqIftVjeP8D3QiVTvl+6CgAWHDhosTcS1v7b8iyGp7C79UUnQqjMkeQMKziYevILPRTrMSyXfh4Omy4fUNPBY=
X-Received: by 2002:a25:7e84:0:b0:650:10e0:87bd with SMTP id
 z126-20020a257e84000000b0065010e087bdmr39214644ybc.257.1654016683266; Tue, 31
 May 2022 10:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1653861287.git.dxu@dxuuu.xyz> <b544771c7bce102f2a97a34e2f5e7ebbb9ea0a24.1653861287.git.dxu@dxuuu.xyz>
In-Reply-To: <b544771c7bce102f2a97a34e2f5e7ebbb9ea0a24.1653861287.git.dxu@dxuuu.xyz>
From:   Song Liu <song@kernel.org>
Date:   Tue, 31 May 2022 10:04:32 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5EGq2uFgO5P3zaX_mcyvn86Fyq9ByEy4QretjL0R3Pcg@mail.gmail.com>
Message-ID: <CAPhsuW5EGq2uFgO5P3zaX_mcyvn86Fyq9ByEy4QretjL0R3Pcg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf, test_run: Add PROG_TEST_RUN support to kprobe
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, May 29, 2022 at 3:06 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> This commit adds PROG_TEST_RUN support to BPF_PROG_TYPE_KPROBE progs. On
> top of being generally useful for unit testing kprobe progs, this commit
> more specifically helps solve a relability problem with bpftrace BEGIN
> and END probes.
>
> BEGIN and END probes are run exactly once at the beginning and end of a
> bpftrace tracing session, respectively. bpftrace currently implements
> the probes by creating two dummy functions and attaching the BEGIN and
> END progs, if defined, to those functions and calling the dummy
> functions as appropriate. This works pretty well most of the time except
> for when distros strip symbols from bpftrace. Every now and then this
> happens and users get confused. Having PROG_TEST_RUN support will help
> solve this issue by allowing us to directly trigger uprobes from
> userspace.
>
> Admittedly, this is a pretty specific problem and could probably be
> solved other ways. However, PROG_TEST_RUN also makes unit testing more
> convenient, especially as users start building more complex tracing
> applications. So I see this as killing two birds with one stone.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  include/linux/bpf.h      | 10 ++++++++++
>  kernel/trace/bpf_trace.c |  1 +
>  net/bpf/test_run.c       | 36 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 47 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 2b914a56a2c5..dec3082ee158 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1751,6 +1751,9 @@ int bpf_prog_test_run_raw_tp(struct bpf_prog *prog,
>  int bpf_prog_test_run_sk_lookup(struct bpf_prog *prog,
>                                 const union bpf_attr *kattr,
>                                 union bpf_attr __user *uattr);
> +int bpf_prog_test_run_kprobe(struct bpf_prog *prog,
> +                            const union bpf_attr *kattr,
> +                            union bpf_attr __user *uattr);
>  bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>                     const struct bpf_prog *prog,
>                     struct bpf_insn_access_aux *info);
> @@ -1998,6 +2001,13 @@ static inline int bpf_prog_test_run_sk_lookup(struct bpf_prog *prog,
>         return -ENOTSUPP;
>  }
>
> +static inline int bpf_prog_test_run_kprobe(struct bpf_prog *prog,
> +                                          const union bpf_attr *kattr,
> +                                          union bpf_attr __user *uattr)
> +{
> +       return -ENOTSUPP;
> +}

As the kernel test bot reported, this is not enough to cover all
different configs. We can
follow the pattern with bpf_prog_test_run_tracing().

Otherwise, this looks good to me.

Song

> +
>  static inline void bpf_map_put(struct bpf_map *map)
>  {
>  }
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 10b157a6d73e..b452e84b9ba4 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1363,6 +1363,7 @@ const struct bpf_verifier_ops kprobe_verifier_ops = {
>  };
>
>  const struct bpf_prog_ops kprobe_prog_ops = {
> +       .test_run = bpf_prog_test_run_kprobe,
>  };
>
>  BPF_CALL_5(bpf_perf_event_output_tp, void *, tp_buff, struct bpf_map *, map,
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 56f059b3c242..0b6fc17ce901 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -1622,6 +1622,42 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog,
>         return err;
>  }
>
> +int bpf_prog_test_run_kprobe(struct bpf_prog *prog,
> +                            const union bpf_attr *kattr,
> +                            union bpf_attr __user *uattr)
> +{
> +       void __user *ctx_in = u64_to_user_ptr(kattr->test.ctx_in);
> +       __u32 ctx_size_in = kattr->test.ctx_size_in;
> +       u32 repeat = kattr->test.repeat;
> +       struct pt_regs *ctx = NULL;
> +       u32 retval, duration;
> +       int err = 0;
> +
> +       if (kattr->test.data_in || kattr->test.data_out ||
> +           kattr->test.ctx_out || kattr->test.flags ||
> +           kattr->test.cpu || kattr->test.batch_size)
> +               return -EINVAL;
> +
> +       if (ctx_size_in != sizeof(struct pt_regs))
> +               return -EINVAL;
> +
> +       ctx = memdup_user(ctx_in, ctx_size_in);
> +       if (IS_ERR(ctx))
> +               return PTR_ERR(ctx);
> +
> +       err = bpf_test_run(prog, ctx, repeat, &retval, &duration, false);
> +       if (err)
> +               goto out;
> +
> +       if (copy_to_user(&uattr->test.retval, &retval, sizeof(retval)) ||
> +           copy_to_user(&uattr->test.duration, &duration, sizeof(duration))) {
> +               err = -EFAULT;
> +       }
> +out:
> +       kfree(ctx);
> +       return err;
> +}
> +
>  static const struct btf_kfunc_id_set bpf_prog_test_kfunc_set = {
>         .owner        = THIS_MODULE,
>         .check_set        = &test_sk_check_kfunc_ids,
> --
> 2.36.1
>
