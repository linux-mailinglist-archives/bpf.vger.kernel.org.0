Return-Path: <bpf+bounces-60393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06932AD61C8
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 23:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA76188A9F6
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 21:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8CF246BD8;
	Wed, 11 Jun 2025 21:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhhUVeIg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0241F246BBE
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 21:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749678299; cv=none; b=eV0ENeKA5eKBfXg7ceIxP1wJAKoXh3raJJYSdPf593JrWsBkOO+zPC/7vlaSo52OCg3t3UGzn3Bc7e4fX6dnVgxSKo2NoYAAF2NAzQ477F+/kygneFmXqFNWOhgHMnWylB9mfqkTOrANNLephoQVfhBAuGG511zkh9kZYW1gcso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749678299; c=relaxed/simple;
	bh=n8krQhktZ2+O8eYKDmiKPqrtCH3jMnXwJbh6O61FSdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7XuYQXPsv1aOMjp0Qel7mfFAJ9FwDNFI41vkL2aSa2lJ215ZrObOG9y2PzA3gBRRwra3TIu+XW9mDwz+lk4nGehL0XDMrg21BatLbrntdp5z8qkOyf+PAiinLJe2mmYuWL+M5QEUhXG4x0XSwlytVRjoQ7agtMVhqfA1vOTLpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhhUVeIg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99544C4CEEF
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 21:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749678298;
	bh=n8krQhktZ2+O8eYKDmiKPqrtCH3jMnXwJbh6O61FSdg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FhhUVeIgAeBNH25fxz9oF0odfWBB9PCaUfnZ4Q0YUP1YP30jI0aSCxpKEN3pXZ/EL
	 umQQMj9Sz4pmfPR+Ybo9RF3zIJZUew1g3geO7Ww+HifXG+TmVZIJQGLzuwB3L4oeJv
	 DSQ8d/Mwuwj6r9yvffQlKz4+tyPP7FydgSzV5y20ZO6ZuwUwwX3P7zFdU8OOMhjfbz
	 aolAgQ+VphU2suMW+Cq1r84uDzCt5O04fpZcL+hGMwPXoPQf/3aFQoYlTA9bEF4F7J
	 CcvwLl+jMfas+iyElop0ijOWC77R4rliQaht5RcPb7zlHmVs8dPCD4YwMcPyx4AELX
	 SRWEswMpxhSCw==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-606c5c9438fso741786a12.2
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 14:44:58 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzg1K5j17kXlgYQum5LWHx3pZW+mcZMH0Qq+qzdujaMwp4wiquh
	XnS5zUHp7nS/Q+CYh+TzqtqLa2c9USCohk52BS22u6Pu6LcbmdzL3nv6yyEOwIghz7FEq/E2pvs
	/T9cUaVWyHzRNE4wUqSISnTdyC4i3jOsS3WCbHtyQ
X-Google-Smtp-Source: AGHT+IHA+AUKel2ZtXicLgKbiI8vDiZy0J6C+3o8M8qgMlN0xZxNBSvqc+itN5oBMIgV5dEJMHIRBCLMglhHx1QFq+w=
X-Received: by 2002:a05:6402:2805:b0:607:425c:3c23 with SMTP id
 4fb4d7f45d1cf-6086a671559mr350762a12.5.1749678297111; Wed, 11 Jun 2025
 14:44:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-4-kpsingh@kernel.org>
 <CAADnVQLMff33qY+xY3Ztybbo38Wr9-bp_GPcoFna4EbtgTrWrg@mail.gmail.com>
In-Reply-To: <CAADnVQLMff33qY+xY3Ztybbo38Wr9-bp_GPcoFna4EbtgTrWrg@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Wed, 11 Jun 2025 23:44:46 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4v+n_6-dVSt9mgkhJPEa3r1q7YW5Zrh0c-j+gos_UOxw@mail.gmail.com>
X-Gm-Features: AX0GCFseZ-SQwR2SX_6Yxnqn9BtMZKCr0JRmpp5HerQz1Mp0lNk5-yqzWXsCimk
Message-ID: <CACYkzJ4v+n_6-dVSt9mgkhJPEa3r1q7YW5Zrh0c-j+gos_UOxw@mail.gmail.com>
Subject: Re: [PATCH 03/12] bpf: Implement exclusive map creation
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 10:58=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jun 6, 2025 at 4:29=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrot=
e:
> >
> > Exclusive maps allow maps to only be accessed by a trusted loader
> > program with a matching hash. This allows the trusted loader program
> > to load the map and verify the integrity.
> >
> > Both maps of maps (array, hash) cannot be exclusive and exclusive maps
> > cannot be added as inner maps. This is because one would need to
> > guarantee the exclusivity of the inner maps and would require
> > significant changes in the verifier.
>
> I was back and forth on it early, but after sleeping on it
> I think we should think of exclusive maps as a generic concept and
> not tied to trusted loader and prog signatures.
> So any map type should be allowed to be exclusive and this patch
> can handle it fine without adding more complexity.
> In map-in-map case the outer map can be created exclusive
> to a particular program, but inner maps don't have to be exclusive,
> and it's fine. The lskel loader won't be using map-in-map anyway,
> so no issues there.

So the idea here is that if an outer map has exclusive access, only it
can add inner maps. I think this is a valid combination as it would
still retain exclusivity over the outer maps elements.

- KP

>
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---

[...]

> >

