Return-Path: <bpf+bounces-50624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E90A2A36E
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 09:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA79E18892CF
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 08:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEFE22578D;
	Thu,  6 Feb 2025 08:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fB9ix6wm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5881FCCE1;
	Thu,  6 Feb 2025 08:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738831445; cv=none; b=kcNuyVsd51bGM5w7G+31tzapNSkEXQkSSJvw0wBhi7A8rE0XJD9DA03HjWD52vjTRInHw79HIYV9Y/5KpO/aEpVgGjUO8jT5MALJg3KFjMSdwk7NlArdBHy5v8MyMkeuEj7xp/c8/mNaDY+wmuVS68GP2aEibpCpZb+31mK+pRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738831445; c=relaxed/simple;
	bh=mJI+NVNthZdvvzNIH/oOTIwroKqZU59erMXCgc1Nqic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/WUXJpWSUTVTOc3Y/octNZy6O8YY5Z/69h708KtPG6t1VxxLRkjN/z8Lu4t2Cu59hGguG41b63dOQuwFYdggQuQBWK1PGRT7W1WEIDK4U3e/qiVqAVscSeGrBxhxRA2EjL239iQx0NooexYf8wnOwNUQDCFT6WSBZfr+h81Axk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fB9ix6wm; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d06026ddf8so552715ab.3;
        Thu, 06 Feb 2025 00:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738831443; x=1739436243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQScERGpxW6SHFx96DVuTqcdq334QwjiqkR8FbScGZ8=;
        b=fB9ix6wmi1uT1DBza9XclRKhbj7BqxHVVv5lvgVHSIVke7+YL03SDAnKDw3jGRvBkJ
         imrgObdsYaAgzFKyZIJ61p3pICG5BhCvvTYW1DsyqKCJZ7j4/TlYI32ctJ4fhNgFhka2
         I7aB6JwF6fEP65AtR+tdFUkfreXwS9xhNLhyIxw0qoo8oOcNWf7i/CApPYrO5Lt7bp0D
         dnrVAioBA4xQQWoVrXYOtbzCzOCOXfDkDvNLWV3jpYF4fMVvUuYx90TB2q5x+PvlQKig
         Npsjub363SPEthIXZfYap7toCsVdtbOVlFwLrow5nWVJ15wfYpbIrozXHXKg5F89VTBM
         5b2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738831443; x=1739436243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQScERGpxW6SHFx96DVuTqcdq334QwjiqkR8FbScGZ8=;
        b=SCQNaENq1v1JcqqN44QoRqzic5ZU3Sm15NRDelyJadyrCtpw9bJFyZc0MTxNZTabzG
         5AmSpXALwED901WpwMshKkh+yhwrL3Tbm9wZgtSl9xmQzMagRWWA2U6hnjSYfSt0UNMG
         4kjRr/bX7FmI6egqPIEw+9s/vuISJrwWcNE9bf0F2kzCeMVI6LZ6AFKJfcE44X+hxMJ+
         BvJKJleoSNJPjWlTB+W0hfXoAC0h9uajmp9F/sr3HxbhMshdOWYMFt22T5NnY5zPZ8wX
         e2shikj/j7d6R0NXE2JCqQDcMlFlE4tzoZo1g8csJ/CaY1sMtP9pC3TyKLchAm0HGx1d
         Yp6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUSmCRgmevXdQSapzywqxrHJHjEiIUkZW3ZrRiu2kIuKhz2BgS0o82LhkoAcdQCM/vF2GmBMeq@vger.kernel.org, AJvYcCVLC05KjPl/i3DKHghu7TfroQVW2VV1/HobAza1hZOjsXHvWz7JMnrgYxgOe1KHlrjTU1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRAiFuYs+0q1eoXLkWO2A/019TJ0l2Gjc7I49XCSAJW5rbdpWF
	Lmv/HW1oBP6FoTk/Zj8UbSiSt24gCyPiQKc+Zr5UCCygarotjqF7umRg31ZmhkUYcNdehQf5IZU
	G0AwSHk+l+mrY7ve0F5VGysCkVHHpbExKmyhAMAcj
X-Gm-Gg: ASbGncuZ8ckabgKDUVTo9M9ZlK2QPRJzHLv/SDtDvGdmECs3pNe1MjVtpLoewFN/wd1
	cgfO7W8epcBMUaP3l5FiB2tsVfn5IitLsiYyLQ1sZxZqb3UUbd3/LvXU+1x2RQYmus4bbdG8=
X-Google-Smtp-Source: AGHT+IHWLEhsS7LqZ5gd45UDsRpIQEL0inWymvxBPPbh6qSBomvkAtK+YhKOVaLCpaSAx+7IZIsS1DvEQZo4HE4hXvs=
X-Received: by 2002:a05:6e02:1546:b0:3d0:d0d:db8e with SMTP id
 e9e14a558f8ab-3d04f40204cmr54065475ab.1.1738831443340; Thu, 06 Feb 2025
 00:44:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-6-kerneljasonxing@gmail.com> <67a384ea2d547_14e0832942c@willemb.c.googlers.com.notmuch>
In-Reply-To: <67a384ea2d547_14e0832942c@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Feb 2025 16:43:27 +0800
X-Gm-Features: AWEUYZm9CtHc2dAYDxFup6EhapE81ULeSHDkFtB31pl0iV5_EYoDvqCMUmmShiU
Message-ID: <CAL+tcoDvCrfE+Xs3ywTA35pvR_NyFyXLihyAuFFZBA4aHmiZBg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 05/12] net-timestamp: prepare for isolating
 two modes of SO_TIMESTAMPING
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

On Wed, Feb 5, 2025 at 11:34=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > No functional changes here, only add skb_enable_app_tstamp() to test
> > if the orig_skb matches the usage of application SO_TIMESTAMPING
> > or its bpf extension. And it's good to support two modes in
> > parallel later in this series.
> >
> > Also, this patch deliberately distinguish the software and
> > hardware SCM_TSTAMP_SND timestamp by passing 'sw' parameter in order
> > to avoid such a case where hardware may go wrong and pass a NULL
> > hwstamps, which is even though unlikely to happen. If it really
> > happens, bpf prog will finally consider it as a software timestamp.
> > It will be hardly recognized. Let's make the timestamping part
> > more robust.
>
> Disagree. Don't add a crutch that has not shown to be necessary for
> all this time.
>
> Just infer hw from hwtstamps !=3D NULL.

I can surely modify this part as you said, but may I ask why? I cannot
find a good reason to absolutely trust the hardware behaviour. If that
corner case happens, it would be very hard to trace the root cause...

>
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >  include/linux/skbuff.h | 13 +++++++------
> >  net/core/dev.c         |  2 +-
> >  net/core/skbuff.c      | 32 ++++++++++++++++++++++++++++++--
> >  net/ipv4/tcp_input.c   |  3 ++-
> >  4 files changed, 40 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index bb2b751d274a..dfc419281cc9 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -39,6 +39,7 @@
> >  #include <net/net_debug.h>
> >  #include <net/dropreason-core.h>
> >  #include <net/netmem.h>
> > +#include <uapi/linux/errqueue.h>
> >
> >  /**
> >   * DOC: skb checksums
> > @@ -4533,18 +4534,18 @@ void skb_complete_tx_timestamp(struct sk_buff *=
skb,
> >
> >  void __skb_tstamp_tx(struct sk_buff *orig_skb, const struct sk_buff *a=
ck_skb,
> >                    struct skb_shared_hwtstamps *hwtstamps,
> > -                  struct sock *sk, int tstype);
> > +                  struct sock *sk, bool sw, int tstype);
> >
> >  /**
> > - * skb_tstamp_tx - queue clone of skb with send time stamps
> > + * skb_tstamp_tx - queue clone of skb with send HARDWARE timestamps
>
> Unfortunately this cannot be modified to skb_tstamp_tx_hw, as that
> would require updating way too many callers.

I didn't change the name, only the description and usage of
skb_tstamp_tx(). It always gets called in the hardware timestamp
situation except skb_tx_timestamp() that is modified.

Thanks,
Jason

