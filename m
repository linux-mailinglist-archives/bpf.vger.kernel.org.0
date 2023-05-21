Return-Path: <bpf+bounces-998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E030370ACFA
	for <lists+bpf@lfdr.de>; Sun, 21 May 2023 10:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E8328108F
	for <lists+bpf@lfdr.de>; Sun, 21 May 2023 08:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5681EEDF;
	Sun, 21 May 2023 08:28:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E838DEA3
	for <bpf@vger.kernel.org>; Sun, 21 May 2023 08:28:09 +0000 (UTC)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C7EEA;
	Sun, 21 May 2023 01:28:07 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so4353770a12.1;
        Sun, 21 May 2023 01:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684657687; x=1687249687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrdKLIRM4AS0rC58VKVCcGhDZRDgFeoEK6NEHLR6op0=;
        b=qqC0baMBH4MOm64Rby4dE76gGcOhRia0P2eyBq4PunGsQDGqGGSRd6yOfvY0cbvKwS
         eKBUSpdbZyWn3yS40uqyIflux1jmoqei0cGD4T0MEOSz2y4FbTt3AC4J+otJH9iz/26f
         Pr9Ubw5cL5OZZTe4aQFzqvf4OZavlglzcbji8G0RNyLrbBOZ0slqd00kvjKWlyU3rNOM
         qFaS/DZ6LkHjG3aFoTZsQ0Qau9z1Y1525tSTzwkr2HZ2pT6lNLNwfKcqHGY9s73g/K49
         /7+AbLsitzfYABv0ToXjtVbroJcijvdrJ0ufT49b+8KQUOwVNu0MRlnuiFvIFq208RHs
         OiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684657687; x=1687249687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrdKLIRM4AS0rC58VKVCcGhDZRDgFeoEK6NEHLR6op0=;
        b=MBd9bBaTxUbroIMeuc6UlJyb/VhhdB2i35/czNIJSh4yvfIVlPylxGk94CWckSb1dx
         rmOmbpArvpZOWzFf0qqMu+7UknRQui1GqEUV+Q38JoNBZLA9c2HPYyZyNqIGIWP8Wcr1
         ZFuy/uub3jZ/YZj6at+82pZuAnJcG3J/vsOE+GmL/3sRblS/Bu4RL7uvyZLkgqDtmnjJ
         uxq+LOQSK+0AB7L2wdYbtK0oag0KFNAw5OBhuiTwgsyVkg5nZ6FXQy+ck491ZhHC2Bgy
         8S9ezjTsTHNf/TLWG52CybfXPfVXHEXvod9bYHld0UbbQElOx2udGQg7m6M7zH3yj48b
         TXow==
X-Gm-Message-State: AC+VfDzE3c+Hr+TYRW4c+1JONCeVaIqij9GZXtKuLEAbTVxFsNf6EDbk
	ZFgHhu08zDLWpPL0B+FLvV9ZoRK1gktlsaplf1dU3sF2jCM=
X-Google-Smtp-Source: ACHHUZ7Ht6R7hueGf2ArlKoIFWu4icp/ARlnPjRpDO3unaiFqt5ZFSUx5b50QvcBG6Yd70xZhjcqZIXBcWrEH78fakY=
X-Received: by 2002:a17:902:e80b:b0:1a1:f5dd:2dce with SMTP id
 u11-20020a170902e80b00b001a1f5dd2dcemr9325538plg.6.1684657687149; Sun, 21 May
 2023 01:28:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAABZP2wiPdij+q_Nms08e8KbT9+CgXuoU+MO3dyoujG_1PPHAQ@mail.gmail.com>
 <073cf884-e191-e323-1445-b79c86759557@linux.dev> <CAABZP2yjONcZNVKT88JXq_QyVzuDnu12nD8APT0XJ45dOtSFrQ@mail.gmail.com>
In-Reply-To: <CAABZP2yjONcZNVKT88JXq_QyVzuDnu12nD8APT0XJ45dOtSFrQ@mail.gmail.com>
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
Date: Sun, 21 May 2023 16:27:56 +0800
Message-ID: <CAABZP2zvn_rfC=E9FF-7Hmruq69gEnZJ5aW8mSbOPQijveeKcA@mail.gmail.com>
Subject: Re: a small question about bpftool struct_ops
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi

On Sat, May 20, 2023 at 7:37=E2=80=AFAM Zhouyi Zhou <zhouzhouyi@gmail.com> =
wrote:
>
> Thank you for responding so quickly ;-)
>
> On Sat, May 20, 2023 at 3:01=E2=80=AFAM Martin KaFai Lau <martin.lau@linu=
x.dev> wrote:
> >
> > On 5/19/23 5:07 AM, Zhouyi Zhou wrote:
> > > Dear developers:
> > > I compiled bpftool and bpf tests in mainline (2d1bcbc6cd70),
> > > but when I invoke:
> > > bpftool struct_ops register bpf_cubic.bpf.o
> > >
> > > the command line fail with:
> > > libbpf: struct_ops init_kern: struct tcp_congestion_ops data is not
> > > found in struct bpf_struct_ops_tcp_congestion_ops
> >
> > At the machine trying to register the bpf_cubic, please dump the vmlinu=
x btf and
> > search for bpf_struct_ops_tcp_congestion_ops and paste it here:
> >
> > For example:
> > #> bpftool btf dump file /sys/kernel/btf/vmlinux
> >
> > ...
> >
> > [74578] STRUCT 'bpf_struct_ops_tcp_congestion_ops' size=3D256 vlen=3D3
> >          'refcnt' type_id=3D145 bits_offset=3D0
> >          'state' type_id=3D74569 bits_offset=3D32
> >          'data' type_id=3D6241 bits_offset=3D512
> OK
> [214398] STRUCT 'bpf_struct_ops_tcp_congestion_ops' size=3D256 vlen=3D3
>         'refcnt' type_id=3D298 bits_offset=3D0
>         'state' type_id=3D214224 bits_offset=3D32
>         'data' type_id=3D213704 bits_offset=3D512
>
> Please tell me if I could provide any further information.
>
> You are of great help
>
> Thank you very much
> Zhouyi
Thanks for your help

Or, can you teach me how to prepare an environment that can run
"bpftool struct_ops register xxx.o" ;-)
(A few words of description of OS version (Ubuntu/CentOS/Suse for etc)
and example kernel .config is enough)

I am an enthusiastic learner ;-)

Thanks in advance
Zhouyi
> >

