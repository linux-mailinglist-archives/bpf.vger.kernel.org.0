Return-Path: <bpf+bounces-49406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBEEA18322
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 18:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 343507A2A33
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 17:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B481F5436;
	Tue, 21 Jan 2025 17:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOYs6YZh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6950E1F5426;
	Tue, 21 Jan 2025 17:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737481284; cv=none; b=MEV4CH8p+0FhqEz+ia4BJ0Ke9i16vMhFX0pCrZCCoIdFnPCbav2pixaBqe8dQKrMnezVzgK+ce7RJ+LbYYHXZyfd+DkBIdctnAhWMosnGHWN0itwT1D6kKP8T/i0FWgfCVFx3BTPaFkzO2Df/9jL7F4p0OurFhk+s93bAzkC4m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737481284; c=relaxed/simple;
	bh=0mfdTlrho6yAn9YT/6FDV9MRKUZyHu+QI0b7rIAS51A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSOAeT+BsZ24LLWfjJYd+2SWRNK4XK2C5WKiWIaQdkN6PvDhPIP5ISnQ9z4y9i2orypqZIJ5KiZqn7adtETC5GZUQlSoYx3NZvsrDr1JKXdbsPW0O66lZ9cwpLY8Q4ooJRwK70waoRRz2HifBd+87G7e6WG86xIswJGEq2lFXCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOYs6YZh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465AAC4CEEB;
	Tue, 21 Jan 2025 17:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737481284;
	bh=0mfdTlrho6yAn9YT/6FDV9MRKUZyHu+QI0b7rIAS51A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vOYs6YZhNlG22xhE81AON1jOuqWOb7ZwKBbgJz5Llp6qUB2RraR9aW2ngjmmqDbDM
	 R+qIkjCrmbuLu1gLrL4MYvN5gdBy1d6F3m7GxYtl2tBvWxDqi9wb6eKS9RH7pI+WRc
	 7dhecSGuFg4kFFCaBtYnR0xhfN3H3EoCvhPbm/cpY7jSRmXWCk7pXOPVaiJ6SEhsZv
	 tXCFadWaihFuQXmicwRyxWiXkUOkTbAfPZY+RwBPwuMyUYVoZQHWuwqGnw8oITTWl4
	 L82ktVq0avZPbCPiChg0mzxxLNizkY9kIqgJdS/3m/T0WltrPEaczbyBv4n+Hb66KP
	 uoZLl8Sj2VJVA==
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3ce7f6fdd2aso47577545ab.3;
        Tue, 21 Jan 2025 09:41:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVFYSaid8iSYRCgmS0q40BI2Nn0yFF3y2lg48RE0hcFtENfFnJMf19Wo2t1BKcd1ygLA/s=@vger.kernel.org, AJvYcCWmM6lXHdwRBs/95WIqZdlJGSxhW/PCVRcSH8/IxXTVjrC2tgLzEZdljjYAAszk3ueMaaDISyM49eB4CrLx@vger.kernel.org
X-Gm-Message-State: AOJu0YzrdgjU6kGSKPbGVQnjDG/1tXrWy0Q/+vz4wG4oJFweR1flDwfq
	SUOwBt+KDLoIr//WExD34H1BFLA/MwFM2GWQLFHEck+6lib0SWfF1IU7cCwaC+23nkqGKEEDnN5
	iY00EMBu4A72rjtV0uQFaYVTTmHA=
X-Google-Smtp-Source: AGHT+IEUDRYo81bXSAyeoZlUKZifQcamjDABYBMvpGgCxThKWGfEojjzRAPox9vm1YZRP36nC41t63Rb3ByydFeutk4=
X-Received: by 2002:a05:6e02:2197:b0:3a7:956c:61a4 with SMTP id
 e9e14a558f8ab-3cf7440f740mr139741365ab.10.1737481283423; Tue, 21 Jan 2025
 09:41:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB5080C05323552276324C4B4C991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB508044E85205F344C4DA4B5F991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAPhsuW4F5uyJKa2Gg1QYRy8_FBERgaj=z4smxtjKa5NF_Zac8w@mail.gmail.com>
 <AM6PR03MB508002DCA7DBE7C7712ECC30991B2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAPhsuW4sd5LgmPjceFqaLGu20N4EVxRB_-FWOm5vcCGcRPa3ZA@mail.gmail.com> <AM0PR03MB507665DA7BA404C64EB016F099E72@AM0PR03MB5076.eurprd03.prod.outlook.com>
In-Reply-To: <AM0PR03MB507665DA7BA404C64EB016F099E72@AM0PR03MB5076.eurprd03.prod.outlook.com>
From: Song Liu <song@kernel.org>
Date: Tue, 21 Jan 2025 09:41:12 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5duwV_OErkW-DbuwAkDX-X1KFMnqoFobn2f+VOtbPkTg@mail.gmail.com>
X-Gm-Features: AbW1kvbkpEYNQIvaUriYSVYo_G7gj7N0hZKnwfqru_meliwnH4zlQgDrmWlnvy4
Message-ID: <CAPhsuW5duwV_OErkW-DbuwAkDX-X1KFMnqoFobn2f+VOtbPkTg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/7] bpf: Add enum bpf_capability
To: Juntong Deng <juntong.deng@outlook.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, martin.lau@linux.dev, eddyz87@gmail.com, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, tj@kernel.org, 
	void@manifault.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 1:50=E2=80=AFPM Juntong Deng <juntong.deng@outlook.=
com> wrote:
>
[...]
>
> >>
> >> Would it be a better idea for us to let each kfunc have its own
> >> capability attribute?
> >
> > This is no different to the BPF helper function ID, which turned
> > out to be not scalable.
> >
>
> There still seems to be a difference? BPF capabilities are not
> one-to-one with kfuncs, and multiple kfuncs can be bound to one
> BPF capability.
>
> BPF capabilities are more like fine-grained versions of program types.

I personally think struct_ops gives good enough fine-grained control.
Therefore, I don't see a real need for a different concept.

[...]

> >>
> >> For example, if a system administrator wants to open the features of t=
he
> >> HID-BPF driver to users, but the system administrator does not want to
> >> open other BPF features to users, such as sched_ext.
> >
> > This appears to be a totally separate topic.
> >
>
> Although I am not sure, I guess general fine-grained permissions
> management might still be valuable (not necessarily BPF capabilities).
>
> I found that Andrii Nakryiko implemented something similar in
> BPF Token[0].
>
> Similar to SCX, BPF features are fine-grained through masks to restrict
> only part of the BPF features to be opened.
>
> This seems to indicate that the demand for making BPF permissions
> management fine-grained has always existed, and the demand for opening
> only part of the BPF features will reappear in different forms.
>
> Maybe we do need a general fine-grained permissions management solution?

I don't think it is easy to build a fine-grained permission management
solution that fits most scenarios. It is better to do this via programmable
interfaces, e.g. with BPF LSM.

Thanks,
Song

> If Andrii saw this email, could you please join the discussion?
>
> [0]: https://lwn.net/Articles/947173/
>

