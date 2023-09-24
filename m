Return-Path: <bpf+bounces-10724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B773F7ACB35
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 20:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 16BBA2817AF
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 18:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0536DDB8;
	Sun, 24 Sep 2023 18:03:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23622D268
	for <bpf@vger.kernel.org>; Sun, 24 Sep 2023 18:03:36 +0000 (UTC)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B97CFB
	for <bpf@vger.kernel.org>; Sun, 24 Sep 2023 11:03:34 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-415155b2796so245791cf.1
        for <bpf@vger.kernel.org>; Sun, 24 Sep 2023 11:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695578613; x=1696183413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFnymHRtoiSLSE6xlXlPfUo1MSdkdwnizEDkqFjEp5M=;
        b=0N12PufIVMADzpR5JvZrVR1zBlw3XeOS0LiFKjxachJfNLZIhXtRQzCDpapBxqeN/N
         KOc1wyj3fz/Ng9libyDmqF6fKVTpgF0ldnPHb18GIKQM16jZZNFrlfv3OeSGIOETR1z9
         z92OZJSBn9IweU/o5n5BizcPtqgTRoFKwvVaRp7S1Bt2dDx4rjb9wijBUs8QF0E6IILx
         F138fTwNd1RBoe8crEm1bo7VibmUQmvqR4u+WTZwDdCNgQ6UW2KOVJqpR0Z8CvqBbWWw
         gFyjKrPTbPDIdHj9cBQ7wvqW3ADh+w10ULYMN3MDx3EAo0ciOjqkkUQtHO62iCSSSgOn
         Vaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695578613; x=1696183413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFnymHRtoiSLSE6xlXlPfUo1MSdkdwnizEDkqFjEp5M=;
        b=m4NVYQvJ+5ieVyEQEkRGpEzlCmypG2MbPYT6fHjGfPHjXP6SVQCaDkK9WJvzC4J1bg
         5hRwOmCojRDC8WjL8tYNrE9bzb8xKgxBbgfRL3RzMfWtC0+S8BMLn0Ci48B9rtE60rch
         ZZbQmEGTdd9cvMVoqT9+Hh+FWWMAksGqOdOSyIUiVMsFFlhiOA2V1pUSGT1SyigSC9Rk
         ECcH13cVeaGbJRgjkKKQKR2iPNLlpN8SwQtmGwiTpRO5tc7gyyQHlBKzTB95fQQzJxGm
         OlCzjA/Ha54vleph7dK4R8F8ms2zcnQDQyUNqi7JDsMBFBZuxx0hcfW3Xg/yRD2qD6tM
         Ip0A==
X-Gm-Message-State: AOJu0YxvjB+9LGWWAOLPgs3MkinMMdVTRWvsqbcVNLVcegiZ8EK8SjbU
	ZT83LtyhIF8h0/IKhiQjJNYT5Yc9/lX2Plfurrt5CQ==
X-Google-Smtp-Source: AGHT+IF1Z2oLq9smh2qhEPC193F5fqkRC6B/tsHivKcbUv1O+Mhj/WxhnsnegPuh58Fu+zugRoFHFRSC8frjQTSIMog=
X-Received: by 2002:a05:622a:111:b0:3f0:af20:1a37 with SMTP id
 u17-20020a05622a011100b003f0af201a37mr308189qtw.15.1695578613246; Sun, 24 Sep
 2023 11:03:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230922234444.3115821-1-namhyung@kernel.org>
In-Reply-To: <20230922234444.3115821-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Sun, 24 Sep 2023 11:03:20 -0700
Message-ID: <CAP-5=fVMdX+vLPNBSe-8arKGvAGcdgHGt7ypEX-J-SZpUi2PGg@mail.gmail.com>
Subject: Re: [PATCH] perf record: Fix BTF type checks in the off-cpu profiling
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 4:44=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The BTF func proto for a tracepoint has one more argument than the
> actual tracepoint function since it has a context argument at the
> begining.  So it should compare to 5 when the tracepoint has 4
> arguments.
>
>   typedef void (*btf_trace_sched_switch)(void *, bool, struct task_struct=
 *, struct task_struct *, unsigned int);
>
> Also, recent change in the perf tool would use a hand-written minimal
> vmlinux.h to generate BTF in the skeleton.  So it won't have the info
> of the tracepoint.  Anyway it should use the kernel's vmlinux BTF to
> check the type in the kernel.
>
> Fixes: b36888f71c85 ("perf record: Handle argument change in sched_switch=
")
> Cc: Song Liu <song@kernel.org>
> Cc: Hao Luo <haoluo@google.com>
> CC: bpf@vger.kernel.org
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/util/bpf_off_cpu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.=
c
> index 01f70b8e705a..21f4d9ba023d 100644
> --- a/tools/perf/util/bpf_off_cpu.c
> +++ b/tools/perf/util/bpf_off_cpu.c
> @@ -98,7 +98,7 @@ static void off_cpu_finish(void *arg __maybe_unused)
>  /* v5.18 kernel added prev_state arg, so it needs to check the signature=
 */
>  static void check_sched_switch_args(void)
>  {
> -       const struct btf *btf =3D bpf_object__btf(skel->obj);
> +       const struct btf *btf =3D btf__load_vmlinux_btf();
>         const struct btf_type *t1, *t2, *t3;
>         u32 type_id;
>
> @@ -116,7 +116,8 @@ static void check_sched_switch_args(void)
>                 return;
>
>         t3 =3D btf__type_by_id(btf, t2->type);
> -       if (t3 && btf_is_func_proto(t3) && btf_vlen(t3) =3D=3D 4) {
> +       /* btf_trace func proto has one more argument for the context */
> +       if (t3 && btf_is_func_proto(t3) && btf_vlen(t3) =3D=3D 5) {
>                 /* new format: pass prev_state as 4th arg */

nit: does this comment need updating?

>                 skel->rodata->has_prev_state =3D true;
>         }
> --
> 2.42.0.515.g380fc7ccd1-goog
>

