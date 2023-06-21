Return-Path: <bpf+bounces-2963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 053447378B8
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 03:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E512813EE
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 01:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D05315B5;
	Wed, 21 Jun 2023 01:29:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4793C15A6
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 01:29:46 +0000 (UTC)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA3F10F9;
	Tue, 20 Jun 2023 18:29:45 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-6300f6ab032so33352646d6.2;
        Tue, 20 Jun 2023 18:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687310984; x=1689902984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dJ+y6an3ZyYlZhJ1PwrQ2SfTniPJELOXrnVqRBZUys=;
        b=elMxAphxwB2YZmqHv3WRjzTLi+x4PN9gIP20gurXhoELnXKQ9g6tDyYEEHB8VdmGV4
         8F+5GBfpxDAQZX5qs+sevXKAyHn4dvljkNyt9eUEC+s01ontLWnGOPc7R+9yuKsHYuPX
         t0c5IqiXWFyTXuyrIS4E/S8hpTWP9uGg08ElATdxJBmGRSC5nnKOy5/GkijxeCR8l5q+
         OsU8bZIv+6hLVcMvK2asEmmuM5CMwTofUz4Puc3Vw6xO87GczPKiFjE0fBOKTZwycZz2
         pwdSxRbUNXgYM9CMWTw59uJ9fK6Gu5cMuCkUSVpHIvNAZ3oZ/Ofw27apTicDhUOmyLVx
         USCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687310984; x=1689902984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dJ+y6an3ZyYlZhJ1PwrQ2SfTniPJELOXrnVqRBZUys=;
        b=B+HdwhMqtBnFoQcF9z4F63cU2eJ62t+kz9zGK5Vu0Aa6f0sBpSYHcegkALMRaNc6Zf
         0MlksxnDpRdu7gg/IOig1wSKWB25TV6jZODO/rZncLYQ61lPKFCnU6YtI2OXuO4MU5ub
         s3/wySjRgtBjgtqdFKmAR6sTGdFEixMh2Zw6gAu4NmDqGcy29568F4gPfutNDngZnusc
         UMNS0yFMYclWwujKMXtr30HOYgRsl0kWU+DWOCcCd3eXgzTf7+oI4osm44ThVT9+Fspq
         x4iZprsUcDh+78IaspVoflYw3NWren3Mq2nkALGlemdnFk3A7MnSqMoiOKKZi0A50I4Y
         W5Rw==
X-Gm-Message-State: AC+VfDy9zk9vZkaCAmIAb7E6ip8KD7RvvdBIw6HQt2SHCFWvVgHjx2Wu
	2D3qoXAq2PgyawjhqPTEKp9z5X8TFv//13dhcZ0=
X-Google-Smtp-Source: ACHHUZ4v1LoOQx2MrnHTV7KNQXvsVcfKxisqdfFkZJn/xA3Ktb+NeRY+6fhhcklKWDzc6J7m0l0KuNHVIS4CuD/NbzU=
X-Received: by 2002:a05:6214:518f:b0:630:228d:6d38 with SMTP id
 kl15-20020a056214518f00b00630228d6d38mr7580844qvb.46.1687310984270; Tue, 20
 Jun 2023 18:29:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230612151608.99661-1-laoar.shao@gmail.com> <20230612151608.99661-4-laoar.shao@gmail.com>
 <CAEf4BzaZEb_Uz21WDmQr7UC8Q50EfHDr2=dK477Z8fGEinCZ7w@mail.gmail.com>
 <CALOAHbC=fJfsE=r=o87sT36gq_OP-rLGv4yb-BuTxadu1KQ-pw@mail.gmail.com> <CAEf4BzaySGo4UOxA1YkehPkW4n2A9XpUoeUTOM6zcBCQOB-gGw@mail.gmail.com>
In-Reply-To: <CAEf4BzaySGo4UOxA1YkehPkW4n2A9XpUoeUTOM6zcBCQOB-gGw@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 21 Jun 2023 09:29:07 +0800
Message-ID: <CALOAHbD+QAqjeCzCHKuz+=3cvA6ujDb9P=SnPLbscC-Ut2UUfA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 03/10] bpftool: Show probed function in
 kprobe_multi link info
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	quentin@isovalent.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 1:17=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jun 16, 2023 at 8:09=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > On Sat, Jun 17, 2023 at 1:30=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Jun 12, 2023 at 8:16=E2=80=AFAM Yafang Shao <laoar.shao@gmail=
.com> wrote:
> > > >
> > > > Show the already expose kprobe_multi link info in bpftool. The resu=
lt as
> > > > follows,
> > > >
> > > > 52: kprobe_multi  prog 381
> > > >         retprobe 0  func_cnt 7
> > > >         addrs ffffffff9ec44f20  funcs schedule_timeout_interruptibl=
e
> > > >               ffffffff9ec44f60        schedule_timeout_killable
> > > >               ffffffff9ec44fa0        schedule_timeout_uninterrupti=
ble
> > > >               ffffffff9ec44fe0        schedule_timeout_idle
> > > >               ffffffffc09468d0        xfs_trans_get_efd [xfs]
> > > >               ffffffffc0953a10        xfs_trans_get_buf_map [xfs]
> > > >               ffffffffc0957320        xfs_trans_get_dqtrx [xfs]
> > > >         pids kprobe_multi(559862)
> > > > 53: kprobe_multi  prog 381
> > > >         retprobe 1  func_cnt 7
> > > >         addrs ffffffff9ec44f20  funcs schedule_timeout_interruptibl=
e
> > > >               ffffffff9ec44f60        schedule_timeout_killable
> > > >               ffffffff9ec44fa0        schedule_timeout_uninterrupti=
ble
> > > >               ffffffff9ec44fe0        schedule_timeout_idle
> > > >               ffffffffc09468d0        xfs_trans_get_efd [xfs]
> > > >               ffffffffc0953a10        xfs_trans_get_buf_map [xfs]
> > > >               ffffffffc0957320        xfs_trans_get_dqtrx [xfs]
> > >
> > > it all subjective, but this format is a bit weird where "addrs" and
> > > "funcs" is in first row to the left. Just makes everything wider. Why
> > > not something like
> > >
> > > addr              func
> > > ffffffff9ec44f20  schedule_timeout_interruptible
> > > ffffffff9ec44f60  schedule_timeout_killable
> > > ffffffffc0953a10  xfs_trans_get_buf_map [xfs]
> > > ffffffffc0957320  xfs_trans_get_dqtrx [xfs]
> >
> > It may be a little strange if there's only one function, but I don't
> > mind doing it as you suggested.
> >
> > >
> > > Not it's singular (addr and func) because it's column names,
> > > basically. Can also do "addr func [module]".
> >
> > The length of the function name is variable, so it is not easy to
> > determine where to put the "[module]". So I prefer to not show  the
> > "[module]".
>
> "func [module]" in the header will give a hint of what is that value
> in square brackets. I didn't mean to align it into a third column

Thanks for the clarification. Will change it.

--=20
Regards
Yafang

