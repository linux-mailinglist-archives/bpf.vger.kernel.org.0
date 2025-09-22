Return-Path: <bpf+bounces-69242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F31C6B92263
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 18:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD06C16EB19
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 16:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7309D2E8B74;
	Mon, 22 Sep 2025 16:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzhjT8vK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2B930DD0E
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557640; cv=none; b=YdNvY7tRMSHKlwU47QrPTcWSg3rP7F/oZcphX7yVCo65za55Xf4gwkHEq0rbX7UcFrqjlAEiu8Ezmcb1S5zV4fB0BRvTIiCZQRFMqXaGVbjt3r06JfVIHqd/B50F2Tn7tIrQth8qXvdaTSGcYdoM4SXJNf4f5t4pzx37j6QJtHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557640; c=relaxed/simple;
	bh=rhU1EkqA5p7stFHqmVeFq5bD3W2ZGIzF1O0/+YaG3D4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYgsdw76z8rtzygvLmdPGNLKjNGmqEZyuhW8J3xy5cwIWuSmawO9DZ4aYNZrrDTDnEv3bA30rTx7UwI1UlVlbLQgZwiX31qMnro5VBvwd3KMs5DN61dkZhARz3Ze/RJFBa7seNAy7B80NU3qBfzarkSjqgil7CVcoTUugQeAgxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzhjT8vK; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-32b8919e7c7so5174801a91.2
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 09:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758557638; x=1759162438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmsic5OB/cDHdMmcKpW0RUCraKQS5ZGd9mFKkXSwuLc=;
        b=AzhjT8vKklr9FoS8nr1ug/5q6QWCBTkVEQnaPV1hj/hUNpKePls88itYGpx1Tuzfel
         UyAC+UJIMeeWr4ENi1vWCtPPEkNWtloQbmGAxay+RBt21XdNFJFnxrCQcWLL2WUlLDC/
         17KqG4tLOOeJahNzp3T87Kj9FB78O2ul7gdYqbyDBTavhH0jdIiYXLjG8a619pVg1trq
         EwtRawZF7sm3RRjekCs/R8VbSw10urMXwSwsf/lyMF+gsG/DryV8MVwiczH6j3N63V8A
         EqogYGKvyGGTGgT2qCK8T1dbTlB0/1gMgQVslo0ybRY3rTYVSxy8wxJgGnM3xGdJVMDW
         29mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758557638; x=1759162438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmsic5OB/cDHdMmcKpW0RUCraKQS5ZGd9mFKkXSwuLc=;
        b=WVJ5Leh3T48aj7XiqBVxaljO470dysSXHuthO2R9gN+B8x9+Q/I0xr3S7+DCZfyUH2
         dcODA8aDcZPIbxok8Dx6EMHA4QZ9P8bXva6B+ug3/4LT71GeXvNaJQzPleSgrhQ2cLVH
         Jtyte+b6GL7TJCfc9rZBr177lCA4TS6/UwzdIBpX/XLGxNuhljp1njCvXPOdgjOqWyOU
         UcYoekEtsPBTNjT4yYH6P47phEXIaRzz+gqsRT4eUNBcGc3EHsT4hHhclphpxJzi9G7X
         D7dxujREltWWb4lY++FoTu2roEKD7grH1qP1+rfIQC1bI8trjNU+CcBW3/2sqyzXFTG6
         AxcQ==
X-Gm-Message-State: AOJu0YwwKR71a9yt93WuYFm4k9++MF/aTN0S2on3DdS058FV/U8hIIwZ
	gmBW6ZLkp86M5sU84RePhJ+Wa2cmzMIPxLGjCEvfRpY8CKRu+AHh+PZUxY13erufGOoGnYJGJXy
	PvhQjqq60YEveVIV9nKPNSe2O6mMlB5o=
X-Gm-Gg: ASbGncvrCpsYpZ2aVLUCPtqjvEA8Ep2k2vaOjUnJVMb83SBjUqnEf/Bfm6sejIAMbk+
	bqYQJUCXjuYCfZk2TcGrkoVfB5QGmCFlQ9ktUjlU/qvg/IaCMYROBN5fRxAlwumKJSEoJOyU+6Z
	4yPyFftSptEp5qGDt/KvvVYAnqXazzTABilyMbRy3PK8wIMLWoHdvFuvBS63HVcxS9CY9JvYvxf
	ZWLk9QHfk/GlzyaDlRaiH+Pv7XKh7q7QA==
X-Google-Smtp-Source: AGHT+IEcdCyUUJlvhe2PgVY5uYhm5D26IyS6YaWyyTFe8pdOHx+N30lXCGhExBjfe8/1w49wadzJCsO45TC5OYaXdyo=
X-Received: by 2002:a17:90b:2b48:b0:32e:87fa:d95f with SMTP id
 98e67ed59e1d1-3309838e014mr15496482a91.32.1758557637530; Mon, 22 Sep 2025
 09:13:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910162733.82534-1-leon.hwang@linux.dev> <20250910162733.82534-5-leon.hwang@linux.dev>
 <CAEf4BzZJ3fEd6EaBV5M8QX=bTtL7bx0OM1E3o5HAgCemfuFQEQ@mail.gmail.com>
 <40840553-6c0a-494d-8429-863c4a6608f9@linux.dev> <CAEf4BzYTse1=pAYcM6y_vKbm74ZDtSu2Daj3sLewvKz16WF9NA@mail.gmail.com>
 <DCZEVCZLG1IW.2MPQVMF4L3D91@linux.dev>
In-Reply-To: <DCZEVCZLG1IW.2MPQVMF4L3D91@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 22 Sep 2025 09:13:40 -0700
X-Gm-Features: AS18NWBCnz3iXJVuISS4fWM9lRZ9iQLLstP8_3Bf3lSWO8aRK1mJkvuHoqpBXw4
Message-ID: <CAEf4BzY8zPBbmjP6ooihyeqeJGdfgdh9KiW3XQGqv1qYWcefXg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 4/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
 flags support for percpu_hash and lru_percpu_hash maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, jolsa@kernel.org, yonghong.song@linux.dev, 
	song@kernel.org, eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 7:50=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> On Sat Sep 20, 2025 at 6:31 AM +08, Andrii Nakryiko wrote:
> > On Thu, Sep 18, 2025 at 10:25=E2=80=AFPM Leon Hwang <leon.hwang@linux.d=
ev> wrote:
> >>
> >>
> >>
> >> >> @@ -1724,7 +1742,7 @@ __htab_map_lookup_and_delete_batch(struct bpf=
_map *map,
> >> >>         value_size =3D htab->map.value_size;
> >> >>         size =3D round_up(value_size, 8);
> >> >>         if (is_percpu)
> >> >> -               value_size =3D size * num_possible_cpus();
> >> >> +               value_size =3D (elem_map_flags & BPF_F_CPU) ? size =
: size * num_possible_cpus();
> >> >
> >> > if (is_percpu && !(elem_map_flags & BPF_F_CPU))
> >> >     value_size =3D size * num_possible_cpus();
> >> >
> >> > ?
> >> >
> >>
> >> After looking at it again, I=E2=80=99d like to keep my approach.
> >>
> >> When 'elem_map_flags & BPF_F_CPU' is set, 'value_size' has to be
> >> assigned to 'size' ('round_up(value_size, 8)') instead of keeping
> >> 'htab->map.value_size'.
> >>
> >
> > isn't that what will happen here as well? There is
> >
> > size =3D round_up(value_size, 8);
> >
> > right before that if
> >
>
> As for percpu maps, both 'size' and 'value_size' need to be 8-byte
> aligned here, because 'map.value_size' itself is not guarenteed to be
> aligned.
>
> In 'htab_map_alloc_check()', there is no alignment check for percpu
> maps.
>
> So 'map.value_size' can be unaligned.
>
> Let's look at how 'value_size' is used:
>
> values =3D kvmalloc_array(value_size, bucket_size, GFP_USER | __GFP_NOWAR=
N);
> dst_val =3D values;
> hlist_nulls_for_each_entry_safe(l, n, head, hash_node) {
>         if (is_percpu) {
>                 if (elem_map_flags & BPF_F_CPU) {
>                         copy_map_value_long(&htab->map, dst_val, per_cpu_=
ptr(pptr, cpu));
>                 }
>         }
>         dst_val +=3D value_size;
> }
> copy_to_user(uvalues + total * value_size, values,
>              value_size * bucket_cnt)
>
> Here, 'value_size' determines how values are laid out and copied.
>

So in my mind (and maybe it's wrong, tell me), BPF_F_CPU turns a
per-CPU map lookup into an effectively non-per-cpu one. So I'm not
sure we need to do 8 byte alignment of value/key sizes when BPF_F_CPU
is specified.

But if people would like to keep 8 byte alignment anyways for
BPF_F_CPU, that's fine too, I guess.

> As a result, when 'is_percpu && (elem_map_flags & BPF_F_CPU)',
> 'value_size' must be assigned to 'size' in order to make sure it's
> 8-byte aligned.
>
> Thanks,
> Leon

