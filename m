Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832CF4D8F09
	for <lists+bpf@lfdr.de>; Mon, 14 Mar 2022 22:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245406AbiCNVvA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Mar 2022 17:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245401AbiCNVu7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Mar 2022 17:50:59 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95034344C7
        for <bpf@vger.kernel.org>; Mon, 14 Mar 2022 14:49:46 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b24so21774070edu.10
        for <bpf@vger.kernel.org>; Mon, 14 Mar 2022 14:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ASwZHRL1dYbxHAAa3H6QEoYnEavtAfPpzmwEdcjIHqE=;
        b=igvYHJaUv8JDuRTWMdMd9UAj4PSFohvnrwhVM9vPjl+ymJQuA4if7lX5wbLZE0zYAJ
         JazPqxD7G0CU08Gqgs1BhIsKq0XPxTKKRJVgKvyG/6+YvfhmRmxBxyEEDDdw2fDnN2xC
         CaRmR7yrvwo9VlhBhpMl4DUpRxmb52ghfh+6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ASwZHRL1dYbxHAAa3H6QEoYnEavtAfPpzmwEdcjIHqE=;
        b=dYSRpkMk+mH/VWnKqch3xz5yBYuZ5qsxqIA2M/iCLoarDIy9dk/JAaPcMWz/O0zOFF
         VpDYzZrcVzqC5lwwktPGb4szs4AW/s8sbhS868SZKoWYk8oGWjKOUnoKv4SyAuD74ZaB
         3S6Kg0JqDuYWdTEt7XsLN/Tnrj5Jj7S0IAsWxjxqtgJgY7kNBCw2Op7S+AKKfulPltSf
         0gZtjk9B/PSd51m2+mCvsjTG/Pjxqb/HL7FMR1bZ25Y+DyxnU8o5WJ1vHbTC4dUDQ8iD
         w4UBZHuh4z0/J8slMjapvusbtDMoVC3KO2MeMnTkmaz9bqRGS14gmojhhxBfH7hvGLks
         Kgdw==
X-Gm-Message-State: AOAM531uWsytX+D1gDA7bsII2raD7NwDVF6BbfUb/d0m7QMyE2QKLmiP
        rj/jp0snkz1nQUbGWzSLAl/JEQ==
X-Google-Smtp-Source: ABdhPJxVU3DgsskRNuuKPRK9GO7r+QLpC/Nqd1O2x9fJSmwsdmGfXJIEpdG7T04kqIt7imnk91XKTg==
X-Received: by 2002:a05:6402:35c7:b0:418:600e:516c with SMTP id z7-20020a05640235c700b00418600e516cmr12401110edc.28.1647294585038;
        Mon, 14 Mar 2022 14:49:45 -0700 (PDT)
Received: from cloudflare.com ([2a01:110f:4809:d800::f9c])
        by smtp.gmail.com with ESMTPSA id i22-20020a170906251600b006d6d9081f46sm7297807ejb.150.2022.03.14.14.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 14:49:44 -0700 (PDT)
References: <20220222182559.2865596-1-iii@linux.ibm.com>
 <20220222182559.2865596-2-iii@linux.ibm.com>
 <87bkygzbg5.fsf@cloudflare.com>
 <8d8b464f6c2820989d67f00d24b6003b8b758274.camel@linux.ibm.com>
 <871qzbz5sa.fsf@cloudflare.com>
 <a924d763fe50ec80594ca3fac6b311cf9ec20fca.camel@linux.ibm.com>
 <87wnh1xvaj.fsf@cloudflare.com> <87o828xwf3.fsf@cloudflare.com>
 <f46bff60be49ab2062770d39a20d1874b10c70ae.camel@linux.ibm.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH RFC bpf-next 1/3] bpf: Fix certain narrow loads with
 offsets
Date:   Mon, 14 Mar 2022 21:57:55 +0100
In-reply-to: <f46bff60be49ab2062770d39a20d1874b10c70ae.camel@linux.ibm.com>
Message-ID: <87k0cwxkzs.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On Mon, Mar 14, 2022 at 07:25 PM +01, Ilya Leoshkevich wrote:
> On Mon, 2022-03-14 at 18:35 +0100, Jakub Sitnicki wrote:
>> On Thu, Mar 10, 2022 at 11:57 PM +01, Jakub Sitnicki wrote:
>> > On Wed, Mar 09, 2022 at 01:34 PM +01, Ilya Leoshkevich wrote:
>> > > On Wed, 2022-03-09 at 09:36 +0100, Jakub Sitnicki wrote:
>> >=20
>> > [...]
>> >=20
>> > > >=20
>> > > > Consider this - today the below is true on both LE and BE,
>> > > > right?
>> > > >=20
>> > > > =C2=A0 *(u32 *)&ctx->remote_port =3D=3D *(u16 *)&ctx->remote_port
>> > > >=20
>> > > > because the loads get converted to:
>> > > >=20
>> > > > =C2=A0 *(u16 *)&ctx_kern->sport =3D=3D *(u16 *)&ctx_kern->sport
>> > > >=20
>> > > > IOW, today, because of the bug that you are fixing here, the
>> > > > data
>> > > > layout
>> > > > changes from the PoV of the BPF program depending on the load
>> > > > size.
>> > > >=20
>> > > > With 2-byte loads, without this patch, the data layout appears
>> > > > as:
>> > > >=20
>> > > > =C2=A0 struct bpf_sk_lookup {
>> > > > =C2=A0=C2=A0=C2=A0 ...
>> > > > =C2=A0=C2=A0=C2=A0 __be16 remote_port;
>> > > > =C2=A0=C2=A0=C2=A0 __be16 remote_port;
>> > > > =C2=A0=C2=A0=C2=A0 ...
>> > > > =C2=A0 }
>> > >=20
>> > > I see, one can indeed argue that this is also a part of the ABI
>> > > now.
>> > > So we're stuck between a rock and a hard place.
>> > >=20
>> > > > While for 4-byte loads, it appears as in your 2nd patch:
>> > > >=20
>> > > > =C2=A0 struct bpf_sk_lookup {
>> > > > =C2=A0=C2=A0=C2=A0 ...
>> > > > =C2=A0=C2=A0=C2=A0 #if little-endian
>> > > > =C2=A0=C2=A0=C2=A0 __be16 remote_port;
>> > > > =C2=A0=C2=A0=C2=A0 __u16=C2=A0 :16; /* zero padding */
>> > > > =C2=A0=C2=A0=C2=A0 #elif big-endian
>> > > > =C2=A0=C2=A0=C2=A0 __u16=C2=A0 :16; /* zero padding */
>> > > > =C2=A0=C2=A0=C2=A0 __be16 remote_port;
>> > > > =C2=A0=C2=A0=C2=A0 #endif
>> > > > =C2=A0=C2=A0=C2=A0 ...
>> > > > =C2=A0 }
>> > > >=20
>> > > > Because of that I don't see how we could keep complete ABI
>> > > > compatiblity,
>> > > > and have just one definition of struct bpf_sk_lookup that
>> > > > reflects
>> > > > it. These are conflicting requirements.
>> > > >=20
>> > > > I'd bite the bullet for 4-byte loads, for the sake of having an
>> > > > endian-agnostic struct bpf_sk_lookup and struct bpf_sock
>> > > > definition
>> > > > in
>> > > > the uAPI header.
>> > > >=20
>> > > > The sacrifice here is that the access converter will have to
>> > > > keep
>> > > > rewriting 4-byte access to bpf_sk_lookup.remote_port and
>> > > > bpf_sock.dst_port in this unexpected, quirky manner.
>> > > >=20
>> > > > The expectation is that with time users will recompile their
>> > > > BPF
>> > > > progs
>> > > > against the updated bpf.h, and switch to 2-byte loads. That
>> > > > will make
>> > > > the quirk in the access converter dead code in time.
>> > > >=20
>> > > > I don't have any better ideas. Sorry.
>> > > >=20
>> > > > [...]
>> > >=20
>> > > I agree, let's go ahead with this solution.
>> > >=20
>> > > The only remaining problem that I see is: the bug is in the
>> > > common
>> > > code, and it will affect the fields that we add in the future.
>> > >=20
>> > > Can we either document this state of things in a comment, or fix
>> > > the
>> > > bug and emulate the old behavior for certain fields?
>> >=20
>> > I think we can fix the bug in the common code, and compensate for
>> > the
>> > quirky 4-byte access to bpf_sk_lookup.remote_port and
>> > bpf_sock.dst_port
>> > in the is_valid_access and convert_ctx_access.
>> >=20
>> > With the patch as below, access to remote_port gets rewritten to:
>> >=20
>> > * size=3D1, offset=3D0, r2 =3D *(u8 *)(r1 +36)
>> > =C2=A0=C2=A0 0: (69) r2 =3D *(u16 *)(r1 +4)
>> > =C2=A0=C2=A0 1: (54) w2 &=3D 255
>> > =C2=A0=C2=A0 2: (b7) r0 =3D 0
>> > =C2=A0=C2=A0 3: (95) exit
>> >=20
>> > * size=3D1, offset=3D1, r2 =3D *(u8 *)(r1 +37)
>> > =C2=A0=C2=A0 0: (69) r2 =3D *(u16 *)(r1 +4)
>> > =C2=A0=C2=A0 1: (74) w2 >>=3D 8
>> > =C2=A0=C2=A0 2: (54) w2 &=3D 255
>> > =C2=A0=C2=A0 3: (b7) r0 =3D 0
>> > =C2=A0=C2=A0 4: (95) exit
>> >=20
>> > * size=3D1, offset=3D2, r2 =3D *(u8 *)(r1 +38)
>> > =C2=A0=C2=A0 0: (b4) w2 =3D 0
>> > =C2=A0=C2=A0 1: (54) w2 &=3D 255
>> > =C2=A0=C2=A0 2: (b7) r0 =3D 0
>> > =C2=A0=C2=A0 3: (95) exit
>> >=20
>> > * size=3D1, offset=3D3, r2 =3D *(u8 *)(r1 +39)
>> > =C2=A0=C2=A0 0: (b4) w2 =3D 0
>> > =C2=A0=C2=A0 1: (74) w2 >>=3D 8
>> > =C2=A0=C2=A0 2: (54) w2 &=3D 255
>> > =C2=A0=C2=A0 3: (b7) r0 =3D 0
>> > =C2=A0=C2=A0 4: (95) exit
>> >=20
>> > * size=3D2, offset=3D0, r2 =3D *(u16 *)(r1 +36)
>> > =C2=A0=C2=A0 0: (69) r2 =3D *(u16 *)(r1 +4)
>> > =C2=A0=C2=A0 1: (b7) r0 =3D 0
>> > =C2=A0=C2=A0 2: (95) exit
>> >=20
>> > * size=3D2, offset=3D2, r2 =3D *(u16 *)(r1 +38)
>> > =C2=A0=C2=A0 0: (b4) w2 =3D 0
>> > =C2=A0=C2=A0 1: (b7) r0 =3D 0
>> > =C2=A0=C2=A0 2: (95) exit
>> >=20
>> > * size=3D4, offset=3D0, r2 =3D *(u32 *)(r1 +36)
>> > =C2=A0=C2=A0 0: (69) r2 =3D *(u16 *)(r1 +4)
>> > =C2=A0=C2=A0 1: (b7) r0 =3D 0
>> > =C2=A0=C2=A0 2: (95) exit
>> >=20
>> > How does that look to you?
>> >=20
>> > Still need to give it a test on s390x.
>>=20
>> Context conversion with patch below applied looks correct to me on
>> s390x
>> as well:
>>=20
>> * size=3D1, offset=3D0, r2 =3D *(u8 *)(r1 +36)
>> =C2=A0=C2=A0 0: (69) r2 =3D *(u16 *)(r1 +4)
>> =C2=A0=C2=A0 1: (bc) w2 =3D w2
>> =C2=A0=C2=A0 2: (74) w2 >>=3D 8
>> =C2=A0=C2=A0 3: (bc) w2 =3D w2
>> =C2=A0=C2=A0 4: (54) w2 &=3D 255
>> =C2=A0=C2=A0 5: (bc) w2 =3D w2
>> =C2=A0=C2=A0 6: (b7) r0 =3D 0
>> =C2=A0=C2=A0 7: (95) exit
>>=20
>> * size=3D1, offset=3D1, r2 =3D *(u8 *)(r1 +37)
>> =C2=A0=C2=A0 0: (69) r2 =3D *(u16 *)(r1 +4)
>> =C2=A0=C2=A0 1: (bc) w2 =3D w2
>> =C2=A0=C2=A0 2: (54) w2 &=3D 255
>> =C2=A0=C2=A0 3: (bc) w2 =3D w2
>> =C2=A0=C2=A0 4: (b7) r0 =3D 0
>> =C2=A0=C2=A0 5: (95) exit
>>=20
>> * size=3D1, offset=3D2, r2 =3D *(u8 *)(r1 +38)
>> =C2=A0=C2=A0 0: (b4) w2 =3D 0
>> =C2=A0=C2=A0 1: (bc) w2 =3D w2
>> =C2=A0=C2=A0 2: (74) w2 >>=3D 8
>> =C2=A0=C2=A0 3: (bc) w2 =3D w2
>> =C2=A0=C2=A0 4: (54) w2 &=3D 255
>> =C2=A0=C2=A0 5: (bc) w2 =3D w2
>> =C2=A0=C2=A0 6: (b7) r0 =3D 0
>> =C2=A0=C2=A0 7: (95) exit
>>=20
>> * size=3D1, offset=3D3, r2 =3D *(u8 *)(r1 +39)
>> =C2=A0=C2=A0 0: (b4) w2 =3D 0
>> =C2=A0=C2=A0 1: (bc) w2 =3D w2
>> =C2=A0=C2=A0 2: (54) w2 &=3D 255
>> =C2=A0=C2=A0 3: (bc) w2 =3D w2
>> =C2=A0=C2=A0 4: (b7) r0 =3D 0
>> =C2=A0=C2=A0 5: (95) exit
>>=20
>> * size=3D2, offset=3D0, r2 =3D *(u16 *)(r1 +36)
>> =C2=A0=C2=A0 0: (69) r2 =3D *(u16 *)(r1 +4)
>> =C2=A0=C2=A0 1: (bc) w2 =3D w2
>> =C2=A0=C2=A0 2: (b7) r0 =3D 0
>> =C2=A0=C2=A0 3: (95) exit
>>=20
>> * size=3D2, offset=3D2, r2 =3D *(u16 *)(r1 +38)
>> =C2=A0=C2=A0 0: (b4) w2 =3D 0
>> =C2=A0=C2=A0 1: (bc) w2 =3D w2
>> =C2=A0=C2=A0 2: (b7) r0 =3D 0
>> =C2=A0=C2=A0 3: (95) exit
>>=20
>> * size=3D4, offset=3D0, r2 =3D *(u32 *)(r1 +36)
>> =C2=A0=C2=A0 0: (69) r2 =3D *(u16 *)(r1 +4)
>> =C2=A0=C2=A0 1: (bc) w2 =3D w2
>> =C2=A0=C2=A0 2: (b7) r0 =3D 0
>> =C2=A0=C2=A0 3: (95) exit
>>=20
>> If we go this way, this should unbreak the bpf selftests on BE,
>> independently of the patch 1 from this series.
>>=20
>> Will send it as a patch, so that we continue the review discussion.
>
> I applied this patch to bpf-next, and while it looks reasonable, the
> test still fails, e.g. here:
>
> 	/* Load from remote_port field with zero padding (backward
> compatibility) */
> 	val_u32 =3D *(__u32 *)&ctx->remote_port;
> 	if (val_u32 !=3D bpf_htonl(bpf_ntohs(SRC_PORT) << 16))
> 		return SK_DROP;
>

You are right. That's that the check I recently added that broke the bpf
CI runs for s390x [1], and started our thread.

I had a stale build of test_progs with a fix akin to patch [2] that I
was testing and missed that. Thanks for giving it a run.

If we go with Martin's suggestion [3] here and avoid bpf_htonl(), then
we could make it work and save ourselves endianess checks.

IOW, a patch like below would be also needed to unbreak the tests.

First chunk is copied from your fixes to test_sk_lookup in patch 3 in
this RFC series, naturally.

[1] https://lore.kernel.org/bpf/CAEf4BzaRNLw9_EnaMo5e46CdEkzbJiVU3j9oxnsemB=
KjNFf3wQ@mail.gmail.com/
[2] https://lore.kernel.org/bpf/20220227202757.519015-4-jakub@cloudflare.co=
m/
[3] https://lore.kernel.org/bpf/20220301062207.d3aqge5qg623asr6@kafai-mbp.d=
hcp.thefacebook.com/

---8<---

diff --git a/tools/testing/selftests/bpf/progs/test_sk_lookup.c b/tools/tes=
ting/selftests/bpf/progs/test_sk_lookup.c
index bf5b7caefdd0..2765a4bd500c 100644
--- a/tools/testing/selftests/bpf/progs/test_sk_lookup.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
@@ -413,15 +413,14 @@ int ctx_narrow_access(struct bpf_sk_lookup *ctx)

        /* Narrow loads from remote_port field. Expect SRC_PORT. */
        if (LSB(ctx->remote_port, 0) !=3D ((SRC_PORT >> 0) & 0xff) ||
-           LSB(ctx->remote_port, 1) !=3D ((SRC_PORT >> 8) & 0xff) ||
-           LSB(ctx->remote_port, 2) !=3D 0 || LSB(ctx->remote_port, 3) !=
=3D 0)
+           LSB(ctx->remote_port, 1) !=3D ((SRC_PORT >> 8) & 0xff))
                return SK_DROP;
        if (LSW(ctx->remote_port, 0) !=3D SRC_PORT)
                return SK_DROP;

        /* Load from remote_port field with zero padding (backward compatib=
ility) */
        val_u32 =3D *(__u32 *)&ctx->remote_port;
-       if (val_u32 !=3D bpf_htonl(bpf_ntohs(SRC_PORT) << 16))
+       if (val_u32 !=3D SRC_PORT)
                return SK_DROP;

        /* Narrow loads from local_port field. Expect DST_PORT. */
