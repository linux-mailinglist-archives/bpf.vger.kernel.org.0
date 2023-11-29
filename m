Return-Path: <bpf+bounces-16204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C827FE462
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 00:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7EE2B2109C
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 23:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413FB47A7A;
	Wed, 29 Nov 2023 23:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6Tt2UZp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B46219FE
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 23:58:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CA9C433CD
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 23:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701302296;
	bh=Xg14zcXiqVmwyfKFlfmykoCDd2MTb+jZ06SN452TO4I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p6Tt2UZpHWf1F52QgeVjt2YmsgmSK793x1q0BLDhj+0fjrzpLWZ7y9i78REuT54LJ
	 OsD8Ne52jXtg7cUe1QZBaaejvDoyDPRcl4CHTsDKOKUIHZ3ffhEezHq8Zv0CP+YJSU
	 NSf2WbIoJju0IvAWYqzoU3RV3GK4nTKoc+8Uuwy9eAly9T1R5bzurCbtIqNGnzyXfp
	 xfAKSFjM63mirR66UtgFJ52/c7slantHfiOvjgbd2QlMHD1JJOlK2c1Lz2rsKn2U+K
	 1Mdzyryuo7gbBatkFvnUvz9dTYPcxn7aWqrlsyw6nXmIkbrnA3m2lhRgbjniUvp7Ok
	 xHPmDpk4A1K+g==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50bce42295eso4600e87.2
        for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 15:58:16 -0800 (PST)
X-Gm-Message-State: AOJu0Yy7Ovlm2GO8QzsRJ1P9WeqwF2YcinVR1iX/UEQtDWmHglu/OUxe
	6VjpfsUhKoiGuHe5tn/wSJB45F+FdMN9jUBNRlg=
X-Google-Smtp-Source: AGHT+IGoEUfetLKO+tecH5R6UCPfklDvEY48tfkrOior7DOcsBy+YjMKfgEq4tFufgF/jG0ACS1UiJTnnhteybMejQo=
X-Received: by 2002:ac2:5229:0:b0:50b:c200:b45e with SMTP id
 i9-20020ac25229000000b0050bc200b45emr3116809lfl.38.1701302294284; Wed, 29 Nov
 2023 15:58:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129195240.19091-1-9erthalion6@gmail.com> <20231129195240.19091-2-9erthalion6@gmail.com>
In-Reply-To: <20231129195240.19091-2-9erthalion6@gmail.com>
From: Song Liu <song@kernel.org>
Date: Wed, 29 Nov 2023 15:58:02 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6J+ZN7KQdxm+2=ZcGGkWohcQxeNS+nNjE5r0K-jdq=FQ@mail.gmail.com>
Message-ID: <CAPhsuW6J+ZN7KQdxm+2=ZcGGkWohcQxeNS+nNjE5r0K-jdq=FQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/3] bpf: Relax tracing prog recursive attach rules
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev, 
	dan.carpenter@linaro.org, olsajiri@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 11:56=E2=80=AFAM Dmitrii Dolgov <9erthalion6@gmail.=
com> wrote:
>
> Currently, it's not allowed to attach an fentry/fexit prog to another
> one of the same type. At the same time it's not uncommon to see a
> tracing program with lots of logic in use, and the attachment limitation
> prevents usage of fentry/fexit for performance analysis (e.g. with
> "bpftool prog profile" command) in this case. An example could be
> falcosecurity libs project that uses tp_btf tracing programs.
>
> Following the corresponding discussion [1], the reason for that is to
> avoid tracing progs call cycles without introducing more complex
> solutions. Relax "no same type" requirement to "no progs that are
> already an attach target themselves" for the tracing type. In this way
> only a standalone tracing program (without any other progs attached to
> it) could be attached to another one, and no cycle could be formed. To
> implement, add a new field into bpf_prog_aux to track the number of
> attachments to the target prog.
>
> As a side effect of this change alone, one could create an unbounded
> chain of tracing progs attached to each other. Similar issues between
> fentry/fexit and extend progs are addressed via forbidding certain
> combinations that could lead to similar chains. Introduce an
> attach_depth field to limit the attachment chain, and display it in
> bpftool.
>
> Note, that currently, due to various limitations, it's actually not
> possible to form such an attachment cycle the original implementation
> was prohibiting. It seems that the idea was to make this part robust
> even in the view of potential future changes.
>
> [1]: https://lore.kernel.org/bpf/20191108064039.2041889-16-ast@kernel.org=
/
>
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>

We discussed this in earlier version:

"
> If prog B attached to prog A, and prog C attached to prog B, then we
> detach B. At this point, can we re-attach B to A?

Nope, with the proposed changes it still wouldn't be possible to
reattach B to A (if we're talking about tracing progs of course),
because this time B is an attachment target on its own.
"

I think this can be problematic for some users. Basically, doing
profiling on prog B can cause it to not work (cannot re-attach).

Given it is not possible to create a call circle, shall we remove
this issue?

Thanks,
Song

