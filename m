Return-Path: <bpf+bounces-63735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448D4B0A7B6
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 17:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F10653B02E6
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 15:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C8A2E3B08;
	Fri, 18 Jul 2025 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WwunbJb/"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027CB2DFA22;
	Fri, 18 Jul 2025 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752852744; cv=none; b=j3pz9YlM+74UDm8bvQQZm8uEjUzaCBLgIGcBcWm+dlrASFsBAS7LdS6e6XzBmLtMOLsnZt1SZN6oCWfhtq809EjaateHX2HPZ8/V04VaEBLhaD+wqoGeJvg+n0x7YPPp4GcUGqkWcavUB11uEFjISMC7U01SsoJsBQPN7qJTqg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752852744; c=relaxed/simple;
	bh=IfXYazO8MYngKiT6clRs5Ye9Jvm86BEkHdyjgYMD/Ro=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mo9B56bIndViBcDquZw9NxTBwqMHh7nQkCMnk2Ma0c/Qr/0LA4kYkfxT3CsyLiYYDfBt3dHzo5q7jgP0gC2djMjUVAyNSJMOup5TLLD9i3cg4C03Mvh4PjxOaKWulxdSlMG4jrFpqWzlQB3PbGH3Ohu0ZysYUR/2IOo7/dN4Zco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WwunbJb/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [40.78.13.147])
	by linux.microsoft.com (Postfix) with ESMTPSA id 77419211FEB6;
	Fri, 18 Jul 2025 08:32:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 77419211FEB6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752852742;
	bh=oaxnkh80pZIn881aHd/5LYCJu4VLzaMbwjcsJ/LtHk4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WwunbJb/iCyVuzlPFGttLFI0s3i9lX6BIiPySY7K+CkC2kQ9nW8nkth9fhwj1U0R+
	 YGWrwuODPnVGd6wXzxlX8DqL20iVH1RUEZ8SYELyANzCyDe7Wf3eRyoeuvLAkRJPrt
	 aZDeBy2pkPjKXbAQwPLXYqV3th4eecNRnUzo664c=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Song Liu <song@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley
 <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>,
 Casey Schaufler <casey@schaufler-ca.com>, John Johansen
 <john.johansen@canonical.com>, Christian =?utf-8?Q?G=C3=B6ttsche?=
 <cgzones@googlemail.com>, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, selinux@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] lsm,selinux: Add LSM blob support for BPF objects
In-Reply-To: <CAPhsuW6K95bnGvRVOKj-qBJT7DX8JsaO6WZMNauMi1GEqVT1FA@mail.gmail.com>
References: <20250715222655.705241-1-bboscaccy@linux.microsoft.com>
 <CAPhsuW6K95bnGvRVOKj-qBJT7DX8JsaO6WZMNauMi1GEqVT1FA@mail.gmail.com>
Date: Fri, 18 Jul 2025 08:32:20 -0700
Message-ID: <878qkl4irf.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Song Liu <song@kernel.org> writes:

> On Tue, Jul 15, 2025 at 3:27=E2=80=AFPM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
> [...]
>> +/**
>> + * lsm_bpf_map_alloc - allocate a composite bpf_map blob
>> + * @map: the bpf_map that needs a blob
>> + *
>> + * Allocate the bpf_map blob for all the modules
>> + *
>> + * Returns 0, or -ENOMEM if memory can't be allocated.
>> + */
>> +static int lsm_bpf_map_alloc(struct bpf_map *map)
>> +{
>> +       if (blob_sizes.lbs_bpf_map =3D=3D 0) {
>> +               map->security =3D NULL;
>> +               return 0;
>> +       }
>> +
>> +       map->security =3D kzalloc(blob_sizes.lbs_bpf_map, GFP_KERNEL);
>> +       if (!map->security)
>> +               return -ENOMEM;
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * lsm_bpf_prog_alloc - allocate a composite bpf_prog blob
>> + * @prog: the bpf_prog that needs a blob
>> + *
>> + * Allocate the bpf_prog blob for all the modules
>> + *
>> + * Returns 0, or -ENOMEM if memory can't be allocated.
>> + */
>> +static int lsm_bpf_prog_alloc(struct bpf_prog *prog)
>> +{
>> +       if (blob_sizes.lbs_bpf_prog =3D=3D 0) {
>> +               prog->aux->security =3D NULL;
>> +               return 0;
>> +       }
>> +
>> +       prog->aux->security =3D kzalloc(blob_sizes.lbs_bpf_prog, GFP_KER=
NEL);
>> +       if (!prog->aux->security)
>> +               return -ENOMEM;
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * lsm_bpf_token_alloc - allocate a composite bpf_token blob
>> + * @token: the bpf_token that needs a blob
>> + *
>> + * Allocate the bpf_token blob for all the modules
>> + *
>> + * Returns 0, or -ENOMEM if memory can't be allocated.
>> + */
>> +static int lsm_bpf_token_alloc(struct bpf_token *token)
>> +{
>> +       if (blob_sizes.lbs_bpf_token =3D=3D 0) {
>> +               token->security =3D NULL;
>> +               return 0;
>> +       }
>> +
>> +       token->security =3D kzalloc(blob_sizes.lbs_bpf_token, GFP_KERNEL=
);
>> +       if (!token->security)
>> +               return -ENOMEM;
>> +
>> +       return 0;
>> +}
>
> We need the above 3 functions inside #ifdef CONFIG_BPF_SYSCALL.
>
> Also, can we use lsm_blob_alloc() in these functions?
>
> Thanks,
> Song

Sure, I'll get that fixed in V2. Thanks

-blaise

>
> [...]

