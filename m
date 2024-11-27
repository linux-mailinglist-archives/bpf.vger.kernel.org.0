Return-Path: <bpf+bounces-45666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E25F19DA003
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 01:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2CE0285369
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 00:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA88DDC5;
	Wed, 27 Nov 2024 00:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQ/6vGRz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3453DC8FE;
	Wed, 27 Nov 2024 00:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732667454; cv=none; b=FYJWv6z8lXfPdPBO+sxkERbashjZMIAj1ZBlCt2r2N3X3ESAS+5cDOUijHnKUmXCP3hqxLvFLMZ3q8n9b+knU88Ecl4mK1ETFz1Edr/X3IwTD1N5jkigiLY81gUgbKAGtjPneJisC6W7RpQa6R/jO/XqAlrE4BnBc0tjNc1mquY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732667454; c=relaxed/simple;
	bh=3qEFGNwL7tBfo43htStj+/Swd7nSlEqy4fAivZCfoq0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BaJ3PjxghqIYw7kRBEwiIZQX+/v8lT+h5ijhb2voN+L3PaiaksKcgtHfQZ1icYTy1II2Fo9M/DdJXrnEmarInAVPxcKu5cmctIuWoL8tjZNbewN5iKOD8+A3IG0qOULMxDgWqDuF9wT5ua5DcrO0BL15uQjjtv0TQDJTEyZLv10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQ/6vGRz; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7f46d5d1ad5so5157935a12.3;
        Tue, 26 Nov 2024 16:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732667452; x=1733272252; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8Tm/28sX7XbLq+0lE5feUXECP+wmu5qLRQRQ2+hOQcg=;
        b=kQ/6vGRzeZMZLP38pSjnjdjddcqnqcZ0V34Xlv5dIn4yEvC9z7PynSpbOiKp2RUWDB
         KAc26tvPdwH6nZRxBZgfoskso+TcWMnl8HuPgdYnR8/QRGAmKFsTakn9Gsiho6ksOc+k
         M8GMnbgpUWN8+d9oJdBmSoX8Q54sdmtS92eqIuh765d1Jf1GkO0Vs0ZpCqGelOLkjIrL
         UZO1aHntbIdHplIshJfOUJ7MAuP/6CsHDslrCv8nHOa5xgi4I2Je/oSUuOiXtEAX+GaA
         m4SEm5SqElqG+SocPf2ronaIAG4QJS1bCIIk18LvBRDldvxe7vyPN5SOC4n9bgnS1rpG
         OdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732667452; x=1733272252;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Tm/28sX7XbLq+0lE5feUXECP+wmu5qLRQRQ2+hOQcg=;
        b=o5Q3r5L+p4gIz4OGfT3EMfmNjEXjEi3+vgHK0i5+32HgRw41xYlfZcsukwCrqMOS68
         fUUTKHVQXJNnyJ/DFNewDizItupmQgxZuuS27FKHlfelRtgUvLCT/qocY4xOVqY3+Gbc
         SxHMCacj6eOQVj8dx5pSzGL+YjRvuX7cvMpPTpnD3hYIti2ZtClp5TwLiDoZt7nMRQgG
         /YVSMbznb1QZJkhzCMgHpqV9gBBlENqSiTMOLl6+KLZVm2mcYNzRbF93IsZXHmSAvjH4
         75S/fIWvF1LsCmvTViTjPpNFobyDtHrWZS6RIsfh69wwWEw8WIRlJr9WK4VJQhDrjfgQ
         2nhg==
X-Forwarded-Encrypted: i=1; AJvYcCVILQ72nTwNnwMn1JOLNd2bDLyC7XZhiN8yAkR/cOeTqJSNKdAD34B4sHAsfUOVhK54Njk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR/D6TxWzIUQ5E5bpj1e86BqMpEAdXuKISttJqvYbJgApEfCwn
	hMMOG71MBo90TNQlnaQK74KlpZ/jY0fCXf1UOC0VIE1T2I5YphVM
X-Gm-Gg: ASbGncuBTmE6AKFYnDiJQnpVcSzWy/2Zq79Q5AyhwL35HHw7uYwwGNDylnGr7o9g007
	diC6YX37jcqjJ7ulaeSxmu7VCigryQ+Py5O8RO5mm39ipn1GgHgkBUMi9yDNtCcIveoraFYWQiw
	ryZIZJCJ3S82jv+s5ZWUBEYbxjjvtO4W8AFoKBALew98FepOTclVaxEfPKxz9wkyN9Da4EOV9vL
	W1aQh3Zt8qZb3PXpxYUUiheEgOnvHbkXHhel4+aT1x6UWI=
X-Google-Smtp-Source: AGHT+IE+PjhQo6fapXdUJQbuu4UTdttropjsbVzP3tJ/lMg/O9Msl6paqQHUFQBSwTZK7En0/4Qw2Q==
X-Received: by 2002:a17:90b:38cd:b0:2ea:addc:9f51 with SMTP id 98e67ed59e1d1-2ee08e5e3e0mr1629057a91.2.1732667452506;
        Tue, 26 Nov 2024 16:30:52 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fb0df0dsm164373a91.44.2024.11.26.16.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 16:30:52 -0800 (PST)
Message-ID: <8744c86ba355245f7ecc14d00351c82285fbf644.camel@gmail.com>
Subject: Re: [PATCH dwarves v1] btf_encoder: handle .BTF_ids section
 endianness when cross-compiling
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: dwarves@vger.kernel.org, arnaldo.melo@gmail.com, bpf@vger.kernel.org, 
	kernel-team@fb.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, 	yonghong.song@linux.dev, Alan Maguire
 <alan.maguire@oracle.com>, Daniel Xu	 <dxu@dxuuu.xyz>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Vadim Fedorenko	 <vadfed@meta.com>
Date: Tue, 26 Nov 2024 16:30:47 -0800
In-Reply-To: <CAEf4Bzb-PMAs7+B85qanUinQrk4aVs4Qk6orbyDP11uBcW-mWA@mail.gmail.com>
References: <20241122070218.3832680-1-eddyz87@gmail.com>
	 <CAEf4BzakAiPWF9x2h-F737LbJ9ovXCJLbXV9R5vKg0Et5CbqSQ@mail.gmail.com>
	 <69af35e3718748b99e4d295bead4072588a50296.camel@gmail.com>
	 <CAEf4Bzb-PMAs7+B85qanUinQrk4aVs4Qk6orbyDP11uBcW-mWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-11-26 at 13:51 -0800, Andrii Nakryiko wrote:

[...]

> > When I tried 'data->d_type =3D ELF_T_WORD' + gelf_xlatetom() snippet
> > suggested by Tony Ambardar some time ago, I got a write protection erro=
r.
> > Concluded that this is so, because file is opened in O_RDONLY mode.
>=20
> Ok, maybe don't follow my words *exactly*, just in spirit ;) I see
> there is elf_getdata_rawchunk() API in libelf, which seems useful:
>=20
> /* Get data translated from a chunk of the file contents as section data
>    would be for TYPE.  The resulting Elf_Data pointer is valid until
>    elf_end (ELF) is called.  */
> extern Elf_Data *elf_getdata_rawchunk (Elf *__elf,
>                                        int64_t __offset, size_t __size,
>                                        Elf_Type __type);
>=20
> I don't know the surrounding code, I was just hoping to leverage
> libelf's byte swapping support (which I think I learned from Tony as
> well). But if it's too inconvenient, so be it.

I missed this API, it works and makes the patch much smaller,
thank you for finding it.


