Return-Path: <bpf+bounces-70854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF600BD6DD5
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 02:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9C7C4EA877
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 00:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510BA1C75E2;
	Tue, 14 Oct 2025 00:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYC5o+3p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179591A9F86
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 00:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760400779; cv=none; b=uDY4P33XmVi6SLfeDTzMK4hbGJJx4xihwBQOgZC5Fx5LV72GPTnREZe6ryCDwaXX2joIpnpbjhBCDAWHcP92rkRTsa5ozVVHASuOJxOcNucmJlU7j8LMRNbaciFhxMP5EUUcCtG/pBIHBsP+gTXBYppzkPGxW8GVep3TvAZ/Lwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760400779; c=relaxed/simple;
	bh=fhj4q5a3LiVQAS6kcTUZWVnd8uOlRAzVTfCdkxjri7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WrkxrQygmlesb3zjqN+xIb7VAnBnkICmG7PHHcdcd0HYv53IbCoCk9FHLQuvTI/m6Kt8a9mckX3UfBMZPz4lFQuaX8nshQ4uPBxphLL98EfII1htkE/sgTkvCJtunquGGPXOorRZM+6wEWNzVnswetbr5FJBshG4SqXM1qBgFG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYC5o+3p; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3f2ae6fadb4so5441912f8f.1
        for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 17:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760400776; x=1761005576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhj4q5a3LiVQAS6kcTUZWVnd8uOlRAzVTfCdkxjri7A=;
        b=jYC5o+3p6LKm6ovfAAmgmS2rXiUufy8NxTTuCNnr+ZWGgquDFnabt/HItPQ1/DtekM
         zXfCCLpBhruLmjImIqyvwik97/RGJNYIY0uG0Y4bxA2Bo9BZZUGryznK+Vc+0LnyzqEQ
         I0BllT3fgXYEKZyhoQD33WR2v9Az/cM4902OHzPRMweUK2p1oRPFX1yVE8JvGNdJq1Xv
         1G5O4JWBi6gt2dmQeyqjXk3+Vnfc01qtFz6yc6hU4SM7JsQ7ZzJ9l49v5aOb8QiQ7R6V
         O3XzXuXBX7s7qUcnAuxlW1lXZAl6OWjTcvlWS8CIzFrg4gguix6qWWOFJtyD/aKgJiFo
         rLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760400776; x=1761005576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhj4q5a3LiVQAS6kcTUZWVnd8uOlRAzVTfCdkxjri7A=;
        b=nY5KQ2boNZoa+d+pmY1CDh9/6dvL2NQrfziEze9cLN79/yu/ntFm3WwS3Ahii1tJT7
         wkyZlWGiuQYNS00mChLDI/WigGHyLPlSEJtYAoLYNP6VRlNU/T+lVAA+KvkwTHM8UTLa
         8EF163zfstWh6kETI/eOQzA6foBtym2swt3DCWF/1aP0wjyP8cmRuTbxJXcDevZVpPPP
         Nf8BlEDqqRuXm3vNzI8BYLhRO9lYguoXpi2lVWpqfZcH9LuKZtjfhLGNRltM80fVWRxh
         +U/rn1RUgkXpu8t3SfQBr1fyS4aj4yOysS+Mx8uSY87M7kAORxamvv+gwZ8u8IFnvSe8
         ccUg==
X-Forwarded-Encrypted: i=1; AJvYcCWHR8J55etf21Oa2NuZgt3Ma+m94va2qMRoVt/tA1YEd65ZSo/t0LcEztlgrPzQ3u0snp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT5+WskK7o+FSHZ4R/2O2yFhc0gW3Nx5g8lyIqrjhp3S8BrtKP
	JQD3gHTd8t/SUJ7Kvt5P5lPXKqk2vXrA4YXuRWAM1ew5/8+MSn7swFGRtKGkwhOL38mehAlQC/w
	x7NYR9dpT5zeay2EWLOZ8A+sBxKBaNS0=
X-Gm-Gg: ASbGncvEjPHiTO58n/uTC35SJXFaUMt5k6mNSHufHUDNcQsBkY+xNUkgFWWhe/jH6jz
	k5RKPJ14TEE6O8H1nOU8I1fdYBWv5tV+hF6g7lbs/5pG3HXaBiCziPnTYT60VeJbbk7H5MS73gq
	Jg775Wb2qGQt3G2Xvnsq32RZhnaKfICSJQ9cjC9ygR+UEsEv9sHb4DlpO6gDrhmVIuFF4lPwP1C
	WJ1zjPzDd4ZAttDijVMBQX56f2t0E6Cvl50y4z7d1TOmhAf50Dbs3ecoi4myAGOdPrJuw==
X-Google-Smtp-Source: AGHT+IEvGmKRV6HqrIpH4NP4kNszwlWCFUyMx/5JiaFAQqQOJMm0HyT9svi40DITYrOVxV2V93qqHWvXyBCRpIM0n0Q=
X-Received: by 2002:a05:6000:26c2:b0:3e1:9b75:f0b8 with SMTP id
 ffacd0b85a97d-4266e8dc01amr15056258f8f.47.1760400776245; Mon, 13 Oct 2025
 17:12:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008173512.731801-1-alan.maguire@oracle.com>
 <CAADnVQLN3jQLfkjs-AG2GqsG5Ffw_nefYczvSVmiZZm5X9sd=A@mail.gmail.com> <b4cd1254-59b4-4bac-9742-49968109c8af@oracle.com>
In-Reply-To: <b4cd1254-59b4-4bac-9742-49968109c8af@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 13 Oct 2025 17:12:45 -0700
X-Gm-Features: AS18NWBHzXxwZpdslcFpj98pbcJj_S06vGcx22qcvSgisfm5Hrcmr2DSitDj2X0
Message-ID: <CAADnVQ+yYeX7G--X4eCSW_cyK_DH3xnS-s2tyQLeBYf=NnzUEQ@mail.gmail.com>
Subject: Re: [RFC bpf-next 00/15] support inline tracing with BTF
To: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Thierry Treyer <ttreyer@meta.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Quentin Monnet <qmo@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, David Faust <david.faust@oracle.com>, 
	"Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 12:38=E2=80=AFAM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
>
> I was trying to avoid being specific about inlines since the same
> approach works for function sites with optimized-out parameters and they
> could be easily added to the representation (and probably should be in a
> future version of this series). Another "extra" source of info
> potentially is the (non per-cpu) global variables that Stephen sent
> patches for a while back and the feeling was it was too big to add to
> vmlinux BTF proper.
>
> But extra is a terrible name. .BTF.aux for auxiliary info perhaps?

aux is too abstract and doesn't convey any meaning.
How about "BTF.func_info" ? It will cover inlined and optimized funcs.

Thinking more about reuse of struct btf_type for these...
After sleeping on it it feels a bit awkward today, since if they're
types they suppose to be in one table with other types,
searchable and so on, but we actually don't want them there.
btf_find_*() isn't fast and people are trying to optimize it.
Also if we teach the kernel to use these loc-s they probably
should be in a separate table.

global non per-cpu vars fit into current BTF's datasec concept,
so they can be another kernel module with a different name.

I guess one can argue that LOCSEC is similar to DATASEC.
Both need their own search tables separate from the main type table.

>
> > The partially inlined functions were the biggest footgun so far.
> > Missing fully inlined is painful, but it's not a footgun.
> > So I think doing "kloc" and usdt-like bpf_loc_arg() completely in
> > user space is not enough. It's great and, probably, can be supported,
> > but the kernel should use this "BTF.inline_info" as well to
> > preserve "backward compatibility" for functions that were
> > not-inlined in an older kernel and got partially inlined in a new kerne=
l.
> >
>
> That would be great; we'd need to teach the kernel to handle multi-split
> BTF but I would hope that wouldn't be too tricky.
>
> > If we could use kprobe-multi then usdt-like bpf_loc_arg() would
> > make a lot of sense, but since libbpf has to attach a bunch
> > of regular kprobes it seems to me the kernel support is more appropriat=
e
> > for the whole thing.
>
> I'm happy with either a userspace or kernel-based approach; the main aim
> is to provide this functionality in as straightforward a form as
> possible to tracers/libbpf. I have to confess I didn't follow the whole
> kprobe multi progress, but at one stage that was more kprobe-based
> right? Would there be any value in exploring a flavour of kprobe-multi
> that didn't use fprobe and might work for this sort of use case? As you
> say if we had that keeping a user-space based approach might be more
> attractive as an option.

Agree.

Jiri,
how hard would it be to make multi-kprobe work on arbitrary IPs ?

>
> > I mean when the kernel processes SEC("fentry/foo") into partially
> > inlined function "foo" it should use fentry for "foo" and
> > automatically add kprobe into inlined callsites and automatically
> > generated code that collects arguments from appropriate registers
> > and make "fentry/foo" behave like "foo" was not inlined at all.
> > Arguably, we can use a new attach type.
> > If we teach the kernel to do that then doing bpf_loc_arg() and a bunch
> > of regular kprobes from libbpf is unnecessary.
> > The kernel can do the same transparently and prepare the args
> > depending on location.
> > If some of the callsites are missing args it can fail the whole operati=
on.
>
> There's a few options here but I think having attach modes which are
> selectable - either best effort or all-or-none would both be needed I
> think.

Exactly. For partially inlined we would need all-or-none,
but I see a case where somebody would want to say:
"pls attach to all places where foo() is called and since
it's inlined the actual entry point may not be accurate and it's ok".

The latter would probably need a flag in tracing tools like bpftrace.
I think all-or-none is a better default.

> > Of course, doing the whole thing from libbpf feels good,
> > since we're burdening the kernel with extra complexity,
> > but lack of kprobe-multi changes the way to think about this trade off.
> >
> > Whether we decide that the kernel should do it or stay with bpf_loc_arg=
()
> > the first few patches and pahole support can/should be landed first.
> >
>
> Sounds great! Having patches 1-10 would be useful as that would allow us
> in turn to update pahole's libbpf submodule commit to generate location
> data, which would then allow us to update kbuild and start using it for
> attach. So we can focus on generating the inline info first, and then
> think about how we want to present that info to consumers.

Yep. Please post pahole patches for review. I doubt folks
will look into your git tree ;)

> Sure, thanks for the feedback! BTW the GNU cauldron videos are online
> already so the presentation [1] about this is available now for folks
> who missed it. I'd be happy to do a BPF office hours too of course if
> that would be helpful in ironing out the details.

Can you share the slides too ?

