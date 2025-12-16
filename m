Return-Path: <bpf+bounces-76747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD89BCC4F0C
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 19:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 712253007ABA
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 18:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C317333D6D3;
	Tue, 16 Dec 2025 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+XQQfPL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0DF21CC55
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 18:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765910926; cv=none; b=sai0NbelDsfLRUcy25AlX3Uo55yAOGTMsgqVN7ag+apJudfePyEh58CkLz8UNHcCfxrkBNQkR9ddOw0RQknRto/ExWB2kDkC5kT2YQWVyJ6wI8Nm/T0ASKa6YusBSoW/L31QQHQHEbKD771blRbwQVINzX6kKYmQctDtTLi40fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765910926; c=relaxed/simple;
	bh=CDwfWfirvvjTlanrx1NeyaqNcbQIyVR7qC3SG5LuORA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dC/5aX0JIVlvwjUn0IsEdsTrb4U1ZmLAK5/UwpJySgCu6NqGyQSMLe1Mm8cw291mKxFXKxIWY6SpXnwaNU7nsOrZxMeKhYzhBN2M6RVxTgwKcyVV4c0GLjjs7B2daW/rc6Wp/69hu9khSEfRh38tVzVou2maX2yvZMFQTzkIZCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+XQQfPL; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b852bb31d9so5699622b3a.0
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 10:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765910924; x=1766515724; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=59EYFG8JRwTTRcOAz4N17XQR1vVvowZf5Mq1LfkVR8Y=;
        b=e+XQQfPLX7TeEvP3UNHIRUuZ/PJ15kQRz3M1367s6ZGa5sHPoGa+qXLxnOyjSxfmPB
         Mjs4NbVQ4B03pfYBEUqFvN6hCySIEcMn4t2nSGTACmsbVJw3gl9GaDIOgZZPkr8NIF1P
         Dvd0wZszllMXqDoPDVPKZROAEKZ6QqL/gkQ9gVR1NCONQJt4r1CXzSVGOXJq/MVEqUXH
         v0xNcaJmZAVmgd50TsDlJxQcK3NMefqNsulUwcmjR0RAdGr3xy7L1avxyVPaBbhHTo1o
         SWkJjG6j9NXTYDH3Sw6Yx3Zc7zU/ngdI9EbL3iS5nWYmGRq0Mukgug04u/O/suD072ai
         juMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765910924; x=1766515724;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=59EYFG8JRwTTRcOAz4N17XQR1vVvowZf5Mq1LfkVR8Y=;
        b=nOOVEwo9DptJ9tpnIZ8olLN82V/CTOskE3U9L981nYxrkYOJ7ULYJo8pw3cr2Vyq+1
         cDFG2zvmjF6Ihnf/uTibO6ZfzkzI4Y3vXGhenW9IqheN0tfquxOLLutwhX9cbFnOGpIO
         MO4ImCjSkX0k9BASE1D3RyuNX8a4hoPVEPj9W+MJW7Rhen04mb7yWYi+P4oR9t6Y80g+
         4YlBn5KlzPZkSE1Cy8Qfo86cMG+OsbYeF1bPzcW3O8zgeV4Jx5nn+HgJ/6rRFB/mrQPT
         sZ75g3k9lqjxyy/fApI5W9WwlCPlx61B7impGjTo//Kp4wnJfQAyxlaa8VJftVp96Ca2
         yQmA==
X-Forwarded-Encrypted: i=1; AJvYcCV6zy6+V5T2A/xAPdyqq8VB8cWG3wwg+h/i/dGO9S47GU/IZwbYpYIVQGtYwYy8FxRcEU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YywCQG7gk9KHQX1HpJYczIHk7y7VmzvtA2ZTAkDmb5XKA6PVG3U
	XoNuwGmrW+B0CL+zTXrrlSNvjiMCLQfUqpdcsY7mmJZ8Hkd/WsPi9fhA
X-Gm-Gg: AY/fxX7o/APIgV+I8MnS44puubQQ4j1dG1cK7E7xhioN7Rdn/tVuctLdMA2PZsN93gt
	G7SIxjFWOoul8H2JoD9W/0UGqKCYT88Bp1W1tes4b8TBEZ94GP73ZCkW0qAEq3vra4PhvzdAOyH
	QAD/oCyxD7tibqWpqoaX5vquGZIGWHBq5FiVOvlONJO+8ZPL30uC0+LtUK7Jc1iPz7li9vuflUR
	awt3xSWmde2oEMAC5qbdX4SzhNeqg/qFHYXoWPQAXNL6SFVb5MuBZ9CkvsBWjQDeaX6Qljas4CW
	P0dNoddquhPXDoKdF5x9wwbRoOzfBNzSOAzfILacxedGmESEgP6TwuA+C9QDNxjcrD15+z9xjx3
	g2a9NyM+CTHqW6f70TMRG/Ong0/zr0IH9BMd+S9owsxKbj+UYQ4HW3nZfrtWir6dJGK3pvr5SV6
	PGPNShkyi1
X-Google-Smtp-Source: AGHT+IE207d8z8pHsazPR+IDqc22X936jsfO7xl5k8vPegczYZ3n1ihCDJOcETolqLre8kWule3D3w==
X-Received: by 2002:a05:6a20:258c:b0:35e:86d3:88c8 with SMTP id adf61e73a8af0-369afa09e50mr14733661637.52.1765910924051;
        Tue, 16 Dec 2025 10:48:44 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c19601e9b1dsm2545931a12.8.2025.12.16.10.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 10:48:43 -0800 (PST)
Message-ID: <18ef13a0b9588cefacc58434bb6a097b92c7d6a7.camel@gmail.com>
Subject: Re: [PATCH v4 2/5] bpf/verifier: do not limit maximum direct offset
 into arena map
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bot+bpf-ci@kernel.org, 
 Anton Protopopov <a.s.protopopov@gmail.com>
Cc: emil@etsalapatis.com, bpf@vger.kernel.org, andrii@kernel.org,
 ast@kernel.org, 	daniel@iogearbox.net, john.fastabend@gmail.com,
 memxor@gmail.com, 	yonghong.song@linux.dev, martin.lau@kernel.org,
 clm@meta.com, 	ihor.solodrai@linux.dev
Date: Tue, 16 Dec 2025 10:48:40 -0800
In-Reply-To: <CAEf4BzazeSaj5MgF01uDMOdiMDSA=YVU=kvzSDKB_Hx7NOARtw@mail.gmail.com>
References: <20251216173325.98465-3-emil@etsalapatis.com>
	 <0447c47ac58306546a5dbdbad2601f3e77fa8eb24f3a4254dda3a39f6133e68f@mail.kernel.org>
	 <CAEf4BzazeSaj5MgF01uDMOdiMDSA=YVU=kvzSDKB_Hx7NOARtw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-16 at 10:38 -0800, Andrii Nakryiko wrote:
> On Tue, Dec 16, 2025 at 10:02=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
> >=20
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index a31c032b2dd6..d6b8a77fbe3b 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -21132,11 +21132,6 @@ static int resolve_pseudo_ldimm64(struct bpf=
_verifier_env *env)
> > >               } else {
> > >                       u32 off =3D insn[1].imm;
> > >=20
> > > -                     if (off >=3D BPF_MAX_VAR_OFF) {
> > > -                             verbose(env, "direct value offset of %u=
 is not allowed\n", off);
> > > -                             return -EINVAL;
> > > -                     }
> > > -
> > >                       if (!map->ops->map_direct_value_addr) {
> > >                               verbose(env, "no direct value access su=
pport for this map type\n");
> > >                               return -EINVAL;
> >=20
> > The map_direct_value_addr() implementations for array and arena maps
> > return only the base address, and then resolve_pseudo_ldimm64() adds th=
e
> > offset at line 21148:
> >=20
> >     aux->map_off =3D off;
> >     addr +=3D off;
> >=20
> > However, insn_array_map_direct_value_addr() (kernel/bpf/bpf_insn_array.=
c)
> > has a different implementation pattern:
> >=20
> >     static int insn_array_map_direct_value_addr(const struct bpf_map *m=
ap,
> >                                                  u64 *imm, u32 off)
> >     {
> >         struct bpf_insn_array *insn_array =3D cast_insn_array(map);
> >=20
> >         if ((off % sizeof(long)) !=3D 0 ||
> >             (off / sizeof(long)) >=3D map->max_entries)
> >             return -EINVAL;
> >=20
> >         /* from BPF's point of view, this map is a jump table */
> >         *imm =3D (unsigned long)insn_array->ips + off;
> >=20
> >         return 0;
> >     }
> >=20
> > Notice that insn_array adds the offset to the base address inside the
> > function (line: *imm =3D (unsigned long)insn_array->ips + off). When
> > resolve_pseudo_ldimm64() then adds the offset again at line 21148, the
> > result is:
> >=20
> >     addr =3D (insn_array->ips + off) + off =3D insn_array->ips + 2*off
> >=20
> > Can this cause insn_array maps to access incorrect array elements? For
> > example, if a program requests offset 32 (which passes the bounds check
> > since 32/8 =3D 4 < max_entries), the actual offset becomes 64, potentia=
lly
> > accessing insn_array->ips[8] when max_entries is only 10.
>=20
> That's a question to Anton (cc'ed), not really related to this patch.
> Anton, please check and send a fix, if necessary.

Seem to be a valid concern.
We don't have tests for BPF_PSEUDO_MAP_VALUE used in combination with
instruction maps.

[...]

