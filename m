Return-Path: <bpf+bounces-1742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 959BA720A31
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 22:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 208EA1C21257
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 20:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA721F18E;
	Fri,  2 Jun 2023 20:22:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC901E537
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 20:22:41 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC14C1BE
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 13:22:39 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b1b3836392so10682381fa.0
        for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 13:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685737358; x=1688329358;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PjL6ci/drtNdTX8KJDQmUQ+aY/1LiTs5oS3ho7A5jWE=;
        b=qmh89dkqYnQ/h7tZ/G/Aj4JRyCJoaJFUlNzxwjI9VlVKLgzruRMSCqy0DouP3/ACDp
         YlU089QHWXG7vhSYdeXvpvTq5UcMWTZvwziC6EuxVTxQTCTTNK97yNXa/qhemM0xNMgP
         Mfz31MNu0GIDvtYGqmvzPNMYUfsyHOdEMiyjlvdcOgcxwNb4qFFPmHZY7KrsuaCoTweR
         ILxX4qsAEQvSBpSeQ24O1jfv8+qjwDNvieyOJX9X9eG/u5CU+JiLyUf8PFnMxVjynzP9
         IjVN8WcgJOjW+/0RtDMBtX7zJjFJGv2FgLVQ7082MuKCmV7/IKmAU99dYsEVcBUwmuRZ
         bKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685737358; x=1688329358;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PjL6ci/drtNdTX8KJDQmUQ+aY/1LiTs5oS3ho7A5jWE=;
        b=Zt4tfqGzc9mF4KFNhKkQRhORILz7/fkxbsnmnJ6XFV9QlEvkIxU8X0wUD3g1Z13thh
         7mDrfDfeFsKLQVjtK7f5hiVaU1xqo0k3Y115UVEmXJJr5Tsxr1Ap/52lohfwuczdRh5Q
         1UCrHMfMlDoZZxGUvD540Cxwg5di6jvEtjjTQxSTD8FTkHtGBIr4IvIfJ5sOb8SqqG9D
         Ix1WVZLFl/8BBc3WzVnl2i210UUXhvqFFCmu9Oal9Zr7Zy/Ghg/HLSXugZxB+QO2Pdzk
         pxbzZJbpVNKETjwOD3IcYK8kXt/U4q3aZOSZxST6SSzUdwJi5pWJwJV7wbIAJphsQ5RG
         G2GQ==
X-Gm-Message-State: AC+VfDzXFU5mZN4g5sm2q250lLxBSyHH+XYyOZJ1BNc0s3uQuM6dDPSb
	IRTRnpZxJoYPLkN9rL4/onw=
X-Google-Smtp-Source: ACHHUZ6Hmwj55xTg0ozbDpfLB4/0EZKb9xdr5SPsx8mX66kLiD6vW9+zQWJIXxDgxEOgixv61ofIvg==
X-Received: by 2002:a2e:8788:0:b0:2ae:df5a:9637 with SMTP id n8-20020a2e8788000000b002aedf5a9637mr672780lji.21.1685737357963;
        Fri, 02 Jun 2023 13:22:37 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id w14-20020a2e958e000000b002adb60e46d3sm340873ljh.81.2023.06.02.13.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 13:22:37 -0700 (PDT)
Message-ID: <ab3ebb05a432ac687c65a08db41e576526ae8951.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, Yonghong Song
 <yhs@fb.com>
Date: Fri, 02 Jun 2023 23:22:36 +0300
In-Reply-To: <CAADnVQLtPzDiPxTXk=s9NC4bO-wrDe7+F=3oEcWkLtbGr+p_yA@mail.gmail.com>
References: <20230530172739.447290-1-eddyz87@gmail.com>
	 <20230530172739.447290-2-eddyz87@gmail.com>
	 <CAEf4BzYJbzR0f5HyjLMJEmBdHkydQiOjdkk=K4AkXWTwnXsWEg@mail.gmail.com>
	 <8b0da2244a328f23a78dc73306177ebc6f0eabfd.camel@gmail.com>
	 <20230601020514.vhnlnmowbo6dxwfj@MacBook-Pro-8.local>
	 <81e2e47c71b6a0bc014c204e18c6be2736fed338.camel@gmail.com>
	 <CAADnVQJY4TR3hoDUyZwGxm10sBNvpLHTa_yW-T6BvbukvAoypg@mail.gmail.com>
	 <6a52b65c270a702f6cbd6ffcf627213af4715200.camel@gmail.com>
	 <CAEf4BzbM2bWHfdCoVYdfUmuYJRVzADBXHzbDwHkg_EX13pJ7gA@mail.gmail.com>
	 <7f39e172d68a1ad92ffe886b4df060ef49cff047.camel@gmail.com>
	 <CAADnVQ+crhOPcnmC-N+CNbQ6PGdG6KKE+s5P1TEq_2KxL14iSw@mail.gmail.com>
	 <e5f82ece5f54067bf6c0514fdeb095f03636dd99.camel@gmail.com>
	 <CAADnVQ+eQ2hVnspsor0nNCR-bN68BtFCZ6Q=Qf-+_ow=Z6bJHA@mail.gmail.com>
	 <f574c204781a139a6ef448dfd3d22935eba81ce0.camel@gmail.com>
	 <CAADnVQLtPzDiPxTXk=s9NC4bO-wrDe7+F=3oEcWkLtbGr+p_yA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-06-02 at 13:03 -0700, Alexei Starovoitov wrote:
> On Fri, Jun 2, 2023 at 12:51=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Fri, 2023-06-02 at 12:43 -0700, Alexei Starovoitov wrote:
> > > On Fri, Jun 2, 2023 at 12:37=E2=80=AFPM Eduard Zingerman <eddyz87@gma=
il.com> wrote:
> > > > > > - do a check as follows:
> > > > > >   if (rold->precise && rold->id && !check_ids(idmap, rold, rcur=
))
> > > > >=20
> > > > > Ignoring rcur->id > 0 ? Is it safe?
> > > >=20
> > > > Well, I thought about it a bit and arrived to the following reasoni=
ng:
> > > > - suppose checkpoint C exists, is proven safe and has
> > > >   registers r6=3DPscalar(range1),id=3D0 and r7=3DPscalar(range2),id=
=3D0
> > > > - this means that C is proven safe for any value of
> > > >   r6 in range1 and any value of r7 in range2
> > > > - having same id on r6 and r7 means that r6 and r7 share same value
> > > > - so this is just a special case of what's already proven.
> > > >=20
> > > > But having written this down, it looks like I also need to verify
> > > > that range1 and range2 overlap :(
> > >=20
> > > I'm lost.
> > > id=3D=3D0 means there is no relationship between regs.
> > > with
> > > if (rold->precise && rold->id && !check_ids(idmap, rold, rcur))
> > >=20
> > > and r6_old->precise
> > > we will only do range_within(rold, rcur) && tnum_in() check
> > > and will ignore r6_cur->id and its relationship with some other reg i=
n cur.
> > > It could be ok.
> >=20
> > Yes, but I just realized that for the following case:
> >=20
> >   Old                      Cur
> >   r6=3DPscalar(range1),id=3D0  r6=3DPscalar(range1),id=3D1
> >   r7=3DPscalar(range2),id=3D0  r7=3DPscalar(range2),id=3D1
> >=20
> > For 'Cur' to be a subset of 'Old' ranges range1 and range2
> > have to have non-empty overlap, so my new check:
>=20
> In theory. yes. and most likely that _was_ the case for 'old',
> but 'cur' doesn't need to do that check.
> 'old' was successful already and 'cur' ranges just need to be within.
>=20
> so
>=20
> >   if (rold->precise && rold->id && !check_ids(idmap, rold, rcur))
> >=20
> > is not fully correct.
>=20
> still looks correct.

Ok, that's the last piece, if Cur[r6.id=3D1] and Cur[r7.id=3D1] they share
the same range. So as long as this range is within range1, range2 it is
all good. And the range is checked downstream of regsafe.
So, yes '(rold->precise && rold->id && !check_ids(idmap, rold, rcur))' is f=
ine.

>=20
> >=20
> > It was a "clever" attempt to ignore solo scalar IDs in Cur without modi=
fying Cur.
> > I'll think a bit more, sorry for a lot of noise.


