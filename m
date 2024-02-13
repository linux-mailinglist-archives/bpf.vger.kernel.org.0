Return-Path: <bpf+bounces-21815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8979D8526E6
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 02:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 404AA28198D
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 01:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580763D6D;
	Tue, 13 Feb 2024 01:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="eXB4vHiz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653E310EB
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 01:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707787113; cv=none; b=KvL5/yt0ErrUFF75sH47NCdtmizNRU5SH7uAnPG2INJpgfIxumRuPfNdT5Bp/2YAySv7rHKnzKIOX9lk6uFwFdqPjZgBC8EMayE97P+8O+N1GtcsyLojFqMeakaVO7o7vA+YdHVxapWP1MY/u2ht3hhS11Xea338N+c7uDy91mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707787113; c=relaxed/simple;
	bh=2nGoxm+WjZU6AVea51wZ3M/eN1iAEyQQ/ziXUflo/PA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ATm3LCJXPz9k29l6uytK6H+E7zpmZluwuQvtW8/sJs5NOj28Hi2aAs2oMNJjJoo6vf5YSZUjWh205xpLULdQCT6gOD7SBsw8vorzo3Oev8D/a9bVMmQWc2OE/89eBtQCAfaOd3s1IJUXQZtuIg3qkRndDpAeFVe3qHmuUZmyL+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=eXB4vHiz; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e0a479a6cbso1269446b3a.0
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 17:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1707787110; x=1708391910; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=r/iL9hk9z65BlWcihXx6WQ/ZeCAECR3zF2bC+FtSh4c=;
        b=eXB4vHizo+QzdyaAXVIcGRyhf4KmdjZayNNw3RmT+Eg9R5NMHN555pFbxQdcdBfcrO
         VOgjYUnzykCrA4MB9dxQ4pu4jL2YoFX172wb78HRDCCZwp6yc9M8H78noMjUvTySt8cQ
         vNQK7KY7mceXjXoI4CRdLOAoTr/wi1FdOjQbCdJqampvuP0LwxEYrmlRwM8OIZrfm0oc
         9Mu2E2TCnDvpt6ssuAm4gnew9XBbS82Y3+YfbQOmTPlzvVSQcB13KDPohmimkQBfX/AU
         K8wpJ2gLkuu2VLIERa4f9Rn/b7E85fBgf9AvtzCEix2akj6Iw71mnplwyvuSWQZVLDyt
         fmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707787110; x=1708391910;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r/iL9hk9z65BlWcihXx6WQ/ZeCAECR3zF2bC+FtSh4c=;
        b=Pi9CQAHv3qrWvY/PK+MX+BZ7mUVKVsAib6xt85bH85XBtii++91yYS4pnkt47arfxQ
         KptIxZrCUexX0BA0hQ8Xqa+TDCJZDRvn3KARMUzc4ILVh4seWXQm+/o0wELAvvOAu4vj
         G4ARAauDHCJ/h/wIQ0HfYu4VTq0jFOK5OmmeNjiX6lxAmcFihdbQ18be3GvHT3DGfEQ2
         JPHaAZdBLQ98+jMDkx/PEhggVnisWQ9TT8pL8ZRPLH9gJo1aCM0SRDZkJunsQj2Yn0Nk
         gxg+aQI+z7ZlFHdyRzCpsQSU6pSGakylv5gYLfhetiZxD4R9LwEPRWsmFdH6dSBX10Xa
         JhFg==
X-Gm-Message-State: AOJu0YwmkQbQunNZM2FHEbN7ol3909BxMyeeluhp0vxQOgZmSGmCwudO
	05iUVRP3Hg2sO4sDLotkfi8/1ZhDUdSwBAeNduVmv7GzgX0/G1QzoeDKdMjmr+s=
X-Google-Smtp-Source: AGHT+IHsjdMXpUH31e+aKErlxkbLoYrBL9hMng63nigj5d/ZtUOaFvXsf00AfWfVTcPMeEzG/buJEQ==
X-Received: by 2002:aa7:8557:0:b0:6d9:b941:dbf5 with SMTP id y23-20020aa78557000000b006d9b941dbf5mr7120874pfn.11.1707787110538;
        Mon, 12 Feb 2024 17:18:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV6siuus/c8HjoUW/4yK2KePDSVjB+bW40vpXQ6kB16ljjH1qBwaPmH1EvkBRsL7UoX/0xMsnHf4eRVnm+d/oL075MV+Z+SL/Fbop/WriCIV1m1vEgrMw==
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id b18-20020aa78712000000b006dfbecb5027sm6341097pfo.171.2024.02.12.17.18.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Feb 2024 17:18:30 -0800 (PST)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Yonghong Song'" <yonghong.song@linux.dev>,
	"'Jose E. Marchesi'" <jose.marchesi@oracle.com>
Cc: <bpf@vger.kernel.org>,
	<bpf@ietf.org>
References: <20240212211310.8282-1-dthaler1968@gmail.com> <87le7ptlsq.fsf@oracle.com> <b5072dfb-ab2b-40eb-891e-630a02c58fe8@linux.dev> <036301da5dfd$be7d1b30$3b775190$@gmail.com> <a81da29b-b671-484a-8f3d-743f1dac44f1@linux.dev>
In-Reply-To: <a81da29b-b671-484a-8f3d-743f1dac44f1@linux.dev>
Subject: RE: [Bpf] [PATCH bpf-next v2] bpf, docs: Add callx instructions in new conformance group
Date: Mon, 12 Feb 2024 17:18:27 -0800
Message-ID: <03a801da5e1a$8d0274c0$a7075e40$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKk5nBwvPPKgL8m8zzpY/2G4YK4bQLYE4TWAif8DTYBtYA5rwFjf1HurzGcgzA=
Content-Language: en-us

> -----Original Message-----
> From: Yonghong Song <yonghong.song@linux.dev>
> Sent: Monday, February 12, 2024 2:49 PM
> To: dthaler1968@googlemail.com; 'Jose E. Marchesi'
> <jose.marchesi@oracle.com>; 'Dave Thaler'
> <dthaler1968=3D40googlemail.com@dmarc.ietf.org>
> Cc: bpf@vger.kernel.org; bpf@ietf.org
> Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: Add callx =
instructions in new
> conformance group
>=20
>=20
> On 2/12/24 1:52 PM, dthaler1968@googlemail.com wrote:
> >> -----Original Message-----
> >> From: Yonghong Song <yonghong.song@linux.dev>
> >> Sent: Monday, February 12, 2024 1:49 PM
> >> To: Jose E. Marchesi <jose.marchesi@oracle.com>; Dave Thaler
> >> <dthaler1968=3D40googlemail.com@dmarc.ietf.org>
> >> Cc: bpf@vger.kernel.org; bpf@ietf.org; Dave Thaler
> >> <dthaler1968@gmail.com>
> >> Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: Add callx
> >> instructions in new conformance group
> >>
> >>
> >> On 2/12/24 1:28 PM, Jose E. Marchesi wrote:
> >>>> +BPF_CALL  0x8    0x1  call PC +=3D reg_val(imm)          BPF_JMP =
| BPF_X
> >> only, see `Program-local functions`_
> >>> If the instruction requires a register operand, why not using one =
of
> >>> the register fields?  Is there any reason for not doing that?
> >> Talked to Alexei and we think using dst_reg for the register for
> >> callx insn is better. I will craft a llvm patch for this today. =
Thanks!
> > Why dst_reg instead of src_reg?
> > BPF_X is supposed to mean use src_reg.
>=20
> Let us use dst_reg. Currently, for BPF_K, we have src_reg for a bunch =
of flags
> (pseudo call, kfunc call, etc.). So for BPF_X, let us preserve this =
property as
> well in case in the future we will introduce variants for callx.

Ah yes, that makes sense.

> The following is the llvm diff:
>=20
> https://github.com/llvm/llvm-project/pull/81546

Which llvm release is it targeted for?
18.1.0-rc3? 18.1.1?  later?

> > But this thread is about reserving/documenting the existing =
practice,
> > since anyone trying to use it would run into interop issues because
> > of existing clang.   Should we document both and list one as =
deprecated?
>=20
> I think just documenting the new encoding is good enough. But other
> people can chime in just in case that I missed something.

Ok.

Dave


