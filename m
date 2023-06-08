Return-Path: <bpf+bounces-2150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 491FC7289BA
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 22:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5421C20EB1
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 20:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E6131F19;
	Thu,  8 Jun 2023 20:58:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0489A1DCDC
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 20:58:45 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6254CE61
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 13:58:42 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f63ea7bfb6so1297517e87.3
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 13:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686257920; x=1688849920;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qNFkfCyb39HIedwKZ6qD3W5GXB4yx5XABi0GwBtOG/s=;
        b=ML+VNH/VsvwNc2xAR9ylwqWfKiEGGIw81s6p9/3YiyOx72qUv0WaeOMgOsDT4Lvc3Z
         0tDFqIvEBIZLn7R/VruYzMuXN1vxXY7SmQikvIJCE8DdaEvvfHLjan3bUrO26LdPZapX
         IoE0jwdHngqzBmGQ/KJp8stlnEXOHpFjGR5s/+d4WjjMzAMoj5arLewworvfDS/bSxpv
         HL/pfjDJgj+jaMG2ZUJJ3XkODL1ZOp1WeI59NnsJ0BeAqBzI6VDhfGr7LpwwYQ+eJvo2
         evwpWmhnH2B4S/u0mEs6FHvUv9LwTRz4j/i57wKj8egnMtU7JG1C73SHzw+p22VTVHv1
         CpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686257920; x=1688849920;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qNFkfCyb39HIedwKZ6qD3W5GXB4yx5XABi0GwBtOG/s=;
        b=THDH6hVFGEM/W4lfqqcFosfRgfclFxWkekP9s7U42nwade9549AowoFOAzEGBrK+ZM
         3yXXuF2Oo/YJ0EdBZjH29nuPMTVKGN//vW8UeUGFj+0dC+zPpn1refRSjuh/ud7xQkY7
         APENGlIq11nBGynxeqqzyXDRblOpyWODWS0TDG8Gh9uhQorrlhy92445cKDyouoPG6RN
         jrgVhRIU9WvFvqf6+bWep6tEpnx37CS2+MfXMoqnJrgTwLzK7x0/FvjqtNjm6hZXoNhl
         VZ+xrfWMRx7OSSGpnr5LdAHcPLL79Y8BudaWkOoKF2QoopryWTNNLUjYX1jVciqxaEMr
         RSQw==
X-Gm-Message-State: AC+VfDwQfD99U2e3UIpwlMopoo9Jx9Zjisn0ufppwDA/yF304D6irkGo
	Pf6yc4qXbMWWNOMGU45Alsg=
X-Google-Smtp-Source: ACHHUZ5OXi5apW4xEOIC+oP3M6VXonI7nXt1TgCYp5Nj8v5yYXZQXKLtsAetqZXv/6W7lrKYFOCkUQ==
X-Received: by 2002:a05:6512:1c5:b0:4d8:8ad1:a05f with SMTP id f5-20020a05651201c500b004d88ad1a05fmr141254lfp.48.1686257920228;
        Thu, 08 Jun 2023 13:58:40 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id u22-20020ac25196000000b004f6150e089dsm303372lfi.289.2023.06.08.13.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 13:58:39 -0700 (PDT)
Message-ID: <342f5aaa30ad5ad1a476ffe997e1669d58a8c8ed.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com, yhs@fb.com
Date: Thu, 08 Jun 2023 23:58:38 +0300
In-Reply-To: <5bb3a6c3daf8c36a88eae6d0a3a8e52d7b24f842.camel@gmail.com>
References: <20230606222411.1820404-1-eddyz87@gmail.com>
	 <20230606222411.1820404-4-eddyz87@gmail.com>
	 <CAEf4BzbbGV6gTJ1KdBB8EwLWV3aNE-iyNtP2pC-W1=MTDNRq5Q@mail.gmail.com>
	 <cc31b95783afa7dc8fb806c973f8420d22a49e58.camel@gmail.com>
	 <CAEf4Bzaj6K4UuLQU-eRPWQt+nnyXwj_-yf9NAyqMkW-fc1m0OA@mail.gmail.com>
	 <5bb3a6c3daf8c36a88eae6d0a3a8e52d7b24f842.camel@gmail.com>
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

On Thu, 2023-06-08 at 22:05 +0300, Eduard Zingerman wrote:
[...]
> > Hm.. It's clever and pretty minimal, I like it. We are basically
> > allocating virtual ID for SCALAR that doesn't have id, just to make
> > sure we get a conflict if the SCALAR with ID cannot be mapped into two
> > different SCALARs, right?
> >=20
> > The only question would be if it's safe to do that for case when
> > old_reg->id !=3D 0 and cur_reg->id =3D=3D 0? E.g., if in old (verified)
> > state we have r6.id =3D r7.id =3D 123, and in new state we have r6.id =
=3D 0
> > and r7.id =3D 0, then your implementation above will say that states ar=
e
> > equivalent. But are they, given there is a link between r6 and r7 that
> > might be required for correctness. Which we don't have in current
> > state.
>=20
> You mean the other way around, rold.id =3D=3D 0, rcur.id !=3D 0, right?
> (below 0/2 means: original value 0, replaced by new id 2).
>=20
> (1)   old cur
> r6.id 0/2   1
> r7.id 0/3   1 check_ids returns true
>=20
> (2)   old cur
> r6.id 1   0/2
> r7.id 1   0/3 check_ids returns false
>=20
> Also, (1) is no different from (3):
>=20
> (3)   old cur
> r6.id 1     3
> r7.id 2     3 check_ids returns true
>=20
> Current check:
>=20
> 		if (!rold->precise)
> 			return true;
> 		return range_within(rold, rcur) &&
> 		       tnum_in(rold->var_off, rcur->var_off) &&
> 		       check_ids(rold->id, rcur->id, idmap);
>=20
> Will reject (1) and (2), but will accept (3).
>=20
> New check:
>=20
> 		if (!rold->precise)
> 			return true;
> 		return range_within(rold, rcur) &&
> 		       tnum_in(rold->var_off, rcur->var_off) &&
> 		       check_scalar_ids(rold->id, rcur->id, idmap);
>=20
> Will reject (2), but will accept (1) and (3).
>=20
> And modification of check_scalar_ids() to generate IDs only for rold
> or only for rcur would not reject (3) either.
>=20
> (3) would be rejected only if current check is used together with
> elimination of unique scalar IDs from old states.
>=20
> My previous experiments show that eliminating unique IDs from old
> states and not eliminating unique IDs from cur states is *very* bad
> for performance.
>=20
> >=20
> > So with this we are getting to my original concerns with your
> > !rold->id approach, which tries to ignore the necessity of link
> > between registers.
> >=20
> > What if we do this only for old registers? Then, (in old state) r6.id
> > =3D 0, r7.id =3D 0, (in new state) r6.id =3D r7.id =3D 123. This will b=
e
> > rejected because first we'll map 123 to newly allocated X for r6.id,
> > and then when we try to match r7.id=3D123 to another allocated ID X+1
> > we'll get a conflict, right?

[...]

Ok, here is what I think is the final version:
a. for each old or cur ID generate temporary unique ID;
b. for scalars use modified check_ids that forbids mapping same 'cur'
   ID to several different 'old' IDs.

(a) allows to reject situations like:

  (1)   old cur   (2)   old cur=20
  r6.id 0   1     r6.id 1   0
  r7.id 0   1     r7.id 1   0

(b) allows to reject situations like:

  (3)   old cur
  r6.id 1   3
  r7.id 2   3

And whether some scalar ID is unique or not does not matter for the
algorithm.

Tests are passing, katran example is fine (350k insns, 29K states),
minor veristat regression:

File       Program                         States (DIFF)
---------  ------------------------------  -------------
bpf_xdp.o  tail_nodeport_nat_ingress_ipv4    +3 (+0.80%)
bpf_xdp.o  tail_rev_nodeport_lb4             +2 (+0.50%)

--- 8< -----------------------------

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 235d7eded565..5794dc7830db 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15149,6 +15149,31 @@ static bool check_ids(u32 old_id, u32 cur_id, stru=
ct bpf_id_pair *idmap)
        return false;
 }
=20
+static bool check_scalar_ids(struct bpf_verifier_env *env, u32 old_id, u32=
 cur_id,
+                            struct bpf_id_pair *idmap)
+{
+       unsigned int i;
+
+       old_id =3D old_id ? old_id : env->id_gen++;
+       cur_id =3D cur_id ? cur_id : env->id_gen++;
+
+       for (i =3D 0; i < BPF_ID_MAP_SIZE; i++) {
+               if (!idmap[i].old) {
+                       /* Reached an empty slot; haven't seen this id befo=
re */
+                       idmap[i].old =3D old_id;
+                       idmap[i].cur =3D cur_id;
+                       return true;
+               }
+               if (idmap[i].old =3D=3D old_id)
+                       return idmap[i].cur =3D=3D cur_id;
+               if (idmap[i].cur =3D=3D cur_id)
+                       return false;
+       }
+       /* We ran out of idmap slots, which should be impossible */
+       WARN_ON_ONCE(1);
+       return false;
+}
+
 static void clean_func_state(struct bpf_verifier_env *env,
                             struct bpf_func_state *st)
 {
@@ -15325,7 +15350,7 @@ static bool regsafe(struct bpf_verifier_env *env, s=
truct bpf_reg_state *rold,
                 */
                return range_within(rold, rcur) &&
                       tnum_in(rold->var_off, rcur->var_off) &&
-                      check_ids(rold->id, rcur->id, idmap);
+                      check_scalar_ids(env, rold->id, rcur->id, idmap);
        case PTR_TO_MAP_KEY:
        case PTR_TO_MAP_VALUE:
        case PTR_TO_MEM:

----------------------------- >8 ---

