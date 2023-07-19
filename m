Return-Path: <bpf+bounces-5226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C10A758A8A
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 03:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B43E12818C3
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 01:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA38615D1;
	Wed, 19 Jul 2023 01:00:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB861ECA
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 01:00:07 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307CFD3
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 18:00:06 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b93fba1f62so46622051fa.1
        for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 18:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689728404; x=1692320404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAEqCtYzjHedUSm/G/8OwXtYIZtN4xqRFxqmxcx+s9g=;
        b=SHMdHWU5MHl0cmQB2Lv1uhIOLWgV0ourhmmw2/hWRek8g55irfDffa2ILOSR59AHo4
         D6fn7OdVh7accPBdQJhlqWpoabpPo3YCRjK3FgM4VFeh9I74+7BgKD8pmiTDfCahwgcL
         oJG3bqEqOhIFu6f3YZkZz7Xo+QK07R/tPIqDlH/q7j/10pyOIpdvPGNQc1xOuPWz2QOf
         5bVv6E7TNhGzWwPn4pe/rgeK+fZVJL+l49n4iEDph7DnzqhH3GzsR8m4KNo3pdoKlP5w
         D1s6uWAvv1Obxin0tpl5OSYOhoVtyoxpyekmYSzyR5UVQXiJV2+284ACMXWQLww0VD3k
         DcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689728404; x=1692320404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAEqCtYzjHedUSm/G/8OwXtYIZtN4xqRFxqmxcx+s9g=;
        b=DM9/az5QWzGSEXI5y7SvekMajIFZj/wjBOQ3tJhT5MTUGi9I/+xYP6KZStfm9j9SiH
         6c97Glc/2QiCDotX+RfuQpopvfMbNOQ6ATT7x9juh0m3BKW3PR0nRVKTslZg54Atrvfy
         zeLbo0f9df6XIRfY4iIQNxamO+8pdQyYDQBu1j20VUk8ImkDZ/B4WRyHi52rR5ARIL9s
         rAwvXZQO37Xz3TbAznYIX9ff97yYDe0rUmIzxz7bcxg295vw2tF43Rsytd1h06uYrB7b
         RQaV/KxXJP4nfIU8pjZTbvmd393SNxFID2aDKLELLbuxjJz3LEvyTGue7xHHOv6d9pBs
         g43Q==
X-Gm-Message-State: ABy/qLanhY890h6RlKj6UGcPcRwXgvwBUgsVhVePWfDLqAMdmA65Jwpw
	kgQOfEkBnlV3Fc38ZICAznTO55AnFv8R5KKJFb4=
X-Google-Smtp-Source: APBJJlFbrie0RR4QoIU3PW2bpVUsoESfAQtLFeFP9f94+r9SSd0Hw4qVOrBYqmWvXbRxUP4yq2y7imPRAJEuRFqJWSY=
X-Received: by 2002:a2e:b053:0:b0:2b9:4476:ab28 with SMTP id
 d19-20020a2eb053000000b002b94476ab28mr5249200ljl.38.1689728404248; Tue, 18
 Jul 2023 18:00:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230717111742.183926-1-jolsa@kernel.org> <20230717111742.183926-2-jolsa@kernel.org>
In-Reply-To: <20230717111742.183926-2-jolsa@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 18 Jul 2023 17:59:53 -0700
Message-ID: <CAADnVQJ=h3yg0u6qEOBV+XmAWOVg7W7rsW05dK_WuYBUnZZ7zg@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf: Disable preemption in bpf_perf_event_output
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

On Mon, Jul 17, 2023 at 4:17=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> The nesting protection in bpf_perf_event_output relies on disabled
> preemption, which is guaranteed for kprobes and tracepoints.

I don't understand why you came up with such a conclusion.
bpf_perf_event_output needs migration disabled and doesn't mind
being preempted.
That's what the nested counter is for.

Stack trace also doesn't look like it's related to that.
More like stack corruption in perf_output_sample.

Do you have
commit eb81a2ed4f52 ("perf/core: Fix perf_output_begin parameter is
incorrectly invoked in perf_event_bpf_output")
in your kernel?

> However bpf_perf_event_output can be also called from uprobes context
> through bpf_prog_run_array_sleepable function which disables migration,
> but keeps preemption enabled.
>
> This can cause task to be preempted by another one inside the nesting
> protection and lead eventually to two tasks using same perf_sample_data
> buffer and cause crashes like:
>
>   kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
>   BUG: unable to handle page fault for address: ffffffff82be3eea
>   ...
>   Call Trace:
>    ? __die+0x1f/0x70
>    ? page_fault_oops+0x176/0x4d0
>    ? exc_page_fault+0x132/0x230
>    ? asm_exc_page_fault+0x22/0x30
>    ? perf_output_sample+0x12b/0x910
>    ? perf_event_output+0xd0/0x1d0
>    ? bpf_perf_event_output+0x162/0x1d0
>    ? bpf_prog_c6271286d9a4c938_krava1+0x76/0x87
>    ? __uprobe_perf_func+0x12b/0x540
>    ? uprobe_dispatcher+0x2c4/0x430
>    ? uprobe_notify_resume+0x2da/0xce0
>    ? atomic_notifier_call_chain+0x7b/0x110
>    ? exit_to_user_mode_prepare+0x13e/0x290
>    ? irqentry_exit_to_user_mode+0x5/0x30
>    ? asm_exc_int3+0x35/0x40
>
> Fixing this by disabling preemption in bpf_perf_event_output.
>
> Fixes: 9594dc3c7e71 ("bpf: fix nested bpf tracepoints with per-cpu data")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/trace/bpf_trace.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index c92eb8c6ff08..2a6ba05d8aee 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -661,8 +661,7 @@ static DEFINE_PER_CPU(int, bpf_trace_nest_level);
>  BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, regs, struct bpf_map=
 *, map,
>            u64, flags, void *, data, u64, size)
>  {
> -       struct bpf_trace_sample_data *sds =3D this_cpu_ptr(&bpf_trace_sds=
);
> -       int nest_level =3D this_cpu_inc_return(bpf_trace_nest_level);
> +       struct bpf_trace_sample_data *sds;
>         struct perf_raw_record raw =3D {
>                 .frag =3D {
>                         .size =3D size,
> @@ -670,7 +669,12 @@ BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, =
regs, struct bpf_map *, map,
>                 },
>         };
>         struct perf_sample_data *sd;
> -       int err;
> +       int nest_level, err;
> +
> +       preempt_disable();
> +
> +       sds =3D this_cpu_ptr(&bpf_trace_sds);
> +       nest_level =3D this_cpu_inc_return(bpf_trace_nest_level);
>
>         if (WARN_ON_ONCE(nest_level > ARRAY_SIZE(sds->sds))) {
>                 err =3D -EBUSY;
> @@ -691,6 +695,7 @@ BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, r=
egs, struct bpf_map *, map,
>
>  out:
>         this_cpu_dec(bpf_trace_nest_level);
> +       preempt_enable();
>         return err;
>  }
>
> --
> 2.41.0
>

