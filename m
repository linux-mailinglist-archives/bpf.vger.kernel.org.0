Return-Path: <bpf+bounces-67631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47179B46590
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 23:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B9D16C829
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 21:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB632EFD98;
	Fri,  5 Sep 2025 21:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbBpUEWg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266F6277035
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 21:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757107937; cv=none; b=o9AqZgmR8pw1BO2A3ZNVYM4Afc+LRllNZmjdlHGo0OmGZV26qrvF1AZjF26tEAoyyiRZPyAWFUgt5b/MWDp2H2ytLjAP4VW0xJyw8OnAaPvMXZx91/aUti0YUs1ob50By5WZngDTpS40HHbfPlh+E1RzyR3QR2HpWk+RDKfpfoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757107937; c=relaxed/simple;
	bh=okLva+SUg1zwUcU2qylooMzuRVfQOyR1iQlX5fKTuUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qQ5kD7zGC30fQVwzWNp/xTYPGa/8R7AoRvgvH/Sb72LzXGfVdruLrk5EEovLv+8xtP4q5U8nvk9zicMo3WLFM7RKVWhelGRfvCajAT09917DIQ+NcMvuVJ024W69Lxuz3rFfYlhrnpYbyX3dnFMrp48LIoG6TTkFuAlIBUVABuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbBpUEWg; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b04770a25f2so389571866b.2
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 14:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757107933; x=1757712733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCUYo8+FcZ8CrNwiHz16phCOnFZG7Upoy8ri0YP+opI=;
        b=BbBpUEWgZ6rl3cxOsgzGn0n5aFCF0n9Fffkr23Tez0TId7bfxtd3g1SC318ix38b7Z
         HXrBPW8AWz4r6mAI4bKPkrxSzg2JRDN44fWzUoQqPO8P/TI+MnNWs3mG21lvYNNKt0oa
         yya7nPwNKQaCcEpqzhGxJKgYD/WJva4M6sk0uT13Tn8dEdVedzCbRrUQT3e8MU5psuyi
         YVTISV6KqrGX61KteGJdiPLfvtNvK5smgAVGrP/1hsv6qWC09DUAvOtqUCr2TAYr+HJy
         O0bzDIkM0q2cgY0+JlG1vCSRH53VbZdBQpq5frnofIgN8fRmVvCa7C35/D/LldHlZaHr
         7zMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757107933; x=1757712733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCUYo8+FcZ8CrNwiHz16phCOnFZG7Upoy8ri0YP+opI=;
        b=JcdVh0sic2PkeWn6GZKUBGk8Cw3ivqVst7XphaHjR73D9sRqXWYRfkpPEREYC5Diol
         5sMyfqjh7RXc4Ls+2EYZosgKcF2zQsngRIF1y/HvdcQo7N50Ah1ctKWnMA1aiyMf3Jmv
         oekG5l6YMFuZGGcVpvdjZa/pGlI5TFza+zbDvPLGKLpLRL2jGthUnkCoxKFjzc/CSpyu
         5Bzpm9vCB/S2ytbxhqzXXhUBLTbisst+f1q2OYaVrvJxd8bd+O5Bk/b/WpqBmx56SoeP
         xMeNOONzOSu56kztDayUbKMgBL+d1VtkAnSsDJXjxR30aqXQXQxG2OgSQHkte8Vkez4w
         /65A==
X-Gm-Message-State: AOJu0Yw1w/7y/VdkoVtA1uora26EuJpQGCM54/B+/moX3ixaKaYzKFm5
	hCCSg507xmPbRpxTrNcS20Q/N5Me8nA8NYfQ3pGReKoOdCq9gN3kMvRzAxoCcyIFloKfHBzz3Tl
	eszs71XENb3PmUyGkTcUwCMhZluLpdkw=
X-Gm-Gg: ASbGncuwaKASZxHlqQmrT9Q17InQx1mp663v/vDfYJXft5PsR5dY8dvYH53lHcA8gL6
	YHUm2gIWmxKQbwSgkL6sVqZzL329ANQZDjJzqXWlR+I9qpLKEsoRYZOEiJT/yM/ol5mzjyobTtR
	aVWFKlVc1gt6SdM91taUwACaDH2Iz0Z+33rNPD/yW1xyJICvYbwRYxEkanFmZFgHl0+6bcjv25h
	e4QEONzMMoyUaU=
X-Google-Smtp-Source: AGHT+IFyxeCbtQzsLdjMhNwvIdHwpZNsb2Lzy1wer7wytrOHYHFlBy32krVItrcrMfKwaRdnpukNkYZOd0xqIEPtlVQ=
X-Received: by 2002:a17:907:97c8:b0:afa:1d2c:2dc7 with SMTP id
 a640c23a62f3a-b04b16e2f4emr18555466b.57.1757107933210; Fri, 05 Sep 2025
 14:32:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com> <20250905164508.1489482-8-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250905164508.1489482-8-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Sep 2025 14:31:51 -0700
X-Gm-Features: Ac12FXzqkrKFsbbT_8XwEnlSDkAruwGWJv8kwyJsYY2WcCGElFUFw6ZQOoMV5k8
Message-ID: <CAEf4BzY_pE4oZD4nQ2o1rXFxA9k+rMFgh+mGu6yeJi_xk-ft9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 7/7] selftests/bpf: BPF task work scheduling tests
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 9:45=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Introducing selftests that check BPF task work scheduling mechanism.
> Validate that verifier does not accepts incorrect calls to
> bpf_task_work_schedule kfunc.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  .../selftests/bpf/prog_tests/test_task_work.c | 149 ++++++++++++++++++
>  tools/testing/selftests/bpf/progs/task_work.c | 108 +++++++++++++
>  .../selftests/bpf/progs/task_work_fail.c      |  98 ++++++++++++
>  3 files changed, 355 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_task_work=
.c
>  create mode 100644 tools/testing/selftests/bpf/progs/task_work.c
>  create mode 100644 tools/testing/selftests/bpf/progs/task_work_fail.c
>

[...]

> +SEC("perf_event")
> +int oncpu_hash_map(struct pt_regs *args)
> +{
> +       struct elem empty_work =3D { .data =3D { 0 } };
> +       struct elem *work;
> +       struct task_struct *task;
> +       int err;
> +
> +       task =3D bpf_get_current_task_btf();
> +       err =3D bpf_map_update_elem(&hmap, &key, &empty_work, BPF_NOEXIST=
);
> +       if (err)
> +               return 0;
> +       work =3D bpf_map_lookup_elem(&hmap, &key);
> +       if (!work)
> +               return 0;
> +
> +       bpf_task_work_schedule_resume(task, &work->tw, (struct bpf_map *)=
&hmap, process_work, NULL);

oh, that struct bpf_map * cast is horrible UX, please just mark that
argument as void * in definitions of
bpf_task_work_schedule_{resume,signal}() (as a follow up, IMO, unless
something needs fixing and a new revision)

> +       return 0;
> +}
> +
> +SEC("perf_event")
> +int oncpu_array_map(struct pt_regs *args)
> +{
> +       struct elem *work;
> +       struct task_struct *task;
> +
> +       task =3D bpf_get_current_task_btf();
> +       work =3D bpf_map_lookup_elem(&arrmap, &key);
> +       if (!work)
> +               return 0;
> +       bpf_task_work_schedule_signal(task, &work->tw, (struct bpf_map *)=
&arrmap, process_work,
> +                                     NULL);
> +       return 0;
> +}
> +

[...]

