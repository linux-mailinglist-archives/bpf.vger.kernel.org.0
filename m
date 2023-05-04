Return-Path: <bpf+bounces-39-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6526F78BE
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 00:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E6BA1C21493
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 22:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD30C15A;
	Thu,  4 May 2023 22:03:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893CBC155
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 22:03:57 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7141154B
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 15:03:55 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-94f1d0d2e03so169798166b.0
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 15:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683237834; x=1685829834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bm/MqcHvW+pNWto/Hy0s/2kAPfe9FtErNhA5b8gBZQo=;
        b=DiSotULz7vnhefFfPt9lke2JwIftSaYwz9eACtZfr3bF6ra1iYkwh/8CSnIaYAkyIb
         ShpCsbovCvbpAafso+F/u5ra4g602vp9N6d26VqQ8esZ10y6LKu4HmVzut6r4OeDr6TA
         oveyoBUI4M2IdfSvrIQkbFfgr2Q3nLx5t+xqhLbryUAesrFGjdOtdrEm2XDsPGgTell5
         C6fFEj87na4QUVYR/jy4aQMXWxt36uUdLNd4BX8l6UxmqbHcc320npmt2YsCNpzs7lXb
         0szqY+IzuLguROASFXO7F32Yvz19ikS8bMDlHiDhi6AY0fIu6NbbI/qjAevRQcs5AcQb
         GOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683237834; x=1685829834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bm/MqcHvW+pNWto/Hy0s/2kAPfe9FtErNhA5b8gBZQo=;
        b=FlFy/FztNnpGsPfM3fTNreIhAt007c7gbz78THDS3IeXH29/aIHQUuw5fMj3aJNN6O
         VU1IU2h33BQx2CPzZCuaZh9yi0EGakx201dgMc6lGXWMU4bRoWsb0N9hNE53zl2CnOqD
         gZo+FRBg2DQLxkc2VCVJGu6HY8OSsEqMMb43ej3Dl/ZkD4r0CS9WxuxGsy/DDSZmcWDy
         dQ8stgctyFvp6GAzxUcxTOeqwZLyLw07pQ2th/h4wDnImAtYsi1LyMorvGe1p2JaTJgS
         hZF4HhdjGB7Dsfl2ME9LghciN5N5/FNV1K4B4dS2cIPH66tf5kIXIiZGtELYfdHQ90cw
         eOZg==
X-Gm-Message-State: AC+VfDzlAdeJmugym24XL1CxtoH4l/Qtcs3YJ6fSaVS2nrC0hdlmJv31
	HQRdYoXOiIQOxUoeaInOhVQSn/v/OR+x+BXFU8VM35oE
X-Google-Smtp-Source: ACHHUZ5RBkMamS/E4lMRCOdHm5v2FyuV1OJ52N3GDyqMOij8CXVBgS9+9ZEGcf47eCXhvmQIzpsjNxDADJw89daoWHE=
X-Received: by 2002:a17:906:ef09:b0:962:46d7:c8fc with SMTP id
 f9-20020a170906ef0900b0096246d7c8fcmr277343ejs.21.1683237834296; Thu, 04 May
 2023 15:03:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230425234911.2113352-1-andrii@kernel.org> <20230425234911.2113352-9-andrii@kernel.org>
 <20230504165633.mtf3etaof3afscpa@MacBook-Pro-6.local>
In-Reply-To: <20230504165633.mtf3etaof3afscpa@MacBook-Pro-6.local>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 May 2023 15:03:42 -0700
Message-ID: <CAEf4BzbsWOiM+ZQhuWyktc4g5MineWGUH-ZG8bMgy8KGLSsYww@mail.gmail.com>
Subject: Re: [PATCH bpf-next 08/10] bpf: support precision propagation in the
 presence of subprogs
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

On Thu, May 4, 2023 at 9:56=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Apr 25, 2023 at 04:49:09PM -0700, Andrii Nakryiko wrote:
> > Add support precision backtracking in the presence of subprogram frames=
 in
> > jump history.
> >
> > This means supporting a few different kinds of subprogram invocation
> > situations, all requiring a slightly different handling in precision
> > backtracking handling logic:
> >   - static subprogram calls;
> >   - global subprogram calls;
> >   - callback-calling helpers/kfuncs.
> >
> > For each of those we need to handle a few precision propagation cases:
> >   - what to do with precision of subprog returns (r0);
> >   - what to do with precision of input arguments;
> >   - for all of them callee-saved registers in caller function should be
> >     propagated ignoring subprog/callback part of jump history.
> >
> > N.B. Async callback-calling helpers (currently only
> > bpf_timer_set_callback()) are transparent to all this because they set
> > a separate async callback environment and thus callback's history is no=
t
> > shared with main program's history. So as far as all the changes in thi=
s
> > commit goes, such helper is just a regular helper.
> >
> > Let's look at all these situation in more details. Let's start with
> > static subprogram being called, using an exxerpt of a simple main
> > program and its static subprog, indenting subprog's frame slightly to
> > make everything clear.
> >
> > frame 0                               frame 1                 precision=
 set
> > =3D=3D=3D=3D=3D=3D=3D                               =3D=3D=3D=3D=3D=3D=
=3D                 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >  9: r6 =3D 456;
> > 10: r1 =3D 123;                                         r6
> > 11: call pc+10;                                               r1, r6
> >                               22: r0 =3D r1;            r1
> >                               23: exit                r0
> > 12: r1 =3D <map_pointer>                                        r0, r6
> > 13: r1 +=3D r0;                                         r0, r6
> > 14: r1 +=3D r6;                                         r6;
> > 15: exit
> >
> > As can be seen above main function is passing 123 as single argument to
> > an identity (`return x;`) subprog. Returned value is used to adjust map
> > pointer offset, which forces r0 to be marked as precise. Then
> > instruction #14 does the same for callee-saved r6, which will have to b=
e
> > backtracked all the way to instruction #9. For brevity, precision sets
> > for instruction #13 and #14 are combined in the diagram above.
> >
> > First, for subprog calls, r0 returned from subprog (in frame 0) has to
> > go into subprog's frame 1, and should be cleared from frame 0. So we go
> > back into subprog's frame knowing we need to mark r0 precise. We then
> > see that insn #22 sets r0 from r1, so now we care about marking r1
> > precise.  When we pop up from subprog's frame back into caller at
> > insn #11 we keep r1, as it's an argument-passing register, so we eventu=
ally
> > find `10: r1 =3D 123;` and satify precision propagation chain for insn =
#13.
> >
> > This example demonstrates two sets of rules:
> >   - r0 returned after subprog call has to be moved into subprog's r0 se=
t;
> >   - *static* subprog arguments (r1-r5) are moved back to caller precisi=
on set.
>
> Haven't read the rest. Only commenting on the above...
>
> The description of "precision set" combines multiple frames and skips the=
 lower
> which makes it hard to reason.

I currently print "current frame" mask only, depending on whether
instruction is in parent or subprog. But yeah, I can make it more
explicit and print both frames' masks, to make it easier to follow

> I think it should be:
>
> 10: r1 =3D 123;                                           fr0: r6
> 11: call pc+10;                                         fr0: r1, r6
>                                 22: r0 =3D r1;            fr0: r6; fr1: r=
1
>                                 23: exit                fr0: r6; fr1: r0
> 12: r1 =3D <map_pointer>                                  fr0: r0, r6
> 13: r1 +=3D r0;                                           fr0: r0, r6
> 14: r1 +=3D r6;                                           fr0: r6
>
> Right?

right, exactly, I'll use this format

