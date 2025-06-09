Return-Path: <bpf+bounces-60118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCB6AD2AAB
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 01:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B0BC3AEB30
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 23:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2997F22E414;
	Mon,  9 Jun 2025 23:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCwIdhZE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4773B2327A3;
	Mon,  9 Jun 2025 23:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749512522; cv=none; b=BcEEqRYuf4HwjiUtkJ4s9Zz9Vhodr8gRkKPs+c9OV4eurbkWmbjAo1j7nfi/LvfC+UMHFcVzV9SHSyja33ygijGsE5HKLwhieu/lmjokB5y/zljTZ2flhxBX2XVn8Dn6lL/1SicvFCxudxTdn4cGncTrDSAOLS/19RunvGBFyvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749512522; c=relaxed/simple;
	bh=ZTSdagBbkHts0xMoehOnUN7zs8WComndYvcr56csSAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WwIOeFPZOjW1sTllex1q8HDiR2TkQpcQlpV/e+MYJNKmulrzBjN9ZCK3wb9N+wGae1IO/LVpX2mdCpsaGmhbI4XMv898pZHdS7Sk2yDuE3N1HN4uhZqZwQvyRZ/ELFZnkhKsXSAmWdX0zxB3g3/eMqjKYF4Q9sLzBaNOOD3CPtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCwIdhZE; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b2f0faeb994so4715648a12.0;
        Mon, 09 Jun 2025 16:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749512520; x=1750117320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDu/xCW1Ihdq8PZL5SZabsuFj2cvQfhGEggcrXsQ7rE=;
        b=mCwIdhZELAQZSRMZBPBuKOyIUjgKaFvTvPeid79uW2bcu4XjIQfbJyqHo0lR0St9gf
         FNHmLOoO70ssJ1JoeQ4lBxZV7qG1jWhgvV6QiYlhDS/wPFxnXKvpjsPFiCtbNF85Alyr
         q+zjaRWKiEqi1mQcs5is+vB4pzmYMHh+lenbs5XAJdy7jJ1x3JmVkT3BHToiDfa3vRJ6
         HFdf9rWNZF3EBoz652Gx3T9nEHSr1wz0S6uopKavG8jqN3KVbUpoUjvsJJkgXAUr3uVY
         9qwX4/IPcbBGkRA/T1h/nDZkYD+h8gU6fc9UYJnGnHDrKL9bfsYODYJD6GEu+JzB1yZn
         vRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749512520; x=1750117320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDu/xCW1Ihdq8PZL5SZabsuFj2cvQfhGEggcrXsQ7rE=;
        b=Nmq3REEOsPLR4MJ/hv82gtDZv5b/EGaBK3VjXhLWBDBzaxxCgmOFVeuRU7UZz3nRd7
         n+jeSP308PsogEKBCayRBti3Vd1jBjMSRpqOo2bKJoFmO8szHGyenEISF/rU0GYUVKBM
         BuvPOc1b5dRfFi4Gw4dwq72pyKLOcUnjS1IPnXXqL6U7NngqjHJ40YsHid/ECNsYp7X+
         KUzXrFRHLIHMP7tvPqkYPRqW92gzLEivq0hc+VfbSzjhBGvPaixrrncKyqTxm/uxg1bl
         PC+zj6+2HEysG5NbYRV/oJc10YsIFNDG4Mjb0+6tQ7X9GryqjLroc7jOqKPutobuuxxP
         u3yg==
X-Forwarded-Encrypted: i=1; AJvYcCWQKs0Bh+LuwnkeFwX/QFajNayYewjGB4sz8T9JqqpTH42y8qglzlY4dp5NKvekqfnS8dk=@vger.kernel.org, AJvYcCXTf/3DQE5vLFqpWPOn1/391wyOwb7jKDvT4agYJyHpVfGQx0rsMRUZ984XSz8uvNg3Ex/yw0bQX954E2Qr@vger.kernel.org
X-Gm-Message-State: AOJu0YwlP/l+x0CblWBAMKbHGedg8QBquNdGahXdql32xBYm7NiLlGDF
	wvzCAshlq2KMr8wsPjHK98f2yHxpJBPJ9PhTMmr/FIrv4n5AotOAFvZDmNgVaWHEeaXSdy+8UOA
	0Nqf8PQQVppaue61aB7gwUOAWfbv6YlrI/9vy
X-Gm-Gg: ASbGncvTOMMHjENq8sjfQXy0uf5oJHhiO+lZCTYWIw8Qv0roajdfOu9A9hoWLw+pnMy
	CtdPUfDYNnVXjNb/r+5gJL/FIxvRP5CTrgPLlwKepEb7siNwuq3v7yhmeYUtg/gBfz8M9POQa1i
	uuyVnk135IVLxX9USQAmvWZueZKfJqlalXuhQCnDOhUV5KM5HwA0M/nHUadFk=
X-Google-Smtp-Source: AGHT+IEtJnurstCFWmb7H9avll9OEZposn42stihqByDe8dtLGxsYKQDC0kS9NSOknf4NcSu04UmxjheTd8mJ8bDgFU=
X-Received: by 2002:a17:90b:5292:b0:313:62ee:45a with SMTP id
 98e67ed59e1d1-31362ee0466mr17460355a91.13.1749512520591; Mon, 09 Jun 2025
 16:42:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606150258.3385166-1-chen.dylane@linux.dev>
In-Reply-To: <20250606150258.3385166-1-chen.dylane@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 9 Jun 2025 16:41:48 -0700
X-Gm-Features: AX0GCFtLPtStZa98JKrEh49lDwLYcSfDasNXhp6xBuhauwYSVGBUlzqJJfwKmIU
Message-ID: <CAEf4Bzb5TU5mgVeGBrG6+v7kgJpqKO5rYMT-hdiSRgt8Vnqjkg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Add show_fdinfo for perf_event
To: Tao Chen <chen.dylane@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 8:03=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wro=
te:
>
> After commit 1b715e1b0ec5 ("bpf: Support ->fill_link_info for perf_event"=
) add
> perf_event info, we can also show the info with the method of cat /proc/[=
fd]/fdinfo.
>
> kprobe fdinfo:
> link_type:      perf
> link_id:        10
> prog_tag:       bcf7977d3b93787c
> prog_id:        20
> name:   bpf_fentry_test1
> offset: 0
> missed: 0
> addr:   ffffffffa28a2904
> event_type:     kprobe
> cookie: 3735928559
>
> uprobe fdinfo:
> link_type:      perf
> link_id:        13
> prog_tag:       bcf7977d3b93787c
> prog_id:        21
> name:   /proc/self/exe
> offset: 63dce4
> ref_ctr_offset: 33eee2a
> event_type:     uprobe
> cookie: 3735928559
>
> tracepoint fdinfo:
> link_type:      perf
> link_id:        11
> prog_tag:       bcf7977d3b93787c
> prog_id:        22
> tp_name:        sched_switch
> event_type:     tracepoint
> cookie: 3735928559
>
> perf_event fdinfo:
> link_type:      perf
> link_id:        12
> prog_tag:       bcf7977d3b93787c
> prog_id:        23
> type:   1
> config: 2
> event_type:     event
> cookie: 3735928559
>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/bpf/syscall.c | 118 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 118 insertions(+)
>
> Change list:
> - v1 -> v2:
>    - Andrii suggested:
>      1. define event_type with string
>      2. print offset and addr with hex
>
>    - Jiri suggested:
>      1. add ref_ctr_offset for uprobe
> - v1:
>     https://lore.kernel.org/bpf/20250604163723.3175258-1-chen.dylane@linu=
x.dev
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 89d027cd7ca..928ff129087 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3795,6 +3795,31 @@ static int bpf_perf_link_fill_kprobe(const struct =
perf_event *event,
>         info->perf_event.kprobe.cookie =3D event->bpf_cookie;
>         return 0;
>  }
> +
> +static void bpf_perf_link_fdinfo_kprobe(const struct perf_event *event,
> +                                       struct seq_file *seq)
> +{
> +       const char *name;
> +       int err;
> +       u32 prog_id, type;
> +       u64 offset, addr;
> +       unsigned long missed;
> +
> +       err =3D bpf_get_perf_event_info(event, &prog_id, &type, &name,
> +                                     &offset, &addr, &missed);
> +       if (err)
> +               return;
> +
> +       seq_printf(seq,
> +                  "name:\t%s\n"
> +                  "offset:\t%llx\n"

I used %#llx to have 0x prepended in front of hex values (here and in
a few other places). That seems to be what we do in other fdinfo
handlers. Applied to bpf-next, thanks.

> +                  "missed:\t%lu\n"
> +                  "addr:\t%llx\n"
> +                  "event_type:\t%s\n"
> +                  "cookie:\t%llu\n",
> +                  name, offset, missed, addr, type =3D=3D BPF_FD_TYPE_KR=
ETPROBE ?
> +                  "kretprobe" : "kprobe", event->bpf_cookie);
> +}
>  #endif
>
>  #ifdef CONFIG_UPROBE_EVENTS

[...]

