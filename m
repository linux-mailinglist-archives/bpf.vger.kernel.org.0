Return-Path: <bpf+bounces-58953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F32AC4396
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 20:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1793B3EC9
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 18:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60F923F40D;
	Mon, 26 May 2025 18:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f7vNnabh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CED43AA9
	for <bpf@vger.kernel.org>; Mon, 26 May 2025 18:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748282446; cv=none; b=lsYVpYuWrUjjS/GTah7sxfU0HyiN1kdUxz8s/cLz2e28NpbaKrL87TJPELdqj1Vzt5EBP4CW5d6tesu4t6SzDZ2mMyryeimXLU/p4f6ZYL2aXp5/igAH74VU41K1Y9SLzcokL0Fo6/WPfEYBtDMG2qeltvpScT/A4B0+w6OTJHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748282446; c=relaxed/simple;
	bh=rI+licYUolL5nhcW9GoIZLfSpbwxMtL6YthxBl22SZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHRA8cd7cbY9EDZFW7JJgvkxiu6ehYx+UPpXXyS5xtCDoiTHhhiI66kkADsSY/7/uA5w6ifGaMCgqSbRF5BoKc4OdVf+dyIsc6K4OVcQtKbOCVh9mSbLdn1LlZKQOOseri/DyuhkRP3t5YJi7es4bsXp7RVIDeoM8sqJqEakX8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f7vNnabh; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2348ac8e0b4so85355ad.1
        for <bpf@vger.kernel.org>; Mon, 26 May 2025 11:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748282444; x=1748887244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BE00iNGaQOBcvJTWH1HJdDZjS8vODDdLLtmR/QEPXS8=;
        b=f7vNnabhvdOz0PP/Pa+YruFib71wohXXIsckWp4N7raMihaWFWdtGU0iwOCFIUuKsp
         rHDtYtQm8cvpalAzewKWO5Qsu2Ni/Lj388MvKw+8Ubnks0PPr3Bu6WhunmtXo3CrKUTv
         FEa4NQNNzeBdCLIOcO2Ablmh3WcJ7VDyumAWkhPl2NY1/AHTPrvmAGd25fjGTMsm7xOb
         OrEVPBJ3NPzLIW5m/zqzTVAZp7HSkx5QIvBX9xBrQ/MifvQxp/reImpMB4t39wpUcN8K
         HaHm7RrnACuH2U8cWM/prs4K4HStYaQkftkA6T25bScCeeNtaw8zc0UukANCGaMPR19P
         GySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748282444; x=1748887244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BE00iNGaQOBcvJTWH1HJdDZjS8vODDdLLtmR/QEPXS8=;
        b=O3fva5L247se4dpGGWWoeg3uEG5n+APZFDObCqYlsGGgZL3jZwFmNYWhGFBjCYHUGo
         5bIl0x8LlinKE1fiNAwpWWuSm09JktAGlcrNVi4FssZFUkIawOE0v+E/wGCeSYXYyD5K
         QfYOid4cARHMV/Llwe0+zPtULmmcp6cCqU9O8ANLcaODxRDHhwpD/Vvq1GYITNaBOOMS
         uDwEHIH0NL+dkpIeFHM87o49RCO4c3uiFj7qf26GQA2BUCi7LwANc71/fmMvBcbg+KDk
         esO+Qct8JJiAapesHB4eYA12ejgxwcT940KFs1hX7pQ3fM8pYPv2uq01x303ezBtSLyZ
         rUxA==
X-Forwarded-Encrypted: i=1; AJvYcCX9Qq4m2FpaSBCCchUM9GJ8D1pLyoGcc0wMFma/9suA+NQqvrze5jzpz9h5QppVB/mPrFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw78AcOEkyInAaF7NvdpVD34E6Zzd7XnSEWZYqJqq3pRuJJR5bR
	gWNhZ1VUa+gQc3azJR246syLp4ay+l6aIYMFNB6P8a4EABiybqELKuFisIcqwxucoM23r3x1ZCA
	qPQuiuTJa2d9XJyOxG70D0exnEXpjSyoS2Ek1OpW0
X-Gm-Gg: ASbGncsNO94QHABNV96XKfUgUFg9LhxNvwKRgFZ//C6wL6BHL13Fr/ysQBnl2giEqBH
	ijNXaF6Xh0SHieox7GgWuKSwY0OVLG9Dap+QHdF5l0Ry3gnrECSKQLpntQ9xRTPze8zQBrlyypf
	1jBRbMZAJsDNxkSO+J/Q8fQ+ZuQmIijPeawR2kjRicDURC
X-Google-Smtp-Source: AGHT+IEtmxefPpCTSi1gvHA9a9DIBuanG4oeTpITjr5Cfh4ZkHf1HTV7gnyeYgG8lD3UeMrlJvwRa++zz4aloVbC260=
X-Received: by 2002:a17:902:ec8d:b0:216:6ecd:8950 with SMTP id
 d9443c01a7336-2341b52771amr4576785ad.19.1748282443435; Mon, 26 May 2025
 11:00:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523032609.16334-1-byungchul@sk.com> <20250523032609.16334-14-byungchul@sk.com>
 <CAHS8izOX0j04=KB-=_kpyR+_HZHk+4hKK-xTEtsGNNHzZFvhKQ@mail.gmail.com>
 <20250526030858.GA56990@system.software.com> <20250526081247.GA47983@system.software.com>
In-Reply-To: <20250526081247.GA47983@system.software.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 26 May 2025 11:00:30 -0700
X-Gm-Features: AX0GCFsrsXIO7EOCYLWTkGfVc6XTbNgw4nzAjpdO0g7ysDNdP-dZJFnwMLd86jQ
Message-ID: <CAHS8izOMkgiWnkixFLhJ1+7OWFbYv+N0am83jV_2cgBecj-jxw@mail.gmail.com>
Subject: Re: [PATCH 13/18] mlx5: use netmem descriptor and APIs for page pool
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 1:12=E2=80=AFAM Byungchul Park <byungchul@sk.com> w=
rote:
>
> On Mon, May 26, 2025 at 12:08:58PM +0900, Byungchul Park wrote:
> > On Fri, May 23, 2025 at 10:13:27AM -0700, Mina Almasry wrote:
> > > On Thu, May 22, 2025 at 8:26=E2=80=AFPM Byungchul Park <byungchul@sk.=
com> wrote:
> > > >
> > > > To simplify struct page, the effort to seperate its own descriptor =
from
> > > > struct page is required and the work for page pool is on going.
> > > >
> > > > Use netmem descriptor and APIs for page pool in mlx5 code.
> > > >
> > > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > >
> > > Just FYI, you're racing with Nvidia adding netmem support to mlx5 as
> > > well. Probably they prefer to take their patch. So try to rebase on
> > > top of that maybe? Up to you.
> > >
> > > https://lore.kernel.org/netdev/1747950086-1246773-9-git-send-email-ta=
riqt@nvidia.com/
> > >
> > > I also wonder if you should send this through the net-next tree, sinc=
e
> > > it seem to race with changes that are going to land in net-next soon.
> > > Up to you, I don't have any strong preference. But if you do send to
> > > net-next, there are a bunch of extra rules to keep in mind:
> > >
> > > https://docs.kernel.org/process/maintainer-netdev.html
>
> It looks like I have to wait for net-next to reopen, maybe until the
> next -rc1 released..  Right?  However, I can see some patches posted now.
> Hm..
>

We try to stick to 15 patches, but I've seen up to 20 sometimes get reviewe=
d.

net-next just closed unfortunately, so yes you'll need to wait until
it reopens. RFCs are welcome in the meantime, and if you want to stick
to mm-unstable that's fine by me too, FWIW.

--=20
Thanks,
Mina

