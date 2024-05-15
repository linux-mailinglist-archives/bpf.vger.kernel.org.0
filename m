Return-Path: <bpf+bounces-29782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 298C08C6AD6
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 18:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26A81F223F3
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 16:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C400225745;
	Wed, 15 May 2024 16:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZKaXVY6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F5B13AF2;
	Wed, 15 May 2024 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715791491; cv=none; b=EjTWFCWlFDAXRirLP6whSINycJI8xjEui8zsVjub6K6NMKBhjMa5sSLbG8jxzoHApFlo676Yn24vqEvk2VKrvMgO1wvQsnue3ZdvBJDLolsUnK27odmFRSZNdfOBEzNBok6Pw2R6+nxKhZuBgWIB4gf1bHn24sSZEjarAFDYRLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715791491; c=relaxed/simple;
	bh=NAsBTPyo6hkTeQEmu1aBJfk7Pm+0tCxNTqj/qhS7Liw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=UM+LbMvYauM8Ga/+dkX13wbTtZWB1V3OQEgrgtD1ZBQZ9yCxV7r056oDxa/k+bDgJX33ox/ovZp3Nf/V5emBLwAIDrFw0DE38B+mh8DgeIATmAVreAPBOPru6h8+qvm91bLInWX/v4jE70hQhZkw6dAkyzhvrlJM3f8Amer0r/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZKaXVY6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED8CC116B1;
	Wed, 15 May 2024 16:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715791490;
	bh=NAsBTPyo6hkTeQEmu1aBJfk7Pm+0tCxNTqj/qhS7Liw=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=OZKaXVY6REI80VZEVknh4j6x8QfSMh3R7uFq+UBvvGzD16sRg8LDdR2J/NEfVLDqd
	 BkXq0KH4h8yhIq3QaqJMDSptbteQmyKbqOfLFgaf83t/iXooqIUMavplWNaqXQWfdO
	 6b94cx4KpscuLLhFa2UPHkfHrr/EEbiGUUNAxsImvEFTM6u9nEQMNzkwvDzu5vLJ20
	 q3DSnosKu3QrPlBuASmjPsubHaReQM6mwnNuAHyRkNrDQWUO4gY74+Fxke6huqjxDT
	 GvjOWsFou3x/5T3FxuU8qShG+DsrayII8ACY1DckCEavl12t/6rQOQ0hK9SbhACN9Y
	 vEEW3ajBihPVA==
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
In-Reply-To: <CACYkzJ4wH258JZMN4gqSs-BxU1QgeHMJ2U=bouYf+xLUW8+ttw@mail.gmail.com>
Date: Wed, 15 May 2024 10:44:49 -0600
Cc: Kees Cook <keescook@chromium.org>,
 linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 jackmanb@google.com,
 renauld@google.com,
 Casey Schaufler <casey@schaufler-ca.com>,
 Song Liu <song@kernel.org>,
 revest@chromium.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EFEB4187-0F14-41BD-B145-319CBE22701E@kernel.org>
References: <20240507221045.551537-1-kpsingh@kernel.org>
 <20240507221045.551537-6-kpsingh@kernel.org> <202405071653.2C761D80@keescook>
 <CAHC9VhTWB+zL-cqNGFOfW_LsPHp3=ddoHkjUTq+NoSj7BdRvmw@mail.gmail.com>
 <0E524496-74E4-4419-8FE5-7675BD1834C0@kernel.org>
 <CAHC9VhS6hckf+xzhPn9gNQfFDiQhiGyJuzGVNXB=ZAr=8Af37w@mail.gmail.com>
 <D58AC87E-E5AC-435D-8A06-F0FFB328FF35@kernel.org>
 <CACYkzJ4wH258JZMN4gqSs-BxU1QgeHMJ2U=bouYf+xLUW8+ttw@mail.gmail.com>
To: Paul Moore <paul@paul-moore.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On 15 May 2024, at 10:08, KP Singh <kpsingh@kernel.org> wrote:
>=20
> On Fri, May 10, 2024 at 7:23=E2=80=AFAM KP Singh <kpsingh@kernel.org> =
wrote:
>>=20
>>=20
>>=20
>>> On 9 May 2024, at 16:24, Paul Moore <paul@paul-moore.com> wrote:
>>>=20
>>> On Wed, May 8, 2024 at 3:00=E2=80=AFAM KP Singh <kpsingh@kernel.org> =
wrote:
>>>> One idea here is that only LSM hooks with default_state =3D false =
can be toggled.
>>>>=20
>>>> This would also any ROPs that try to abuse this function. Maybe we =
can call "default_disabled" .toggleable (or dynamic)
>>>>=20
>>>> and change the corresponding LSM_INIT_TOGGLEABLE. Kees, Paul, this =
may be a fair middle ground?
>>>=20
>>> Seems reasonable to me, although I think it's worth respinning to =
get
>>> a proper look at it in context.  Some naming bikeshedding below ...
>>>=20
>>>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>>>> index 4bd1d47bb9dc..5c0918ed6b80 100644
>>>> --- a/include/linux/lsm_hooks.h
>>>> +++ b/include/linux/lsm_hooks.h
>>>> @@ -117,7 +117,7 @@ struct security_hook_list {
>>>>       struct lsm_static_call  *scalls;
>>>>       union security_list_options     hook;
>>>>       const struct lsm_id             *lsmid;
>>>> -       bool                            default_enabled;
>>>> +       bool                            toggleable;
>>>> } __randomize_layout;
>>>=20
>>> How about inverting the boolean and using something like 'fixed'
>>> instead of 'toggleable'?
>>>=20
>>=20
>> I would prefer not changing the all the other LSM_HOOK_INIT calls as =
we change the default behaviour then. How about calling it "dynamic"
>>=20
>> LSM_HOOK_INIT_DYNAMIC and call the boolean dynamic
>>=20
>=20
> Paul, others, any preferences here?

I will throw another in the mix, LSM_HOOK_RUNTIME which captures the =
nature nicely. (i.e. these hooks are enabled / disabled at runtime). =
Thoughts?

>=20
> - KP
>=20
>> - KP
>>=20
>>> --
>>> paul-moore.com



