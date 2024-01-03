Return-Path: <bpf+bounces-18956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC14E82388F
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 23:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 473C6B24E16
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 22:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A48B1DDEA;
	Wed,  3 Jan 2024 22:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2FZABmJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B80A1EB2D
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 22:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-555aa7fd668so5472433a12.0
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 14:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704321981; x=1704926781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HIen513CvZ92bNCsDyQhtULC1oJO69XinHVNlw5C3k=;
        b=b2FZABmJ02+hm9TtxNrKqnkhpiICbywx2ab+ZWPI/OmLyr4ObOW2q0Q3DJP2Wl1R+G
         E2lwwIQMwExDlBT4GDLX2xRWQwaPP4NYGW2n6T1pAS4WPBdzJcayRrcR+0ci7CSCVvjh
         /ccUnlW3ngM7x+bRpgPB/m7WJMW0HbC5TMiDeaNM7ESOthgwcRJdnro4QhiNwamT47Xl
         6+jtE0vhD2quYfWFBwoANU24TuCicT0Fcd34mSKUqmhUou+RMzPpdK/+6zn4TbgnNP0X
         8Hpx6Fp3CpJBre/V6TbY98WIssvNG7IInmuoz/vYfff1DrTNOZTmZUMoXvjQH/JruQx1
         XUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704321981; x=1704926781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2HIen513CvZ92bNCsDyQhtULC1oJO69XinHVNlw5C3k=;
        b=ZMQMeh1AiXLlrIF45tkCZPAbxnNcMzZ70iEmA1FrIkF7w00SCDw67aXgDd6AgonD9H
         SS7x/+8Hebp8BilwJtF7TcC2FyP21TmDRBV/Vqb8DLkicuvAasTAldaA7OcMJ7FEdYnb
         e8nLMgtDiDauLLLSBVA2VkJc+COTu60YwVwyX6ajvbFhZAsYBKD0WLMDn9GJM9vSHvJX
         pHJHCX2Xtz9T4WPfXYX3lGo6x+BBRV8ndAQ/uqaVXDPe7UK25t3vHNBM0mTbLfWai816
         Q4Fiul5U6XaPCq8Wjobz1CReLMQT6oFG0gTPz0nyVojk4kSqFaL4FwDQCVuZsnqpQm0L
         KHmw==
X-Gm-Message-State: AOJu0Yyg6Pp5euCJnRxtLqbjpdVJ1QvjfTBFAGsmpHpLTRcPcJAN4too
	yPpJRKsquxb5BurdMYP8luucBpX7HJqxVNe991Q=
X-Google-Smtp-Source: AGHT+IF9Wx4KgNfLhXod3L5Mi4NKH64L7O0D1BMMLzzDYr1SkHhVoggTCoXibyFYlyml5OyuzKghFRjx5Stt9UTTOz8=
X-Received: by 2002:a50:8747:0:b0:556:38d5:9c20 with SMTP id
 7-20020a508747000000b0055638d59c20mr3179316edv.45.1704321981088; Wed, 03 Jan
 2024 14:46:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102190055.1602698-1-andrii@kernel.org> <20240102190055.1602698-6-andrii@kernel.org>
 <b40c235a580968400316d464e14a8a72f09d2013.camel@gmail.com>
In-Reply-To: <b40c235a580968400316d464e14a8a72f09d2013.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jan 2024 14:46:08 -0800
Message-ID: <CAEf4BzZSbPwWLtgDXY-=3xeHyq_R1-iEGMvSnPtXp3_EyshSnw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 5/9] libbpf: use stable map placeholder FDs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 12:57=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Tbh, it looks like calls to zclose(map->fd) were unnecessary
> regardless of this patch, as all maps are closed at the end of
> bpf_object_load() in case of an error.
>

yep, agreed

> [...]
>
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index f29cfb344f80..e0085aef17d7 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
>
> [...]
>
> > @@ -5275,13 +5289,11 @@ static int bpf_object_create_map(struct bpf_obj=
ect *obj, struct bpf_map *map, bo
> >               create_attr.btf_value_type_id =3D 0;
> >               map->btf_key_type_id =3D 0;
> >               map->btf_value_type_id =3D 0;
> > -             map->fd =3D bpf_map_create(def->type, map_name,
> > -                                      def->key_size, def->value_size,
> > -                                      def->max_entries, &create_attr);
> > +             map_fd =3D bpf_map_create(def->type, map_name,
> > +                                     def->key_size, def->value_size,
> > +                                     def->max_entries, &create_attr);
> >       }
> >
> > -     err =3D map->fd < 0 ? -errno : 0;
> > -
> >       if (bpf_map_type_is_map_in_map(def->type) && map->inner_map) {
> >               if (obj->gen_loader)
> >                       map->inner_map->fd =3D -1;
> > @@ -5289,7 +5301,19 @@ static int bpf_object_create_map(struct bpf_obje=
ct *obj, struct bpf_map *map, bo
> >               zfree(&map->inner_map);
> >       }
> >
> > -     return err;
> > +     if (map_fd < 0)
> > +             return -errno;
>
> Nit: this check is now placed after call to bpf_map_destroy(),
>      which might call munmap(), which might overwrite "errno",
>      set by some of the previous calls to bpf_map_create().
>

this should be `return map_fd;`, no need for errno, good catch, fixed

> [...]
>
> > diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_int=
ernal.h
> > index b5d334754e5d..662a3df1e29f 100644
> > --- a/tools/lib/bpf/libbpf_internal.h
> > +++ b/tools/lib/bpf/libbpf_internal.h
> > @@ -555,6 +555,30 @@ static inline int ensure_good_fd(int fd)
> >       return fd;
> >  }
> >
> > +static inline int create_placeholder_fd(void)
> > +{
> > +     int fd;
> > +
> > +     fd =3D ensure_good_fd(open("/dev/null", O_WRONLY | O_CLOEXEC));
>
> Stupid question: is it ok to assume that /dev is always mounted?
> Googling says that kernel chooses if to mount it automatically
> depending on the value of CONFIG_DEVTMPFS_MOUNT option.
> Another option might be memfd_create().

Yeah, good point, I actually don't know how reliable is /dev/null.
memfd_create() is not a bad idea, Linux 3.17+, should be fine. I'll
switch.

>
> > +     if (fd < 0)
> > +             return -errno;
> > +     return fd;
> > +}
>
> [...]
>
>

