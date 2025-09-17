Return-Path: <bpf+bounces-68622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C811B7FB9F
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 16:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8DF1C01637
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 04:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC215237172;
	Wed, 17 Sep 2025 04:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HF4+8g+U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E910019DF6A
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 04:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758084273; cv=none; b=LOT6ANhdf8C3Je3VpdTpVIia/28+MnoYftGZ4h9zLANMrz21hOK9yXIV1jRYTCD6kjQAENnp/e51JWLyy9nshxczyInByUJnNqeeDTlnR97jwagZMoX7f+gQhhODNHW1MCj9QfIUVa7vdLlV91TEVVIKPOr4/yMcSG3FG5hjKu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758084273; c=relaxed/simple;
	bh=nrI/9zb0JPgkb5gmo6nChZ1+0qv01/J0ZWCDNwCYmxs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lTEYYrJPxuPDSF3ZJTYSetjf2L/L/E4OrfZjugq0rHEyfmS5gKa2JhULIc3UVzB8McjqPjszNbojOh4LXSYPtmawp+kDHH1AD20sJv0WWQS/LzbCECNiDVH8cofYe+egRGkwC3gf3BNqRF6x4BhwMxIps3aY/SPLb+U/yXw5y0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HF4+8g+U; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32ec2f001abso735014a91.2
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 21:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758084271; x=1758689071; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eqYcvZxCAO5c01hsQClqHTc5/zD1nK7qGmmR/kkiikI=;
        b=HF4+8g+UofmKU1luuTJ9T9Pd5PXrBV5LnDAeeDprGCYhOj1vBpct04CWsxFGSXgUSJ
         77Af0HaOK3WYPNgqwk90upJnsbfmUSZb0gci3VgRE01ZO/9bspvbvMcGUhqMjD3zEnXp
         IqKlv98rwBYCg9YiSpM4dj/SpY4qX4XDXFq1mdm445yjB/KXTSHfyy/CFGNnpm+ynWCB
         6DWPDHn248ixc+8ucWXyEY+xaJyHpHJ+yrMZQ6WXqPIRsP48R8UrhLty2Z4WKdRCdco4
         YPr3a1PjnxSEGbjv94i5ilQNRezto69UDSkOprY9jFTkCU0ipZofOvUNFhUptCf0F02F
         pcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758084271; x=1758689071;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eqYcvZxCAO5c01hsQClqHTc5/zD1nK7qGmmR/kkiikI=;
        b=gRuxysfHsHqW901b44KgXvTkL6/LZuUA21NqNCEghRz4owbx6yXkWTv6CmHg0htp0h
         /sYghN0nUbIOB6BIgbGC8fLqvRN+Y46PeWNHgeod8sA74tJHcavU3Esbzldo+titTZ9r
         ijghjRFd8hznjn0QWAqf3IUTi8KCYOctwEBYf6Tfqc9PMkV4iofWyEErK2s5pJJ8EPPV
         dng/scPuy3yyntOpWs/r8BHN3h/u2PXkfk1Wsm1YV8HOCHbGw/2EAic3vD70NotjGUaX
         2c0YI/n0xw1fsvn5P90R2qe3WVarcVoec5KJBTodlVgsJp3SFirrAh3OKV3JgSAoT5op
         /ZMg==
X-Forwarded-Encrypted: i=1; AJvYcCUXYS0DJ6J7Ao8BCsepicmFNX8fG8vk0sd77bzZMvdk8gjtjhUSY9LZbvkAreLuYCLiKew=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzNGOro2Sfx0n7qhFmSzMNq7K3AAcfhvkoFMcRubp5h3mp8GhJ
	BgolRcNM9ABpEBmVYf2dfyMrAyQz/QtdwGjkgMyp8lqAnqTJqb8pyR3n
X-Gm-Gg: ASbGncudxm7/3Oe+NJ+YDvP5/X/Hsxq/OX10ThRP8r4BcZo48T3/nkcnpN8mnzUyqOn
	aeBH6yyb5N3/+Mo/jIOmypLI7vSwcBmwSR8fPEkbQ6UCzxuwQk9xJ24+FMWE9h8Hci6Bvr617tz
	0WoQJ/7RbcODggjlqRDX0CI/IADVLapvazLV8qGNyjQUVbNzm7Up2wnZ38cvO59KQq7fJcdTd5x
	aQXsULWcLZKVZleQJJn1O4KTKkZ77Oq73cjuW94DaSnL1wD9zUmx9Cz6SZoaAovp/08A3b9DYF6
	07/W0EMcOh4o+FaLH9vAhTT4UygqtpNkbUg7pR8qnFvO4MopSAp2niqbven4wM84MB7Q7HpgksH
	W6IriVL0D+G7Iv3pfUko=
X-Google-Smtp-Source: AGHT+IFunPjD2aOHjFEZDAMjPJ1XcWGmqC/uToF4HJN9bPYkbAzCOLkWDeycZl2C5fqReVQDOx8GjQ==
X-Received: by 2002:a17:90b:2d8c:b0:32e:3829:a71c with SMTP id 98e67ed59e1d1-32ee3eecc0emr977513a91.16.1758084271098;
        Tue, 16 Sep 2025 21:44:31 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed266ed36sm1127945a91.2.2025.09.16.21.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 21:44:30 -0700 (PDT)
Message-ID: <5e2fff56d3465ca921dbee96f512bf0443f66346.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 0/8] bpf: Introduce deferred task context
 execution
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf <bpf@vger.kernel.org>,
  Alexei Starovoitov	 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>,
 Kernel Team	 <kernel-team@meta.com>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>
Date: Tue, 16 Sep 2025 21:44:27 -0700
In-Reply-To: <CAADnVQLe+5C8MH9SEU2MxHP9iaCHJHXdnuXTHkqvnVwsHTynwA@mail.gmail.com>
References: <20250916233651.258458-1-mykyta.yatsenko5@gmail.com>
	 <3b65db27f2cd4575875a090f9cce0ca0f138daea.camel@gmail.com>
	 <CAADnVQLe+5C8MH9SEU2MxHP9iaCHJHXdnuXTHkqvnVwsHTynwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-16 at 21:37 -0700, Alexei Starovoitov wrote:
> On Tue, Sep 16, 2025 at 4:55=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Wed, 2025-09-17 at 00:36 +0100, Mykyta Yatsenko wrote:
> >=20
> > [...]
> >=20
> > > Changelog:
> > > ---
> > > v4 -> v5
> > > v4:
> > > https://lore.kernel.org/all/20250915201820.248977-1-mykyta.yatsenko5@=
gmail.com/
> > >  * Fix invalid/null pointer dereference bug, reported by syzbot
> > >  * Nits in selftests
> >=20
> > Note for reviewrs, this is the part that takes care of syzbot report:
> >=20
> >    /* Check if @regno is a pointer to a specific field in a map value *=
/
> >    static int check_map_field_pointer(struct bpf_verifier_env *env, u32=
 regno,
> >   -                                  enum btf_field_type field_type, u3=
2 field_off,
> >   -                                  const char *struct_name)
> >   +                                  enum btf_field_type field_type, u3=
2 rec_off)
> >    {
> >           struct bpf_reg_state *regs =3D cur_regs(env), *reg =3D &regs[=
regno];
> >           bool is_const =3D tnum_is_const(reg->var_off);
> >           struct bpf_map *map =3D reg->map_ptr;
> >           u64 val =3D reg->var_off.value;
> >   +       const char *struct_name =3D btf_field_type_name(field_type);
> >   +       int field_off;
> >=20
> >           if (!is_const) {
> >                   verbose(env,
> >   @@ -8545,6 +8546,8 @@ static int check_map_field_pointer(struct bpf_v=
erifier_env *env, u32 regno,
> >                   verbose(env, "map '%s' has no valid %s\n", map->name,=
 struct_name);
> >                   return -EINVAL;
> >           }
> >   +       /* Now it's safe to dereference map->record */
> >   +       field_off =3D *(int *)((void *)map->record + rec_off);
>=20
> I don't follow. Why does it have to be so weird?
> The syzbot flagged that:
> if (btf_record_has_field(map->record, ...)
> if (map->record->timer_off
> crashes.
>=20
> and the workaround is to do:
> *(int *)((void *)map->record + rec_off)
> ?!
>=20
> That's quite ugly.
> Is this the case of compiler assuming non-null and hoists load?
> Then barrier() will solve it?

In v4 the function invocation looked like:

  err =3D check_map_field_pointer(env, regno, BPF_TIMER, map->record->timer=
_off, "bpf_timer");

As it turns out, map->record can be NULL if there are no special
fields in the map. In current kernel code this is handled by the
following part:

static int process_timer_func(struct bpf_verifier_env *env, int regno,
			      struct bpf_call_arg_meta *meta)
{
        ...
        // btf_record_has_field checks if map->record is NULL and returns e=
rror
	if (!btf_record_has_field(map->record, BPF_TIMER)) {
		...
	}
	if (map->record->timer_off !=3D val + reg->off) {
		...
	}
        ...
}

