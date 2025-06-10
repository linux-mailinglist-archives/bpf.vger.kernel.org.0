Return-Path: <bpf+bounces-60141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9205AD32A0
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 11:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80A397A9461
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 09:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B246A28C5AB;
	Tue, 10 Jun 2025 09:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfasKfMp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358FE28C019;
	Tue, 10 Jun 2025 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749548758; cv=none; b=QQFGhhHh+dCJZDrblfvaKsiNP3l7IKeo/msW8yfNqTdSdYoyELMjyAJPrmR/Nn8/v8jOHFve4NhLd9oQxSLmZFKhdl14x13E1qhx5azfZjhHCMqVM4mohUYN2Wj/mIbk9OFgnErv7IS1gHnRvCRISCof8HiYpQ4/4K4/WF5OC88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749548758; c=relaxed/simple;
	bh=yFxZfITXax1je2USVN4oSCSjLG6ui9xD112gidlTpL0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cv5pBVwyBvs+rHgEQD6we/eRdRvRubJyUGon2cRoaApQoSSpyCjYNHIItJqgARjzRJsajIJr++q01YAgt65vVZ/ISYeJgWFwWqpUb1/0W2TTuoM214qKlnSAnUGiZFBumt1k7uIE00jMA1/OnH9FbJFh0+miVLpRLQ4qhbcsylg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfasKfMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FEEC4CEED;
	Tue, 10 Jun 2025 09:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749548757;
	bh=yFxZfITXax1je2USVN4oSCSjLG6ui9xD112gidlTpL0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QfasKfMpCWRaoYeaItc7dihlAQAXFhm3kelEN4vYeOvWmS7ehW3zOhqtCVhNclOA8
	 iwH0Gx3lgRrQOEQzmJlky92mv/ZiINKUa+9wnIn02IZjzY88YNbwLTdzULHA/ojLZl
	 uDJvVZm896yE+rJbD5YyZBn4p7zgiDFfd6YPZGvESjIKJv7Pq1CjG45IBVVZAfwnNA
	 R8f96CHumssRGEfxYtTq5kvJREiy34oIycuNUkk0O4bO3gmik9Kh0DZpSDUZgKJos5
	 4LwXZrHp/tz/amZ4qkF63zP+f0eR/YQQtFYYRPKzD0CaIMDcDsR+MP20VsAmJ9w2LR
	 pH0cGLqiqUKRA==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 062421AF6AF2; Tue, 10 Jun 2025 11:45:44 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
 bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Subject: Re: [PATCH 00/12] Signed BPF programs
In-Reply-To: <CACYkzJ6_VXiWauPBMWOzX+QHedj4noYxfmt_usUzXCiifuEuLA@mail.gmail.com>
References: <20250606232914.317094-1-kpsingh@kernel.org>
 <87h60ppbqj.fsf@toke.dk>
 <CACYkzJ6_VXiWauPBMWOzX+QHedj4noYxfmt_usUzXCiifuEuLA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 10 Jun 2025 11:45:43 +0200
Message-ID: <87cybcdj5k.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

KP Singh <kpsingh@kernel.org> writes:

> On Mon, Jun 9, 2025 at 10:20=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@kernel.org> wrote:
>>
>>
>> > Given that many use-cases (e.g. Cilium) generate trusted BPF programs,
>> > trusted loaders are an inevitability and a requirement for signing sup=
port, a
>> > entrusting loader programs will be a fundamental requirement for an se=
curity
>> > policy.
>>
>> So I've been following this discussion a bit on the sidelines, and have
>> a question related to this:
>>
>> From your description a loader would have embedded hashes for a concrete
>> BPF program, which doesn't really work for dynamically generated
>> programs. So how would a "trusted loader" work for dynamically generated
>> programs?
>
> The trusted loader for dynamically generated programs would be the
> binary that loads the BPF program. So a security policy will need to
> allow certain trusted binaries (signed with a different key) to load
> unsigned BPF programs for cilium.

OK, so this refers to a policy along the line of: "Only allow signed BPF
program except for this particular userspace binary that is allowed to
load anything"?

> For a stronger policy, the generators can use a derived key and
> identity (e.g from the Kubernetes / machine / TLS certificate) and
> then sign their programs using this certificate. The LSM policy then
> allows verification with a trusted build key and for certain binaries,
> with the delegated credentials.

And this means "add a separate trusted key on the kernel side that the
userspace binary signs things with before passing it to the kernel"?

In which case, how does that tie into the original statement I quoted at
the top of this email? The "trusted loaders are an inevitability" bit? I
was assuming that the "trusted loaders" in that sentence referred to the
light-skeleton loader program, but from your reply I'm not thinking
maybe it just means "some userspace binaries need to be exempt from any
signing requirement"? Or am I missing something?

-Toke

