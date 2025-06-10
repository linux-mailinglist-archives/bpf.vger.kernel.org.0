Return-Path: <bpf+bounces-60186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED91AD3B14
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 16:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C3EE3A40FF
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 14:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DC92BCF47;
	Tue, 10 Jun 2025 14:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZNQ2Kpp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8925629ACE5;
	Tue, 10 Jun 2025 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749565544; cv=none; b=JWjYAh8h06Cv+2iqqdID5p9+Q/WsXI0uzrkNAPMahp1u07v1lIAtQFevrPqzAZ8S/iCDRD0edqMAomn7A3Y2BpYkFWGo5fkAnhGckH5YOt9rKQk0SpjnKp9m5+n6FPqOLIly7bjKT8/QeQRr+i6L69l8DV3Z1DgWLQVeS+1t9gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749565544; c=relaxed/simple;
	bh=Hr/xqZLGagafgLn98UXv2mQCJHm38h+zvwi9d47piSA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IEYjYtR/R0W8pFxoMWtPJ4JlIzc5H4dzFFML5AoI3SNHCs3W8Eua3aXBhi+QUWMqA1kGkPDQQiyWwXHw7xHF4L2uqQNzjpcB0uThPLDU03zWV5BgPGOcjFE4r7l+FZOWitoD3nCHFQgvhL6EtwvKir981eEQlmHN8QNWX0P775Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZNQ2Kpp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86EBC4CEED;
	Tue, 10 Jun 2025 14:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749565544;
	bh=Hr/xqZLGagafgLn98UXv2mQCJHm38h+zvwi9d47piSA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BZNQ2Kpp4Dtc1AQ+9XMzczvKlk9RSkZO9VRp3KXgSpgyzGAieavlfH+HjOVMiDlQ4
	 KAJjb7uzSUwAkqLSl6nssLLKNlsjmzfp9HLEQVznemKy+8gqXuBFjISrMoUjPFmSbj
	 WSD9Q0fxczwp8JikhzF53zNqeudodxfK8fHZZIrxzQlOhu0beGloW4sVvc+3dQFxmk
	 MUt4TJU8mQ6WC9IxRpxzVIbH4IknAN3mCMQpzmHNnDxI7LHObBuwo3VRsg/WnCSLTO
	 6Wtcce2v+wO+CWbBtG35xeH+cQHCNpHn90rltjnFDTfJaT48LB5LmUVJDF9da9vrSm
	 0MpVuCBuANAzQ==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 6AC991AF6B3F; Tue, 10 Jun 2025 16:25:29 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
 bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Subject: Re: [PATCH 00/12] Signed BPF programs
In-Reply-To: <CACYkzJ7mOk2CbFpKi_eg16a81AEeTZU1O6r6zOgwAjwSReYedA@mail.gmail.com>
References: <20250606232914.317094-1-kpsingh@kernel.org>
 <87h60ppbqj.fsf@toke.dk>
 <CACYkzJ6_VXiWauPBMWOzX+QHedj4noYxfmt_usUzXCiifuEuLA@mail.gmail.com>
 <87cybcdj5k.fsf@toke.dk>
 <CACYkzJ6SLvJNfGiQ7DegBGv2vryxtdHq8isme29ByrAeKwhwDA@mail.gmail.com>
 <877c1jerkq.fsf@toke.dk>
 <CACYkzJ7mOk2CbFpKi_eg16a81AEeTZU1O6r6zOgwAjwSReYedA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 10 Jun 2025 16:25:29 +0200
Message-ID: <87v7p3d67a.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

KP Singh <kpsingh@kernel.org> writes:

>>
>> Right, but this patch series has no mechanism for establishing a
>> userspace loader binary as trusted (right?). The paragraph I quoted
>> makes it sound like these are related, and I was trying to figure out
>> what the relation was. But it sounds like the answer is that they are
>> not?
>>
>
> The relation here is that no matter what we do, the kernel cannot be
> the only trusted blob on the system and this was aimed at answering
> questions people had earlier when I proposed the design. This patch
> does add signing support and this allows us to add the following
> policy, it does not directly add any user space support.
>
> bprm_committed_creds (check signature of program, if verifies with a
> separate key) add a blob that allows:
>
>  * unsigned bpf programs
>  * signed with a derived key
>
> security_bpf:
>
>  * Check for the right attributes for signing.
>  * restrict which program types can be loaded.
>
> (additional key hooks for restricting which keys are allowed to verify
> programs).

Right, gotcha - thanks for clarifying! :)

-Toke

