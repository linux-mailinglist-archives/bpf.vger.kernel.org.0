Return-Path: <bpf+bounces-60146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8B2AD34D0
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 13:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2B0416A7F0
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 11:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E52F223DC5;
	Tue, 10 Jun 2025 11:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5821o57"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1C0224257
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 11:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749554315; cv=none; b=VFOQgM9P4zLRyxe/bH8UtDEDnzCbKJM/qfrfj6kXBCnOzkrWFU9hmQXOwLvWSNUy24X4tDFC0FMm7KSwm/F6Eql5btkCjVhXQrO+AhjEt7Omj2WJ6beBObxey6wyXf19PxZOjsAyrQyJOXKLHRdlzQG8sozvf4YTAw0kSnOxMEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749554315; c=relaxed/simple;
	bh=muZFKIZf3adRIcczoaBbdodzF3qZFbj2irmzlGhgwwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FvNCqNhAOMvFtAHT7250Nxoniln/EQpXpDOwh8CaNAkssEsMg74fxiVupIAtxuvJnpCMiYzPtVJvUVYthieiM/YDkjMEdaZNibVJW2cuZZrdgGZBDfKkjscScDdsISy9bRn/m7ypUjdx1ZV8+bCpZUG2ep/4JoK53UgslC6ELRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5821o57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B7AC4AF09
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 11:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749554315;
	bh=muZFKIZf3adRIcczoaBbdodzF3qZFbj2irmzlGhgwwE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=q5821o5773eUM7I51VUHSf828W/XtMtjUxdOQDZrTbAmzECwAmAuc/kKd8MRh8WrN
	 e0yfUVC6lFea7/4r+49BQyAlc0r+qLIgwAjFVt7sRT83sc9TmM4OyDWnT0OivvJNxd
	 qztiQVq6UQpglN30k7UWaswSQ3Ntq+r7Lo8BgAUeSUeTN5SmAp8v9j5YNlHKZJWOeD
	 PgScsHw0Cc5pmXsOix0fp+WNqMBl90aIJavSqBzlJf9IfFSNwLKOnrSiPSsyFamJCA
	 UtEAf1ktZiDtmHTF88WCJMglmaak10rNi8slAE5zGg/5sGA6Wqa7I4lbpLlZuWCvSu
	 WLGRsvSYGgJ7w==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6070293103cso8814294a12.0
        for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 04:18:34 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx0qZljSOYbx/00kyGIcjF7uGG3eUY5RoaSGvdDpR1AlghuDzHQ
	YbSGAqKrze1LGp4uvspiwHLDxJk64k0XhAJanYMS2+uT1naIBasvPerXCb3fhztllW6QX7+JOey
	AOD6Q2YOst8fwmf43v/1nrTtO11TMhmac9eDEk2X6
X-Google-Smtp-Source: AGHT+IFBSG6aHFiYRzRXwRjeS4mLbYf0rt9zNt9kdiP9j3ubrz49cRvKF8yIPa1bzg/PXvL1cy4jpEACamPBFYnYRT0=
X-Received: by 2002:a05:6402:27cd:b0:5fb:868b:5a59 with SMTP id
 4fb4d7f45d1cf-60774897edfmr16080895a12.32.1749554313510; Tue, 10 Jun 2025
 04:18:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <87h60ppbqj.fsf@toke.dk>
 <CACYkzJ6_VXiWauPBMWOzX+QHedj4noYxfmt_usUzXCiifuEuLA@mail.gmail.com> <87cybcdj5k.fsf@toke.dk>
In-Reply-To: <87cybcdj5k.fsf@toke.dk>
From: KP Singh <kpsingh@kernel.org>
Date: Tue, 10 Jun 2025 13:18:22 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6SLvJNfGiQ7DegBGv2vryxtdHq8isme29ByrAeKwhwDA@mail.gmail.com>
X-Gm-Features: AX0GCFvwSXDyvq61832xj3p-z5GsxDJ--RtCEHv2Agh8d4AoyyHMHYEyiBT1DLs
Message-ID: <CACYkzJ6SLvJNfGiQ7DegBGv2vryxtdHq8isme29ByrAeKwhwDA@mail.gmail.com>
Subject: Re: [PATCH 00/12] Signed BPF programs
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 11:45=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@kernel.org> wrote:
>
> KP Singh <kpsingh@kernel.org> writes:
>
> > On Mon, Jun 9, 2025 at 10:20=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@kernel.org> wrote:
> >>
> >>
> >> > Given that many use-cases (e.g. Cilium) generate trusted BPF program=
s,
> >> > trusted loaders are an inevitability and a requirement for signing s=
upport, a
> >> > entrusting loader programs will be a fundamental requirement for an =
security
> >> > policy.
> >>
> >> So I've been following this discussion a bit on the sidelines, and hav=
e
> >> a question related to this:
> >>
> >> From your description a loader would have embedded hashes for a concre=
te
> >> BPF program, which doesn't really work for dynamically generated
> >> programs. So how would a "trusted loader" work for dynamically generat=
ed
> >> programs?
> >
> > The trusted loader for dynamically generated programs would be the
> > binary that loads the BPF program. So a security policy will need to
> > allow certain trusted binaries (signed with a different key) to load
> > unsigned BPF programs for cilium.
>
> OK, so this refers to a policy along the line of: "Only allow signed BPF
> program except for this particular userspace binary that is allowed to
> load anything"?
>
> > For a stronger policy, the generators can use a derived key and
> > identity (e.g from the Kubernetes / machine / TLS certificate) and
> > then sign their programs using this certificate. The LSM policy then
> > allows verification with a trusted build key and for certain binaries,
> > with the delegated credentials.
>
> And this means "add a separate trusted key on the kernel side that the
> userspace binary signs things with before passing it to the kernel"?
>
> In which case, how does that tie into the original statement I quoted at
> the top of this email? The "trusted loaders are an inevitability" bit? I
> was assuming that the "trusted loaders" in that sentence referred to the
> light-skeleton loader program, but from your reply I'm not thinking

No trusted loaders are exactly what they mean, trusted blobs of code
that can load BPF programs, these can be loader programs in light
skeletons or trusted user-space binaries.

- KP

> maybe it just means "some userspace binaries need to be exempt from any
> signing requirement"? Or am I missing something?
>
> -Toke

