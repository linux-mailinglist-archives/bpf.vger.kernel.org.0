Return-Path: <bpf+bounces-59374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B843AC96BA
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 22:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74D601C204EB
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 20:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CD227A468;
	Fri, 30 May 2025 20:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbPhc/no"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FF3283159
	for <bpf@vger.kernel.org>; Fri, 30 May 2025 20:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748637885; cv=none; b=D+GjYJGMxXi+egMONjB8Ktz6mdYBCgzjgKkBINqwE75/vGmRcHMU8C7iRjExs0SYLuqjSLRARNiIPqgL2+8N2bn43qr0x4BQykhJc4htEUbdQ3pKbL2UAKPAiXIkRwSPUyzdlrVQnv4RKNPuTkittvgGuDqQw+cHdB3lRk7u8gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748637885; c=relaxed/simple;
	bh=WKODy9FgXDgbxxqWIA/IwTJOy8VJdioFU2ccnli5Qqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDd92YVnewYhCfon9xVvW7wgg7DfSKBldcj0Th71iWTB6mqgcqzMaUiGNY75WMJAnJAglmZKONFOTRR9HHVvhdkR8ZPv7mrV3hhZs2KBdJVqiYT076hsJkgK9S7im3g1uOOdyz068L8WMk1PYb30A5yhAmUPKVEfSyhmDLHMvsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbPhc/no; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7181C4CEF7
	for <bpf@vger.kernel.org>; Fri, 30 May 2025 20:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748637884;
	bh=WKODy9FgXDgbxxqWIA/IwTJOy8VJdioFU2ccnli5Qqw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CbPhc/no0sprPn3MpKuqpBbsDpyw9abX5ODIn1jJi6UkVBrWyHG4hA2FG5nFkCVSp
	 w7HUoXKR8iWP5TENPwSpNXcF31CXXNZp26hUnvXfB/+22FafWkB0EYN7V+qfKbY0TA
	 wEo20e7ECyluRc2B8UpVE8o60SlqtVocaXAQH1/iBVgjVptT5tz6XuIOz2H2l7BYWX
	 LmnGZ0oFerv2zqPVzvtRd/t2ZrHV0AIeRMkylsU85E1P4clXyGb2EAVLTR7W87J5p9
	 vH/dAIJCMs1S+jWkvRQds74WhsJdCgIFqk2Vx26n+oi/CqgNPW6vFdVh2mck5Gnjki
	 h4X3m4ZvxTUTg==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad93ff9f714so440052366b.2
        for <bpf@vger.kernel.org>; Fri, 30 May 2025 13:44:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMmZrsea4/+1WQj/UOIUh7PBrUE+AVbiQuSxnyLUMtak2qnnBJr/0upqr92WwVVKpYnxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YysMWf9URPxOsr/mhP83SIeZUQ2rZ0nSGFNzc3+/g/ktkcqKmO9
	gNHgwV5uj+638GqE3wMV0vdrZNqiKD/CgkmDoF06NtxyE2wXp0ZLxhT8s+flenVbRDzksu8dBW7
	61keWLym5t6LSzM/UkLZuWHdFVxqxN5oSiUHAH1FS
X-Google-Smtp-Source: AGHT+IFYPjLrtRmSUw02l8acZu75ZEk31voCEunbDz/ggHhtTlCZtv6L/sdj5D+DMpzfEs9+aMo/5KET1xbavpqajeo=
X-Received: by 2002:a17:907:3d16:b0:ad8:a935:b8f9 with SMTP id
 a640c23a62f3a-adb36ba4a97mr335177366b.32.1748637883137; Fri, 30 May 2025
 13:44:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528215037.2081066-1-bboscaccy@linux.microsoft.com>
 <CACYkzJ5oJASZ43B531gY8mESqAF3WYFKez-H5vKxnk8r48Ouxg@mail.gmail.com> <CAHC9VhSLOjQr4Ph2CefyEZGiB-Vqd4a8Y9=uA2YPo79Xo=Qopg@mail.gmail.com>
In-Reply-To: <CAHC9VhSLOjQr4Ph2CefyEZGiB-Vqd4a8Y9=uA2YPo79Xo=Qopg@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Fri, 30 May 2025 22:44:32 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4W9yhET8AnwvU5hhbP8nsH12sneqzKexVs6p4C596+sA@mail.gmail.com>
X-Gm-Features: AX0GCFtEzKd5icGNP9zMXhh3w0IjhKTZ4H9XX606OWYKl73LpaAxQPOFCdjO9vc
Message-ID: <CACYkzJ4W9yhET8AnwvU5hhbP8nsH12sneqzKexVs6p4C596+sA@mail.gmail.com>
Subject: Re: [PATCH 0/3] BPF signature verification
To: Paul Moore <paul@paul-moore.com>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, jarkko@kernel.org, zeffron@riotgames.com, 
	xiyou.wangcong@gmail.com, kysrinivasan@gmail.com, code@tyhicks.com, 
	linux-security-module@vger.kernel.org, roberto.sassu@huawei.com, 
	James.Bottomley@hansenpartnership.com, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
	Ignat Korchagin <ignat@cloudflare.com>, Quentin Monnet <qmo@kernel.org>, 
	Jason Xing <kerneljasonxing@gmail.com>, Willem de Bruijn <willemb@google.com>, 
	Anton Protopopov <aspsk@isovalent.com>, Jordan Rome <linux@jordanrome.com>, 
	Martin Kelly <martin.kelly@crowdstrike.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Matteo Croce <teknoraver@meta.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 10:15=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Fri, May 30, 2025 at 12:42=E2=80=AFPM KP Singh <kpsingh@kernel.org> wr=
ote:
> > On Wed, May 28, 2025 at 11:50=E2=80=AFPM Blaise Boscaccy
> > <bboscaccy@linux.microsoft.com> wrote:
>
> ...
>
> > Please hold off on further iterations, I am working on a series and
> > will share these patches based on the design that was proposed.
>
> I don't think there is any harm in Blaise continuing his work in this
> area, especially as he seems to be making reasonable progress towards
> a solution that satisfies everyone's needs.  Considering all of the
> work that Blaise has already invested in this, and his continued
> willingness to try to work with everyone in the community to converge
> on a solution, wouldn't it be more beneficial to work with Blaise on
> further developing/refining his patchset instead of posting a parallel
> effort?  It's your call of course, I'm not going to tell you, or
> anyone else, to refrain from posting patches upstream, but it seems
> like this is a good opportunity to help foster the development of a
> new contributor.

I think Blaise's interactions leave a lot to be desired, especially as
a new contributor with the replies being unnecessarily abrasive, which
I am choosing to ignore.

Regardless, it would be more efficient to handle the subtleties here
if someone from the core BPF community implements this. This is why I
volunteered myself, but I need some time to wrap up the code and send
it on the list. Blaise can continue to send patches that don't
incorporate the feedback, it will only delay me further.

>
> > > 2. Timing of Signature Check
> > >
> > > This patchset moves the signature check to a point before
> > > security_bpf_prog_load is invoked, due to an unresolved discussion
> > > here:
> >
> > This is fine and what I had in mind, signature verification does not
> > need to happen in the verifier and the existing hooks are good enough.
>
> Excellent, I'm glad we can agree on the relative placement of the
> signature verification and the LSM hook.  Perhaps I misunderstood your
> design idea, but I took your comment:
>
> "The signature check in the verifier (during BPF_PROG_LOAD):

I meant during BPF_PROG_LOAD i.e. before the bpf_check is triggered,
as I said this is better explained when implemented.

>> trust me, friend=E2=80=9D aspect of the original design.

The kernel is the TCB, both LSM and BPF are a part of the kernel and
part of the same trust domain, LSM has sufficient information in the
existing LSM hooks to enforce a signature policy and there is no need
for a boolean:

* If attr.signature is set, it's enforced, a new boolean does not
convey any new information here.
* If we specifically need auditing here, we can add an audit call in
the signature_verification method, this can be done in a follow-up
series.


>
>  verify_pkcs7_signature(prog->aux->sha, sizeof(prog->aux->sha),
>    sig_from_bpf_attr, =E2=80=A6);"
>
> https://lore.kernel.org/linux-security-module/CACYkzJ6VQUExfyt0=3D-FmXz46=
GHJh3d=3DFXh5j4KfexcEFbHV-vg@mail.gmail.com/
>
> ... to mean that the PKCS7 signature verification was going to happen
> *in* the verifier, with the verifier being bpf_check().  Simply for my
> own education, if bpf_check() and/or the bpf_check() call in
> bpf_prog_load() is not the verifier, it would be helpful to know that,
> and also what code is considered the be the BPF verifier.  Regardless,
> it's a good step forward that we are all on the same page with respect
> to the authorization of signed/unsigned BPF programs.  We still have a
> ways to go it looks like, but we're making good progress.
>
> --
> paul-moore.com

