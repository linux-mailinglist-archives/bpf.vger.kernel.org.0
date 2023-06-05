Return-Path: <bpf+bounces-1872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B867231A6
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 22:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 949A11C208E0
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 20:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D746261D6;
	Mon,  5 Jun 2023 20:44:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D29323E
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 20:44:06 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBAAEC
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 13:43:57 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f62cf9755eso1575970e87.1
        for <bpf@vger.kernel.org>; Mon, 05 Jun 2023 13:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685997835; x=1688589835;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PWTNdBmbsJYIMVnDalArRyW5H7hE8akMEsjpCji+c8A=;
        b=HRQh/k7CEHF4owy0UZBjBpSCaHcNe0k/yK9NPVLb2wImaasIy+bR6KdiaYHrKd1xzX
         bOuvF4rA+g4D/Fp5yJ1Xn4JN4e5koMPSP014W1phu8giEm/F4IEwtlXKWwMk8iVoEDJu
         KUaIjOLYbjUSG2OSIj8toYYsIVqvgPPA63fyOigJKeVn/+XdCHJkJid5pmM1BamqvEUK
         nlOH+/FjR6VOHGgxNB+eNB/DcCxjOItQorapGmBZaaIY1mT2oGs3yACjIZ00iCxoGBTK
         /taAnlFT1X6CpPdvkXPuLBoOsmq4qzLYtHF45CrWJbyyNBb+1nRcaK8itraa3udfcctg
         3PHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685997835; x=1688589835;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PWTNdBmbsJYIMVnDalArRyW5H7hE8akMEsjpCji+c8A=;
        b=Dr+FSW6+pJpDvCqwg2011CL23v35LiMnftcFTidL3js2CeICy6Fnd3qUsTP55qWLw8
         0G3DLYkX9HRpzss7roBSkjRgp4iEypACunN1BU9p3RZs4cPQmEgq47d27wv3MxA+4fjm
         d2tyKiF6jVXK9MGngWRUA5CWJSNL9ocmTSEsFJwMydKRZUkEP37F8ca9yJPxM4k1Xd/A
         Qr/C/bmA5Rkflyd/P9/wACByWGDscAU0C166m8/dhplfzShQwkY3yDNx2DZgd8L+2yqs
         hQlWgcgJWkqT8pJ10rUszpFUKFGqIP1wmrPlmDfcJ8x6oCsvlMIujo8ewb4iiiSWDJqd
         aBEQ==
X-Gm-Message-State: AC+VfDwpancKlJzx8yFmzHAkRg1vVz9zxvBP74dms27jgfh8ltVLq0Qt
	e2sRU4SJ6Ajj96gSA2S/JpQsbIvaUUh2KA==
X-Google-Smtp-Source: ACHHUZ6QfrDdBGH+Vr+SKeMxg8EeEyX2wojz/UKXoiZUmK57Cq3bjFFUsDKSrDat4bqw1wA/wKKxGQ==
X-Received: by 2002:a05:6512:61:b0:4f6:217a:561e with SMTP id i1-20020a056512006100b004f6217a561emr53387lfo.37.1685997835264;
        Mon, 05 Jun 2023 13:43:55 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id q1-20020ac25101000000b004f381a71f26sm1248278lfb.46.2023.06.05.13.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 13:43:54 -0700 (PDT)
Message-ID: <d301a15f96e3c4050a8fb3ff238705aeba0f1ce9.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov
	 <ast@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf
 <bpf@vger.kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
 Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Date: Mon, 05 Jun 2023 23:43:53 +0300
In-Reply-To: <db0ce896af65b729e09cb1fb0fee6aa5b5d44ce0.camel@gmail.com>
References: <20230530172739.447290-1-eddyz87@gmail.com>
	 <20230530172739.447290-2-eddyz87@gmail.com>
	 <CAEf4BzYJbzR0f5HyjLMJEmBdHkydQiOjdkk=K4AkXWTwnXsWEg@mail.gmail.com>
	 <8b0da2244a328f23a78dc73306177ebc6f0eabfd.camel@gmail.com>
	 <20230601020514.vhnlnmowbo6dxwfj@MacBook-Pro-8.local>
	 <81e2e47c71b6a0bc014c204e18c6be2736fed338.camel@gmail.com>
	 <CAADnVQJY4TR3hoDUyZwGxm10sBNvpLHTa_yW-T6BvbukvAoypg@mail.gmail.com>
	 <6a52b65c270a702f6cbd6ffcf627213af4715200.camel@gmail.com>
	 <CAEf4BzbM2bWHfdCoVYdfUmuYJRVzADBXHzbDwHkg_EX13pJ7gA@mail.gmail.com>
	 <7f39e172d68a1ad92ffe886b4df060ef49cff047.camel@gmail.com>
	 <CAEf4BzY8u_JbwBi=wYLFopj79MOfKGnyWo9O19esBqoT2zsABA@mail.gmail.com>
	 <6cbfe3170e72fb981823cb7680a204c62ab36ede.camel@gmail.com>
	 <CAEf4BzZvBDuSdKTW+PzB9RPvi=yMNHixdDWh+6dbJcBz6nO5hQ@mail.gmail.com>
	 <db0ce896af65b729e09cb1fb0fee6aa5b5d44ce0.camel@gmail.com>
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

On Sat, 2023-06-03 at 02:20 +0300, Eduard Zingerman wrote:
> On Fri, 2023-06-02 at 15:07 -0700, Andrii Nakryiko wrote:
> [...]
> > > And we don't really need to bother about unique IDs in non-cached sta=
te
> > > when rold->id check discussed in a sibling thread is used:
> > >=20
> > >                 if (rold->precise && rold->id && !check_ids(rold->id,=
 rcur->id, idmap))
> > >                         return false;
> >=20
> > It makes me worry that we are mixing no ID and ID-ed SCALARs and
> > making them equivalent. I need to think some more about implications
> > (and re-read what you and Alexei discussed). I don't feel good about
> > this and suspect we'll miss some non-obvious corner case if we do
> > this.
>=20
> Here is the complete argument in a single piece:
>=20
>   Suppose:
>     - There is a checkpoint state 'Old' with two registers marked as:
>       - rA=3Dprecise scalar with range A, id=3D0;
>       - rB=3Dprecise scalar with range B, id=3D0.
>     - 'Old' is proven to be safe.
>     - There is a new state 'Cur' with two registers marked as:
>       - rA=3Dscalar with range C, id=3DU;
>       - rB=3Dscalar with range C, id=3DU;
>         (Note: if rA.id =3D=3D rB.id the registers have identical range).
>=20
>   Proposition:
>     As long as range C is a subset of both range A and range B
>     the state 'Cur' is safe.
>=20
>   Proof:
>     State 'Cur' represents a special case of state 'Old',
>     a variant of 'Old' where rA and rB happen to have same value.
>     Thus 'Cur' is safe because 'Old' is safe.
>=20

I had a separate discussion with Andrii on this topic.
Andrii is still concerned that the change from:

	if (rold->precise && !check_ids(idmap, rold, rcur))
		return false;
to:

	if (rold->precise && rold->id && !check_ids(idmap, rold, rcur))
		return false;

Is not fully equivalent and there might be a corner case where 'Cur'
and 'Old' don't behave in the same way. I don't have a better argument
than the one stated above.

On the other hand, this optimization is needed to mitigate relatively
small overhead:

$ ./veristat -e file,prog,states -f "states_pct>10" \
    -C master-baseline.log current.log
File         Program                         States  (DIFF)
-----------  ------------------------------  --------------
bpf_xdp.o    tail_handle_nat_fwd_ipv6        +155 (+23.92%)
bpf_xdp.o    tail_nodeport_nat_ingress_ipv4  +102 (+27.20%)
bpf_xdp.o    tail_rev_nodeport_lb4            +83 (+20.85%)
loop6.bpf.o  trace_virtqueue_add_sgs          +25 (+11.06%)

(there are also a few programs with overhead <1%, I don't list those
 for brevity).
=20
On yet another hand:
- this change major impact is because of elimination of unique IDs in
  the 'Cur' state;
- once register spill/fill code is modified to generate scalar IDs in
  the same way as BPF_MOV code does it would be possible to drop
  unique scalar IDs in 'Cur' and in 'Old' in is_state_visited() /
  clean_live_states() using the same code.

Having this in mind we decided to withhold this change for now.
I will post an updated patch-set without it, Andrii will test it on
some more internal BPF programs to see if impact is still small.

> > >=20
> > > Here, if rcur->id is unique there are two cases:
> > > - rold->id =3D=3D 0: then rcur->id is just ignored
> > > - rold->id !=3D 0: then rold->id/rcur->id pair would be added to idma=
p,
> > >                  there is some other precise old register with the
> > >                  same id as rold->id, so eventually check_ids()
> > >                  would make regsafe() return false.
> > >=20
> > > > > - do a check as follows:
> > > > >   if (rold->precise && rold->id && !check_ids(idmap, rold, rcur))
> > > > >     return false;
> > > >=20

