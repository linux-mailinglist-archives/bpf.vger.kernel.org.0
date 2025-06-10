Return-Path: <bpf+bounces-60149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EADFAD356B
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 13:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129DC175847
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 11:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE7122D4F0;
	Tue, 10 Jun 2025 11:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWH1+0oE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C4D22D4E7;
	Tue, 10 Jun 2025 11:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749556723; cv=none; b=Bf1W1p/3qEmx12qxbS7zgJG1Xd4Tpxf42lD2OoP8NLaVreTc+b674pMM7caAmOa2MSOs5aKo30YiDBTzN47E93HJFMJWgGLLoYxvOW09ak/z3RB5iYqwXUVoId+b+tLs4grJ5pwOvV+cbL/J9J2vY/zVuiZ/TuuWtiF2Zg1Khao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749556723; c=relaxed/simple;
	bh=YbV5Vrcg9CJRBSxpYetisOiH07VFx+vcOnsIPf6+cXs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EqAWd99R7IuiFYI7jB0ZrKXWpFsWVMXfm5xnyH+bkDr6JBb2aguqdmTTpprtr0iafZABsSkdOK+xTaNKY/uUattLpyqIPm1tIRWxLGvvcXCIfb40TxgbOsyn+wDNlq7/qDq1IZ7neEqyeO78DrfQcpx8qTVpodfW/4AMcUm4A1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWH1+0oE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDEEC4CEF2;
	Tue, 10 Jun 2025 11:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749556722;
	bh=YbV5Vrcg9CJRBSxpYetisOiH07VFx+vcOnsIPf6+cXs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KWH1+0oEYdCAT7Ze1r1sT2ffXRBchJ92u/MfbO1o5CTWKk+ujzNN0fTBiq/ycWb1v
	 7C41ZO0xxNzTI8RpxYrC0ojAcj632kLc5v0HHirpq0kulPzRhaWKUyq7PyoAZd5E+C
	 8tuS1ydATFPpzNTHXoHdSAiX8Hlw4kKwJqiYUO96t4VPFQC+ALUBSk8yCj3DDebdLw
	 xW7TT22LBHjHc7qve9dx8o/Y2BojreWNa92QSUrEHFjb6DYADA8JppgdoY7rzq1OdW
	 j1AjW8Pd+YbahgjUaVI4GBI0chpQXBQF4r3I+cVrNx/TOz0xPCmbJEjSRppiCOE/+/
	 aOEcTSCDYnsrw==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 52B631AF6B10; Tue, 10 Jun 2025 13:58:29 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
 bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Subject: Re: [PATCH 00/12] Signed BPF programs
In-Reply-To: <CACYkzJ6SLvJNfGiQ7DegBGv2vryxtdHq8isme29ByrAeKwhwDA@mail.gmail.com>
References: <20250606232914.317094-1-kpsingh@kernel.org>
 <87h60ppbqj.fsf@toke.dk>
 <CACYkzJ6_VXiWauPBMWOzX+QHedj4noYxfmt_usUzXCiifuEuLA@mail.gmail.com>
 <87cybcdj5k.fsf@toke.dk>
 <CACYkzJ6SLvJNfGiQ7DegBGv2vryxtdHq8isme29ByrAeKwhwDA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 10 Jun 2025 13:58:29 +0200
Message-ID: <877c1jerkq.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

KP Singh <kpsingh@kernel.org> writes:

> On Tue, Jun 10, 2025 at 11:45=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen=
 <toke@kernel.org> wrote:
>>
>> KP Singh <kpsingh@kernel.org> writes:
>>
>> > On Mon, Jun 9, 2025 at 10:20=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgens=
en <toke@kernel.org> wrote:
>> >>
>> >>
>> >> > Given that many use-cases (e.g. Cilium) generate trusted BPF progra=
ms,
>> >> > trusted loaders are an inevitability and a requirement for signing =
support, a
>> >> > entrusting loader programs will be a fundamental requirement for an=
 security
>> >> > policy.
>> >>
>> >> So I've been following this discussion a bit on the sidelines, and ha=
ve
>> >> a question related to this:
>> >>
>> >> From your description a loader would have embedded hashes for a concr=
ete
>> >> BPF program, which doesn't really work for dynamically generated
>> >> programs. So how would a "trusted loader" work for dynamically genera=
ted
>> >> programs?
>> >
>> > The trusted loader for dynamically generated programs would be the
>> > binary that loads the BPF program. So a security policy will need to
>> > allow certain trusted binaries (signed with a different key) to load
>> > unsigned BPF programs for cilium.
>>
>> OK, so this refers to a policy along the line of: "Only allow signed BPF
>> program except for this particular userspace binary that is allowed to
>> load anything"?
>>
>> > For a stronger policy, the generators can use a derived key and
>> > identity (e.g from the Kubernetes / machine / TLS certificate) and
>> > then sign their programs using this certificate. The LSM policy then
>> > allows verification with a trusted build key and for certain binaries,
>> > with the delegated credentials.
>>
>> And this means "add a separate trusted key on the kernel side that the
>> userspace binary signs things with before passing it to the kernel"?
>>
>> In which case, how does that tie into the original statement I quoted at
>> the top of this email? The "trusted loaders are an inevitability" bit? I
>> was assuming that the "trusted loaders" in that sentence referred to the
>> light-skeleton loader program, but from your reply I'm not thinking
>
> No trusted loaders are exactly what they mean, trusted blobs of code
> that can load BPF programs, these can be loader programs in light
> skeletons or trusted user-space binaries.

Right, but this patch series has no mechanism for establishing a
userspace loader binary as trusted (right?). The paragraph I quoted
makes it sound like these are related, and I was trying to figure out
what the relation was. But it sounds like the answer is that they are
not?

-Toke

