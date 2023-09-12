Return-Path: <bpf+bounces-9769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3102B79D68B
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 18:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BEB21C20C71
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 16:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC6C1C2B;
	Tue, 12 Sep 2023 16:40:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783B21C05
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:40:33 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B246E115;
	Tue, 12 Sep 2023 09:40:32 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bcb89b4767so96476011fa.3;
        Tue, 12 Sep 2023 09:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694536831; x=1695141631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkHo4j2Je41GsmDMW8omOLUe6wtjQHu4mDM0qIbuMqs=;
        b=SedgNbGJUdpouI6Fp0Ew6HIzOhRpclZ1t536iJrJ5p/027mIgoS46IDyhwxxRxpCiQ
         05uI34EFsmLuUkumngG1PHfQZhzqsuMMLnqPRMq/5eBy79dcwX4x+W6GsDgs4fyrjqUT
         g0WgcM5oqqwLbOrOSxdzhnMdbQP3tXwloUA/9WAWu2UcoheNC5+NgQgL72Eon9JPy4za
         0EQ/bH9YIlYwGpW0q9MrVEVES89zgqhqzCKu6E49bmCPYxHEaAipPRPpg8RDhaVo78lA
         dbJnOjruDuifdMB6qcWeUrTaOGmFFpjm3Z9yIAlv/TceOYg+A8Z9ozAeq/4l32Pf087m
         iBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694536831; x=1695141631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IkHo4j2Je41GsmDMW8omOLUe6wtjQHu4mDM0qIbuMqs=;
        b=Ic9yuDlyvFeQSwyryjW0O3FUqOpukwkDdN8UjA4vlI3HmTB7ijsCVpbvaJP8kiBcmg
         k/YvbtV6OXJsaXd8lSnkh+sTJ5/ybTk2/A/lfOCzdP6T4PpdLcp6lO0b1dG8t7jFxyua
         1MtNxmlW7Xi2TbIAPDPu8LG5eevoM9kp1oQlEOH5I6sMwym2Pv3fMilqoEbkOqf4U+bw
         iXEMtiUCiJ+RP3RgjGJPW0KSmTsCAs0KLtWoorxYYPYdkKWyiAE8Ebn8olVgGvHI+mJU
         K+vpbJcI3Ih1uomzRlaZCMPdkvcDSsSO81oQVecEMg+B/LIKEWBc6CDHpbhnhpRCb2rC
         Xm5g==
X-Gm-Message-State: AOJu0Yw9Kc3/Fz9Z2OJKuRXHim9SU2ghfIna+7NILVMn6Z7WwzOkFPTd
	Vw9kylxCSDvXImkak8vAnv+RyCvLnwb/C0T2ofQ=
X-Google-Smtp-Source: AGHT+IFynt4EHyvl4JVYJbIY4c5EoRe2MuajjeTZ9QeAH2lI8pVs1Fx0KXrfntmVS+35oI/W26zJpeKv4zynkNbztCg=
X-Received: by 2002:a05:6512:220d:b0:502:d639:22ed with SMTP id
 h13-20020a056512220d00b00502d63922edmr17122lfu.48.1694536830618; Tue, 12 Sep
 2023 09:40:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230909091646.420163-1-pengdonglin@sangfor.com.cn>
 <20ef8441084c9d5fd54f84987afa77eed7fe148e.camel@gmail.com> <e78dc807b54f80fd3db836df08f71c7d2fb33387.camel@gmail.com>
In-Reply-To: <e78dc807b54f80fd3db836df08f71c7d2fb33387.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 12 Sep 2023 09:40:19 -0700
Message-ID: <CAADnVQL0O_WFYcYQRig7osO0piPdOH2yHkdH0CxCfNV7NkA0Lw@mail.gmail.com>
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

On Tue, Sep 12, 2023 at 7:19=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2023-09-12 at 16:51 +0300, Eduard Zingerman wrote:
> > On Sat, 2023-09-09 at 02:16 -0700, Donglin Peng wrote:
> > > Currently, we are only using the linear search method to find the typ=
e id
> > > by the name, which has a time complexity of O(n). This change involve=
s
> > > sorting the names of btf types in ascending order and using binary se=
arch,
> > > which has a time complexity of O(log(n)). This idea was inspired by t=
he
> > > following patch:
> > >
> > > 60443c88f3a8 ("kallsyms: Improve the performance of kallsyms_lookup_n=
ame()").
> > >
> > > At present, this improvement is only for searching in vmlinux's and
> > > module's BTFs, and the kind should only be BTF_KIND_FUNC or BTF_KIND_=
STRUCT.
> > >
> > > Another change is the search direction, where we search the BTF first=
 and
> > > then its base, the type id of the first matched btf_type will be retu=
rned.
> > >
> > > Here is a time-consuming result that finding all the type ids of 67,8=
19 kernel
> > > functions in vmlinux's BTF by their names:
> > >
> > > Before: 17000 ms
> > > After:     10 ms
> > >
> > > The average lookup performance has improved about 1700x at the above =
scenario.
> > >
> > > However, this change will consume more memory, for example, 67,819 ke=
rnel
> > > functions will allocate about 530KB memory.
> >
> > Hi Donglin,
> >
> > I think this is a good improvement. However, I wonder, why did you
> > choose to have a separate name map for each BTF kind?
> >
> > I did some analysis for my local testing kernel config and got such num=
bers:
> > - total number of BTF objects: 97350
> > - number of FUNC and STRUCT objects: 51597
> > - number of FUNC, STRUCT, UNION, ENUM, ENUM64, TYPEDEF, DATASEC objects=
: 56817
> >   (these are all kinds for which lookup by name might make sense)
> > - number of named objects: 54246
> > - number of name collisions:
> >   - unique names: 53985 counts
> >   - 2 objects with the same name: 129 counts
> >   - 3 objects with the same name: 3 counts
> >
> > So, it appears that having a single map for all named objects makes
> > sense and would also simplify the implementation, what do you think?
>
> Some more numbers for my config:
> - 13241 types (struct, union, typedef, enum), log2 13241 =3D 13.7
> - 43575 funcs, log2 43575 =3D 15.4
> Thus, having separate map for types vs functions might save ~1.7
> search iterations. Is this a significant slowdown in practice?

What do you propose to do in case of duplicates ?
func and struct can have the same name, but they will have two different
btf_ids. How do we store them ?
Also we might add global vars to BTF. Such request came up several times.
So we need to make sure our search approach scales to
func, struct, vars. I don't recall whether we search any other kinds.
Separate arrays for different kinds seems ok.
It's a bit of code complexity, but it's not an increase in memory.
With 13k structs and 43k funcs it's 56k * (4 + 4) that's 0.5 Mbyte
extra memory. That's quite a bit. Anything we can do to compress it?
Folks requested vmlinux BTF to be a module, so it's loaded on demand.
BTF memory consumption is a concern to many.
I think before we add these per-kind search arrays we better make
BTF optional as a module.

