Return-Path: <bpf+bounces-21142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F6B8489E1
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 01:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF61F28478D
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 00:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB7C7E1;
	Sun,  4 Feb 2024 00:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8ud68WT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6873621
	for <bpf@vger.kernel.org>; Sun,  4 Feb 2024 00:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707006964; cv=none; b=WjJqxxrDTfjLxcrvm819NQJbYn0fHgWNfjjxF08OEKx5/fRBJDwATvVOuQ4VyEFrxhktUIGbeAFH2F6MMp/TxEpPJLrIXQLP0RxGLdL07p01irITVNAAmyKEc6BjQysUXsfjvM1ciP9ZywgJU5w+ljKU1MHv/RW7572glbsmYxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707006964; c=relaxed/simple;
	bh=kxqh/H6kkUNkJfUsRVIKlITByNKNy9LpPXce1uz0cXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eeXgrmGIuDSStn5hJrBG0V1ZvhxA/IQ9P9K0xgB+WbJDHRepsApn/7par++xV3Fj6rcibSYIz70iAzWF45wQSDDWp3u91pJw6jbAALkywacsn/PTbe9coWE8HBj4IdnV67g94cuso5OYN1BkGwP01CnJdp8x/h7J0Gqubb8/IS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8ud68WT; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bfd40ff56fso218859b6e.2
        for <bpf@vger.kernel.org>; Sat, 03 Feb 2024 16:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707006961; x=1707611761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpMA+13WokxlDEZMEsPCpX0NzeCKhbGY6mYcSdBl7jY=;
        b=O8ud68WTH0usPOR9/vpd0UKurkIdHx/sBOl/3+x5yIyqE+XR4SL/YmA4gwMRy8YX9H
         KJZjjonhzCtNbyxbH9Tf2rx9VFeQtHCAGrNwghwWq8aFezHa6Uae2CZQ08zAg+hvZO8R
         ajoRovNpEB/m3SP9jbIH25WeuQBPGEVBvern4RpNDYBZQBl92pzIG2NYawk6VO2+Otum
         3aGTPvwd7EBp+gaPxTk/RtJSQaVgBz1tVdwaKfWjB957OXa44bFISE0qdfP3WkGpdKq2
         ARFXglEDMjEML4TAVDGJqvCK9xkzRPPM1saPq+cBENdaFTu7jhPYqse3B/bfLpsNYZen
         Qfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707006961; x=1707611761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpMA+13WokxlDEZMEsPCpX0NzeCKhbGY6mYcSdBl7jY=;
        b=hN9U88+SUWwgtCPnYefXt0eAeRkZMLuowkFdxN07sair8eDeRcmT1nC7SeF+YJ8sFL
         T86ApWqwRoKT9+a14Nyoa7KHTZBf6Rg/Ym3fmyh6Z9i3Y6o6m7naAcm4mfCucUHLU1tD
         QFGM6KMA74xf02qxSxYc7eRjItg5omcHI7efRufk0p0YesucA3J5+xB4mg9halGURTSl
         P0lb+K/7JIbzizVTqts5gXgXkDWNrElCm6KTjkwkYwmz7xH+nnJsPNkqttYovyej0qe0
         xoi2rxEGPP1snAR8wI/bupl4Q23AYyGrhBHKSTlxHPkgfxCfBrub27swFqupGeYvnJ2t
         Mh7w==
X-Gm-Message-State: AOJu0YzJtwJPhoquXwtDNVuAI4gkzPPooOmZVzV77Jhyv+yryFTG1BZj
	d5dD3HEh8tvaAfxqLH/m+GyuDoM6I037WX5BftvWSGrPc/UTkSyRmmNxF6YhLXPFEcpRxgBb7HB
	4Vmt2976crGQY8dG4icjsrrs8hJY=
X-Google-Smtp-Source: AGHT+IF7fYfrknViUljTL4egw6kEgcjNMlJOWBHmcchKy/I96/oVXuiiCg2jH8IWFyiU+dC7EfyY9m5SIng3qPOkZHI=
X-Received: by 2002:a05:6808:1496:b0:3bf:c979:6733 with SMTP id
 e22-20020a056808149600b003bfc9796733mr5216951oiw.14.1707006961638; Sat, 03
 Feb 2024 16:36:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHViUT2y81_JHsuSDfH9Vu_KRbanvmGY_1Bs4jfrGyZPGHCbdg@mail.gmail.com>
 <2024020216-expenses-slobbery-9100@gregkh>
In-Reply-To: <2024020216-expenses-slobbery-9100@gregkh>
From: Lucien Wang <lcnwed@gmail.com>
Date: Sun, 4 Feb 2024 08:35:49 +0800
Message-ID: <CAHViUT2iOjpcCK36va3a8P5=Hpq8O3y1KBPf=7mHYzd9Eayjaw@mail.gmail.com>
Subject: Re: There has a backport bug between v5.10.79 and v5.10.80 when run
 bpf selftest "test_sockmap" on 5.10 lts kernel
To: Greg KH <gregkh@linuxfoundation.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

There has a bug when I run bpf selftest "test_sockmap" on Linux
5.10.209, and I found it introduced by "c842a4c4ae7f bpf: sockmap,
strparser, and tls are reusing qdisc_skb_cb and colliding".

On Fri, Feb 2, 2024 at 11:03=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Fri, Feb 02, 2024 at 11:40:38AM +0800, Lucien Wang wrote:
> > Kernel version=EF=BC=9A16ad71c250c1 (HEAD -> linux-5.10.y, tag: v5.10.2=
09,
> > origin/linux-5.10.y) Linux 5.10.209
> >
> > Bug reproduced steps=EF=BC=9A
> > 1.  cd (kernel source tree root)/tools/testing/selftests/bpf
> > 2.  make test_sockmap ; make test_progs
> > 3.  ./test_sockmap
> > # 1/ 6  sockmap::txmsg test passthrough:OK
> > # 2/ 6  sockmap::txmsg test redirect:OK
> > # 3/ 6  sockmap::txmsg test drop:OK
> > # 4/ 6  sockmap::txmsg test ingress redirect:OK
> >
> > After "# 4/ 6  sockmap::txmsg test ingress redirect:OK" display from
> > terminal, the main process stucks and sends nothing.
> > 4. In other terminal run " ps fax |grep sockmap " ,below is output
> >   13076 pts/0    S+     0:00  |           \_ ./test_sockmap
> >   13129 pts/0    S+     0:00  |               \_ ./test_sockmap
> >   13130 pts/0    Z+     0:00  |               \_ [test_sockmap] <defunc=
t>
> >   13237 pts/1    S+     0:00              \_ grep --color=3Dauto sockma=
p
> > Obversely, because of child process 13129 sleep, so the main process is=
 stuck.
> >
> > My research:
> > I use Bisection method to find the bug patch " c842a4c4ae7f bpf:
> > sockmap, strparser, and tls are reusing qdisc_skb_cb and colliding
> > "(on linux-5.10.y branch), it backport from v5.16-rc1 ,
> > It must due to merge high patches incompletely, Please take a few
> > moment for this.
>
> I do not understand, sorry, what exactly do you want us to do here?
>
> confused,
>
> greg k-h

