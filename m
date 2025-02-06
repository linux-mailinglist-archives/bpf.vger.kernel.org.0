Return-Path: <bpf+bounces-50593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06CFA29EE3
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 03:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 001E23A6DB8
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 02:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1C413AD18;
	Thu,  6 Feb 2025 02:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ajp57LRc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4227DF60;
	Thu,  6 Feb 2025 02:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738809585; cv=none; b=IknQt2AElhu/7g+GbawAZ1bJQ1aXczLFSltKcpE1pi4zXhKjfQ7jwtg+1Mpj7w80ezie2+LTI+bwK8ogmgwjuYxGR7JgtfVD4upcuRGKr6i1Npa1qa2rIYasWZMKnDxNypmZLi8cYGqlE+DzA0xcTdEqIhQeSFm5e0HdbRmlPbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738809585; c=relaxed/simple;
	bh=qib+L5QecLhpYpK9BFbnvXVFtUrOM7IY3xfFFVGj1EM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tpxt1Usl4yzV30/2XJfKcHpHbLRIaK9Zgz/dTCDHIB/py+Opybm+qowc4DXKewE2/L5Hb2wLoWGoyEbncMKnwrhkHwuIsFSuO7QAzfwyMmBiMx4s7GIamlHg1FID9vcxq89fOKEHmifWr/72qRlTuSfWEZhPNUDukoIpF3hx5rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ajp57LRc; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3ce87d31480so1273685ab.2;
        Wed, 05 Feb 2025 18:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738809583; x=1739414383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2r/k2esHHDOBMYVJXVugTMop5rQCFz6g3dqQigy6JQ=;
        b=Ajp57LRchXSh7nZsXXPlPkuShxg+nhxaq56uBrj4WvirzpwLw7nTqqd0kkmjvh3Ufh
         jc4++MvJuvsDI3gdhZtudN/pzOM4LLdzJbVV2UUmAoLxZ4bZyQhbTObmxjbIpP1PHr5V
         N2zIBGIat87Qro3qrkW3Hks1rS7DCL/iMBAX64JGh3AzFM8fJlZw+YMAwei9s48dDsBv
         clxUrOuvGDeWuJ2ZYKFRQ8zzzn5783MAXtXRWjhlpOwQ4sZHV47IkbmZpRhNONIOC886
         t+jstxFoF27ptZwq1bUjPL1GhLxjcpQhmYtVDhjCJ2DR217tSiWPgufl5pJCne4uFAR9
         9LDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738809583; x=1739414383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2r/k2esHHDOBMYVJXVugTMop5rQCFz6g3dqQigy6JQ=;
        b=IFFYq+55AyVjUbVO1v6FIfdANYJt9q05ZC2BIUC1FT+COIHDHLNuDFhEKd+21calHl
         X+Rs5eWDvlc8xX8ftCqr62D4rC4C8X1dczjDRsu5Y67G4Q+9yPPjlW+Sv/eVR8Z63ILy
         bc2fzMrfJgPbQfMtB4vw6ik13hs4wcLYXqMA/bZfZcuBB5dRUGKKGUQz9tIYcVGy2THH
         9wta7XMP7aXynhk0n+fqA/B81OgkWTWDKfJoEvhYZjnf/Rge/8XdlykPvBzgFXKdQ3zG
         xCBEtAP0Se1/H/2+VITYWB5wuFk7gLKWlBIiebmp9w/VgPGISd+EMW1Ln6TLdPsygT3H
         a4wg==
X-Forwarded-Encrypted: i=1; AJvYcCWvsuA+3qfzD9+T81UCnEWk592/Mg/WiRLcti9V2g9vzeDhj+5+ic1c2cffCHiKwgoEjL8i6rAK@vger.kernel.org, AJvYcCXioCZYeigEmg2zaP+kFvC9YFUGtrCQl9pUILApYTBgFjw6yH5yVb2m1m59nd3JtMJbGdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXxPEWCOfCIddmDr2lKz0TUd/L2JHbbzk9jy8PakLI8cPOdDCv
	Vo5Ik9+G3ThHRpmBUChMzdw19AGJ02slSviGjIo8T3HFhweOaUzt/cNpXwMwZYFoa9FfKmutezI
	v5nulEiuB2o7RZ0v9gP3U3GksJi8=
X-Gm-Gg: ASbGncst1eUkkov7ykXGcp5CBoE/haGIczHHXe6AE4x1EI0r7+vFyMA+eQJdc5YB7Nz
	zF+hA7u1/tPG498Zs02u00bV1zhFGI/wAmh7PV2jLqtEmBb2DrfNdTA7y2iVy7Vtgk6pQT9ye
X-Google-Smtp-Source: AGHT+IErDIEoR2HhHfFpZVwdHMo7Bs+UqubQrx8ZGHT/yrKUu4Cb1uXgxKhGsw68cmEkRepPue69fKEKViPJfJZe8sA=
X-Received: by 2002:a05:6e02:198e:b0:3d0:137a:8c9d with SMTP id
 e9e14a558f8ab-3d04f422693mr60280105ab.8.1738809582599; Wed, 05 Feb 2025
 18:39:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-11-kerneljasonxing@gmail.com> <20250204175744.3f92c33e@kernel.org>
 <e894c427-b4b3-4706-b44c-44fc6402c14c@linux.dev> <CAL+tcoCQ165Y4R7UWG=J=8e=EzwFLxSX3MQPOv=kOS3W1Q7R0A@mail.gmail.com>
 <0a8e7b84-bab6-4852-8616-577d9b561f4c@linux.dev> <CAL+tcoAp8v49fwUrN5pNkGHPF-+RzDDSNdy3PhVoJ7+MQGNbXQ@mail.gmail.com>
In-Reply-To: <CAL+tcoAp8v49fwUrN5pNkGHPF-+RzDDSNdy3PhVoJ7+MQGNbXQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Feb 2025 10:39:05 +0800
X-Gm-Features: AWEUYZmQIXkstOeyIJPZP_vVKzMniHYvrfhmVb18rqqOtBKYr5MYe6WYRYCZ5uM
Message-ID: <CAL+tcoC5hmm1HQdbDaYiQ1iW1x2J+H42RsjbS_ghyG8mSDgqqQ@mail.gmail.com>
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

On Thu, Feb 6, 2025 at 9:05=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Thu, Feb 6, 2025 at 8:47=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
> >
> > On 2/5/25 4:12 PM, Jason Xing wrote:
> > > On Thu, Feb 6, 2025 at 5:57=E2=80=AFAM Martin KaFai Lau <martin.lau@l=
inux.dev> wrote:
> > >>
> > >> On 2/4/25 5:57 PM, Jakub Kicinski wrote:
> > >>> On Wed,  5 Feb 2025 02:30:22 +0800 Jason Xing wrote:
> > >>>> +    if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
> > >>>> +        SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb=
) {
> > >>>> +            struct skb_shared_info *shinfo =3D skb_shinfo(skb);
> > >>>> +            struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
> > >>>> +
> > >>>> +            tcb->txstamp_ack_bpf =3D 1;
> > >>>> +            shinfo->tx_flags |=3D SKBTX_BPF;
> > >>>> +            shinfo->tskey =3D TCP_SKB_CB(skb)->seq + skb->len - 1=
;
> > >>>> +    }
> > >>>
> > >>> If BPF program is attached we'll timestamp all skbs? Am I reading t=
his
> > >>> right?
> > >>
> > >> If the attached bpf program explicitly turns on the SK_BPF_CB_TX_TIM=
ESTAMPING
> > >> bit of a sock, then all skbs of this sock will be tx timestamp-ed.
> > >
> > > Martin, I'm afraid it's not like what you expect. Only the last
> > > portion of the sendmsg will enter the above function which means if
> > > the size of sendmsg is large, only the last skb will be set SKBTX_BPF
> > > and be timestamped.
> >
> > Sure. The last skb of a large msg and more skb of small msg (or MSG_EOR=
).
> >
> > My point is, only attaching a bpf alone is not enough. The
> > SK_BPF_CB_TX_TIMESTAMPING still needs to be turned on.
>
> Right.
>
> >
> > >
> > >>
> > >>>
> > >>> Wouldn't it be better to let BPF_SOCK_OPS_TS_SND_CB return whether =
it's
> > >>> interested in tracing current packet all the way thru the stack?
> > >>
> > >> I like this idea. It can give the BPF prog a chance to do skb sampli=
ng on a
> > >> particular socket.
> > >>
> > >> The return value of BPF_SOCK_OPS_TS_SND_CB (or any cgroup BPF prog r=
eturn value)
> > >> already has another usage, which its return value is currently enfor=
ced by the
> > >> verifier. It is better not to convolute it further.
> > >>
> > >> I don't prefer to add more use cases to skops->reply either, which i=
s an union
> > >> of args[4], such that later progs (in the cgrp prog array) may lose =
the args value.
> > >>
> > >> Jason, instead of always setting SKBTX_BPF and txstamp_ack_bpf in th=
e kernel, a
> > >> new BPF kfunc can be added so that the BPF prog can call it to selec=
tively set
> > >> SKBTX_BPF and txstamp_ack_bpf in some skb.
> > >
> > > Agreed because at netdev 0x19 I have an explicit plan to share the
> > > experience from our company about how to trace all the skbs which wer=
e
> > > completed through a kernel module. It's how we use in production
> > > especially for debug or diagnose use.
> >
> > This is fine. The bpf prog can still do that by calling the kfunc. I do=
n't see
> > why move the bit setting into kfunc makes the whole set won't work.
> >
> > > I'm not knowledgeable enough about BPF, so I'd like to know if there
> > > are some functions that I can take as good examples?
> > >
> > > I think it's a standalone and good feature, can I handle it after thi=
s series?
> >
> > Unfortunately, no. Once the default is on, this cannot be changed.
> >
> > I think Jakub's suggestion to allow bpf prog selectively choose skb to =
timestamp
> > is useful, so I suggested a way to do it.
>
> Because, sorry, I don't want to postpone this series any longer (blame
> on me for delaying almost 4 months), only wanting to focus on the
> extension for SO_TIMESTAMPING so that we can quickly move on with
> small changes per series.
>
> Selectively sampling the skbs or sampling all the skbs could be an
> optional good choice/feature for users instead of mandatory?
>
> There are two kinds of monitoring in production: 1) daily monitoring,
> 2) diagnostic monitoring which I'm not sure if I translate in the
> right way. For the former that is obviously a light-weight feature, I
> think we don't need to trace that many skbs, only the last skb is
> enough which was done in Google because even the selective feature[1]
> is a little bit heavy. I received some complaints from a few
> latency-sensitive customers to ask us if we can reduce the monitoring
> in the kernel because as I mentioned before many issues are caused by
> the application itself instead of kernel.
>
> [1] selective feature consists of two parts, only selectively
> collecting all the skbs in a certain period or selectively collecting
> exactly like what SO_TIMESTAMPING does in a certain period. It might
> need a full discussion, I reckon.

I presume you might refer to the former. It works like the cmsg
feature which can be a good selectively sampling example. It would be
better to check the value of reply in the BPF_SOCK_OPS_TS_SND_CB
callback which is nearly the very beginning of each sendmsg syscall
because I have a hunch we will add more hook points before skb enters
the qdisc.

I think we can split the whole idea into two parts: for now, because
of the current series implementing the same function as SO_TIMETAMPING
does, I will implement the selective sample feature in the series.
After someday we finish tracing all the skb, then we will add the
corresponding selective sample feature.

But the default mode is the exact same as SO_TIMESTAMPING instead of
asking bpf prog to enable the sample feature. Does it make sense to
you?

With that said, the patch looks like this:
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 1f528e63bc71..73909dad7ed4 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -497,11 +497,14 @@ static void tcp_tx_timestamp(struct sock *sk,
struct sockcm_cookie *sockc)
            SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb) {
                struct skb_shared_info *shinfo =3D skb_shinfo(skb);
                struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
+               bool enable_sample =3D true;

-               tcb->txstamp_ack_bpf =3D 1;
-               shinfo->tx_flags |=3D SKBTX_BPF;
-               shinfo->tskey =3D TCP_SKB_CB(skb)->seq + skb->len - 1;
-               bpf_skops_tx_timestamping(sk, skb, BPF_SOCK_OPS_TS_SND_CB);
+               enable_sample =3D bpf_skops_tx_timestamping(sk, skb,
BPF_SOCK_OPS_TS_SND_CB);
+               if (enable_sample) {
+                       tcb->txstamp_ack_bpf =3D 1;
+                       shinfo->tx_flags |=3D SKBTX_BPF;
+                       shinfo->tskey =3D TCP_SKB_CB(skb)->seq + skb->len -=
 1;
+               }
        }
 }

Thanks,
Jason

