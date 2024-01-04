Return-Path: <bpf+bounces-18972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DB4823972
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 01:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464C11F2609B
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 00:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5A037C;
	Thu,  4 Jan 2024 00:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMpI/Hoi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ACB366
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 00:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-556c60c3f9aso6558a12.3
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 16:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704326943; x=1704931743; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XXFbbSq9dfv7QPqQP+wMcfAdYFolTObL0S2llhtFicc=;
        b=KMpI/Hoi0V0RtFTY4WKNL2tXgbDEBuXZJWwKz90H4qSRRvtDLpwXoSj8226PGocX4b
         rgGhCagcoQBjDJlUXePX3Vxyji3ZFEwPDIXfjPsprhxPnNPr5PF3bQ8vuVqs0vDN7Yhk
         dWcqlhma/vxbLVM4zdjhdJ2VIJWMXkflRYzqFPPNCy0zCPU2FmRHzn5wAe6pg3NuylZa
         7ckxbq2khsqYEKNOyEpIlHfO2fSIslvtqTVzZumaNML5WCGscGUcm+VHEq36dKxvBPyn
         pfY5iZ6oqYg7WPRhUWbq3GDvuTVel8Y13dPmf4r75jr4n9s2h6rsm8kdwSvpYcFa+mVD
         PXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704326943; x=1704931743;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XXFbbSq9dfv7QPqQP+wMcfAdYFolTObL0S2llhtFicc=;
        b=ukLeqsbzad548LTlWWYrxjPr5Hdy0+D8zRRCK5zV7tPHcLOjC/4F1R5sou63qU6D4r
         XZNuo/7hSr/CoRQHKkwGdxXNKtduPKELHOtA7QM6MCbc3L2VP/bEYKd/oDGotDdPS0IZ
         p9F5cWv3GLdNcRCOTtVcX5voieIELFaQBMvcfcNaGmlUrcHhcxnTPEktbAo1/usHel9O
         EbNZQapwYjpvNBPLz6mYSfUhV6o8ShoNWCGG+UuXfCbmW9pvnUHIi+CyB1uzrC9X6Ele
         mC/X6GclJllsMvkS47LKimwP6TYFo74AxjCcflYb2DX8EvNZ7WS+N0KBLOnzZpbstQDu
         w4IA==
X-Gm-Message-State: AOJu0Yzp+9v6s50BpJYW1H2Or8wDoP7ex5S0ffoArSAE6f5oM+NhhaNT
	P/06EAq2oVdT94V7dXrSucI=
X-Google-Smtp-Source: AGHT+IH22/UjAtfMWKyu9w1spgQKnrV0dcoFk3E8jssPI2Zi5ZIX2sn9Cgb9uFIDTREGp89ux6XpsQ==
X-Received: by 2002:a50:8755:0:b0:554:4e4b:7b68 with SMTP id 21-20020a508755000000b005544e4b7b68mr13399419edv.2.1704326942853;
        Wed, 03 Jan 2024 16:09:02 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id k24-20020a056402049800b00555e52fed52sm7024869edv.91.2024.01.03.16.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 16:09:02 -0800 (PST)
Message-ID: <5e3dd1c0953d2311da52b3dda378362a4f118a4f.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 8/9] libbpf: implement __arg_ctx fallback
 logic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com, Jiri Olsa <jolsa@kernel.org>
Date: Thu, 04 Jan 2024 02:09:01 +0200
In-Reply-To: <CAEf4BzaPhbRVEJ9o3UqP0q6Ot63BYdxw4UO8J94bQk2Waij+Zw@mail.gmail.com>
References: <20240102190055.1602698-1-andrii@kernel.org>
	 <20240102190055.1602698-9-andrii@kernel.org>
	 <75cad82e8e11b6049c99dcd2170fb445e2d3d2ee.camel@gmail.com>
	 <CAEf4BzaB_dOz8QmG9kGM7ViD=iM7P-a1GsMAMyyJhdf1W2Kwng@mail.gmail.com>
	 <7746c6fa67e655b288e069b0c1d6393dc8c46502.camel@gmail.com>
	 <CAEf4BzaPhbRVEJ9o3UqP0q6Ot63BYdxw4UO8J94bQk2Waij+Zw@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=mQGNBGKNNQEBDACwcUNXZOGTzn4rr7Sd18SA5Wv0Wna/ONE0ZwZEx+sIjyGrPOIhR14/DsOr3ZJer9UJ/WAJwbxOBj6E5Y2iF7grehljNbLr/jMjzPJ+hJpfOEAb5xjCB8xIqDoric1WRcCaRB+tDSk7jcsIIiMish0diTK3qTdu4MB6i/sh4aeFs2nifkNi3LdBuk8Xnk+RJHRoKFJ+C+EoSmQPuDQIRaF9N2m4yO0eG36N8jLwvUXnZzGvHkphoQ9ztbRJp58oh6xT7uH62m98OHbsVgzYKvHyBu/IU2ku5kVG9pLrFp25xfD4YdlMMkJH6l+jk+cpY0cvMTS1b6/g+1fyPM+uzD8Wy+9LtZ4PHwLZX+t4ONb/48i5AKq/jSsb5HWdciLuKEwlMyFAihZamZpEj+9n91NLPX4n7XeThXHaEvaeVVl4hfW/1Qsao7l1YjU/NCHuLaDeH4U1P59bagjwo9d1n5/PESeuD4QJFNqW+zkmE4tmyTZ6bPV6T5xdDRHeiITGc00AEQEAAbQkRWR1YXJkIFppbmdlcm1hbiA8ZWRkeXo4N0BnbWFpbC5jb20+iQHUBBMBCgA+FiEEx+6LrjApQyqnXCYELgxleklgRAkFAmKNNQECGwMFCQPCZwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQLgxleklgRAlWZAv/cJ5v3zlEyP0/jMKQBqbVCCHTirPEw+nqxbkeSO6r2FUds0NnGA9a6NPOpBH+qW7a6+n6q3sIbvH7jlss4pzLI7LYlDC6z+egTv7KR5X1xFrY1uR5UGs1beAjnzYeV2hK4yqRUfygsT0Wk5e4FiNBv4+DUZ8r0cNDkO6swJxU55DO21mcteC147+4aDoHZ40R0tsAu+brDGSSoOPpb0RWVsEf9XOBJqWWA+T7mluw
 nYzhLWGcczc6J71q1Dje0l5vIPaSFOgwmWD4DA+WvuxM/shH4rtWeodbv iCTce6yYIygHgUAtJcHozAlgRrL0jz44cggBTcoeXp/atckXK546OugZPnl00J3qmm5uWAznU6T5YDv2vCvAMEbz69ib+kHtnOSBvR0Jb86UZZqSb4ATfwMOWe9htGTjKMb0QQOLK0mTcrk/TtymaG+T4Fsos0kgrxqjgfrxxEhYcVNW8v8HISmFGFbqsJmFbVtgk68BcU0wgF8oFxo7u+XYQDdKbI1uQGNBGKNNQEBDADbQIdo8L3sdSWGQtu+LnFqCZoAbYurZCmUjLV3df1b+sg+GJZvVTmMZnzDP/ADufcbjopBBjGTRAY4L76T2niu2EpjclMMM3mtrOc738Kr3+RvPjUupdkZ1ZEZaWpf4cZm+4wH5GUfyu5pmD5WXX2i1r9XaUjeVtebvbuXWmWI1ZDTfOkiz/6Z0GDSeQeEqx2PXYBcepU7S9UNWttDtiZ0+IH4DZcvyKPUcK3tOj4u8GvO3RnOrglERzNCM/WhVdG1+vgU9fXO83TB/PcfAsvxYSie7u792s/I+yA4XKKh82PSTvTzg2/4vEDGpI9yubkfXRkQN28w+HKF5qoRB8/L1ZW/brlXkNzA6SveJhCnH7aOF0Yezl6TfX27w1CW5Xmvfi7X33V/SPvo0tY1THrO1c+bOjt5F+2/K3tvejmXMS/I6URwa8n1e767y5ErFKyXAYRweE9zarEgpNZTuSIGNNAqK+SiLLXt51G7P30TVavIeB6s2lCt1QKt62ccLqUAEQEAAYkBvAQYAQoAJhYhBMfui64wKUMqp1wmBC4MZXpJYEQJBQJijTUBAhsMBQkDwmcAAAoJEC4MZXpJYEQJkRAMAKNvWVwtXm/WxWoiLnXyF2WGXKoDe5+itTLvBmKcV/b1OKZF1s90V7WfSBz712eFAynEzyeezPbwU8QBiTpZcHXwQni3IYKvsh7s
 t1iq+gsfnXbPz5AnS598ScZI1oP7OrPSFJkt/z4acEbOQDQs8aUqrd46PV jsdqGvKnXZxzylux29UTNby4jTlz9pNJM+wPrDRmGfchLDUmf6CffaUYCbu4FiId+9+dcTCDvxbABRy1C3OJ8QY7cxfJ+pEZW18fRJ0XCl/fiV/ecAOfB3HsqgTzAn555h0rkFgay0hAvMU/mAW/CFNSIxV397zm749ZNLA0L2dMy1AKuOqH+/B+/ImBfJMDjmdyJQ8WU/OFRuGLdqOd2oZrA1iuPIa+yUYyZkaZfz/emQwpIL1+Q4p1R/OplA4yc301AqruXXUcVDbEB+joHW3hy5FwK5t5OwTKatrSJBkydSF9zdXy98fYzGniRyRA65P0Ix/8J3BYB4edY2/w0Ip/mdYsYQljBY0A==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-03 at 15:59 -0800, Andrii Nakryiko wrote:
[...]
> > > > > +     fn_id =3D btf__add_func(btf, prog->name, btf_func_linkage(f=
n_t), fn_t->type);
> > > >=20
> > > > Nit: Why not call this function near the end, when fn_proto_id is a=
vailable?
> > > >      Thus avoiding need to "guess" fn_t->type.
> > > >=20
> > >=20
> > > I think I did it to not have to remember btf_func_linkage(fn_t)
> > > (because fn_t will be invalidated) and because name_off will be reuse=
d
> > > for parameters. Neither is a big deal, I'll adjust to your suggestion=
.
> > >=20
> > > But note, we are not guessing ID, it's guaranteed to be +1, it's an
> > > API contract of btf__add_xxx() APIs.
> >=20
> > Noted, well, maybe just skip this nit in such a case.
> >=20
>=20
> I already did the change locally, as I said it's a small change, so no pr=
oblem.

Oh, ok, thanks.

[...]

> > > > > +             /* clone fn/fn_proto, unless we already did it for =
another arg */
> > > > > +             if (func_rec->type_id =3D=3D orig_fn_id) {
> > > > > +                     int fn_id;
> > > > > +
> > > > > +                     fn_id =3D clone_func_btf_info(btf, orig_fn_=
id, prog);
> > > > > +                     if (fn_id < 0) {
> > > > > +                             err =3D fn_id;
> > > > > +                             goto err_out;
> > > > > +                     }
> > > > > +
> > > > > +                     /* point func_info record to a cloned FUNC =
type */
> > > > > +                     func_rec->type_id =3D fn_id;
> > > >=20
> > > > Would it be helpful to add a log here, saying that BTF for function
> > > > so and so is changed before load?
> > >=20
> > > Would it? We don't have global subprog's name readily available, it
> > > seems. So I'd need to refetch it by fn_id, then btf__str_by_offset()
> > > just to emit cryptic (for most users) notifications that something
> > > about some func info was adjusted. And then the user would get this
> > > same message for the same subprog but in the context of a different
> > > entry program. Just confusing, tbh.
> > >=20
> > > Unless you insist, I'd leave it as is. This logic is supposed to be
> > > bullet-proof, so I'm not worried about debugging regressions with it
> > > (but maybe I'm delusional).
> >=20
> > I was thinking about someone finding out that actual in-kernel BTF
> > is different from that in the program object file, while debugging
> > something. Might be a bit surprising. I'm not insisting on this, though=
.
>=20
> Note the "/* check if existing parameter already matches verifier
> expectations */", if program is using correct types, we don't touch
> BTF for that subprog. If there was `void *ctx`, we don't really lose
> any information.

But `void *ctx` would be changed to `struct bpf_user_pt_regs_t *ctx`, right=
?
And that might be a bit surprising. But whatever, if you think that adding
log entry here is too much of hassle -- let's leave it as is.

> If they use `struct pt_regs *ctx __arg_ctx`, then yeah, it will be
> updated to `struct bpf_user_pt_regs_t *ctx __arg_ctx`, but even then,
> original BTF has original FUNC -> FUNC_PROTO definition. You'd need to
> fetch func_info and follow BTF IDs (I'm not sure if bpftool even shows
> this today).
>=20
> In short, I don't see why this would be a problem, but perhaps I
> should just bite a bullet and do feature detector for this support.

I like that current implementation does the transformation unconditionally,
it does no harm and avoids unnecessary branching.

[...]

