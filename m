Return-Path: <bpf+bounces-49275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD216A1620C
	for <lists+bpf@lfdr.de>; Sun, 19 Jan 2025 14:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C723A5837
	for <lists+bpf@lfdr.de>; Sun, 19 Jan 2025 13:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663B91DED6B;
	Sun, 19 Jan 2025 13:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJe4XEss"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7800F184;
	Sun, 19 Jan 2025 13:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737293978; cv=none; b=mI7G2qUYDAxM2tILQfNJp6rzSKI/bjV2f7J1CNCCiAxMwftF2FpG/UY6o53gzby/FcRErHq3QO99n+E40vCSopmFVFi1Gr/CzfgMoWBz+bFjzuH1JHUEeAysoaFyioWpmMFqIyH4Tz3nlbO6XPKXmKWcaVs6/sihWXimLEL3cDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737293978; c=relaxed/simple;
	bh=AOrMseePuFZUh7P1yTJm/E/Na9Q68+1r2WXcc8MChlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/ax8xe4QL1Y+MBMRPvCThNwu9kEmZ3wXFwECRZSz/3y0FEucB/bI8mkEVxUbU4vh3t2Ujf1FTYeuwfsLQK8w11A5XTq8sFAGw1uugBtu6dPyvICRjPqM8pLuBOyCpfJ8tuN2fKY8NBzpTF3x1cPd/HgVMjcYTXfcWnQrU9fwXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJe4XEss; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3ce915a8a25so12681315ab.1;
        Sun, 19 Jan 2025 05:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737293975; x=1737898775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyLW6Nb+BwKq6P0lAx9OQ8RLychDMbpqf1N3HwTHDZY=;
        b=aJe4XEsspOD5EUNRTllNmIWPngB0emEw8A11BbZ2t+lJJYqfMuyPZQ4J373MKXMN2t
         qvZIkyXlfRTJPiDwf8I8tYnvrUp8w79y+GOcnhzMWJovO/EzXBue/RevFao7H+IEuUjY
         IwZ7R4Ni6XpAV+Y5uICyDqKe+UNfJxOQze5aOj7cOz/kmZUj8LERlmst/pwLFuMH71OR
         aOPueDD7ACGPRi7erDO8McP5evH0AOEvRlgFSAWyABZhh2tDoxUeI7vweK4wFlO+V5mm
         lA9n3orbtL7xIHBDcbKorXlh1LUFdSag6mT51G2h0/BglKSxiPYxluqoxeY7Exq9wrBX
         +4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737293975; x=1737898775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZyLW6Nb+BwKq6P0lAx9OQ8RLychDMbpqf1N3HwTHDZY=;
        b=hj01Wb3rqXntt5wNJgLHy+fPTLJ6zMhwl4QlOZK8Af+pwQBlFElw90byyrpD7iJWs9
         NpfAU9aDq1Fqhz5+NP1RBpgvPJDyocjYSB0zf9EAK3KYeKMzVKWsp6DS8vyMkEg6rOdT
         Q3g608xepbY+tWRiBuXAJPBsBSBK14Kq3WLI6UAYfjgeeau4yS05+YkQrVkN9ql9jTqV
         uu2IxO/BhgCXoOV5MyQvYs2YcqtrmdojMi8jtDsQQabiaVNzqW696zObj033JPwCch2n
         E3yTsX8M7YlxbhuTgdYh+S56hC0r4kdawCDZkiFIgCZrIkd41i8GVNAp8V8iWBdzH0UW
         OwVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbseT25Bt8ExqO60VT4iK9huHyEdtSnnZrxVo1kWRu1AqE0urPfZxyykjUxdcOsIkUHyJqO6Xt@vger.kernel.org, AJvYcCXForEVrk1+9Lm4wbTW8Sby5G8wpbly7AzcQJdeEGblqEh4jRQ34LDj/SpcJZZRhIzF0v4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9yhOf9M04RmXaIfEfSpHDhXal3H3vBh2AwoS6IQhwdc6jvF1a
	EEVAmZR9Rq5NhjHY5mTZP3KR7UOpC28JJS15q70Wz+wbUoW/Anhy8Bhu4qeZd5rN6N3rJnZyOpJ
	jT3AVUnYgSr2eIHy54+yll7x/EDU=
X-Gm-Gg: ASbGncsd054/mvGWlagW3QfCwmgRgdY3DAX+Gu2MYG7mp4450Ahy7KebpRZAG0fDF4b
	25L57wLoceYHV4EyKyeAscLLhanSbJSV/42vHSgn4boNIm1T2bQ==
X-Google-Smtp-Source: AGHT+IGg8f5eZQpNG0ez0cD3+Qd900BX8NgeG34bZBtsWI0SwjFcmMMHiIRdbgZUx1flVCz4zipAhuZnahViiVY0eKA=
X-Received: by 2002:a92:cda7:0:b0:3ce:7bf1:526 with SMTP id
 e9e14a558f8ab-3cf7449615bmr65232265ab.16.1737293975391; Sun, 19 Jan 2025
 05:39:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-9-kerneljasonxing@gmail.com> <ef391d15-4968-42c6-b107-cbd941d98e73@linux.dev>
 <CAL+tcoC+bXAPP94zLka5GcwbpWNQtFijxd0PcPnVrtS-F=h6vQ@mail.gmail.com>
 <fc4dd0d9-d4ae-4601-be01-5fad7c74e585@linux.dev> <CAL+tcoCJiaO4o8y56k2p8aePzkoE6SHXc7o4hEAc+D_hw7K8+A@mail.gmail.com>
In-Reply-To: <CAL+tcoCJiaO4o8y56k2p8aePzkoE6SHXc7o4hEAc+D_hw7K8+A@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 19 Jan 2025 21:38:59 +0800
X-Gm-Features: AbW1kvYYkcgXuSflECjdY2MrJtceOthRWr7W8YSTvTDsAPkFjt5asG1IdnfhtZU
Message-ID: <CAL+tcoDwa-iZhZzx+vdW97Bqk28_CBOUgyhuiHv=q213v09aiA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 08/15] net-timestamp: support sw
 SCM_TSTAMP_SND for bpf extension
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

On Sat, Jan 18, 2025 at 9:43=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Sat, Jan 18, 2025 at 8:47=E2=80=AFAM Martin KaFai Lau <martin.lau@linu=
x.dev> wrote:
> >
> > On 1/15/25 3:56 PM, Jason Xing wrote:
> > > On Thu, Jan 16, 2025 at 6:48=E2=80=AFAM Martin KaFai Lau <martin.lau@=
linux.dev> wrote:
> > >>
> > >> On 1/12/25 3:37 AM, Jason Xing wrote:
> > >>> Support SCM_TSTAMP_SND case. Then we will get the software
> > >>> timestamp when the driver is about to send the skb. Later, I
> > >>> will support the hardware timestamp.
> > >>
> > >>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > >>> index 169c6d03d698..0fb31df4ed95 100644
> > >>> --- a/net/core/skbuff.c
> > >>> +++ b/net/core/skbuff.c
> > >>> @@ -5578,6 +5578,9 @@ static void __skb_tstamp_tx_bpf(struct sk_buf=
f *skb, struct sock *sk, int tstype
> > >>>        case SCM_TSTAMP_SCHED:
> > >>>                op =3D BPF_SOCK_OPS_TS_SCHED_OPT_CB;
> > >>>                break;
> > >>> +     case SCM_TSTAMP_SND:
> > >>> +             op =3D BPF_SOCK_OPS_TS_SW_OPT_CB;
> > >>
> > >> For the hwtstamps case, is skb_hwtstamps(skb) set? From looking at a=
 few
> > >> drivers, it does not look like it. I don't see the hwtstamps support=
 in patch 10
> > >> either. What did I miss ?
> > >
> > > Sorry, I missed adding a new flag, namely, BPF_SOCK_OPS_TS_HW_OPT_CB.
> > > I can also skip adding that new one and rename
> > > BPF_SOCK_OPS_TS_SW_OPT_CB accordingly for sw and hw cases if we
> > > finally decide to use hwtstamps parameter to distinguish two differen=
t
> > > cases.
> >
> > I think having a separate BPF_SOCK_OPS_TS_HW_OPT_CB is better consideri=
ng your
> > earlier hwtstamps may be NULL comment. I don't see the drivers I looked=
 at
> > passing NULL though but the comment of skb_tstamp_tx did say it may be =
NULL :/
>
> Yep, I was trying not to rely on or trust the hardware/driver's
> implementation, or else it will let the bpf program fetch the software
> timestamp instead of hardware timestamp which will cause unexpected
> behaviour.
>
> After re-reading this part, I reckon that using this SKBTX_IN_PROGRESS
> flag is enough to recognize if we are in the hardware timestamping
> generation period. I will try this one since it requires much less
> modification.

For the record only, SKBTX_IN_PROGRESS cannot represent if we're
generating the hardware timestamp. For example, in I40e driver,
i40e_xmit_frame_ring() calls i40e_tsyn() to set SKBTX_IN_PROGRESS
before generating the software SND timestamp in i40e_tx_map() by
calling skb_tx_timestamp().

Therefore, I will use the current patch directly.

Thanks,
Jason

