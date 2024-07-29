Return-Path: <bpf+bounces-35887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA4B93F9D2
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 17:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FD87B21A79
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 15:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAF815AAC1;
	Mon, 29 Jul 2024 15:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z6ukkpiZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0852580027
	for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 15:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722268112; cv=none; b=mM4KgYLAfjhgi9CUN6m+sMU6As7OJHRSCl1qZtQ6gGGHC86kRzi8ZHVRKc98X+xJeoF4IeWnerlzoUdVnPAvs2YoROFhIlvDLMYBc8h3Vq1kXZOQHvPgLItBYlm5EJHn8z08oL4gO0ai+i1VNNwqaK4dq2qAkou550g/ISp/00w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722268112; c=relaxed/simple;
	bh=3M44BJ/6llBRI3BY+/27BawTsfMJUQaBcNY4z9SHW/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XM1LsI3xxftqXayBLgPQWaIhlPJD+cHbdncs1fql5q1ChzTQIax7oeBQm+pnS0kXb5IaEw7GjVEU+eK94lbmkmRlxVP8WR5hp1uAuxZq9VGRBlLezX26GWtB4ZwfP8Pt0XdESoSC/y1VCQ6eV982+K7O8b0YdbYqox/gjECVyjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z6ukkpiZ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a869e3e9dfso15321a12.0
        for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 08:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722268109; x=1722872909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXhuRVtdMgKztBG06DUybwA27IR+VJWVhO/lY2CgOJc=;
        b=z6ukkpiZFX3hyMBqjeoOg2GZleki2WIOgK2D4XYceEAUEzXHCQ5vljBHfNxtkJTEh2
         tGrO18uJk5CjMMp0Nbh9R+J62o/j/p1/0hkNmnY6GIAl3lxEgdIrHaDxSE9ziaCr5wnQ
         CVTkIQx9zH0fM05603Rgy636VPNxRzIJkhqK/8Sq9OD7rE7HfWVEeULaEQ/ysSltUzV0
         RbAsijnm6SHje4ZfQvctdSOiXVfXNB/2GSMao0Y0cakr9gX+aUFc/frNOU3lPmWSvX4c
         fw6rR35qVEByhux1MYM/FHcgWqZBmIaYNfeKQncpfya2j/nE0TPMzGYMILseakonoWnv
         ESNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722268109; x=1722872909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXhuRVtdMgKztBG06DUybwA27IR+VJWVhO/lY2CgOJc=;
        b=uIgFI988Ih6ii3OS5N0snZNfZ+SizzvLbdGj5iwxsiF54EOYtKYPDX4J8Ocdswizcs
         IGNv9WX4JjRBRcAgBsv3FnaIoP0NfKI1zts7AuoidlpeZlNfl5m+9wJQ0ZDAc6LfGSTa
         kwOlt3pNqF4+qGmJQeCuCg5fq3eS5I7zmtZ+hCN+dBZTcjSScPqf5dxLlCdPJ7+OFFvD
         oD/CNyWY9qwAq1ix/jFLNWIe3q8dkq7usncshgs0e2sSfncbPhClXJkRrgpA2gAPyTjg
         bX3tbhth7Bgo043KSjsBVmWD2IisrSOYYpBh7Dy7M688ARQr46hfYsymLNktpjLNjsiw
         xUZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPS8nm4Y1YLLV4toM2KOkbPFiYQwmTmrwdqW98Ls6L1YfKOr0yqOcPyj7yA8jinHdJpeVaD9OQ4NSV4SqUCh3d1oc/
X-Gm-Message-State: AOJu0Yx/kE06iL6JVfhYjXhxgi9MBDXmNxLIZEbszk/cbXq+xRBXgga1
	rZYn9ft46kwplQ5bs2ksYENRbKYbJ/c0QaHaCLnnZJ0soAheGldlKYFHBFqleGc5at/qxx+Y6mH
	bjlxUe4iWG+rW+o/qda9flmMLdf599Ez/RoHq
X-Google-Smtp-Source: AGHT+IH7QFyGS9sG4LuxOfocsqAqv82bMTA+QSn7azu9nOm+cFz5UNLcj0gpvytnicRkd122MuYcGBq2TC00htBHepI=
X-Received: by 2002:a05:6402:350c:b0:5ac:4ce3:8f6a with SMTP id
 4fb4d7f45d1cf-5b40d4a1985mr8515a12.6.1722268108796; Mon, 29 Jul 2024 08:48:28
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627170900.1672542-1-andrii@kernel.org> <20240627170900.1672542-4-andrii@kernel.org>
In-Reply-To: <20240627170900.1672542-4-andrii@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Mon, 29 Jul 2024 17:47:51 +0200
Message-ID: <CAG48ez3VuVQbbCCPRudOGq8jTVkhH17qe6vv7opuCghHAAd3Zw@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] fs/procfs: add build ID fetching to PROCMAP_QUERY API
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	gregkh@linuxfoundation.org, linux-mm@kvack.org, liam.howlett@oracle.com, 
	surenb@google.com, rppt@kernel.org, adobriyan@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 7:08=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
> The need to get ELF build ID reliably is an important aspect when
> dealing with profiling and stack trace symbolization, and
> /proc/<pid>/maps textual representation doesn't help with this.
[...]
> @@ -539,6 +543,21 @@ static int do_procmap_query(struct proc_maps_private=
 *priv, void __user *uarg)
>                 }
>         }
>
> +       if (karg.build_id_size) {
> +               __u32 build_id_sz;
> +
> +               err =3D build_id_parse(vma, build_id_buf, &build_id_sz);
> +               if (err) {
> +                       karg.build_id_size =3D 0;
> +               } else {
> +                       if (karg.build_id_size < build_id_sz) {
> +                               err =3D -ENAMETOOLONG;
> +                               goto out;
> +                       }
> +                       karg.build_id_size =3D build_id_sz;
> +               }
> +       }

The diff doesn't have enough context lines to see it here, but the two
closing curly braces above are another copy of exactly the same code
block from the preceding patch. The current state in mainline looks
like this, with two repetitions of exactly the same block:

[...]
                karg.dev_minor =3D 0;
                karg.inode =3D 0;
        }

        if (karg.build_id_size) {
                __u32 build_id_sz;

                err =3D build_id_parse(vma, build_id_buf, &build_id_sz);
                if (err) {
                        karg.build_id_size =3D 0;
                } else {
                        if (karg.build_id_size < build_id_sz) {
                                err =3D -ENAMETOOLONG;
                                goto out;
                        }
                        karg.build_id_size =3D build_id_sz;
                }
        }

        if (karg.build_id_size) {
                __u32 build_id_sz;

                err =3D build_id_parse(vma, build_id_buf, &build_id_sz);
                if (err) {
                        karg.build_id_size =3D 0;
                } else {
                        if (karg.build_id_size < build_id_sz) {
                                err =3D -ENAMETOOLONG;
                                goto out;
                        }
                        karg.build_id_size =3D build_id_sz;
                }
        }

        if (karg.vma_name_size) {
[...]

