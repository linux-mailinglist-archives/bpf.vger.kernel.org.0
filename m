Return-Path: <bpf+bounces-28554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED558BB6F5
	for <lists+bpf@lfdr.de>; Sat,  4 May 2024 00:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C7C1F2567D
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 22:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676F45B1E9;
	Fri,  3 May 2024 22:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChkMQsqV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C095914C
	for <bpf@vger.kernel.org>; Fri,  3 May 2024 22:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714774469; cv=none; b=s1WeXcuf//p4QA/pbFmhh0dB9JCnu/FoSTxiz+MS0jSXmXqhPe/C3a7JbobiFAFp7lH5Zq2SRxvYA07C4LEwbxwzqdi9qhLaMT7NJFTrnA4tUe9EaGo+PFtFyC8/6MZ65tWdGySHnoGtgFDaNngT8kFRuc/YVp1PIR3ABgRrzZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714774469; c=relaxed/simple;
	bh=KY70WDwQfpFGkdGxP2rtEFsFvYC4z2Yf4mdc3zUfYQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ai497L753ZA6LzusQl5iDE/S6V0XpSlWzpQ3Dx33bi4Oi1iyE6EQsU9sVcvg+7TJBa+IxaRZ/rV2p9rELuZUzPqeTXyF6DJIj02FgEeddk/K9bxZHjWzS2kGMGI6eUL2CrFpT2S1Wd3JMICzBYv+BJmznmlZ2ijGzQYPOvLl4Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChkMQsqV; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso96338a12.2
        for <bpf@vger.kernel.org>; Fri, 03 May 2024 15:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714774467; x=1715379267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRTcuUePTK+L8KHntSv+q8ur3hdBoV+7EyENfmK6zXw=;
        b=ChkMQsqVdStpFt7oUSeib+nD9rdY0qfW0wvY67+1px7y+6N/v8UoCxiJDU/BxpcmyG
         BAT43A2jLKiKAB3tTh6nPzm/0POXsf2vjAHo2rzNovtt/9ypggTU+vkV0iZF2SDTZgh7
         /+YNrzgF/+uNZq4PTg9k6gYFF6T0WvpMUImT3Yh9VUCgkWpF0SEIF+PmZwbqYsMzNgTH
         if1DEpbAVt7mP7BtNPzfTHAO6oUuJS2rUFTOLsQW4k2ZSBg0qY1mho6nXLVuMKKjFfw1
         o11TC9Z9MvXXFhwa3+6Arg+hvhfRcr5/TiZT8PclB4wqQ40qINCiR/G2ZfBI6HAUCV8d
         W+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714774467; x=1715379267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRTcuUePTK+L8KHntSv+q8ur3hdBoV+7EyENfmK6zXw=;
        b=ZmyBnzuxt8ZpVxWL2V8Qk6z5NpCRWJgUqx6U1yopT+LIG/iEDDKZPR8zuxVnECm2zl
         j0DIv6m4a1VVD7KGgsw7gyL2VLaZ3kHFV9xnTqfjJ1iPVreVPZ+roFbHq0Nj20Ka8d7w
         J/RgwYxBn0MDMWGnL49uhC5XYz8go+WuRNrH4S9oQYM8Hi+RNz9T6B6eCCagklKPg3UP
         J5n6Xu5SPlVFEHEiEDFjviB3NRfhTmkKkjYCvTTm88N1EKgHZ4nK73MIc9fM5ElnbCie
         7QZu924KfidMQn+KHTsw2VuZ9j2Dyya0/FM85hgBzQINVt/We+ssS+AFnUhJTwM7PQaw
         soWA==
X-Forwarded-Encrypted: i=1; AJvYcCVWAMZYEp9XfYNVJRKdJIrS6EIBKEMyCjgYjQcSZt7mJ38JjmpEhebXJTfrDJf5vDVHF5C7p75Vz3VOBG2CObv7P/BT
X-Gm-Message-State: AOJu0YxE/jYXaxZJnOALraHAw1qUSJtB17lcEEL8StCqgsRnak4BOzUV
	Kl32S2xq113HgBhSlHpmSIE9ZYAHEkfWTD5IifanFY5OLYKJFJuJogipkktnucRwQPv6hAbLsr4
	qeErntDBjrlHglhWgnRC8/Cqzltg=
X-Google-Smtp-Source: AGHT+IHjEULgLwYWCJE4DauEogSBF4oR5uaKvZQBgo8Jmuj5CTB1KTuQZkr2d4c5savgDW3uXzDOI3QvrPeCw4n4Jbc=
X-Received: by 2002:a17:90b:46d0:b0:2a2:cf1d:895c with SMTP id
 jx16-20020a17090b46d000b002a2cf1d895cmr3688151pjb.41.1714774466647; Fri, 03
 May 2024 15:14:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503111836.25275-1-jose.marchesi@oracle.com>
 <6687f49cdd5061202ee112c38614bea091266179.camel@gmail.com> <171a007587c02ff4a8d064c65531fde318c3b4e2.camel@gmail.com>
In-Reply-To: <171a007587c02ff4a8d064c65531fde318c3b4e2.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 3 May 2024 15:14:14 -0700
Message-ID: <CAEf4Bza5cmJK-+tK1QJ-SVUWmTOTOM_3gZQ=9yhynU5vE_wWyg@mail.gmail.com>
Subject: Re: [RFC bpf-next] bpf: avoid clang-specific push/pop attribute
 pragmas in bpftool
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	david.faust@oracle.com, cupertino.miranda@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 2:18=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Fri, 2024-05-03 at 13:36 -0700, Eduard Zingerman wrote:
> > On Fri, 2024-05-03 at 13:18 +0200, Jose E. Marchesi wrote:
> > [...]
> >
> > > This patch modifies bpftool in order to, instead of using the pragmas=
,
> > > define ATTR_PRESERVE_ACCESS_INDEX to conditionally expand to the CO-R=
E
> > > attribute:
> > >
> > >   #ifndef __VMLINUX_H__
> > >   #define __VMLINUX_H__
> > >
> > >   #ifndef BPF_NO_PRESERVE_ACCESS_INDEX
> > >   #define ATTR_PRESERVE_ACCESS_INDEX __attribute__((preserve_access_i=
ndex))
> > >   #else
> > >   #define ATTR_PRESERVE_ACCESS_INDEX
> > >   #endif
> >
> > Nit: maybe swap the branches to avoid double negation?
> >
> > >
> > >   [... type definitions generated from kernel BTF ... ]
> > >
> > >   #undef ATTR_PRESERVE_ACCESS_INDEX
> > >
> > > and then the new btf_dump__dump_type_with_opts is used with options
> > > specifying that we wish to have struct type attributes:
> > >
> > >   DECLARE_LIBBPF_OPTS(btf_dump_type_opts, opts);
> > >   [...]
> > >   opts.record_attrs_str =3D "ATTR_PRESERVE_ACCESS_INDEX";
> > >   [...]
> > >   err =3D btf_dump__dump_type_with_opts(d, root_type_ids[i], &opts);
> > >
> > > This is a RFC because introducing a new libbpf public function
> > > btf_dump__dump_type_with_opts may not be desirable.
> > >
> > > An alternative could be to, instead of passing the record_attrs_str
> > > option in a btf_dump_type_opts, pass it in the global dumper's option
> > > btf_dump_opts:
> > >
> > >   DECLARE_LIBBPF_OPTS(btf_dump_opts, opts);
> > >   [...]
> > >   opts.record_attrs_str =3D "ATTR_PRESERVE_ACCESS_INDEX";
> > >   [...]
> > >   d =3D btf_dump__new(btf, btf_dump_printf, NULL, &opts);
> > >   [...]
> > >   err =3D btf_dump__dump_type(d, root_type_ids[i]);
> > >
> > > This would be less disruptive regarding library API, and an overall
> > > simpler change.  But it would prevent to use the same btf dumper to
> > > dump types with and without attribute definitions.  Not sure if that
> > > matters much in practice.
> > >
> > > Thoughts?
> >
> > I think that generating attributes explicitly is fine.
> >
> > I also think that moving '.record_attrs_str' to 'btf_dump_opts' is pref=
erable,
> > in order to avoid adding new API functions.
>
> On more argument for making it a part of btf_dump_opts is that
> btf_dump__dump_type() walks the chain of dependent types,
> so attribute placement control is not per-type anyways.

And that's very unfortunate, which makes this not a good option, IMO.

>
> I also remembered my stalled attempt to emit preserve_static_offset
> attribute for certain types [1] (need to finish with it).
> There I needed to attach attributes to a dozen specific types.
>
> [1] https://lore.kernel.org/bpf/20231220133411.22978-3-eddyz87@gmail.com/
>
> So, I think that it would be better if '.record_attrs_str' would be a
> callback accepting the name of the type and it's kind. Wdyt?

I think if we are talking about the current API, then extending it
with some pre/post type callback would solve this specific problem
(but even then it feels dirty, because of "this callback is called
after } but before ," sadness). I really dislike callbacks as part of
public APIs like this. It feels like the user has to have control and
the library should provide building blocks.

So how about an alternative view on this problem. What if we add an
API that will sort types in "C type system" order, i.e., it will
return a sequence of BTF type ID + a flag whether it's a full BTF type
definition or forward declaration only for that type. And then,
separately, instead of btf_dump__dump_type() API that emits type *and*
all its dependencies (unless they were already emitted, it's very
stateful), we'll have an analogous API that will emit a full
definition of one isolated btf_type (and no dependencies).

The user will need to add semicolons after each type (and empty lines
and stuff like that, probably), but they will also have control over
appending/prepending any extra attributes and whatnot (or #ifdef
guards).

Also, when we have this API, we'll have all the necessary building
blocks to finally be able to emit only types for module BTF without
duplicated types from vmlinux.h (under assumption that vmlinux.h will
be included before that). Libbpf will return fully sorted type order,
including vmlinux BTF types, but bpftool (or whoever is using this
API) will be smart in ignoring those types and/or emitting just
forward declaration for them.

With the decomposition into sort + emit string representation, it's
now trivial to use in this flexible way.

Thoughts?


>
> [...]

