Return-Path: <bpf+bounces-28549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77398BB57A
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 23:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D51A281939
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 21:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A3D50269;
	Fri,  3 May 2024 21:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqBKts97"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AA33F8F1
	for <bpf@vger.kernel.org>; Fri,  3 May 2024 21:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714771103; cv=none; b=D8QOSKSSFlkjCvOT9OFWHCcZxWAMZpr/Ie9nIGeIrXuxH4YcJVPzRx6AhalK46ni1P/tXJ48vstnhOCjXjXO5BW/nubTug6ZAsXs1dE53ZeWuw9lm/eTuWmr+WM1II+typoupHdmkXydZ2cjJdsp0Cn0x0q5DZVyaq2pQ8kCJTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714771103; c=relaxed/simple;
	bh=IRSwM3U/n7IrL8y+qXzLf9KeahiVP4P529zfC3To2Uo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lWPSRCmwprCjNSWU/wLxzYwlBw/apaMNeLOAV0eNeecX81dfQV8Ei9ne2mqM/8tT8nk0M6AAsmsQ0GpejqXo2LIHwGgftPkf5+KT/JN1+HxJbZ7/QP56zrzJ61cVMtnQfvfMCYj7R13gqmBumn1ytmTMf6cYXMGPS2g+jDTPW28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqBKts97; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f28bb6d747so133571b3a.3
        for <bpf@vger.kernel.org>; Fri, 03 May 2024 14:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714771101; x=1715375901; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oPuhRkr1fJA5SnPjVaKEd2darL7JNmMm99fNd8SEMh0=;
        b=VqBKts97PEtTlGlsUA1KQCDCoebYzOw//iD6MYBQULU+E1trNhxiOJ2DB60/Fpd9Ht
         SDwNwhgf4NFIKSK11Z6S6DQaRQrqt7TWi9ZQ2loIxRk/wpUXRHdvYUZ3d5sLpqAYYAcg
         bt0PxoPzaNbcMEfRh/KVaS64VfFr+a4tAykt4ihCJjTiWxx7fjUtZsJl2BUQ2XzumHD0
         ax/q8NTC0eUzKLORa4sPGEY1/ftO0LV+EeMdXQ7AMvaCRH6cI2Tw64k+LKeqw+FV6FGc
         T+GIpH0KsElR6X6zt2CIGeaGyvD0kUc83HoxC0av9Kc4lkt2HOmgkLVLsvMl8vYvhyeU
         VD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714771101; x=1715375901;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oPuhRkr1fJA5SnPjVaKEd2darL7JNmMm99fNd8SEMh0=;
        b=wCjR8N5AK/pG0H7xB+TCYoplig3lvSFd53ZVD9jaTn39J5wwCZzDL6Vx4k2hsBhnOd
         JuLcXVMC5tCL6jzfIFl+OzTznZo/4u/MFymiHJ1KlQA5T9NbuSBg5BBVnFLKkN9R7Dxt
         OAQG1X0RaS/oUN8XJeitzhTP3goenyXTzn2cWn5ifpFXURjoN0O27Ky8HuCpYw8+1t0+
         rFbQMCLUsBuYo+0LcfExrhQAlJ78vLZ5X7SMeg4Hj897CE+RAdYE06SXdAw/kdriEzCI
         YDKgdDhRiLxg8pPnc03qkfQnYljf+420PSCHQqJZiMz0XXIu9BkT6w6+0bEQ6zxbBbDG
         ZkYw==
X-Forwarded-Encrypted: i=1; AJvYcCUnSHXvMAj/Re7RtVKc2/P5jGWAgnT7MYKSxtL080HFoau/4tpWV9o/NqZUECIC+bKe4nniz4MBnNX2p9GKpv/WVvm/
X-Gm-Message-State: AOJu0YyYKytmae4yFgcmtz6JfuPtSenZ1Rb8Ki1hKuGyXxqEF0/ul/dm
	rvajIq9IKTIL14iYb+iHxzGX/CgUkQer9em1XnfufmNOxLFsmEij
X-Google-Smtp-Source: AGHT+IE1ztPpGEFJq9zY9B/80Kj/w43A88TDd75UA/+H2slCa2Y07yettpeYv7MEJN3EHThtR3ip0g==
X-Received: by 2002:a05:6a20:f391:b0:1a9:b7d0:b6ff with SMTP id qr17-20020a056a20f39100b001a9b7d0b6ffmr3867733pzb.32.1714771101181;
        Fri, 03 May 2024 14:18:21 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160:da47:6959:81c7:8b0? ([2604:3d08:6979:1160:da47:6959:81c7:8b0])
        by smtp.gmail.com with ESMTPSA id e2-20020a056a0000c200b006ecee611c05sm3494521pfj.182.2024.05.03.14.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:18:20 -0700 (PDT)
Message-ID: <171a007587c02ff4a8d064c65531fde318c3b4e2.camel@gmail.com>
Subject: Re: [RFC bpf-next] bpf: avoid clang-specific push/pop attribute
 pragmas in bpftool
From: Eduard Zingerman <eddyz87@gmail.com>
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Yonghong Song
	 <yonghong.song@linux.dev>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	david.faust@oracle.com, cupertino.miranda@oracle.com
Date: Fri, 03 May 2024 14:18:20 -0700
In-Reply-To: <6687f49cdd5061202ee112c38614bea091266179.camel@gmail.com>
References: <20240503111836.25275-1-jose.marchesi@oracle.com>
	 <6687f49cdd5061202ee112c38614bea091266179.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-03 at 13:36 -0700, Eduard Zingerman wrote:
> On Fri, 2024-05-03 at 13:18 +0200, Jose E. Marchesi wrote:
> [...]
>=20
> > This patch modifies bpftool in order to, instead of using the pragmas,
> > define ATTR_PRESERVE_ACCESS_INDEX to conditionally expand to the CO-RE
> > attribute:
> >=20
> >   #ifndef __VMLINUX_H__
> >   #define __VMLINUX_H__
> >=20
> >   #ifndef BPF_NO_PRESERVE_ACCESS_INDEX
> >   #define ATTR_PRESERVE_ACCESS_INDEX __attribute__((preserve_access_ind=
ex))
> >   #else
> >   #define ATTR_PRESERVE_ACCESS_INDEX
> >   #endif
>=20
> Nit: maybe swap the branches to avoid double negation?
>=20
> >=20
> >   [... type definitions generated from kernel BTF ... ]
> >=20
> >   #undef ATTR_PRESERVE_ACCESS_INDEX
> >=20
> > and then the new btf_dump__dump_type_with_opts is used with options
> > specifying that we wish to have struct type attributes:
> >=20
> >   DECLARE_LIBBPF_OPTS(btf_dump_type_opts, opts);
> >   [...]
> >   opts.record_attrs_str =3D "ATTR_PRESERVE_ACCESS_INDEX";
> >   [...]
> >   err =3D btf_dump__dump_type_with_opts(d, root_type_ids[i], &opts);
> >=20
> > This is a RFC because introducing a new libbpf public function
> > btf_dump__dump_type_with_opts may not be desirable.
> >=20
> > An alternative could be to, instead of passing the record_attrs_str
> > option in a btf_dump_type_opts, pass it in the global dumper's option
> > btf_dump_opts:
> >=20
> >   DECLARE_LIBBPF_OPTS(btf_dump_opts, opts);
> >   [...]
> >   opts.record_attrs_str =3D "ATTR_PRESERVE_ACCESS_INDEX";
> >   [...]
> >   d =3D btf_dump__new(btf, btf_dump_printf, NULL, &opts);
> >   [...]
> >   err =3D btf_dump__dump_type(d, root_type_ids[i]);
> >=20
> > This would be less disruptive regarding library API, and an overall
> > simpler change.  But it would prevent to use the same btf dumper to
> > dump types with and without attribute definitions.  Not sure if that
> > matters much in practice.
> >=20
> > Thoughts?
>=20
> I think that generating attributes explicitly is fine.
>=20
> I also think that moving '.record_attrs_str' to 'btf_dump_opts' is prefer=
able,
> in order to avoid adding new API functions.

On more argument for making it a part of btf_dump_opts is that
btf_dump__dump_type() walks the chain of dependent types,
so attribute placement control is not per-type anyways.

I also remembered my stalled attempt to emit preserve_static_offset
attribute for certain types [1] (need to finish with it).
There I needed to attach attributes to a dozen specific types.

[1] https://lore.kernel.org/bpf/20231220133411.22978-3-eddyz87@gmail.com/

So, I think that it would be better if '.record_attrs_str' would be a
callback accepting the name of the type and it's kind. Wdyt?

[...]

