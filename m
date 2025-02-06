Return-Path: <bpf+bounces-50592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C63A29EA3
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 03:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67AB57A3D89
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 02:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0858C83A14;
	Thu,  6 Feb 2025 02:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoGDuG+m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAE823CE;
	Thu,  6 Feb 2025 02:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738808129; cv=none; b=HqwPsYFKCy8GfV3OJQkZTFzZbi593eU9FHUnniSm0KzPgtL/dtZdeufqxYRzv3dq1e5QqC4ARBcwvKF9EINZDkwz4/czCO7IfDAlqUaRASmgqhAaQNEyqu0cKVShDWDRhO5hGF109F8vJzZU/D6ClXH+G7ExR5oBLctimJxeZeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738808129; c=relaxed/simple;
	bh=bYtT4kCtOsX9y5HeblxSM9JmLjihn2DIoKDhNk3oqY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ek8H5oCeQ+u8b9LZfK85+bl7Ay1sy0fdh4G7/g4Ur1/wGFtuou8iD+alOkEJcLHkRqyL3xkipkkAZA9VaNc4IElqAqtOcQ9UNP+Nbp49pPj/jMhfyXWPaJrBD1VFASapbCFgLv/Webut3erGKYzuakTYZ7Rc25XrmHbHEiWI4U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OoGDuG+m; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-84cdacbc373so17418739f.1;
        Wed, 05 Feb 2025 18:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738808127; x=1739412927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFJOgQB4BvQz0kFxcSF8bPMGP2TyNp74xWrYgZwxmos=;
        b=OoGDuG+moqIrAFHE0+9E7mSTaPKnslht8UlPtP2WaFZndKwJLgIJLVxkMqu5LuEA2k
         zMfhh8/ycLJgzXiu/5nTZwQb11aeoWamLO/qiGC3HRd+eF9LvPime1xM9pLKh4oHLxJB
         VMSrERoQCg2wQ45WxaABgG+814pw1j2NRz/jbS+ULK5XiUpi897mEJ9K4vDXaXgfLtHK
         mXybWNp7Le+l6pJyhEgDdtihZmwD5tiQD2e5cXtYPEwIqN9WttNBoaySi/uzdOPKuB24
         HcpB/NCojyMMEXr4regsHli/EV3u1jCPzGBKVXHScpOvltGSR47mu5ZhbuqwPnBUnO1P
         KyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738808127; x=1739412927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFJOgQB4BvQz0kFxcSF8bPMGP2TyNp74xWrYgZwxmos=;
        b=NoAEypDvroZOnRHO5aO2dHGaQBlJPgmWsdtfnfzpwTuqZasU8HKTqBn7GQ+wpU6D/h
         mq2NJKSmMjjjs9Ozyd/RYcvRp+xxP3U/K0FON6py6RWNQGhlfESLGqnuS0ACDYodlOpS
         L+zTbsOBAP7ZRU1vs2Nw8pYR1ze23qtdJKFujHcGvUBdsTVH59klwyIkA4C5WdUNVnEq
         kbwYP8zClVP8KjieqLldHJpkR5BHiUyjc9iz2KXTw1LBEOPq1k3vfwAJu0yHlaiC/fcI
         lI96+YJg/4kqNYvT2U4sRGqyS74wpolJfPBnvBkbhS9Iu2Zt0BlLN9U0magcaF94S3xR
         B4MA==
X-Forwarded-Encrypted: i=1; AJvYcCWIKUGTrsrFGhxpmUDW5eUGUoMkxqXnS7b9rbzacBueNRNvQeJcdIXBGGhQ8vmBo59UGRY=@vger.kernel.org, AJvYcCWcecteJI8vpDy73/64lMLWBdA7YgJoCjxhZ1MvQoa9AScf5pgvQxm2PHhXN+Vzp4W/+ShdtSm7@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf/fxCO1hQPygtPx3ylsxT+8CQa0v2924+brWqjripkajD7x7i
	ZFuzMlo2w+pfbTQ1EC9Wh7wS4RgvONFXCcms2Zdei4qhy5prU3xYpPM+sUIfXF0c5GFFTAfRzN4
	01ctwxmZg2Q8xhlzdgVRwfK3TEis=
X-Gm-Gg: ASbGncs7HPP+2gkMkGleCVX4/Pa8WOmMTh1MKi95ET/1eYkpKgNL64WYIMocas+0X3E
	eF0AlaiiuY/5xGcWCoF7wRMvn6fAdCgRKy3eueR9Su+ZF8xDbSSbMFDawfwNlXtTVo7vZm54=
X-Google-Smtp-Source: AGHT+IERfaZUcgR+uy6HNwTEwqIlwRlaivLWdsRMVY8O0s/xrypEIiFAy/gsao582++bvkJM6gxt7MJQEOmWHWnefOk=
X-Received: by 2002:a05:6e02:2188:b0:3cf:b87b:8fd4 with SMTP id
 e9e14a558f8ab-3d04f8f6fd6mr45555505ab.15.1738808127127; Wed, 05 Feb 2025
 18:15:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-13-kerneljasonxing@gmail.com> <67a389af981b0_14e0832949d@willemb.c.googlers.com.notmuch>
 <CAL+tcoC6egv7dTqESYy8Z80OoacvjgxLvsTXukUZZDgbLxH8AA@mail.gmail.com> <c329a0c1-239b-4ca1-91f2-cb30b8dd2f6a@linux.dev>
In-Reply-To: <c329a0c1-239b-4ca1-91f2-cb30b8dd2f6a@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Feb 2025 10:14:50 +0800
X-Gm-Features: AWEUYZmbUqaXpJ13vHPGNsCYi8BqO8H9JsV4edkiRf5DcbZvA31ORW4FHZCzy88
Message-ID: <CAL+tcoCY=03zt3RBJP0G8+8hC1oC+o2h67MdqrmEkjM3-y-gZQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 12/12] selftests/bpf: add simple bpf tests in
 the tx path for timestamping feature
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 9:28=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 2/5/25 8:08 AM, Jason Xing wrote:
> >>> +     switch (skops->op) {
> >>> +     case BPF_SOCK_OPS_TS_SCHED_OPT_CB:
> >>> +             delay =3D val->sched_delay =3D timestamp - val->sendmsg=
_ns;
> >>> +             break;
> >>
> >> For a test this is fine. But just a reminder that in general a packet
> >> may pass through multiple qdiscs. For instance with bonding or tunnel
> >> virtual devices in the egress path.
> >
> > Right, I've seen this in production (two times qdisc timestamps
> > because of bonding).
> >
> >>
> >>> +     case BPF_SOCK_OPS_TS_SW_OPT_CB:
> >>> +             prior_ts =3D val->sched_delay + val->sendmsg_ns;
> >>> +             delay =3D val->sw_snd_delay =3D timestamp - prior_ts;
> >>> +             break;
> >>> +     case BPF_SOCK_OPS_TS_ACK_OPT_CB:
> >>> +             prior_ts =3D val->sw_snd_delay + val->sched_delay + val=
->sendmsg_ns;
> >>> +             delay =3D val->ack_delay =3D timestamp - prior_ts;
> >>> +             break;
> >>
> >> Similar to the above: fine for a test, but in practice be aware that
> >> packets may be resent, in which case an ACK might precede a repeat
> >> SCHED and SND. And erroneous or malicious peers may also just never
> >> send an ACK. So this can never be relied on in production settings,
> >> e.g., as the only signal to clear an entry from a map (as done in the
> >> branch below).
>
> All good points. I think all these notes should be added as comment to th=
e test.

Got it, I will add them in the commit message.

> I think as a test, this will be a good start and can use some followup to
> address the cases.

Good idea.

>
> >
> > Agreed. In production, actually what we do is print all the timestamps
> > and let an agent parse them.
>
> The BPF program that runs in the kernel can provide its own user interfac=
e that
> best fits its environment. If a raw printing interface is sufficient, tha=
t works
> well and is simple on the BPF program side. If the production system cann=
ot
> afford the raw printing cost, the bpf prog can perform some aggregation f=
irst.
>
> The BPF program should be able to detect when an outgoing skb is re-trans=
mitted
> and act accordingly. There is BPF timer to retire entries for which no AC=
K has
> been received.

Oh, first time to know the BPF timer.

>
> Potentially, this data can be aggregated into the individual bpf_sk_stora=
ge or
> using a BPF map keyed by a particular IP address prefix.
>
> I just want to highlight here for people in the future referencing this t=
hread
> to look for implementation ideas.

Thanks, I think they are useful! I will copy more description in the
commit message.

Thanks,
Jason

