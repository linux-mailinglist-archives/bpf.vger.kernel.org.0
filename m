Return-Path: <bpf+bounces-68715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD78DB82057
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 23:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8142A4AC7
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 21:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991302E0B68;
	Wed, 17 Sep 2025 21:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5v1qXSP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762DB27E041
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 21:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758145807; cv=none; b=M83xVuGB2L6R93n1SozMgT/CTibfu/75vQ1C7uivoJlE5AKBxo6Y5iqCip/WE7CLh7KQiMTsUXeUXkvAmH53/oxbXkgk7hOOojjWoVlfC8wVwQ7CKDVtaAYvMcBkBgZTY55FLA84+LpUcpuqaHjWpAb3KSZl3Molf3e9BlWt82c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758145807; c=relaxed/simple;
	bh=4lgESopTrATDhGkM0HHOQv1hTfusCPu7wtyF65k60lU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZUNrCZH0TBkvtkfhCKoIdeskw3R/gMr7iy0xgQzMwBF+MwulHy+zxifSLn8N3UoQSRlLSIXmBySlCHiVvlJphLh3j2VQzlNMMkzaFB6DW7z7GHHiGwazqYzI/nN7FZBdBjSZw8+7ucFikAv2qqM2gKC+ilrZ8Z3QsVOwzKuKXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5v1qXSP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45df0cde41bso1398445e9.3
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 14:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758145804; x=1758750604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqyrjgXOohfzh4obmtYI8xrHppF1dHYbKy8e8Ldhp6E=;
        b=d5v1qXSPiWGsi+JhBrwTpPnQyIygT50Phj7U4Ww2EqyV7BnxTEpynifJCJ6uaroNjL
         bQvHhdsI8YKnZiBuzmNEC/+eB3eBIoHQUnPwBk8k9NsMACEEgUGVu8Jt3EFE1GZ1MW1g
         pRaRFism3A1ISIi03kYi+n4pqbkmz7Kb8Oyq20NGqpks4o3gqpC9kCC/63mLUhqposdm
         aoo3mq/qzHCDdMo8GVPWwYr2Se6Ri6seqBaau5fgiPW6hCTj8tYODxrsH3tnZ03LzPjg
         WJGg01y1xbj3VUXNvuase1NJXVDh9Xwq5WEATbs/AzGrvFQV3ciggpvPBQW+fDdeCCLR
         ZFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758145804; x=1758750604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqyrjgXOohfzh4obmtYI8xrHppF1dHYbKy8e8Ldhp6E=;
        b=fEWH3Hb17If0OdenZJQIc+TR7JO5aZwuI279RcdNlDJII/pFeT0cCMfiha4ZBvxPe9
         NY7VGjfKAR9ROBNPmwdGQwsDUcnBAOpDt90ha1BLBwlPRrVBH9sLdl2TKt+UuLlCzP/J
         TrDqTW2zQYsshTQ0vLkMjv1WfMIM1hS+DFcBiYGkgLeUWfuHNQvLJkZnCJ8S/oOThVSX
         x3RfnQaVund92DQe/V4cLA/vD0a+QIN0XmRmmtxigHXDkV0H0/Pj0oQDLwvnp3JRksDi
         ha+ciRs1IdsEzq4rUsj33/RbtWyt9LHaLwvRHVQqdsGQpobc6nJze/ceUYIRXP+8P1Wi
         Frgg==
X-Forwarded-Encrypted: i=1; AJvYcCUes+UTYQ9515AdUSchRLJIwSOjX66rs/aGw3LA0uDFsb6y96nwZma+iks9dWG0nanV4Co=@vger.kernel.org
X-Gm-Message-State: AOJu0YwofqRErj6Iy6FDAh8o73mFStDrUxMTh0GNPsXpFl0QkxX3zACH
	uoGyO1jrsxDM9EMH2UChsm4xjupM6l7BA0d207pOP4DbyIRsmCCjMi2DaxlfjLZtpsbSe0Q7e0O
	ObLxbatggj1svBATSjBnWIkEyVH+6Rk0=
X-Gm-Gg: ASbGncti6UDdqBMN0DJrxk4PoPu2Lt+0GjSVD5IkZVO16YqgUQGxpu9ClrQNubvOR7r
	BwbhVezxlqS0DNR+g35vLjkVwF3NNgiKmvoInQPFqEYx/lHG2tOtKt6iIh0xBsU42VrNfUyGqIC
	iCYCqpshhf9KK16O5dwDLxjmRg8rsXhjRRf9RrVNn7t+v8WhwbdyYXjy5c25DW8tipQQZ0Ei+J2
	aZqhcs1vwvxV+e82BaZMHKmpLrE/zpiFrN3YqEUCAahePYzJWvmRC2O5lK0dUWDLA==
X-Google-Smtp-Source: AGHT+IFOmXDz/6HEDppxlX6lw8jk6v4WCjSVEdlxI5kZrFWo2D6v7EPGhoJn2DsPRNCAi1P88d0+Xjgx+0QmHfdlik0=
X-Received: by 2002:a05:600c:354c:b0:459:dde3:1a55 with SMTP id
 5b1f17b1804b1-46205cc8649mr40182685e9.24.1758145803653; Wed, 17 Sep 2025
 14:50:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911163328.93490-1-leon.hwang@linux.dev> <20250911163328.93490-5-leon.hwang@linux.dev>
 <CAEf4BzbX_j5guUYuNNgR4dANR11tzLriDGOCOfxS9zRFmQdi7g@mail.gmail.com>
In-Reply-To: <CAEf4BzbX_j5guUYuNNgR4dANR11tzLriDGOCOfxS9zRFmQdi7g@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 17 Sep 2025 14:49:52 -0700
X-Gm-Features: AS18NWAnG-SyKqAAMqnT2Sd0NnjIYQsc1OPd9CMMXv8-BAduayyUxZmNlpKfWM0
Message-ID: <CAADnVQLHk0iMweeFQZJONbjDLBfSXnJkT0-KFNPukqzEHbuxXw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 4/6] bpf: Add common attr support for map_create
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Menglong Dong <menglong8.dong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 2:39=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Sep 11, 2025 at 9:33=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev>=
 wrote:
> >
> > Currently, many 'BPF_MAP_CREATE' failures return '-EINVAL' without
> > providing any explanation to user space.
> >
> > With the extended BPF syscall support introduced in the previous patch,
> > detailed error messages can now be reported. This allows users to
> > understand the specific reason for a failed map creation, rather than
> > just receiving a generic '-EINVAL'.
> >
> > Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> > ---
> >  kernel/bpf/syscall.c | 82 ++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 63 insertions(+), 19 deletions(-)
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 5e5cf0262a14e..2f5e6005671b5 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -1340,12 +1340,13 @@ static bool bpf_net_capable(void)
> >
> >  #define BPF_MAP_CREATE_LAST_FIELD map_token_fd
> >  /* called via syscall */
> > -static int map_create(union bpf_attr *attr, bool kernel)
> > +static int map_create(union bpf_attr *attr, bool kernel, struct bpf_co=
mmon_attr *common_attrs)
> >  {
> > +       u32 map_type =3D attr->map_type, log_true_size;
> > +       struct bpf_verifier_log *log =3D NULL;
> >         const struct bpf_map_ops *ops;
> >         struct bpf_token *token =3D NULL;
> >         int numa_node =3D bpf_map_attr_numa_node(attr);
> > -       u32 map_type =3D attr->map_type;
> >         struct bpf_map *map;
> >         bool token_flag;
> >         int f_flags;
> > @@ -1355,6 +1356,18 @@ static int map_create(union bpf_attr *attr, bool=
 kernel)
> >         if (err)
> >                 return -EINVAL;
> >
> > +       if (common_attrs->log_buf) {
> > +               log =3D kvzalloc(sizeof(*log), GFP_KERNEL);
> > +               if (!log)
> > +                       return -ENOMEM;
> > +               err =3D bpf_vlog_init(log, BPF_LOG_FIXED, u64_to_user_p=
tr(common_attrs->log_buf),
> > +                                   common_attrs->log_size, NULL);
> > +               if (err) {
> > +                       kvfree(log);
> > +                       return err;
> > +               }
> > +       }
>
> what if we keep bpf_verifier_log on stack? It's 1KB, should be still
> fine to be on kernel stack, no?

1k is a lot. I'm pretty nervous about stack usage. kmalloc is cheap.
Let's use it. I'd drop 'v' part. There is no way it will fallback
to valloc() even if we double BPF_VERIFIER_TMP_LOG_SIZE in the future.

