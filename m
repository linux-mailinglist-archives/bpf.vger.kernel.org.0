Return-Path: <bpf+bounces-50766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A479EA2C3C3
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 14:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B51DE3AA788
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 13:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4441F4191;
	Fri,  7 Feb 2025 13:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGdcbgRM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36C11A5BB1;
	Fri,  7 Feb 2025 13:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935312; cv=none; b=t1ijPaKvDZuAwXFSjiWinIPrs06/BdY6Z46YKYaQxrbg+3xGwTCyvIFVbtm0+2XW+Q/WdUCmyXLMl3+ZcoYp++za7G5azLHSuyWSzXuQqx0E4yGL89kUiyn/hAd6YudMd0ei8L0ybF+GDtT7UP+bXeyy4NRH5BENA6TrhfzvxFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935312; c=relaxed/simple;
	bh=vY1bOS/eum+ZjHSSi6snToo0JUebutpJNRJprO0sdOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W9/sMMFF9lIBDK+u/puxnqTw1hbcGQr30a4qpQ8dzzQO8+/fuZyYiSyNVpVEoYySdKy7scEOfhzTjzLIfIQGgf+fCmVRM8D2SSWEbOb9OzPtvWcRl0W++xzS1ENfC5r61kM7Jydn9RvfCAXPDGNDnTfVR5uzxtQ867n5lfKEBmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGdcbgRM; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d04d655fefso17446875ab.3;
        Fri, 07 Feb 2025 05:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738935310; x=1739540110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1rbN1kyJhZtSFWy60iFcf++JcmL12EiVI3WC4zT40U=;
        b=kGdcbgRMqK0sy6kpPKmPLDjwtzUvxmI8HaqG8fR6Y9RJUtvoRWXHZWOzFi46w+AWf+
         6C9QU1jefXrnRLjfEHERDJ60TXlYAHr6Mptz+J1iEh/N0WLqEzjMecmnbqoF99YsLnjH
         blo8HxsQdYnRKMYKJ2oFS3GJTdcT7EYlFPNaEve3d9cUdhuxER+B/gzD/a0cI69dmVZG
         syXOATgNWEVh1U82us+Zs0uIv2EJNTNTKofhoZv/Uu75VwZOtckQwqLYYWOKgx4c3Rl5
         8vkI5KA55rkDybH8cIGjYMQkUudGrWaslAlp4pIcdSVPB8HA+0FjsBgQnyBMCpDSos2w
         WchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738935310; x=1739540110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1rbN1kyJhZtSFWy60iFcf++JcmL12EiVI3WC4zT40U=;
        b=Hfl5YX1BVjcQ6QbhjuBsdqtTnkMD8+WWbYrVeyQMG7b10o37tJ5rGo3OYQ2bm7TERC
         Qn1KQvnW+bF9ZAUtaM33c863xsgljthqGc5yE/4tS7QmSwnECmu6FWlSwi4lfn2atDaF
         /CTJDkgZdRQ6N5Kysba3sBkN1bs9Vs13C6SXDtclT5dmSFAR9hT5NYNxSa0cPfBV+fEd
         xpUQS9c9s0SN/zjIv1ytoISqJ6T573yTWBkN7CxNex7eddliz0kRWR4fPmDbC+q8oWks
         qV6kQX4bXrOhXbrAno8I8ionktJ/uAFyx8kXzs6QVoEXatRI3J9RcOjaznayhAMn7ZAl
         oZ5g==
X-Forwarded-Encrypted: i=1; AJvYcCVewL3vKA6I6vGjNWQnJYkad5BS9z36ujADX5BoJA1R0Voa9tEUKAF8uuJleDNzhpxx+X+ms7is@vger.kernel.org, AJvYcCXNNM0WoN1x6FrU5wStx447dgIUV9hvKGZhXjpjdhhq44iyAGH9BmDWsqRlYSPSZsqdvk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmZzmL5oKxEgdnMW+4kCNcd3r3Bru7JiRtVziIheLTI6VaCEQj
	4tv93hI53gS4vPE2qsI2xlVdL4QriFqTk3zBtaFf2C1eGKeD/sUG47k14D69eOBR1BX74WP3mB+
	no0tdzkTrT4Lbij7TOyQjZH8PDnjzMQNwIOCV7w==
X-Gm-Gg: ASbGncs5mr1DcJSGbeb+qM4pwK2/IgtFdl55vUXZxFFcZUr4m3HcJ5NuZ5nRS2Zw8lZ
	wcTrnFei02F9Xo52DliGbb8pDppVu5La9ypS70fg9I9fQE5nxC0cHDNBDI1BkmCYJ8nRZmDhc
X-Google-Smtp-Source: AGHT+IES5rVLZOf/UVlLT9BZGHdOYu6CE+b8aXL5spCx4XiVOrbok6X4DRYffGjknCfdHTLqo5gBwe9gHu9v+bnBxhk=
X-Received: by 2002:a92:c263:0:b0:3cf:f88b:b51a with SMTP id
 e9e14a558f8ab-3d13dcfce6cmr25963575ab.2.1738935309702; Fri, 07 Feb 2025
 05:35:09 -0800 (PST)
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
 <CAL+tcoC_5106onp6yQh-dKnCTLtEr73EZVC31T_YeMtqbZ5KBw@mail.gmail.com>
 <b158a837-d46c-4ae0-8130-7aa288422182@linux.dev> <CAL+tcoCUjxvE-DaQ8AMxMgjLnV+J1jpYMh7BCOow4AohW1FFSg@mail.gmail.com>
 <739d6f98-8a44-446e-85a4-c499d154b57b@linux.dev>
In-Reply-To: <739d6f98-8a44-446e-85a4-c499d154b57b@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 7 Feb 2025 21:34:33 +0800
X-Gm-Features: AWEUYZm6WNHjuSs7mQCHIFvotgjIiK9WGdoU-XRw6scHDKV5BZ2JZ1tEgyb7RQk
Message-ID: <CAL+tcoCEw7ppu7OvgOhcb=oeJLi4ZwhVdCHuHVSkhP8gEcpVDg@mail.gmail.com>
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

On Fri, Feb 7, 2025 at 10:07=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/5/25 10:56 PM, Jason Xing wrote:
> >>> I have to rephrase a bit in case Martin visits here soon: I will
> >>> compare two approaches 1) reply value, 2) bpf kfunc and then see whic=
h
> >>> way is better.
> >>
> >> I have already explained in details why the 1) reply value from the bp=
f prog
> >> won't work. Please go back to that reply which has the context.
> >
> > Yes, of course I saw this, but I said I need to implement and dig more
> > into this on my own. One of my replies includes a little code snippet
> > regarding reply value approach. I didn't expect you to misunderstand
> > that I would choose reply value, so I rephrase it like above :)
>
> I did see the code snippet which is incomplete, so I have to guess. afaik=
, it is
> not going to work. I was hoping to save some time without detouring to th=
e
> reply-value path in case my earlier message was missed. I will stay quiet=
 and
> wait for v9 first then to avoid extending this long thread further.

FYI, the code I adjusted works, a little bit ugly though.

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index ad4f056aff22..44b4f8655668 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -498,10 +498,13 @@ static void tcp_tx_timestamp(struct sock *sk,
struct sockcm_cookie *sockc)
                struct skb_shared_info *shinfo =3D skb_shinfo(skb);
                struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);

-               tcb->txstamp_ack =3D 2;
-               shinfo->tx_flags |=3D SKBTX_BPF;
                shinfo->tskey =3D TCP_SKB_CB(skb)->seq + skb->len - 1;
-               bpf_skops_tx_timestamping(sk, skb, BPF_SOCK_OPS_TS_SND_CB);
+               if (bpf_skops_tx_timestamping(sk, skb,
BPF_SOCK_OPS_TS_SND_CB)) {
+                       tcb->txstamp_ack =3D 2;
+                       shinfo->tx_flags |=3D SKBTX_BPF;
+               } else {
+                       shinfo->tskey =3D 0;
+               }
        }
 }

I'm not sure if it meets your requirement? The reason why I resorted
to this method is because I failed to attempt to use kfunc and
struggled to read many btf codes :(

So please provide more hints so that I can start again. Thanks.

Thanks,
Jason

