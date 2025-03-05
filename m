Return-Path: <bpf+bounces-53377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A939DA50640
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 18:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D1ED188AFDC
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 17:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FCD1ACECC;
	Wed,  5 Mar 2025 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdtJ5gvz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834CD567D;
	Wed,  5 Mar 2025 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741195239; cv=none; b=IWdMpyvX4fxy3QtUetF/eLKw05YMu4HlWu1YmNR0pkf/QkqqwWkZnlXjAe9rMOZPS/4s1n5T1///f5uSFkzVPeZhUFmzxtHuYAWCAAxWJ1FUZHOOo50tQYp1Kf6prriJ8ycMEXECsjd5yTK+2Zrkm3xuUT6NFkhwetWfr6oqXC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741195239; c=relaxed/simple;
	bh=WpDBlYrRrddG1QZTvQAGM3RflVC0/iMkOC0i1mENe24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uo3Oq8OIqTWkAyC0KeTTdonktEUmhT3F7e8y50dcpey3/qwKQVjq9zT9zioGmoqymxeQYfNnoS1LpNQ3yWLvBVWlJDfKANupqxnnE0A3wj4RjV7N+FNyoaDbOSn9me79OoLPWlvVcQuglwPLub5q2cg1I0BWtMre4YOt1n/E8P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdtJ5gvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21F7C4CEED;
	Wed,  5 Mar 2025 17:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741195239;
	bh=WpDBlYrRrddG1QZTvQAGM3RflVC0/iMkOC0i1mENe24=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RdtJ5gvzDRKV3XgOmkAHAQwl5tgl+7W3pGMVDMsLSOUKlgixzGbnM11eEwljtNt7h
	 6VxJdqCevgv/ajXqXoMdlSWaGvRjcLfZQJBDPhZm+Mhn6t5AJE4QQkKgPlEVXO3vXP
	 CeCpLfGxypDUYawQpnPcM70MIseAm3n3ecwJTh7c50ZtsfGirKrGOkCB8VOncm7MU5
	 tm/JfjjfFOOqj//H7qUvK7jBviPt2vAEazBLS70H0XgrielARN6pd4JV28IwUVpFJE
	 sFKDhWKYzOnWgXw/TQRsyuRqYqDx25wx92knhjfJ0KNQq+bIn7X3L2PzW7COCAqndu
	 zXQWo+j9/Ukew==
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d2a869d016so21134955ab.0;
        Wed, 05 Mar 2025 09:20:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCULBkrzg5oQkCyQxWjOT2rzQuhyn9gdGqOh7GV2Tw/E3lri+SFus3WDKo72iSPf1euFQb1DPMq+J6AkxVddTh0A0kMTScW2@vger.kernel.org, AJvYcCVVlcXW7rKo8tRCUEqfCY4p68E6786Ctxe7YroHkbNTfZTDcu+KHk2WqClKo2I/ogW5/Hc=@vger.kernel.org, AJvYcCXC7q8ZWY6tJ7xDDpEfQboDn3Lk+KaXOuexSvcNlrGbomIjm1yHU+CKUOtwfSqTadg2kvzV73i1zNyr8f0t@vger.kernel.org, AJvYcCXlqEbTWsNqh6WWpVxtvxLPBhqZrqMc0NG3Crwi48p8c6ax0BzJvR/yxJ9a+eQdYRrQNC7bsiE9Iw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzct8OrTivJQBmu2lfqJ3w4j80oBIVzJXRGn3CcKcX4hz+7GBbz
	kpzInShkiRf1/ONR+pam/MXo2ambwefVWzn6+8K+NcPgOAcvgKJtsWhysSeqa76H8Md1i5BuW2+
	0sZnX0FA2kl7BTlqoLlear8THm/I=
X-Google-Smtp-Source: AGHT+IHJhox4U/rWW/uMifWKfbyEY9Rrz8YE11KbN++wNd5Mwq3TIeJMWPZEODjurE7eFo9PAGD1VjnRPV8ISAHlwEU=
X-Received: by 2002:a05:6e02:17cb:b0:3d3:fa0a:7242 with SMTP id
 e9e14a558f8ab-3d42b8a598cmr43289235ab.9.1741195238274; Wed, 05 Mar 2025
 09:20:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304203123.3935371-1-bboscaccy@linux.microsoft.com>
 <20250304203123.3935371-3-bboscaccy@linux.microsoft.com> <CAHC9VhS5Gnj98K4fBCq3hDXjmj1Zt9WWqoOiTrwH85CDSTGEYA@mail.gmail.com>
 <877c54jmjl.fsf@microsoft.com> <CAHC9VhQO_CVeg0sU_prvQ_Z8c9pSB02K3E5s84pngYN1RcxXGQ@mail.gmail.com>
 <CAPhsuW6RrUiXaQe1HBYOvwUx2GFaA-RKx22955A2StsP2erTeA@mail.gmail.com>
 <CAHC9VhQ1BHXfQSxMMbFtGDb2yVtBvuLD0b34=eSrCAKEtFq=OQ@mail.gmail.com> <CAADnVQJL77xLR+E18re88XwX0kSfkx_5O3=f8YQ1rVdVkf8-hQ@mail.gmail.com>
In-Reply-To: <CAADnVQJL77xLR+E18re88XwX0kSfkx_5O3=f8YQ1rVdVkf8-hQ@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Wed, 5 Mar 2025 09:20:27 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7sc_gYP=U0j41GgQGuF1Qj4ontKDiib64qB0COq84huA@mail.gmail.com>
X-Gm-Features: AQ5f1Jq6LMCyQsH5491-2X3aI9H8rWYPUpga1R1rjIwi8DAvg25eSbIT1vLvV7s
Message-ID: <CAPhsuW7sc_gYP=U0j41GgQGuF1Qj4ontKDiib64qB0COq84huA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/2] selftests/bpf: Add is_kernel parameter to
 LSM/bpf test programs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	LSM List <linux-security-module@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 9:08=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
[...]
> My preference is to go via bpf-next, since changes are bigger
> on bpf side than on lsm side.
>
> Re: selftest.
>
> Why change them at all if 'bool kernel' attribute is unused ?
> Addition of the attr should be backward compatible change,
> so all tests should still pass as-is.

I was thinking of keeping the argument list in the selftests up
to date, so that the users can use selftests as examples when
writing their BPF programs.

OTOH, with the "bool kernel" at the end of the argument list,
it is backward compatible.

> You probably should add a new test where 'kernel' arg is actually
> used for something. That would be patch 2.

+1. This is a great idea.

Thanks,
Song

