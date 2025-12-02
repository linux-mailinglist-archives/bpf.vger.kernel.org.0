Return-Path: <bpf+bounces-75905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FF7C9C718
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 18:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D3D03A6451
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 17:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CD32C21C9;
	Tue,  2 Dec 2025 17:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYUpz3BH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FF82C1788
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 17:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697481; cv=none; b=OaDCUBmHxBH1EWO6zndt4s+CpGNg3RAi/AQ6r5NeQ7ldmqz4uu73iLpM6u9ZP0aDxhNd9mjQk02ydmNMvI+d5ijboKFxJD7/P4ZPzsD843Ocr0OHw3g4lPpGPyBSNV4d7LOlnSui/+fzrmfP8IQyJyg0eKUFeHcgGX/pjwsrkFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697481; c=relaxed/simple;
	bh=saK7OctyxgWhisy+qF8s5lx1yaFhDmsKK8qlbKzyuWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L9F9fO1nDN4Ipjzk6X9EAEycPVvZj+mdOfkyprmDZlnbnZ9uNy6DbwozNd8AARzP9mtVwnUuXKoZpiu5zzE4fi2KgSwSvD8FvXmlsolsDf7VjX1+/NB+wqsrMLaFfTUM/AdanO/+fCa6G03cauND4kKOBBIQNcZu/c/f3HykDgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYUpz3BH; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-63f97ab5cfcso4721758d50.0
        for <bpf@vger.kernel.org>; Tue, 02 Dec 2025 09:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764697478; x=1765302278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1QXCWStMxfmVW47fiVgRuxVCfQyLhwauTimKRg96bI=;
        b=EYUpz3BHxGKJy6h+H32v9YGW3xEuPyBMFZh2HmiAMrGiyu4HiPRrpZahfcabUIuTss
         zRCPklywF8Ge4QhjiVcEok/91OLh/IV/F1sJIn++JoxaI0UQ7bDKbo+p+LWLpUe3xRZn
         IUFg+w8rM8jM0qYTb+cFgDTnPPySa62fF35sCDJZkmlqjMgzfXCCTs/hDZNQEGHalmFt
         ZpvnOAdeT+M/TvUywgyALp0EYMojDkeyVB6AnMIkNlEFxx0yDmD6m53YhiApY6cyeoU5
         HxXaldaG/NY5/eV9+Bl+Wq5dcqYe2eJ0snTZ1CiFHdSuSMHPudl3GCjPz7ZxHkRrnzZx
         c8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764697478; x=1765302278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f1QXCWStMxfmVW47fiVgRuxVCfQyLhwauTimKRg96bI=;
        b=VfM8R+YeetAFzEUpDRxAwUgZNpdOyA2wtJr/xx6I0EvlEX3PzOQKUiEW9jhH0Bkcla
         dmlGtK7GhyiL03wGlZSDNdv8DLY7dh9E9HI7JXkW+EY3ZmSX4+YaKj+o0ft3kxxU/Cwt
         sfsJwxioKUp3w9kmePPef9VXCm1uOzHe+A0BCY5chyUrhT83ta2DvWoBEZTj+sDMEjyB
         MVj5V0AcZpse3T+bC6+PYvoi0c+/Op5DW3ChUDIcUVYwkqUKkNgwjx/PjKShx/aKghGE
         N7Kuntf7ekFhrVa9oYiEj3gg8zFwFMHhxmiy0r6nZ7I5kmZq/P/tuqoWrk34RijU/dgc
         UpWg==
X-Gm-Message-State: AOJu0YzdyNl7tADERdcIfuZMIj0CX7H/3gDlYVjsbGN6lGHTnBJnGLbV
	VBYAZG8Y7FdajQgYBPZDL0OGMOjY/qGUlRWaAyM71zNSYBin3eKj2bEHJmTatUeclq/QIUT//G6
	/1DSjaMYklUJZshdqVyhJ7E5uEGUg/XE=
X-Gm-Gg: ASbGncs+sZpTVxDr2D+K6kFjLDpPAUf2kVBSlzDeV6DHSHEMZT0nWUKNWUIpDkTPYe3
	5u5vzLiCCNk0XWD8PEEH5TYZFQjBHdXjHUN+OcJoMbeqiRvUS9iN32gEshbz29scvbwQitF08JX
	xQlVvJilz/x7nheY320ai7wNGJVtHB8XTm/35Ug0mqrjDnK1FANDGzqYnJCsToem/ko2ykRdlVM
	KMS7vVEQDfYE0IWT1Uss8zT6Zn7ng7PakSfJMCV/GH25L9ER/vTsPc2/RZsRR7oTWut3J9sUe4+
	OIqtz7Mxfi4=
X-Google-Smtp-Source: AGHT+IF3T7gonVEzDbMH1IjvcZAcl2do8qpFUbUVbAiGLDEWU32llXfeCPujEBw+pJANdPjzkmUbRgZcUQJ0kyPObxc=
X-Received: by 2002:a05:690e:191d:b0:63f:c019:23ee with SMTP id
 956f58d0204a3-64329320b2fmr20274229d50.21.1764697477976; Tue, 02 Dec 2025
 09:44:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202171615.1027536-1-ameryhung@gmail.com> <CAADnVQKvRYnKME8-Q24=CqaNz24ibqfbczrRB4_BJxbNcj2oNQ@mail.gmail.com>
In-Reply-To: <CAADnVQKvRYnKME8-Q24=CqaNz24ibqfbczrRB4_BJxbNcj2oNQ@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 2 Dec 2025 09:44:27 -0800
X-Gm-Features: AWmQ_bkeUgvkkC8TtxSkopI-F7dx1MlUMA8yZ5Hhz__NeAUN7rXeWM3a2PJkCis
Message-ID: <CAMB2axN3ZyvvRLAD=xUE_VO9a9aAAYq5DV6_vym5wRTy+xNi+Q@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Disallow tail call to programs that use
 cgroup storage
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 9:32=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Dec 2, 2025 at 9:16=E2=80=AFAM Amery Hung <ameryhung@gmail.com> w=
rote:
> >
> > Mitigate a possible NULL pointer dereference in bpf_get_local_storage()
> > by disallowing tail call to programs that use cgroup storage. Cgroup
> > storage is allocated lazily when attaching a cgroup bpf program. With
> > tail call, it is possible for a callee BPF program to see a NULL
> > storage pointer if the caller prorgam does not use cgroup storage.
> >
> > Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> > Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> > Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
> > Closes: https://lore.kernel.org/bpf/c9ac63d7-73be-49c5-a4ac-eb07f7521ad=
b@hust.edu.cn/
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  kernel/bpf/arraymap.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> > index 1eeb31c5b317..9c3f86ef9d16 100644
> > --- a/kernel/bpf/arraymap.c
> > +++ b/kernel/bpf/arraymap.c
> > @@ -884,8 +884,9 @@ int bpf_fd_array_map_update_elem(struct bpf_map *ma=
p, struct file *map_file,
> >                                  void *key, void *value, u64 map_flags)
> >  {
> >         struct bpf_array *array =3D container_of(map, struct bpf_array,=
 map);
> > +       u32 i, index =3D *(u32 *)key, ufd;
> >         void *new_ptr, *old_ptr;
> > -       u32 index =3D *(u32 *)key, ufd;
> > +       struct bpf_prog *prog;
> >
> >         if (map_flags !=3D BPF_ANY)
> >                 return -EINVAL;
> > @@ -898,6 +899,14 @@ int bpf_fd_array_map_update_elem(struct bpf_map *m=
ap, struct file *map_file,
> >         if (IS_ERR(new_ptr))
> >                 return PTR_ERR(new_ptr);
> >
> > +       if (map->map_type =3D=3D BPF_MAP_TYPE_PROG_ARRAY) {
> > +               prog =3D (struct bpf_prog *)new_ptr;
> > +
> > +               for_each_cgroup_storage_type(i)
> > +                       if (prog->aux->cgroup_storage[i])
> > +                               return -EINVAL;
>
> hmm. I think AI was right that prog refcnt is leaked.

Ah right. I forgot to map_fd_put_ptr(). Will fix it in the next respin.

