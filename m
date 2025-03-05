Return-Path: <bpf+bounces-53347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2EAA50443
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 17:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF1DF3A5737
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 16:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B24250C14;
	Wed,  5 Mar 2025 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GRCmUsk+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D111724E4B5
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 16:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191141; cv=none; b=IZ8Yn+3e/k08nK7lxISRR+4b37vrDfT1z2jF4DsIv90bycxeEF6Q4fu87aXz9qipvfMk5ocSRdW4rHEyZv7g8t7f9X67ccByInswwV2eDngvQZfLR0yjR5Fdoi8kL6FZOC5vJYHz0XpQGJrrKZgGTqygTVmFPmt0yNJLGe6uNn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191141; c=relaxed/simple;
	bh=2q39nFob89uGjhIZ3SJiCBavEHz6XphRtukgeM+fPHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fKm/D71b6hUH8F3xT9hGG3ASG43nv9hNStmpok5Nimwg8HmVaGOLoqvB+/+ynIDaG2YjoUOj5xOLN4UE/K9RaA4qn1xcNo30evHGYGV4/egl5tZObnFP7j2t9qXCNoer4rtnIBXo/IOM0VbMDGMZIAoLqalziVVlkvGuM9cYgKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GRCmUsk+; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e6119fc5e9bso1090150276.0
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 08:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741191138; x=1741795938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HR6v/qJNcz2018VPIy19J59hCQI20OhNaLeBeMvMyms=;
        b=GRCmUsk+KxmEFI1arAP0wyX/T/tWMTzc9ZJ+oF37MOw5vKZfVPQfE3GS0AImNbqEV1
         t/WJ2kUcsQ5FaifEqil2ms5vhwPJQ+hEC63dbLxWoLgBqQ6trVqZ7E+zSPAJrxuxa0g7
         MW+oYixfDflRvccCzn4GSy30B9Ya+nS/f8qDuQuD0CxpbB+bWLdykfDgr9KVSQkJljrN
         l1y0PRKxER4TdC3RI1kd3hAyKXX42y6Qa+rcMX4VXy1WjHKFMx0rfPllrQhKasdPcE9S
         9TSKHrYxV5yE1TujVK03fCfYDAsz+IqXT49919qukuVWrrwcJqugFSc1Lpg4PPv5OeQF
         fEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741191138; x=1741795938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HR6v/qJNcz2018VPIy19J59hCQI20OhNaLeBeMvMyms=;
        b=At6N/+Hs8vCLIVIayWgbegZjzUybhhS2HoYtn4GZA7SDKCaIDOz+i295Nyq/w1Cjbd
         A9kpsGCtLbSGDvgXiw+m6j2yEnQCJx8o8qZeq2beU9+Oy9LLUWxb5N+ZVSsSF/viaJVl
         a4+o55XnYQcY3kjIY/G8z5r5rYF99XWyJ8JkDGYtQgBFk/Pecg4M8MJiuXKmJlCde/PU
         ccTvZ3qcqU8RJ0rnDGm+FfqDfdzcfgSunZjjySTGaJCZWC9jrk+dLu/N59r+uM0kXz/P
         2ZF7Uqg/7jPORFk/hUs3BqWzPWwIvJCL1W/wdZspTL6CL6FzpB4Fn+DxYIRrNYYRIvDD
         jfaA==
X-Forwarded-Encrypted: i=1; AJvYcCWg2L2q1j0rjDiX+cPzr15zsq9Iu7ET7frEeYacQxbViHb/T5aXIOsZntDrVffiX8A8RE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxppqNhmUpluCsSV70ySNphHmnGI1HKySy94/P63pV1GKLPi3O2
	2rKK7Ac1M/GKqdkXinoScxteroSd8EiRy1KRqu6OCjGXrdUvBiKdk45XND8htPza1hDbMErorK4
	dRMdmwelIuZokbrlvOCW3iyCdQtntCKBRPbGB
X-Gm-Gg: ASbGncsOEMeSflHfIScwuL2ujSSxP14BrVQ5q+MhbvLSUyP+GqB8fuBZUjl3NJfaIcj
	WvSx6zGcmFcVsncZu2ycV5YqovDFUgJ7FFZuBpU+IZn3MvJfJUAxt/p9lkx36LGCMLDxwUA8RWT
	sGC2Xo1D4jt1+kDkHMYP8AZ1GkrA==
X-Google-Smtp-Source: AGHT+IG2+ri9TiG/+pR3y5KkKxoz0d2KVOY8e3WkmBgUHc2qC5BioAV59fgj/NVLtTUT4F32NzzVt7ytF05Eu8bmAsg=
X-Received: by 2002:a05:6902:1583:b0:e61:1be5:d0ae with SMTP id
 3f1490d57ef6-e611e196a54mr5413376276.5.1741191137730; Wed, 05 Mar 2025
 08:12:17 -0800 (PST)
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
In-Reply-To: <CAPhsuW6RrUiXaQe1HBYOvwUx2GFaA-RKx22955A2StsP2erTeA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 5 Mar 2025 11:12:07 -0500
X-Gm-Features: AQ5f1Jpzk8xNhqaDNcdEV_2AlQwGfaf4RmRxkPjJlwjeTek1OtX3R3sL0LkAbEc
Message-ID: <CAHC9VhQ1BHXfQSxMMbFtGDb2yVtBvuLD0b34=eSrCAKEtFq=OQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/2] selftests/bpf: Add is_kernel parameter to
 LSM/bpf test programs
To: Song Liu <song@kernel.org>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 10:32=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> On Tue, Mar 4, 2025 at 6:14=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Tue, Mar 4, 2025 at 8:26=E2=80=AFPM Blaise Boscaccy
> > <bboscaccy@linux.microsoft.com> wrote:
> > > Paul Moore <paul@paul-moore.com> writes:
> > > > On Tue, Mar 4, 2025 at 3:31=E2=80=AFPM Blaise Boscaccy
> > > > <bboscaccy@linux.microsoft.com> wrote:

...

> Do we need this in the LSM tree before the upcoming merge window?
> If not, we would prefer to carry it in bpf-next.

As long as we can send this up to Linus during the upcoming merge
window I'll be happy; if you feel strongly and want to take it via the
BPF tree, that's fine by me.  I'm currently helping someone draft a
patchset to implement the LSM/SELinux access control LSM callbacks for
the BPF tokens and I'm also working on a fix for the LSM framework
initialization code, both efforts may land in a development tree
during the next dev cycle and may cause a merge conflict with Blaise's
changes.  Not that a merge conflict is a terrible thing that we can't
work around, but if we can avoid it I'd be much happier :)

Please do make the /is_kernel/kernel/ change I mentioned in patch 1/2,
and feel free to keep my ACK from this patchset revision.

Thanks everyone!

--=20
paul-moore.com

