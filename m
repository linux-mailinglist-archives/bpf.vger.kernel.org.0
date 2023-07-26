Return-Path: <bpf+bounces-5892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8257627A9
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 02:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198F91C21015
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 00:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E355A42;
	Wed, 26 Jul 2023 00:13:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540D7197
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 00:13:28 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589FA26A5;
	Tue, 25 Jul 2023 17:13:26 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b974031aeaso70788761fa.0;
        Tue, 25 Jul 2023 17:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690330404; x=1690935204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDDgReAJCptzk/DJeO2qgJGBxlxZ6C3u8/sdB5PsuSs=;
        b=NFMTJ48ZTXZ3BuqMksqg9ZujmiD9svp900Tn10XqWhtaXlz7wScIzrd8Jgd454WVLK
         uYpzBAX2b0sFiL3RG/cv4adyRHORKmjeic0cKoXrpB9jlWQSr0qatayodB+PfnFxQ0+p
         Xxrl5g11QEIHxJuWRvJtIDDMwVrVWgC6PGs/3zqBPomBj1KC2gytgiYAdsKCuBn+kWfM
         AxJ5YPk/rr0eeYCZvcyZs1WCD8R8bFNkfkL6nQERobJGyGzXNFMCVypGU6u5FphvgK7Q
         hOVuBYpAWoio/qCpN9x9t0fUC+1U07Ip3K2/KhDqtC3kvxz3y0xqDYWu59rm0/rwnUPB
         q+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690330404; x=1690935204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SDDgReAJCptzk/DJeO2qgJGBxlxZ6C3u8/sdB5PsuSs=;
        b=Ent2ZRxncg6TXUMrsiUWZPsvDR3rjVKEFuLl71m+wasNXSgzQtuk107j1sO6XrSqXE
         mQT0DZQlssUu34Y55Xmrc7lszVa1S+rvTPKHbFSfI7NN6mg5RjftVW9+e0SUsWWpqlMr
         BOU9Flx+XPmZWejdlpT5KD8IkccJZeTAzJQ4+QUH6UH3axfg2esbFWdQgWhUnHL9Lk2M
         XDtqWPsbUcteeHsUpt4tLhkK/jlcSzjTrYhRVzHbFoWSAreXd2nyD2ChCrPFKeTD+/nA
         apGBxEzcPalqEcfA7l5TMZuZEsGc80tkjyVRvIbBO3i3CUdFNxWfqYJjDfmNE+/V32gw
         rlng==
X-Gm-Message-State: ABy/qLZXOvG6wmKi/hyO0jH9yqWgSFzimMU64VzP/7iKUgPoby4k+PIa
	6ePeFf8eoP4EeTMgwl3FIciZmA1rMh2A6dgNDXo=
X-Google-Smtp-Source: APBJJlGcaZlSQGitPhosly4Hm5s7GQ7lGgaDenwkub/4S31WdbNSvy0xDUbss4wWpG8k18MQek0MG+wMtVlp+Y1o8vQ=
X-Received: by 2002:a2e:2c0a:0:b0:2b6:effd:9a3b with SMTP id
 s10-20020a2e2c0a000000b002b6effd9a3bmr210034ljs.24.1690330404155; Tue, 25 Jul
 2023 17:13:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230725084206.580930-1-jolsa@kernel.org> <20230725084206.580930-3-jolsa@kernel.org>
In-Reply-To: <20230725084206.580930-3-jolsa@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 25 Jul 2023 17:13:12 -0700
Message-ID: <CAADnVQJLjS4WXz7Dod0Sc1iZFuJOnqByEwwN3ukAWtbRhOE9DA@mail.gmail.com>
Subject: Re: [PATCHv3 bpf 2/2] bpf: Disable preemption in bpf_event_output
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, stable <stable@vger.kernel.org>, Hou Tao <houtao1@huawei.com>, 
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 1:42=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> We received report [1] of kernel crash, which is caused by
> using nesting protection without disabled preemption.
>
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
> Cc: stable@vger.kernel.org
> Reported-by: Oleg "livelace" Popov <o.popov@livelace.ru>
> Closes: https://github.com/cilium/cilium/issues/26756
> Fixes: 2a916f2f546c ("bpf: Use migrate_disable/enable in array macros and=
 cgroup/lirc code.")
> Acked-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/trace/bpf_trace.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 14c9a1a548c9..6826ebf750b0 100644
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

Removed extra empty line here and in patch 1 and applied.

Thanks!

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

