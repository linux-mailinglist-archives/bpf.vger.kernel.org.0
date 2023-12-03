Return-Path: <bpf+bounces-16539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3081E802431
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 14:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3821F210E1
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 13:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D09F9FC;
	Sun,  3 Dec 2023 13:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XijV2AVo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A5694
	for <bpf@vger.kernel.org>; Sun,  3 Dec 2023 05:22:13 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9e1021dbd28so505079166b.3
        for <bpf@vger.kernel.org>; Sun, 03 Dec 2023 05:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701609732; x=1702214532; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qX+OUgsKWurHPfdcoE44sY7EPHOCEzWlKwGZ5RO8OtA=;
        b=XijV2AVozBM4O0r5HlIHss1PdtJEFeswMowNVQDInzwrU7z2DZFKaKVB0hil2WxOgb
         TxrvFHtY2NpG0KxrUjKCKTNWL12S48fUJC5NCkpAX4o7yyQM/OoqB1VdgpOaQRGoHI4k
         LDVgRRJ0qvldHgSkUJ0DYJ5iuRy582jre09xNaqlT45dYdUnazzcRrNQWIaQYlxqS+GJ
         equT1YvYH/YAQZYJo/ACZOD9rjMIIkqLBxvUUNlcAhgfYvJLYPFBqlKIfpuf+UZCxBaf
         GajouNagendtoJtexYEr4lJJ1Opdbsd/zFUVH2dzkUYzY6Xu/WcZw6IbVRdg5ttC1UJ7
         dxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701609732; x=1702214532;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qX+OUgsKWurHPfdcoE44sY7EPHOCEzWlKwGZ5RO8OtA=;
        b=cVErvdEwPAzHRPBtfJNGmu4UexgmMsMa58qJFFZ6SaEHqML6BDzhA2/yUe2cswzWPc
         vXgEkOiIx8ret0On30B7+oUMGjiUxRsXteBhqklAs7IjH4FpPcsldRBGfNkzK23HWyFM
         w9y137V3laYQEGAti9/fSbj4DKiNlQgCeKMPq8shPo7J96hdTloD89dyG450V6sFVkkl
         TwprWfn75hoNL4h1z5U1WUHYftp1C5D0QMcofzNoSS9jlkyHEPrq86kIWYE7asPaUlx2
         /3YXrbhsxOYLoN431qTQU94/sOuNLzABST0sgRS2ijcLU81NkDJCippy5fWlo6y7WQhX
         81/g==
X-Gm-Message-State: AOJu0Yxkaxe8rsSicTT9B4iBFolvNWcHU2Z2wK/r6xokYhQjXaMjTDlV
	YeJYhfRHW3X6nVshJyOB4/4=
X-Google-Smtp-Source: AGHT+IEVdG5nQzApgsCboucsN6tw9jYbuPYkKaGHkFmROtPyGIJxdXEllYS0Q53yTF74IwgjCw9K8Q==
X-Received: by 2002:a17:906:fc26:b0:a19:a19b:c740 with SMTP id ov38-20020a170906fc2600b00a19a19bc740mr2440728ejb.144.1701609731545;
        Sun, 03 Dec 2023 05:22:11 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id g9-20020a1709063b0900b009ca522853ecsm4131969ejf.58.2023.12.03.05.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 05:22:10 -0800 (PST)
Message-ID: <62f507b80afc6c3526a9c486af7b64c5d048bd79.camel@gmail.com>
Subject: Re: [PATCH bpf v3 2/3] bpf: fix accesses to uninit stack slots
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrei Matei <andreimatei1@gmail.com>, bpf <bpf@vger.kernel.org>, Andrii
	Nakryiko <andrii.nakryiko@gmail.com>
Cc: Hao Sun <sunhao.th@gmail.com>, kernel-team@dataexmachina.dev
Date: Sun, 03 Dec 2023 15:22:11 +0200
In-Reply-To: <CABWLsesV9FvmF+j3n8ZntcNCL1gbhKOg65a5NA8s5-ro=3cYYA@mail.gmail.com>
References: <20231202230558.1648708-1-andreimatei1@gmail.com>
	 <20231202230558.1648708-3-andreimatei1@gmail.com>
	 <CABWLsesV9FvmF+j3n8ZntcNCL1gbhKOg65a5NA8s5-ro=3cYYA@mail.gmail.com>
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

On Sat, 2023-12-02 at 18:09 -0500, Andrei Matei wrote:
> [...]
>=20
> > --- a/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
> > @@ -5,9 +5,10 @@
> >  #include <bpf/bpf_helpers.h>
> >  #include "bpf_misc.h"
> >=20
> > -SEC("tc")
> > +SEC("socket")
> >  __description("raw_stack: no skb_load_bytes")
> > -__failure __msg("invalid read from stack R6 off=3D-8 size=3D8")
> > +__success
> > +__failure_unpriv __msg_unpriv("invalid read from stack R6 off=3D-8 siz=
e=3D8")
> >  __naked void stack_no_skb_load_bytes(void)
> >  {
>=20
> Please confirm that changing this program type is OK. I wasn't sure here.
>=20
> [...]

lgtm, does not seem matter in this case.

