Return-Path: <bpf+bounces-41304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 363D2995B65
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 01:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0D45B222BD
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 23:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181CA217910;
	Tue,  8 Oct 2024 23:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQjxh3cK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA6D2178FF;
	Tue,  8 Oct 2024 23:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728428923; cv=none; b=iu1ILSElKVzgweLlTlYMiXjllFQj47Dy0B1es83fxtJ8djTQYNdqB13gWmQBAiZ/69dQw7pwTlEU/BSjqCQs4VCKL/SPPnMoGD+dNGThukEfD93XbYa4UlavKAdQQZFm1lBfIJAjUQ7SLrn0W3iIdZ9y52BFqEipv4QLlmqPSTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728428923; c=relaxed/simple;
	bh=srZ/Uhr70S2RnP/s0nx9PpuHPHu1mU7k5PbwG8SNTeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LlW77FwtfX/ttd4Z9wl8ahn6mJgcLlDkWldB5IQpL+abe9werZevsMMWF0hX/4HOydWn6IJO7DP/puC/QWWQhoVbhH3p6dcD6KAykW6tt2nIaUHthInsWlxGAZmY/0HK5hdTGf+GlZfT87bbDWpXRUG8/0xU8Ltvzyas8wUwvbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQjxh3cK; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a34802247eso34820095ab.0;
        Tue, 08 Oct 2024 16:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728428920; x=1729033720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyGxrD+ZOkEIkxHoOi9HvRjk7gMiKGRRO8sZGQYAf0E=;
        b=jQjxh3cKJOgALVSmODP86g0C0k4EJ7/rTcShmNRTecm5x8LZccUbt+lmCxcDkuEO+s
         +x6iemP+utTxgwV4AG0rj6AgEEEYjBicKhsLV3vWdr0FRoKwRR8Nry2QvKwurpHv0qR3
         sK34s24kZEqgRhPLXffAA/2O6cBkdemgo2L1QwreNpRrqZdTzjOBpqILolrAZ73HSMld
         5eA/cw6ONK030+K1kbMNINTQkfbXIcFhlInl2RYOn55GaNUN/XFx3v/0QoxdbryTgCj0
         +HD2NHjfVmrV/zKJD+fuoRB33Jkoyq742JbTnSLAtyyxOnkdU0FinRk1wgJPR0OanLcG
         kHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728428920; x=1729033720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lyGxrD+ZOkEIkxHoOi9HvRjk7gMiKGRRO8sZGQYAf0E=;
        b=nsyR92p+NgOwZIEj3ummObWX9z2izbd/IvUGeFiI70PcLh0bYSj3m8009T1GHv9DrI
         bqiUL8+RhpzB+cD99IsM4KAwIKieNjJydVtxbfC60otmiqRATZiTuU9/aK8BmOSxpBXf
         aR4R9lJVNSIW/4VtNfJduoa47w6ui6iOdS3e01ob/vnDdvkORi0VofQSDzfuc81c0WoM
         1duFG8UN7CJBoXmbIlpuv2MQPQjfHEvZFmoxmhSgNaSD5wlKh1I2vCzenef4eU4XKBa9
         wRw6EPLN7qQ07817XSmVlD8fxDZLS1XYa4Qz2d+T+yIeuim6zrzKJ5PMgIw+z2BbMX4K
         csIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkFGZvymWzP1TL2Q1LIpeyPsPKydOQdm0EA9D5YjLRmoJELdf0iQ2gcPT+KlZHKXnvMXU=@vger.kernel.org, AJvYcCWKOz0MVz0vZTwJw/EmY2Y3h6819PBJySGMwAr7zL5Le+3PeSVts+GVnP5126g03N59wge9oDQF@vger.kernel.org
X-Gm-Message-State: AOJu0YzVDFpzL/HXCtjfDW+PY5S+a7dZ2rogEZM9IbA85IXbwxlxOEe8
	Hg9LiLDEnO0wKuOEdF6EwEGrJ5OGg5XNaPaPsvT8EdbmYOevqqKi+rNGtoINdS8b4lTiaZdVc5F
	n3M0v7dpar1nt+FQng0iGBSHeDtE=
X-Google-Smtp-Source: AGHT+IG51EoVP+DmksX2lzgKLLvdHVspXyLGifOooywc0CM6GlITChjrUoYdupOylHuLhxB3Wl3aU8V6fdI+U1+gJ3M=
X-Received: by 2002:a05:6e02:1d81:b0:3a0:abec:da95 with SMTP id
 e9e14a558f8ab-3a397d19872mr4048755ab.22.1728428920109; Tue, 08 Oct 2024
 16:08:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
 <20241008095109.99918-4-kerneljasonxing@gmail.com> <8f35cf0f-c56b-4fd0-93ef-e7e4f1c49dba@linux.dev>
In-Reply-To: <8f35cf0f-c56b-4fd0-93ef-e7e4f1c49dba@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 9 Oct 2024 07:08:04 +0800
Message-ID: <CAL+tcoBxdcEyigGjdPLM=LzDwx-q87t+_CewF7PvxRSavi8Utw@mail.gmail.com>
Subject: Re: [PATCH net-next 3/9] net-timestamp: introduce TS_SW_OPT_CB to
 generate driver timestamp
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 3:13=E2=80=AFAM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 08/10/2024 10:51, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > When the skb is about to send from driver to nic, we can print timestam=
p
> > by setting BPF_SOCK_OPS_TS_SW_OPT_CB in bpf program.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >   include/uapi/linux/bpf.h       | 5 +++++
> >   net/core/skbuff.c              | 8 +++++++-
> >   tools/include/uapi/linux/bpf.h | 5 +++++
> >   3 files changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 3cf3c9c896c7..0d00539f247a 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -7024,6 +7024,11 @@ enum {
> >                                        * feature is on. It indicates th=
e
> >                                        * recorded timestamp.
> >                                        */
> > +     BPF_SOCK_OPS_TS_SW_OPT_CB,      /* Called when skb is about to se=
nd
> > +                                      * to the nic when SO_TIMESTAMPIN=
G
> > +                                      * feature is on. It indicates th=
e
> > +                                      * recorded timestamp.
> > +                                      */
> >   };
> >
> >   /* List of TCP states. There is a build check in net/ipv4/tcp.c to de=
tect
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index e697f50d1182..8faaa96c026b 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -5556,11 +5556,17 @@ static bool bpf_skb_tstamp_tx(struct sock *sk, =
u32 scm_flag,
> >               case SCM_TSTAMP_SCHED:
> >                       cb_flag =3D BPF_SOCK_OPS_TS_SCHED_OPT_CB;
> >                       break;
> > +             case SCM_TSTAMP_SND:
> > +                     cb_flag =3D BPF_SOCK_OPS_TS_SW_OPT_CB;
> > +                     break;
> >               default:
> >                       return true;
> >               }
> >
> > -             tstamp =3D ktime_to_timespec64(ktime_get_real());
> > +             if (hwtstamps)
> > +                     tstamp =3D ktime_to_timespec64(hwtstamps->hwtstam=
p);
> > +             else
> > +                     tstamp =3D ktime_to_timespec64(ktime_get_real());
>
> Looks like this chunk belongs to another patch?

Makes sense. I could remove it here and write them when we need to
implement hwtstamp logic.

Thanks,
Jason

