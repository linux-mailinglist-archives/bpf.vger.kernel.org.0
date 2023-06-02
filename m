Return-Path: <bpf+bounces-1737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915457209FC
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 21:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D01F281A73
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 19:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B991E535;
	Fri,  2 Jun 2023 19:43:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2875F17759
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 19:43:27 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB61123
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 12:43:26 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b1b084620dso12543111fa.0
        for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 12:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685735005; x=1688327005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5RgxzeR5wVmj/0alSfPERFwvyzHbDIkRpX58syhIlE=;
        b=lwaJ7aRRCMnZTtzACUxiG5K77qVc+WN+ACVjJK5YxwuG3bFm9tjbsxDOqbFNnEwmCW
         w0IjswA4rOmPFWDAmgCtURs0Z92VyuLQpP+4PSfLdxEUmljYsFQRa7nr6ROAtwP5v/CC
         kRJPIzfuapzznrKHqykmMzbs2L7rzdqpEZ/IlMBrZfqnpboX/enZKCm8z1qoyqPggUsP
         nwohf1ntif3eZlgcO0jpEjwjm3U0jC9PG42yjo+VBF/zSHlb8qR/rAsPr61I+z9LXw35
         qCqDLZPhUj/BoZi3HlzBprQSYF1zT9RVj/BiWjrFeLNCWCrnBcWaiM6PTPRDn6FKM3Hf
         nBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685735005; x=1688327005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I5RgxzeR5wVmj/0alSfPERFwvyzHbDIkRpX58syhIlE=;
        b=l7YhSeJnP60ubctorvUH6i3NCMLsGgFwLphnIkTQGmHs9FvpmjL4OawU+eLbkiuR1E
         Mhi+6B7eq3bcNhM+RFKatpL6yfe2uU39QFB8bjLSRNYonSiarloGlhOR5LP1Hyag+Re5
         egxHGKA54kiHxIcGsMzfc59G3x1xiZy5HfNQaX49YbQZVIiVVEdNi11vv7KBxMjDkgsA
         zOqdJgzGf3LvRYxzIF2fugX4irLqM2qSvMS6KbH7cTqTK6TLW7cRX1/5reNh3a0MYB3u
         TLe/3SdAm93vGrSY4UFtYfw5V6tW91EDz16vB2iAHXDysZTQ/oIgxxe0Y+H4uRnIGzgw
         Y99Q==
X-Gm-Message-State: AC+VfDzD55ZSEFZ9vrw6ISh5ChnPvTHNM/l98LtST0N34EWkuQuElFes
	yhpcOJuJeB4BWtF4zWZY3K+XKoAHqICtd2WBxaU=
X-Google-Smtp-Source: ACHHUZ7gLVMciE4+LEXXZ4SpgozLhi0jpgALWmnKEQ23K4G2dFHagzEz/wRz7sWdTGk6Zm7BgBczoHwqUclxWE1hpOc=
X-Received: by 2002:a2e:82c2:0:b0:2b1:a874:34c9 with SMTP id
 n2-20020a2e82c2000000b002b1a87434c9mr701195ljh.22.1685735004281; Fri, 02 Jun
 2023 12:43:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230530172739.447290-1-eddyz87@gmail.com> <20230530172739.447290-2-eddyz87@gmail.com>
 <CAEf4BzYJbzR0f5HyjLMJEmBdHkydQiOjdkk=K4AkXWTwnXsWEg@mail.gmail.com>
 <8b0da2244a328f23a78dc73306177ebc6f0eabfd.camel@gmail.com>
 <20230601020514.vhnlnmowbo6dxwfj@MacBook-Pro-8.local> <81e2e47c71b6a0bc014c204e18c6be2736fed338.camel@gmail.com>
 <CAADnVQJY4TR3hoDUyZwGxm10sBNvpLHTa_yW-T6BvbukvAoypg@mail.gmail.com>
 <6a52b65c270a702f6cbd6ffcf627213af4715200.camel@gmail.com>
 <CAEf4BzbM2bWHfdCoVYdfUmuYJRVzADBXHzbDwHkg_EX13pJ7gA@mail.gmail.com>
 <7f39e172d68a1ad92ffe886b4df060ef49cff047.camel@gmail.com>
 <CAADnVQ+crhOPcnmC-N+CNbQ6PGdG6KKE+s5P1TEq_2KxL14iSw@mail.gmail.com> <e5f82ece5f54067bf6c0514fdeb095f03636dd99.camel@gmail.com>
In-Reply-To: <e5f82ece5f54067bf6c0514fdeb095f03636dd99.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 2 Jun 2023 12:43:13 -0700
Message-ID: <CAADnVQ+eQ2hVnspsor0nNCR-bN68BtFCZ6Q=Qf-+_ow=Z6bJHA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 2, 2023 at 12:37=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
> > > - do a check as follows:
> > >   if (rold->precise && rold->id && !check_ids(idmap, rold, rcur))
> >
> > Ignoring rcur->id > 0 ? Is it safe?
>
> Well, I thought about it a bit and arrived to the following reasoning:
> - suppose checkpoint C exists, is proven safe and has
>   registers r6=3DPscalar(range1),id=3D0 and r7=3DPscalar(range2),id=3D0
> - this means that C is proven safe for any value of
>   r6 in range1 and any value of r7 in range2
> - having same id on r6 and r7 means that r6 and r7 share same value
> - so this is just a special case of what's already proven.
>
> But having written this down, it looks like I also need to verify
> that range1 and range2 overlap :(

I'm lost.
id=3D=3D0 means there is no relationship between regs.
with
if (rold->precise && rold->id && !check_ids(idmap, rold, rcur))

and r6_old->precise
we will only do range_within(rold, rcur) && tnum_in() check
and will ignore r6_cur->id and its relationship with some other reg in cur.
It could be ok.

