Return-Path: <bpf+bounces-18317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C485818D61
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 18:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC16284189
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 17:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6730D38DFC;
	Tue, 19 Dec 2023 17:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGC/tXAD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84DF37894
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 17:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e297d0692so3564439e87.1
        for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 09:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703005276; x=1703610076; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8GH5ZY6l7oMij7j9T1sAYksfWJGG03XnGRyM0Q3zUEw=;
        b=cGC/tXADPtTaIbVsT1FdCFC++iVq8cuOQLITwIo6c50vz5N95XlJ4GsTf1PgCgAiNZ
         VycK+HAx5nI+pGx6tcqM+1PBd2RCXmGENHX3QVLdYYPn6HLXSBDliyuknm71msqSUNbq
         hqvuMz0uNexHA4Rcf8LTYAmMrCQWfd4hjLqSOOvlz8VAbXzz2DhcAUBCGCMo7lk8Fa51
         6Cbifj3dm0QG3Cgbxhp/ubS1e/ime7oLCxBps/Rkxws/JHSfbIcq5B4VRc1R6a+MUt+U
         YLXi4EuMTVG4VcV+jETX0nqEWT18gcviv66yBMofgeurIsQEyZFqzckzFWMjjcrxk2Er
         bHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703005276; x=1703610076;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8GH5ZY6l7oMij7j9T1sAYksfWJGG03XnGRyM0Q3zUEw=;
        b=oz+4aSa854OKdhULM7JcOG2HOkt0aeCKsTvumwH2I93Pnbbb6cwfDIyu62cxykLP0K
         hduviIJeKYqog8Ulp3GJXSlqYex7NHN53vrtUVz/x9HTv3Q584BEdXuafe0I6K6KvzDp
         Qob1iRwK65WUuWykxbo2m0FBxO+a/My6dtTCGjkMnWPDi7Ks1DgdqufasNCl6Z/0+HKo
         Ay8lOTWv2FyEISF4pKzNa4QmzywrMYNAZ2Xa7tY0E0r5y3mio38WfeOMkR0WxYd0QC4+
         ijKRsGvCKObHCYlMTHG1Bilne85+XXb8N8vzPsrV1ggNkcv3robKapVSE1UlsIDtmuNT
         nu8g==
X-Gm-Message-State: AOJu0YwSrYH8gwUg1in4+IMeQp6A8dma/Akt1pbX9C97X3jeFe11Mnfs
	vSJuo8yWv/Tg04HGrvmRk/M=
X-Google-Smtp-Source: AGHT+IEHqysf6jRwFpRzFLEXDoCn3Cwrn0YzqlA2E+nOS4IhnvgVPEHc3fiY1ytRWuaXj8IOAXyyMg==
X-Received: by 2002:ac2:4311:0:b0:50e:4b1f:5ddb with SMTP id l17-20020ac24311000000b0050e4b1f5ddbmr574711lfh.16.1703005275459;
        Tue, 19 Dec 2023 09:01:15 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id i42-20020a0565123e2a00b0050e372f2320sm696250lfv.132.2023.12.19.09.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:01:14 -0800 (PST)
Message-ID: <0994aae8e3086cb93f25a47ee9e81a6894dbff26.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/1] bpf: Simplify checking size of helper
 accesses
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrei Matei <andreimatei1@gmail.com>
Cc: bpf@vger.kernel.org, andrii.nakryiko@gmail.com
Date: Tue, 19 Dec 2023 19:01:12 +0200
In-Reply-To: <CABWLseu+uALXXwaSGJ=zJhoZuWH3Lajby-ip8oKAmTOLxci7Vw@mail.gmail.com>
References: <20231217010649.577814-1-andreimatei1@gmail.com>
	 <20231217010649.577814-2-andreimatei1@gmail.com>
	 <658b22003f90e066ba7d6585aa444c3e401ff0ac.camel@gmail.com>
	 <CABWLseu+uALXXwaSGJ=zJhoZuWH3Lajby-ip8oKAmTOLxci7Vw@mail.gmail.com>
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

On Mon, 2023-12-18 at 21:54 -0500, Andrei Matei wrote:
> On Mon, Dec 18, 2023 at 7:04=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Sat, 2023-12-16 at 20:06 -0500, Andrei Matei wrote:
> > [...]
> >=20
> > > (*) Besides standing to reason that the checks for a bigger size acce=
ss
> > > are a super-set of the checks for a smaller size access, I have also
> > > mechanically verified this by reading the code for all types of
> > > pointers. I could convince myself that it's true for all but
> > > PTR_TO_BTF_ID (check_ptr_to_btf_access). There, simply looking
> > > line-by-line does not immediately prove what we want. If anyone has a=
ny
> > > qualms, let me know.
> >=20
> > check_help_mem_access() is a bit obfuscated :)
> > After staring at it for a bit I have a question regarding
> > check_ptr_to_btf_access():
> > - it can call btf_struct_access(),
> >   which in can call btf_struct_walk(),
> >   which has the following check:
> >=20
> >                 if (btf_type_is_ptr(mtype)) {
> >                         const struct btf_type *stype, *t;
> >                         enum bpf_type_flag tmp_flag =3D 0;
> >                         u32 id;
> >=20
> >                         if (msize !=3D size || off !=3D moff) {
> >                                 bpf_log(log,
> >                                         "cannot access ptr member %s wi=
th moff %u in struct %s with off %u size %u\n",
> >                                         mname, moff, tname, off, size);
> >                                 return -EACCES;
> >                         }
> >=20
> > - previously this code was executed twice, for size 0 and for size
> >   umax_value of the size register;
> > - now this code is executed only for umax_value of the size register;
> > - is it possible that with size 0 this code could have reported error
> >   -EACCESS error, which would be missed now?
>=20
> I don't have a good answer. I too have looked at check_ptr_to_btf_access(=
) and
> ended up confused -- but then again, I don't know what's supposed to be a=
llowed
> and what's supposed to not be allowed. I will say, though, that I don't t=
hink
> the code as it stands make sense, and I don't think any interaction betwe=
en the
> zero-size check and btf access is intentional. Around [1] we've looked a =
bit at
> the history of this zero-size check, and it's been there forever, predati=
ng
> most of the code around it. What convinces me personally that the zero-si=
ze
> check was not load-bearing is the fact that we were only performing
> the check iff
> umin =3D=3D 0 -- we were not consistently performing a check for the umin=
 value.
> Also, obviously, we were not performing a check for every possible value =
in
> between umin and umax. So I can't really imagine positive benefits of the
> inconsistent check we were doing. But then again, I cannot actually speak=
 with
> confidence about it.

Not checking consistently for all possible offsets is a good argument, than=
k you.

> As a btw, I'll say that we don't allow variable-offset accesses to btf pt=
r [2].
> I don't know if this should influence how we treat the access size... but
> maybe? Like, should we disallow variable-sized accesses on the same argum=
ent as
> disallowing variable-offset ones (whatever that argument may be)? I don't=
 know
> what I'm talking about (generally BTF is foreign to me), but I imagine th=
is all
> means that currently the verifier allows one to read from an array field =
by
> starting at a compile-time constant offset, and extending to a variable s=
ize.
> However, you cannot start from an arbitrary offset, though. Does this
> combination of being strict about the offset but permissive about the siz=
e make
> sense?

I agree with you, that disallowing variable size access in BTF case
might make sense. check_ptr_to_btf_access() calls either:
a. env->ops->btf_struct_access(), which is one of the following:
   1. _tc_cls_act_btf_struct_access() (through a function pointer),
      which allows accessing exactly one field: struct nf_conn->mark;
   2. bpf_tcp_ca_btf_struct_access, which allows accessing several
      fields in sock, tcp_sock and inet_connection_sock structures.
b. btf_struct_access(), which checks the following:
   1. part with btf_find_struct_meta() checks that access does not reach
      to some forbidden field;
   2. btf_struct_walk() checks that offset and size of the access match
      offset and size of some field in the target BTF structure;

Technically, checks a.1, a.2 and b.1 are ok with variable size access,
but b.2 is not and it does not seem to be verified.

I tried a patch below and test_progs seem to pass locally
(but I have some troubles with my local setup at the moment,
 so it should be double-checked).

> I'll take guidance. If people prefer we don't touch this code at all, tha=
t's
> fine. Although it doesn't feel good to be driven simply by fear.

Would be good if others could comment.

[...]

---

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cf2a09408bdc..946415d11338 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7328,6 +7328,7 @@ static int check_mem_size_reg(struct bpf_verifier_env=
 *env,
 {
        int err;
        const bool size_is_const =3D tnum_is_const(reg->var_off);
+       struct bpf_reg_state *ptr_reg =3D &cur_regs(env)[regno - 1];
=20
        /* This is used to refine r0 return value bounds for helpers
         * that enforce this value as an upper bound on return values.
@@ -7373,6 +7374,13 @@ static int check_mem_size_reg(struct bpf_verifier_en=
v *env,
                verbose(env, "verifier bug: !zero_size_allowed should have =
been handled already\n");
                return -EFAULT;
        }
+
+       if (base_type(ptr_reg->type) =3D=3D PTR_TO_BTF_ID && !size_is_const=
) {
+               verbose(env, "variable length access to r%d %s is not allow=
ed",
+                       regno - 1, reg_type_str(env, ptr_reg->type));
+               return -EACCES;
+       }
+
        err =3D check_helper_mem_access(env, regno - 1,
                                      reg->umax_value,
                                      /* zero_size_allowed: we asserted abo=
ve that umax_value is

