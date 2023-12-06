Return-Path: <bpf+bounces-16901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA61807660
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 18:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EF16B20F3D
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 17:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E5B61FD7;
	Wed,  6 Dec 2023 17:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuFkquL8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3676D40
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 09:18:45 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c9f57d9952so58662261fa.3
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 09:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701883124; x=1702487924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byYYh82SJe6H7l5tEMaIOQSSi0orbRxeAIv9UdI0PyM=;
        b=TuFkquL8yLz7rrZSv3zPcKbZlaaIkaDylqLVaSUAXHRn6bSm/eUVKwxh1b0I2wL75M
         IBhugzMILLIKvrhqsLMdMs8TBPUbNtyk7hV5bhcfFA/W+1AdHZiOFeCZ1RZ/AbOM8blz
         dPaOf7iAxKrhmEObPkFM1A89TuAe/EZ+BA7x4T+76dypCwFgAY03FfTvgYRN+2d39JMC
         cE8FB5JQA7/vIdRn6RxNuZkUM9PGML13KxRud6zMC938x+ueVg1k7z8tcStctDjLD0Xu
         HIpouE5BLw/fK5GVYfRzr5muZbTF9BuUOAc+A91SfS4LfN1By5wYAvWiH7RLNXr8yn9W
         D9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701883124; x=1702487924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=byYYh82SJe6H7l5tEMaIOQSSi0orbRxeAIv9UdI0PyM=;
        b=sCN8CuhMyWBvRzmqp18lHq8oll4KH8+ixoyiIbv3t1fLbAdjJiMevgDjPnC2EqJWzG
         jTynDFnvuxPsSdj1WEwe1Gzu7NzGsAYiVoWvLtwYIxIoQVcG6/BYXUQlob0JRNFXdEqt
         lvx6KJeYm0w9xIsGL8b3k8jE9yZsN9TS/tGR3cS38w/ZjhDi0GFBhIMxFhPmEMNA3UYB
         dSQ64LFNDXyWRqOPk4mM8ycPT4vmJUIj7p4sXJNfFjgHdXA/2BRLYQRMT5w+XGpH9VRQ
         sMRqkHFi3326klfZoZj+NjEGqGPJ9Ikhg7xuSalpMMuPGk6EktXSyTxNjSeH4A+owLg3
         t4Rg==
X-Gm-Message-State: AOJu0YwTN8MNLUWeF9AaVybrEOOW4135+Gg2VMbTW8iDcR24CakzIOIC
	/++bdQsNxBBLbGvEt2F79Od0DA3JYA8nZtefbbezS+WV
X-Google-Smtp-Source: AGHT+IGlMWCnI/jUcoKfYZBg+/4Fu2UwRZdeWTxqzgZ5rH4ZSqhaRjjUeL345xyAJDncOw8BcwVGaf/F6NaoKWp1+ZA=
X-Received: by 2002:a2e:730a:0:b0:2c9:eeff:3f6f with SMTP id
 o10-20020a2e730a000000b002c9eeff3f6fmr665490ljc.51.1701883123841; Wed, 06 Dec
 2023 09:18:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201094729.1312133-1-jiejiang@chromium.org>
 <20231205-versorgen-funde-1184ee3f6aa4@brauner> <CAEf4BzZY=twEbSyE7cLee_aYcH3k8qxUEt6tBC_G-etU7E9JpA@mail.gmail.com>
 <20231206-ruhmreich-abklopfen-21c69e3e9cfd@brauner>
In-Reply-To: <20231206-ruhmreich-abklopfen-21c69e3e9cfd@brauner>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 6 Dec 2023 09:18:31 -0800
Message-ID: <CAEf4BzbXiptd+VkJfamubDHkj3kJ40VpzrCzkwcj9ygJy-tSdA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Support uid and gid when mounting bpffs
To: Christian Brauner <brauner@kernel.org>
Cc: Jie Jiang <jiejiang@chromium.org>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	vapier@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 2:58=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Tue, Dec 05, 2023 at 10:28:39AM -0800, Andrii Nakryiko wrote:
> > On Tue, Dec 5, 2023 at 8:31=E2=80=AFAM Christian Brauner <brauner@kerne=
l.org> wrote:
> > >
> > > On Fri, Dec 01, 2023 at 09:47:29AM +0000, Jie Jiang wrote:
> > > > Parse uid and gid in bpf_parse_param() so that they can be passed i=
n as
> > > > the `data` parameter when mount() bpffs. This will be useful when w=
e
> > > > want to control which user/group has the control to the mounted bpf=
fs,
> > > > otherwise a separate chown() call will be needed.
> > > >
> > > > Signed-off-by: Jie Jiang <jiejiang@chromium.org>
> > > > ---
> > >
> > > Sorry, I was asked to take a quick look at this. The patchset looks f=
ine
> > > overall but it will interact with Andrii's patchset which makes bpffs
> > > mountable inside a user namespace (with caveats).
> > >
> > > At that point you need additional validation in bpf_parse_param(). Th=
e
> > > simplest thing would probably to just put this into this series or in=
to
> > > @Andrii's series. It's basically a copy-pasta from what I did for tmp=
fs
> > > (see below).
> > >
> > > I plan to move this validation into the VFS so that {g,u}id mount
> > > options are validated consistenly for any such filesystem. There is j=
ust
> > > some unpleasantness that I have to figure out first.
> > >
> > > @Andrii, with the {g,u}id mount option it means that userns root can
> > >
> > > fsconfig(..., FSCONFIG_SET_STRING, "uid", "1000", ...)
> > > fsconfig(..., FSCONFIG_SET_STRING, "gid", "1000", ...)
> > > fsconfig(..., FSCONFIG_CMD_CREATE, ...)
> > >
> > > If you delegate CAP_BPF in that userns to uid 1000 then an unpriv use=
r
> > > in that userns can create bpf tokens. Currently this would require
> > > userns root to give both CAP_DAC_READ_SEARCH and CAP_BPF to such an
> > > unprivileged user.
> >
> > This is probably fine. Basically the only difference is that BPF FS
> > can be instantiated inside an unpriv namespace, instead of in a
> > privileged parent namespace, right?
>
> Hm, I think this is slightly misphrased but I guess I get what you mean.
>
> Basically, userns root can change what {g,u}id bpffs will use to
> instantiate inodes once init_user_ns root creates the superblock. IOW,
> the {g,u}id mount option isn't guarded and can thus be changed by userns
> root.
>
> >
> > But delegate_xxx options are still guarded by the explicit
> > capable(CAP_SYS_ADMIN) check, so that unprivileged user won't be able
> > to grant themselves BPF token-enabling capabilities without a
> > privileged parent doing it on their behalf.
> >
> > Is my understanding correct or am I missing some nuance here?
>
> No, that's correct.

Ok, thanks, then it seems like it's all good w.r.t. interaction with
delegate_xxx options and BPF token creation.

