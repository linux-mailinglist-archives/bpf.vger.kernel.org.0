Return-Path: <bpf+bounces-49927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27286A2030C
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 02:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57EFA3A77F7
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 01:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D48C481A3;
	Tue, 28 Jan 2025 01:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtyH7X4O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533A58F54;
	Tue, 28 Jan 2025 01:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738028099; cv=none; b=q0OMnPdxWS6W52ZJpfYBHYbotlSJq5auv1uQ6RUVsozFYz9qdHm2bBIEi24xso1vpev0i7e99+Nvh5EETb54VTvdyjLEg/yPVxjGLz87tgqzvDk7+dFP5SkXaRH2NpI+YN9d01Btzvs2sfkmoOtIL4em5XNM8NOlIBK5H0OjDR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738028099; c=relaxed/simple;
	bh=+oPBgWwqGUOexPCWAxNqZHrFZ/fA248oiW8luLVn7/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K68Z9/2pr05gWgC7E3VESskKPr89//OhOVltoM2vqaSSjK8nQOyqTgM5GQ1Tm/CWnVE/C1qI6qzAnJiRxoChEOpW8NIld+/cHgDifBlsUIeE7FZZxPukOSmYfSoUHC59pHrc/dQFj4U1203WBUDURNi9sqN+Xs9tfQGheTrzGh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtyH7X4O; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a8160382d4so13407085ab.0;
        Mon, 27 Jan 2025 17:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738028097; x=1738632897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oPBgWwqGUOexPCWAxNqZHrFZ/fA248oiW8luLVn7/8=;
        b=MtyH7X4OUvXA8Bc9Fsb9VgFH+HpP5YCMiUaa6Vhm3oZQeT2e5dSpWTcQ21TLYqUStO
         8w6eEijC6tTVwz4xLuuj4syOH0gbPa2y2mqqLatLyE7uRKi+e8juUH7VPcQGkiV2hgO6
         BEYhv38J7RYaToU4lXw1+4lMFm0R3p13TqT8RzS8fqXZC9pnhx4ydupqKryg7gjX6a3q
         1yECLgfXxhRpvgrX6+8qLEE6Fe0FDKXyjk8N0/tQVdCIljy/BP4UHWv4Wq+a+r6K2Ol5
         iR2u/K7Gkk7yTG6VI8dNiHnanEqFs8IfSn3tyQignpiinsp3lE7JstOtZUZfHhLjntxl
         eYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738028097; x=1738632897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+oPBgWwqGUOexPCWAxNqZHrFZ/fA248oiW8luLVn7/8=;
        b=dmQ4yFgQ1qk3x/s8q2V6vtH9e+2p24wMJoKYsEDEkt2yBao3u7WRPvsPBs930giDQv
         F//W5F8xOh0zr89bWZH3yuQ1oz/wvPebSaYfPq/QqF0RUNuJoFIvIQj/Raippc1/iqJQ
         x/z0GtpcD2nqT+i91sHZSf0kM3wyFZUQ0geBp3B0gTZ3ffzlFD4pv6cSmhzlbdaJvzl4
         y16HTPITid/5Nrz97bh8kFbyNi+KOJdR8wWGBOa6Fu94cs/Tl/4sirb07vBWzyt5Yl2y
         0AZnqA85FLQKSNsuj/rZsoJih5eEc4iryPYLovoKBZtr+N3vuq4zZ2RqpQFileXYbR60
         QMCg==
X-Forwarded-Encrypted: i=1; AJvYcCVJp7XzGtkKE9RRglYHsilkXm4ybbcICiHrOEmu1/ZtBIzrE426DAg4u7AQUPfd2MNn1Bi47nVd@vger.kernel.org, AJvYcCVvNCjzzwTtcETna4EAIZjXr1TJB2t4yYp23VJa+UbZyHbIR935gjNAw1TEHwJ7K+30MAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB2UtgXTksY0eULnNre78ii9c/2jyyRVNMuf2NUgNMvWDGhdP8
	cLpVpEH5K57M1FJcrpoNvtcqD2iVNvuLv3lnXKY1zDvd2a6yfkQHTZg40PLr/bLru1QI6AOPC2D
	ASgWMVtHx1oTuueVm6UFqv8vLmY8=
X-Gm-Gg: ASbGnct6GSKuEoJOm4nqR0QY4e4c64Thv1uhaJMvf6KbcXApGkP6B+5BCYOxLg/ZL/V
	p+ii0xR5mPDLqfUncnsKGM05WvkBlSl5OjYMBc8YfpsYEP+wwtrR+anbtDQlSRA==
X-Google-Smtp-Source: AGHT+IHt6+VjtGmVY0WpD9cHknxl56A8hB/aEspZJdQ4DqCAwIhCOrkRr70OLOhtbhsFJ/kr8wKe3lu+qhkJ/Z63AYU=
X-Received: by 2002:a92:c248:0:b0:3cf:cbac:3ba6 with SMTP id
 e9e14a558f8ab-3cfcbac3c55mr106177545ab.5.1738028097295; Mon, 27 Jan 2025
 17:34:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
 <20250121012901.87763-4-kerneljasonxing@gmail.com> <e1440d0b-4803-49b2-ba17-b9523649ca8b@linux.dev>
 <CAL+tcoB182=QS0hLN9_ihf5Fcivr3BHuom8rrm+75bjpgC___Q@mail.gmail.com>
In-Reply-To: <CAL+tcoB182=QS0hLN9_ihf5Fcivr3BHuom8rrm+75bjpgC___Q@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 28 Jan 2025 09:34:20 +0800
X-Gm-Features: AWEUYZlzuxuMJPKVAVrqD2QCV5fPg2pOiKA1hFD6q7CbPy6NRINam-wuXi7YKyc
Message-ID: <CAL+tcoAjQFT57wSxcLaVUJJi1qQYYtE7OH2Q+KpZUziB49uBZg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 03/13] bpf: stop UDP sock accessing TCP
 fields in bpf callbacks
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

On Sat, Jan 25, 2025 at 8:28=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Sat, Jan 25, 2025 at 7:41=E2=80=AFAM Martin KaFai Lau <martin.lau@linu=
x.dev> wrote:
> >
> > On 1/20/25 5:28 PM, Jason Xing wrote:
> > > Applying the new member allow_tcp_access in the existing callbacks
> > > where is_fullsock is set to 1 can help us stop UDP socket accessing
> > > struct tcp_sock, or else it could be catastrophe leading to panic.
> > >
> > > For now, those existing callbacks are used only for TCP. I believe
> > > in the short run, we will have timestamping UDP callbacks support.
> >
> > The commit message needs adjustment. UDP is not supported yet, so this =
change
> > feels like it's unnecessary based on the commit message. However, even =
without
> > UDP support, the new timestamping callbacks cannot directly write some =
fields
> > because the sk lock is not held, so this change is needed for TCP times=
tamping
>
> Thanks and I will revise them. But I still want to say that the
> timestamping callbacks after this series are all under the protection
> of socket lock.

For the record only, I was wrong about the understanding of socket
lock like above because there remains cases where this kind of path,
say, i40e_intr()->i40e_ptp_tx_hwtstamp()->skb_tstamp_tx()->__skb_tstamp_tx(=
),
will not be protected under the socket lock. With that said, directly
accessing tcp_sock is not safe even if the socket type is TCP.

Thanks,
Jason

