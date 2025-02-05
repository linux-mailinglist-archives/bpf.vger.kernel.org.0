Return-Path: <bpf+bounces-50518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 530FBA29511
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 16:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 282117A34B1
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 15:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEA5191F7A;
	Wed,  5 Feb 2025 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GR9hiSJ9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622FB16CD1D;
	Wed,  5 Feb 2025 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738769766; cv=none; b=mph7cnYTh1qTQVVdaWtHy4qqij6AdWSSS9o8T9TrfprT9lTWWAMHXhOSqLCLepdbWehmp1+hy+nhEFIgOjUf9Gn7kKFz7PhikgAFgTKnWMkfofI/AWzd9CvsKptRmPXyrNsxVbQKsgH/cW4R7N1W7OBy8rCq0/sQp5mHRzpzYBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738769766; c=relaxed/simple;
	bh=OJrHKp72EmWbiNNZi3CsGHTtOCW703Jj0toIqMalxvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKR5Z69Bq3dfWVyK2KttkxcnL1gCK7XoL1A6XuoHZfsRP1YHGKFTBQmlYbtqXdQRSNaiUmZlv/MwY9+m33HFHrvQDSL7URVMqgiV7X7GQOJtJRMLGgXUyH6AB6kWXA2kregy0ZdXmIrf1V/r8qVMGvPQ/tqnst0LOSytMazuD2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GR9hiSJ9; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3ce87d31480so21298335ab.2;
        Wed, 05 Feb 2025 07:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738769764; x=1739374564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RapciOTx06Hi/QDxEveN7wocKCij7PsHoQ5MJNg/ZaM=;
        b=GR9hiSJ9CkwMBbQ4NiTG7epO9rGbvsoZNRAPNdJyA0BNdsTOoORpPcKaGeeLH6ImoU
         99AeA/6isCTYoTrOoqmNb/Q6RsiPanN9B4es0bEwDfsRLOpjUWgNsu85dLoO1Yi1BZd3
         zixkfhmy3GbxJ0qIl/PA1vcBCvFtzm4FIxiq/LpKUmdm48FLFVoTBQ0PVkbqDChNelGC
         o76RbH3Mgt80MEoHNymLy9rcMySHfJU8EQEibcv/9VvCdb3c43/f5nkDFMARbQ5c411Z
         YDgtZq+mJiOu6W9MZN4segzQ0w/K8xyXQbhf9Z4dwMDjc8V15Qf3QpZW11l0WZCF3i36
         DoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738769764; x=1739374564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RapciOTx06Hi/QDxEveN7wocKCij7PsHoQ5MJNg/ZaM=;
        b=qCGoIxMrPdXnLPO9qPF4oLrG1GAiLoU3qf415t9wUnTibHBIeL+isXHt97DjbBJn89
         Ahk92RE5xZfwHguLAYYvfmJtk6EXbjXlOF7Ac9f7ZaFTgZsoYvj8FwtjGPmYXVjY4994
         5FSQSTIe7r7AMxutIMGnne9i5nsXx6JlOYsQmwxM71y39jOf4SYMhcbwn36bPlcHv5M9
         lu7WUqPVIL7OLnfJ8O9VVaxsVNXiH/ipotrdi/oVBebZ6s+cnZH6EH+RL2tiO9ARUZak
         DCCM3jF+tiXar6/jyGkTn+CbIEuxQIIuO0DCzjBGk3sCilbzhc4JYNtjcvm+Ob2K79fg
         c39w==
X-Forwarded-Encrypted: i=1; AJvYcCU9Z7l6UtD2HeERenry+r+yu2nuJDtL3ZjjFB0P9nsTNpVVnt76bv8ogUs099fGd/9A/QU=@vger.kernel.org, AJvYcCWrFpCt2mFhKKD1vQl1FA22ayJUrl/AYjo6mwi9SMiRYcMyPsKIwpkGEYmqaL5tmPp6pnBmJzOJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxD7zFH4R9aTDS7jkE+KB6K1qProUAcpB5erR/QOo6WA5ZBy1FM
	bN6yJ4/6wkpPudkPc9uO8u/u4amaxM4PDf6NKBpxVCZLZYD0s2W6LjMdZtqHhuAiUs31RWN6HQe
	gATsHaK9TXA+leoMTZm06LwWz9Mc=
X-Gm-Gg: ASbGnctSw6Du8qi0b0wy9gwlDldLDXSshW19gk9zzVMciR5faOPUXxd+o766rQ7+qCR
	3O1xltCS+lj0EyBtVe6+S2REMKVDhJWTuS/5z/9htpFEBwg3/g9usBR49HJ+mmNisUuNkiDw=
X-Google-Smtp-Source: AGHT+IEyOTharhCittwVdzFAnH6gtlgwCm7DKIFyy07n0tubJvemNmukwRvWiZWnET/2UX/LqGtrXFcd4o1ITtsIzQo=
X-Received: by 2002:a05:6e02:12eb:b0:3d0:124d:99e8 with SMTP id
 e9e14a558f8ab-3d04f47c699mr25416665ab.13.1738769764327; Wed, 05 Feb 2025
 07:36:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-4-kerneljasonxing@gmail.com> <67a382a56d206_14e083294ef@willemb.c.googlers.com.notmuch>
In-Reply-To: <67a382a56d206_14e083294ef@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 5 Feb 2025 23:35:28 +0800
X-Gm-Features: AWEUYZkrdgozCgZPVhfOrg40UZjQ40kkd8-gLXx7CCH9c01nD9IeaxFICFWe-xE
Message-ID: <CAL+tcoD4PPFy1K39z_zegxfVdOVXJrZgMSaaVBEB3KvFPX=pNQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 03/12] bpf: stop unsafely accessing TCP fields
 in bpf callbacks
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 11:24=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > The "allow_tcp_access" flag is added to indicate that the callback
> > site has a tcp_sock locked.
> >
> > Applying the new member allow_tcp_access in the existing callbacks
> > where is_fullsock is set to 1 can stop UDP socket accessing struct
> > tcp_sock and stop TCP socket without sk lock protecting does the
> > similar thing, or else it could be catastrophe leading to panic.
> >
> > To keep it simple, instead of distinguishing between read and write
> > access, users aren't allowed all read/write access to the tcp_sock
> > through the older bpf_sock_ops ctx. The new timestamping callbacks
> > can use newer helpers to read everything from a sk (e.g. bpf_core_cast)=
,
> > so nothing is lost.
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >  include/linux/filter.h | 5 +++++
> >  include/net/tcp.h      | 1 +
> >  net/core/filter.c      | 8 ++++----
> >  net/ipv4/tcp_input.c   | 2 ++
> >  net/ipv4/tcp_output.c  | 2 ++
> >  5 files changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > index a3ea46281595..1569e9f31a8c 100644
> > --- a/include/linux/filter.h
> > +++ b/include/linux/filter.h
> > @@ -1508,6 +1508,11 @@ struct bpf_sock_ops_kern {
> >       void    *skb_data_end;
> >       u8      op;
> >       u8      is_fullsock;
> > +     u8      allow_tcp_access;       /* Indicate that the callback sit=
e
> > +                                      * has a tcp_sock locked. Then it
> > +                                      * would be safe to access struct
> > +                                      * tcp_sock.
> > +                                      */
>
> perhaps no need for explicit documentation if the variable name is
> self documenting: is_locked_tcp_sock

Good suggestion. I will take it :)

Thanks,
Jason

