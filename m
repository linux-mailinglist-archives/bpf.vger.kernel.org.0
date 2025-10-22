Return-Path: <bpf+bounces-71673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 645B3BFA59F
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 08:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E2594F488E
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 06:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611EB2F2618;
	Wed, 22 Oct 2025 06:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCG1tcqT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F96224AF0
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 06:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761116031; cv=none; b=NL+Bq6fLvuXD+rrwZehW0nen2XoSfa5VEO2T35ikAKUcg40kV98nUOz7AmXSjEiZhVh8l5XQQrpKZ0Vbl3k5YeArqtFK3fHBP314XUcMdjZGWhFdlxWVP2OCUbyZvNNESJjswPkT98iplelu/d5qNDYkuPasiZQ5YWh+tThMKRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761116031; c=relaxed/simple;
	bh=F/vphGZKH0qpQzPbpS6SNY7pmf7I05yj22+z9cao+MM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EyxLyRw+FAts3i90fcy841pMqlo4yELfR6No9W/q46NDC3LGFsg/JIXl48+YL5/vBdxc2ADnETSkFX2I2DyQb21IyJMrBVrm9tHreUe96v3UJqKAQUrqDD1PkCgZXzII+TUXB8QDKzlHhlmwxiU37o470olhNML9h4LDf3UuJKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCG1tcqT; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-78f3bfe3f69so5688711b3a.2
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 23:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761116030; x=1761720830; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SXARnwZT4spsO4NRUWFlmV6GGi8KcPnqLjj2bGNvZjA=;
        b=NCG1tcqTjxDEAyCpFMEspj91ZHGOU8TmvZTUN+jdBSRYRK0FdIwBxkM4zDDRbqghSx
         1gkUrb4luDQOXI3H4/XERsLC1FhrGHVWjqAN7kZyKjyUHpLb3DNZsvffJiFZI+Y0tACH
         b+E23UuTUfyLEay7z7oB8xiiFGqqGe7V5KlNhgULxxI+4UJNHvWdHG2v4kr9ZCIb+v5K
         1qcHXY8yxR1awo54xXhqKp3jD4FXY6PPx9LfGTEV4dCd7VNZQfN4udOumTifG7fyA/+Z
         KYmsGxnd7fmZNvcOjGEazkDcbMxTr0oeWzd1rAecIseH9ZGKchsM0M4icT/aAUsRu81S
         ZRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761116030; x=1761720830;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SXARnwZT4spsO4NRUWFlmV6GGi8KcPnqLjj2bGNvZjA=;
        b=CBB3AK/x/IrE7QYDW4yDHVyNajUgYFcABmLw7rY2uRhGAqUXc3pihMVHG19eU5kyP6
         WpzR9gxdFxy8oao8Ndrl37WKlqre1J2L1kPUtQqoSSr9zb9h9WeR3r9WFOs+TQhP5mJ7
         JtaqU/JL4w8OxXRvIUjm7HQdw6gVL0e3lhiS4Yd250EHJPlpjNfqB32ynxZ3u7iZOtcX
         bxwWO+Q0E77qdJctfzpdOy/IXmM7xNZdemn9f6AcqVIOpy+/PsnX05vrbzV5ir6wbWeH
         qxaNMIC2QrcxdKguRM2+b7LW1zNJX/039O+r8edGT1Ax4uN+1L6jrn89rRJLIbTUgncx
         5yQw==
X-Gm-Message-State: AOJu0YwL2ZwtiffQrOdmZ23HQBLoJJhbCBJJxNF4n4DZd3A/Lnu/1n2R
	/Q4bFuOo0qOscGVXbQOFTHHF+MPdSlw9UMILLmFxyRltenT9fMYPjt+K
X-Gm-Gg: ASbGncsGulSEW+SkgZMigjOARKcg2TQV7BryJ5RaCG++KaV8/CD8hVJ6LU05H+S9FuR
	alEavksegZFpC9dBwSup2A0oZzBE5xLhOGGs5q0CDdkCNtH9g/n4Svb/Dgvh0cCz/TG21dORVQ0
	Q0cLfNM6ubL8bSLx8RMe6qVCeBzadwZL5OWTgUZpdm6N4BLi3/cgLhNdb/nWLU94miR9RbEDxbF
	BXZJxt9e+JMAnEU9dgvSNjBr5AxYTkc3TVnNWMaFsPTXcqVIMhNLd5TZFJLEDWExog3KQuXHJT1
	4fBQfJOjn+MAVwfS6d5s7HF2QVtixfS5xSQ3tJeXFur1aIZMmNaiGUnq4HZkvwH2TfLndXZwsa4
	jto9/F8vZ4T+bEmDNewL8ayiaYoRuakJiAGKCkCmTshYQ1WVmLvtfFKn+xiiiOkaf6ECW2ZFh
X-Google-Smtp-Source: AGHT+IGIS+hAHCDlATOmVlc7RZ7oYUF3yr6Rtwo6xhtP5JEu5q5qyr/fSP+75tiKt8rAG0OTPR+Icg==
X-Received: by 2002:a05:6a20:6a0b:b0:32b:83bf:2cdb with SMTP id adf61e73a8af0-334a8524332mr27402947637.15.1761116029767;
        Tue, 21 Oct 2025 23:53:49 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b36188sm12269241a12.27.2025.10.21.23.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 23:53:49 -0700 (PDT)
Message-ID: <ca9b352ca29f34cfac52f969f25fee204e25fb6f.camel@gmail.com>
Subject: Re: [PATCH v6 bpf-next 10/17] bpf, x86: add support for indirect
 jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Tue, 21 Oct 2025 23:53:45 -0700
In-Reply-To: <aPh+9Lw+vmD1nXqY@mail.gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
	 <20251019202145.3944697-11-a.s.protopopov@gmail.com>
	 <c3de352f15a5004c48f4b37bfb4294f6602ec644.camel@gmail.com>
	 <aPh+9Lw+vmD1nXqY@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-22 at 06:51 +0000, Anton Protopopov wrote:

[...]

> > > +/* gotox *dst_reg */
> > > +static int check_indirect_jump(struct bpf_verifier_env *env, struct =
bpf_insn *insn)
> > > +{
> > > +	struct bpf_verifier_state *other_branch;
> > > +	struct bpf_reg_state *dst_reg;
> > > +	struct bpf_map *map;
> > > +	u32 min_index, max_index;
> > > +	int err =3D 0;
> > > +	int n;
> > > +	int i;
> > > +
> > > +	dst_reg =3D reg_state(env, insn->dst_reg);
> > > +	if (dst_reg->type !=3D PTR_TO_INSN) {
> > > +		verbose(env, "R%d has type %d, expected PTR_TO_INSN\n",
> > > +			     insn->dst_reg, dst_reg->type);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	map =3D dst_reg->map_ptr;
> > > +	if (verifier_bug_if(!map, env, "R%d has an empty map pointer", insn=
->dst_reg))
> > > +		return -EFAULT;
> > > +
> > > +	if (verifier_bug_if(map->map_type !=3D BPF_MAP_TYPE_INSN_ARRAY, env=
,
> > > +			    "R%d has incorrect map type %d", insn->dst_reg, map->map_type=
))
> > > +		return -EFAULT;
> >=20
> > Nit: we discussed this in v5, let's drop the verifier_bug_if() and
> >      return -EINVAL?
>=20
> So, I think this is a verifier bug. We've checked above that the
> register is PTR_TO_INSN, so it must have map and map type should
> be BPF_MAP_TYPE_INSN_ARRAY. Now this is always true, for future
> I added these warnings, just in case. Wdyt?

Wellp, yes this is a verifier bug, thank you for explaining.
Sorry for the noise.

> >      > The program can be written in a way, such that e.g. hash map
> >      > pointer is passed as a parameter for gotox, that would be an
> >      > incorrect program, not a verifier bug.
> >=20
> >      Also, use reg_type_str() instead of "type %d"?
>=20
> This is map type, not register? Ah, you maybe meant the first
> message, I will fix it, thanks.

Hm, right, doesn't apply here, but helps with the first message.
It looks like we don't have a similar function for maps.
But that's a "bug", not verifier message, so probably fine.

> > > +
> > > +	err =3D indirect_jump_min_max_index(env, insn->dst_reg, map, &min_i=
ndex, &max_index);
> > > +	if (err)
> > > +		return err;
> > > +

[...]

