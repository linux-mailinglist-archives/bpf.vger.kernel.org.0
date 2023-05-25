Return-Path: <bpf+bounces-1245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 198627112E9
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 19:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60111C20E43
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 17:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B676A1F95C;
	Thu, 25 May 2023 17:54:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB29101DA
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 17:54:28 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C1097;
	Thu, 25 May 2023 10:54:27 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-973bf581759so128328366b.0;
        Thu, 25 May 2023 10:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685037265; x=1687629265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/20VApzN3sPBkZnwvcb54AXnS2bInta1+wgq5QOgNk=;
        b=oPFaXJfLPwtyQ8WQccrT5LJWteQExDZlck7hQ8gV3hf2nc9G+/0BySXr22HsKUzmF4
         9Di1OwPIY/19Mt7BETii5qHDnhYu1XOXOJPbC2lfFDbA/Kb6eb+4+wj3441d0t+M60sL
         FCu78LPWypiTBBgyBI6eETM9558mdswP1U05UdIVYZpaUvOPHogvaF/ujUJ0RomnP1rD
         9Jxo2LgGIaNZUEYKC8zm1r/hFCyuIjcZH9FZAIQjVbfiqsraqUk7BLkFVj0oa9QhargJ
         0hMwvvVqh+q/OxQ9UcqL2Fj15UXlyi4Id2PyCkUlnckEtrGymRbvEW7SryyWCskwxECZ
         BV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685037265; x=1687629265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/20VApzN3sPBkZnwvcb54AXnS2bInta1+wgq5QOgNk=;
        b=AzwCHLVTBJ0cP5CdBQS9lD68dHczoqnjNMXBeo67HVHtY2Up4FwdWlk6kNgRVgScwL
         J+bz14RgohYErHYCLKEUeq6lWhnweA+BI8Vq2Er8kQumdVq7Y/qm4I3XqwAuvkd1fDRw
         bsjeDJcDS/HoYze92yO3mcgUAWzI3gM9lmX9qrm5C/bCznZjTvbJQL0j774Z6OQfiGKj
         oxIJvvTlLKdfYQ1Ij3NPOOeSMY+YAp/LDyjEHbPM2ERc9T7glPyrnCbDtMBu4zFxztya
         UhDaANhF512iNX1hSwwEaJW1v7MEbIF+kvT0wXH4JP+1h/dQhHvOnb6tYqGVummvjtTe
         foIg==
X-Gm-Message-State: AC+VfDxugOH0IkRyZpyT47I80lj9S9dxljr8J2Lxw7P4HFI5FhCKvPWe
	DR1ibhJlykhSwBcWkp3SoO5/liryaWH9ksxsSAk=
X-Google-Smtp-Source: ACHHUZ4uYZNxBOT8583zqUCp1HxGXJcJEeFPbQbqIP0VbykWDy05PjW7yuUdg18pAwUBZmZYzK9+WAFtxN3EqV1tdgk=
X-Received: by 2002:a17:907:36c9:b0:953:517a:8f1a with SMTP id
 bj9-20020a17090736c900b00953517a8f1amr2030819ejc.58.1685037265452; Thu, 25
 May 2023 10:54:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230525000307.3202449-1-namhyung@kernel.org>
In-Reply-To: <20230525000307.3202449-1-namhyung@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 May 2023 10:54:13 -0700
Message-ID: <CAEf4BzbKtJ+xehJqzStiUEB67YbDFpydVSiLbNi2=WQt+8iDBQ@mail.gmail.com>
Subject: Re: [PATCH] perf bpf filter: Fix a broken perf sample data naming in BPF
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 24, 2023 at 5:03=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> BPF CO-RE requires 3 underscores for the ignored suffix rule but it
> mistakenly used only 2.  Let's fix it.
>
> Fixes: 3a8b8fc31748 ("perf bpf filter: Support pre-5.16 kernels where 'me=
m_hops' isn't in 'union perf_mem_data_src'")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/bpf_skel/sample_filter.bpf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Seems like that's the only remaining case. LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/ut=
il/bpf_skel/sample_filter.bpf.c
> index cffe493af1ed..fb94f5280626 100644
> --- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
> +++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
> @@ -25,7 +25,7 @@ struct perf_sample_data___new {
>  } __attribute__((preserve_access_index));
>
>  /* new kernel perf_mem_data_src definition */
> -union perf_mem_data_src__new {
> +union perf_mem_data_src___new {
>         __u64 val;
>         struct {
>                 __u64   mem_op:5,       /* type of opcode */
> @@ -108,7 +108,7 @@ static inline __u64 perf_get_sample(struct bpf_perf_e=
vent_data_kern *kctx,
>                 if (entry->part =3D=3D 7)
>                         return kctx->data->data_src.mem_blk;
>                 if (entry->part =3D=3D 8) {
> -                       union perf_mem_data_src__new *data =3D (void *)&k=
ctx->data->data_src;
> +                       union perf_mem_data_src___new *data =3D (void *)&=
kctx->data->data_src;
>
>                         if (bpf_core_field_exists(data->mem_hops))
>                                 return data->mem_hops;
> --
> 2.41.0.rc0.172.g3f132b7071-goog
>
>

