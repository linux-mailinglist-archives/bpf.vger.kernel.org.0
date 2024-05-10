Return-Path: <bpf+bounces-29560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ABC8C2CDC
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 01:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB6CAB2251A
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 23:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4195F17556D;
	Fri, 10 May 2024 23:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isliUz8e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7514D16F0DA
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 23:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715383043; cv=none; b=J1Xlesbj3d0ehOlV+YBNoygGNIT55KbkRre49X4c6GoK4pxxaesf039x9Yc6MWeYxai0ZUrweIXpyZlODc8D1xQmQVDsYUn9tdgbmQYkrTBIiARQqRGYwBYtBoXAHHPIINtXJHpZpNfxV86C8me5cC9U0bqRHMuiq/fjNEkhgL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715383043; c=relaxed/simple;
	bh=NTPMECqa0K4/0dKdCMWd3E6iTp49ODVJwdafM121rqg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bb308svJ3fe5K67+ly4+FpCdGxmYXlDWuK/BFF5glz/qXRYATLvggaK14Mj0BbkMbuAV2jQu+3w7B2RW69BOyTPfPXtazmxPxl8dv1XKyLa6EFQg8iUzkp/Za0ouubuNKUT33y5P56ozBQJRI1kFUTa6TrPq+X1nRTgJAhU4/SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isliUz8e; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2b38f2e95aeso2598765a91.0
        for <bpf@vger.kernel.org>; Fri, 10 May 2024 16:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715383035; x=1715987835; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TpQQn0DhZiDVzpplovhy61d74hroM1tP+HIktW0vNlk=;
        b=isliUz8eoa5GOSEuPW0DH/AXWaYYJexEYjdTd7p4H6ExrBKjf0LsVtUM+DeaUxP/bD
         IiPF86/QGmlOD2fmkFy+XI01ROy4a4X3K0wTdmTvA09Q0KdySCbUmOwlDFpD/O4SiwJI
         bWtpAA2hpwWD/eS34LofaxUj2DCwjAcchHKR4qU0rU6zKiswRJ+Mo2lBD/vQeCETT2AR
         HPfcP66obfhrUky7mSkmFKFcFheIimPTtqaJ5Ket34/+WLboObk7wKLAU2Iqpz4Elsn2
         iwBjtd9/BZgnIHVUrXBtDo2AkXuG5zFFuGHT7bC/YV4s2+Rb1zR3F2RxM5J1FjULavrj
         OGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715383035; x=1715987835;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TpQQn0DhZiDVzpplovhy61d74hroM1tP+HIktW0vNlk=;
        b=XktsrHzSgU/lDW9Yo6gO/jSTJXPCtV3WKa5uTWoxcB9Fi9STWeJnqtF/eni9C5pUnn
         mnokPwsEfFynmHNTpMERuWKm/44B/aB6oEjSriqZVrzIKRyDv+6PkNrb9h2fSn+xiWuS
         vR8SP2wPfMtSfOswuaeqlxREJzyZn5u/p+lTI/hGcEz07yONqtr9WWlu3RP6LFskTBaq
         W2NWhgh3u77jfBXqnX8hCNheGNgHElWIQkNnjQ+InFJ3NmVwVEuIouBBw055iXoU2ztJ
         VhtWtKOG/+g3ARG6k7AmZikai7Fq+qRlM1IHfAlRbnjkrWCY+ItRrA8gP+1Km7/BGCE4
         Q+Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUClqsP9bsXJj3PnNn1pF35CpNvv3jM27H6NyTofWibRTyXSMDZme0AEuqm+gl0I4Q8dEzY5NapT4GwiHRIoPX9yBxa
X-Gm-Message-State: AOJu0YyE5twPJ3l472otH4UQrNKXfgDiLn8D1t7KpStCYW8e0oufIcUg
	0pet8ockcW+9CaNeFePdGjYRiULMQYHvBeNCR+c/Tqnzq4+ixhZO
X-Google-Smtp-Source: AGHT+IElMfUALC7pLilKW9AiBv96anI0AD5Hrl1XMUcvLqyZIYv2BR8Hc+HqskhwBPZL30pC/c7nzg==
X-Received: by 2002:a17:90b:98:b0:2ab:8e59:9da9 with SMTP id 98e67ed59e1d1-2b6c6ff020cmr6017774a91.6.1715383035418;
        Fri, 10 May 2024 16:17:15 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136b24sm37723665ad.255.2024.05.10.16.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 16:17:15 -0700 (PDT)
Message-ID: <cfe0145e88727ccb23be8728671649eb0ffb61ae.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 7/9] selftests/bpf: Test kptr arrays and
 kptrs in nested struct fields.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>,
  bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org,  kernel-team@meta.com, andrii@kernel.org
Cc: kuifeng@meta.com
Date: Fri, 10 May 2024 16:17:14 -0700
In-Reply-To: <f2d480de-a598-4771-9c72-722dba941e83@gmail.com>
References: <20240510011312.1488046-1-thinker.li@gmail.com>
	 <20240510011312.1488046-8-thinker.li@gmail.com>
	 <d8f2fa21a9af5bfcb2acb1addecea435285c40e6.camel@gmail.com>
	 <d2b9a943-ca26-404d-899a-c7651ce18a42@gmail.com>
	 <62a51fcaddbf5eb8552a96e6a24ded83f8f9fa49.camel@gmail.com>
	 <aa0cb7c8-f057-4f51-84c4-2cc9bc4e2edb@gmail.com>
	 <a938837ff87adcdebaa58f612395dee06a0ea94a.camel@gmail.com>
	 <52912c4f-219a-45d4-bb61-aaeadaf880c5@gmail.com>
	 <e65e8c7d387312f4b13a1241376ad6b959f90bf7.camel@gmail.com>
	 <f2d480de-a598-4771-9c72-722dba941e83@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-10 at 16:04 -0700, Kui-Feng Lee wrote:

[...]


> I am not sure if I read you question correctly.
>=20
> For example, we have 3 correct info.
>=20
>   [info(offset=3D0x8), info(offset=3D0x10), info(offset=3D0x18)]
>=20
> And We have program that includes 3 instructions to access the offset=20
> 0x8, 0x10, and 0x18. (let's assume these load instructions would be=20
> checked against infos)
>=20
>   load r1, [0x8]
>   load r1, [0x10]
>   load r1, [0x18]
>=20
> If everything works as expected, the verifier would accept the program.
>=20
> Otherwise, like you said, all 3 info are pointing to the same offset.
>=20
>   [info(0offset=3D0x8), info(offset=3D0x8), info(offset=3D0x8)]
>=20
> Then, the later two instructions should fail the check.

I think it would be in reverse.
If for some offset there is no record of special semantics
verifier would threat the load as a regular memory access.

However, there is a btf.c:btf_struct_access(), which would report
an error if offset within a special field is accessed directly:

int btf_struct_access(struct bpf_verifier_log *log,
		      const struct bpf_reg_state *reg,
		      int off, int size, enum bpf_access_type atype __maybe_unused,
		      u32 *next_btf_id, enum bpf_type_flag *flag,
		      const char **field_name)
{
	...
	struct btf_struct_meta *meta;
	struct btf_record *rec;
	int i;

	meta =3D btf_find_struct_meta(btf, id);
	if (!meta)
		break;
	rec =3D meta->record;
	for (i =3D 0; i < rec->cnt; i++) {
		struct btf_field *field =3D &rec->fields[i];
		u32 offset =3D field->offset;
		if (off < offset + btf_field_type_size(field->type) && offset < off + siz=
e) {
			bpf_log(log,
				"direct access to %s is disallowed\n",
				btf_field_type_name(field->type));
			return -EACCES;
		}
	}
	break;
}

So it looks like we need a test with a following structure:

- global definition using an array, e.g. with a size of 3
- program #1 doing a direct access at offset of element #1, expect load tim=
e error message
- program #2 doing a direct access at offset of element #2, expect load tim=
e error message
- program #3 doing a direct access at offset of element #3, expect load tim=
e error message
If some of the offsets is computed incorrectly the error message will not b=
e printed.

(And these could be packed as progs/verifier_*.c tests)
And some similar tests with different levels of nested arrays and structure=
s.
But this looks a bit ugly/bulky.
Wdyt?
>=20

