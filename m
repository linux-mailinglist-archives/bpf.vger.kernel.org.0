Return-Path: <bpf+bounces-43071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6229C9AEE1A
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 19:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939091C21F2B
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 17:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3511EF958;
	Thu, 24 Oct 2024 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMvipw9t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD6F1EB3D
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 17:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729791097; cv=none; b=pM2nie8OKgijjYEgRew3KDAViKzYJO7fxMw7tqmqR0Q8qHQjRXtUZGs3+9fgN6G5VV+vUUkO355SAa71BHx2goPjbEhSH6h2L0saPKW2N/j4XkqICBH/5/5uy+QGcHzNJ6aSKP+aem86FnR2jMh4/nyyrXZ9BQQedwsl+X8vxSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729791097; c=relaxed/simple;
	bh=8CYYqRDUtT6QyYv2Zhfnf+uGDhBis19FmGiDqDIvbHI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cqtSEkE+hubmwRWbL77SMz3zY6elArscFuMZ4sZDkmthnuWyNewYxi8G94gEEVaz0YnKV4bdZ5xTROLEPsrC5q0uVOT9LA4JBYstGMB8qtnM+hg+jyMfLz0WhWZPNCY5Npa2G1XfDdsIzM4ssqUbPbqZDBliE0+vNOsV8NVmEK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMvipw9t; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e31af47681so926429a91.2
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 10:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729791094; x=1730395894; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ojwrFmW7XcH30E065kIFIfxCwpZNS90XgeqXxHv6Vh8=;
        b=AMvipw9tw8JBNzJn70PCxSALDK+zAMLhS1MqdXCw69rcuP9FoFR5yaS4VQ6zaRACzS
         EPLBrN0q8YdViyDq3JK40ZPmknebOH5cXMWxcMzn2bP1WKmCpe8kGTfqCdXCTqNBSGVn
         jzVyA8D7TnXerS0ytuMoz3zHwLcVRY/W6dvRPZpzOajt/its88FnFOfcic3hPNy81fu4
         y4wNm2WJxfH17rWWWUJVSsvmmGVFhuLkiilWMSrcbB7BIgM5RZZV7eAEnBWMen1XpWYW
         2qxerqjfHd6lxGQQ/5OdtsaokUoXiCGomgYfcGKnHCnmO1NK5nAOco7/chV2irjL5PAp
         7qGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729791094; x=1730395894;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ojwrFmW7XcH30E065kIFIfxCwpZNS90XgeqXxHv6Vh8=;
        b=urPCgQEL0NReyLuy6eBxb+lHaq+x49U2YhYfC+3id9mAqEwkpyW+pC8sno4AOQHIwV
         XakFP4AcJTkV09VnojudXRcviRlEzFh2dgOaG1ikvyVPpIgZ1m8gazJZNrfPFv3aCJ6E
         O8tqSJt07u5FwWIzPiV7e7F1Ko3OSGWdxph2yVxt25O1bkk4OgSviPMfQsz9ny0nHhP6
         6epEhKz44gG0AP3pECwYA9KsDP4pHBXIeiEo4Bz1+9tCrSsZ+2pruNRLGaWXRJq0n/fE
         /+X1qIu4qr33jUfgmsBLJcM25e2xagtO5uufdKzLd1eoQvgtzEBjXn95dyAKgzkGmj53
         ztOw==
X-Forwarded-Encrypted: i=1; AJvYcCUHQUsvE5LYtujxen/reCWMADdhW8xO6XSLaCIXILqdLgEopFYqL48rW7tJ9ZQYcDtMk7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTIATbqeo9buGbBGTkcv+PcrCBzKCv0bvmQywD3266m6YKugEK
	SOfZ2LWAZsMJPxCt24QOPBDkaaImD7MYYkmx90liX4G7V8fv2d4B
X-Google-Smtp-Source: AGHT+IGwzON6WiEV3rQntURgovjB2eXHN8ihE7hmXOYBDsNRyZHZHFq6BMEHFAfTxzSJkl1a7k9Vdg==
X-Received: by 2002:a17:90a:69c4:b0:2e2:cc47:ce1a with SMTP id 98e67ed59e1d1-2e76b5b5793mr8229788a91.1.1729791093966;
        Thu, 24 Oct 2024 10:31:33 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0db987sm74891725ad.204.2024.10.24.10.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 10:31:33 -0700 (PDT)
Message-ID: <b83c12777cd1980c16da363097aeb8ef6a1def91.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_get_hw_counter kfunc
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>, bpf
 <bpf@vger.kernel.org>
Date: Thu, 24 Oct 2024 10:31:28 -0700
In-Reply-To: <4d7f00e6-8fab-4274-8121-620820b99f02@linux.dev>
References: <20241023210437.2266063-1-vadfed@meta.com>
	 <CAADnVQ+YRj2_wWYkT20yo+5+G5B11d3NCZ8TBuCKJz+SJo37iw@mail.gmail.com>
	 <4d7f00e6-8fab-4274-8121-620820b99f02@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-24 at 14:11 +0100, Vadim Fedorenko wrote:

[...]

> > > @@ -20396,6 +20398,15 @@ static int fixup_kfunc_call(struct bpf_verif=
ier_env *env, struct bpf_insn *insn,
> > >                     desc->func_id =3D=3D special_kfunc_list[KF_bpf_rd=
only_cast]) {
> > >                  insn_buf[0] =3D BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
> > >                  *cnt =3D 1;
> > > +       } else if (IS_ENABLED(CONFIG_X86) &&
> >=20
> > It's better to introduce bpf_jit_inlines_kfunc_call()
> > similar to bpf_jit_inlines_helper_call().
>=20
> Yep, I thought about introducing it while adding more architectures, but
> can do it from the beginning.

After thinking a bit more, I think I messed up in a private discussion
with Vadim. It is necessary to introduce bpf_jit_inlines_kfunc_call()
and use it in the mark_fastcall_pattern_for_call(),
otherwise the following situation is possible:

- the program is executed on the arch where inlining for
  bpf_get_hw_counter() is not implemented;
- there is a pattern in the code:

    r1 =3D *(u64 *)(r10 - 256);
    call bpf_get_hw_fastcall
    *(u64 *)(r10 - 256) =3D r1;
    ... r10 - 8 is not used ...
    ... r1 is read ...

- mark_fastcall_pattern_for_call() would mark spill and fill as
  members of the pattern;
- fastcall contract is not violated, because reserved stack slots are
  used as expected;
- remove_fastcall_spills_fills() would remove spill and fill:

    call bpf_get_hw_fastcall
    ... r1 is read ...

- since call is not transformed to instructions by a specific jit the
  value of r1 would be clobbered, making the program invalid.
 =20
Vadim, sorry I did not point this out earlier, I thought that fastcall
contract ensuring logic would handle everything.

[...]


