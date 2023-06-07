Return-Path: <bpf+bounces-2004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65663726594
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 18:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21EAF2812F1
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 16:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA1337325;
	Wed,  7 Jun 2023 16:14:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6440734D94
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 16:14:41 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCD51BDF
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 09:14:39 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b1af9ef7a9so68069421fa.1
        for <bpf@vger.kernel.org>; Wed, 07 Jun 2023 09:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686154477; x=1688746477;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZHS3RgPrEuzUDOPW9f757i2RQxMltNXmjLxDojTeMZ0=;
        b=S5Ii04bGp09gdlD+tTCyRk7w3TFTau2JMj+sU1/bJkAZcd1Oivj6JrfG42dmffg1iT
         BGb9+GpzscjSmgnL301HM3lYaRvyh0xznRUOuhXya22iZwX3NhC3RgPZk5ABIZbjwv/T
         1rwxWc91lnTOeSg46vk55nPc/inr6I8zm3PE8yTGGmO8F/qeOp4MIRpu6nkJQxzfqPQt
         JXW/qJc7x7RMiYWDOmiARskzNHjYgW3JvrTya0hS1+tc4HS0omXLu5oeShbgbZq0GA5T
         OY3W7nI0lJqGseVZYR2AA7t21yjXrA4WJo0FgxKUJ74pjbWK99csAuVA/cfRT0PGqZ1E
         /aGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686154477; x=1688746477;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZHS3RgPrEuzUDOPW9f757i2RQxMltNXmjLxDojTeMZ0=;
        b=K5nnCxHkvKsPhWwHYuYrpwzvyqTFNmbQXBtDut6yAaOEQO173g7KEYSN66DfDfiJ5A
         1NevcZmqpNIyJuAu8xY/fCDmfm+QdLyP5yoVmVei9wzDhQXuvYvpFtC/G8N1kusffgRO
         NMSkHbun/6WZh3J+GwdhIH7jnOg88USXO7WTz7Bae0CMdldYwTPoQLIJfpuwUgG7R+wg
         w2CCFgCSLKhA+QdDSVofLbK4KhOJUhUIot7Y379Z8hRj9w4YDphd2smL2TraLv4PPvBe
         KkxKnkdb1uNGd7Bikjdl9P++UwXkN/x9KfAgBOrDFLq7NRXd9iDHe41gsf7pe8xdxTfQ
         YUeA==
X-Gm-Message-State: AC+VfDx1KeQfPTk2T5NPeh+okOhZgiJ+Dw+vDzNdi4vZyPQkQssKrq29
	8YBhb3rTTg89HzjNJDD3RyE=
X-Google-Smtp-Source: ACHHUZ7mza0Tt0AO/vqdmSyALgrQGbzSrQ4ZtS89pDGCVilrpEc79skf0Cge4rR+0FB0WWGlHUMX2w==
X-Received: by 2002:a2e:9ec3:0:b0:2b1:bfe7:457b with SMTP id h3-20020a2e9ec3000000b002b1bfe7457bmr2281795ljk.13.1686154477071;
        Wed, 07 Jun 2023 09:14:37 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id y2-20020a2e95c2000000b002b161e6c7basm2240207ljh.108.2023.06.07.09.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 09:14:36 -0700 (PDT)
Message-ID: <45fac5ac0874163031b46388d65de194ed6f27e6.camel@gmail.com>
Subject: Re: [RFC bpf-next 1/8] btf: add kind metadata encoding to UAPI
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yhs@meta.com>, Toke
 =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@kernel.org>, Alexei
 Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Quentin Monnet
 <quentin@isovalent.com>, Mykola Lysenko <mykolal@fb.com>, bpf
 <bpf@vger.kernel.org>
Date: Wed, 07 Jun 2023 19:14:34 +0300
In-Reply-To: <e58d3ec4-dcac-48b8-c6c2-63d131d967d8@meta.com>
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

On Wed, 2023-06-07 at 08:29 -0700, Yonghong Song wrote:
>=20
> On 6/7/23 4:55 AM, Eduard Zingerman wrote:
> > On Tue, 2023-06-06 at 13:30 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wro=
te:
> > [...]
> > >=20
> > > As for bumping the version number, I don't think it's a good idea to
> > > deliberately break compatibility this way unless it's absolutely
> > > necessary. With "absolutely necessary" meaning "things will break in
> > > subtle ways in any case, so it's better to make the breakage obvious"=
.
> > > But it libbpf is not checking the version field anyway, that becomes
> > > kind of a moot point, as bumping it doesn't really gain us anything,
> > > then...
> >=20
> > It seems to me that in terms of backward compatibility, the ability to
> > specify the size for each kind entry is more valuable than the
> > capability to add new BTF kinds:
> > - The former allows for extending kind records in
> >    a backward-compatible manner, such as adding a function address to
> >    BTF_KIND_FUNC.
>=20
> Eduard, the new proposal is to add new kind, e.g., BTF_KIND_KFUNC, which
> will have an 'address' field. BTF_KIND_KFUNC is for kernel functions.
> So we will not have size compatibility issue for BTF_KIND_FUNC.

Well, actually this might be a way to avoid BTF_KIND_KFUNC :)
What I wanted to say is that any use of this feature leads to
incompatibility with current BTF parsers, as either size of existing
kinds would be changed or a new kind with unknown size would be added.
It seems to me that this warrants version bump (or some other way to
signal existing parsers that format is incompatible).

>=20
> > - The latter is much more fragile. Types refer to each other,
> >    compatibility is already lost once a new "unknown" tag is introduced
> >    in a type chain.
> >=20
> > However, changing the size of existing BTF kinds is itself a
> > backward-incompatible change. Therefore, a version bump may be
> > warranted in this regard.


