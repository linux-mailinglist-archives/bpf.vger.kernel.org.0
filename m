Return-Path: <bpf+bounces-39757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3797976FE3
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 19:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4714E1F25466
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 17:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC181BF336;
	Thu, 12 Sep 2024 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrpAMqQ/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54048149C50
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 17:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726163985; cv=none; b=YfcC+rahEd74Q9pR/IMqoir5BUinsedakkVhPZHNwPZOS6Tzar0dHzlBtGHKhXkCRju2fDBkuX6Tj9VvT5tmwiiHmpx0Ue3OktzQ6BLh/v2ifVZixM/iXqX83Qprpa2AIPU9k/QOzlXhFdYQklaWFCwf0vzREMmboWQvbZzBbA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726163985; c=relaxed/simple;
	bh=bJSW95k4SI9TqyKRmpnTh4QHPlMKq51/JTTOWXfr0fQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2kK0MafUnQlo44Lc2yin9qbbgqyJSFcp1XYcv13rF+JhO9QzHVuDERt0GPv6tHwfC5s7cfFh3DiPpI+g2isVDQeZ7v3WujgyHrkccaEbUE0xtEgvcW+FlaDzu0Rwx7MT0MU8pOTZAUDtu6G6dmraIgepsc3vfz3OsJjmPT8Bg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrpAMqQ/; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2053616fa36so15123655ad.0
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 10:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726163983; x=1726768783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36hDrNEGkVjRxMXLT0Bx+OvHmCCXvAQjZdWAQF9RF3c=;
        b=BrpAMqQ/sb2dRYdIdybsFe8fMmKnXrTauYFkMeP+6vT3slJDQztgNDIYCZ7yhYEEEN
         h8gOdqykjyITvzEqtUacHdL/SeM6ynMhMEKN0R+vnjOLJO3cwiYankwa0+4+exCxRev3
         W/mUUGK3C6RHvxbmPkn/IqnrmBQujryuapO7+yys14FPqHvUXy/wZowFqIc9eKTk3jbe
         twBK7W8Nb01aWwbjHmITjXDGo+3qAjjhAnDRbTYtnLmChk9+rhKXSOr2bEMoKqUmDjiv
         xkAxCu4Stq7vF+4AXKU4U9sNitbnNCQMLjh/KJ5NRaUXwADpepizdtypu0r4cewP9Onf
         wngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726163983; x=1726768783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36hDrNEGkVjRxMXLT0Bx+OvHmCCXvAQjZdWAQF9RF3c=;
        b=snl9/lrPwPKN05ZYD47Cs95NAvEsoMs2o1kvzWFDWGnPopS93SPXLK/12kDAcOVoof
         1EWfVlQF/sVIyZw7HtPYs/xdV9Y3B6YEJMQ8g5X6TScWV7jqRJr0E9RuZe9LjcY/8gaN
         tSeB/3J7XV8trwpxhC9V6hFvY4HDdVy0lrVgDgQY0KM/VOC5F4tHlxtWO90cjgVt/26X
         gVVCd+n0i6T+crynSJwWFVg3BrSPnFmMvUd/F3aIO1LCPT8QHKD2im1rkio6M+wbtStQ
         aHFXtictpecTRTn6HwvNZgfPNLdemLZq6NbjtQPQ7BGhRk1IXCGtyBHcJlljmQPEQ5QY
         iqrw==
X-Forwarded-Encrypted: i=1; AJvYcCWtTwyy3HOOUQkXmjMjADfawOEhO+JvVeKyQnpzf4yyJVP8pgh2YodW4A43sbU/qMo/S/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynspl2wm5EXLAjVcmFqMEYrJG9z1wFOBK7xdz4PxhNXzXQLPTQ
	NiUk/ZparnoxBIl2Y7WdZpSl87jnliOAPFCg68vs9qORwPYCKRXg7D9/Z8qAvwN1aYcEkWkf8qX
	1lu3gLnLtei9BdwkrFHYyxJS5LbY=
X-Google-Smtp-Source: AGHT+IGgBehpAhsM18ThhZx5XBj7hqvjDVeOorjbSrWJVL1PC4XIT8mau41VB/9ACMWBdRNPwyeLnk2q+TaydN7sTdQ=
X-Received: by 2002:a17:902:e5c3:b0:205:709e:1949 with SMTP id
 d9443c01a7336-2076e421fd0mr57553175ad.57.1726163983510; Thu, 12 Sep 2024
 10:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906135608.26477-1-daniel@iogearbox.net> <20240906135608.26477-5-daniel@iogearbox.net>
 <CAADnVQ+GSCAPC7v787c4poFY4ku=L9q1cn1d=A3YhVRUomoVrQ@mail.gmail.com>
 <fb38bb54-c59b-ba36-821f-f7dfcaa390cc@iogearbox.net> <a86eb76d-f52f-dee4-e5d2-87e45de3e16f@iogearbox.net>
In-Reply-To: <a86eb76d-f52f-dee4-e5d2-87e45de3e16f@iogearbox.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Sep 2024 10:59:31 -0700
Message-ID: <CAEf4BzbYwfEaoG8TQrncjeG6RSD5TO04baAM=t9aqShVnbn8vg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 5/8] bpf: Zero former ARG_PTR_TO_{LONG,INT}
 args in case of error
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, kongln9170@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 2:47=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 9/9/24 2:16 PM, Daniel Borkmann wrote:
> > On 9/7/24 12:35 AM, Alexei Starovoitov wrote:
> >> On Fri, Sep 6, 2024 at 6:56=E2=80=AFAM Daniel Borkmann <daniel@iogearb=
ox.net> wrote:
> >>>
> >>> -       if (unlikely(flags & ~(BPF_MTU_CHK_SEGS)))
> >>> -               return -EINVAL;
> >>> -
> >>> -       if (unlikely(flags & BPF_MTU_CHK_SEGS && (len_diff || *mtu_le=
n)))
> >>> +       if (unlikely((flags & ~(BPF_MTU_CHK_SEGS)) ||
> >>> +                    (flags & BPF_MTU_CHK_SEGS && (len_diff || *mtu_l=
en)))) {
> >>> +               *mtu_len =3D 0;
> >>>                  return -EINVAL;
> >>> +       }
> >>>
> >>>          dev =3D __dev_via_ifindex(dev, ifindex);
> >>> -       if (unlikely(!dev))
> >>> +       if (unlikely(!dev)) {
> >>> +               *mtu_len =3D 0;
> >>>                  return -ENODEV;
> >>> +       }
> >>
> >> I don't understand this mtu_len clearing.
> >>
> >> My earlier comment was that mtu is in&out argument.
> >> The program has to set it to something. It cannot be uninit.
> >> So zeroing it on error looks very odd.
> >>
> >> In that sense the patch 3 looks wrong. Instead of:
> >>
> >> @@ -6346,7 +6346,9 @@ static const struct bpf_func_proto
> >> bpf_skb_check_mtu_proto =3D {
> >>          .ret_type       =3D RET_INTEGER,
> >>          .arg1_type      =3D ARG_PTR_TO_CTX,
> >>          .arg2_type      =3D ARG_ANYTHING,
> >> -       .arg3_type      =3D ARG_PTR_TO_INT,
> >> +       .arg3_type      =3D ARG_PTR_TO_FIXED_SIZE_MEM |
> >> +                         MEM_UNINIT | MEM_ALIGNED,
> >> +       .arg3_size      =3D sizeof(u32),
> >>
> >> MEM_UNINIT should be removed, because
> >> bpf_xdp_check_mtu, bpf_skb_check_mtu will read it.
> >>
> >> If there is a program out there that calls this helper without
> >> initializing mtu_len it will be rejected after we fix it,
> >> but I think that's a good thing.
> >> Passing random mtu_len and let helper do:
> >>
> >> skb_len =3D *mtu_len ? *mtu_len + dev->hard_header_len : skb->len;
> >>
> >> is just bad.
> >
> > Ok, fair. Removing MEM_UNINIT sounds reasonable, was mostly thinking
> > that even if its garbage MTU being passed in, mtu_len gets filled in
> > either case (BPF_MTU_CHK_RET_{SUCCESS,FRAG_NEEDED}) assuming no invalid
> > ifindex e.g.:
> >
> >    __u32 mtu_len;
> >    bpf_skb_check_mtu(skb, skb->ifindex, &mtu_len, 0, 0);
>
> Getting back at this, removing MEM_UNINIT needs more verifier rework:
> MEM_UNINIT right now implies two things actually: i) write into memory,
> ii) memory does not have to be initialized. If we lift MEM_UNINIT, it
> then becomes: i) read into memory, ii) memory must be initialized.
>
> This means that for bpf_*_check_mtu() we're readding the issue we're
> trying to fix, that is, it would then be able to write back into things
> like .rodata maps.
>
> My suggestion is for this series is to go with MEM_UNINIT tag and
> clearing on error case to avoid leaking, and then in a subsequent
> series to break up MEM_UNINIT in the verifier into two properties:
> MEM_WRITE and MEM_UNINIT to better declare intent of the helpers. Then
> the bpf_*_check_mtu() will have MEM_WRITE but not MEM_UNINIT.
>
> Thoughts? (If preference is to further extend this series, I can also
> look into that ofc.)

We have MEM_RDONLY which literally means that memory is meant to be
only consumed for reading. Will this solve these issues?

>
> Thanks,
> Daniel

