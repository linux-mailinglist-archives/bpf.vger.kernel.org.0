Return-Path: <bpf+bounces-72936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA774C1DD44
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 00:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186B418891C1
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 23:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C230322522;
	Wed, 29 Oct 2025 23:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gtoj1i58"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296D332143F
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 23:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761782104; cv=none; b=eKPq2cRQ/9iezCMKbXY6PkbnDH/QeJQCAwo+VK8VEFYfOQr8hdVYNPSlPmAd4fLqAldGumVcMH5OUP35/1SkR/lRk0HESyEriJ8t9+/K5a1mcEOpHR2b/iRN/vd4oCv4VK7v9nuFaJF6fv5byYrWkDm1MJgA0CZ0P6vRB1MByJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761782104; c=relaxed/simple;
	bh=CYuA3OD7N1VyOHmj72f8JRfLIC7SK2GyTfK04raeZz8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rm4jf7zEZnchkSpbrGwx0wIQwaFRfXMqCO/g4C41fjo2usHuXZucyJQbe4DEkUysRdLlSIEQwudREyFrKXur7PdcbTYUi4Yj+OiLcLQKqx5n4YG8FH6rLs3YgJEbXPCDSXc1g8y9docYcTZ8j7YY/2GIlzpa7q/n6zXcEMrmlQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gtoj1i58; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b6cf1a95273so255442a12.1
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 16:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761782102; x=1762386902; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lODhMav5p1K71nbHvBAouQHLQOzUWHcWHd+5BKoeR1c=;
        b=Gtoj1i58LcAU60pZCZ5gB4EGCXj/+K/1GkW0xg9MzOecBHCllhxCKzCO24LjpfE6QE
         eLym776yHabv7Q4ccbiU6mmJ/yJd8VRPNRqgWmXgNShAgYD8ERuxaUTMlNaHMP39B104
         rZLvssqNiJvt8xVJjNeX7mVMjGR4PwjWreg9sYF2xvRKcuQuU4ooZAD+sV4TtQNdCQHB
         6D1YrI240QjV6O3IeZD5EKl8n22dmW1vrFFxPSv+9TTYo4DzW9r1WZDVvdU4Uk6tcWKn
         dR6nzkgCNFXjQ7rkjyTH/3GXzeEb94DKnUxiCf74QXPU5cpPopmLhK9l+FI+NjUxs+7A
         KXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761782102; x=1762386902;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lODhMav5p1K71nbHvBAouQHLQOzUWHcWHd+5BKoeR1c=;
        b=KiNWTZGF8l9UsHSNROQYJC7k+GLY5n7O96In3/jqPQJM+Hjir9215kPaO6gpu4dYCC
         f3nG1CKjs9ad1epYcN1wkcFvlVft662YKNmdV3TGTBDZEpItoOo0B7d5TVN8carnfxzI
         SX+WMUBscLkNY0DLtZuSTI5fNOGOuVXYySfeRSIYT9cP6tklF9mvDGq9ShOeLIrDHji8
         cZHEqlvBseF8s6dM+wOiy0LwqP8PItC6RQ6/d11ROyqzW9Lry9HZ5koeE58Ob9SvHf1N
         rqIwv6tlKWfzFhiBqg0OMSt5ESCqrLO34r3kbzmcnS0VZLhp3e6M0i9oh5Q1S5Np/mt1
         hDSw==
X-Forwarded-Encrypted: i=1; AJvYcCX3fqvP8RTHp6W9CDVdCki2R9X08x4JXCh/XvH8tXacmmMuFqkfwJE/CSTaT3LBJr+zACA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoUzjIf3Q4uCV7/lZIOAv6HfL0I5jcwylTPtRYu2RGXSPbNYsX
	fRriiYORJNYxnZZ4y62HlIT7+Utfs93ksxb5yyFezPLYQZWZP8QqJPbo
X-Gm-Gg: ASbGncuu+nnZrsEZscI1eO3BeuTAD+jYKMvOl6U2zBBnTijgol7+QqWVeCGCxX9d9Cg
	AYhHxhRRKfBaDztGZg/oLEd84J9B0KAEdncRTtNP/4SybN0xsYVqN26PRD9PilracbBj9cmSiRS
	cTyuSR+Qd52NAczFv2ny5IKye3Y8WsbchH7O9iidGbJvl/AnoA4CaztVlSokqFOkPQxSqqRdPNl
	VqFCNlVecpdDBvUQBz2GmmwFWYCf5M03pDTupg4dkZNDo8Nm41Go2iGNuh/yQmEXCDEke/6xE02
	hR4r2qcBEONitq56XLxU5wvlUn+ycsVN2tB+NIhLtz4yohLbxBzQSNzCVo8qJuwWT5A5UPCDq/L
	OQ2f5UPK7/h6Sgq3qHA1ifg0RBc68L3bguc0G8AJpORfgJWT9HGyr8/Fqcx26gfGiw0CVXVGL3/
	hlTftAlPuaEPNIhqIdbdTOLdMdVvGl/XBQKr1sEGoHakPHqM8=
X-Google-Smtp-Source: AGHT+IGSab5b/K48kjoDAIw5ovbxTQ1bdqBd16anwHKOLxBIj1YWvYElMA79LCrE9dJiCPT/HKFH5g==
X-Received: by 2002:a17:902:7448:b0:27f:1c1a:ee43 with SMTP id d9443c01a7336-294deebc4fdmr35815395ad.29.1761782102406;
        Wed, 29 Oct 2025 16:55:02 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:3086:7e8a:8b32:fa24? ([2620:10d:c090:500::5:6b34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf49easm166854335ad.9.2025.10.29.16.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 16:55:02 -0700 (PDT)
Message-ID: <ddf506c9c5c5e9fbfd2c1b7d99bc4d2307fc702d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/8] bpf: Refactor btf_kfunc_id_set_contains
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, 
	andrii@kernel.org, ast@kernel.org
Cc: dwarves@vger.kernel.org, alan.maguire@oracle.com, acme@kernel.org, 
	tj@kernel.org, kernel-team@meta.com
Date: Wed, 29 Oct 2025 16:55:00 -0700
In-Reply-To: <20251029190113.3323406-3-ihor.solodrai@linux.dev>
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
		 <20251029190113.3323406-3-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-29 at 12:01 -0700, Ihor Solodrai wrote:
> btf_kfunc_id_set_contains() is called by fetch_kfunc_meta() in the BPF
> verifier to get the kfunc flags stored in the .BTF_ids ELF section.
> If it returns NULL instead of a valid pointer, it's interpreted by the
> verifier as an illegal kfunc usage which fails the verification.
>=20
> Conceptually, there are two potential reasons for
> btf_kfunc_id_set_contains() to return NULL:
>=20
>   1. Provided kfunc BTF id is not present in relevant kfunc id sets.
>   2. The kfunc is not allowed, as determined by the program type
>      specific filter [1].
>=20
> The filter functions accept a pointer to `struct bpf_prog`, so they
> might implicitly depend on earlier stages of verification, when
> bpf_prog members are set.
>=20
> For example, bpf_qdisc_kfunc_filter() in linux/net/sched/bpf_qdisc.c
> inspects prog->aux->st_ops [2], which is initialized in:
>=20
>     check_attach_btf_id() -> check_struct_ops_btf_id()
>=20
> So far this hasn't been an issue, because fetch_kfunc_meta() is the
> only place where lookup + filter logic is applied to a kfunc id.
>=20
> However in subsequent patches of this series it is necessary to
> inspect kfunc flags earlier in BPF verifier, in the add_kfunc_call().
>=20
> To resolve this, refactor btf_kfunc_id_set_contains() into two
> interface functions: btf_kfunc_flags() that does not apply the
> filters, and btf_kfunc_flags_if_allowed() that does.
>=20
> [1] https://lore.kernel.org/all/20230519225157.760788-7-aditi.ghag@isoval=
ent.com/
> [2] https://lore.kernel.org/all/20250409214606.2000194-4-ameryhung@gmail.=
com/
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

This preserves original semantics, as far as I can tell,
although a more logical split for API functions seem to be:
- btf_kfunc_is_allowed()
- btf_kfunc_flags()

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


