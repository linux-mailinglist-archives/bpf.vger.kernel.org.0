Return-Path: <bpf+bounces-5731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA68375FEAC
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 20:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FAE2281555
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 18:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E925100A7;
	Mon, 24 Jul 2023 18:00:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CD4F9E5
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 18:00:26 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86590172D;
	Mon, 24 Jul 2023 11:00:25 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b72161c6e9so71276461fa.0;
        Mon, 24 Jul 2023 11:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690221624; x=1690826424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKpNqY8f0mYa5U7e/O0Zjuwp+qRiTKpk1WGgmDNW+UA=;
        b=FbvwyX+AsInXMX78Myxy7I9+awMLOiQcB/aIRdDKHB9IxVBEg5p4aQTqtWhvcdzmGC
         gXuEePJrW9qJYWN2iqHS/bM8pm0aOQNRmXoodpJH3ZzBmy7Ulp4agyjRXtE08EDcZFu0
         CEe3zGmNRTnLu9IMtDrJO2EIyO0W3v5PiBZB0I6XIwAhtoegGRf53vnjzXEM9VxpDpWg
         UR9Qw7n4eDCPAo25RkrP0X5oWad3qMwXFocs41TsLg2HRV7zQPEehY6Tm/9ZCbUF9TCm
         FOlh2I0gfiOYfSPtO8xkcsvmFrltHWVlfPeHfS4T9zJYDgPWGMuTvDAhE4ndd6ifITj3
         iDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690221624; x=1690826424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKpNqY8f0mYa5U7e/O0Zjuwp+qRiTKpk1WGgmDNW+UA=;
        b=Y/mK3ynXEpSIWcy2Pf7WF/oahX3OGk6mj5+Tg0ICED1JIzSQzYN/f2FEFFiR3FLM1C
         yN0eie9WKx09GyNTCsG/LFbLe+ko6qkVMAxLBXz1qX+EHW6+X7ozDj5Ws7clyohveOaq
         up02gOnFWOAoS+oJ7LW0g3t+pkXEKdC5JR9uOQg93sp2I7TvMwcPJxb+rO+AEe8wPLpV
         MSnfiPt380/e8NGdY7UwdSWPQSF1son2v3SJ+aIMhzskAfpXprYC+qWxW5hu594eEjoE
         XcKQb9Xxxt4EV4RV2qP09ORzJ3Ce0LrGBPnJVSUsgkBdReYXUC4CAX9ztiPBiYFNeiBA
         QfnA==
X-Gm-Message-State: ABy/qLZ8bMPgDBoxjwdCkL3bBEDtT+Wbr9Va47TA0w38dzgrWp+BvRKh
	FKblwJkqx9lFf3uLjO4WlKtpwIUSjgUfvFEu+wfy/CYbKOg=
X-Google-Smtp-Source: APBJJlGG8Y8e6dULSlz63EvXQGy4YB1ETqEmsIT8QVfD3RSr2wLtndkuG+l5yepNg2/InFB0JX9CpteBKIcDVBvar00=
X-Received: by 2002:a2e:b54a:0:b0:2b8:3974:60fb with SMTP id
 a10-20020a2eb54a000000b002b8397460fbmr5269655ljn.3.1690221623453; Mon, 24 Jul
 2023 11:00:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230722074753.568696-1-arnd@kernel.org> <CALOAHbCV2v3X7g1TD42yve0juhRD2vhq=DMtDz9P6+mX8Dae_w@mail.gmail.com>
 <CAADnVQKGe8DN+Zs387UVwpij3ROGqNEnc5r940h5ueqQYHTYCA@mail.gmail.com> <fa5e9098-d6f9-48a2-bb77-2620b6bb6556@app.fastmail.com>
In-Reply-To: <fa5e9098-d6f9-48a2-bb77-2620b6bb6556@app.fastmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 24 Jul 2023 11:00:11 -0700
Message-ID: <CAADnVQ+p4wpd=tKJAiwB34O1y5vv4mibtkt9D-F7sG=rQapcew@mail.gmail.com>
Subject: Re: [PATCH] bpf: force inc_active()/dec_active() to be inline functions
To: Arnd Bergmann <arnd@arndb.de>
Cc: Yafang Shao <laoar.shao@gmail.com>, Arnd Bergmann <arnd@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Hou Tao <houtao1@huawei.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jul 23, 2023 at 11:32=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrot=
e:
>
> >> If so, why can't we improve the compiler ?
> >
> > Agree.
> > Sounds like a compiler bug.
>
> I don't know what you might want to change in the compiler
> to avoid this. Compilers are free to decide which functions to
> inline in the absence of noinline or always_inline flags.

Clearly a compiler bug.
Compilers should not produce false positive warnings regardless
how inlining went and optimizations performed.


> One difference between gcc and clang is that gcc tries to
> be smart about warnings by using information from inlining
> to produce better warnings, while clang never uses information
> across function boundaries for generated warnings, so it won't
> find this one, but also would ignore an unconditional use
> of the uninitialized variable.
>
> >> If we have to change the kernel, what about the change below?
> >
> > To workaround the compiler bug we can simply init flag=3D0 to silence
> > the warn, but even that is silly. Passing flag=3D0 into irqrestore is b=
uggy.
>
> Maybe inc_active() could return the flags instead of modifying
> the stack variable? that would also result in slightly better
> code when it's not inlined.

Which gcc are we talking about here that is so buggy?

