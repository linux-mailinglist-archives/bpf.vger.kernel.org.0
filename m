Return-Path: <bpf+bounces-5839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9A8761E38
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 18:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E982828111F
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 16:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09E42417A;
	Tue, 25 Jul 2023 16:16:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AED621D5D
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 16:16:04 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C133213C
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 09:15:45 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b72161c6e9so271961fa.0
        for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 09:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690301734; x=1690906534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=952/tqDCHq+lq2SmoX7TIsxaFEfjApJfJTF5tci0Ky8=;
        b=qVy+2guYcjVPiCqP994Q8btqOeLyhCg/KzahnroWYY4Dnk7DZZ8Akzoi57LGvVfwqL
         Ee+Pzad+6cd1o/G9UZDuMh/+mWgTXyKtZoY46YEDtfXQ2lRCkigS0lNSUxN5Weyn3yyi
         z90I0FTcpSkie6YaZv+qadKufbBhGAaoC7OM8dYyqhfoERpc/tQh3RtBdUjpoqjwD0Mb
         I8rg83jyZSd+Ao5yJ1An+4egEamz7qR5O5o6sZdOSlLBc7m9hyN1Kxcdqiom92xSwzUo
         Sq9WONyND2lJznUinhp4YzGaTCyxCbjuCSCl441qJ0EkG03tnTj3Y2dzyRDQ+1kjAQzJ
         yWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690301734; x=1690906534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=952/tqDCHq+lq2SmoX7TIsxaFEfjApJfJTF5tci0Ky8=;
        b=Bs3fom1xrkJqPxRICu3zaguYg0ENSpz3M3QIHf3GmOthVaFtdko2MGWDHBZJ+02xbH
         Q+R3g0br/x5w6VGrZb5bSxsLa+e9Hc0joE2vSuxOvCZ7z3b+cscr2bFep6UhzFMoE2/w
         SuY5+Jr30C3/QJ3/neirVcJXyDAx3ScU08pJ/qReVasvxfpmF9mJ1FfRXm0meCHqa0Ps
         RMvggjskVaBvsuHrh1CKTtRi60dhQWDghw/xM56uYGS1RvZ1Dne0ReI9nhRx+6FvLVqz
         sPuOFdj+YSJklv9OhD1PVPW1eNx+dfiTp2AMVZqWzzQjpK5ZSsMJg+WSGigOxZsUyu1k
         tSJQ==
X-Gm-Message-State: ABy/qLZbIX0zj1qs7So/xTYdwIHqeIpg9ks8kuWbziLXAxIMeCmVZUsC
	Eh6hiXPFbbE+TiIcTb2MArdHJL2/I9/cVDw5pXY=
X-Google-Smtp-Source: APBJJlFwFr/5oSBdAWwa25/cm0LEOFI3VjAVGGF0SGRkvWLTgm5/KfKD4tODLO6AZwFEyNS/FNyC+v2emfsHEmRoGCE=
X-Received: by 2002:a05:651c:48c:b0:2b7:34c4:f98f with SMTP id
 s12-20020a05651c048c00b002b734c4f98fmr1055009ljc.11.1690301733790; Tue, 25
 Jul 2023 09:15:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACsn0ckZO+b5bRgMZhOvx+Jn-sa0g8cBD+ug1CJEdtYxSm_hgA@mail.gmail.com>
 <PH7PR21MB3878D8DCEF24A5F8E52BA59DA303A@PH7PR21MB3878.namprd21.prod.outlook.com>
In-Reply-To: <PH7PR21MB3878D8DCEF24A5F8E52BA59DA303A@PH7PR21MB3878.namprd21.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 25 Jul 2023 09:15:22 -0700
Message-ID: <CAADnVQJ1fKXcsTXdCijwQzf0OVF0md-ATN5RbB3g10geyofNzA@mail.gmail.com>
Subject: Re: [Bpf] Review of draft-thaler-bpf-isa-01
To: Dave Thaler <dthaler@microsoft.com>
Cc: Watson Ladd <watsonbladd@gmail.com>, "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 7:03=E2=80=AFAM Dave Thaler <dthaler@microsoft.com>=
 wrote:
>
> I am forwarding the email below (after converting HTML to plain text)
> to the mailto:bpf@vger.kernel.org list so replies can go to both lists.
>
> Please use this one for any replies.
>
> Thanks,
> Dave
>
> > From: Bpf <bpf-bounces@ietf.org> On Behalf Of Watson Ladd
> > Sent: Monday, July 24, 2023 10:05 PM
> > To: bpf@ietf.org
> > Subject: [Bpf] Review of draft-thaler-bpf-isa-01
> >
> > Dear BPF wg,
> >
> > I took a look at the draft and think it has some issues, unsurprisingly=
 at this stage. One is
> > the specification seems to use an underspecified C pseudo code for oper=
ations vs
> > defining them mathematically.

Hi Watson,

This is not "underspecified C" pseudo code.
This is assembly syntax parsed and emitted by GCC, LLVM, gas, Linux Kernel,=
 etc.

> > The good news is I think this is very fixable although tedious.
> >
> > The other thornier issues are memory model etc. But the overall structu=
re seems good
> > and the document overall makes sense.

What do you mean by "memory model" ?
Do you see a reference to it ? Please be specific.

