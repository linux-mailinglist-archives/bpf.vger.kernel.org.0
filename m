Return-Path: <bpf+bounces-41366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 324B299620D
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 10:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E97FF28921B
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 08:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD991891AA;
	Wed,  9 Oct 2024 08:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHz5TFan"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1604188711;
	Wed,  9 Oct 2024 08:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728461514; cv=none; b=oTkP0B5cF/L488ataZ5XRNVus++qQ1JLKE1yUAyedAsgFnN3QbAkTLQs2HERtUhTjDRUqJ+fyjM71Qfurczas+B4wTzXWza7xteo8Ccyjp+mCxkXxqilzqhCZ03W8YbPKSHgyDpFHcSyaTM4zfX4JIqz3NVL/D1+zUIPqgRUGyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728461514; c=relaxed/simple;
	bh=LTGafedAFHSf1OakUpMcfz5j5NTUf/6vsN2R0v1mgJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQnoLix0qr36WHkCKZFbzxtC0ggT1yDYlwBwtU6fRGYIrWb/S4av3kOtDF5XqXwEjcld7QQvqNzqxho6djDktcO9RQloSnfnLw0SUnT0nZ8w9Owe+Ca3JGRfT7kEHDFhPbunXK+9SafFslZ2RmxpsvwK6bHWu+AWz+q2/dJ6qc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHz5TFan; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a3a03399fbso978975ab.0;
        Wed, 09 Oct 2024 01:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728461512; x=1729066312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPCYF6R3mCZaQcqSISINl1vSIo/zCX+0zhfvtXPYjdE=;
        b=ZHz5TFannOVnUy2GIWsGrKg8GEH4nNaqqGKJxkN2PIyTU57xt3T4UkMJMVbWYgwDg3
         syHm5z7Js3JQ2o+d1Ux1BPovECFEOqvPrn8LsbKJaKFyQ3YMP5pghVNgh0sLaBAocvZZ
         gmzZFx7C32MXlPCVmJpWgiy1cIW2dI54JAbVIad2+wDyFD0k25Ls9LNvPuq/b9hQlRNj
         T/Zt5Gww1Ra8DoLFnkD8b4lFZcRwyM950Pj+ZEPh038QqUkT8kXbYPF1ZatRn42Kgd20
         4e8j7OdIhv8FPJWI4klAf0N7H3o5m1Ai45Z9WUhySepC54IQ2+4N4szfo5JqdzIFO+o3
         MVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728461512; x=1729066312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPCYF6R3mCZaQcqSISINl1vSIo/zCX+0zhfvtXPYjdE=;
        b=PccLZr0hYf/AVB4oMk7NUBFY6J6sb3ROtg/cfzECV5yNEU94xA3m5XEfTA++MBK4i8
         tFpNOVllIvEkDmmY9wy+kKGC8zQzVJwe97IXgC5IeTJjsukahvsdO/kauLmKnugw2Ghe
         lX4ZI0rVulhHy3epzPg1Zo9Dv8ssyneLa6KhIZcAVFkw5Eq8p5MOzme28fsw76+zg3us
         XVIcE3kPSfYlEwiUkyGTUn9qfEn3XiZXAn7q6tzMzVbT6KOIvcCMTWnjlV+xLh3E3chq
         BHpYJlJYRfRxwdRLUhqD95Cw7khGh8hX40mX/6Ha/RIHB9J2YGDxCvThM/7ZSr9GgKCN
         p2DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvujt/Br9WRU67/wFbLCAaH6m9DFk568nOA9hxS+lByegqtq95yS9ysiMiTv944fvWnZ6oFRaY@vger.kernel.org, AJvYcCXAUQX0tLE3RJZB5zGcDju5sbjroZU3nGCycPyQskqoG+1fkVdUi3V78t9YaSi5+/PTgn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxejLpu3y/MEmKt8sEvQ68sNV9g3IKYLFr3kn5DXo2+RZm1tAnj
	PnD4/YJYrsBMDUHizLOAWrTBJqARX8nsShLH6dTYZwhnFx0xMQJ8K794+Uy7TUvsldu9SzKYwXd
	Hd8LQVfjSnTvGuCYazRCpiRoqHO4=
X-Google-Smtp-Source: AGHT+IHt6PewSD3yyZfvzSl17kqWRd0Ai2/kwT30PhJ+ABxGg9ReLaq5PF+D/UpVP1/57YUlzTNzr19JT+1nsEjs+V4=
X-Received: by 2002:a05:6e02:1a07:b0:3a3:6b20:5e20 with SMTP id
 e9e14a558f8ab-3a397d0aecamr17258875ab.13.1728461511986; Wed, 09 Oct 2024
 01:11:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008095109.99918-2-kerneljasonxing@gmail.com> <20241009005846.40046-1-kuniyu@amazon.com>
In-Reply-To: <20241009005846.40046-1-kuniyu@amazon.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 9 Oct 2024 16:11:15 +0800
Message-ID: <CAL+tcoCA3MAGgVBod+FSUXxThPYJ3+XfQR9k+dWk0YLd3fAnkg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/9] net-timestamp: add bpf infrastructure to
 allow exposing more information later
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org, 
	eddyz87@gmail.com, edumazet@google.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kernelxing@tencent.com, 
	kpsingh@kernel.org, kuba@kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me, song@kernel.org, 
	willemb@google.com, willemdebruijn.kernel@gmail.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 8:59=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Tue,  8 Oct 2024 17:51:01 +0800
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Implement basic codes so that we later can easily add each tx points.
> > Introducing BPF_SOCK_OPS_ALL_CB_FLAGS used as a test statement can help=
 use
> > control whether to output or not.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  include/uapi/linux/bpf.h       |  5 ++++-
> >  net/core/skbuff.c              | 18 ++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h |  5 ++++-
> >  3 files changed, 26 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index c6cd7c7aeeee..157e139ed6fc 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -6900,8 +6900,11 @@ enum {
> >        * options first before the BPF program does.
> >        */
> >       BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG =3D (1<<6),
> > +     /* Call bpf when the kernel is generating tx timestamps.
> > +      */
> > +     BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG =3D (1<<7),
> >  /* Mask of all currently supported cb flags */
> > -     BPF_SOCK_OPS_ALL_CB_FLAGS       =3D 0x7F,
> > +     BPF_SOCK_OPS_ALL_CB_FLAGS       =3D 0xFF,
>
> I remember this change makes two selftests fail and needs diff
> in this link.
> https://lore.kernel.org/bpf/20231016161134.25365-1-kuniyu@amazon.com/

Thanks for pointing out this. I will dig into this :)

>
> Also, adding a bpf selftest or extending some for this series
> would be nice.

Sure, I would like to add a selftest after we all reach a consensus on
how to implement it in the right way.

Thanks,
Jason

