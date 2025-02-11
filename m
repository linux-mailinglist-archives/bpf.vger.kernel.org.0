Return-Path: <bpf+bounces-51070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC85A2FEB0
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 01:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7F71166893
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 00:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975C01D5CDE;
	Tue, 11 Feb 2025 00:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K65ICpft"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F631BFE00;
	Tue, 11 Feb 2025 00:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739232068; cv=none; b=iI9qXfjmGOK4rw1yZ8dgGkWl1dJ2WhMYlrUJopXwdod5L/T6QwWUuvXiYMQX8pbXKCFFC3+oyHetcFp13ebYre887LNiXn+nSQ2+t7o2Hxm/AIv3jrmzkXyD7/6mm7aNwSsCitvNgV5SSvXe5DSKNtt+MWOoj6eXvJM/xdy+mu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739232068; c=relaxed/simple;
	bh=LtNu0hLLYWkIDqE1WjVUidT6v1gAK5mlfHR7MROpIoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYvlAUIpJ4J0ZXgjzsSurASsrs9Yv7fVJGh/gvXtBpOe2vi+QGXkbcERgN/yUSwbTRKk8uQuvmrjNA4QgY8G2TXhtn3rZePJZZH56H3V8N9XQf6pf9FR+EkaAYnORbl0PdO65uywtq5XdiFZWc9aMovS2gHRLVoz/c8tCpnwewI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K65ICpft; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3cf82bd380bso41469605ab.0;
        Mon, 10 Feb 2025 16:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739232065; x=1739836865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvs+SrA5yj3ot/zdCGwqMLGtc//Fs99RUqtk+u6og/A=;
        b=K65ICpftrDvmvakRIAsI9dXD6JrMdvap72KRSmU0fZVdxRKkhDF20s4CAwo7KAkAo9
         JMVP6lNw//rawpSqsU9AdWRjniPJQrsWrDmWEyG6DXAOih5rAjlrd96ZcPH51oqhqvjC
         GedyIkC5fghAxH/PIjgN/UMb0pq0Rmk8f51GU6UmuAYVpoIPTccNVv4EiqpW8ALSneEc
         1fvT4XAX5WUUsD/t9pNcWe7164Sbe04bQg0AGXf9Emy27J4HBuHg0UvkL/C86W6EDxUl
         aDijvi+4gXf2iEBRaKBsWGTF6xFjUb4ayXqwwQSf3r0ZWSI3/ifFMLkaqkRgZeZ01qmQ
         tGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739232065; x=1739836865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvs+SrA5yj3ot/zdCGwqMLGtc//Fs99RUqtk+u6og/A=;
        b=RwTiM2ls+WthECD8Nw+TkaUfCUndGcmBD6b7LygtprBch/35BMkaPG2x7aT2mg98pj
         oFK0mBGS0kLeGfydS1AG6dsIUyDbHmpWdm554GZIYZqJnkePst6lgvhzFBof4qr8rC4G
         FC/Bpj6uSeLukFSF3O+plu7CWjbPkR4RWhkBc23gYX57dQE49pUdTAFp85z1AmzuhCuX
         ji/MQKnH1eUwUUi/jN3xangFh9Y8nvYTXXdq6AI0bEk+Q//TmM2OhDITGEHKeDEakADN
         9cMql/HandQwJChL/s2ejHuAndpQZYfC+Aj37Zyow72B9AjSh4xKczrmNsbB6fOaFzQr
         YBMg==
X-Forwarded-Encrypted: i=1; AJvYcCVpTcnQ0D8N4dLvcyLS5KVyHaMzgVDK2n1mEpzoxd8M4/cdkXbQU066B9eNizzy+53Y8eA=@vger.kernel.org, AJvYcCXKOGjeAMnweq/vsO5AvPm1UorjYiWUB+loytkQnA/OBZmnfnGRJkdQ4FWgdVuC4jWTEcHzII9k@vger.kernel.org
X-Gm-Message-State: AOJu0YyRZuYcw+ogu4y0wkwQpe+YZXNgP+1L2Xu0jlrML8YAJKvQMo3a
	hA8m5hMhGBkcHohmgRZswrVRzZCKmsMDkBOkvY4W0BPPPLpOJVF14C3pQi12D6m2XLqSj7Up/Id
	Nzp4Lm/MicyIDxmBbC44NMFVvfYwzkjnn41HLnsru
X-Gm-Gg: ASbGncsBfQDUXLMrul8EaUOFIQDuRmFVPGNLspUAy1Y4yxtZqwl93zEG/QZZLsr/yMb
	agf+jhU6VyYL4uusgiuuQaEnrwCwcCNCPoWIaYAdmEHnwy8rwF+4UtrRZb3dmQqJb6hHBeLiK
X-Google-Smtp-Source: AGHT+IGFOgzDd9mVFv8R2Y/UecKvR5yibkezTo4wAewqE7dKEomxWYOyqBang81mQYwquXVb/W0vc5fs8rcBYMJbNxo=
X-Received: by 2002:a05:6e02:b4d:b0:3cf:bb7d:ac13 with SMTP id
 e9e14a558f8ab-3d13dd0261cmr92207965ab.1.1739232065549; Mon, 10 Feb 2025
 16:01:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-9-kerneljasonxing@gmail.com> <67a3878eaefdf_14e08329415@willemb.c.googlers.com.notmuch>
 <CAL+tcoAH6OYNOvUg8LDYw_b+ar3bo2AXqq0=oHgb-ogEYAeHZA@mail.gmail.com> <e6f2c489-85a9-436e-8d05-4b3063c133fd@linux.dev>
In-Reply-To: <e6f2c489-85a9-436e-8d05-4b3063c133fd@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 11 Feb 2025 08:00:29 +0800
X-Gm-Features: AWEUYZlE7vfBaBxDJ33s6Ck5iJUfkht7Ylw9cwzuDgwF2YEc9_ac4wrjqwpjZ5U
Message-ID: <CAL+tcoBMVfcmdvwAOe5QROweKnMQw4NrrBwtQZ6RZYD4xEX_3g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 08/12] bpf: support hw SCM_TSTAMP_SND of SO_TIMESTAMPING
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

On Tue, Feb 11, 2025 at 6:40=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/5/25 8:03 AM, Jason Xing wrote:
> >>> @@ -5574,9 +5575,9 @@ static void skb_tstamp_tx_bpf(struct sk_buff *s=
kb, struct sock *sk,
> >>>                op =3D BPF_SOCK_OPS_TS_SCHED_OPT_CB;
> >>>                break;
> >>>        case SCM_TSTAMP_SND:
> >>> -             if (!sw)
> >>> -                     return;
> >>> -             op =3D BPF_SOCK_OPS_TS_SW_OPT_CB;
> >>> +             op =3D sw ? BPF_SOCK_OPS_TS_SW_OPT_CB : BPF_SOCK_OPS_TS=
_HW_OPT_CB;
> >>> +             if (!sw && hwtstamps)
> >>> +                     *skb_hwtstamps(skb) =3D *hwtstamps;
> >> Isn't this called by drivers that have actually set skb_hwtstamps?
> > Oops, somehow my mind has gone blank =F0=9F=99=81 Will remove it. Thank=
s for
> > correcting me!
>
> I just noticed I missed this thread when reviewing v9.
>
> I looked at a few drivers, e.g. the mlx5e_consume_skb(). It does not nece=
ssarily

There are indeed many drivers behaving like you said:
1. xgbe_tx_tstamp()
2. aq_ptp_tx_hwtstamp()
3. bnx2x_ptp_task
4. i40e_ptp_tx_hwtstamp
...

I really doubt that I've checked this a long time ago and then left
this memory behind in V9, after all we've discussed this a lot of
times...

> set the skb_hwtstamps(skb) before calling skb_tstamp_tx(). The __skb_tsta=
mp_tx()
> is also setting skb_hwtstamps(skb) after testing "if (hwtstamps)", so I t=
hink

This assignment is used to assign a cloned or newly allocated skb
instead of the orig_skb passing from the driver side.

> this assignment is still needed here?

Right.

Thanks,
Jason

