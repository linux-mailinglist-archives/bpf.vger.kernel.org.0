Return-Path: <bpf+bounces-76908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81897CC96BB
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 20:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E9CC300D029
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 19:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B322EE607;
	Wed, 17 Dec 2025 19:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HXbBLmeY"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3D12EC553;
	Wed, 17 Dec 2025 19:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766000042; cv=none; b=ocL9S9q3ZNL7h3dOw+kB4jGBg61m9yAd6Ri1vwJ8/ksGBDum8zLG3k9OM3BWdriskijsmQxAz9QeU35unUtwnIkNv6acSJ+mZA2MChhLg8/mSo6s+YDaprKB8VJasdNcS/JesOHU5hFoJYlug0ihHn5sinTzkK3Dzsa6uOqdZgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766000042; c=relaxed/simple;
	bh=ABPN2FQ9nwjE6HAYepxIfkFVBVZa4QUp2RGIyPpMNq8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OiCPKokAZ/QEs4MeUbggUJIQB37FR+tuwRR6AH6An53npYiqkCcAacekmvzFEn7bvfCZc9pCQPJ6OFQ3w4LCb9YkeVdexswJqyGJFbg1ysv8EyAFbPurHw+1IVGAnAXVSziS8mw3Cvzi654/Lv385DqOj8DW86RH8gYHfknZu3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HXbBLmeY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [13.88.17.9])
	by linux.microsoft.com (Postfix) with ESMTPSA id 47A03200D65D;
	Wed, 17 Dec 2025 11:33:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 47A03200D65D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1766000038;
	bh=2Wu29q5yFc8HH5wM4y7yzeRfJmHHYl36rlkPIkV+IJ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HXbBLmeYjzlvawGtJhUa6VQQHxU2zoRdVBF6TKwaWR2Fc1pYEwQ+21nosvlc/JTP2
	 BXGFrl+cqxXInV+V6A647yuLgvCiCwZynt9friNSnz9DfMkVJR29UO4d4zsSsyP/Xg
	 qNSn7sstxnaZVq3+LY/f5TkW9UQxeSHlPH1NcySQ=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: ryan foster <foster.ryan.r@gmail.com>
Cc: James.Bottomley@hansenpartnership.com, akpm@linux-foundation.org,
 bpf@vger.kernel.org, corbet@lwn.net, dhowells@redhat.com,
 gnoack@google.com, jmorris@namei.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux@treblig.org, mic@digikod.net, paul@paul-moore.com, serge@hallyn.com
Subject: Re: [RFC 00/11] Reintroduce Hornet LSM
In-Reply-To: <CAHtS32-Zh3knxSdR=DUqQH4rX4QU8ewgu+KHGq6Af3qs9S0FAg@mail.gmail.com>
References: <CAHtS32-Zh3knxSdR=DUqQH4rX4QU8ewgu+KHGq6Af3qs9S0FAg@mail.gmail.com>
Date: Wed, 17 Dec 2025 11:33:55 -0800
Message-ID: <87v7i4hpi4.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

ryan foster <foster.ryan.r@gmail.com> writes:

> Hi all,
>

Hi Ryan,

> I want to confirm I understand the current semantics, and specific issues
> this series is addressing.
>
> In the signed BPF two step flow, the LSM makes decisions using what is
> known at the time of run hooks.  At load time, the only clear fact is "the
> loader is signed".  However, if we really want integrity for "the final
> program that will execute after relocation, and any inputs as part of the
> contract, matches what was signed".  The fact exists after loader runs, so
> the kernel could end up allowing and auditing based on the signed loader,
> even though it cannot yet truthfully say the runnable payload has been
> verified.
>

Correct.

> If this is the right understanding, perhaps we could consider a design that
> moves enforcement to the moment the program becomes effective. E.g.  Load
> can create a program object, but it is inert by default.  The kernel should
> only allow attach or link creation if the kernel has already recorded a
> verified record of the final relocated instruction stream plus
> referenced state for inputs, is included in the "integrity contract".
>
> If the referenced state is mutable, then either state must be frozen before
> the contract is verified, or any mutation must invalidate verified and
> force re-verification and a new policy decision. Otherwise the state is
> susceptible to TOCTOU issues.
>
> Is this the semantic goal Hortnet is aiming for, and is attack or link
> creation the intended enforcement point for the "cannot become effective
> until verified" rule, instead of trying to make a load time hook represent
> final payload verification?
>
> Thanks
>
> Regard, Ryan


The semantic goal for Hornet is to validate the provenance and integrity
of all the user-generated inputs when they are loaded into the kernel,
in order to allow users to make intelligent security decisions based
on that. IMO, attaching and linking are orthogonal run-time policy issues
that are seperate from provenance and data integrity concerns.

Allowing or disallowing linking and attaching based on the completeness of
signature validation does make sense. That kind of decision would
probably be handled by selinux, IPE, or a custom BPF LSM program most
likely though. 

-blaise

