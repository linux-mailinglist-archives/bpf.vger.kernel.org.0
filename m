Return-Path: <bpf+bounces-1234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2FF7111E1
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 19:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AD751C20E9D
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 17:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3AF1DDC0;
	Thu, 25 May 2023 17:19:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6C21D2A4
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 17:19:47 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0887B6
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 10:19:45 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-96f9cfa7eddso162791366b.2
        for <bpf@vger.kernel.org>; Thu, 25 May 2023 10:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685035184; x=1687627184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRF1xYVNc5u22SGFZTt6FKO/QolgxwxRCuye2ydodGE=;
        b=rTVCoC3MupQXtIypZDKmzEZ+aX+JndE0EEjgnJmzh2wiHExKch74kgmpAyfG2tMjfZ
         8pcV+jbi+kD3E5/7I4ngg02Cy5SHK3PrWDt/j0eJPUu+GQNnTOrUA7qTfpryeDvvNslk
         Rp04SZKwzimEVGfcnmTrpfDAnH8swry/RAPbDLJt06+MX97Oy8xQotnkygXUEBlf/lBX
         /9P1w0urkFlrBmF+SC813ytl//Pqp5UoIO7FAHCaT4GGRA+nGtbfUjRCsELSYAbQ9OZx
         RGsXtkYlvZM9i4NqvqdZ72YmG/onD7DccSc9J6+JY8sgQSgeVRDvR1bJqT/e+MVpWBBi
         IwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685035184; x=1687627184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRF1xYVNc5u22SGFZTt6FKO/QolgxwxRCuye2ydodGE=;
        b=MPu99pYUm7OmCLZM5+fXzW1y70FCbd52bcHEeBO8ps/TEUUTOHqFVpQOMApZoOo8cA
         mIb4OXVkS5qWab8hzI6004qaRqwwYmo9tkYDV+8vd71wLPWMS8SiArnvScw+j8F2FswW
         3ALjZXTuGzmyfCD9W2T/A24RosDSVfSqxVfQw4SjhbvrvdpdFhkVuABm5KkoYePNtsb3
         PySk6udGD+CM88t4avfpvHeoGbP5i60U6AIXDxAYM/iRhRt9Zf0OKIhqtCjfiD6A2Y4v
         6KjTdJVkkIn5sIYbGOd4lEEx7AkK8ljM5+iXLPiJZBjKTRl1wRvuinWPXAq9Vr7/kg5H
         QbcQ==
X-Gm-Message-State: AC+VfDxTGMo9DA6fDKmq5bgaklaayiWEv1RZGCVJmSprsqBk5WYWTg9y
	P3mfAlOWgdAw7j8SJIzTTieNHEDyEi3QvkvmFzczGw5590I=
X-Google-Smtp-Source: ACHHUZ7Zj7jS+aqEOcMt1Zobi/TbHWvYGEELG4Rx71jtb90Ik5boaPwOQ0+z48FtysCO9ZvuK3Hjovw4nINqGC5xtWY=
X-Received: by 2002:a17:907:97cc:b0:966:4bb3:5b8d with SMTP id
 js12-20020a17090797cc00b009664bb35b8dmr2391697ejc.30.1685035183817; Thu, 25
 May 2023 10:19:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230524210243.605832-1-andrii@kernel.org> <20230524210243.605832-2-andrii@kernel.org>
 <20230525031810.g42tmdk7ykjrkrcr@MacBook-Pro-8.local>
In-Reply-To: <20230525031810.g42tmdk7ykjrkrcr@MacBook-Pro-8.local>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 May 2023 10:19:31 -0700
Message-ID: <CAEf4Bzbe-D1PwWB7T4SCzNG3RKTMko_0h1TOiEmUrR22NPjfXg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/3] bpf: revamp bpf_attr and name each
 command's field and substruct
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 24, 2023 at 8:18=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, May 24, 2023 at 02:02:41PM -0700, Andrii Nakryiko wrote:
> >
> > And there were a bunch of other similar changes. Please take a thorough
> > look and suggest more changes or which changes to drop. I'm not married
> > to any of them, it just felt like a good improvement.
>
> Agree that current layout sucks, but ...
>
> >  include/uapi/linux/bpf.h       | 235 +++++++++++++++++++++++++++------
> >  kernel/bpf/syscall.c           |  40 +++---
> >  tools/include/uapi/linux/bpf.h | 235 +++++++++++++++++++++++++++------
> >  3 files changed, 405 insertions(+), 105 deletions(-)
>
> ... the diff makes it worse. The diffstat for "nop" change is a red flag.

Only 100 lines are a real "nop" change to copy/paste existing fields
that are in unnamed fields. The rest is a value add.

I don't think the deal is in stats, though, right?

>
> > +     /*
> > +      * LEGACY anonymous substructs, for backwards compatibility.
> > +      * Each of the below anonymous substructs are ABI compatible with=
 one
> > +      * of the above named substructs. Please use named substructs.
> > +      */
> > +
>
> All of them cannot be removed. This bagage will be a forever eyesore.
> Currently it's not pretty. The diffs make uapi file just ugly.
> Especially considering how 'named' and 'legacy' will start diverging.

We have to allow "divergence" (only in the sense that new fields only
go into named substructs, but the existing fields stay fixed, of
course), to avoid more naming conflicts. If that wasn't the case,
using struct_group() macro could have been used to avoid a copy/paste
of those anonymous field/struct copies.

So I'm not happy about those 100 lines copy paste of fixed fields
either, but at least that would get us out of the current global
naming namespace for PROG_LOAD, MAP_CREATE, BTF_LOAD, etc.

> New commands are thankfully named. We've learned the lesson,

Unfortunately, the problem is that unnamed commands are the ones that
are most likely to keep evolving.

> but prior mistake is unfixable. We have to live with it.

Ok, too bad, but it's fine. It was worth a try.

I tried to come up with something like struct_group() approach to
minimize code changes in UAPI header, but we have a more complicated
situation where part of struct has to be both anonymous and named,
while another part (newly added fields) should go only to named parts.
And that doesn't seem to be possible to support with a macro,
unfortunately.

