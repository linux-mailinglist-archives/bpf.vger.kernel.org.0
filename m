Return-Path: <bpf+bounces-58237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0646AAB7667
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 22:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212C0866FDF
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 20:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659B72951DE;
	Wed, 14 May 2025 20:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdkimYli"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730DB1E9B0C;
	Wed, 14 May 2025 20:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253291; cv=none; b=c5GkGpu2K1gY0iVNFLGuYgedHq0sszHw/wtz3PzZ+BdZBXbKXBYaII15AauucPaz0ooLkwc7narwU9VZzLUMwBkUJbwCspsamcRgO3Fi6sBfMpqyTDwgzsZgZisIQW5/bNBU/iiL/LGLIQ5Sr/1Mxjb6DyWu2ptWvCY5zXFon0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253291; c=relaxed/simple;
	bh=X3N2aVqCYNyB+V7LQh7hbMkDswvtRNWzTyi4qd7K6kE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0eJOmeN2qwjbauZ3jRruk08FJWpjZR1rGpICF2XGxQIUVDjRkNBRLisotHyoWxKdqm21dKkyaLob3wysm1c6WV1EeUF5c8uDKj6GmW15PdESpWHM0Wr+rCwr2zsc0aMW+a7jVJ81qZvCKciVsGi7lvZZNeL2k6ILg2SLGx1eh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdkimYli; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e740a09eb00so227096276.0;
        Wed, 14 May 2025 13:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747253287; x=1747858087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnMFZJ+Y+vsiV2dHjLhQlDtDDqCoEieHp1SijjKcO3o=;
        b=SdkimYli/4i2iogdl+A7wNuiekp8x8o5YdoU7XkHFTxmKqDrdEqcsIM7miX8VipraX
         fAer1UWXiZDVj3g/+yphMsKhfCwaj7pdA8Yw22XPI2IQqJQdtHTjf2h+6xXNzdEXCbhU
         dsju9R+73jW7C2x7+SLAYGfJhQmr4I9KPPYSgniRGjnVfY+CKbkaLqVFqTm/sqZjXkRs
         5nBUGWO21sm05IhFeCgchNBqU69T/vf9L9XrubIZPWBQ46JzmkW2bxyxO0f6uZeLn6kC
         iySY7FRZWP0b+tI4VPKqLXc37zh1c/uZTlsODrLOQ5jouG6pmIBt7JSF1kT/WIhSk+0s
         8v5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747253287; x=1747858087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnMFZJ+Y+vsiV2dHjLhQlDtDDqCoEieHp1SijjKcO3o=;
        b=MQEHuIB3gu/egDeIyLOyQ5V0Vt26CFKdUKrNHxC3JPrytLQdRzQzvzgJzx3i8nmlZY
         Jgkd84EmDC0jox5zL+oKkPbHZbNmU8+QZ1Uc0NeOIDQORdn7eL93Zt4H6bx1uGZNkaYM
         HsjX8WmHrGavBEodasM3F7lT5Trx9zXnNQuk/EPqm2V4q3VH5vg5big0NslSCLOqiEZk
         EIqOrOtdLvY5qKJZBiK6hh2zvOjTewJt1x6wSsEWwWQ+cts9IuQTNUWr+xAuDCwW9ue7
         rmthzCHmIKsmHYOLsHIX8yRthASOlvIx+R3vhQaCQ5tlYpG+8KmByJ229mNs1mibmzfU
         /atw==
X-Forwarded-Encrypted: i=1; AJvYcCUMofEZwX4QNG71Z34C5bDdM3EOT1ilaDnQOzS3drPN0o6NHHy63nZyVqlOGQ/zLs0JbZY=@vger.kernel.org, AJvYcCUj3Qq2sl3LOqFraMVYLJqR8SFYH+MvuiqcauFCMe3DhC2qQvNU+rQgm8FwhfNWyKhmQWqWVUtULroFs5VX@vger.kernel.org, AJvYcCW3xbn+LklVPp3svfvYoLCP0Jpeh8pdaOh/1kgmkjDmWwOEVn/AnmwZ3aI2I3qCLk7Xbs0hcYuj+5N85ennCLLePw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhkUXyxOZFCQpHwi9sisbFLvJw22NFaxPouqd3va9RKUXn/XaU
	NOuTVqYR8NQhGVRtouK0YAgMC3oxIj+lZUdEt3yh5CW0RFrkOJ+LrRlmx3YNUd29DwOV8Jq8E8X
	OmAZIGFXe7Ap2Cm6ChKwTIupzXmYuAJW8HpMQjA==
X-Gm-Gg: ASbGncvvVkJOzeEaYSPvMdHQxB26j7zfIfYsqIyNDNkoliDJaGiCpnldeWVmNTr+kXR
	cD/ET2Nwp3VVvvEOjPF3pDB0K+b+okmMbtF1ZrR5FhkhKg5FyjzTSTcCRYBTyLivfHuJPAvupiM
	yC0o8VJgej8yTc0kGDfxCL0n5mDd9HKGE=
X-Google-Smtp-Source: AGHT+IG0ENkGoRAv2XFTfyYLledASg8yeQV6WEFCuVbEtFlCEJIFWwU581QBunws9E5mQlHdoeVQh5wBcothZ116WlI=
X-Received: by 2002:a05:6902:15ca:b0:e7a:b192:e5c2 with SMTP id
 3f1490d57ef6-e7b3d501912mr6481642276.19.1747253287101; Wed, 14 May 2025
 13:08:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501225337.928470-1-namhyung@kernel.org>
In-Reply-To: <20250501225337.928470-1-namhyung@kernel.org>
From: Howard Chu <howardchu95@gmail.com>
Date: Wed, 14 May 2025 13:07:56 -0700
X-Gm-Features: AX0GCFuHPMQ0gNn4Bd4_zoBwRfbhq0Y3tec7aNeRJupUAz4w81z66_u9FkcNAc4
Message-ID: <CAH0uvogTqNzDd5+xxR-VaGFY0r8=TzBxcXVYN9yxj9TykF5L=A@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Support --summary-mode=cgroup
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

Just a single comment although this has been applied.

On Thu, May 1, 2025 at 3:53=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Add a new summary mode to collect stats for each cgroup.
>
>   $ sudo ./perf trace -as --bpf-summary --summary-mode=3Dcgroup -- sleep =
1
>
>    Summary of events:
>
>    cgroup /user.slice/user-657345.slice/user@657345.service/session.slice=
/org.gnome.Shell@x11.service, 535 events
>
>      syscall            calls  errors  total       min       avg       ma=
x       stddev
>                                        (msec)    (msec)    (msec)    (mse=
c)        (%)
>      --------------- --------  ------ -------- --------- --------- ------=
---     ------
>      ppoll                 15      0   373.600     0.004    24.907   197.=
491     55.26%
>      poll                  15      0     1.325     0.001     0.088     0.=
369     38.76%
>      close                 66      0     0.567     0.007     0.009     0.=
026      3.55%
>      write                150      0     0.471     0.001     0.003     0.=
010      3.29%
>      recvmsg               94     83     0.290     0.000     0.003     0.=
037     16.39%
>      ioctl                 26      0     0.237     0.001     0.009     0.=
096     50.13%
>      timerfd_create        66      0     0.236     0.003     0.004     0.=
024      8.92%
>      timerfd_settime       70      0     0.160     0.001     0.002     0.=
012      7.66%
>      writev                10      0     0.118     0.001     0.012     0.=
019     18.17%
>      read                   9      0     0.021     0.001     0.002     0.=
004     14.07%
>      getpid                14      0     0.019     0.000     0.001     0.=
004     20.28%
>

<SNIP>

> +static int update_cgroup_stats(struct hashmap *hash, struct syscall_key =
*map_key,
> +                              struct syscall_stats *map_data)
> +{
> +       struct syscall_data *data;
> +       struct syscall_node *nodes;
> +
> +       if (!hashmap__find(hash, map_key->cgroup, &data)) {
> +               data =3D zalloc(sizeof(*data));
> +               if (data =3D=3D NULL)
> +                       return -ENOMEM;
> +
> +               data->key =3D map_key->cgroup;
> +               if (hashmap__add(hash, data->key, data) < 0) {
> +                       free(data);
> +                       return -ENOMEM;
> +               }
> +       }
> +
> +       /* update thread total stats */
> +       data->nr_events +=3D map_data->count;
> +       data->total_time +=3D map_data->total_time;
> +
> +       nodes =3D reallocarray(data->nodes, data->nr_nodes + 1, sizeof(*n=
odes));
> +       if (nodes =3D=3D NULL)
> +               return -ENOMEM;
> +
> +       data->nodes =3D nodes;
> +       nodes =3D &data->nodes[data->nr_nodes++];
> +       nodes->syscall_nr =3D map_key->nr;
> +
> +       /* each thread has an entry for each syscall, just use the stat *=
/

This comment shouldn't be here.

Otherwise,

Reviewed-by: Howard Chu <howardchu95@gmail.com>

Thanks,
Howard

