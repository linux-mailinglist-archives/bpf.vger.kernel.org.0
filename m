Return-Path: <bpf+bounces-29474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA708C259A
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 15:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFE421C22009
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 13:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66CE12C467;
	Fri, 10 May 2024 13:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNxMq7yf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC7D129E7A;
	Fri, 10 May 2024 13:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715347427; cv=none; b=CwjVv3cWtfhzut6sq+Dvk8W90v+55AfRTM6Q0teYmMeHcZviCvVB3m3IFk5R84TRNhHzJRoYrORBY8Voc0OxxtiBE6Z8ZYaUimeP62yvgokjDgSIH/WCRqZsSREqOPeBWBNPR01P/yOt0DY8U8O+QYM6P0nLWeifwfOUDg3QC8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715347427; c=relaxed/simple;
	bh=QOfNmHJaxWSvaeChuVTWYm97k8EwY+/Ds6fY7S3tHG0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jrIORtPb26F7UzfAr9xpG1Vw+gWbfqX1dE2K42wop4ONOFum7o6GOe/7P1OAc02G3fLQnK+uRR3md3peyfu5Abj81Ir4yoluB9LiY9sGiBzphW+9oioL4CTr+KOPrda8J1gkGlH/vf5pJlL1yTwgB8s7i+2DGxTMLWUzb8WlCGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNxMq7yf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5F5C113CC;
	Fri, 10 May 2024 13:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715347427;
	bh=QOfNmHJaxWSvaeChuVTWYm97k8EwY+/Ds6fY7S3tHG0=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=oNxMq7yfT5qla44ObK4W/cm54NqR+cbX0qJMQDqk4RTboCuabz/5h63mQaQeTlh8Y
	 17EimdMwNPm1TT3iZCpp/UDQAePNJwZZ35oko6ACx2slPyVWx7JlIZ9RigHvCKYveD
	 eJbALWiOnp+8Z2rWu+drtxFQnOtOyhMCPAis9xeAXZU9o85zAjad3NHRcgNwwV6hvU
	 qpapanK9A2gyvTuq/k88LahJQJX/XqvlrlKAE8Xf1OJPZJw8G0w0T5r50IRRaplH5S
	 zholKMXpqY9hMzahWviVCrEI3k7VBiYCU/YTWINZYZl4oQr/KmhqlJkk1jbao4cVP8
	 8bMW/xcfA1Ldg==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH bpf-next v10 5/5] bpf: Only enable BPF LSM hooks when an
 LSM program is attached
From: KP Singh <kpsingh@kernel.org>
In-Reply-To: <CAHC9VhS6hckf+xzhPn9gNQfFDiQhiGyJuzGVNXB=ZAr=8Af37w@mail.gmail.com>
Date: Fri, 10 May 2024 09:23:43 -0400
Cc: Kees Cook <keescook@chromium.org>,
 linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 jackmanb@google.com,
 renauld@google.com,
 casey@schaufler-ca.com,
 song@kernel.org,
 revest@chromium.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D58AC87E-E5AC-435D-8A06-F0FFB328FF35@kernel.org>
References: <20240507221045.551537-1-kpsingh@kernel.org>
 <20240507221045.551537-6-kpsingh@kernel.org> <202405071653.2C761D80@keescook>
 <CAHC9VhTWB+zL-cqNGFOfW_LsPHp3=ddoHkjUTq+NoSj7BdRvmw@mail.gmail.com>
 <0E524496-74E4-4419-8FE5-7675BD1834C0@kernel.org>
 <CAHC9VhS6hckf+xzhPn9gNQfFDiQhiGyJuzGVNXB=ZAr=8Af37w@mail.gmail.com>
To: Paul Moore <paul@paul-moore.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On 9 May 2024, at 16:24, Paul Moore <paul@paul-moore.com> wrote:
>=20
> On Wed, May 8, 2024 at 3:00=E2=80=AFAM KP Singh <kpsingh@kernel.org> =
wrote:
>> One idea here is that only LSM hooks with default_state =3D false can =
be toggled.
>>=20
>> This would also any ROPs that try to abuse this function. Maybe we =
can call "default_disabled" .toggleable (or dynamic)
>>=20
>> and change the corresponding LSM_INIT_TOGGLEABLE. Kees, Paul, this =
may be a fair middle ground?
>=20
> Seems reasonable to me, although I think it's worth respinning to get
> a proper look at it in context.  Some naming bikeshedding below ...
>=20
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index 4bd1d47bb9dc..5c0918ed6b80 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -117,7 +117,7 @@ struct security_hook_list {
>>        struct lsm_static_call  *scalls;
>>        union security_list_options     hook;
>>        const struct lsm_id             *lsmid;
>> -       bool                            default_enabled;
>> +       bool                            toggleable;
>> } __randomize_layout;
>=20
> How about inverting the boolean and using something like 'fixed'
> instead of 'toggleable'?
>=20

I would prefer not changing the all the other LSM_HOOK_INIT calls as we =
change the default behaviour then. How about calling it "dynamic"=20

LSM_HOOK_INIT_DYNAMIC and call the boolean dynamic

- KP

> --=20
> paul-moore.com


