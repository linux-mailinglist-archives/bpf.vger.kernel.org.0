Return-Path: <bpf+bounces-50336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BA1A26869
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 01:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 870C13A572C
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 00:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAC34A29;
	Tue,  4 Feb 2025 00:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X27qFVUg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B307494;
	Tue,  4 Feb 2025 00:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738628355; cv=none; b=tBR+N7frqNLuSLtLcPeM5W2/pvvssvfN9afELiXlvuAple5aRgfkv6bc0eAZkCFgzgYmAQISDvZBxLYJrPviwF4iQgZPt0gZiy7+pnc0LkKGecFdYoh+63w3hyAt86oyThb8tNKn70O+2kMNENHpG9yWyZyDCElxysJl90lkQzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738628355; c=relaxed/simple;
	bh=56scHuL7V2Tr/CgoMTaRCAv5MZTVRhaW5ovJ82v7jEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bco8F74xpgKYlFWMukQERC32/RWKPWJCphZFfaPLlAqcebJ62WtrvrqgnS+E65FU2LXDze6zUvUYzs/mY3H5ydcafk2MXSkEsglWFKm7LaCzUY6ojG6AG7bE+eHLFi+zDGxGxu7ZnR4ev6ZU2YOz2rfCDdOKyURgO+jQgPgS8MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X27qFVUg; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a8160382d4so11772795ab.0;
        Mon, 03 Feb 2025 16:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738628352; x=1739233152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rniXA2nD8BRjTtQAs1lRtAmqvSNTwh4cAEiLG2TUYlE=;
        b=X27qFVUgm0854WaecAo3lD9ccZKe4eTlx5BS805WUL/5rMOvogDwjUKLmpje+s8sF3
         3qrC8eZ//W2fb+fPvKqRMsZJiJmz/OrViNvG5okL26GU6jYJDw4Qlben2avnH3VNi7rq
         7ebuf8TInOTJZaiDwVvvw+P8guN9ReTyPH2gY5d10C4oGN1+Grs/nORa4rAeSzJ2N0xe
         uCOrgpxA8GRLdWAGXmFIezvCxMnwDL4/S+sKXRydRlDpuPo1ZodFIFuSqCpMTgJVpyev
         mFoGahmdiUPl/HciWUl7C9su62BuUpJFfstdGpBgK5sdyE72dvXe7/g/zv55XMENKIGl
         v08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738628352; x=1739233152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rniXA2nD8BRjTtQAs1lRtAmqvSNTwh4cAEiLG2TUYlE=;
        b=AjgwB0FpEB9qOfBctb3igYWSU3bjt54ltJEE5W4siy+tsKZBFJJlGZd/RwijPU7//Q
         rixJ5OmWsv5VIqtWQUmygUsaUYXEgfn9W4c2P5mH7i6BxnYsizscDlKD5Cc9MFz00U1l
         yTFtQVtvkWcdd1o0ag7m9Iq5ou0/KJw3zeMXbMSdfPPGOTU+GBY5V5qfp5sHMIfpmVNw
         NeC9bk8Jf3/BIaYORCRN/YvNj/bEkcNbOs2jD7nLyUrP7gv1btNF4ULuGbu7T+/4A0yl
         UK843bNw0/X9T028mPqGY4re5nT/8GOeT1tlK5t89gI0rV6zoImN33jMpAMv8fxYhTYf
         Hogw==
X-Forwarded-Encrypted: i=1; AJvYcCU0d0WFr2UPPRNwfYEuAbaPa2XEIDSiiw5R9dY3cxqSU5ugZWe8PotOmLQegm0ZLdxequDv7TTe@vger.kernel.org, AJvYcCXX5YqGj9RbvlgI/YdQk7NGo5ARgABRXVUU/9xdD0Mdb3GhVevxm6eTLXgEWHn+1bC2KvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztyu83qd/zsJalKYM5UnIkbTers3RfKhx2teEdJDaJff37EMLF
	OEQ4nAZiqvmlj4NdgdM9EIRS8DahbB8BJwFKAo440adDJ8QMbCkjCfR7cATwZaBziDh3MB7nH+x
	B3AHiF2ww1xLg6cZP1XjJCbMQGyI=
X-Gm-Gg: ASbGncvqy+pL3XDzMEHNvZ/9HDzI9woOyROy8scRBUxqTi9HnNW9Z30Ba+hQPyDOG/0
	D9L0eXBedvjDxEhCiBwd18RVgChnlGEiwvsfDKposDLpNeuo7H01fcCF2l91JKCXErLeOxUnm
X-Google-Smtp-Source: AGHT+IFnqU9zhGK0ivdkfRMSATeojf7CM4y+2MI822oCnvQEQb8+IXhD5S0Owq3GD9rWYj4TETKOJ1dLgTJWITogd0k=
X-Received: by 2002:a92:cda7:0:b0:3cf:b365:dcf0 with SMTP id
 e9e14a558f8ab-3cffe43240cmr191685345ab.19.1738628352591; Mon, 03 Feb 2025
 16:19:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
 <20250128084620.57547-6-kerneljasonxing@gmail.com> <3b3e0cdf-9c2b-4423-b638-0a79b238eb93@linux.dev>
In-Reply-To: <3b3e0cdf-9c2b-4423-b638-0a79b238eb93@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 4 Feb 2025 08:18:36 +0800
X-Gm-Features: AWEUYZlgN0Wqak8xZpH_B6NW1krO6jxlSKLjEXa092plsNAO4QSvUix8B5RfUQE
Message-ID: <CAL+tcoALoyfc7wL7odJ9uzsuD0D6BJ4qFpNJgxsAOHE21i_LAA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 05/13] net-timestamp: prepare for isolating
 two modes of SO_TIMESTAMPING
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 7:14=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 1/28/25 12:46 AM, Jason Xing wrote:
> > No functional changes here. I add skb_enable_app_tstamp() to test
> > if the orig_skb matches the usage of application SO_TIMESTAMPING
> > and skb_sw_tstamp_tx() to distinguish the software and hardware
>
> There is no skb_sw_tstamp_tx() in the code. An outdated commit message?

Thanks. I'll update it and double check before reposting.

>
> > timestamp when tsflag is SCM_TSTAMP_SND.
> >
> > Also, I deliberately distinguish the the software and hardware
> > SCM_TSTAMP_SND timestamp by passing 'sw' parameter in order to
> > avoid such a case where hardware may go wrong and pass a NULL
> > hwstamps, which is even though unlikely to happen. If it really
> > happens, bpf prog will finally consider it as a software timestamp.
> > It will be hardly recognized. Let's make the timestamping part
> > more robust.
> >
> > After this patch, I will soon add checks about bpf SO_TIMESTAMPING.
>
> This needs to be updated also. BPF does not use the SO_TIMESTAMPING socke=
t option.
>
> > In this way, we can support two modes parallelly.
>
> s/parallely/in parallel/

Will fix it.

>
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >   include/linux/skbuff.h | 13 +++++++------
> >   net/core/dev.c         |  2 +-
> >   net/core/skbuff.c      | 32 ++++++++++++++++++++++++++++++--
> >   net/ipv4/tcp_input.c   |  3 ++-
> >   4 files changed, 40 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index bb2b751d274a..dfc419281cc9 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -39,6 +39,7 @@
> >   #include <net/net_debug.h>
> >   #include <net/dropreason-core.h>
> >   #include <net/netmem.h>
> > +#include <uapi/linux/errqueue.h>
> >
> >   /**
> >    * DOC: skb checksums
> > @@ -4533,18 +4534,18 @@ void skb_complete_tx_timestamp(struct sk_buff *=
skb,
> >
> >   void __skb_tstamp_tx(struct sk_buff *orig_skb, const struct sk_buff *=
ack_skb,
> >                    struct skb_shared_hwtstamps *hwtstamps,
> > -                  struct sock *sk, int tstype);
> > +                  struct sock *sk, bool sw, int tstype);
> >
> >   /**
> > - * skb_tstamp_tx - queue clone of skb with send time stamps
> > + * skb_tstamp_tx - queue clone of skb with send HARDWARE timestamps
> >    * @orig_skb:       the original outgoing packet
> >    * @hwtstamps:      hardware time stamps, may be NULL if not availabl=
e
> >    *
> >    * If the skb has a socket associated, then this function clones the
> >    * skb (thus sharing the actual data and optional structures), stores
> > - * the optional hardware time stamping information (if non NULL) or
> > - * generates a software time stamp (otherwise), then queues the clone
>
> This line is removed. Does it mean no software timestamp now after this c=
hange?

Right, _software_ timestamp will enter skb_tx_timestamp() then call
__skb_tstamp_tx() instead of this skb_tx_timestamp().

>
> > - * to the error queue of the socket.  Errors are silently ignored.
> > + * the optional hardware time stamping information (if non NULL) then
> > + * queues the clone to the error queue of the socket.  Errors are
> > + * silently ignored.
> >    */
> >   void skb_tstamp_tx(struct sk_buff *orig_skb,
> >                  struct skb_shared_hwtstamps *hwtstamps);
> > @@ -4565,7 +4566,7 @@ static inline void skb_tx_timestamp(struct sk_buf=
f *skb)
> >   {
> >       skb_clone_tx_timestamp(skb);
> >       if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
> > -             skb_tstamp_tx(skb, NULL);
> > +             __skb_tstamp_tx(skb, NULL, NULL, skb->sk, true, SCM_TSTAM=
P_SND);
> >   }
>
>

