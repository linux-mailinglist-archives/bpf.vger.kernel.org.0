Return-Path: <bpf+bounces-22778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2465C869CCA
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 17:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDE9E2868A0
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 16:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1264B219ED;
	Tue, 27 Feb 2024 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6hI2fG9"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14E91C6B0
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052717; cv=none; b=ktPsWsuU82xiwJMtQILFRMzs/Ja+ghEEju8bnjeiHvrCAxso6LleOFuaysuCGps5O8WCIBs2YbWSRrfJ6m+E5ub8B/7TDuh3lCcF4aiQYOgwpGSIEKGAIW3QERzwKpAz7vztrXY/2WtxiLmU6HixMvB4kOMegNqWCty8JA5SCS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052717; c=relaxed/simple;
	bh=zaOkgxIiB8GNse2AVQG29Q0YOlZCBjN6gtzoplU25RI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bt04sfbIK2DDE+mkOV0mnoJgbPr0oGJH9qbNOjEkNQakjw/5IKmw/xsDSkZ2ZGhIFUGU+tDCKGfg+hpznblKy8wUg5qcYoA9lB3UbqY9k800z4OUsS6Bw2nLDXIkx2dyvdSDxIZf8Qgy0H8YV5glE8isuxot5LQyXqUo4MfTRjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X6hI2fG9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709052714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fa7hNUw2MnGUSkkyaysmsOHXW2bn0B5N2bcUJWgOZXI=;
	b=X6hI2fG9tp79Q4ZX0QQdJKdH6vfVc5Gd1j/ST9fnixjP5lKgjkKS/Rj7rdQbjP5OIH3Qbj
	653g0AlRZxf9hZ+bk/W3ZkfnKsdMnflz/1SX4ke5gicCDhGlhuta1EuWy1q4NC9W8iDsr1
	rRMrHyJYCB1gCn1w6zOdllUcncLHPqI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-pwEINHFHPZaOucM5b1GsyQ-1; Tue, 27 Feb 2024 11:51:53 -0500
X-MC-Unique: pwEINHFHPZaOucM5b1GsyQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5129e5b5556so4697741e87.2
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 08:51:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709052712; x=1709657512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fa7hNUw2MnGUSkkyaysmsOHXW2bn0B5N2bcUJWgOZXI=;
        b=wE1Lvl5K573wgnWgA6xwwECU0DBkVTA+VcJ/sL1rcyvMYgISx2cyxmG6vTBuIXaNWP
         48czYZPkQuMlHy6+1RTAbdM2UVoB/OgfBCoyy39i54v7yEtCHNH+O7GaykdCPNoA1r9+
         Ex2ciJDLfGwvmnBUmdZAmmB8rGFNxoTEQXgjX6eoHNcLZdIy1PBTf9JlcOERoQPCra/W
         C9I1mGBsiCiv526SbgXGWryz10QcMTy7Z/ZdYGCcDLIL42uQDlmBxwR1k0yszWXxg09b
         ol8j0Vr/nLpb1U+wnyPGvRuk1UkGPu1H91VNZP0K7xLdF/QBdCT0jnBOehlJuIBmiaFn
         Bqnw==
X-Forwarded-Encrypted: i=1; AJvYcCU54He6q8Q0XnSEjV1o2dQRjkly+FUoZT6mXgxwpyrFf9mWAeirThcBbj2hp35+5/9IU7azaYfZxiX3l8qab/983gOU
X-Gm-Message-State: AOJu0YzVExjGK3zAQJpNHkVSZpHQ6yLop6yKr2fYhHvK21JfzKSmq0B+
	M7mW9a3+OQ1R+aLl75WnyDa+fOJvyYocRVYufI9y1bhfeAJ4npYOJmEm9+DjDd4BdO+1xmDt++1
	weHQvtYuzzaqenn4uxKiJdcuZVpnbKiYaprVXops8eLv82OoioPrBVvkRaGhMhUBnXRgC5kpKuP
	n0uCf7+nW9PLRQt14txdqJr1Gq
X-Received: by 2002:a05:6512:21c3:b0:512:eb68:d314 with SMTP id d3-20020a05651221c300b00512eb68d314mr5801929lft.37.1709052712050;
        Tue, 27 Feb 2024 08:51:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFn+5DokthX5JEB0laGa6PU+Ets4rObRsTUnAYyutXhmYDPA3cLG84WeT3/0s2gZENZv7xZvDHyIB5bfThwtvA=
X-Received: by 2002:a05:6512:21c3:b0:512:eb68:d314 with SMTP id
 d3-20020a05651221c300b00512eb68d314mr5801912lft.37.1709052711724; Tue, 27 Feb
 2024 08:51:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
 <20240221-hid-bpf-sleepable-v3-8-1fb378ca6301@kernel.org> <55177311ccdc24a74811d4a291ee1880044a5227.camel@gmail.com>
 <pocfd5n6lxriqg7r6usyhrlprgslclxs44jqoq63lw734fjl2g@5kv4hjaux2fp> <9a35a53a1887fb664fd540ec7e272cb3ea63f799.camel@gmail.com>
In-Reply-To: <9a35a53a1887fb664fd540ec7e272cb3ea63f799.camel@gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Tue, 27 Feb 2024 17:51:39 +0100
Message-ID: <CAO-hwJ+TGiLrc4De7htvKaSsMfQnZahK-zONAMNgUMYHEQb-7g@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v3 08/16] bpf/verifier: do_misc_fixups for is_bpf_timer_set_sleepable_cb_kfunc
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 5:36=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2024-02-27 at 17:18 +0100, Benjamin Tissoires wrote:
> [...]
>
> > Hmm, I must still be missing a piece of the puzzle:
> > if I declare bpf_timer_set_sleepable_cb() to take a third "aux"
> > argument, given that it is declared as kfunc, I also must declare it in
> > my bpf program, or I get the following:
> >
> > # libbpf: extern (func ksym) 'bpf_timer_set_sleepable_cb': func_proto [=
264] incompatible with vmlinux [18151]
> >
> > And if I declare it, then I don't know what to pass, given that this is
> > purely added by the verifier:
> >
> > 43: (85) call bpf_timer_set_sleepable_cb#18152
> > arg#2 pointer type STRUCT bpf_prog_aux must point to scalar, or struct =
with scalar
>
> Right, something has to be done about number of arguments and we don't
> have a convenient mechanism for this afaik.
>
> The simplest way would be to have two kfuncs:
> - one with 2 arguments, used form bpf program;
> - another with 3 arguments, used at runtime;
> - replace former by latter during rewrite.

It's hacky but seems interesting enough to be tested :)

>
> > Maybe I should teach the verifier that this kfunc only takes 2
> > arguments, and the third one is virtual, but that also means that when
> > the kfunc definitions are to be included in vmlinux.h, they would also
> > have this special case.
>
> It might be a somewhat generic mechanism, e.g. btf_decl_tag("hidden")
> for kfunc parameter.

We also could use the suffix (like __uninit, __k, etc...), but it
might introduce more headaches than the 2 kfuncs you are proposing.

>
> imho, having two kfuncs is less hacky.
>
> > (I just tried with a blank u64 instead of the struct bpf_prog_aux*, but
> >  it crashes with KASAN complaining).
>
> For my understanding:
> - you added a 3rd param (void *) to kfunc;

it was struct bpf_prog_aux *, but yes

> - passed it as zero in BPF program;
> - applied the above rewrite, so that r3 equals to prog->aux;
> - and now KASAN complains, right?

yep, but see below

>
> Could you please provide more details on what exactly it complains about?
>

Well, there is a simple reason: that code is never reached because, in
that function, there is a `if (insn->src_reg =3D=3D
BPF_PSEUDO_KFUNC_CALL)` above that unconditionally terminates with a
`continue`. So basically this part of the code is never hit.

I'll include that new third argument and the dual kfunc call in
fixup_kfunc_call() and report if it works from here.

Cheers,
Benjamin


