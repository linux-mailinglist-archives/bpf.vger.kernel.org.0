Return-Path: <bpf+bounces-57980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C595AB242E
	for <lists+bpf@lfdr.de>; Sat, 10 May 2025 16:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C13191B6408F
	for <lists+bpf@lfdr.de>; Sat, 10 May 2025 14:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE8F231855;
	Sat, 10 May 2025 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goosey.org header.i=@goosey.org header.b="iwo1lv8f";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Ca75rZMd"
X-Original-To: bpf@vger.kernel.org
Received: from e240-12.smtp-out.eu-north-1.amazonses.com (e240-12.smtp-out.eu-north-1.amazonses.com [23.251.240.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D302747B;
	Sat, 10 May 2025 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.240.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746888039; cv=none; b=qWwF6HEo3Mn/e7Nm1FSVDYiQnR5HN0D+RmIIUGQdsiqDD+B/Ms9ONXR9xkOChATgn1VgcsV7G7qXMbER8Mwen5m2Ma5CgtrgXz6c4VHtChLkS4TT+w3BQW/2INDIWAYDc0SnUn2VCzRLaZfFVXDCm0opYm6ABb6bDXCaHLkO7MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746888039; c=relaxed/simple;
	bh=KMKl5zhXLDYEfXZ6tteF1iVkfC9CD4G+WrBxconLDd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ea8tRhRrtdSHeTQ2e09i5ExQ9sMTppOsbQJ4OkSipCTRQPF802u7/aON6iqF0gunNUCNxdB8nfJh2X3AWNiV3U7oSmqiel4kVuu3cZKZAWpLUY7VDckNHGxambu3x1I7IkXjicSfjFrcwj2Odtoj/nj/+jV6CLXlRhNUuMuaOAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goosey.org; spf=pass smtp.mailfrom=eu-north-1.amazonses.com; dkim=pass (2048-bit key) header.d=goosey.org header.i=@goosey.org header.b=iwo1lv8f; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=Ca75rZMd; arc=none smtp.client-ip=23.251.240.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goosey.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eu-north-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=iuunfi4kzpbzwuqjzrd5q2mr652n55fx; d=goosey.org; t=1746888035;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=KMKl5zhXLDYEfXZ6tteF1iVkfC9CD4G+WrBxconLDd0=;
	b=iwo1lv8fI08QdE5VYLmRTxtD/9qKI799T8AerPRboc3KglsdTOmCHay8oe3d+KpQ
	f0l99fphfTrIC5ZveZNtRTxIcoYwmHGP0re5VEXSvJCrsZoPjGospmf9Vqoy5om32N6
	DVLOLW+UDzui9X6huEM4G9X15MvZ+r7JC4N2zKVcsmNWBXLlCjv1uBtrwjh0eIN2jx6
	QaiY1jhvlsPnm22N8sMmLnbyh92lI+ig9p4yTuSUfxCVI3hJ6+yRhXaK6GwagbgZWwS
	FfvOFe8IfJW6lS8PGdaZ40hpyMG8t02L2fduwBFLXEKDF7vL3V/NVwQvOFR49ftzAUe
	vWo1Y2KgVQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=bw45wyq3hkghdoq32obql4uyexcghmc7; d=amazonses.com; t=1746888035;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=KMKl5zhXLDYEfXZ6tteF1iVkfC9CD4G+WrBxconLDd0=;
	b=Ca75rZMd2pkXEZ6zP1H0DLvSyPug23JBw85G+hQ597ZELxmtRCF04+uyd1GnhsTx
	1MlenaAqp1CYpL3+MiUuKpiIRS+TjWzEy1kgeGjkqZ5lrJMGKHmeB8iob/DLcHylID8
	kh4cVHriMN2tYyCSorVmMZIwYL+rKqm+F8nYaz6Y=
X-Forwarded-Encrypted: i=1; AJvYcCU/cTAxoNY28G6ME7Ie8pPZaroTJD4UBGACAshD6NIjkkv+W4cKW2nK8O6C2sAPb5v1Wso=@vger.kernel.org, AJvYcCW2COPqE5mYPzRsbqXTJGrVFsXQDZsBR9bh95wqxJ59GccxhhJzXu0iiwXij1vN8583CPa0Fq7+hYbKQ1Iq@vger.kernel.org, AJvYcCWNLuzjpHeUnjUVbg/XDdK5bpyFbX1CsMVhzNpSmhchTF+iTFFv+QZ5fgHjcXotRyxriS8xGziA@vger.kernel.org
X-Gm-Message-State: AOJu0YzYQOiLvVeH1RzDZj10+m4Vbfloyxpf2dWb7jLVxPUlhUA4gHDm
	HzRRtjTAVz1mYUU3bXJ+vcN4sOA3eqtJMZgz013G84VC6OqlFbbRcon6PSfXfF51QqhbnSBpb98
	pyAzMMElRotPbdHiKKF3y3FfDc3o=
X-Google-Smtp-Source: AGHT+IFOxsIG+1iEx9ZpQPXXa6rt+jwNsdN1AWSLrJAKilGXNLBf51PhuX6pHHj6liVACzbJVfRrTYocmdRAEfDQcL4=
X-Received: by 2002:a2e:b8c9:0:b0:30b:efa3:b105 with SMTP id
 38308e7fff4ca-326c45900ccmr31918351fa.19.1746888034583; Sat, 10 May 2025
 07:40:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <01100196ba916f60-f2642e95-026a-4ba3-bd32-f871d781c2d6-000000@eu-north-1.amazonses.com>
In-Reply-To: <01100196ba916f60-f2642e95-026a-4ba3-bd32-f871d781c2d6-000000@eu-north-1.amazonses.com>
From: Ozgur Kara <ozgur@goosey.org>
Date: Sat, 10 May 2025 14:40:34 +0000
X-Gmail-Original-Message-ID: <CADvZ6Eq4uZsiM4tPZVQGYQYhAFgLmu=ND2vcrY7vmkPGtLfh4A@mail.gmail.com>
X-Gm-Features: AX0GCFvhh_bksUL8uCmWQxmdadZWrfe_8ngxSdo9LL1zIZrNhm7TvDpZYH9nycg
Message-ID: <01100196baa40a87-e4dfc972-74d0-40b9-a78f-83cfe5649dfe-000000@eu-north-1.amazonses.com>
Subject: Re: [PATCH] net: fix unix socket bpf implementation: ensure reliable
 wake-up signaling
To: Ozgur Kara <ozgur@goosey.org>
Cc: John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, 
	"David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Feedback-ID: ::1.eu-north-1.jZlAFvO9+f8tc21Z4t7ANdAU3Nw/ALd5VHiFFAqIVOg=:AmazonSES
X-SES-Outgoing: 2025.05.10-23.251.240.12

Hello,
I'm sorry but actually please ignore this patch because i realized
that i can put an atomic process with finish_wait() instead of
prepare_to_wait() because its located in af_unix.h and i'm trying to
understand it now.
Can we preserve wake-up with schedule() by registering towards wait
queue by using finish_wait() instead of prepare_to_wait()?
i will figure out the wait in af_unix.h and send a new patch.

Sorry,

Ozgur

Ozgur Kara <ozgur@goosey.org>, 10 May 2025 Cmt, 17:20 tarihinde =C5=9Funu y=
azd=C4=B1:
>
> From: Ozgur Kara <ozgur@goosey.org>
>
> This patch addresses a race condition in the unix socket bpf
> implementation where wake-up signals could be missed. specifically,
> after releasing mutex (`mutex_unlock(&u->iolock)`) and before
> acquiring it again (`mutex_lock(&u->iolock)`) another thread can
> insert data and send a wake-up signal. if this signal occurs before
> `wait_woken()` is called, it may be lost and cause the thread to
> remain unnecessarily blocked.
>
> to fix this patch introduces a safer wait mechanism using
> `prepare_to_wait()` and `finish_wait()` which ensures that the wakeup
> signal is not missed. this prevents unnecessary blocking and reduces
> the risk of potential deadlocks in high-load or multi-processor
> environments.
>
> such race conditions can lead to performance degradation or, in rare
> cases, deadlocks, especially under heavy load or on multi-cpu systems
> where the problem may be difficult to reproduce.
>
> also there was a space in the last line so i added a checkpatch correctio=
n :)
>
> Signed-off-by: Ozgur Kara <ozgur@goosey.org>
> --
> diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
> index e0d30d6d22ac..04f2b38803d2 100644
> --- a/net/unix/unix_bpf.c
> +++ b/net/unix/unix_bpf.c
> @@ -26,14 +26,29 @@ static int unix_msg_wait_data(struct sock *sk,
> struct sk_psock *psock,
>         if (!timeo)
>                 return ret;
>
> +       /* wait queue is waited */
>         add_wait_queue(sk_sleep(sk), &wait);
>         sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> +
> +       /* control while locked */
>         if (!unix_sk_has_data(sk, psock)) {
> +               set_current_state(TASK_INTERRUPTIBLE);
>                 mutex_unlock(&u->iolock);
> -               wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
> +
> +               if (!schedule_timeout(timeo))
> +                       ret =3D 0; /* timeout set */
> +               else
> +                       ret =3D signal_pending(current) ? -ERESTARTSYS : =
1;
> +
>                 mutex_lock(&u->iolock);
> -               ret =3D unix_sk_has_data(sk, psock);
> +
> +               if (ret > 0)
> +                       ret =3D unix_sk_has_data(sk, psock);
> +       } else {
> +               ret =3D 1; /* return data */
>         }
> +
> +       __set_current_state(TASK_RUNNING);
>         sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
>         remove_wait_queue(sk_sleep(sk), &wait);
>         return ret;
> @@ -198,5 +213,4 @@ void __init unix_bpf_build_proto(void)
>  {
>         unix_dgram_bpf_rebuild_protos(&unix_dgram_bpf_prot, &unix_dgram_p=
roto);
>         unix_stream_bpf_rebuild_protos(&unix_stream_bpf_prot,
> &unix_stream_proto);
> -
>  }
> --
>
>
>

