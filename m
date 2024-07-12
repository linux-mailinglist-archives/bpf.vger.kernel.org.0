Return-Path: <bpf+bounces-34696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128FC930188
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 23:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE1442829EF
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 21:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C014E49655;
	Fri, 12 Jul 2024 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRujuvTb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7475481C4;
	Fri, 12 Jul 2024 21:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720819309; cv=none; b=g4RtsRZdQ9TylKXWFQlu1R3swA7JlUXlH8D1I16fhWJw2M9y11Xkz/fjCgrdA+/SPVzpAuAm9J8nlHx5dO4bOLwLg4HfZ7GWZSv8IZuLmosj6gucsgEDBljbFV1xqPla6jEA5x5luV4G6aT08/7RKDuPJ3Vhfn91+csvuOzBwlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720819309; c=relaxed/simple;
	bh=v+xXYnxlsAxleAOTA1ncvDt5Xi1Xg9rGIfFCOE4Ol2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGrYKJ/zCBdo7NOIt4Gxe6bt6RsMjPntBDHraW1CubvnpuqYnDuM9QSXCDVP2HDHcHQJKktdrWHSOc2V4y7Hxp85k34Fs8QRnJEg5ag6GGi1HR4sKsIpruzn809xjJpYDLPeLJvemxTygJyGrN0GqrVUWCRT4X7pfD+4w2sq43M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRujuvTb; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c2dee9d9cfso1868965a91.3;
        Fri, 12 Jul 2024 14:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720819307; x=1721424107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y24z6qGDcPXhbPxvOoVUfJxIvbX7B5X90OmhrVqoPw4=;
        b=GRujuvTbE++iVbpT/mLSbs9WtXpjfbCXLOribxL5+b9qGcAP5Oflz18mm+tX2bNclw
         GLygEPoOiPL9GIBpgFr5QnHvdUROPl6hczaLMtyhe4kYqGLjfxX4nfzQ6OoXRfxgz0HG
         3udOtvGA0XlJXm5IdYwNSgRDqyL9R5fu2GgFuZFvDTfJijOGZhh1GnLcsNRVJbDDUSkP
         OWzVv5Oul/STXnWWiCgZmbx1DOxm9hexrX/ROHfig9aFgh7J0XNtZiiBlooGhSaRDSWO
         m8Xja4KFJeXDqJKywuXQVi6C0TlAhGh+fLncJ48ZwUeM2C6A8m6/SX2hc9mumfOZ9iFa
         iN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720819307; x=1721424107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y24z6qGDcPXhbPxvOoVUfJxIvbX7B5X90OmhrVqoPw4=;
        b=Ssi1osDlKPaJV2nmIRfsYyrhdVboqu9qNz1mI8o/7q9ZfhiFrxTpqa1+DaIuhSwojM
         xIezsoinZ5WEp4VlFJAHFPfMhNbKzJQrSujtW5bfr230kNxl6CwBMIN80FMu73twrNKc
         KAbF4VPNsF0m9FLFWvBbpb9Y0mV6DhgWgWJ08Si0JwIi1gX7FV9OJX5H0b0bvj2v8xJp
         RxcZTyyLsRyAbi7U9bxnLT/fFjm5VEbuLd7Gn6sj3UBHfPb7q324AHau9h8f2mp3wcQ6
         qmT3D4DLQk704QEHqBdOBmy/IBs/W108dWpmYY0ZVBWCXBxKlao6qyltdg+rfhA6XQnr
         TLxg==
X-Forwarded-Encrypted: i=1; AJvYcCVqeDP+ytK99n56H8ErjQ+EwpLMHy/0mhITNxx01slgJOo9zStY9XNblAajjMBRkCQsCNR8S6bUboq+uZ6nvrY4n1YmSiZQrYuj+tQrnDNVN6f+zhOorwSlZmeqteROi+pioCtUId1flzN+AFzd4S+0CcXji6SWiYb+9YzxQMfIoqWP9Lan
X-Gm-Message-State: AOJu0YwqST441PxbYtQcLYGcBD5fPwdy2xzj8lnzzD5P3l1HP9pawLbF
	Kzfjxg9t9foy3lRnlNwfSkkpiGx9vcaucbTyk1Cmij78TPD310iHiJunVh60T8GKABqtJk5ngXL
	84hTQiD+zXKMAdH9uH4rt/lzxHh8=
X-Google-Smtp-Source: AGHT+IHxt/alBNukSln4XzuPDvUKYqFRc6yKjlD0M68iVlDQJwJsU+oEfZZVlVTmJDE/w0RwnJS7ML9pcS/f8E6jmpA=
X-Received: by 2002:a17:90b:4f4b:b0:2ca:7f1f:9ae5 with SMTP id
 98e67ed59e1d1-2ca7f1fa19emr6760289a91.19.1720819307246; Fri, 12 Jul 2024
 14:21:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711110235.098009979@infradead.org> <20240711110401.096506262@infradead.org>
In-Reply-To: <20240711110401.096506262@infradead.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 12 Jul 2024 14:21:34 -0700
Message-ID: <CAEf4BzazYsP9uDJfwJJRP6wscgDo8tJpK2vp7eAWS2ca_KQvsA@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] perf/uprobe: Convert (some) uprobe->refcount to SRCU
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, andrii@kernel.org, oleg@redhat.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, jolsa@kernel.org, clm@meta.com, 
	paulmck@kernel.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ bpf

On Thu, Jul 11, 2024 at 4:07=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> With handle_swbp() hitting concurrently on (all) CPUs, potentially on
> the same uprobe, the uprobe->refcount can get *very* hot. Move the
> struct uprobe lifetime into uprobes_srcu such that it covers both the
> uprobe and the uprobe->consumers list.
>
> With this, handle_swbp() can use a single large SRCU critical section
> to avoid taking a refcount on the uprobe for it's duration.
>
> Notably, the single-step and uretprobe paths need a reference that
> leaves handle_swbp() and will, for now, still use ->refcount.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/events/uprobes.c |   68 ++++++++++++++++++++++++++++-------------=
-------
>  1 file changed, 41 insertions(+), 27 deletions(-)
>
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -51,7 +51,7 @@ static struct mutex uprobes_mmap_mutex[U
>  DEFINE_STATIC_PERCPU_RWSEM(dup_mmap_sem);
>

[...]

> @@ -1982,22 +1990,31 @@ pre_ssout(struct uprobe *uprobe, struct
>         if (!utask)
>                 return -ENOMEM;
>
> +       utask->active_uprobe =3D try_get_uprobe(uprobe);
> +       if (!utask->active_uprobe)
> +               return -ESRCH;
> +
>         xol_vaddr =3D xol_get_insn_slot(uprobe);
> -       if (!xol_vaddr)
> -               return -ENOMEM;
> +       if (!xol_vaddr) {
> +               err =3D -ENOMEM;
> +               goto err_uprobe;
> +       }
>
>         utask->xol_vaddr =3D xol_vaddr;
>         utask->vaddr =3D bp_vaddr;
>
>         err =3D arch_uprobe_pre_xol(&uprobe->arch, regs);
> -       if (unlikely(err)) {
> -               xol_free_insn_slot(current);

let's keep this here, because you later remove err_uprobe part and
err_xol is only jumped to from here; it's better to just drop err_xol
and err_uprobe altogether and keep the original xol_free_insn_slot()
here.

> -               return err;
> -       }
> +       if (unlikely(err))
> +               goto err_xol;
>
> -       utask->active_uprobe =3D uprobe;
>         utask->state =3D UTASK_SSTEP;
>         return 0;
> +
> +err_xol:
> +       xol_free_insn_slot(current);
> +err_uprobe:
> +       put_uprobe(utask->active_uprobe);

utask->active_uprobe =3D NULL;

let's not leave garbage in utask (even if you remove this later anyways)

> +       return err;
>  }
>
>  /*

[...]

