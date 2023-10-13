Return-Path: <bpf+bounces-12140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7840F7C86C1
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 15:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E8C3282DBA
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 13:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CED515E95;
	Fri, 13 Oct 2023 13:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1Rwow9C"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D2415E85
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 13:25:21 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47796BE
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 06:25:19 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c50cf61f6dso3241911fa.2
        for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 06:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697203517; x=1697808317; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gu+QKnH5kll1YmZHf4AuWCG6rgcBmoIoMYxBJzXsxgs=;
        b=j1Rwow9C1wrFGE6pQVYvLvE5TDXPe/Duo+/eWgQWbePxbtPb59vj6Em2DXEzMrlgn4
         tKUAI4k9nL5Ir988pgrnWhOyXTRPwK8e3BT5qNDhyfnXM+hdZB8EbW97HTCHPyp41Vof
         aBQcV53vzKamLSg7pWFgLLBGL1TJL2p2bCiVYWiAQwvaqC4XpqvNDUYdMbXpASOrEFSr
         JSugclCzjRqwUBrETZsQJNVoHMavgVF6CQzhmMJ/+IfAcKc4As5Ta77OMhPeAMVNpvwr
         avfkVzRmhj69opQOduPVQX2m5CxVyjqeMsLtT5Qdnxwr8G6xPUC+i9ZzLb7AOsgSS4al
         5UmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697203517; x=1697808317;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gu+QKnH5kll1YmZHf4AuWCG6rgcBmoIoMYxBJzXsxgs=;
        b=daXIt2HvGAREW6gSpRcAoIZKAoJpzVXp218fkSTfREsEh1zEZA4W78U22D2kc9Mv/s
         aSyQw4XgfRaTSdklD6iUFxfWCh9uyAQ6C6QBpR2/nKUooh/FTRcAoFfeoBouhPrY/9qg
         9brwPMJdiidoC+4x/XEXMU0cgB90KGsPZxd+soWUCuvWDXU7dfffyMvh0H1392GSYLwQ
         tFcQEQBhKcpAMbYksHKwAnDK8eT+OpH5d/23vV3XoGeGF2PmYeaZaJMkDgk8qx/ftPoG
         CV47skA5nwG+ZWlYGZ/cXKtwA/icVN9zDtAQZE6vM20qwUHYVtL1z+xTZkKEUz+nhVs1
         f1Mg==
X-Gm-Message-State: AOJu0YyBENJaoLwL1qYGTmy1moGjPSmFX6IAyUukrtg3JgTixHEy4mdD
	QVZeOJcWx+QRWLI2cwOCdTirDxeTICBeYQ==
X-Google-Smtp-Source: AGHT+IGKP7udRZM6Kq0BGCcap0eA//vAsqD3Jg+KOY4daielsxvcGH4c1Klsltxm+fqSkIwU4lsInw==
X-Received: by 2002:a2e:3304:0:b0:2c0:20e3:9905 with SMTP id d4-20020a2e3304000000b002c020e39905mr24480744ljc.21.1697203517131;
        Fri, 13 Oct 2023 06:25:17 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id f13-20020a2e6a0d000000b002b6d68b520esm4031105ljc.65.2023.10.13.06.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 06:25:16 -0700 (PDT)
Message-ID: <5695d6b472d932e7aba4d1f6cbd1a8002642a33f.camel@gmail.com>
Subject: Re: Is tools/testing/selftests/bpf/ maintained?
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: bpf <bpf@vger.kernel.org>, KP Singh <kpsingh@kernel.org>
Date: Fri, 13 Oct 2023 16:25:14 +0300
In-Reply-To: <261bfeec-8230-490a-b583-d52223e2d707@I-love.SAKURA.ne.jp>
References: <adfab6e8-b1de-4efc-a9ef-84e219c91833@I-love.SAKURA.ne.jp>
	 <26b213505abeefba2728d238927ddd1907967786.camel@gmail.com>
	 <261bfeec-8230-490a-b583-d52223e2d707@I-love.SAKURA.ne.jp>
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-10-13 at 22:15 +0900, Tetsuo Handa wrote:
> Thank you for showing complete command line.
>=20
> On 2023/10/13 1:34, Eduard Zingerman wrote:
> > # Note: kernel build is mandatory, as vmlinux.h is constructed from DWA=
RF in ./vmlinux
>=20
> is what I was missing. Makefile rules should explicitly describe dependen=
cy on vmlinux ,
> or at least emit message to teach users about the need to build vmlinux ?

Yes, that would be nice.

> But I still get error. I'm using Ubuntu 22.04.3 LTS.

I think you are using clang-14, which does not like u32 instructions.
At least I get the same error message as you with clang-14.
If so, please try using clang-16 instead.

>=20
> ----------------------------------------
> root@ubuntu:/usr/src/linux# make -C tools/testing/selftests/bpf/
> make: Entering directory '/usr/src/linux/tools/testing/selftests/bpf'
>   CLNG-BPF [test_maps] verifier_and.bpf.o
> progs/verifier_and.c:58:16: error: invalid operand for instruction
>         asm volatile ("                                 \
>                       ^
> <inline asm>:1:184: note: instantiated into assembly here
>                                                         r1 =3D 0;        =
                                         *(u64*)(r10 - 8) =3D r1;          =
                        r2 =3D r10;                                        =
       r2 +=3D -8;                                               r1 =3D map=
_hash_48b ll;                           call 1;                         if =
r0 =3D=3D 0 goto l0_1;                                   r1 =3D *(u32*)(r0 =
+ 0);                                   r9 =3D 1;                          =
                       w1 %=3D 2;                                          =
      w1 +=3D 1;                                                w9 &=3D w1;=
                                               w9 +=3D 1;                  =
                              w9 >>=3D 1;                                  =
             w3 =3D 1;                                                 w3 -=
=3D w9;                                               w3 *=3D 0x10000000;  =
                                     r0 +=3D r3;                           =
                    *(u32*)(r0 + 0) =3D r3;                           l0_1:=
   r0 =3D r0;                                                exit;         =
                               =20
>                                                                          =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
        ^
> 1 error generated.
> make: *** [Makefile:598: /usr/src/linux/tools/testing/selftests/bpf/verif=
ier_and.bpf.o] Error 1
> make: Leaving directory '/usr/src/linux/tools/testing/selftests/bpf'
> ----------------------------------------
>=20


