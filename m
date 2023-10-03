Return-Path: <bpf+bounces-11330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1417B7552
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 01:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id D6DAD1F21A58
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 23:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11D4405F9;
	Tue,  3 Oct 2023 23:41:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D93C3FB09
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 23:41:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6146C433CC
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 23:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696376487;
	bh=kf0WrV8kqjILXnFrNx+nNeu/jWlbgpfK5XFmKhicOyk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BJ5iu4LBlG6XCTSh2En1w4yEyBb3NUgcO/eCitDWrl/S7wHiWT7JbzMIlxfcDNa2n
	 VH4qeCqE9jVIEQYaYIs5FCW+V+QCbPVNvy4YwZz71qC+mI4mWflepBxiNpiNgECHlH
	 x/8yngnTp7Nr2ZfkTt3UFlXXRiW3vTWbItmXRZQM7XBWXZCQORKdkg1H5JxE0q9NSk
	 zzqV5cgYHfO16ESjU2bNRK0Ws8G8paDlV2xVA9/XXtAJqw+7MCGCIWtdjiJC4BVMGh
	 n6kb12uvWnqOidGr9hrsV4o0695yYzpNHjchAvOe13AjAKIC1/2B9dvc9LEKowGtUV
	 icrWat+COf68w==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-533d31a8523so2773149a12.1
        for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 16:41:27 -0700 (PDT)
X-Gm-Message-State: AOJu0YzR/I0fzOL9k/JiYP+1Wg9/aNUFoI3BU++pqG0OFsBjju2pzGCg
	bkzFykhVnXPDtAjFzxTzqKLMkhyMYnzLOYggf/9Juw==
X-Google-Smtp-Source: AGHT+IEbNW1alkMAyzOd2bcxK/nUbwF6w5xhsH/hTLGTvt5MTkpHzHkGP5bcyRnxTAbo0jmWYHddNqSABLEh4qw/XDQ=
X-Received: by 2002:a50:ee91:0:b0:51e:53eb:88a3 with SMTP id
 f17-20020a50ee91000000b0051e53eb88a3mr510889edr.25.1696376486108; Tue, 03 Oct
 2023 16:41:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp>
 <CACYkzJ5k7oYxFgWp9bz1Wmp3n6LcU39Mh-HXFWTKnZnpY-Ef7w@mail.gmail.com> <CAHC9VhTCHPA+xY=KuLAzUsAKzXG8bMi0SGhGArtHMQVr85MTFw@mail.gmail.com>
In-Reply-To: <CAHC9VhTCHPA+xY=KuLAzUsAKzXG8bMi0SGhGArtHMQVr85MTFw@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Wed, 4 Oct 2023 01:41:15 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7mAaYnfuhTh8zkS9A0SsiEdDfLA0JCaUgLhvCPZU8Yfg@mail.gmail.com>
Message-ID: <CACYkzJ7mAaYnfuhTh8zkS9A0SsiEdDfLA0JCaUgLhvCPZU8Yfg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] LSM: Allow dynamically appendable LSM modules.
To: Paul Moore <paul@paul-moore.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, bpf <bpf@vger.kernel.org>, 
	Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 4, 2023 at 1:27=E2=80=AFAM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Wed, Sep 27, 2023 at 12:02=E2=80=AFPM KP Singh <kpsingh@kernel.org> wr=
ote:
> >
> > Until I hear the real limitations of using BPF, it's a NAK from me.
>
> There is a lot going on in this thread, and while I'm still playing
> catch-up from LSS-EU and some time off (ish) it looks like most of the
> most important points have already been made, which is great.
> However, I did want to comment quickly on the statement above.
>
> We want to be very careful about using an existing upstream LSM as a
> reason for blocking the inclusion of a new LSM upstream.  We obviously
> want to reject obvious duplicates and proposals that are sufficiently
> "close" (with "close" deliberately left ambiguous here), but we don't
> want to stifle new ideas simply because an existing LSM claims to "do
> it all".  We've recently been trying to document this, with the latest
> draft viewable here:
>
> https://github.com/LinuxSecurityModule/kernel#new-lsm-guidelines

Thanks for the context and documenting this Paul.

>
> --
> paul-moore.com

