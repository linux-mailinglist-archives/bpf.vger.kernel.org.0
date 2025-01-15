Return-Path: <bpf+bounces-49003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A83A12F65
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 00:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707A518880D8
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 23:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75A31DDA34;
	Wed, 15 Jan 2025 23:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c40cvFyZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D762A1DAC95;
	Wed, 15 Jan 2025 23:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736985084; cv=none; b=YEHfzu+vr1ZwE/jAed6y/1e2ip66E5BBuGNyFDysS/WkxEzWdrl4FS9xqzPjNK1ziqaPNr0FCorLSWNXH0azW2WHKOKD7XENpqPP0+kreUUGfJyv9ODPI7xY8mZDovWxcua+TtAKtZfgsTbYp3hvRhk/cjC1t0VI+ZQXh1gDH+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736985084; c=relaxed/simple;
	bh=2UTckcavDEduvei+kEBUAO0RfUTCYzZOhVZNKn0pIsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFo7Dtor3S7hb3i6Y9eHTwiE9u3FS2qseG6DWoNBNaD6AiMxM+Uu2Bln99Ez5t+Wron65WUcPRCetO7z+QrA77WySnZ5F7bmuIwJERIBGBQ8YPIUhtsKkNKpFqutjha7LYs6o8sXE/f+Dw3XLj/+bz2a3eXBipunLf9shnH6+LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c40cvFyZ; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3ce886a2d5bso2707435ab.1;
        Wed, 15 Jan 2025 15:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736985082; x=1737589882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkgp0fplyIiM5HQsbUSPVXTFZ2fJnbj2/HHh7OfNmnk=;
        b=c40cvFyZYty0nLOe9GtNkErRBjILD7/T7bdnK1sprJ5YlbnDsrFgZF78fHe/r15N/R
         e++e9LmZiFFW4F23nsxXc9X6gSgDwjnSLwGP0bc0fFybeaw0BY2peQ2dL+vZtdvirlIZ
         N6Qnwyd60a4lNyemZAjT9QSMuyutLW6F1ko4F4l/F+2Kfw7hWhRileJKa8J0KjKJalLj
         pIsRAC9e5TMK1RqF7+HuBsmKeXlDyZTZc5aa1/meoJYxvZ/073Za3MQn0qTML6lRgjO5
         T0S/A+GnnD28HtSg29wQrA+4NKygvkS0k/2FrpX0sZhy2NqyM7wK4s6NimEOnED0Wde4
         vyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736985082; x=1737589882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkgp0fplyIiM5HQsbUSPVXTFZ2fJnbj2/HHh7OfNmnk=;
        b=ZRsKZ7Eo93iQhGnHedLOrvwvCz8GHHbE6j88EnxA/C9PbBZv4cLmGJMHHquuDGXa/o
         Pymk4DLsj3vbHtEt0CJiSxb9BDf5Cimslp5pq4ZpOvPKIh00emE/BRq5boayTrjmcKT3
         GBcquD04RpverhbL35f2waL9hjLSTE4Xgpl+lYKEsytjWooK6gEWtUUheoNTD+X9QiAG
         Eikr+K2mYv7TdyVR7UnU2tYoM+lz/Wt9fo51i8BYisaWUJHHVJEOCldEuUe0yNEfwQT4
         5jTzKX5oTnA+RmFxkULn5wFtE2joF8ZjLP9CE9GIjdf3oNN1DxczRY+PSs2sw41EhOdf
         IzPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkMQQX8285kLwC08Upg5+sURbfd4JI3XkTTeexgMCHbfeHNkO5Qx7sSA0KYukGPnZjrSSKGyDv@vger.kernel.org, AJvYcCXZa1CxO4npLTTbxs7EdIPLaI6EL35mhHzLB7Kvl6B7o/daiS3T9t2earzmNX8zCds2JjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVddNVMw1LNrGcqHMFvy+aOWXmxJH4u5cAjcJ8slxUBpvLqnC6
	sp94SEIcvtQLB4wlsZHa4gac3dUqoiaf4NmeFZ86viBQc0Ga78U5e89Zt6Zi8y3l6iceQWazaDD
	tb5TC9NmwbnLYklU5wb3oIVIfqDU=
X-Gm-Gg: ASbGncu+4Os6Gh+RQE73baoYMDmC7XdOy+gCDASkCfeSicILsTOKRIaCSNSZKfQjVDr
	JwIQCYL0KZ2hqW8qC7yy6CGaFBENPlrZGKASa
X-Google-Smtp-Source: AGHT+IEteWbWscKGuIRNpMt/GTaVW0UZO/q7REkmbfH3+Vl1nJBzlF4YcfDE/N7sLo7Uxi6fIgf9+sJIdWf6UBw/NDA=
X-Received: by 2002:a05:6e02:1fc7:b0:3ce:7968:ead3 with SMTP id
 e9e14a558f8ab-3ce7968ec04mr106210585ab.7.1736985081961; Wed, 15 Jan 2025
 15:51:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-7-kerneljasonxing@gmail.com> <96b5bf3f-b99d-46ac-a22c-754582020c17@linux.dev>
In-Reply-To: <96b5bf3f-b99d-46ac-a22c-754582020c17@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 16 Jan 2025 07:50:45 +0800
X-Gm-Features: AbW1kvYL6RdPk8R4EpjEoG66wqfRLEzP6ANMljRYe00lHdXY9FPmtI8kFkm4q-w
Message-ID: <CAL+tcoARXLJCvE1hjACH5B_rbxM-B4yGrROaVamp=11N2mnoKw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 06/15] net-timestamp: prepare for isolating
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

On Thu, Jan 16, 2025 at 6:11=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 1/12/25 3:37 AM, Jason Xing wrote:
> >   void __skb_tstamp_tx(struct sk_buff *orig_skb,
> >                    const struct sk_buff *ack_skb,
> >                    struct skb_shared_hwtstamps *hwtstamps,
> > -                  struct sock *sk, int tstype)
> > +                  struct sock *sk, bool sw, int tstype)
>
> Instead of adding a new "bool sw" and changing all callers, is it the sam=
e as
> testing "!hwtstamps" ?

Actually, I had a version using the hwtstamps, then I realized that
hardware or driver may go wrong and pass a NULL hwstamps. It's indeed
unlikely to happen. If so, timestamping code will consider it as a
software timestamp.

I don't expect that thing happening, ensuring our code is robust
enough. The original timestamping code seems not deal with this case
as we cannot see some particular test in __skb_tstamp_tx(). The worst
thing is if it happens, we would never know and treat it as a software
SCM_TSTAMP_SND case.

Does it make any sense to you?

Thanks,
Jason

