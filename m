Return-Path: <bpf+bounces-45452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBFC9D5AE4
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 09:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806E9284E79
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 08:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7688718A6BF;
	Fri, 22 Nov 2024 08:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TkAUmVtG"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1CF1632C6
	for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 08:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732263423; cv=none; b=mF7/4XBSfKi246fr4cTz7Oy52Enu7Kv4lSFiirAoPUM84Sux9JSvNdVZwMf79i3fz7Jc0VqSoZApbzHfoJZ35Ha2lPMPmlzau3+euMZPlJ/xWFTFYl54mpD/+tMcf+DCQA/bit3wmoG7E466aQZmsh6RUa33cWf4IKqjKUZsjpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732263423; c=relaxed/simple;
	bh=xk0Fp0+bN6FKayBAYjalWJTCWsFsWEGxzuF72NhSP38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=phYG4FkZzkxvfWNwdzs7TqXrI4HvEYOCanCuR+ourQ2u8DADMnG2Uf8bd/PzhsIIMI9EgJe+Gb32sYkasvGOn+Sjrc+Gzbg1yI8WfycB1Wzmk3vKvb0aJDWEHocfRh8vpjxXauE9yuvkSmeuY/fll8fB84Gk7zCqRJxkcSh1d7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TkAUmVtG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732263420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SL5pNnDPsbVA1xe0hrEJ7KV9XmpKuGUUP9MjKyVDU+E=;
	b=TkAUmVtGsZL51J5aJkBO+iZ+3OPChq8pUxne2FTsQijPdbF5nYQ5/3DYThBTOkWU3Cl7dg
	Br7OcZ2CGWFXSnfpgwGewnaOZRe/07YKxrSCl3v833e1BzvUmKfdFAKOcZictXrAFWGZ21
	/Nmk4WskvlRmWsAXV8yp+3Y6IDEzdIo=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-R6rH3cfAPQKw-sZrgPf12w-1; Fri, 22 Nov 2024 03:16:56 -0500
X-MC-Unique: R6rH3cfAPQKw-sZrgPf12w-1
X-Mimecast-MFC-AGG-ID: R6rH3cfAPQKw-sZrgPf12w
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e3892eb6b1dso3214622276.2
        for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 00:16:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732263416; x=1732868216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SL5pNnDPsbVA1xe0hrEJ7KV9XmpKuGUUP9MjKyVDU+E=;
        b=mp0Y36Pfc7tRztaxUf4/vjKMUrRrqm3jy4umngfebmtNDsP7YPFN3BMsX7VxWuzZWh
         /VllugTeAha9mrELSnXvNRERIjukSpWEs3GEW9PPH7W3rfoaB5omT9SW/aMJFxKA2gsw
         4lXOaqmP2SDbhLkEBV7FzkIWnhTOptUF5+Jr4mNcaJkSbKa+Sc7K7h3PRKyMgEbVMDvJ
         HdKbe1/VgaXtWIaxcOrMNh4MdHYBqWIobxKn1sqqES4BRg22/T3BKfsMR1c9IzcIbOnp
         ZXoVxTRHyuYEB5jKiqkSEzM6bhhGM0FsV4EucGo1zO1fUVNpTuL05lzqwyXrdUMN1ze1
         9Vag==
X-Forwarded-Encrypted: i=1; AJvYcCV5asJ4qTqKZeVjH1ZAGCfo3X3k30XG/cPoTAFAklV9AjquvbhDxFmzFxTvF1gkxLe3TzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzjLdqt899mIsZOOR0PQlVl7+fuUfrPg/IHK8ItND9ghyRij1Q
	Fpcyc4vezyomvnfOGlQu7H+FkzrNk1/Pkum81kAXMpGvqKYN4Yue3elkmZyRiCdmGWC6B/XSRxN
	plFm9tlkti0MtyKC2z3mNhy4bMiSjK4VUPYjUZtEUkttD4/u26id5L2Va4e4GFLviAAk/EYkUcR
	zZtZpeccKBb22BdZI6KYb38avW
X-Gm-Gg: ASbGncsVXpUvFTdxEemepmNDu+tivoC/s6vBB0xz8MkiYkpK5G8VxIeXPG+SY4XY+0K
	BaLrSPDuOWC4aQL9br7uV5/G48W8t+F8=
X-Received: by 2002:a05:6902:2891:b0:e38:bbea:5f99 with SMTP id 3f1490d57ef6-e38f8c0827dmr1776431276.44.1732263415787;
        Fri, 22 Nov 2024 00:16:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEj5vouXz0BRQwa2iQNMlHQsy/q/aCh6IzhfMrbtN83KbXl29vM/kWrF8c5EzwxZD81oxJ4cvZZonMj3R9bA/k=
X-Received: by 2002:a05:6902:2891:b0:e38:bbea:5f99 with SMTP id
 3f1490d57ef6-e38f8c0827dmr1776401276.44.1732263415431; Fri, 22 Nov 2024
 00:16:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118-vsock-bpf-poll-close-v1-0-f1b9669cacdc@rbox.co>
 <673ed7b929dbe_157a2089e@john.notmuch> <dpt2h73fnzgzufuvilmaw5lbs2nydc3572xqn4yoicateys6cb@reuefsarvhka>
 <673fc371c9de1_11182089c@john.notmuch>
In-Reply-To: <673fc371c9de1_11182089c@john.notmuch>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 22 Nov 2024 09:16:44 +0100
Message-ID: <CAGxU2F7G-s9pwYBD6ateceJJTq_ac5=Yi=AKC6GNX+d6Ly9PUA@mail.gmail.com>
Subject: Re: [PATCH bpf 0/4] bpf, vsock: Fix poll() and close()
To: John Fastabend <john.fastabend@gmail.com>
Cc: Michal Luczaj <mhal@rbox.co>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobby.eshleman@bytedance.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 12:34=E2=80=AFAM John Fastabend
<john.fastabend@gmail.com> wrote:
>
> Stefano Garzarella wrote:
> > On Wed, Nov 20, 2024 at 10:48:25PM -0800, John Fastabend wrote:
> > >Michal Luczaj wrote:
> > >> Two small fixes for vsock: poll() missing a queue check, and close()=
 not
> > >> invoking sockmap cleanup.
> > >>
> > >> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> > >> ---
> > >> Michal Luczaj (4):
> > >>       bpf, vsock: Fix poll() missing a queue
> > >>       selftest/bpf: Add test for af_vsock poll()
> > >>       bpf, vsock: Invoke proto::close on close()
> > >>       selftest/bpf: Add test for vsock removal from sockmap on close=
()
> > >>
> > >>  net/vmw_vsock/af_vsock.c                           | 70 +++++++++++=
+--------
> > >>  .../selftests/bpf/prog_tests/sockmap_basic.c       | 77 +++++++++++=
+++++++++++
> > >>  2 files changed, 120 insertions(+), 27 deletions(-)
> > >> ---
> > >> base-commit: 6c4139b0f19b7397286897caee379f8321e78272
> > >> change-id: 20241118-vsock-bpf-poll-close-64f432e682ec
> > >>
> > >> Best regards,
> > >> --
> > >> Michal Luczaj <mhal@rbox.co>
> > >>
> > >
> > >LGTM, would be nice to get an ack from someone on the vsock side
> > >though.
> >
> > Sorry, is at the top of my list but other urgent things have come up.
> >
> > I will review it by today.
>
> Thanks a lot Stefano much appreciated! I was also slow to review as I
> was travelling and on PTO.
>

You're welcome :-) Thanks for reviewing the bpf part!

Hope you enjoyed your PTO!

Ciao,
Stefano

> >
> > Stefano
> >
> > >
> > >Acked-by: John Fastabend <john.fastabend@gmail.com>
> > >
> >
>
>


