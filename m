Return-Path: <bpf+bounces-50574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FE6A29DD1
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 01:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F41CB1681F5
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 00:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCE62907;
	Thu,  6 Feb 2025 00:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frFWFS/K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DD028F1;
	Thu,  6 Feb 2025 00:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738800813; cv=none; b=dHOSZW+/mu9wHyy8jrRUmqoAkrXbcXby5mObIo2i59e+mXEPGKbsV4HJPr9HfsrJOto2jv/Rh3st/cUdixp9zSFwPfDzuGa6dPOwp9S2/N3kknQMfM47gktKAoW6AFdjB7VTemSEbV7bnew9x7ugEYgfupgcRpGGqlRw+XK2mZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738800813; c=relaxed/simple;
	bh=I9RWG4JWiuo01AmK+FK5z5pg1WoJS6+WlcDifh54GrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RiAfx646bX7YuARCA7yUlFzE3PIqektmPOyk18cPt4AKRyYbv7Z2MJrIluAzJEyd0YK8rZj8F23UZyVacNTNICuZCSGlS6HYkrZWri3U9bJs75xTqlL9cE/3uyj/zyzw2K3hLrwdqU0VSlj4Xq66IG3X3z2gJ572V/t0B2ROYKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frFWFS/K; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d04d767d3aso2509405ab.2;
        Wed, 05 Feb 2025 16:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738800811; x=1739405611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nDC13wO7BQNudhGcbpiJgtYUZKRa9Wfr1pLvthotCQ=;
        b=frFWFS/KVcbYJpZAmqfrV4JJ6zqvojooPaSe99Esnfgw9Y7vhoH6NKeqB4W4jW4j6C
         hLx19iCIvkJfmekBiJMWcmPINIMiDS+xEnW8deJByHRmLnGyso164ClIMHbcy2hPyw2c
         BRvvF6+q/yZHn2j/oyDRJ5N/gzcV1a6G7ubKuOR48o6vwexpOWX4rorlZMz+btAybDg1
         w6d9MqVM4Puk/b4zFUelMW3JQtidH12cT0uDjejGZ+VzQ8RR8b+QT+upD9cstwu008Ht
         hvnFfEJEhx/MTaNMPyuBmeLYIFgOL2IF5wcox+oqN5DF9IwpHLxLq5QZ1Y/QUt8OR3Ni
         WbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738800811; x=1739405611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nDC13wO7BQNudhGcbpiJgtYUZKRa9Wfr1pLvthotCQ=;
        b=rIEFyBFagdM48W0RIwjaOn6P7LpORjblW8uIqiPy0TDgV/B4kDbu4kkXM8YOa2W7/+
         YKJLcxR8aDtzrW66h0fp9EnB93rLiU5xjPMrn/JTLqmqOI74y0bANI1c+PXIXbhZOlPB
         rkRqgI2Yk1cpfUyzok6cIn2LBdOtyUpAj/zX8zkwUpc6gLbavFkXEhY8P+In+IWnAuV/
         hiLoXiDjLsfNQeAdz9nWjpJDSOwUGCl8wIxqb0cyzQIuX4eR+pXluBk8lcn/vsplM5hR
         9lkLYoQwvCfDX0iTEpQgtIJ7lR8y6B4cjuH2jMI348FZacXB3uqViRM2GFG1q6LMIyvI
         eEIA==
X-Forwarded-Encrypted: i=1; AJvYcCUZGTkdMIUGprF+5+No7Vvu00MKdmHfHDza2CA9q4jkc9ApAKzXfzI3/mIWoaV+U/lQjuXz/PPO@vger.kernel.org, AJvYcCVs62z8UtSkyU2XXdSKsjqgq7o7otJYyVNE3iUu3iB0/5dP1wMaWmPX+a2vZLvUfy6X6OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyX3ikvGxLDm3jq5UPaHbhJkf+ozW68BvadlD+XN6QZHAJlJ0W
	V0lcjZyfCADNhyt0YU5p/DiuetxTc2A/wiMyI4z/N4zIqDjkl9u7CPO3ir6GaUI+TWU5mW2hdUO
	eW9+pn9eXOCAcVsjSxZtSoXL9JaM=
X-Gm-Gg: ASbGnctvznIE+wEoSIF60sgI/JfiTkOoHejvO2dpqnAEo5MjozqUOE2fxB/dWCLzIDK
	4t65QLJ60qz9gLPiQZhoi+5VrmdmCdPiA4HZ4bg/w/RDlTMdcvKUPj94esI00ANuVVuC1/psx
X-Google-Smtp-Source: AGHT+IEhgTk9YbnevXYLYUtiDKFyDtdhdPNBIAJFDY0qNen8QemsPHHBlh/Wbvt1Fi5kdLUTZdqOr+8CBpuJq7XdnsI=
X-Received: by 2002:a05:6e02:1b0c:b0:3cf:c8bf:3b8a with SMTP id
 e9e14a558f8ab-3d04f419163mr52725465ab.7.1738800810808; Wed, 05 Feb 2025
 16:13:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-11-kerneljasonxing@gmail.com> <20250204175744.3f92c33e@kernel.org>
 <e894c427-b4b3-4706-b44c-44fc6402c14c@linux.dev>
In-Reply-To: <e894c427-b4b3-4706-b44c-44fc6402c14c@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Feb 2025 08:12:54 +0800
X-Gm-Features: AWEUYZkV5dzLYm2UHctk11Vr97P7s1xam3Xwcfe8_isfQve_IUocjYJ3X0Qksjk
Message-ID: <CAL+tcoCQ165Y4R7UWG=J=8e=EzwFLxSX3MQPOv=kOS3W1Q7R0A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 10/12] bpf: make TCP tx timestamp bpf
 extension work
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 5:57=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 2/4/25 5:57 PM, Jakub Kicinski wrote:
> > On Wed,  5 Feb 2025 02:30:22 +0800 Jason Xing wrote:
> >> +    if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
> >> +        SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb) {
> >> +            struct skb_shared_info *shinfo =3D skb_shinfo(skb);
> >> +            struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
> >> +
> >> +            tcb->txstamp_ack_bpf =3D 1;
> >> +            shinfo->tx_flags |=3D SKBTX_BPF;
> >> +            shinfo->tskey =3D TCP_SKB_CB(skb)->seq + skb->len - 1;
> >> +    }
> >
> > If BPF program is attached we'll timestamp all skbs? Am I reading this
> > right?
>
> If the attached bpf program explicitly turns on the SK_BPF_CB_TX_TIMESTAM=
PING
> bit of a sock, then all skbs of this sock will be tx timestamp-ed.

Martin, I'm afraid it's not like what you expect. Only the last
portion of the sendmsg will enter the above function which means if
the size of sendmsg is large, only the last skb will be set SKBTX_BPF
and be timestamped.

>
> >
> > Wouldn't it be better to let BPF_SOCK_OPS_TS_SND_CB return whether it's
> > interested in tracing current packet all the way thru the stack?
>
> I like this idea. It can give the BPF prog a chance to do skb sampling on=
 a
> particular socket.
>
> The return value of BPF_SOCK_OPS_TS_SND_CB (or any cgroup BPF prog return=
 value)
> already has another usage, which its return value is currently enforced b=
y the
> verifier. It is better not to convolute it further.
>
> I don't prefer to add more use cases to skops->reply either, which is an =
union
> of args[4], such that later progs (in the cgrp prog array) may lose the a=
rgs value.
>
> Jason, instead of always setting SKBTX_BPF and txstamp_ack_bpf in the ker=
nel, a
> new BPF kfunc can be added so that the BPF prog can call it to selectivel=
y set
> SKBTX_BPF and txstamp_ack_bpf in some skb.

Agreed because at netdev 0x19 I have an explicit plan to share the
experience from our company about how to trace all the skbs which were
completed through a kernel module. It's how we use in production
especially for debug or diagnose use.

I'm not knowledgeable enough about BPF, so I'd like to know if there
are some functions that I can take as good examples?

I think it's a standalone and good feature, can I handle it after this seri=
es?

Thanks,
Jason

