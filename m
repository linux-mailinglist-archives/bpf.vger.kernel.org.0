Return-Path: <bpf+bounces-2044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8888727149
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 00:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DD322815DE
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 22:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEE13B8D9;
	Wed,  7 Jun 2023 22:05:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2FF3AE79
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 22:05:27 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32981FF5
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 15:05:25 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f649db9b25so7168e87.0
        for <bpf@vger.kernel.org>; Wed, 07 Jun 2023 15:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686175524; x=1688767524;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ux5s7JB5Ti7Lf8FCOgILRP3uUqGnyveuz2AjI88L6ow=;
        b=Ut8OyRIgTrMNBTWvpzWMXXtsM4H8YGyEujCDWr7VWIpRhWCqZLFzR9bptDxkhpUmUA
         xpLwx0P3OgEw5ZOTHfzEWvR/9+OOWdssyoGYG90aSSJZnpDXGmwXejROB7W/MOXH1u3e
         Nmqjzg0/x8nXuWhkB/CLLq/ZBbcrc6viqGgy+L/kKCegtvI4xqbLXRRwpMmy4mGjR7Pc
         2aw93/h5yWT9glkKOiq5FDst+j6EAfjrPxYtr9KfdL4OHkcRa9sPJYsI7MVh2N5EjsSj
         jnaRqZXqyuvu51N0dY40dg47LtxRT8AoY/6c6hCIzFTAw92yH0O1pixNHulBSl22qE9G
         +Pwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686175524; x=1688767524;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ux5s7JB5Ti7Lf8FCOgILRP3uUqGnyveuz2AjI88L6ow=;
        b=VPMRJb8ATe6vuoNPcA9F81/l5f+bPw29GEDKNbI8qfGlxPBe+EK18ufV1nBo2YmkqR
         hoDP/VFI92XZE4/aqZMz21Hv3jtz5DhujqWNxCe3vGJT8F3KpjB4Uq7GaccZTVakOGJN
         jXMooYwSgwmMV/cP0EdmHelaaeGB4ZolZ011jbLiHFill96uJsJSv+fX8OB1VZm8hein
         H1uLBBmM7j/tj1ef5H69O5cdyOdsPp4UymOpobBzqnGL9MnQtsMNPFzTv1yj3uVs4ckp
         zdbS5cCq+ZK7m7GtlAmnMP8kgrdTdL7lW4mwGgmLbtMeulDcJmaBt31L2we8pjlLwwnt
         h/oQ==
X-Gm-Message-State: AC+VfDxpji4PnfbjoOQQD7LCFMiK+HsAWw9UpKTYBlz/FRlruiztfsyi
	kNVyGuEBI0Pu2p7qTbFJ7cM=
X-Google-Smtp-Source: ACHHUZ5/BVRQaw4HiWZkhxlrlXhzMGxj/JHz7I9ou0rp8d10DaoKU2Km8AJcNo4Aa6i/4Hv5WRFcsw==
X-Received: by 2002:ac2:46cd:0:b0:4eb:1361:895c with SMTP id p13-20020ac246cd000000b004eb1361895cmr2732420lfo.55.1686175523783;
        Wed, 07 Jun 2023 15:05:23 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id o27-20020ac2495b000000b004f627f4a07csm1256749lfi.145.2023.06.07.15.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 15:05:23 -0700 (PDT)
Message-ID: <24c2b0295ea9b8a3f3fc256e2d7bf004a046ebb1.camel@gmail.com>
Subject: Re: [RFC bpf-next 1/8] btf: add kind metadata encoding to UAPI
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Yonghong Song <yhs@meta.com>, Toke
 =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@kernel.org>, Alexei
 Starovoitov <alexei.starovoitov@gmail.com>, Alan Maguire
 <alan.maguire@oracle.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Quentin Monnet
 <quentin@isovalent.com>, Mykola Lysenko <mykolal@fb.com>, bpf
 <bpf@vger.kernel.org>
Date: Thu, 08 Jun 2023 01:05:21 +0300
In-Reply-To: <CAEf4BzY9_EiBqM74Gce9-Z5O+uubCY=CUejXr79hDY6SbOvTOg@mail.gmail.com>
References: <20230531201936.1992188-1-alan.maguire@oracle.com>
	 <20230531201936.1992188-2-alan.maguire@oracle.com>
	 <20230601035354.5u56fwuundu6m7v2@MacBook-Pro-8.local>
	 <89787945-c06c-1c41-655b-057c1a3d07dd@oracle.com>
	 <CAADnVQ+2ZuX00MSxAXWcXmyc-dqYtZvGqJ9KzJpstv183nbPEA@mail.gmail.com>
	 <CAEf4BzZaUEqYnyBs6OqX2_L_X=U4zjrKF9nPeyyKp7tRNVLMww@mail.gmail.com>
	 <CAADnVQKbmAHTHk5YsH-t42BRz16MvXdRBdFmc5HFyCPijX-oNg@mail.gmail.com>
	 <CAEf4BzamU4qTjrtoC_9zwx+DHyW26yq_HrevHw2ui-nqr6UF-g@mail.gmail.com>
	 <CAADnVQ+_YeLZ0kmF+QueH_xE10=b-4m_BMh_-rct6S8TbpL0hw@mail.gmail.com>
	 <CAEf4Bzbtptc9DUJ8peBU=xyrXxJFK5=rkr3gGRh05wwtnBZ==A@mail.gmail.com>
	 <CAADnVQJAmYgR91WKJ_Jif6c3ja=OAmkMXoUO9sTnmp-xmnbVJQ@mail.gmail.com>
	 <878rcw3k1o.fsf@toke.dk>
	 <35e5f70bbe0890f875e0c24aff0453c25f018ea6.camel@gmail.com>
	 <e58d3ec4-dcac-48b8-c6c2-63d131d967d8@meta.com>
	 <45fac5ac0874163031b46388d65de194ed6f27e6.camel@gmail.com>
	 <CAEf4BzY9_EiBqM74Gce9-Z5O+uubCY=CUejXr79hDY6SbOvTOg@mail.gmail.com>
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

On Wed, 2023-06-07 at 14:47 -0700, Andrii Nakryiko wrote:
> On Wed, Jun 7, 2023 at 9:14=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > On Wed, 2023-06-07 at 08:29 -0700, Yonghong Song wrote:
> > >=20
> > > On 6/7/23 4:55 AM, Eduard Zingerman wrote:
> > > > On Tue, 2023-06-06 at 13:30 +0200, Toke H=C3=B8iland-J=C3=B8rgensen=
 wrote:
> > > > [...]
> > > > >=20
> > > > > As for bumping the version number, I don't think it's a good idea=
 to
> > > > > deliberately break compatibility this way unless it's absolutely
> > > > > necessary. With "absolutely necessary" meaning "things will break=
 in
> > > > > subtle ways in any case, so it's better to make the breakage obvi=
ous".
> > > > > But it libbpf is not checking the version field anyway, that beco=
mes
> > > > > kind of a moot point, as bumping it doesn't really gain us anythi=
ng,
> > > > > then...
> > > >=20
> > > > It seems to me that in terms of backward compatibility, the ability=
 to
> > > > specify the size for each kind entry is more valuable than the
> > > > capability to add new BTF kinds:
> > > > - The former allows for extending kind records in
> > > >    a backward-compatible manner, such as adding a function address =
to
> > > >    BTF_KIND_FUNC.
> > >=20
> > > Eduard, the new proposal is to add new kind, e.g., BTF_KIND_KFUNC, wh=
ich
> > > will have an 'address' field. BTF_KIND_KFUNC is for kernel functions.
> > > So we will not have size compatibility issue for BTF_KIND_FUNC.
> >=20
> > Well, actually this might be a way to avoid BTF_KIND_KFUNC :)
> > What I wanted to say is that any use of this feature leads to
> > incompatibility with current BTF parsers, as either size of existing
> > kinds would be changed or a new kind with unknown size would be added.
> > It seems to me that this warrants version bump (or some other way to
> > signal existing parsers that format is incompatible).
>=20
> It is probably too late to have existing KINDs changing their size. If
> this layout metadata was mandatory from the very beginning, then we
> could have relied on it for determining new extra fields for
> BTF_KIND_FUNC.
>=20
> As things stand right now, new BTF_KIND_KFUNC is both a signal of
> newer format (for kernel-side BTF; nothing changes for BPF object file
> BTFs, which is great side-effect making backwards compat pain
> smaller), and is a simpler and safer way to add extra information.
>=20
> >=20
> > >=20
> > > > - The latter is much more fragile. Types refer to each other,
> > > >    compatibility is already lost once a new "unknown" tag is introd=
uced
> > > >    in a type chain.
> > > >=20
> > > > However, changing the size of existing BTF kinds is itself a
> > > > backward-incompatible change. Therefore, a version bump may be
> > > > warranted in this regard.
> >=20
>=20
> See above and previous emails. Not having to bump version means we can
> start emitting this layout info from Clang and pahole with no extra
> opt-in flags, and not worry about breaking existing tools and apps.
> This is great, so let's not ruin that property :)

I'm not sure I understand how this would help:
- If no new kinds are added, absence or presence of metadata section
  does not matter. Old parsers would ignore it, new parsers would work
  as old parsers, so there is no added value in generating metadata.
- As soon as new kind is added old parsers are broken.

What am I missing?

