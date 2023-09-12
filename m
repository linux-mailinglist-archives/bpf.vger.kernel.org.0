Return-Path: <bpf+bounces-9780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE15879D8FC
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 20:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4259C281FA1
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 18:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBD6A920;
	Tue, 12 Sep 2023 18:46:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E5F8F7D
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 18:46:53 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DCF210B;
	Tue, 12 Sep 2023 11:46:52 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5007abb15e9so10282686e87.0;
        Tue, 12 Sep 2023 11:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694544410; x=1695149210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlisdeXG1+0rUkSkUAgCvAV9XfPOwbPjqhW65rxCmzE=;
        b=CAEbrfALnzbh+XzAAJf4dxlOj5+oa7oWeBlsQagEGtgXjDVYfTGaZebQJd6lP3CP6Z
         zB3vO+fyCbVi6OO3OQ+qdiDdAssQ+mWfGjHFIGnoDNVnmKOXTprMuJrVRbn6cjLhSYJP
         eYyTEF0y1JIOFpw/n6NyAuHU6JXubiMEU2vPcOww+d82CH+BRpP3oGTMDZjGyLTIuTO9
         OcIw/lQIx0PN5uSrw6gdWBehxepzS5cWNezFsxcHECrAyQKDvWca7Hp5xDU3/PWZSwYF
         HUlFGJDlegRnTHqaslk9PuRrATUrmIMJR0LCBgxygxMZcsQQm5cHQUuSButzRsmAvfpd
         hoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694544410; x=1695149210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlisdeXG1+0rUkSkUAgCvAV9XfPOwbPjqhW65rxCmzE=;
        b=On9Jg04unQISZQT9eRqEirJDY14qhu35XcTkeet+RwigssB8+ER0lsOVs2Z2PyvXoo
         frU5YhrBp9+SlMUpDqwxl8iVo3ekeKyOZJljwJWIM4yEa/qyICU4IxabaeIG9HiL3jsq
         JOC77ncSwbfsgaek1lQZfBmmDVMU55Flm7vG/ceEb1+lMwXrhH720cPE3I5p+akX6sGR
         ME6F0UFVPAC6Fu4cXu/6in3Y2dsLYE8o529cCP27w8dO426Esa3uXMTVI7ckXBXEIvkX
         ecdTdoY/FjgaupFPuVMmkJYNWtMEZ5oFlt+JgPB/BFjYXv/iv4LdRAZVWprExpBQnqOG
         2mdQ==
X-Gm-Message-State: AOJu0YwN5qAmBUq6wyygbjY1Y8kefHi3iOoPXiBXUq64CSsQd6CgK3bW
	9k8/PymP3u6MjwgeGS0yxh1GxlSO0HRDD5AwPNc=
X-Google-Smtp-Source: AGHT+IFbxAWcMfNx0uoU7+H0U3HIM3YZgkC0rBmwcaxiCx0pAxt/vrzZXYKY85wAvX50xObsDU/thO/XHU9zh2Jy1bw=
X-Received: by 2002:a05:6512:3b83:b0:4fe:7e1f:766a with SMTP id
 g3-20020a0565123b8300b004fe7e1f766amr353954lfv.24.1694544409764; Tue, 12 Sep
 2023 11:46:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230909091646.420163-1-pengdonglin@sangfor.com.cn>
 <20ef8441084c9d5fd54f84987afa77eed7fe148e.camel@gmail.com>
 <e78dc807b54f80fd3db836df08f71c7d2fb33387.camel@gmail.com>
 <CAADnVQL0O_WFYcYQRig7osO0piPdOH2yHkdH0CxCfNV7NkA0Lw@mail.gmail.com> <035ab912d7d6bd11c54c038464795da01dbed2de.camel@gmail.com>
In-Reply-To: <035ab912d7d6bd11c54c038464795da01dbed2de.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 12 Sep 2023 11:46:38 -0700
Message-ID: <CAADnVQLMHUNE95eBXdy6=+gHoFHRsihmQ75GZvGy-hSuHoaT5A@mail.gmail.com>
Subject: Re: [RFC PATCH v2] bpf: Using binary search to improve the
 performance of btf_find_by_name_kind
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Donglin Peng <pengdonglin@sangfor.com.cn>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, dinghui@sangfor.com.cn, 
	huangcun@sangfor.com.cn, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 10:03=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Tue, 2023-09-12 at 09:40 -0700, Alexei Starovoitov wrote:
> > On Tue, Sep 12, 2023 at 7:19=E2=80=AFAM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Tue, 2023-09-12 at 16:51 +0300, Eduard Zingerman wrote:
> > > > On Sat, 2023-09-09 at 02:16 -0700, Donglin Peng wrote:
> > > > > Currently, we are only using the linear search method to find the=
 type id
> > > > > by the name, which has a time complexity of O(n). This change inv=
olves
> > > > > sorting the names of btf types in ascending order and using binar=
y search,
> > > > > which has a time complexity of O(log(n)). This idea was inspired =
by the
> > > > > following patch:
> > > > >
> > > > > 60443c88f3a8 ("kallsyms: Improve the performance of kallsyms_look=
up_name()").
> > > > >
> > > > > At present, this improvement is only for searching in vmlinux's a=
nd
> > > > > module's BTFs, and the kind should only be BTF_KIND_FUNC or BTF_K=
IND_STRUCT.
> > > > >
> > > > > Another change is the search direction, where we search the BTF f=
irst and
> > > > > then its base, the type id of the first matched btf_type will be =
returned.
> > > > >
> > > > > Here is a time-consuming result that finding all the type ids of =
67,819 kernel
> > > > > functions in vmlinux's BTF by their names:
> > > > >
> > > > > Before: 17000 ms
> > > > > After:     10 ms
> > > > >
> > > > > The average lookup performance has improved about 1700x at the ab=
ove scenario.
> > > > >
> > > > > However, this change will consume more memory, for example, 67,81=
9 kernel
> > > > > functions will allocate about 530KB memory.
> > > >
> > > > Hi Donglin,
> > > >
> > > > I think this is a good improvement. However, I wonder, why did you
> > > > choose to have a separate name map for each BTF kind?
> > > >
> > > > I did some analysis for my local testing kernel config and got such=
 numbers:
> > > > - total number of BTF objects: 97350
> > > > - number of FUNC and STRUCT objects: 51597
> > > > - number of FUNC, STRUCT, UNION, ENUM, ENUM64, TYPEDEF, DATASEC obj=
ects: 56817
> > > >   (these are all kinds for which lookup by name might make sense)
> > > > - number of named objects: 54246
> > > > - number of name collisions:
> > > >   - unique names: 53985 counts
> > > >   - 2 objects with the same name: 129 counts
> > > >   - 3 objects with the same name: 3 counts
> > > >
> > > > So, it appears that having a single map for all named objects makes
> > > > sense and would also simplify the implementation, what do you think=
?
> > >
> > > Some more numbers for my config:
> > > - 13241 types (struct, union, typedef, enum), log2 13241 =3D 13.7
> > > - 43575 funcs, log2 43575 =3D 15.4
> > > Thus, having separate map for types vs functions might save ~1.7
> > > search iterations. Is this a significant slowdown in practice?
> >
> > What do you propose to do in case of duplicates ?
> > func and struct can have the same name, but they will have two differen=
t
> > btf_ids. How do we store them ?
> > Also we might add global vars to BTF. Such request came up several time=
s.
> > So we need to make sure our search approach scales to
> > func, struct, vars. I don't recall whether we search any other kinds.
> > Separate arrays for different kinds seems ok.
> > It's a bit of code complexity, but it's not an increase in memory.
>
> Binary search gives, say, lowest index of a thing with name A, then
> increment index while name remains A looking for correct kind.
> Given the name conflicts info from above, 99% of times there would be
> no need to iterate and in very few cases there would a couple of iteratio=
ns.
>
> Same logic would be necessary with current approach if different BTF
> kinds would be allowed in BTF_ID_NAME_* cohorts. I figured that these
> cohorts are mainly a way to split the tree for faster lookups, but
> maybe that is not the main intent.
>
> > With 13k structs and 43k funcs it's 56k * (4 + 4) that's 0.5 Mbyte
> > extra memory. That's quite a bit. Anything we can do to compress it?
>
> That's an interesting question, from the top of my head:
> pre-sort in pahole (re-assign IDs so that increasing ID also would
> mean "increasing" name), shouldn't be that difficult.

That sounds great. kallsyms are pre-sorted at build time.
We should do the same with BTF.
I think GCC can emit BTF directly now and LLVM emits it for bpf progs too,
but since vmlinux and kernel module BTFs will keep being processed
through pahole we don't have to make gcc/llvm sort things right away.
pahole will be enough. The kernel might do 'is it sorted' check
during BTF validation and then use binary search or fall back to linear
when not-sorted =3D=3D old pahole.

