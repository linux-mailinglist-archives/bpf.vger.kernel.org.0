Return-Path: <bpf+bounces-1978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66349725289
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 05:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90401C20C06
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 03:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2340812;
	Wed,  7 Jun 2023 03:47:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC6F7C
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 03:47:00 +0000 (UTC)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C87519BA
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 20:46:58 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230607034654epoutp0191cc35ad8bef99f909b16a2697ce9de0~mQ8LbwnSi2884628846epoutp01s
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 03:46:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230607034654epoutp0191cc35ad8bef99f909b16a2697ce9de0~mQ8LbwnSi2884628846epoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1686109614;
	bh=k1m+RlQQFeNCzyiUnh1J/FXLYlXA+3gMhUZrUrNfHKY=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=vOZcK6YnxdMv8N9V6FKPwaz/pfIrY2xknH35x0oJhHC4abSXQCIgsFjHlB4a0U+wr
	 /yVarAlrZv6iiDyXAhII370fGFPC/ShPrqnWv48fE3gIFztF3dAIJBFH2kKlXZ/cew
	 1jYhIsftQxeXyX6YcTOiizvzUeELnsT8cSS9uyWk=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20230607034653epcas5p3c0bf8899b9872834d9d7152e9c054909~mQ8KyupoW1388913889epcas5p3o;
	Wed,  7 Jun 2023 03:46:53 +0000 (GMT)
X-AuditID: b6c32a4b-56fff70000013ffc-9b-647ffdad6277
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	15.29.16380.DADFF746; Wed,  7 Jun 2023 12:46:53 +0900 (KST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: [PATCH v4 2/3] bpf: make bpf_dump_raw_ok() based on
 CONFIG_KALLSYMS
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From: Maninder Singh <maninder1.s@samsung.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC: "ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "andrii@kernel.org" <andrii@kernel.org>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "song@kernel.org"
	<song@kernel.org>, "yhs@fb.com" <yhs@fb.com>, "kpsingh@kernel.org"
	<kpsingh@kernel.org>, "sdf@google.com" <sdf@google.com>, "haoluo@google.com"
	<haoluo@google.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>, "boqun.feng@gmail.com"
	<boqun.feng@gmail.com>, "vincenzopalazzodev@gmail.com"
	<vincenzopalazzodev@gmail.com>, "ojeda@kernel.org" <ojeda@kernel.org>,
	"jgross@suse.com" <jgross@suse.com>, "brauner@kernel.org"
	<brauner@kernel.org>, "michael.christie@oracle.com"
	<michael.christie@oracle.com>, "samitolvanen@google.com"
	<samitolvanen@google.com>, "glider@google.com" <glider@google.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "keescook@chromium.org"
	<keescook@chromium.org>, "stephen.s.brennan@oracle.com"
	<stephen.s.brennan@oracle.com>, "alan.maguire@oracle.com"
	<alan.maguire@oracle.com>, "pmladek@suse.com" <pmladek@suse.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, Onkarnath
	<onkarnath.1@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <CAEf4BzYavyL431eA_HZ-X8+wTeO4Cyt7tGDUbPB0yqPru=ZUSw@mail.gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230607034028epcms5p8ed013806c42bd79b76368ac015a7b6ba@epcms5p8>
Date: Wed, 07 Jun 2023 09:10:28 +0530
X-CMS-MailID: 20230607034028epcms5p8ed013806c42bd79b76368ac015a7b6ba
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1DTZRzH7/n+2Ma80ZcNx6MEBScZyzYSgoercNd18K1MgvMyEy4XfA+X
	Y+42l2J3OYT0JDApkTkM4QIZAwH5UZOBq7ELMPEKro61IEh2GDAREG3Sjm6MZf+97v287/N+
	3p/7cHD+ZdZmjlx5mFErZYpoFpf4pi829vkr3uO5ccbhZDRqKySQtamSRA9XqnB03+Nko+bO
	Qgwt2ftZaLZvEaCvax/g6NRCL45s/VY2uujYjk6YjRiynzPg6OZn+Wj6ehmGRrovslDz6UYS
	jZ51AeT9YpREjZcaADKW3iNRf9l3GFq9vUyieqObRMN/zxKov8HLQl779xiaerTIQmeGMtGd
	Oj2QRtJVup8JurzoLpu+Zhhj0zXtWrrY7ibpDqOILhkdxul202kWXaurwOkF128EfabTBOjW
	zl8Ieqk98m3ee9yXcxmF/CNGLUnZzz3grKtkq9wxR3v1LlwHqreUgCAOpBLgOec/oARwOXzK
	AuDJmlWsBHA4PCoEes0Cn0dAZcKVAQPmYz4VBX/SNwOfRUDFwUddz/pkFiWGpu4ewsehlAR2
	fL5I+EbilJMLr5gusPxZPKg/5SL8HA6/begCPg6iMuBUqYft1zdCR5P7P57/4RLwcyj8dHwI
	93MInPBY1vUnYVNH2frMj6Fr9hbLFwypYgCvWwKmJNhaZ1obyqPeggOtJtLHBBUD690OzO95
	DXZMPlxjnHoOXq6dxX0lcSoWtnZL/JYIWHGjZd0SDMtWprBAL3N1gGNgsaONDHRcWlhY/xsN
	vdM9bP+edRhsN7ZgZ8HThserNvwv2fA4uQbgJrCJUWny8xjNi6p4JXNErJHla7TKPHHOofx2
	sHbKojfN4M+Je2IbwDjABiAHjw7lfbjjeC6flysrOMaoD72v1ioYjQ2Ec4joMN7WVwZz+FSe
	7DBzkGFUjDrwinGCNuuwhOWTaUxPDa+gqmhg21c//iGkC9N2H7NO2mTZGdPjc6IZbqz+V67G
	1mvcmEXtG7u/f+e8ta3iTsZk2LZ66apUjcLYeJRwR4J8ZOip0qKU14WEJ86zK2WPXCWNt89E
	ujXadMUHln3MhJxM3kJgfFOVKVNxBG4YyLEOVt5u2x1xdFdaohlTvnT+VbO95PyXSddSgxOB
	XiQGY0NR87JnRpzvtKYLBMGpWcLhiKWuxKtzezbM9AqXDyaL5/YOi1u23g0pkJQXhkhIW7a0
	Oh1axk09SY6+TQlvpE4Whr8b9IQuM3tQOmcXPIj/ZO/Om7fK/7pxQbldmxSedfXE742y4mhC
	c0D2gghXa2T/AsAt9Do5BAAA
X-CMS-RootMailID: 20230606042819epcas5p4f0601efb42d59007cba023c73fa0624a
References: <CAEf4BzYavyL431eA_HZ-X8+wTeO4Cyt7tGDUbPB0yqPru=ZUSw@mail.gmail.com>
	<20230606042802.508954-1-maninder1.s@samsung.com>
	<20230606042802.508954-2-maninder1.s@samsung.com>
	<CGME20230606042819epcas5p4f0601efb42d59007cba023c73fa0624a@epcms5p8>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Andrii Nakryiko,

>>
>> bpf_dump_raw_ok() depends on kallsyms_show_value() and we already
>> have a false definition for the =21CONFIG_KALLSYMS case. But we'll
>> soon expand on kallsyms_show_value() and so to make the code
>> easier to follow just provide a direct =21CONFIG_KALLSYMS definition
>> for bpf_dump_raw_ok() as well.
>
> I'm sorry, I'm failing to follow the exact reasoning about
> simplification. It seems simpler to have
>=20
> static inline bool kallsyms_show_value(const struct cred *cred)
> =7B
> =C2=A0=20=C2=A0=20return=20false;=0D=0A>=20=7D=0D=0A>=20=0D=0A>=20and=20c=
ontrol=20it=20from=20kallsyms-related=20internal=20header,=20rather=20than=
=0D=0A>=20adding=20CONFIG_KALLSYMS=20ifdef-ery=20to=20include/linux/filter.=
h=20and=0D=0A>=20redefining=20that=20=60return=20false=60=20decision.=20Wha=
t=20if=20in=20the=20future=20we=0D=0A>=20decide=20that=20if=20=21CONFIG_KAL=
LSYMS=20it's=20ok=20to=20show=20raw=20addresses,=20now=0D=0A>=20we'll=20hav=
e=20to=20remember=20to=20update=20it=20in=20two=20places.=0D=0A>=20=0D=0A>=
=20Unless=20I'm=20missing=20some=20other=20complications?=0D=0A>=20=0D=0A=
=0D=0APatch=203/3=20does=20the=20same,=20it=20extends=20functionality=20of=
=20kallsyms_show_value()=0D=0Ain=20case=20of=20=20=21CONFIG_KALLSYMS.=0D=0A=
=0D=0AAll=20other=20users=20likes=20modules=20code,=20kprobe=20codes=20are=
=20using=20this=20API=0D=0Afor=20sanity/permission,=20and=20then=20prints=
=20the=20address=20like=20below:=0D=0A=0D=0Astatic=20int=20kprobe_blacklist=
_seq_show(struct=20seq_file=20*m,=20void=20*v)=0D=0A=7B=0D=0A...=0D=0A=20=
=20=20=20=20=20=20=20if=20(=21kallsyms_show_value(m->file->f_cred))=0D=0A=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20seq_printf(m,=20=220x%px-0x=
%px=5Ct%ps=5Cn=22,=20NULL,=20NULL,=0D=0A=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20(void=20*)ent->start_addr);=
=0D=0A=20=20=20=20=20=20=20=20else=0D=0A=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20seq_printf(m,=20=220x%px-0x%px=5Ct%ps=5Cn=22,=20(void=20*)en=
t->start_addr,=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20(void=20*)ent->end_addr,=20(void=20*)ent->start_=
addr);=0D=0A..=0D=0A=7D=0D=0A=0D=0Aso=20there=20will=20be=20no=20issues=20i=
f=20we=20move=20kallsyms_show_value()=20out=20of=20KALLSYMS=20dependency.=
=0D=0Aand=20these=20codes=20will=20work=20in=20case=20of=20=21KALLSYMS=20al=
so.=0D=0A=0D=0Abut=20BPF=20code=20logic=20was=20complex=20and=20seems=20thi=
s=20API=20was=20used=20as=20checking=20for=20whether=20KALLSYMS=20is=0D=0Ae=
nabled=20or=20not=20as=20per=20comment=20in=20bpf_dump_raw_ok():=0D=0A=0D=
=0A/*=0D=0A=20*=20Reconstruction=20of=20call-sites=20is=20dependent=20on=20=
kallsyms,=0D=0A=20*=20thus=20make=20dump=20the=20same=20restriction.=0D=0A=
=20*/=0D=0A=0D=0Aalso=20as=20per=20below=20code:=20=0D=0A(we=20were=20not=
=20sure=20whether=20BPF=20will=20work=20or=20not=20with=20patch=203/3=20bec=
ause=20of=20no=20expertise=20on=20BPF=20code,=0D=0Aso=20we=20keep=20the=20b=
ehaviour=20same)=0D=0A=0D=0A=20=20=20=20=20=20=20if=20(ulen)=20=7B=0D=0A=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20if=20(bpf_dump_raw_ok(file->f_=
cred))=20=7B=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20unsigned=20long=20ksym_addr;=0D=0A=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20u64=20__user=20*user_ksyms;=
=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20u32=20i;=0D=0A=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20/*=20copy=20the=20address=20of=20the=20kernel=20symbol=
=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20*=20corresponding=20to=20each=20function=0D=0A=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20*/=0D=0A=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20ulen=20=3D=20mi=
n_t(u32,=20info.nr_jited_ksyms,=20ulen);=0D=0A=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20user_ksyms=20=3D=20u64_to_user=
_ptr(info.jited_ksyms);=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20if=20(prog->aux->func_cnt)=20=7B=0D=0A=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20for=20(i=20=3D=200;=20i=20<=20ulen;=20i++)=20=7B=0D=0A=20=20=20=
...=0D=0A=20=20=20=7D=0D=0A=20=20=20=0D=0Aearlier=20conversation=20for=20th=
is=20change:=0D=0Ahttps://lkml.org/lkml/2022/4/13/326=0D=0A=0D=0Ahere=20Pet=
r=20CC'ed=20BPF=20maintainers=20to=20know=20their=20opinion=20whether=20BPF=
=20code=20can=20work=20with=20patch=203/3,=0D=0Aif=20not=20then=20we=20need=
=20this=20patch.=0D=0A=0D=0AThanks,=0D=0AManinder=20Singh

