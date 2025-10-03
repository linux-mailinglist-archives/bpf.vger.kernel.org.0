Return-Path: <bpf+bounces-70290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A78BB6445
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 10:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF2CD3B391D
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 08:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805AC275864;
	Fri,  3 Oct 2025 08:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2Q4jrWB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFE72556E
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759481318; cv=none; b=JTarvA70FLKGHgIJlCvLNzOlBNSFd2JfF0GBAR9GsbvFDm0XtlziHQYSDAA89YKyKbkZgYsKqXEcslY2lnY3/WkopyGl6NZj+xiBsWCfqHJifrVOdyVbUjvxmb/9GmaN9G+X8aV3P15R/DMziqE21/Z2t0EHjXZMBNYw4gdvJEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759481318; c=relaxed/simple;
	bh=7/aYymvTSqWw7GvnTH/EcYDe/tscxOeGGUsYmp8EV3E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NIIKQZNAvZ/6wW0qj92+81v2fwehI241P4o0Nu3MeatDfdGERJbafzWTL5lBNGugD+Ba0r21x7D7im8ruspnssmPwxShUFTMkDCwhUn8w/y+HQQ2EeiNhGCSEvPekrzo4l0QewCE5ZqYuhkDmVzwYzw6+9ET79b01KBQ3uPDqts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2Q4jrWB; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-330b0bb4507so1984975a91.3
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 01:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759481316; x=1760086116; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8kUQOFfR1ghgs9vA7icC/TFRRA49ZCU9WllruQa+oAI=;
        b=O2Q4jrWBSvU7ryQUniqQX3fJEqxfhysfzj6KjbzsxRs09XN3ZX4PaSWRNS2jzDzOkF
         ICvzkttAWuecA+XAhiw9Ggjj+m03q31WRLodhyADQ/Szpr701NDbFhw1D2mGgqL6MxY8
         jkwANmy7iwY92pVGGlgZfJs1KLLnYTefyBbGViBU7UiePovDgpaWXHXGSR0rm/Bp7of1
         3shODgww1kJQSGlK7+it0z1b6z/1Yr7DeJNczHKKqh5fUh8L5v0bthKO/UfFJiVt/5oD
         eHb7lvAusKBzqPdIE1HtJaX9GX3TbjGA5P00eK+06cEJA+7OmdC0CkNqLjMWZq8pcIcp
         5Edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759481316; x=1760086116;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8kUQOFfR1ghgs9vA7icC/TFRRA49ZCU9WllruQa+oAI=;
        b=khf5qJVIyrvhkC7fKBkE1PKbx+JPxNr9cPW1BFcgjQT66pLCf26IPHh5IksDVwAt25
         hiDQEumhbo11ZgGBgY7VNXGXlaA4sq3v6FJ/WSyNKrZERqm/eifl3ZcNpYrBMKGYuz7W
         +9hHrSV4BfiR8nKYLSPO2GrFe8kyRyY93i9cFl6qSxpRuq0LtTxm1b6TjVYaGo9chh/+
         5QiS77EDoAxHiaRIWGL3vXbvtlzuXP3g5d/iWhMQQOoBaH3f6JLPAJQ/oUVoc2XWLRZB
         +2y6x41SBSwHgKxXIzwNuQtr4nP7hN9rb4BuoPozjnKPYWCp75Mf7fvQRJvpyFYRmWvp
         +zNA==
X-Gm-Message-State: AOJu0Ywss0jblSuBq5Z+LUmAdQBpYBr6SCcbvY1NuT9kc0JRdeBEW6pv
	tFknmzsPncTIO5P9THxsbv+EoXvLXziR5/EwruvN9IBc07saQrcHgdHigkokng==
X-Gm-Gg: ASbGncvwkPbLPzy9a2IP92g20h8VLy19Pbciz7EAG8oxo7MbBptzjpZmtK7A6GVq9Nh
	/I1WzWS+OljNl7bYLvC6gDlT/Ato6c1fRWOXdf5uJONOjG39L/xQgg4KQO0OegpB/cUEf/Te6y2
	sV0cQp1F31Dx+kpIWhbKh8DcNmKNfTaSQLaONrOsY+N21SmGZPb/0vskMmHCCs8sRPipVewaE0r
	vhpKT/F+xLOR207Nam1dklMW7+RW/JEDV9hNDQhFxkiD0RUcU+jj0viL+KbkbWckA8WVraIUsEd
	XMaqV0DeRgp7xcKTfiQj/lAD5KhaagLkQcPHYRwDLesJD4sEG3GrAEEy4C+uuiWxEkv834iYRBF
	BCYew9aBaFmEaG9uNhGXcvEmDEz4ydK0ijt7Zh2CJypLlmBI7g85SUa8=
X-Google-Smtp-Source: AGHT+IFj2smw4Ko+UBszUv6Wx/RNlxmLiq5SUAvCJghbXBoYeGHftjAlRufqPdl8HvET0mFTa9BbaQ==
X-Received: by 2002:a17:90b:1d89:b0:32b:df0e:9283 with SMTP id 98e67ed59e1d1-339c27e8309mr2416649a91.34.1759481315737;
        Fri, 03 Oct 2025 01:48:35 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339c4a0d50esm1491897a91.2.2025.10.03.01.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 01:48:35 -0700 (PDT)
Message-ID: <83421daaf2db3319b12ab95bc5406b4d5fc7c076.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 04/15] bpf, x86: add new map type:
 instructions array
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Fri, 03 Oct 2025 01:48:32 -0700
In-Reply-To: <aN99rP7iS2O0kJMN@mail.gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
	 <20250930125111.1269861-5-a.s.protopopov@gmail.com>
	 <7f2e28c4cee292fb6eb5785830d5e572b7bd59c2.camel@gmail.com>
	 <aN99rP7iS2O0kJMN@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-03 at 07:39 +0000, Anton Protopopov wrote:
> On 25/10/02 05:50PM, Eduard Zingerman wrote:
> > On Tue, 2025-09-30 at 12:51 +0000, Anton Protopopov wrote:
> >
> > Overall I think this patch is fine.
> > We discussed this some time ago, but I can't find the previous discussi=
on:
> > would it be possible to make this map element a tuple of three elements
> > (orig_off, xlated_off, jitted_off)?
> > Visible to user as well.
>
> See https://lore.kernel.org/bpf/8ff2059d38afbd49eccb4bb3fd5ba741fefc5b57.=
camel@gmail.com/
>
> In short, this will make the map element to be of different size
> from userspace and kernel (BPF) perspective.

But why does map element size has to be different between kernel and user?
For internal use there is an `ips` array and that has to be 64-bit.
For external use, it appears that any structure can be used.
I probably don't understand something.

> (Userspace can build the orig_off -> xlated_off mapping easily, if needed=
,
> just keep a copy of the map before the load.)

[...]

> > > +#define MAX_INSN_ARRAY_ENTRIES 256
> >
> > Hm, did not notice this before.  We probably need an option limiting
> > max number of jump table alternatives.

(I meant LLVM option, but you probably inferred)

> >
> > Yonghong, wdyt?
>
> This one comes from the fact I've mentioned in the other place: need
> to optimize the lookup from jit (not it is brute force). Then this
> limitation will go away.
>
> But also curious, what LLVM thinks about this. Will it,
> theoretically, create say 65K tables or so?

This generates a 4K jump table for me:

  $ cat gen-foo.py
  import random as r

  print('int foo(int i) {')
  print('  switch(i) {')
  for c in r.sample(range(0, 4096), 1024):
      print(f'  case {c}: return {r.randint(-10000, 10000)};')
  print('  }')
  print('  return 0;')
  print('}')

  $ python3 gen-foo.py | clang -xc -O2 -S -o - - | grep '.quad' | wc -l
  4093

[...]

> > > +void bpf_prog_update_insn_ptr(struct bpf_prog *prog,
> > > +			      u32 xlated_off,
> > > +			      u32 jitted_off,
> > > +			      void *jitted_ip)
> > > +{
> > > +	struct bpf_insn_array *insn_array;
> > > +	struct bpf_map *map;
> > > +	int i, j;
> > > +
> > > +	for (i =3D 0; i < prog->aux->used_map_cnt; i++) {
> > > +		map =3D prog->aux->used_maps[i];
> > > +		if (!is_insn_array(map))
> > > +			continue;
> > > +
> > > +		insn_array =3D cast_insn_array(map);
> > > +		for (j =3D 0; j < map->max_entries; j++) {
> > > +			if (insn_array->ptrs[j].user_value.xlated_off =3D=3D xlated_off) =
{
> >
> > If this would check for `insn_array->ptrs[j].orig_xlated_off =3D=3D xla=
ted_off`
> > there would be no need in `user_value.xlated_off =3D orig_xlated_off`
> > in the `bpf_insn_array_init()`, right?
>
> The copy of the original offset is kept inside the map for the
> following reason.  When the map is first loaded, it is frozen. Thus
> user can't update it anymore.  During load some of xlated_off are
> changed (together with program code). If the program load fails, it
> is common to reload it with a log buffer. If map was changed, it now
> will point to incorrect instructions. So in this case the map should
> be seen as the original one, and the orig_xlated_off is used to reset
> it.

Missed this part:

> 'If map was changed, it now will point to incorrect instructions.'

Makes sense, thank you for explaining.

[...]

