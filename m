Return-Path: <bpf+bounces-58752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721D4AC1530
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 22:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C31D16BEFB
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 20:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4CA1DF246;
	Thu, 22 May 2025 20:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMi2i/4C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98FF7482;
	Thu, 22 May 2025 20:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747944195; cv=none; b=mTw7gy2Hi8DSoMSALWrSXO25VGfZm8T3f+hUTSDO6QT/UrCrjpeqSSrHS/rLpjwxho8H3/+5yzBhU+FAC5OC5sS5PpMbYE7liepIJZwdhY2UWfWyMMmbimpow61rgAnJ9iTj3xUzHYPsv4ExnSN14eHXF2GSmWo0bDRLb8NHauc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747944195; c=relaxed/simple;
	bh=NwMSlcLfrSRhutdLjYTifiPS06af95pgUqjQUWhFMYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dClJ3AhyuiII6tZcyz2DTeHSXaIfdXH5qtFZCQAtzpPfNVEX4zFgHazFs4c0Ajdwb+8PC/YDoW8brfGiF+kRHQ/5R8/zIgShSmIDHwMUt7oi7KfhZJ+u2YutxiAAWcI3asdbIrS0i5w9eF+bCgfxtKnZWJXj7u0W5rEb68SCllM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMi2i/4C; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-30820167b47so216894a91.0;
        Thu, 22 May 2025 13:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747944193; x=1748548993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAdJzVm3ckUGYbOTwm87Nrbqr6uFTL/pYXC4+IrzeYQ=;
        b=UMi2i/4CSQSWlWSwO0KU4UzX39gXSGTifnbE0iqaiqtSgYLH0jbD3tXeoRMrZaEEEU
         wRqpD2hse5CPcuJEAqr3HUAmjNh6n0T0nrrscpSZdtwfff4mOmpk1tBim1lAnWn488fl
         cOWiCws7PCB7uER5U+SMIKN9v5B7XyO7bIO2V/CSwJTgkyYptv9wEb0676PT2GY1w9Pm
         v2Pn0mNF3/Nzi+oxUDOZ2WrENgMKBE76h6jQub1DikxdesBAODBF0sSObFca9H26FYzk
         o8xKY9CK4qcLcuiJg1IBXlR45uH+JFSXvnCFMDHJYeReTaA6LppA5irshvDHsNEt0UAn
         /jlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747944193; x=1748548993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAdJzVm3ckUGYbOTwm87Nrbqr6uFTL/pYXC4+IrzeYQ=;
        b=xHZ0sZcCEGPBC/KVbpHEhWWMnJVWDXkcdUU/jkSlIU/R5up2CpUiPDfyPBRuIJTx0Y
         9K2dlxTfWxKcxlM07/8Uf4zvwZilVkIKJxN1GTO+Ifk5lRODnybw9AzAUxa3MesptLwV
         87HtEXbHVEqyouD6vHJGM4TFUE2NNNGUu6B/8srALVFbkUuIiWphJmlcg874NEwZgKja
         lApWzi1N3d2KjIMZOrgbSAVMA+chyc0AagdBtUNQge6eEQooCk9ZBLRXwO279NiEnmdV
         lQIko1m1Ps2eTSMbrkeFeazf3AFZ9J880ZtnVBZmjK0izsGIDhgXlP+sBrtPPVO8ZR4b
         qZFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV49SuHjSXTn6TV/HhPv0qChEb7uHAUq6b0QfDHpTeMmS6KlCcYf0WwbN8LVH2Q8S3vxcI=@vger.kernel.org, AJvYcCXVvXditsQEg/afA/CrWXSTUxubymg32PjNx28IuXsNXJGRBQEVGswdV+YF0j9a3OpZ85pMo84kKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwV1E7+PANyZQrdWnXNhaWrktOucAeAP8mbj+rugLnrPHArJipq
	sJeXJwHms4znEWfvN0Eug+RGZj7Rwnji79ElPJk7GBiPZVVqanlHKzqJMOt5qrmDerKUnG3F8VP
	5bVEl/3Kq9sV9n0nJGJtzACS1U+XCbIw=
X-Gm-Gg: ASbGncv/CSfwXlLN2JmrRndJQsrIiAhyVV7FnfyzoM6FkcxczIduPeyTyA2O3kR2AAo
	hjRPNPqMbHO0lTQqg8DwAE1N4EVRFTECfshlqKXJ65ImF2tbsUvmg+ct18nBH2XCZQGNtTAIn/g
	3cEAAFNAuaFTMfkflP5SgnSb4BjHQ3SO5+e/ym04hawYdXA1WL
X-Google-Smtp-Source: AGHT+IFZaeN3HpVHbbkDdhI8b2b/0dHz/flsUtAabB1zm7ZFSAIv7EkRiirvKfdFXiIIeqjBJB56U2fJ+jt0Yd/Vb+8=
X-Received: by 2002:a17:90b:3a48:b0:30e:e9f1:8447 with SMTP id
 98e67ed59e1d1-310e8899a4emr1006092a91.4.1747944192595; Thu, 22 May 2025
 13:03:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416-btf_inline-v1-0-e4bd2f8adae5@meta.com>
 <d39e456b-20ed-48cf-90c0-c0b0b03dabe6@oracle.com> <09366E0A-0819-4C0A-9179-F40F8F46ECE0@meta.com>
In-Reply-To: <09366E0A-0819-4C0A-9179-F40F8F46ECE0@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 May 2025 13:03:00 -0700
X-Gm-Features: AX0GCFtO6pcG3LYXhAsXB4wVxIDWX7xmYAvT9alk62QM_YIVC0urxCv2uI7_jhM
Message-ID: <CAEf4BzZxccvWcGJ06hSnrVh6jJO-gdCLUitc7qNE-2oO8iK+og@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] list inline expansions in .BTF.inline
To: Thierry Treyer <ttreyer@meta.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, 
	"dwarves@vger.kernel.org" <dwarves@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"acme@kernel.org" <acme@kernel.org>, "ast@kernel.org" <ast@kernel.org>, Yonghong Song <yhs@meta.com>, 
	"andrii@kernel.org" <andrii@kernel.org>, "ihor.solodrai@linux.dev" <ihor.solodrai@linux.dev>, 
	Song Liu <songliubraving@meta.com>, Mykola Lysenko <mykolal@meta.com>, Daniel Xu <dlxu@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 10:56=E2=80=AFAM Thierry Treyer <ttreyer@meta.com> =
wrote:
>
> Hello everyone,
>
> Here are the estimates for the different encoding schemes we discussed:
> - parameters' location takes ~1MB without de-duplication,
> - parameters' location shrinks to ~14kB when de-duplicated,
> - instead of de-duplicating the individual locations,
>   de-duplicating functions' parameter lists yields 187kB of locations dat=
a.
>
> We also need to take into account the size of the corresponding funcsec
> table, which starts at 3.6MB. The full details follows:
>
>   1) // params_offset points to the first parameter's location
>      struct fn_info { u32 type_id, offset, params_offset; };
>   2) // param_offsets point to each parameters' location
>      struct fn_info { u32 type_id, offset; u16 param_offsets[proto.arglen=
]; };
>   3) // locations are stored inline, in the funcsec table
>      struct fn_info { u32 type_id, offset; loc inline_locs[proto.arglen];=
 };
>
>   Params encoding             Locations Size   Funcsec Size   Total Size
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   (1) param list, no dedup         1,017,654      5,467,824    6,485,478
>   (1) param list, w/ dedup           187,379      5,467,824    5,655,203
>   (2) param offsets, w/ dedup         14,526      4,808,838    4,823,364

This one is almost as good as (3) below, but fits better into the
existing kind+vlen model where there is a variable number of fixed
sized elements (but locations can still be variable-sized and keep
evolving much more easily). I'd go with this one, unless I'm missing
some important benefit of other representations.

>   (3) param list inline            1,017,654      3,645,216    4,662,870
>
>   Estimated size in bytes of the new .BTF.func_aux section, from a
>   production kernel v6.9. It includes both partially and fully inlined
>   functions in the funcsec tables, with all their parameters, either inli=
ne
>   or in their own sub-section. It does not include type information that
>   would be required to handle fully inlined functions, functions with
>   conflicting name, and functions with conflicting prototypes.
>
>   The deduplicated locations in 2) are small enough to be indexed by a u1=
6.
>
> Storing the locations inline uses the least amount of space. Followed by
> storing inline a list of offsets to the locations. Neither of these
> approaches have fixed size records in funcsec. "param list, w/ dedup" is
> ~1MB larger than inlined locations, but has fixed size records.
>
> In all cases, the funcsec table uses the most space, compared to the
> locations. The size of the `type` sub-section will also grow when we add
> the missing type information for fully inlined functions, functions with
> conflicting name, and functions with conflicting prototypes.
>
> With fixed size records in the funcsec table, we'd get faster lookup by
> sorting by `type_id` or `offset`.  bpftrace could efficiently search the
> lower bound of a `type_id` to instrument all its inline instances.
> Symbolication tools could efficiently search for inline functions at a
> given offset.
>
> However, it would rule out the most efficient encoding.
> How do we want to approach this tradeoff?
>
> > 2. refine the representation of inline info, exploring adding new
> > kind(s) to UAPI btf.h if needed. This would likely mean new APIs in
> > libbpf to add locations and function site info.
>
>
> I currently have a pahole prototype to emit "param list, no dedup" and am
> close to a patch adding FUNCSEC to libbpf. I was wondering if it would ma=
ke
> sense for FUNCSEC to be a DATASEC with its 'kind_flag` set?

Why abuse DATASEC if we are extending BTF with new types anyways? I'd
go with a dedicated FUNCSEC (or FUNCSET, maybe?..)

BTW, Alan, you've been working on self-describing BTF (size per fixed
part of kind + size per vlen items). Any update on that one? Did you
get blocked on it somewhere?

>
> Let me know if you have any questions or have new ideas for the encoding!
>
> Have a great day,
> Thierry
>
>
> > On 19 May 2025, at 13:02, Alan Maguire <alan.maguire@oracle.com> wrote:
> >
> > hi folks
> >
> > I just wanted to try and capture some of the discussion from last week'=
s
> > BPF office hours where we talked about this and hopefully we can
> > together plot a path forward that supports inline representation and
> > helps us fix some other long-standing issues with more complex function
> > representation. If I've missed anything important or if anything looks
> > wrong, please do chime in!
> >
> > In discussing this, we concluded that
> >
> > - separating the complex function representations into a separate .BTF
> > section (.BTF.func_aux or something like it) would be valuable since it
> > means tracers can continue to interact with existing function
> > representations that have a straightforward relationship between their
> > parameters and calling conventions stored in the .BTF section, and can
> > optionally also utilize the auxiliary function information in .BTF.func=
_aux
> >
> > - this gives us a bit more freedom to add new kinds etc to that
> > auxiliary function info, and also to control unauthorized access that
> > might be able to retrieve a function address or other potentially
> > sensitive info from the aux function data
> >
> > - it also means that the only kernel support we would likely initially
> > need to add would be to allow reading of
> > /sys/kernel/btf/vmlinux.func_aux , likely via a dummy module supporting
> > sysfs read.
> >
> > - for modules, we would need to support multi-split BTF, i.e split BTF
> > in .BTF.func_aux in the module that sits atop the .BTF section of the
> > module which in turn sits atop the vmlinux BTF.  Again only userspace
> > and tooling support would likely be needed as a first step. I'm looking
> > at this now and it may require no or minimal code changes to libbpf,
> > just testing of the feature.  bpftool and pahole would need to support =
a
> > means of specifying multiple base BTFs in order, but that seems doable =
too.
> >
> > We were less conclusive on the final form of the representation, but it
> > would ideally help support fully and partially inlined representations
> > and other situations we have today where the calling
> > convention-specified registers and the function parameters do not
> > cleanly line up. Today we leave such representations out of BTF but a
> > location representation would allow us to add them back in. Similarly
> > for functions with the same name but different signatures, having a
> > function address to clarify which signature goes with which site will h=
elp.
> >
> > Again we don't have to solve all these problems at once but having them
> > in mind as we figure out the right form of the representation will help=
.
> >
> > Something along the lines of the variable section where we have triples
> > of <function type id, site address, location BTF id> for each function
> > site will play a role. Again the exact form of the location data is TBD=
,
> > but we can experiment here to maximize compactness. Andrii pointed out =
a
> > BTF kind representation may waste bytes; for example a location will
> > likely not require a name offset string representation. Could be an
> > index into an array of location descriptions perhaps. Would be nice to
> > make use of dedup for locations too, likely within pahole rather than
> > BTF dedup proper. An empirical question is how much dedup will help,
> > likely we will just have to try and see.
> >
> > So based on this I think our next steps are:
> >
> > 1. add address info to pahole; I'm working on a proof-of-concept on thi=
s
> > hope to have a newer version out this week. Address info would be neede=
d
> > for functions that we wish to represent in the aux section as a way of
> > associating a function site with a location representation.
> > 2. refine the representation of inline info, exploring adding new
> > kind(s) to UAPI btf.h if needed. This would likely mean new APIs in
> > libbpf to add locations and function site info.
> > 3. explore multi-split BTF, adding libbpf-related tests for
> > creation/manipulation of split BTF where the base is another split BTF.
> > Multi-split BTF would be needed for module function aux info
> >
> > I'm hoping we can remove any blocks to further progress; task 3 above
> > can be tackled in parallel while we explore vmlinux inline
> > representation (multi-split is only needed for the module case where th=
e
> > aux info is created atop the module split BTF). I'm hoping to have a bi=
t
> > more done on task 1 later this week. So hopefully there's nothing here
> > that impedes making progress on the inline problem.
> >
> > Again if there's anything I've missed above or that seems unclear,
> > please do follow up. It's really positive that we're tackling this issu=
e
> > so I want to make sure that nothing gets in the way of progressing this=
.
> > Thanks again!
> >
> > Alan
>

