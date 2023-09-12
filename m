Return-Path: <bpf+bounces-9771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D343179D71D
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 19:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1921C20DBD
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 17:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61754443E;
	Tue, 12 Sep 2023 17:03:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E5E1C04
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 17:03:45 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5830C10EB;
	Tue, 12 Sep 2023 10:03:44 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-52a4737a08fso7426831a12.3;
        Tue, 12 Sep 2023 10:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694538222; x=1695143022; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E8/azAKBlYwgKiN3HC5+jewHHPRjYUqWu2uxWYjHjA8=;
        b=jJ/EXvqQUl3Jj+y8/MSkN9RXOQGd392Rbc8QyvthI0d1HhAy+I/Z8dj9gaBlzK/BOT
         aSMabSyuW6kYLAq6AwjffPTqIxYOkaO+c4j/gOnL9om9sDvyCBeLWJjWbvbYFXRSql6g
         mbmtxZ8rfTtrD4Q6HKzvTR0UgxxtpYQSLhzlxONcG8XlNZuXVBu2ym4DPO9NvncSewpE
         QyUvc6sXYzFGcd38ScLA84HQN9/lHmHASHxIG4u36EiHkwEDy2syLCyVyRHKJqfjnN+R
         MYNZvASHYt3zU0vVyw1U4a0YrGF5UCkjxhqXwKMf+M2mJgtEs4nHOHI+NHFMzB3lZRp8
         Q+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694538222; x=1695143022;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E8/azAKBlYwgKiN3HC5+jewHHPRjYUqWu2uxWYjHjA8=;
        b=h3mAsxYiouyDG7qNWkNgPTmZgd0j1hSUygdrjdnr/eK8WpwEMt1gLnnaIi4xgQ0ex7
         PxeUovNw1G98aGAT0JdjxjXRafL5SvCXMdymAR7MOs4cB+bcojaDp+WyE8MEe64nHDyC
         Kbe9/kQeKfi6N/3hGiwNl2hwkRlRwY7Qvnl7TjgUxznwW/nzu8afkTi1c0ZjFwqqV78h
         RPMrfj/W504jrCLQO7VjTThUWOBlggQTFc6vlB0lz7NdFT8GBD8imCbAR31+ghRdUteg
         YbZhdspKDEh4LraIAhGyM8QMi+1QWQ1vOStoEgHnsNkRyReDYMyM+h5eESHOcPpg8PMV
         xIbg==
X-Gm-Message-State: AOJu0YxfuJSMlBBoCvkbgvuQjlfwerP1iDgCwsBvtmAiQ2wl29D+AyVc
	XwYPXcY+quyLtYaWzMmUJJM=
X-Google-Smtp-Source: AGHT+IGnaJLjpC1NG637CzbLV0zu88vYZZ0142booqQSd22ZJqBp5vcf7hmYTCmkflh3zF/TYS53RQ==
X-Received: by 2002:aa7:d517:0:b0:52f:6641:4ecd with SMTP id y23-20020aa7d517000000b0052f66414ecdmr158665edq.37.1694538222011;
        Tue, 12 Sep 2023 10:03:42 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id w7-20020aa7d287000000b0052a063e52b8sm6150573edq.83.2023.09.12.10.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 10:03:41 -0700 (PDT)
Message-ID: <035ab912d7d6bd11c54c038464795da01dbed2de.camel@gmail.com>
Subject: Re: [RFC PATCH v2] bpf: Using binary search to improve the
 performance of btf_find_by_name_kind
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Donglin Peng <pengdonglin@sangfor.com.cn>, Martin KaFai Lau
 <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, Song Liu
 <song@kernel.org>, Yonghong Song <yhs@fb.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
 dinghui@sangfor.com.cn, huangcun@sangfor.com.cn, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Date: Tue, 12 Sep 2023 20:03:40 +0300
In-Reply-To: <CAADnVQL0O_WFYcYQRig7osO0piPdOH2yHkdH0CxCfNV7NkA0Lw@mail.gmail.com>
References: <20230909091646.420163-1-pengdonglin@sangfor.com.cn>
	 <20ef8441084c9d5fd54f84987afa77eed7fe148e.camel@gmail.com>
	 <e78dc807b54f80fd3db836df08f71c7d2fb33387.camel@gmail.com>
	 <CAADnVQL0O_WFYcYQRig7osO0piPdOH2yHkdH0CxCfNV7NkA0Lw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-09-12 at 09:40 -0700, Alexei Starovoitov wrote:
> On Tue, Sep 12, 2023 at 7:19=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Tue, 2023-09-12 at 16:51 +0300, Eduard Zingerman wrote:
> > > On Sat, 2023-09-09 at 02:16 -0700, Donglin Peng wrote:
> > > > Currently, we are only using the linear search method to find the t=
ype id
> > > > by the name, which has a time complexity of O(n). This change invol=
ves
> > > > sorting the names of btf types in ascending order and using binary =
search,
> > > > which has a time complexity of O(log(n)). This idea was inspired by=
 the
> > > > following patch:
> > > >=20
> > > > 60443c88f3a8 ("kallsyms: Improve the performance of kallsyms_lookup=
_name()").
> > > >=20
> > > > At present, this improvement is only for searching in vmlinux's and
> > > > module's BTFs, and the kind should only be BTF_KIND_FUNC or BTF_KIN=
D_STRUCT.
> > > >=20
> > > > Another change is the search direction, where we search the BTF fir=
st and
> > > > then its base, the type id of the first matched btf_type will be re=
turned.
> > > >=20
> > > > Here is a time-consuming result that finding all the type ids of 67=
,819 kernel
> > > > functions in vmlinux's BTF by their names:
> > > >=20
> > > > Before: 17000 ms
> > > > After:     10 ms
> > > >=20
> > > > The average lookup performance has improved about 1700x at the abov=
e scenario.
> > > >=20
> > > > However, this change will consume more memory, for example, 67,819 =
kernel
> > > > functions will allocate about 530KB memory.
> > >=20
> > > Hi Donglin,
> > >=20
> > > I think this is a good improvement. However, I wonder, why did you
> > > choose to have a separate name map for each BTF kind?
> > >=20
> > > I did some analysis for my local testing kernel config and got such n=
umbers:
> > > - total number of BTF objects: 97350
> > > - number of FUNC and STRUCT objects: 51597
> > > - number of FUNC, STRUCT, UNION, ENUM, ENUM64, TYPEDEF, DATASEC objec=
ts: 56817
> > >   (these are all kinds for which lookup by name might make sense)
> > > - number of named objects: 54246
> > > - number of name collisions:
> > >   - unique names: 53985 counts
> > >   - 2 objects with the same name: 129 counts
> > >   - 3 objects with the same name: 3 counts
> > >=20
> > > So, it appears that having a single map for all named objects makes
> > > sense and would also simplify the implementation, what do you think?
> >=20
> > Some more numbers for my config:
> > - 13241 types (struct, union, typedef, enum), log2 13241 =3D 13.7
> > - 43575 funcs, log2 43575 =3D 15.4
> > Thus, having separate map for types vs functions might save ~1.7
> > search iterations. Is this a significant slowdown in practice?
>=20
> What do you propose to do in case of duplicates ?
> func and struct can have the same name, but they will have two different
> btf_ids. How do we store them ?
> Also we might add global vars to BTF. Such request came up several times.
> So we need to make sure our search approach scales to
> func, struct, vars. I don't recall whether we search any other kinds.
> Separate arrays for different kinds seems ok.
> It's a bit of code complexity, but it's not an increase in memory.

Binary search gives, say, lowest index of a thing with name A, then
increment index while name remains A looking for correct kind.
Given the name conflicts info from above, 99% of times there would be
no need to iterate and in very few cases there would a couple of iterations=
.

Same logic would be necessary with current approach if different BTF
kinds would be allowed in BTF_ID_NAME_* cohorts. I figured that these
cohorts are mainly a way to split the tree for faster lookups, but
maybe that is not the main intent.

> With 13k structs and 43k funcs it's 56k * (4 + 4) that's 0.5 Mbyte
> extra memory. That's quite a bit. Anything we can do to compress it?

That's an interesting question, from the top of my head:
pre-sort in pahole (re-assign IDs so that increasing ID also would
mean "increasing" name), shouldn't be that difficult.

> Folks requested vmlinux BTF to be a module, so it's loaded on demand.
> BTF memory consumption is a concern to many.
> I think before we add these per-kind search arrays we better make
> BTF optional as a module.


