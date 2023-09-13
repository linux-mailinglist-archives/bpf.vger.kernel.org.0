Return-Path: <bpf+bounces-9906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA3479E9FA
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 15:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85D77281FBF
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 13:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E6E1DDFF;
	Wed, 13 Sep 2023 13:46:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7C23FFE
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 13:46:04 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD32619B6;
	Wed, 13 Sep 2023 06:46:03 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-502e0b7875dso724820e87.0;
        Wed, 13 Sep 2023 06:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694612762; x=1695217562; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=asTT2XBzDAvCymnsddbZfuEFjnNzqFtFMyBqPDTsn2k=;
        b=rkGmj/1wQbn8lfsCNOSUf/LTSOVGRdkIL98JseDbd+Xx29NG0hnZBeZhJYf0/mU8rK
         QtDfFEiDFuH0fLgq+A9ZHaoPO5Z5g69FTPhYpW8LOKcGNXE7pX9jfZRS+YdPk5tpQ/7Z
         HXqrZCCageMrlyXzndN8M87Do8VW5jtL+Al57pclFyE69lFrMotjnjhjES9SNXNV2/aQ
         hwL7x0z+amoKz1t9yJbHrMHzf9pdmkDtnznHXzqxkhxu0zbAYJdiu+BQ94ys6hM3S1s2
         tEvA2kGnQ1Nib0L/MjEHp3UhQ7JE5HwxsL8og0vONpv4lZFZF+I8SkIx7xAeT7DE2g8L
         SgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694612762; x=1695217562;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=asTT2XBzDAvCymnsddbZfuEFjnNzqFtFMyBqPDTsn2k=;
        b=F/nou8Ohb2P2unE1JG1UOwSfteTFU94LYcZ0vXSi2rrL4mGwhu4mptTyntvgytPxON
         OVlM+arXqU276DXb1oKYPiNUgieeFSHMxNhXf/kKMEDlx4EvkMxcxw5b5UZtiIPmWHGd
         NXX31johJYlJrCzw+slPYowzLN2eXhB9l45xV54dNqMqpXCN8B9qr7RV2Td063Hz4DcP
         tEwtu+ajU8puGLYHidXFs1FD0z/oU7422dOl1PWEIs2+9EP0SfZDlz/bIhFxfP6lQNCr
         zm8iWRs3zOyVXsekf9k5Nyoc4eB4FzYXhZ24BG4EcN7W8B50wgST/hfK/qXA3FMGdIK/
         tAVQ==
X-Gm-Message-State: AOJu0YwaAfot8key9dJLwWbT9ACTQQTmN5BoaNkvfu9Hpdizstqqp6ri
	0EsWH+9EcDXzV7CMr8G9sA8=
X-Google-Smtp-Source: AGHT+IHeqTpFDj8gdtbM6wEOs4/ayNLLJSdjfRCoZQZFqxXEeXPY2r3kbGKj3QWKpIBsVc6nLse8nw==
X-Received: by 2002:a05:6512:3d8e:b0:500:bb99:69a9 with SMTP id k14-20020a0565123d8e00b00500bb9969a9mr2310285lfv.64.1694612761027;
        Wed, 13 Sep 2023 06:46:01 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id t26-20020a056402241a00b0052febc781bfsm715340eda.36.2023.09.13.06.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 06:46:00 -0700 (PDT)
Message-ID: <0bef11aa061a425f276a539a47b786ec6b661987.camel@gmail.com>
Subject: Re: [RFC PATCH v2] bpf: Using binary search to improve the
 performance of btf_find_by_name_kind
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, pengdonglin
 <pengdonglin@sangfor.com.cn>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
 Steven Rostedt <rostedt@goodmis.org>,  Masami Hiramatsu
 <mhiramat@kernel.org>, dinghui@sangfor.com.cn, huangcun@sangfor.com.cn, bpf
 <bpf@vger.kernel.org>,  LKML <linux-kernel@vger.kernel.org>
Date: Wed, 13 Sep 2023 16:45:58 +0300
In-Reply-To: <e564b0e9-3497-a133-3094-afefc0cd1f7e@oracle.com>
References: <20230909091646.420163-1-pengdonglin@sangfor.com.cn>
	 <20ef8441084c9d5fd54f84987afa77eed7fe148e.camel@gmail.com>
	 <e78dc807b54f80fd3db836df08f71c7d2fb33387.camel@gmail.com>
	 <CAADnVQL0O_WFYcYQRig7osO0piPdOH2yHkdH0CxCfNV7NkA0Lw@mail.gmail.com>
	 <035ab912d7d6bd11c54c038464795da01dbed2de.camel@gmail.com>
	 <CAADnVQLMHUNE95eBXdy6=+gHoFHRsihmQ75GZvGy-hSuHoaT5A@mail.gmail.com>
	 <5f8d82c3-838e-4d75-bb25-7d98a6d0a37c@sangfor.com.cn>
	 <e564b0e9-3497-a133-3094-afefc0cd1f7e@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-09-13 at 14:34 +0100, Alan Maguire wrote:
> On 13/09/2023 11:32, pengdonglin wrote:
> > On 2023/9/13 2:46, Alexei Starovoitov wrote:
> > > On Tue, Sep 12, 2023 at 10:03=E2=80=AFAM Eduard Zingerman <eddyz87@gm=
ail.com>
> > > wrote:
> > > >=20
> > > > On Tue, 2023-09-12 at 09:40 -0700, Alexei Starovoitov wrote:
> > > > > On Tue, Sep 12, 2023 at 7:19=E2=80=AFAM Eduard Zingerman <eddyz87=
@gmail.com>
> > > > > wrote:
> > > > > >=20
> > > > > > On Tue, 2023-09-12 at 16:51 +0300, Eduard Zingerman wrote:
> > > > > > > On Sat, 2023-09-09 at 02:16 -0700, Donglin Peng wrote:
> > > > > > > > Currently, we are only using the linear search method to fi=
nd the
> > > > > > > > type id
> > > > > > > > by the name, which has a time complexity of O(n). This chan=
ge
> > > > > > > > involves
> > > > > > > > sorting the names of btf types in ascending order and using
> > > > > > > > binary search,
> > > > > > > > which has a time complexity of O(log(n)). This idea was ins=
pired
> > > > > > > > by the
> > > > > > > > following patch:
> > > > > > > >=20
> > > > > > > > 60443c88f3a8 ("kallsyms: Improve the performance of
> > > > > > > > kallsyms_lookup_name()").
> > > > > > > >=20
> > > > > > > > At present, this improvement is only for searching in vmlin=
ux's and
> > > > > > > > module's BTFs, and the kind should only be BTF_KIND_FUNC or
> > > > > > > > BTF_KIND_STRUCT.
> > > > > > > >=20
> > > > > > > > Another change is the search direction, where we search the=
 BTF
> > > > > > > > first and
> > > > > > > > then its base, the type id of the first matched btf_type wi=
ll be
> > > > > > > > returned.
> > > > > > > >=20
> > > > > > > > Here is a time-consuming result that finding all the type i=
ds of
> > > > > > > > 67,819 kernel
> > > > > > > > functions in vmlinux's BTF by their names:
> > > > > > > >=20
> > > > > > > > Before: 17000 ms
> > > > > > > > After:=C2=A0=C2=A0=C2=A0=C2=A0 10 ms
> > > > > > > >=20
> > > > > > > > The average lookup performance has improved about 1700x at =
the
> > > > > > > > above scenario.
> > > > > > > >=20
> > > > > > > > However, this change will consume more memory, for example,
> > > > > > > > 67,819 kernel
> > > > > > > > functions will allocate about 530KB memory.
> > > > > > >=20
> > > > > > > Hi Donglin,
> > > > > > >=20
> > > > > > > I think this is a good improvement. However, I wonder, why di=
d you
> > > > > > > choose to have a separate name map for each BTF kind?
> > > > > > >=20
> > > > > > > I did some analysis for my local testing kernel config and go=
t
> > > > > > > such numbers:
> > > > > > > - total number of BTF objects: 97350
> > > > > > > - number of FUNC and STRUCT objects: 51597
> > > > > > > - number of FUNC, STRUCT, UNION, ENUM, ENUM64, TYPEDEF, DATAS=
EC
> > > > > > > objects: 56817
> > > > > > > =C2=A0=C2=A0 (these are all kinds for which lookup by name mi=
ght make sense)
> > > > > > > - number of named objects: 54246
> > > > > > > - number of name collisions:
> > > > > > > =C2=A0=C2=A0 - unique names: 53985 counts
> > > > > > > =C2=A0=C2=A0 - 2 objects with the same name: 129 counts
> > > > > > > =C2=A0=C2=A0 - 3 objects with the same name: 3 counts
> > > > > > >=20
> > > > > > > So, it appears that having a single map for all named objects=
 makes
> > > > > > > sense and would also simplify the implementation, what do you=
 think?
> > > > > >=20
> > > > > > Some more numbers for my config:
> > > > > > - 13241 types (struct, union, typedef, enum), log2 13241 =3D 13=
.7
> > > > > > - 43575 funcs, log2 43575 =3D 15.4
> > > > > > Thus, having separate map for types vs functions might save ~1.=
7
> > > > > > search iterations. Is this a significant slowdown in practice?
> > > > >=20
> > > > > What do you propose to do in case of duplicates ?
> > > > > func and struct can have the same name, but they will have two
> > > > > different
> > > > > btf_ids. How do we store them ?
> > > > > Also we might add global vars to BTF. Such request came up severa=
l
> > > > > times.
> > > > > So we need to make sure our search approach scales to
> > > > > func, struct, vars. I don't recall whether we search any other ki=
nds.
> > > > > Separate arrays for different kinds seems ok.
> > > > > It's a bit of code complexity, but it's not an increase in memory=
.
> > > >=20
> > > > Binary search gives, say, lowest index of a thing with name A, then
> > > > increment index while name remains A looking for correct kind.
> > > > Given the name conflicts info from above, 99% of times there would =
be
> > > > no need to iterate and in very few cases there would a couple of
> > > > iterations.
> > > >=20
> > > > Same logic would be necessary with current approach if different BT=
F
> > > > kinds would be allowed in BTF_ID_NAME_* cohorts. I figured that the=
se
> > > > cohorts are mainly a way to split the tree for faster lookups, but
> > > > maybe that is not the main intent.
> > > >=20
> > > > > With 13k structs and 43k funcs it's 56k * (4 + 4) that's 0.5 Mbyt=
e
> > > > > extra memory. That's quite a bit. Anything we can do to compress =
it?
> > > >=20
> > > > That's an interesting question, from the top of my head:
> > > > pre-sort in pahole (re-assign IDs so that increasing ID also would
> > > > mean "increasing" name), shouldn't be that difficult.
> > >=20
> > > That sounds great. kallsyms are pre-sorted at build time.
> > > We should do the same with BTF.
> > > I think GCC can emit BTF directly now and LLVM emits it for bpf progs
> > > too,
> > > but since vmlinux and kernel module BTFs will keep being processed
> > > through pahole we don't have to make gcc/llvm sort things right away.
> > > pahole will be enough. The kernel might do 'is it sorted' check
> > > during BTF validation and then use binary search or fall back to line=
ar
> > > when not-sorted =3D=3D old pahole.
> > >=20
> >=20
> > Yeah, I agree and will attempt to modify the pahole and perform a test.
> > Do we need
> > to introduce a new macro to control the behavior when the BTF is not
> > sorted? If
> > it is not sorted, we can use the method mentioned in this patch or use
> > linear
> > search.
> >=20
> >=20
>=20
> One challenge with pahole is that it often runs in parallel mode, so I
> suspect any sorting would have to be done after merging across threads.
> Perhaps BTF deduplication time might be a useful time to re-sort by
> name? BTF dedup happens after BTF has been merged, and a new "sorted"
> btf_dedup_opts option could be added and controlled by a pahole
> option. However dedup is pretty complicated already..

Hi Alan,

libbpf might be the right place to do this, however, I think that it is
also doable in pahole's btf_encoder__encode(), e.g. as follows:
- after a call to btf__dedup():
  - create a sorted by name IDs ordering;
  - create a new BTF object;
  - add records to the new BTF according to the sorted ordering;
  - remap id references while adding;
  - use the new BTF object instead of old one to write BTF output.

I assume that implementation would be similar regardless whether it is
done in pahole or in libbpf.

Thanks,
Eduard

> One thing we should weigh up though is if there are benefits to the
> way BTF is currently laid out. It tends to start with base types,
> and often-encountered types end up being located towards the start
> of the BTF data. For example
>=20
>=20
> [1] INT 'long unsigned int' size=3D8 bits_offset=3D0 nr_bits=3D64 encodin=
g=3D(none)
> [2] CONST '(anon)' type_id=3D1
> [3] VOLATILE '(anon)' type_id=3D1
> [4] ARRAY '(anon)' type_id=3D1 index_type_id=3D21 nr_elems=3D2
> [5] PTR '(anon)' type_id=3D8
> [6] CONST '(anon)' type_id=3D5
> [7] INT 'char' size=3D1 bits_offset=3D0 nr_bits=3D8 encoding=3DSIGNED
> [8] CONST '(anon)' type_id=3D7
> [9] INT 'unsigned int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3D(=
none)
> [10] CONST '(anon)' type_id=3D9
> [11] TYPEDEF '__s8' type_id=3D12
> [12] INT 'signed char' size=3D1 bits_offset=3D0 nr_bits=3D8 encoding=3DSI=
GNED
> [13] TYPEDEF '__u8' type_id=3D14
>=20
> So often-used types will be found quickly, even under linear search
> conditions.
>=20
> When we look at how many lookups by id (which are O(1), since they are
> done via the btf->types[] array) versus by name, we see:
>=20
> $ grep btf_type_by_id kernel/bpf/*.c|wc -l
> 120
> $ grep btf_find_by_nam kernel/bpf/*.c|wc -l
> 15
>=20
> I don't see a huge number of name-based lookups, and I think most are
> outside of the hotter codepaths, unless I'm missing some. All of which
> is to say it would be a good idea to have a clear sense of what will get
> faster with sorted-by-name BTF. Thanks!
>=20
> Alan

