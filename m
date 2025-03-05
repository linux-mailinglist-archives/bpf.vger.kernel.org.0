Return-Path: <bpf+bounces-53373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA8FA50610
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 18:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7F187A890C
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 17:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100D9250BE1;
	Wed,  5 Mar 2025 17:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQoHmrXd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5671C5F11;
	Wed,  5 Mar 2025 17:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741194526; cv=none; b=Iwg7Oh4dOVZ/tR/DpzWQpyGdUAG1MqsmhYBruKsAh763uQpv7URLVykgBt4HIlJ7d7HjR+91sYHrwgLRbUKW9UQTifCLNZCL7DT94x3oxDp0M1IYKrFIaw9PL0r3IiNP8ExYUV0fnS9ZBYAC9BxrH+rNR3tLqVhUoNCtaxGyj/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741194526; c=relaxed/simple;
	bh=BvrpRLEjubg+uBgW0PQjlbnPvYou/AIaycZ0Uh7wWfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9/PXjl18wEPUyb88oDucpFcNcPIX/SiC6EInTOgnNc5beVRtI58YH+Itbb72xQTuFmfr2c71UG5ihM5qObVo6KSu8JGszCjSYaucL8/xdpu4ZGQHtn+UVkDGTCxxvz16lejS1HaM26WQCvV6GKaruz9BR93D2UafKzDEts/0S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQoHmrXd; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-390f69e71c8so797811f8f.0;
        Wed, 05 Mar 2025 09:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741194522; x=1741799322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCmHH2sBXFrU1aD2JeP8UinBUcmUwStB8VTMjRRTo3M=;
        b=FQoHmrXdqO0w+XXlB//31Jxe+OAGHe+Nzz4tPapIiA7SSAPVBG9JpOVQ3PiiE00KDR
         8GONP7edeJJ4F5lANFGmQCEjELagKZf/URAISfLvDQ2Hup9DvfSP6kSjSmvnDYPL/ImT
         D7WfJ0mcaWY/UFZb2l4bNa3PYiIXcF6lnFzMCs5HyIT39GcQUXb8mjqvk5oMFSaSI3ov
         hWt3CJrOUKFck+oR/rp+CyDsDyrFuGmytxCTHlkm6TZz17Jsb0xQf9SN+TrG0+qPeG81
         VsY7NSV6VfAM69IZjZqn3HW/72a4E1rHFEg2GKuOFoEssBJ49DTYvnmFuoA127K+MkbM
         mcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741194522; x=1741799322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JCmHH2sBXFrU1aD2JeP8UinBUcmUwStB8VTMjRRTo3M=;
        b=F5moFPO7gwksMHz0iJT1vmOAprn13lR3oLwu1UyyfH4mjpqhAEfHLHikYgH7DE5REt
         9FjFFVDfA1p3svNz75ynyU8heZHcAXXEOp3LLqYjoFMOJ1+XT6uA54p+Bw8gwIYpfW5A
         GnPhDNOL4MAYT4wtmByHjeBsRoXafPCq1I9RNRrb5kOx2JnmmyjFCPOnQN4E3GWgVBOF
         Il2jmegRO9OdHoMTIEZl6dma1uDhBDbV21ddF0xzMAs5GJzIvl2Fzy4vIM1aiFaebTOR
         rXNUgLdxfMNjZxsDfB6B16irINGsl/aE3PiLpmWaOScW5Plh79EWRzqzh+KoyAEEbv+q
         6nJA==
X-Forwarded-Encrypted: i=1; AJvYcCU0Cpr2M1UQZqpnngdAytqsymIEieChuBHuEcd5p3b+KrPhV9MXME8Y04zoOedkubHb3UuvjmJSPHvSNpO/@vger.kernel.org, AJvYcCWww2VKavtVte2q1TNnu6Neufy8OXHEkoBKSpkGIqlDDsR+pJhR5fAtfFqqS63oNELOX3I=@vger.kernel.org, AJvYcCX+EVoI3lSkg86m8bNKt+Ll7Eu+I+b2AS1XJ4QeXitNd8sNmR5QMiL1Th+neErE1i8zncLsoiQw+c9gXGCGTXaqgrumcYdu@vger.kernel.org, AJvYcCXK6s0FTdDOkuaie5BLyRj/QbFkXo1Gp38etKL33sMB6w/SOsvYrSEyPymy2j/ADbaMFrukLbQ/fQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyesdwu+XeOVHWUqmneKHocYQ154ROTeehwvEZSt11YhMI48yP4
	+uMaCAYYzR5UTaZzoz6515GfUltniFGP41S1JDP8V677KeqeVSN02I9OueXBTU3nwCnp7pxI0Kv
	7tSw0P1rZpW0QT9ODnXms6Ve5n6s=
X-Gm-Gg: ASbGncssJL5J3TMcRbEBvh/H8m7ee0yZ2YvrA2y7z7NofGHezRIQ1/gcH/ipxkqC0o7
	DKxbvvkpPp/hvE83LwgugUrhCJfKh3nehnlWI/M6+aj+8TGfdAgFQmF0qRYRtx+299/7RoXGO4V
	pCnSINugguJs5IWgQ/n10bh9NXHZG+2a4CWnFwtQMqmQ==
X-Google-Smtp-Source: AGHT+IFhLsvM9iNsC7Z9Gk77B7oPmq2594HIGrrnihVI9DffiOarfWHTZWxnq+tOuVUjiytsYWy3FUj5+D18DIphGKg=
X-Received: by 2002:a05:6000:154c:b0:390:ff84:532b with SMTP id
 ffacd0b85a97d-391296d894dmr55899f8f.7.1741194521507; Wed, 05 Mar 2025
 09:08:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304203123.3935371-1-bboscaccy@linux.microsoft.com>
 <20250304203123.3935371-3-bboscaccy@linux.microsoft.com> <CAHC9VhS5Gnj98K4fBCq3hDXjmj1Zt9WWqoOiTrwH85CDSTGEYA@mail.gmail.com>
 <877c54jmjl.fsf@microsoft.com> <CAHC9VhQO_CVeg0sU_prvQ_Z8c9pSB02K3E5s84pngYN1RcxXGQ@mail.gmail.com>
 <CAPhsuW6RrUiXaQe1HBYOvwUx2GFaA-RKx22955A2StsP2erTeA@mail.gmail.com> <CAHC9VhQ1BHXfQSxMMbFtGDb2yVtBvuLD0b34=eSrCAKEtFq=OQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQ1BHXfQSxMMbFtGDb2yVtBvuLD0b34=eSrCAKEtFq=OQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Mar 2025 09:08:30 -0800
X-Gm-Features: AQ5f1JpbqWJ2U2ge5hW2KG36R4uPAlWjU6dS7IbAVApjbqNIyD5ZAKIyRS1MGwQ
Message-ID: <CAADnVQJL77xLR+E18re88XwX0kSfkx_5O3=f8YQ1rVdVkf8-hQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/2] selftests/bpf: Add is_kernel parameter to
 LSM/bpf test programs
To: Paul Moore <paul@paul-moore.com>
Cc: Song Liu <song@kernel.org>, Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
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

On Wed, Mar 5, 2025 at 8:12=E2=80=AFAM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Tue, Mar 4, 2025 at 10:32=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> > On Tue, Mar 4, 2025 at 6:14=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > > On Tue, Mar 4, 2025 at 8:26=E2=80=AFPM Blaise Boscaccy
> > > <bboscaccy@linux.microsoft.com> wrote:
> > > > Paul Moore <paul@paul-moore.com> writes:
> > > > > On Tue, Mar 4, 2025 at 3:31=E2=80=AFPM Blaise Boscaccy
> > > > > <bboscaccy@linux.microsoft.com> wrote:
>
> ...
>
> > Do we need this in the LSM tree before the upcoming merge window?
> > If not, we would prefer to carry it in bpf-next.
>
> As long as we can send this up to Linus during the upcoming merge
> window I'll be happy; if you feel strongly and want to take it via the
> BPF tree, that's fine by me.  I'm currently helping someone draft a
> patchset to implement the LSM/SELinux access control LSM callbacks for
> the BPF tokens and I'm also working on a fix for the LSM framework
> initialization code, both efforts may land in a development tree
> during the next dev cycle and may cause a merge conflict with Blaise's
> changes.  Not that a merge conflict is a terrible thing that we can't
> work around, but if we can avoid it I'd be much happier :)
>
> Please do make the /is_kernel/kernel/ change I mentioned in patch 1/2,
> and feel free to keep my ACK from this patchset revision.

My preference is to go via bpf-next, since changes are bigger
on bpf side than on lsm side.

Re: selftest.

Why change them at all if 'bool kernel' attribute is unused ?
Addition of the attr should be backward compatible change,
so all tests should still pass as-is.

You probably should add a new test where 'kernel' arg is actually
used for something. That would be patch 2.

