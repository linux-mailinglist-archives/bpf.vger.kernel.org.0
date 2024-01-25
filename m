Return-Path: <bpf+bounces-20359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD4B83D136
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 01:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 145B2B28046
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 00:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D298E1B7ED;
	Thu, 25 Jan 2024 23:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmCvWcjE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB4013DBA9
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 23:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706227156; cv=none; b=eIniDN9gPAJaLcQdFyOBAPULttvrBrXcUPPs9LMYwxYb+UDp2H2H7QoHyIF3CF/rwE9QuXB6cK1/Yjtqr0YuZxoTYN/g5v0Hr0BgksslkdmJEPjRs29Xnuj4ZVF7TsrDzi7mRejc0yugHxrT4OE+/XZqXOx4OBDNeCPFp4g7ydY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706227156; c=relaxed/simple;
	bh=Oh5RVWKPPxHrnAkfq10f88ys30QtFltfkaXL4osKPn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I8c4Jscm7bgQ+uSopWYNNGAKR4PudMA4QMe+BYWR+ui8kN+B3bjAmh5I/DiZJ8vVp+RVsmDDKCG4KMhGpnBqPvapKZ/s5KVbamrOnEQptEfEBL5tmciaJFRPcwx0gw3IUF+jVIJLP3kE2jAtHUo7rcWk1PV2x0XPo5T5cm4oqzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmCvWcjE; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d62aab8fecso1226440a12.1
        for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 15:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706227154; x=1706831954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00LQqf56g1V2ulY04VDZBQCXwcBJpIYRiYbR1/AD2fk=;
        b=UmCvWcjEz5hDsSmLcM3V9Gi9U3EKIxFcu1hEnfZ0JAhzXepSH36aniXSz+DkknFp2/
         knVnlGbLMuwMKBXPhad8IfAHs1ByLFvmhYpRvN7orl2d5azN9HOTz1JvxdY+seBpu4BM
         yZPP6e8hwh1NzcLIJQlg34O7mpfsW4YqoGAuMaEwQIS1hem0RuczqRkSINR/Cowv/GG1
         NpdpCFHXUELzF+IsIeSrI7gJ3k+FkLtGhj17Mqw1cSnokNUrMJ/RABE+kXp5ogBt78+y
         zrzCtJZU6wXgN1h7I1crLD3zhFrVOCmrS6hQ7/uamJtnoTNLmW0TJ8WIuy/8Z6x+c9Vd
         j/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706227154; x=1706831954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00LQqf56g1V2ulY04VDZBQCXwcBJpIYRiYbR1/AD2fk=;
        b=f829AKNSZfzzP3NXp2S6242ml3GFaLIMDn9+Babf+7xcoWcjfxst66WjihlNl7X7TK
         ApAfUoUm2QeTkjVR9sr7b8PauD4gwE0ITIDrZSoB55NQt6TwD3VHnHCr3MnEvH4+uCjl
         iIl1rPWtD7jXTp3hN9Weof7EzI1qPxmMJZHhGxh1VdPnDiTnMiV5nOA3m8uYinngUGV2
         bv5G8RD3BccNZcr4rhQgggh/bjdEB7W/kjoPWvcBt6ApkVRAmjYdpYCz+rQz4gtjcZgt
         GAsTG0ctWlw68mMgluZHZ8WH+6h1R86ucKefd/1eYe2/R8J8t14vMsFMcVTCkKvojUle
         xvAg==
X-Gm-Message-State: AOJu0YwaQQh2WsLJLC2rux5L1b+qciPofk9rpWDY1rDF3jbyXkFNE0DZ
	4Ffjq0sxgLIvTt306yRRgHYrYxjQH/SJX3WHpAUwZTmV0/z9orCcOiskXuRXYWdHgJr8XG2hMn+
	ATZtC7SAF+uIOOTttBsTnv2kI26Y=
X-Google-Smtp-Source: AGHT+IF9FxFVBWR93AREmbaWvZuON82VzY+eW+798xmoPPuKImtkQXIpcl/kQdFAlfYHSO4wdEREHJ1nqqW5YvHxezg=
X-Received: by 2002:a05:6a20:6709:b0:199:d648:7d87 with SMTP id
 q9-20020a056a20670900b00199d6487d87mr463616pzh.81.1706227153465; Thu, 25 Jan
 2024 15:59:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124224130.859921-1-thinker.li@gmail.com> <CAEf4BzZaFh3BaDYhTAWCuZBZ9t_2C2iXOsCGF88LeNb+ndVaXg@mail.gmail.com>
 <b1819ff0-872b-4cab-91d2-b496929d49f7@gmail.com>
In-Reply-To: <b1819ff0-872b-4cab-91d2-b496929d49f7@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Jan 2024 15:59:01 -0800
Message-ID: <CAEf4BzZ7jke36H+UOyU8_UQCksF4QhEmu94=H70=uJqbdOPRRw@mail.gmail.com>
Subject: Re: [RFC bpf-next] bpf: Create shadow variables for struct_ops in skeletons.
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 3:13=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com> =
wrote:
>
>
>
> On 1/25/24 14:21, Andrii Nakryiko wrote:
> > On Wed, Jan 24, 2024 at 2:41=E2=80=AFPM <thinker.li@gmail.com> wrote:
> >>
> >> From: Kui-Feng Lee <thinker.li@gmail.com>
> >>
> >> Create shadow variables for the fields of struct_ops maps in a skeleto=
n
> >> with the same name as the respective fields. For instance, if struct
> >> bpf_testmod_ops has a "data" field as following, you can access or mod=
ify
> >> its value through a shadow variable also named "data" in the skeleton.
> >>
> >>    SEC(".struct_ops.link")
> >>    struct bpf_testmod_ops testmod_1 =3D {
> >>        .data =3D 0x1,
> >>    };
> >>
> >> Then, you can change the value in the following manner as shown in the=
 code
> >> below.
> >>
> >>    skel->st_ops_vars.testmod_1.data =3D 13;
> >>
> >> It is helpful to configure a struct_ops map during the execution of a
> >> program. For instance, you can include a flag in a struct_ops type to
> >> modify the way the kernel handles an instance. By implementing this
> >> feature, a user space program can alter the flag's value prior to load=
ing
> >> an instance into the kernel.
> >>
> >> The code generator for skeletons will produce code that copies values =
to
> >> shadow variables from the internal data buffer when a skeleton is
> >> opened. It will also copy values from shadow variables back to the int=
ernal
> >> data buffer before a skeleton is loaded into the kernel.
> >>
> >> The code generator will calculate the offset of a field and generate c=
ode
> >> that copies the value of the field from or to the shadow variable to o=
r
> >> from the struct_ops internal data, with an offset relative to the begi=
nning
> >> of the internal data. For instance, if the "data" field in struct
> >> bpf_testmod_ops is situated 16 bytes from the beginning of the struct,=
 the
> >> address for the "data" field of struct bpf_testmod_ops will be the sta=
rting
> >> address plus 16.
> >>
> >> The offset is calculated during code generation, so it is always in li=
ne
> >> with the internal data in the skeleton. Even if the user space program=
s and
> >> the BPF program were not compiled together, any differences in version=
s
> >> would not impact correctness. This means that even if the BPF program =
and
> >> the user space program reference different versions of the "struct
> >> bpf_testmod_ops" and have different offsets for "data", these offsets
> >> computed by the code generator would still function correctly.
> >>
> >> The user space programs can only modify values by using these shadow
> >> variables when the skeleton is open, but before being loaded. Once the
> >> skeleton is loaded, the value is copied to the kernel, and any future
> >> changes only affect the shadow variables in the user space memory and =
do
> >> not update the kernel space. The shadow variables are not initialized
> >> before opening a skeleton, so you cannot update values through them be=
fore
> >> opening.
> >>
> >> For function pointers (operators), you can change/replace their values=
 with
> >> other BPF programs. For example, the test case in test_struct_ops_modu=
le.c
> >> points .test_2 to test_3() while it was pointed to test_2() by assigni=
ng a
> >> new value to the shadow variable.
> >>
> >>    skel->st_ops_vars.testmod_1.test_2 =3D skel->progs.test_3;
> >>
> >> However, you need to turn off autoload for test_2() since it is not
> >> assigned to any struct_ops map anymore. Or, it will fails to load test=
_2().
> >>
> >>   bpf_program__set_autoload(skel->progs.test_2, false);
> >>
> >> You can define more struct_ops programs than necessary. However, you n=
eed
> >> to turn autoload off for unused ones.
> >
> > Overall I like the idea, it seems like a pretty natural and powerful
> > interface. Few things I'd do a bit differently:
> >
> > - less code gen in the skeleton. It feels like it's better to teach
> > libbpf to allow getting/setting intial struct_ops map "image" using
> > standard bpf_map__initial_value() and bpf_map__set_initial_value().
> > That fits with other global data maps.
>
> Right, it is doable to move some logic from the code generator to
> libbpf. The only thing should keep in the code generator should be
> generating shadow variable fields in the skeleton.
>
> >
> > - I think all struct ops maps should be in skel->struct_ops.<name>,
> > not struct_ops_vars. I'd probably also combine struct_ops.link and
> > no-link struct ops in one section for simplicity
>
> agree!
>
> >
> > - getting underlying struct_ops BTF type should be possible to do
> > through bpf_map__btf_value_type_id(), no need for struct_ops-specific
> > one
>
> AFAIK, libbpf doesn't set def.value_type_id for struct_ops maps.
> bpf_map__btf_value_type_id() doesn't return the ID of a struct_ops type.
> I will check what the side effects are if def.value_type_id is set for
> struct_ops maps.

Yes, it doesn't right now, not sure why, though. At least we can fix
that on libbpf side.

>
> >
> > - you have a bunch of specific logic to dump INT/ENUM/PTR, I wonder if
> > we can just reuse libbpf's BTF dumping API to dump everything? Though
> > for prog pointers we'd want to rewrite them to `struct bpf_program *`
> > field, not sure yet how hard it is.
>
> I am not quite sure what part you are talking about.
> Do you mean the code skipping type modifiers?
> The implementation skips all const (and static/volatile/... etc) to make
> sure the user space programs can change these values without any
> tricky type casting.
>

No, I'm talking about gen_st_ops_shadow_vars and gen_st_ops_func_one,
which don't handle members of type STRUCT/UNION, for example. I didn't
look too deeply into details of the implementation in those parts, but
I don't see any reason why we shouldn't support embedded struct
members there?

> >
> > The above is brief, so please ask questions where it's not clear what
> > I propose, thanks!
> >
> > [...]
>
> Thank you for the comments.
>

