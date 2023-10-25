Return-Path: <bpf+bounces-13203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8437D60C1
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 06:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543EC2819C9
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 04:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5F98836;
	Wed, 25 Oct 2023 04:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G/3QN55J"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EBA79FB
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 04:14:03 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1C0128
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 21:14:01 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-5068b69f4aeso1756e87.0
        for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 21:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698207239; x=1698812039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRrGdq6DFD2VOzqL31MoSC4FSnbuEPDJ3WtOuo0gpgA=;
        b=G/3QN55J/sCS0J/SfGcnPJ8kUmqO1BxPImMnbO/CxkKpmC4g8Wip4k7ozpr9UFyFXG
         KWi+EmbI/v2GFbfIzNMwJtsh2Du6XqPiAZyTBx+O9GPkh8QsMVNiIExvfvIBj/M1D4HO
         Cva3Af2meEXpOZ1xUIc2SzXto+sjyz5Vh3d/jlfvzmqLgeJxeU3cBfwqZlieLMzOrnB1
         ec9Sey1XhOcYPQKNKSj7CACiqh+HC2LBrtf0c7UPwTWkG06kEQGi3hJB/gs/77XRd8sw
         QXIRdh/TLZf1wZ0zmNGahBBVWbAL5RTUOrbPjLynQ6lO+MHv+srdet+spYjaSxQxcTdz
         0scQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698207239; x=1698812039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MRrGdq6DFD2VOzqL31MoSC4FSnbuEPDJ3WtOuo0gpgA=;
        b=WMaBHcE7iz81Icc880zt0eGCJJ14OMxn7gRsDPpx0PhYW14oI4VEQ4L0MSwmJIYAkK
         HHQbuKh4sVqUK0Iahp2CUW2q2xFaivmRbG953f3td/VDUrVjpvWgsi/PnQofHnUgjWpC
         LwYMxZYl0Gey1DGNbprYqPSduyNQ144ShCUsaKJhq9Xta+05/5gYFY+gwmItsfDpb8uX
         KTBDDiUSH2frWGb7FWuEGJaNY4evnYQlDVm6enay3H+ozmRE3japB7xeBveW10FAo76W
         iGDJ/DjIi9wzpL9m1Y1pJqYKod9avikINnV5NCUInZdMAPJP0q44TO2fznCwxQso1CrI
         c8pQ==
X-Gm-Message-State: AOJu0YzRAr6DFI+nH0aE0oqJLlpw1XmMqUt2JgZwx4X41OOuF9i1nyNi
	OyWJXZXJ9+OANIyg+X19YdqVB54Thb6Ib1JYK6RtyA==
X-Google-Smtp-Source: AGHT+IHI+KWIQoLqEN1h1L4IB/gdLFWEebU7EccylLto5kbX9M/hG4CYZ7fflDxcW6w/DV6/Ld52DD+ocQQIAgEt7pI=
X-Received: by 2002:a05:6512:360e:b0:501:b029:1a47 with SMTP id
 f14-20020a056512360e00b00501b0291a47mr17427lfs.1.1698207238852; Tue, 24 Oct
 2023 21:13:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231020204741.1869520-1-namhyung@kernel.org> <20231020204741.1869520-2-namhyung@kernel.org>
In-Reply-To: <20231020204741.1869520-2-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 24 Oct 2023 21:13:47 -0700
Message-ID: <CAP-5=fXocfgq4+7foOVvh5uFFU2xnMJLLZ+Kr93Wh3hGCCMp_A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] perf lock contention: Check race in tstamp elem creation
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 1:47=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> When pelem is NULL, it'd create a new entry with zero data.  But it
> might be preempted by IRQ/NMI just before calling bpf_map_update_elem()
> then there's a chance to call it twice for the same pid.  So it'd be
> better to use BPF_NOEXIST flag and check the return value to prevent
> the race.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
> ---
>  tools/perf/util/bpf_skel/lock_contention.bpf.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/=
util/bpf_skel/lock_contention.bpf.c
> index b11179452e19..69d31fd77cd0 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -328,7 +328,11 @@ int contention_begin(u64 *ctx)
>         if (pelem =3D=3D NULL) {
>                 struct tstamp_data zero =3D {};
>
> -               bpf_map_update_elem(&tstamp, &pid, &zero, BPF_ANY);
> +               if (bpf_map_update_elem(&tstamp, &pid, &zero, BPF_NOEXIST=
) < 0) {
> +                       __sync_fetch_and_add(&task_fail, 1);
> +                       return 0;
> +               }
> +
>                 pelem =3D bpf_map_lookup_elem(&tstamp, &pid);
>                 if (pelem =3D=3D NULL) {
>                         __sync_fetch_and_add(&task_fail, 1);
> --
> 2.42.0.655.g421f12c284-goog
>

