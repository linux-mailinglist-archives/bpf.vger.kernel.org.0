Return-Path: <bpf+bounces-67935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F356CB50651
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 21:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69E511BC891D
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 19:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D902335CEB7;
	Tue,  9 Sep 2025 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCRYHtlD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016483570C5;
	Tue,  9 Sep 2025 19:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757445665; cv=none; b=Ol8te0lxGiehS+Z0WYtS6YjjIPQKmp6CIplHVB52d9RQ/IiYVr/OcfeD+90G69qg2MrC4q5DmaxpRQL7DaikoawjWm8F5UlxglueX9hRzYBNyGQXZO8oAIBY5tG4knkdxRPW/pWkB5/GU8ie/XvsvcZmBWCx5inoZLGvpSQCH3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757445665; c=relaxed/simple;
	bh=PBaWCw1yzNsutBu+o233AHDRCu7w/AA2teJPBgfek08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VjyYrM07hLmmMBsM9HiVfA48r5XepM9R6/YeZ339xWDE8qaqfmOUGn5j6St4KFDeCT0E3WuzvwCr8h5L8lGB5e5XpNn4yhbl40W9uvx/QPU3+DpgugtsDXqnb6d9/+Y4/hdxYVVS+ymr5bQdlT8Q5KuzLDGYdq1b9EQpgfgNBUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCRYHtlD; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d603acc23so48177367b3.1;
        Tue, 09 Sep 2025 12:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757445661; x=1758050461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBaWCw1yzNsutBu+o233AHDRCu7w/AA2teJPBgfek08=;
        b=gCRYHtlDs/PO3fVLrvN5OcHsmWSIknJebhG8ONe+IU4WcLy+r6cqrmFYKqn0Zn4j30
         bOtnhdMQxSoZQNdZh0M4NRS1qYcXdmzPwbaZFv/YzhLYPZBGWA09BV6F92mDVprlbJ9d
         6tu7V2yinT2Njy5I/EttYLtclFY7PyuMhx+IwYZP1JrIE4S1Y0kKHmGOMRmbgQjuj8rI
         6MMKKBNF3WLnOJnysIL9WPcNTKeELY1PVcIzJJVc2yjOj3YKVv1aIPZ16AwQdtjnjyIX
         swBOXPoSeVxJGgn5aR3rwgGhQCmsRhGxid/RKaI1mCG/naMD06BePNialzrGoQtrZ78U
         KdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757445661; x=1758050461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBaWCw1yzNsutBu+o233AHDRCu7w/AA2teJPBgfek08=;
        b=sDp+JuG2LNzcnsNma9c/GuijAMlpZ1t40WQmZcBAqLWbQDm8YDSvh6+YfTl1hSI0AF
         xljQVwhVkFCRV9+a/4jpiKP5YMR8QaRaR/tKYUzCIi+ukhJei0pgWIz1XZgQfo5h3V4/
         3iv27vzs4lGatmI4M1CGc8DxgUKZ2Fyuww53RC4gKbOavuJlMigDwwhRdJVzBTsJ4osf
         r/jaZa0qM1lBw8NF67xNGkq0ngzfqUPEgLd1TkD1lofxUwFWknVo/av3nhhRj1iyMg1a
         p6lOEk0U+JM2x+PeJIB62cr+J/qx3b1yuJXo4V9+Uhd9tN9xd2k1LpmaVkTyK9Gx2ypH
         lvQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaEpFmOPKTOLyBB7rNtpdFQtpkR/WorrmY5B3fD/csH2S7stWgmR82rPQFsm/iJVfnflWnV4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVY8+4OXPT4nMAQl1elbpmZIovEe0YrrXxMZFycHTMDBAaRelG
	r7HpRkwVpRSyP8OXK8/WCp5w/rcKr5yR6nf52PoQzDvyep0DQ2N+v/Fu8lPBMX12MIOIYl3wSec
	vRl95XklqIhJ4iWs8fd2lzEk/KR/gF3Q=
X-Gm-Gg: ASbGncuXMWz1+ho77bRA2NFXX0t7V+MJRRbl9RB1904R1otWx3LJEosDFoA/t2FFeYm
	i2UGBB1Lrp0AAasvYz2llHtwn2Qu3AzDLR7jXMY6scXJ6z8UgEbT6ZvacZ+zbBesT5jmgK06fMi
	cmT5gXS6iZ7VvawfH4kUFD9RXuGxMiJWOepcY3yZ9/MpF/gxB1ny56aYsoDcXlTMYaflBTYztOz
	jIxmfXaLerTTY648f3ibGJaAAD/79gqxA==
X-Google-Smtp-Source: AGHT+IGrJ0pqWmM3h2TfRH5DiQcU5gjHiJZCcKOmB4gBkSun6Wjs7kS0s4HyzyuxPcE1JIBFIWnmy6kSLzpiaUE/iP8=
X-Received: by 2002:a05:690c:4b83:b0:719:f1b0:5c29 with SMTP id
 00721157ae682-727f27db7bemr103452427b3.3.1757445660862; Tue, 09 Sep 2025
 12:21:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825193918.3445531-1-ameryhung@gmail.com> <7695218f-2193-47f8-82ac-fc843a3a56b0@nvidia.com>
 <CAMB2axMk63AAv13q2QREn--ee-SMCwjhtv_iPN8EsrjN1L5EMw@mail.gmail.com>
 <19e4aad7-c4ab-49a4-9be4-28f464e6789f@nvidia.com> <CAMB2axOJXqHu3QZNCtCKNM8ScuoQU4SWTHgcYva=+62YUydCHg@mail.gmail.com>
In-Reply-To: <CAMB2axOJXqHu3QZNCtCKNM8ScuoQU4SWTHgcYva=+62YUydCHg@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 9 Sep 2025 15:20:48 -0400
X-Gm-Features: Ac12FXxjrdZn7nfSzcymFT69uHuWWML_scQjPb83KOptvoHcQ8U7i_2g52NGVic
Message-ID: <CAMB2axNOd=SvDkyjcgadJ0ZaC0HNSjeEJd11nYOaZNbm1PfUdA@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 0/7] Add kfunc bpf_xdp_pull_data
To: Nimrod Oren <noren@nvidia.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, kuba@kernel.org, 
	martin.lau@kernel.org, mohsin.bashr@gmail.com, saeedm@nvidia.com, 
	tariqt@nvidia.com, mbloch@nvidia.com, maciej.fijalkowski@intel.com, 
	kernel-team@meta.com, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 11:53=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> On Tue, Sep 9, 2025 at 9:21=E2=80=AFAM Nimrod Oren <noren@nvidia.com> wro=
te:
> >
> > On 05/09/2025 1:16, Amery Hung wrote:
> > > On Thu, Aug 28, 2025 at 6:39=E2=80=AFAM Nimrod Oren <noren@nvidia.com=
> wrote:
> > >> I got a crash when testing this series with the xdp_dummy program fr=
om
> > >> tools/testing/selftests/net/lib/. Need to make sure we're not breaki=
ng
> > >> compatibility for programs that keep the linear part empty.
> > >
> > > ping.py test ran successfully for me. Is this what you tried but
> > > crashed the kernel?
> >
> > Yes, that's odd. Is it possible that the native multibuf case was
> > skipped over because of an older iproute2/libbpf version?
> >
> > If it's helpful, I used iproute2-6.16.0 built with libbpf 1.7.0 support=
.
> > I am able to reproduce the crash by loading multibuf prog directly with=
:
> > `ip link set dev eth0 mtu 9000 xdp obj
> > tools/testing/selftests/net/lib/xdp_dummy.bpf.o sec xdp.frags`
>
> I can reproduce it with v2. Will fix it in v3.
>
> The bug is that sinfo->flags is also cleared in build_skb(), so later
> xdp_buff_has_frags() will always return false and no data was ever
> pulled into the linear part.

Correcting myself. It is sinfo->xdp_frags_size being cleared in
xdp_update_skb_shared_info().

