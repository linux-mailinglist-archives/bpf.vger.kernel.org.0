Return-Path: <bpf+bounces-16470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EF5801542
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 22:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A7E1F2101C
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 21:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFD159B4F;
	Fri,  1 Dec 2023 21:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOms6duh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975B510D7;
	Fri,  1 Dec 2023 13:22:56 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50abbb23122so3712760e87.3;
        Fri, 01 Dec 2023 13:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701465775; x=1702070575; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B3kcUYruKC5iUd8aJKRoo9plHi51/X4cugDuquOO8NY=;
        b=MOms6duhY6Kx53wlIP5tO0EI3tRsGFoHi0J/Bg29gxxe06F/tcIfAjX95H/m7yeScT
         E3Gt+H+oxSBz/bLvnAtvNeQ1/2fX7O0fp/YH93qQ8X/5vZg0+kJyUHkCP3qBftyrg5Yv
         BiNplNGy94/Pnzmd+K2aagZ5yvlIgTh9+YQGqOSdZ6Wjpbx+ZwGIwG2EsKPnMG9wpP62
         zLVNFXbRRzuinD47KdmMSkQdGZ56AHbSj+nhfHhD6KXzfDxdxeJn75UvDnZREWpH5T3x
         TapWs5m2y63furSLQw3cmp87E5Y7VT8M29ht23u2AVUrjiD0cstaTyfaNr0lcMNFdHBP
         8liw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701465775; x=1702070575;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B3kcUYruKC5iUd8aJKRoo9plHi51/X4cugDuquOO8NY=;
        b=O0OjCYp8Tpu4KxN+ZFhTNDZNs4wYzFZ6RT+OHFg35Cvj3nhqCqvfcSALJibM2Trgyg
         Q5ZzMZ2ePKiVt2XonQ3ayHqWO3+RCSB0j1oCRcAtZlk9M5Xp/lHu6/76d+RU9JvqnQG4
         bknni/jiOEuv1Kj5mtmlw4F26n/fV2gljHIQSTwD6ZWTedhJTVjCGUWHX1K2T0hswmEs
         RrO234XUvPztQRysTUIogEMxsmeSpRxQg3hE1HVUsGEOALYOx8BHdF1o0enD5sWDTdTm
         yA+qxZjrOq43d86o4pDhamYU6VfGzKck6uEvQOt5rxZsQ0XRgpm7rgpy9SvhvL+706BB
         Dr7w==
X-Gm-Message-State: AOJu0YwFV05jNHTDm6Bwd3n05t19vsALu+Hdu1CnRkM7dRwELex/wAHd
	IHKfpBmHLS9VIWiS82uf+j4=
X-Google-Smtp-Source: AGHT+IH6F806c40B0ns5cCYw37MpVBBr93IvKOgwh/USfc9GdYKyjRv1qKyCoucVjpTTf9WspjWgEg==
X-Received: by 2002:a05:6512:4017:b0:508:11c3:c8ca with SMTP id br23-20020a056512401700b0050811c3c8camr1640816lfb.7.1701465774460;
        Fri, 01 Dec 2023 13:22:54 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id cm26-20020a0564020c9a00b0054c6b50df3asm500640edb.92.2023.12.01.13.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 13:22:54 -0800 (PST)
Message-ID: <c0c9b60a3c14080f93a8b7b38f0277c6dd0bf7fc.camel@gmail.com>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v3 3/9] libbpf: Add
 BPF_CORE_WRITE_BITFIELD() macro
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Xu <dxu@dxuuu.xyz>, ndesaulniers@google.com,
 daniel@iogearbox.net,  nathan@kernel.org, ast@kernel.org,
 andrii@kernel.org, steffen.klassert@secunet.com, 
 antony.antony@secunet.com, alexei.starovoitov@gmail.com,
 yonghong.song@linux.dev,  martin.lau@linux.dev, song@kernel.org,
 john.fastabend@gmail.com,  kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org,  trix@redhat.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org,  llvm@lists.linux.dev, devel@linux-ipsec.org,
 netdev@vger.kernel.org, Jonathan Lemon <jlemon@aviatrix.com>
Date: Fri, 01 Dec 2023 23:22:52 +0200
In-Reply-To: <2schji4oladptrev3tswmwkbhspz6mdy5u2v7tvll4du7iylri@2u2zmfdzn6fm>
References: <cover.1701462010.git.dxu@dxuuu.xyz>
	 <adea997dff6d07332d294ad9cd233f3b71494a81.1701462010.git.dxu@dxuuu.xyz>
	 <2schji4oladptrev3tswmwkbhspz6mdy5u2v7tvll4du7iylri@2u2zmfdzn6fm>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=mQGNBGKNNQEBDACwcUNXZOGTzn4rr7Sd18SA5Wv0Wna/ONE0ZwZEx+sIjyGrPOIhR14/DsOr3ZJer9UJ/WAJwbxOBj6E5Y2iF7grehljNbLr/jMjzPJ+hJpfOEAb5xjCB8xIqDoric1WRcCaRB+tDSk7jcsIIiMish0diTK3qTdu4MB6i/sh4aeFs2nifkNi3LdBuk8Xnk+RJHRoKFJ+C+EoSmQPuDQIRaF9N2m4yO0eG36N8jLwvUXnZzGvHkphoQ9ztbRJp58oh6xT7uH62m98OHbsVgzYKvHyBu/IU2ku5kVG9pLrFp25xfD4YdlMMkJH6l+jk+cpY0cvMTS1b6/g+1fyPM+uzD8Wy+9LtZ4PHwLZX+t4ONb/48i5AKq/jSsb5HWdciLuKEwlMyFAihZamZpEj+9n91NLPX4n7XeThXHaEvaeVVl4hfW/1Qsao7l1YjU/NCHuLaDeH4U1P59bagjwo9d1n5/PESeuD4QJFNqW+zkmE4tmyTZ6bPV6T5xdDRHeiITGc00AEQEAAbQkRWR1YXJkIFppbmdlcm1hbiA8ZWRkeXo4N0BnbWFpbC5jb20+iQHUBBMBCgA+FiEEx+6LrjApQyqnXCYELgxleklgRAkFAmKNNQECGwMFCQPCZwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQLgxleklgRAlWZAv/cJ5v3zlEyP0/jMKQBqbVCCHTirPEw+nqxbkeSO6r2FUds0NnGA9a6NPOpBH+qW7a6+n6q3sIbvH7jlss4pzLI7LYlDC6z+egTv7KR5X1xFrY1uR5UGs1beAjnzYeV2hK4yqRUfygsT0Wk5e4FiNBv4+DUZ8r0cNDkO6swJxU55DO21mcteC147+4aDoHZ40R0tsAu+brDGSSoOPpb0RWVsEf9XOBJqWWA+T7mluw
 nYzhLWGcczc6J71q1Dje0l5vIPaSFOgwmWD4DA+WvuxM/shH4rtWeodbv iCTce6yYIygHgUAtJcHozAlgRrL0jz44cggBTcoeXp/atckXK546OugZPnl00J3qmm5uWAznU6T5YDv2vCvAMEbz69ib+kHtnOSBvR0Jb86UZZqSb4ATfwMOWe9htGTjKMb0QQOLK0mTcrk/TtymaG+T4Fsos0kgrxqjgfrxxEhYcVNW8v8HISmFGFbqsJmFbVtgk68BcU0wgF8oFxo7u+XYQDdKbI1uQGNBGKNNQEBDADbQIdo8L3sdSWGQtu+LnFqCZoAbYurZCmUjLV3df1b+sg+GJZvVTmMZnzDP/ADufcbjopBBjGTRAY4L76T2niu2EpjclMMM3mtrOc738Kr3+RvPjUupdkZ1ZEZaWpf4cZm+4wH5GUfyu5pmD5WXX2i1r9XaUjeVtebvbuXWmWI1ZDTfOkiz/6Z0GDSeQeEqx2PXYBcepU7S9UNWttDtiZ0+IH4DZcvyKPUcK3tOj4u8GvO3RnOrglERzNCM/WhVdG1+vgU9fXO83TB/PcfAsvxYSie7u792s/I+yA4XKKh82PSTvTzg2/4vEDGpI9yubkfXRkQN28w+HKF5qoRB8/L1ZW/brlXkNzA6SveJhCnH7aOF0Yezl6TfX27w1CW5Xmvfi7X33V/SPvo0tY1THrO1c+bOjt5F+2/K3tvejmXMS/I6URwa8n1e767y5ErFKyXAYRweE9zarEgpNZTuSIGNNAqK+SiLLXt51G7P30TVavIeB6s2lCt1QKt62ccLqUAEQEAAYkBvAQYAQoAJhYhBMfui64wKUMqp1wmBC4MZXpJYEQJBQJijTUBAhsMBQkDwmcAAAoJEC4MZXpJYEQJkRAMAKNvWVwtXm/WxWoiLnXyF2WGXKoDe5+itTLvBmKcV/b1OKZF1s90V7WfSBz712eFAynEzyeezPbwU8QBiTpZcHXwQni3IYKvsh7s
 t1iq+gsfnXbPz5AnS598ScZI1oP7OrPSFJkt/z4acEbOQDQs8aUqrd46PV jsdqGvKnXZxzylux29UTNby4jTlz9pNJM+wPrDRmGfchLDUmf6CffaUYCbu4FiId+9+dcTCDvxbABRy1C3OJ8QY7cxfJ+pEZW18fRJ0XCl/fiV/ecAOfB3HsqgTzAn555h0rkFgay0hAvMU/mAW/CFNSIxV397zm749ZNLA0L2dMy1AKuOqH+/B+/ImBfJMDjmdyJQ8WU/OFRuGLdqOd2oZrA1iuPIa+yUYyZkaZfz/emQwpIL1+Q4p1R/OplA4yc301AqruXXUcVDbEB+joHW3hy5FwK5t5OwTKatrSJBkydSF9zdXy98fYzGniRyRA65P0Ix/8J3BYB4edY2/w0Ip/mdYsYQljBY0A==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-01 at 13:51 -0700, Daniel Xu wrote:
> On Fri, Dec 01, 2023 at 01:23:14PM -0700, Daniel Xu via Devel wrote:
> > =3D=3D=3D Motivation =3D=3D=3D
> >=20
> > Similar to reading from CO-RE bitfields, we need a CO-RE aware bitfield
> > writing wrapper to make the verifier happy.
> >=20
> > Two alternatives to this approach are:
> >=20
> > 1. Use the upcoming `preserve_static_offset` [0] attribute to disable
> >    CO-RE on specific structs.
> > 2. Use broader byte-sized writes to write to bitfields.
> >=20
> > (1) is a bit hard to use. It requires specific and not-very-obvious
> > annotations to bpftool generated vmlinux.h. It's also not generally
> > available in released LLVM versions yet.
> >=20
> > (2) makes the code quite hard to read and write. And especially if
> > BPF_CORE_READ_BITFIELD() is already being used, it makes more sense to
> > to have an inverse helper for writing.
> >=20
> > =3D=3D=3D Implementation details =3D=3D=3D
> >=20
> > Since the logic is a bit non-obvious, I thought it would be helpful
> > to explain exactly what's going on.
> >=20
> > To start, it helps by explaining what LSHIFT_U64 (lshift) and RSHIFT_U6=
4
> > (rshift) is designed to mean. Consider the core of the
> > BPF_CORE_READ_BITFIELD() algorithm:
> >=20
> >         val <<=3D __CORE_RELO(s, field, LSHIFT_U64);
> >                 val =3D val >> __CORE_RELO(s, field, RSHIFT_U64);
> >=20
> > Basically what happens is we lshift to clear the non-relevant (blank)
> > higher order bits. Then we rshift to bring the relevant bits (bitfield)
> > down to LSB position (while also clearing blank lower order bits). To
> > illustrate:
> >=20
> >         Start:    ........XXX......
> >         Lshift:   XXX......00000000
> >         Rshift:   00000000000000XXX
> >=20
> > where `.` means blank bit, `0` means 0 bit, and `X` means bitfield bit.
> >=20
> > After the two operations, the bitfield is ready to be interpreted as a
> > regular integer.
> >=20
> > Next, we want to build an alternative (but more helpful) mental model
> > on lshift and rshift. That is, to consider:
> >=20
> > * rshift as the total number of blank bits in the u64
> > * lshift as number of blank bits left of the bitfield in the u64
> >=20
> > Take a moment to consider why that is true by consulting the above
> > diagram.
> >=20
> > With this insight, we can how define the following relationship:
> >=20
> >               bitfield
> >                  _
> >                 | |
> >         0.....00XXX0...00
> >         |      |   |    |
> >         |______|   |    |
> >          lshift    |    |
> >                    |____|
> >               (rshift - lshift)
> >=20
> > That is, we know the number of higher order blank bits is just lshift.
> > And the number of lower order blank bits is (rshift - lshift).
> >=20
> > Finally, we can examine the core of the write side algorithm:
> >=20
> >         mask =3D (~0ULL << rshift) >> lshift;   // 1
> >         nval =3D new_val;                       // 2
> >         nval =3D (nval << rpad) & mask;         // 3
> >         val =3D (val & ~mask) | nval;           // 4
> >=20
> > (1): Compute a mask where the set bits are the bitfield bits. The first
> >      left shift zeros out exactly the number of blank bits, leaving a
> >      bitfield sized set of 1s. The subsequent right shift inserts the
> >      correct amount of higher order blank bits.
> > (2): Place the new value into a word sized container, nval.
> > (3): Place nval at the correct bit position and mask out blank bits.
> > (4): Mix the bitfield in with original surrounding blank bits.
> >=20
> > [0]: https://reviews.llvm.org/D133361
> > Co-authored-by: Eduard Zingerman <eddyz87@gmail.com>
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>=20
> Just pointing out I inserted Eduard's tags here. Eduard - I hope that's
> OK. Not sure what the usual procedure for this is.

Not that I did a big contribution, you and Andrii figured out a much
better (and correct) expression :) I'm fine with and without this tag,
thank you for working on this.

