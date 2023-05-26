Return-Path: <bpf+bounces-1342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10453713040
	for <lists+bpf@lfdr.de>; Sat, 27 May 2023 01:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE72628121C
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 23:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146862D254;
	Fri, 26 May 2023 23:10:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C556815B7
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 23:10:55 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B529D3;
	Fri, 26 May 2023 16:10:54 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b00ecabdf2so12527675ad.2;
        Fri, 26 May 2023 16:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685142654; x=1687734654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzzwX4jI8qfzX9UxemVFwpvHZe0mlondIIclMNme04k=;
        b=kOmmndwQp9sckObT8PMVXR0Jua13g0JMjsVP11/n53DvSbyiVl07xv7ErsjTN3+ljb
         pgwYyLArOIMtt6VCBijW02qFExxJhQ+BC8K+NRokMemDTCbWp1Px8LmvnX92jYWgfY5E
         +4FByQgOzkGVTRBRFvj6Jg8PklCII0pibxyUkOFxZ73yLColAp9C3lW4Sw5Vg1eDmTu5
         Pgc7gbcSe/gwsEGuuc5IeNM44r8M054Jo8ONmDpeAzivOlI9NWf4YgNAwJ/v24tPpKYS
         02WsVHpxzFl1xzzYvgsF2xMcxgnihqwXeIxpIwnSwEiY89hK5GcSEQbUKrqb6FPgX11t
         FqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685142654; x=1687734654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzzwX4jI8qfzX9UxemVFwpvHZe0mlondIIclMNme04k=;
        b=fORfJG9SdKlbPRASJHkeibxvo1MIHP0Cb8MR8U92CmYe7X6vN556W/XuccdZ+6EGwJ
         QtO7PDmERvlGXGEeRq1sWqgX2ILxeTAxaLJY3rM3j7jxZILEn6sGA+tLueCA5mxxq5Vi
         UCa5Si/7uwHSM40Nd0VI0jXXdus5LWOrnEHSCiUdW9bCcsR9ID2XLPo3Hz6yTZtd1d4K
         qVXtHC7mYlcG3UPBcrnIBzIo6GRSfXwVAw0lnCh4xyVkjxlZJIElZ++9mBVHvJd/UgJt
         H+fkJKm5i57daLRIRCqKHzEDEW7HxtAPc4mT424QqGrGUPShS1qj/o6SxWo9TavGRjFe
         duNw==
X-Gm-Message-State: AC+VfDzi+YRSm5poJPZiUrF5Y5ytsm4ekZvmEfJwZpH/WrCqrhgqF9wq
	N0MH7YpHWZMxAYKrRpFdazeDvpMZFGxpPkkI+N8=
X-Google-Smtp-Source: ACHHUZ6MiW4pJpPHAIm0mqK+fGib0HKPAj0qOwudKcdK4zhv1ijzVmDGDJBagMj42DB0v6hJPLQeSL4Rrgi948iHNUc=
X-Received: by 2002:a17:903:22c3:b0:1b0:122f:672b with SMTP id
 y3-20020a17090322c300b001b0122f672bmr4172388plg.47.1685142653765; Fri, 26 May
 2023 16:10:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAABZP2wiPdij+q_Nms08e8KbT9+CgXuoU+MO3dyoujG_1PPHAQ@mail.gmail.com>
 <073cf884-e191-e323-1445-b79c86759557@linux.dev> <CAABZP2yjONcZNVKT88JXq_QyVzuDnu12nD8APT0XJ45dOtSFrQ@mail.gmail.com>
 <CAABZP2zvn_rfC=E9FF-7Hmruq69gEnZJ5aW8mSbOPQijveeKcA@mail.gmail.com>
In-Reply-To: <CAABZP2zvn_rfC=E9FF-7Hmruq69gEnZJ5aW8mSbOPQijveeKcA@mail.gmail.com>
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
Date: Sat, 27 May 2023 07:10:42 +0800
Message-ID: <CAABZP2wBSjevevALA_VF-fTirp-bB42XouKRTuq=RR=60xL=EQ@mail.gmail.com>
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

On Sun, May 21, 2023 at 4:27=E2=80=AFPM Zhouyi Zhou <zhouzhouyi@gmail.com> =
wrote:
>
> Hi
>
> On Sat, May 20, 2023 at 7:37=E2=80=AFAM Zhouyi Zhou <zhouzhouyi@gmail.com=
> wrote:
> >
> > Thank you for responding so quickly ;-)
> >
> > On Sat, May 20, 2023 at 3:01=E2=80=AFAM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> > >
> > > On 5/19/23 5:07 AM, Zhouyi Zhou wrote:
> > > > Dear developers:
> > > > I compiled bpftool and bpf tests in mainline (2d1bcbc6cd70),
> > > > but when I invoke:
> > > > bpftool struct_ops register bpf_cubic.bpf.o
> > > >
> > > > the command line fail with:
> > > > libbpf: struct_ops init_kern: struct tcp_congestion_ops data is not
> > > > found in struct bpf_struct_ops_tcp_congestion_ops
> > >
> > > At the machine trying to register the bpf_cubic, please dump the vmli=
nux btf and
> > > search for bpf_struct_ops_tcp_congestion_ops and paste it here:
> > >
> > > For example:
> > > #> bpftool btf dump file /sys/kernel/btf/vmlinux
> > >
> > > ...
> > >
> > > [74578] STRUCT 'bpf_struct_ops_tcp_congestion_ops' size=3D256 vlen=3D=
3
> > >          'refcnt' type_id=3D145 bits_offset=3D0
> > >          'state' type_id=3D74569 bits_offset=3D32
> > >          'data' type_id=3D6241 bits_offset=3D512
> > OK
> > [214398] STRUCT 'bpf_struct_ops_tcp_congestion_ops' size=3D256 vlen=3D3
> >         'refcnt' type_id=3D298 bits_offset=3D0
> >         'state' type_id=3D214224 bits_offset=3D32
> >         'data' type_id=3D213704 bits_offset=3D512
> >
> > Please tell me if I could provide any further information.
> >
> > You are of great help
> >
> > Thank you very much
> > Zhouyi
> Thanks for your help
>
> Or, can you teach me how to prepare an environment that can run
> "bpftool struct_ops register xxx.o" ;-)
> (A few words of description of OS version (Ubuntu/CentOS/Suse for etc)
> and example kernel .config is enough)
I invoke following commands, and it works:
cd tools/testing/selftests/bpf
find . -name vmlinux.h|xargs rm
make -j 20

put bpf_cubic.bpf.o to my virtual machine, and it works!
I don't know why

Thank you all!
Best Regards
Zhouyi
>
> I am an enthusiastic learner ;-)
>
> Thanks in advance
> Zhouyi
> > >

