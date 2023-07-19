Return-Path: <bpf+bounces-5227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8138758A92
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 03:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 044A11C20F59
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 01:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA0915D1;
	Wed, 19 Jul 2023 01:02:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9273617C8
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 01:02:12 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0211719
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 18:02:09 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fbb281eec6so10256779e87.1
        for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 18:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689728527; x=1692320527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IR2CTSlruEZarmfrxhbWpuYtmsEa2Ta8i7N9u1igoUY=;
        b=nVIR4wUxouLbjMlQ6I9jzIOgXkhaiCoK0GtQY8S5d/3GO1TV+4YBGMIkYihHGwnLia
         c3jZksqcyvl/thh++G7nhL5FyiFQgcOAyfAXRvgAsyrtZeEfa7xaW7k8mqRHL4SeGqHn
         4YwTmJXhqNn4oowre7j36DzQGGP2UkWCmaVBQSA1hLz+qC/1z+L7eszBysQV1MwoUIW3
         KOfywYqw+SONm4/4exHRtUx6jRimGl+QK6rld7ntiCPwRV9KG/cMdPCg+FiT/JLjqGPU
         JOV6FMcAZ39gxfgwssDmdJqwSQEQdqPBxafjwedFEI99MUNn/1IYFMhLOROnrG/i+9bm
         EhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689728527; x=1692320527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IR2CTSlruEZarmfrxhbWpuYtmsEa2Ta8i7N9u1igoUY=;
        b=H8gomrkCcmtO1efd7ssWI0BQRx0eydPPi9ahnTp49mABXCxHA3Wwe66ttUZeI7K0o0
         6WMou4pI8MOTuKyCJsuHJ1C/EGE16gVQzrv7/Ec58cjPlzXxf2ulqZkgFOG1QAB+PyB2
         wz8p2NlStPTOgiWBc/Upm466k7c5ntue3nMLDdf+SVAu0iJw6uJ+q2DfGkqwCa6K0Del
         ubmSQJvNY0s1Cl/eiLQ1heJZ4JXJBGTE4AGXmUImHayhiHttUx0Mk0UnOaJXpM1uXKm9
         ye7UvzEWKTnLdfZFGC7OsrKM6Y2uYB8S+3RNDhgLnqDlJMB6oegWVSS/Qm82Ciyyk8qf
         D9ag==
X-Gm-Message-State: ABy/qLaVc3MyTVP8fCKN6UpkSUImpF9sBN3Ay2yT3CPcJA+5ZfdCQCBM
	KuKYVjeTUEboeibtfjKR+NkK1PsUq7EXYgVwU/k=
X-Google-Smtp-Source: APBJJlHWW/P7AU1t6BqGJXfU1A7konAmf1tZmnQKXNwZvWC2vwoKf0x1X+Zd3S85xLDCjLM7dfrWzVhutq/WTf+asFs=
X-Received: by 2002:a2e:868e:0:b0:2b8:377a:22f1 with SMTP id
 l14-20020a2e868e000000b002b8377a22f1mr11061435lji.32.1689728527209; Tue, 18
 Jul 2023 18:02:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230717111742.183926-1-jolsa@kernel.org> <20230717111742.183926-3-jolsa@kernel.org>
In-Reply-To: <20230717111742.183926-3-jolsa@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 18 Jul 2023 18:01:56 -0700
Message-ID: <CAADnVQJfTz8UVP-4FL0TNKXOz_HsnKAwVvf8Y0X6vCTn0H5nuA@mail.gmail.com>
Subject: Re: [PATCH/RFC 2/2] bpf: Disable preemption in bpf_event_output
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 17, 2023 at 4:18=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> We received report [1] of kernel crash, which is caused by
> using nesting protection without disabled preemption.

Same question. I don't see why it would be preemption related.

> The bpf_event_output can be called by programs executed by
> bpf_prog_run_array_cg function that disabled migration but
> keeps preemption enabled.
>
> This can cause task to be preempted by another one inside the
> nesting protection and lead eventually to two tasks using same
> perf_sample_data buffer and cause crashes like:
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000001
>   #PF: supervisor instruction fetch in kernel mode
>   #PF: error_code(0x0010) - not-present page
>   ...
>   ? perf_output_sample+0x12a/0x9a0
>   ? finish_task_switch.isra.0+0x81/0x280
>   ? perf_event_output+0x66/0xa0
>   ? bpf_event_output+0x13a/0x190
>   ? bpf_event_output_data+0x22/0x40
>   ? bpf_prog_dfc84bbde731b257_cil_sock4_connect+0x40a/0xacb
>   ? xa_load+0x87/0xe0
>   ? __cgroup_bpf_run_filter_sock_addr+0xc1/0x1a0
>   ? release_sock+0x3e/0x90
>   ? sk_setsockopt+0x1a1/0x12f0
>   ? udp_pre_connect+0x36/0x50
>   ? inet_dgram_connect+0x93/0xa0
>   ? __sys_connect+0xb4/0xe0
>   ? udp_setsockopt+0x27/0x40
>   ? __pfx_udp_push_pending_frames+0x10/0x10
>   ? __sys_setsockopt+0xdf/0x1a0
>   ? __x64_sys_connect+0xf/0x20
>   ? do_syscall_64+0x3a/0x90
>   ? entry_SYSCALL_64_after_hwframe+0x72/0xdc
>
> Fixing this by disabling preemption in bpf_event_output.
>
> [1] https://github.com/cilium/cilium/issues/26756
> Reported-by:  Oleg "livelace" Popov <o.popov@livelace.ru>
> Fixes: 768fb61fcc13 ("bpf: Fix bpf_event_output re-entry issue")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/trace/bpf_trace.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 2a6ba05d8aee..36fb6e483952 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -720,7 +720,6 @@ static DEFINE_PER_CPU(struct bpf_trace_sample_data, b=
pf_misc_sds);
>  u64 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 met=
a_size,
>                      void *ctx, u64 ctx_size, bpf_ctx_copy_t ctx_copy)
>  {
> -       int nest_level =3D this_cpu_inc_return(bpf_event_output_nest_leve=
l);
>         struct perf_raw_frag frag =3D {
>                 .copy           =3D ctx_copy,
>                 .size           =3D ctx_size,
> @@ -737,8 +736,13 @@ u64 bpf_event_output(struct bpf_map *map, u64 flags,=
 void *meta, u64 meta_size,
>         };
>         struct perf_sample_data *sd;
>         struct pt_regs *regs;
> +       int nest_level;
>         u64 ret;
>
> +       preempt_disable();
> +
> +       nest_level =3D this_cpu_inc_return(bpf_event_output_nest_level);
> +
>         if (WARN_ON_ONCE(nest_level > ARRAY_SIZE(bpf_misc_sds.sds))) {
>                 ret =3D -EBUSY;
>                 goto out;
> @@ -753,6 +757,7 @@ u64 bpf_event_output(struct bpf_map *map, u64 flags, =
void *meta, u64 meta_size,
>         ret =3D __bpf_perf_event_output(regs, map, flags, sd);
>  out:
>         this_cpu_dec(bpf_event_output_nest_level);
> +       preempt_enable();
>         return ret;
>  }
>
> --
> 2.41.0
>

