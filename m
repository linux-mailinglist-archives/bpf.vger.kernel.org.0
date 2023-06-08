Return-Path: <bpf+bounces-2177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7AE728BEB
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 01:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 086C22817FE
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 23:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508D6370C2;
	Thu,  8 Jun 2023 23:40:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDF41953A
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 23:40:49 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323FD194
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 16:40:36 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f63ab1ac4aso1458899e87.0
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 16:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686267634; x=1688859634;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pekEYx3Kd88VqHH2OQbUa4oacx5THAvNBzgpfcGD8Sk=;
        b=AmVwH4mMnLJ/ow8YWbAd6rANFUCz27LpEDfwaEuEBuF3maqkKEuQlQGz3kj74w7OsF
         Kbl5xqWzHk+h1Ed3mAT3W809XfLLCvaUDFJwy+XGtJNlFxuEdbwhSPGgVBNoPaNtqk+U
         hrF7Xb6EW33VLb9MDA154xMuxn3NocNI9YBCN8j9+HSlh9a3DrF8/lx49piUFIDAZ69U
         iIVZUombOhBwuomHCY8JZkQChc2XfAPO/9uLAx9B/4KnGqkb2uhPEI/3xlEMX/+uGbc/
         tdkOZUOFc6hLJ6O5VP+7+kVlcF6yo1spqOgVvZeBF+omxHD9sDJwQMQNrIGmz+KxMQPI
         SgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686267634; x=1688859634;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pekEYx3Kd88VqHH2OQbUa4oacx5THAvNBzgpfcGD8Sk=;
        b=eiXz9yzO8+igteuYQRe3TYAgqJr+UuaLPxAmCR/b/PwWeprYNyaWel/WRPaWBD56CX
         WPQx8uFzjKasTs2J0VxSDuh+4LwQC2UY582ofHEa5qqBkrRROZOJr8ARbz30mt78VwR6
         KaDQtiQAX69d5xc93u9EqA++cAllS9dpEFOkBa5qREVpIjivRXa29g73Q+ZTcrVPtGR2
         wNjYYDHned0wWre8QArtIUYtMoreXp+YCfiqhLKEMhQsFgWdsPwldCa0ow9KXlZGbAUz
         JQJlIpbY3e7TBol9wMuWk49k/ovnTW9E1GwOyfOxqYbh4Ldw5aBtIQwMRoXCzt1d9+Um
         WB/w==
X-Gm-Message-State: AC+VfDyvHXzHAaj1YzrnFAGTK9lWae1TpErDYCv9AMeRHU8GlwYhN3x/
	XrZBxi0T2XWEwDfmUaZ/15E=
X-Google-Smtp-Source: ACHHUZ5jWszjOO535p5yzPZQnx4z9kG6AUIohQ3ZeaznnqZGrq1URB1JzD9IKGs32IUUCyk99r5xtA==
X-Received: by 2002:a19:d60a:0:b0:4f6:e50:d41c with SMTP id n10-20020a19d60a000000b004f60e50d41cmr247723lfg.60.1686267634082;
        Thu, 08 Jun 2023 16:40:34 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id j13-20020ac253ad000000b004f0049433adsm334123lfh.307.2023.06.08.16.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 16:40:33 -0700 (PDT)
Message-ID: <eff91336d6b83caffd63386f076a08744fe13f47.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com, yhs@fb.com
Date: Fri, 09 Jun 2023 02:40:32 +0300
In-Reply-To: <CAEf4BzZ8u9MWgcx4DqBVWW6tLx4mVCrc9ZW0fgoJvfA-DhxgkA@mail.gmail.com>
References: <20230606222411.1820404-1-eddyz87@gmail.com>
	 <20230606222411.1820404-4-eddyz87@gmail.com>
	 <CAEf4BzbbGV6gTJ1KdBB8EwLWV3aNE-iyNtP2pC-W1=MTDNRq5Q@mail.gmail.com>
	 <cc31b95783afa7dc8fb806c973f8420d22a49e58.camel@gmail.com>
	 <CAEf4Bzaj6K4UuLQU-eRPWQt+nnyXwj_-yf9NAyqMkW-fc1m0OA@mail.gmail.com>
	 <5bb3a6c3daf8c36a88eae6d0a3a8e52d7b24f842.camel@gmail.com>
	 <342f5aaa30ad5ad1a476ffe997e1669d58a8c8ed.camel@gmail.com>
	 <CAEf4BzZ8u9MWgcx4DqBVWW6tLx4mVCrc9ZW0fgoJvfA-DhxgkA@mail.gmail.com>
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

On Thu, 2023-06-08 at 15:37 -0700, Andrii Nakryiko wrote:
> On Thu, Jun 8, 2023 at 1:58=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > On Thu, 2023-06-08 at 22:05 +0300, Eduard Zingerman wrote:
> > [...]
> > > > Hm.. It's clever and pretty minimal, I like it. We are basically
> > > > allocating virtual ID for SCALAR that doesn't have id, just to make
> > > > sure we get a conflict if the SCALAR with ID cannot be mapped into =
two
> > > > different SCALARs, right?
> > > >=20
> > > > The only question would be if it's safe to do that for case when
> > > > old_reg->id !=3D 0 and cur_reg->id =3D=3D 0? E.g., if in old (verif=
ied)
> > > > state we have r6.id =3D r7.id =3D 123, and in new state we have r6.=
id =3D 0
> > > > and r7.id =3D 0, then your implementation above will say that state=
s are
> > > > equivalent. But are they, given there is a link between r6 and r7 t=
hat
> > > > might be required for correctness. Which we don't have in current
> > > > state.
> > >=20
> > > You mean the other way around, rold.id =3D=3D 0, rcur.id !=3D 0, righ=
t?
> > > (below 0/2 means: original value 0, replaced by new id 2).
>=20
> no, I actually meant what I wrote, but I didn't realize that
> check_ids() is kind of broken... Because it shouldn't allow the same
> ID from cur state to be mapped to two different IDs in old state,
> should it?

IDs are used for several things, and it looks like the answer might vary.

For example, I looked at mark_ptr_or_null_regs():
- it is called when conditional of form (ptr =3D=3D NULL) is checked;
- it marks every register with pointer having same ID as ptr as
  null/non-null;
- when register is marked not null ID is removed (not for locks but
  ignore it for now).

Assume r6 and r7 are both PTR_MAYBE_NULL and ID assignments look as
follows:

        old cur
  r6.id 1   3
  r7.id 2   3
 =20
'old' is safe, which means the following:
- either r6 was not accessed or it was guarded by (r6 =3D=3D NULL)
- either r7 was not accessed or it was guarded by (r7 =3D=3D NULL)

In both cases it should be ok, if r6 and r7 are in fact the same
pointer. It would be checked to be not NULL two times but that's fine.
So, I'd say that 'cur' is a special case of 'old' and check_ids() is
correct for it. But this is the same argument I used for scalars and
you were not convinced :)

Need to examine each use case carefully.

> > > (1)   old cur
> > > r6.id 0/2   1
> > > r7.id 0/3   1 check_ids returns true
>=20
> I think this should be rejected.

That's what we agreed upon when decided not to do !rold->id, so yes.

> > > (2)   old cur
> > > r6.id 1   0/2
> > > r7.id 1   0/3 check_ids returns false
>=20
> And this should be rejected.

For sure.

> > > Also, (1) is no different from (3):
> > >=20
> > > (3)   old cur
> > > r6.id 1     3
> > > r7.id 2     3 check_ids returns true
>=20
> And this definitely should be rejected.

Same as (1).
=20
> The only situation that might not be rejected would be:
>=20
>         old    cur
> r6.id   0/1    3
> r7.id.  0/2    4
>=20
> And perhaps this one is ok as well?
>=20
>         old    cur
> r6.id   3      0/1
> r7.id.  4      0/2

I think these two should be accepted.

[...]
> > +static bool check_scalar_ids(struct bpf_verifier_env *env, u32 old_id,=
 u32 cur_id,
> > +                            struct bpf_id_pair *idmap)
> > +{
> > +       unsigned int i;
> > +
> > +       old_id =3D old_id ? old_id : env->id_gen++;
> > +       cur_id =3D cur_id ? cur_id : env->id_gen++;
> > +
> > +       for (i =3D 0; i < BPF_ID_MAP_SIZE; i++) {
> > +               if (!idmap[i].old) {
> > +                       /* Reached an empty slot; haven't seen this id =
before */
> > +                       idmap[i].old =3D old_id;
> > +                       idmap[i].cur =3D cur_id;
> > +                       return true;
> > +               }
> > +               if (idmap[i].old =3D=3D old_id)
> > +                       return idmap[i].cur =3D=3D cur_id;
> > +               if (idmap[i].cur =3D=3D cur_id)
> > +                       return false;
>=20
> I think this should just be added to existing check_ids(), I think
> it's a bug that we don't check this condition today in check_ids().
>=20
> But I'd say let's land fixes you have right now. And then work on
> fixing and optimizing scala ID checks separately. We are doing too
> many things at the same time :(

Ok, will post V4 with these changes and examine other cases later.
Thanks again for the discussion.

[...]

