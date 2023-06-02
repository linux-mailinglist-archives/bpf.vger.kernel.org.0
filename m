Return-Path: <bpf+bounces-1734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9E57209AA
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 21:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D56281B1D
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 19:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A8C1F17D;
	Fri,  2 Jun 2023 19:13:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C501E500
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 19:13:26 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE2F1B7
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 12:13:25 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b1b86146afso1017931fa.3
        for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 12:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685733203; x=1688325203;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GmzI6ovsduszn2K0iEqtpCXFimFLMVqVPlvo5iY1WUg=;
        b=HpjJoOgJamv7mvV9Zb20/rRZCI0l45ZI6cZPFIXRKc+OAVpQfzb7W5kg0dsDUqOX/3
         0rMLq+YWmvIYA5kGhIdrsPVwTOLKApvzNqmfKwaJbhDJBBCFVBbxW6npj1kRXzKs2W0r
         TnA0eaBS8+8+38OeSZ1Q5vRqdFnaMOjJ3RAZ6Qmxz1G17pBiLfJjnnQA5JWk1ACmFsR9
         5plZkwmd+YwSOL4Fx3l7aW7ipxUGhYqhHSGeFObDhpWrqAnOWCKwmrqGNfn/DptGTK9V
         +HHZ/omDuP9nYpudvst4/91WVsbfCuTQIaU/GK3FEdAvYszj39sE4oCHxwgv+jZ7be28
         Fpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685733203; x=1688325203;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GmzI6ovsduszn2K0iEqtpCXFimFLMVqVPlvo5iY1WUg=;
        b=CVcy/GZcVlRUNg/u0fMZaslMfmtfAsGBklH83H1EKTDIn424htt++9FkuoRVMtv8U0
         NC0A7HiTkAsbIuEgkx2GZGgTCm24srk0PexuZMtunmaCoZe/zbfl5c66olgy1Dh1+Erq
         +XcFZRSZ1jLNfV5/9cmVVhLR7HpsJo+8tEOq8ARrjb9yZnYYfCek5i29lXeNMnOVQp+B
         5Lwc8K3LofjgKF7x4zaomYO0YrwYMpfHxYW64RHFLfs65Qhr0HwdCtr5dp0jbcRCnyne
         mD4uQ7hABASwIj9kaMRfF2Alo3i17dYB1bjSe8zbJ9s4GFocOpPzwGXjtps7VJ149UXX
         6iXg==
X-Gm-Message-State: AC+VfDyo+d3R//G+UplVHNmkM1fd+TwANpQidPRhFvMv2RKL7hvpRf13
	odqUovdDGdHIU+JpwqHIcqw=
X-Google-Smtp-Source: ACHHUZ4Pja8ZsN2Nc8zXydXdrOs2P/5Vv6w3jFhinifLHYsQoU+Qlnu1OXhd338OUBr+/27EwGZtfQ==
X-Received: by 2002:a2e:90c6:0:b0:2b0:2d23:79b with SMTP id o6-20020a2e90c6000000b002b02d23079bmr612875ljg.3.1685733202904;
        Fri, 02 Jun 2023 12:13:22 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id p15-20020a2ea40f000000b002adb6dd5a97sm319709ljn.27.2023.06.02.12.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 12:13:22 -0700 (PDT)
Message-ID: <7f39e172d68a1ad92ffe886b4df060ef49cff047.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf
 <bpf@vger.kernel.org>,  Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song <yhs@fb.com>
Date: Fri, 02 Jun 2023 22:13:21 +0300
In-Reply-To: <CAEf4BzbM2bWHfdCoVYdfUmuYJRVzADBXHzbDwHkg_EX13pJ7gA@mail.gmail.com>
References: <20230530172739.447290-1-eddyz87@gmail.com>
	 <20230530172739.447290-2-eddyz87@gmail.com>
	 <CAEf4BzYJbzR0f5HyjLMJEmBdHkydQiOjdkk=K4AkXWTwnXsWEg@mail.gmail.com>
	 <8b0da2244a328f23a78dc73306177ebc6f0eabfd.camel@gmail.com>
	 <20230601020514.vhnlnmowbo6dxwfj@MacBook-Pro-8.local>
	 <81e2e47c71b6a0bc014c204e18c6be2736fed338.camel@gmail.com>
	 <CAADnVQJY4TR3hoDUyZwGxm10sBNvpLHTa_yW-T6BvbukvAoypg@mail.gmail.com>
	 <6a52b65c270a702f6cbd6ffcf627213af4715200.camel@gmail.com>
	 <CAEf4BzbM2bWHfdCoVYdfUmuYJRVzADBXHzbDwHkg_EX13pJ7gA@mail.gmail.com>
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

On Fri, 2023-06-02 at 11:50 -0700, Andrii Nakryiko wrote:
[...]
> > > The thread is long. Could you please describe it again in pseudo code=
?
> >=20
> > - Add a function mark_precise_scalar_ids(struct bpf_verifier_env *env,
> >                                         struct bpf_verifier_state *st)
> >   such that it:
> >   - collect PRECISE_IDS: a set of IDs of all registers marked in env->b=
t
> >   - visit all registers with ids from PRECISE_IDS and make sure
> >     that these registers are marked in env->bt
> > - Call mark_precise_scalar_ids() from __mark_chain_precision()
> >   for each state 'st' visited by states chain processing loop,
> >   so that:
> >   - mark_precise_scalar_ids() is called for current state when
> >     __mark_chain_precision() is entered, reusing id assignments in
> >     current state;
> >   - mark_precise_scalar_ids() is called for each parent state, reusing
> >     id assignments valid at 'last_idx' instruction of that state.
> >=20
> > The idea is that in situations like below:
> >=20
> >    4: if (r6 > r7) goto +1
> >    5: r7 =3D r6
> >    --- checkpoint #1 ---
> >    6: <something>
> >    7: if (r7 > X) goto ...
> >    8: r7 =3D 0
> >    9: r9 +=3D r6
> >=20
> > The mark_precise_scalar_ids() would be called at:
> > - (9) and current id assignments would be used.
> > - (6) and id assignments saved in checkpoint #1 would be used.
> >=20
> > If <something> is the code that modifies r6/r7 the link would be
> > broken and we would overestimate the set of precise registers.
> >=20
>=20
> To avoid this we need to recalculate these IDs on each new parent
> state, based on requested precision marks. If we keep a simple and
> small array of IDs and do a quick linear search over them for each
> SCALAR register, I suspect it should be very fast. I don't think in
> practice we'll have more than 1-2 IDs in that array, right?

I'm not sure I understand, could you please describe how it should
work for e.g.?:

    3: r6 &=3D 0xf            // assume safe bound
    4: if (r6 > r7) goto +1
    5: r7 =3D r6
    --- checkpoint #1 ---
    6: r7 =3D 0
    7: if (r7 > 10) goto exit;
    8: r7 =3D 0
    9: r9 +=3D r6

__mark_chain_precision() would get to checkpoint #1 with only r6 as
precise, what should happen next?

As a side note: I added several optimizations:
- avoid allocation of scalar ids for constants;
- remove sole scalar ids from cached states;
- do a check as follows:
  if (rold->precise && rold->id && !check_ids(idmap, rold, rcur))
    return false;

And I'm seeing almost zero performance overhead now.
So, maybe what we figured so far is good enough.
Need to add more tests, though.

