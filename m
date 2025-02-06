Return-Path: <bpf+bounces-50621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 944AAA2A1A5
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 07:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5E33A8400
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 06:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00C8224AE5;
	Thu,  6 Feb 2025 06:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPR9Jm9J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E984C8E;
	Thu,  6 Feb 2025 06:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738825042; cv=none; b=AMtX9f+xaf+/Ujo7SXCfsusSk+v+170SKOi8Xas22CgiWWT1Qoux9DCwGSXtlEzxOMIvsSyF2N34cjGqcOKmPKIeKlhwUQHs5hoSUDo/R8+ZfoCUjcS0qVDUskiRl+B3KvYR6P1DCcxOX7HYUZ9CasSBJg2OYhENUxsZPOcpp2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738825042; c=relaxed/simple;
	bh=0VWbUmFlJ2h6hG/4I0Umu/lAWDE5xP4eXIkM9Ehu6CU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=juJHT6G+F+Spw63L5d+irg+R3DoFbcBrKGgYtd+xrGwQo7eBSAJuav/xc0VxwPVrYoXIZkZ8YFAzaRewK3OWQMpSB+9xmo/HhnIN3FN13gk+syfTL5u3JD/qSAel+Ir2fFCUlaR9IWAnBrVbUZ+K80zB/1a3gNSgO5jKG2/RTRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPR9Jm9J; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-844e10ef3cfso50384039f.2;
        Wed, 05 Feb 2025 22:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738825040; x=1739429840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VWbUmFlJ2h6hG/4I0Umu/lAWDE5xP4eXIkM9Ehu6CU=;
        b=aPR9Jm9JbxXwP6TJ8k2zwKkAWT6KhMdih4t633HboGwBgg05TzjwSvUtdtC36nDuRW
         nLymNb3TWpOhMwB2qzC1IitGQ0V372X+59iM/km1cctNuhPnaRtMO9n/XHQ93ysWFx8V
         8f1MDCmPsrrrPb7h6Z8/6k38vY0Gb5fVTTaXd/tVPGrZ1c2VgmYmqP5+vrTmjH/2Wu3x
         v4nyau0kclnsFh+s7c937lRLOlj8lJdcjP4GFo5sNpo9xhyElhGe7Ep/KNel3TjeivpF
         9Wclz7PntvtCMweldWN7YDpHn/hHQu6oFuxeaw7kKIeyFlli/z7DV3PLw31P3dtoSNBL
         O1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738825040; x=1739429840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VWbUmFlJ2h6hG/4I0Umu/lAWDE5xP4eXIkM9Ehu6CU=;
        b=ueUm6hQkVL+EwYWx3m21gGr49ofQjntRiVhbsoA7cbVq/CF3W0ViRHO+w5UQ6anFBw
         RcJbb3Pob435wYxiOtNq4aQRDIG0PwaElLmnbiX9wZU3PaEwmP6ubljMHF/sMi3rtB4D
         2Hc7u4TpMDF1LaG2PM4hh7243ZsmTcLb5dINXSltSpvDbYh84sqOnseKsJmnWJt69abj
         zy9SiKRFjEUQ5TprH4zf93k4VlxmctG3SkgNARxmyXNVbIluu5ZHfsJOYYty1tIU/CW7
         5ag+KYSaTGymflMoPDliXrBhqOpRQBDnohjxUaVjqUSh56qMYcqPx900SI2jikaeoLhq
         4PdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKW9JDB9cADKhTLIAppVfZCI917ZxxNBxW+pR5HCs/67aSTK2m0Bsvaqi9kBz+c514ogI=@vger.kernel.org, AJvYcCVw0gGNimJ0xthbymPLc7JQpWWQT4k2bwtUDGuQTGiMukY8NGirbTmfjVod80zC4Daz+QWqCopR@vger.kernel.org
X-Gm-Message-State: AOJu0YwYmJik4GEvuMBJAzc06WIGL6nrMx8hCC/kzxDqDgPUqKF86/Zp
	+/In8W9OmbUiX2KNyQORa+Xz73QL03KJjWoZpn4ZZ7AAH6jD5MO4SBMGKWRpI4RmX4U7O+MooQk
	doK9g/aXB/I/NWTpzky7HA7z8Bg8=
X-Gm-Gg: ASbGncuvpI44mPobWtTjpFdCd6y3fm3Whii2CJI+sdNtYokAFvsw1RDM8dwkQvHdBaw
	YcXZ0lQR3jKN2iIemGBc2MUAGgnhOZwPjVSWTUtRv63zbZh8rlMk08mdZXlxT6N54YEa2fxw=
X-Google-Smtp-Source: AGHT+IE7bEP71tw89uKuITjpYd5NfvQDN1Aqgd48CmZ5ijoGejMAsRp6uMOZZ//GOjraKBIk74xJIQcSYzP6HjbNi+s=
X-Received: by 2002:a05:6e02:3883:b0:3d0:1ba7:853 with SMTP id
 e9e14a558f8ab-3d04f59feeemr65059745ab.8.1738825039917; Wed, 05 Feb 2025
 22:57:19 -0800 (PST)
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
 <CAL+tcoC5hmm1HQdbDaYiQ1iW1x2J+H42RsjbS_ghyG8mSDgqqQ@mail.gmail.com>
 <67a424d2aa9ea_19943029427@willemb.c.googlers.com.notmuch>
 <CAL+tcoCPGAjs=+Hnzr4RLkioUV7nzy=ZmKkTDPA7sBeVP=qzow@mail.gmail.com>
 <67a42ba112990_19c315294b7@willemb.c.googlers.com.notmuch>
 <CAL+tcoC_5106onp6yQh-dKnCTLtEr73EZVC31T_YeMtqbZ5KBw@mail.gmail.com> <b158a837-d46c-4ae0-8130-7aa288422182@linux.dev>
In-Reply-To: <b158a837-d46c-4ae0-8130-7aa288422182@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Feb 2025 14:56:43 +0800
X-Gm-Features: AWEUYZl-Q7bgMD0-8JLuVfLSSt702oBhforuyaz7gVcg0eZ3-v94cOoIXe7jf10
Message-ID: <CAL+tcoCUjxvE-DaQ8AMxMgjLnV+J1jpYMh7BCOow4AohW1FFSg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 10/12] bpf: make TCP tx timestamp bpf
 extension work
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	dsahern@kernel.org, willemb@google.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 2:12=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 2/5/25 7:41 PM, Jason Xing wrote:
> > On Thu, Feb 6, 2025 at 11:25=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> >>
> >>>>> I think we can split the whole idea into two parts: for now, becaus=
e
> >>>>> of the current series implementing the same function as SO_TIMETAMP=
ING
> >>>>> does, I will implement the selective sample feature in the series.
> >>>>> After someday we finish tracing all the skb, then we will add the
> >>>>> corresponding selective sample feature.
> >>>>
> >>>> Are you saying that you will include selective sampling now or want =
to
> >>>> postpone it?
> >>>
> >>> A few months ago, I planned to do it after this series. Since you all
> >>> ask, it's not complex to have it included in this series :)
> >>>
> >>> Selective sampling has two kinds of meaning like I mentioned above, s=
o
> >>> in the next re-spin I will implement the cmsg feature for bpf
> >>> extension in this series.
> >>
> >> Great thanks.
> >
> > I have to rephrase a bit in case Martin visits here soon: I will
> > compare two approaches 1) reply value, 2) bpf kfunc and then see which
> > way is better.
>
> I have already explained in details why the 1) reply value from the bpf p=
rog
> won't work. Please go back to that reply which has the context.

Yes, of course I saw this, but I said I need to implement and dig more
into this on my own. One of my replies includes a little code snippet
regarding reply value approach. I didn't expect you to misunderstand
that I would choose reply value, so I rephrase it like above :)

>
> >
> >>
> >>> I'm doing the test right now. And leave
> >>> another selective sampling small feature until the feature of tracing
> >>> all the skbs is implemented if possible.
> >>
> >> Can you elaborate on this other feature?
> >
> > Do you recall oneday I asked your opinion privately about whether we
> > can trace _all the skbs_ (not the last skb from each sendmsg) to have
> > a better insight of kernel behaviour? I can also see a couple of
> > latency issues in the kernel. If it is approved, then corresponding
> > selective sampling should be supported. It's what I was trying to
> > describe.
> >
> > The advantage of relying on the timestamping feature is that we can
> > isolate normal flows and monitored flow so that normal flows wouldn't
> > be affected because of enabling the monitoring feature, compared to so
> > many open source monitoring applications I've dug into. They usually
> > directly hook the hot path like __tcp_transmit_skb() or
> > dev_queue_xmit, which will surely influence the normal flows and cause
> > performance degradation to some extent. I noticed that after
> > conducting some tests a few months ago. The principle behind the bpf
> > fentry is to replace some instructions at the very beginning of the
> > hooked function, so every time even normal flows entering the
> > monitored function will get affected.
>
> I sort of guess this while stalled in the traffic... :/
>
> I was not asking to be able to "selective on all skb of a large msg". Thi=
s will
> be a separate topic. If we really wanted to support this case (tbh, I am =
not
> convinced) in the future, there is more reason the default behavior shoul=
d be
> "off" now for consistency reason.

Yep, another topic. At that time, I particularly noticed that Jakub
said "all skbs" which you agreed with, so I felt reluctant...

> The comment was on the existing tcp_tx_timestamp(). First focus on allowi=
ng
> selective tracking of the skb that the current tcp_tx_timestamp() also tr=
acks
> because it is the most understood use case. This will allow the bpf prog =
to
> select which tcp_sendmsg call it should track/sample. Perhaps the bpf pro=
g will
> limit tracking X numbers of packets and then will stop there. Perhaps the=
 bpf
> prog will only allocate X numbers of sample spaces in the bpf_sk_storage =
to
> track packet. There are many reasons that bpf prog may want to sample and=
 stop
> tracking at some point even in the current tcp_tx_timestamp().

Completely agreed, this is also what I did in my kernel module. Willem
once mentioned that Google also uses the sample feature, IIRC. So for
sure I will complete it soon in this series. Thanks for your
information, BTW. I will quote it :)

---
More discussions/suggestions are welcome since I've already proposed
_tracing all the skbs_. The idea behind this is to let this bpf
extension help us get enough information about kernel (especially
stack) behaviour.

The goals are:
1) much less side effects on the normal flows due to so_timestamping
feature compared to normal bpf* related trace method.
2) have a deep insight/understanding of where those latencies exactly
come from. I've encountered TSQ limits (please see tcp_write_xmit(),
there are more controls) with virtio_net driver. So maybe hacking the
tcp_write_xmit() is needed.
3) Only trace the last skb from each sendmsg might not be enough if
the latency arises in the kernel. If one of skbs is missed, we will
never know what happens to that skb.

Based on the above, I'd like to make it into an optional choice
provided to users if they want to take a deep look inside the kernel.

Thanks,
Jason

