Return-Path: <bpf+bounces-13855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2FB7DE834
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 23:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195FF1C20E47
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 22:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723D914291;
	Wed,  1 Nov 2023 22:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcaJ1p06"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E83125D3
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 22:41:22 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9981B12E
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 15:41:17 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-5090cc340a3so316355e87.2
        for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 15:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698878476; x=1699483276; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MWY+gLil3DkAQXFaO9pDteYC4cNd6zgjG3MDhvIoWGI=;
        b=XcaJ1p06umdgCtYWEgC6Pxh9XXsyFazRJdCMU4NyzSwlSkaXNxOsx5XI05fwZQ06xZ
         v3WhzgnTFloHQSzLs6KZw0mK6qNGkIumg5ux/XB1W9feUCWh5FYaBgoNBlfT+AReOIk6
         AFf9iWQic9FwD7kgB2srdU6fLQ9ndUS0TNmWsGbYDRrbD1IY+KBb5V6t/yFCtE5BWL7l
         ON/Z4KpiPP2qYuLDAi9vnl1zvJtIiMXA3TUkiG12Mp7D1OVqhOOWRBAMJdcaGWepjHO+
         9d0slgwZYOGOWMMGlZV7fFszh8wGxRziRuv4/Nkb7uZYPDa1EVTe1vvHXAUGp6m6JuP4
         7g0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698878476; x=1699483276;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MWY+gLil3DkAQXFaO9pDteYC4cNd6zgjG3MDhvIoWGI=;
        b=RevNs88zwzox6tb1RXLxuvUPgtIWgSsqw++QOlYuvW3RN2DYaGf0GonQuPHDjhVSC0
         fEGS+WwXu7s7InEDPiPEy/xc+XjYKbxzUmJrY9Vtwb/gjGWzItY5UuyqkM2WKywbZWv3
         /geZEzxk4zDabknouLmji9NvufXajse10Nf7ND8yt+ksWP2uSyZA0jYrf0rV+tH6G3vC
         1CtzskyZyI4HjTCfly5frT+TOeueiFF0mW+8xzUppVLAhvLNwAIvO669iTGXm1OOrw/q
         chKnREUCcdzFqOvsXKfgBzN1AOlsX7GDRVjM6ACsX9AFs5QBWDEzObPq3d0jM6varYsr
         aOeQ==
X-Gm-Message-State: AOJu0YzNa8nX2xkjtHPCuH+z4s9SIgWb2JLU9ZhL+RRdUfg4NIq9wEM7
	Bnkm3JhPsugpT4vjEoiSipo=
X-Google-Smtp-Source: AGHT+IEe0GuClGke4eHKtkCX/PuN3J0a40raZZKOHSsEUUILcz1Ln4m29jZzToJZ+D28z1OfItKo1w==
X-Received: by 2002:a05:6512:2349:b0:507:bc6b:38a6 with SMTP id p9-20020a056512234900b00507bc6b38a6mr17603453lfu.33.1698878475539;
        Wed, 01 Nov 2023 15:41:15 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id o6-20020ac25e26000000b00507a622185csm314235lfg.235.2023.11.01.15.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 15:41:15 -0700 (PDT)
Message-ID: <cc5d12af859d5cbce64aec2fc89179d25a3b082b.camel@gmail.com>
Subject: Re: BTF_TYPE_ID_LOCAL off by one?
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Lorenz Bauer
	 <lorenz.bauer@isovalent.com>
Cc: Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andrii@kernel.org>, bpf
	 <bpf@vger.kernel.org>
Date: Thu, 02 Nov 2023 00:41:14 +0200
In-Reply-To: <CAEf4BzY1QZEKSthdG8N_Cs7jdxM-S9gnLZfOfp+s636ORyoUcQ@mail.gmail.com>
References: 
	<CAN+4W8i=7Wv2VwvWZGhX_mc8E7EST10X_Z5XGBmq=WckusG_fw@mail.gmail.com>
	 <CAEf4BzZCjTsWhcmQz08QB4mirfgG0ea6bYJX2RgKirwFxAO+3g@mail.gmail.com>
	 <CAN+4W8gKa=wRegmvnr_DTCJjrr5EM6nVws0Mf7Ksto3ZzZroQA@mail.gmail.com>
	 <CAEf4BzY1QZEKSthdG8N_Cs7jdxM-S9gnLZfOfp+s636ORyoUcQ@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=mQGNBGKNNQEBDACwcUNXZOGTzn4rr7Sd18SA5Wv0Wna/ONE0ZwZEx+sIjyGrPOIhR14/DsOr3ZJer9UJ/WAJwbxOBj6E5Y2iF7grehljNbLr/jMjzPJ+hJpfOEAb5xjCB8xIqDoric1WRcCaRB+tDSk7jcsIIiMish0diTK3qTdu4MB6i/sh4aeFs2nifkNi3LdBuk8Xnk+RJHRoKFJ+C+EoSmQPuDQIRaF9N2m4yO0eG36N8jLwvUXnZzGvHkphoQ9ztbRJp58oh6xT7uH62m98OHbsVgzYKvHyBu/IU2ku5kVG9pLrFp25xfD4YdlMMkJH6l+jk+cpY0cvMTS1b6/g+1fyPM+uzD8Wy+9LtZ4PHwLZX+t4ONb/48i5AKq/jSsb5HWdciLuKEwlMyFAihZamZpEj+9n91NLPX4n7XeThXHaEvaeVVl4hfW/1Qsao7l1YjU/NCHuLaDeH4U1P59bagjwo9d1n5/PESeuD4QJFNqW+zkmE4tmyTZ6bPV6T5xdDRHeiITGc00AEQEAAbQkRWR1YXJkIFppbmdlcm1hbiA8ZWRkeXo4N0BnbWFpbC5jb20+iQHUBBMBCgA+FiEEx+6LrjApQyqnXCYELgxleklgRAkFAmKNNQECGwMFCQPCZwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQLgxleklgRAlWZAv/cJ5v3zlEyP0/jMKQBqbVCCHTirPEw+nqxbkeSO6r2FUds0NnGA9a6NPOpBH+qW7a6+n6q3sIbvH7jlss4pzLI7LYlDC6z+egTv7KR5X1xFrY1uR5UGs1beAjnzYeV2hK4yqRUfygsT0Wk5e4FiNBv4+DUZ8r0cNDkO6swJxU55DO21mcteC147+4aDoHZ40R0tsAu+brDGSSoOPpb0RWVsEf9XOBJqWWA+T7mluw
 nYzhLWGcczc6J71q1Dje0l5vIPaSFOgwmWD4DA+WvuxM/shH4rtWeodbv iCTce6yYIygHgUAtJcHozAlgRrL0jz44cggBTcoeXp/atckXK546OugZPnl00J3qmm5uWAznU6T5YDv2vCvAMEbz69ib+kHtnOSBvR0Jb86UZZqSb4ATfwMOWe9htGTjKMb0QQOLK0mTcrk/TtymaG+T4Fsos0kgrxqjgfrxxEhYcVNW8v8HISmFGFbqsJmFbVtgk68BcU0wgF8oFxo7u+XYQDdKbI1uQGNBGKNNQEBDADbQIdo8L3sdSWGQtu+LnFqCZoAbYurZCmUjLV3df1b+sg+GJZvVTmMZnzDP/ADufcbjopBBjGTRAY4L76T2niu2EpjclMMM3mtrOc738Kr3+RvPjUupdkZ1ZEZaWpf4cZm+4wH5GUfyu5pmD5WXX2i1r9XaUjeVtebvbuXWmWI1ZDTfOkiz/6Z0GDSeQeEqx2PXYBcepU7S9UNWttDtiZ0+IH4DZcvyKPUcK3tOj4u8GvO3RnOrglERzNCM/WhVdG1+vgU9fXO83TB/PcfAsvxYSie7u792s/I+yA4XKKh82PSTvTzg2/4vEDGpI9yubkfXRkQN28w+HKF5qoRB8/L1ZW/brlXkNzA6SveJhCnH7aOF0Yezl6TfX27w1CW5Xmvfi7X33V/SPvo0tY1THrO1c+bOjt5F+2/K3tvejmXMS/I6URwa8n1e767y5ErFKyXAYRweE9zarEgpNZTuSIGNNAqK+SiLLXt51G7P30TVavIeB6s2lCt1QKt62ccLqUAEQEAAYkBvAQYAQoAJhYhBMfui64wKUMqp1wmBC4MZXpJYEQJBQJijTUBAhsMBQkDwmcAAAoJEC4MZXpJYEQJkRAMAKNvWVwtXm/WxWoiLnXyF2WGXKoDe5+itTLvBmKcV/b1OKZF1s90V7WfSBz712eFAynEzyeezPbwU8QBiTpZcHXwQni3IYKvsh7s
 t1iq+gsfnXbPz5AnS598ScZI1oP7OrPSFJkt/z4acEbOQDQs8aUqrd46PV jsdqGvKnXZxzylux29UTNby4jTlz9pNJM+wPrDRmGfchLDUmf6CffaUYCbu4FiId+9+dcTCDvxbABRy1C3OJ8QY7cxfJ+pEZW18fRJ0XCl/fiV/ecAOfB3HsqgTzAn555h0rkFgay0hAvMU/mAW/CFNSIxV397zm749ZNLA0L2dMy1AKuOqH+/B+/ImBfJMDjmdyJQ8WU/OFRuGLdqOd2oZrA1iuPIa+yUYyZkaZfz/emQwpIL1+Q4p1R/OplA4yc301AqruXXUcVDbEB+joHW3hy5FwK5t5OwTKatrSJBkydSF9zdXy98fYzGniRyRA65P0Ix/8J3BYB4edY2/w0Ip/mdYsYQljBY0A==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-11-01 at 15:40 -0700, Andrii Nakryiko wrote:
> On Wed, Nov 1, 2023 at 2:27=E2=80=AFAM Lorenz Bauer <lorenz.bauer@isovale=
nt.com> wrote:
> >=20
> > On Tue, Oct 31, 2023 at 6:38=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >=20
> > > I don't remember if this is intention or not, but the main part is
> > > adjusting CO-RE relocation, the actual instruction value is less
> > > important. But this is happening after static linking, because BTF is
> > > deduplicated (there is a duplication in BTF generated by Clang).
> >=20
> > Ah I see! And the deduplication is done by libbpf during linking? So
>=20
> yes
>=20
> > far, we've been validating that the instruction immediate matches what
> > is in ext_infos. Should I just stop doing that?
>=20
> probably, because I just checked libbpf's linker code, I don't think
> we adjust instructions that have CO-RE relocations. We might probably
> add that, but it's basically just BTF_TYPE_ID_LOCAL that would need
> this special handling. If someone sends the patch I'll accept it :)
>=20
> >=20
> > > There are at least two identical prototypes (which is strange and
> > > might be worth looking into from Clang side).
> >=20
> > That would be good!
>=20
> Agreed, maybe Yonghong or Eduard can take a look when they get time?

I'll take a look, probably on Sat/Sun.

