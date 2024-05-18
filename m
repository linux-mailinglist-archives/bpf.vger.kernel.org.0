Return-Path: <bpf+bounces-29989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA8A8C8F39
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 03:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB24D1C2162E
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 01:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367A34A2D;
	Sat, 18 May 2024 01:36:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7356F65C;
	Sat, 18 May 2024 01:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715996195; cv=none; b=hyOwWsaC+r3bJxjW+TyUD3pFtqpI6sTwzHf+ikSa30hYtlzXmJ7Igz1qnmeRN4x83OHezBIEu69hlUsTB2ZiVbsbODdVnOU0HKxac5LwR+0vd8v8uR/p3QRWxeAKhYehfuckq0pdQSzLgsz8MurhKDrDE4x/ifK0ALZL1xZOZJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715996195; c=relaxed/simple;
	bh=g77ml5lcE2iE9xCtb9k6mMp59FTQtocZvJ+uMVyH8lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f5I5KM+JrBM6gPoUU3EVUMoB90qbZFRUWXq3bqwS1H4LziK3Iqo309SG0GG9QXBcecU0eEXrqgsm6XNzXgqJMOaWpE/cVm8wkPcsEvkxvSpyQTs4jb4ZuKlDO5oPAIo3jF48yKHvhxXjvgLwWSldwmc7+Vvn+wm1itOpjJvzw88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ecddf96313so27527975ad.2;
        Fri, 17 May 2024 18:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715996194; x=1716600994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTCxofTlWGQ9nrhOXteZtT/uEkQ42dDxCW5nFgvpDLE=;
        b=SwYfO2exMGF6SaYaV6caVnO6gI1qeqA/4/tpw2OjyRNKLnElRvnL4dpth8BcRg/49f
         2w72+5iZ2tMk2M5Xw43ag+3j0i2GtF0uELAITvS9dy6RtDoByHP7qK+8ge6GZYAZVp4Y
         86sweo2uG642bz/wHLSf35kLOYVfRlDQYFdlCS61DyjETZ9MhFU7nnDcdTTeUiylvY0/
         PCfaxhNlvwW9lp1Yv1rDzKZMYjlL6xLygZvh9uerY83W2twm+W61QJre7pAq2MIkdX5p
         k56L0bpIFWJWbamGKimpn+3MDNII8LdICTFM3X3aWqnAeZQjs8mHbosCvxHOQR9M7pwV
         XpXg==
X-Forwarded-Encrypted: i=1; AJvYcCUgQ7shHV4EtUq2PY4vGkzBRngU5alvt+CDIfsuJh8gpCdtAlMfYq9uEFHBy4MoTXRt93y1ORGx3vLWFmc8pwjarop2yPFXYIJ9DTU4BueObMPGI9PBThNQCgov9pDotNN2+0LbG8Cqkhk9HPq3umBVxConO/L15wXr30Z4dWQ3Y+9B2w==
X-Gm-Message-State: AOJu0YwA51gHiH5wpA1Y9EWaU9G7WM0+cnfv1uofJliZA0qK9gW66Q2y
	gvX0kNo/quT1lnaoqHZkMd5L9RemaennqOOg219UaJYo6BDa3JomZ+htynr3M3pFbYNxM1aA+OY
	9Leo+eR18r4M0S+5Ug0jT8l4F9wk=
X-Google-Smtp-Source: AGHT+IHz1K3GEGvf07srArdolZCSfjAM4JlLqExr1aWNukGplBGX2CHIyL37WzFuCgZuf12UbGqNcPeIrcsBcCcOfQQ=
X-Received: by 2002:a17:90b:5184:b0:2b8:d6cb:101e with SMTP id
 98e67ed59e1d1-2b8d6cb1263mr17605329a91.7.1715996193620; Fri, 17 May 2024
 18:36:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516041948.3546553-1-irogers@google.com> <20240516041948.3546553-2-irogers@google.com>
In-Reply-To: <20240516041948.3546553-2-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 17 May 2024 18:36:22 -0700
Message-ID: <CAM9d7ch51JK8Xu+kOYUdxgM10_gS2=vjfW5sqFwrRS2eC8cYXA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] perf bpf filter: Give terms their own enum
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Changbin Du <changbin.du@huawei.com>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 9:20=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Give the term types their own enum so that additional terms can be
> added that don't correspond to a PERF_SAMPLE_xx flag. The term values
> are numerically ascending rather than bit field positions, this means
> they need translating to a PERF_SAMPLE_xx bit field in certain places
> and they are more densely encoded.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
[SNIP]
> diff --git a/tools/perf/util/bpf_skel/sample-filter.h b/tools/perf/util/b=
pf_skel/sample-filter.h
> index 2e96e1ab084a..161d5ff49cb6 100644
> --- a/tools/perf/util/bpf_skel/sample-filter.h
> +++ b/tools/perf/util/bpf_skel/sample-filter.h
> @@ -16,12 +16,32 @@ enum perf_bpf_filter_op {
>         PBF_OP_GROUP_END,
>  };
>
> +enum perf_bpf_filter_term {
> +       /* No term is in use. */
> +       PBF_TERM_NONE,
> +       /* Terms that correspond to PERF_SAMPLE_xx values. */
> +       PBF_TERM_IP,
> +       PBF_TERM_ID,
> +       PBF_TERM_TID,
> +       PBF_TERM_CPU,
> +       PBF_TERM_TIME,
> +       PBF_TERM_ADDR,
> +       PBF_TERM_PERIOD,
> +       PBF_TERM_TRANSACTION,
> +       PBF_TERM_WEIGHT,
> +       PBF_TERM_PHYS_ADDR,
> +       PBF_TERM_CODE_PAGE_SIZE,
> +       PBF_TERM_DATA_PAGE_SIZE,
> +       PBF_TERM_WEIGHT_STRUCT,
> +       PBF_TERM_DATA_SRC,
> +};
> +
>  /* BPF map entry for filtering */
>  struct perf_bpf_filter_entry {
>         enum perf_bpf_filter_op op;
>         __u32 part; /* sub-sample type info when it has multiple values *=
/
> -       __u64 flags; /* perf sample type flags */
> +       enum perf_bpf_filter_term term;
>         __u64 value;
>  };
>
> -#endif /* PERF_UTIL_BPF_SKEL_SAMPLE_FILTER_H */
> \ No newline at end of file
> +#endif /* PERF_UTIL_BPF_SKEL_SAMPLE_FILTER_H */
> diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/ut=
il/bpf_skel/sample_filter.bpf.c
> index fb94f5280626..8666c85e9333 100644
> --- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
> +++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
> @@ -48,31 +48,50 @@ static inline __u64 perf_get_sample(struct bpf_perf_e=
vent_data_kern *kctx,
>  {
>         struct perf_sample_data___new *data =3D (void *)kctx->data;
>
> -       if (!bpf_core_field_exists(data->sample_flags) ||
> -           (data->sample_flags & entry->flags) =3D=3D 0)
> +       if (!bpf_core_field_exists(data->sample_flags))
>                 return 0;
>
> -       switch (entry->flags) {
> -       case PERF_SAMPLE_IP:
> +       switch (entry->term) {
> +       case PBF_TERM_NONE:
> +               return 0;
> +       case PBF_TERM_IP:
> +               if ((data->sample_flags & PERF_SAMPLE_IP) =3D=3D 0)
> +                       return 0;

Can we check this in a single place like in the original code
instead of doing it in every case?  I think we can keep the
entry->flags and check it only if it's non zero.  Then uid and
gid will have 0 to skip.

Thanks,
Namhyung


>                 return kctx->data->ip;
> -       case PERF_SAMPLE_ID:
> +       case PBF_TERM_ID:
> +               if ((data->sample_flags & PERF_SAMPLE_ID) =3D=3D 0)
> +                       return 0;
>                 return kctx->data->id;
> -       case PERF_SAMPLE_TID:
> +       case PBF_TERM_TID:
> +               if ((data->sample_flags & PERF_SAMPLE_TID) =3D=3D 0)
> +                       return 0;
>                 if (entry->part)
>                         return kctx->data->tid_entry.pid;
>                 else
>                         return kctx->data->tid_entry.tid;
> -       case PERF_SAMPLE_CPU:
> +       case PBF_TERM_CPU:
> +               if ((data->sample_flags & PERF_SAMPLE_CPU) =3D=3D 0)
> +                       return 0;
>                 return kctx->data->cpu_entry.cpu;
> -       case PERF_SAMPLE_TIME:
> +       case PBF_TERM_TIME:
> +               if ((data->sample_flags & PERF_SAMPLE_TIME) =3D=3D 0)
> +                       return 0;
>                 return kctx->data->time;
> -       case PERF_SAMPLE_ADDR:
> +       case PBF_TERM_ADDR:
> +               if ((data->sample_flags & PERF_SAMPLE_ADDR) =3D=3D 0)
> +                       return 0;
>                 return kctx->data->addr;
> -       case PERF_SAMPLE_PERIOD:
> +       case PBF_TERM_PERIOD:
> +               if ((data->sample_flags & PERF_SAMPLE_PERIOD) =3D=3D 0)
> +                       return 0;
>                 return kctx->data->period;
> -       case PERF_SAMPLE_TRANSACTION:
> +       case PBF_TERM_TRANSACTION:
> +               if ((data->sample_flags & PERF_SAMPLE_TRANSACTION) =3D=3D=
 0)
> +                       return 0;
>                 return kctx->data->txn;
> -       case PERF_SAMPLE_WEIGHT_STRUCT:
> +       case PBF_TERM_WEIGHT_STRUCT:
> +               if ((data->sample_flags & PERF_SAMPLE_WEIGHT_STRUCT) =3D=
=3D 0)
> +                       return 0;
>                 if (entry->part =3D=3D 1)
>                         return kctx->data->weight.var1_dw;
>                 if (entry->part =3D=3D 2)
> @@ -80,15 +99,25 @@ static inline __u64 perf_get_sample(struct bpf_perf_e=
vent_data_kern *kctx,
>                 if (entry->part =3D=3D 3)
>                         return kctx->data->weight.var3_w;
>                 /* fall through */
> -       case PERF_SAMPLE_WEIGHT:
> +       case PBF_TERM_WEIGHT:
> +               if ((data->sample_flags & PERF_SAMPLE_WEIGHT) =3D=3D 0)
> +                       return 0;
>                 return kctx->data->weight.full;
> -       case PERF_SAMPLE_PHYS_ADDR:
> +       case PBF_TERM_PHYS_ADDR:
> +               if ((data->sample_flags & PERF_SAMPLE_PHYS_ADDR) =3D=3D 0=
)
> +                       return 0;
>                 return kctx->data->phys_addr;
> -       case PERF_SAMPLE_CODE_PAGE_SIZE:
> +       case PBF_TERM_CODE_PAGE_SIZE:
> +               if ((data->sample_flags & PERF_SAMPLE_CODE_PAGE_SIZE) =3D=
=3D 0)
> +                       return 0;
>                 return kctx->data->code_page_size;
> -       case PERF_SAMPLE_DATA_PAGE_SIZE:
> +       case PBF_TERM_DATA_PAGE_SIZE:
> +               if ((data->sample_flags & PERF_SAMPLE_DATA_PAGE_SIZE) =3D=
=3D 0)
> +                       return 0;
>                 return kctx->data->data_page_size;
> -       case PERF_SAMPLE_DATA_SRC:
> +       case PBF_TERM_DATA_SRC:
> +               if ((data->sample_flags & PERF_SAMPLE_DATA_SRC) =3D=3D 0)
> +                       return 0;
>                 if (entry->part =3D=3D 1)
>                         return kctx->data->data_src.mem_op;
>                 if (entry->part =3D=3D 2)
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>

