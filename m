Return-Path: <bpf+bounces-17009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 180DD808ACE
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 15:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDAD71F2156B
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 14:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826DF41847;
	Thu,  7 Dec 2023 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0CgGmTi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DC244375
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 14:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B21C433CA
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 14:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701959945;
	bh=YYP9M5CabZpeYJJLjhmY+B9XfRSYvsYhWN68zmz1gug=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K0CgGmTivulp3fCJm7TCUUoy4YCeDh3pgQcXYFZuRUpbThJOnpvEJ8OvWSxtVts+z
	 tR9bsH9g8sE2IEspfblOIk/lurirawgKabgdMNQXKSMhzAz1aGzmUiiVe/OVmJJaJk
	 noA99vwYANezZMVr8HPou02oHgKr3ifuDf8KHBHN61MRiV9yl9zAUHGNMnj5npoMxj
	 fCF2wU0kjT9VVOGXmqWi6oaBwkpbmDD033J3dQdSleGmWoIT2LlYvFDUG7otFIwtpC
	 YX9oVVodbI9bRLCw0vy4fXNatx983HuEQ0c5zX8HO9oDUjXUlqjNmEoLFcmOaiHbC7
	 lTCieGgydj4Zg==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50bfa5a6cffso888457e87.0
        for <bpf@vger.kernel.org>; Thu, 07 Dec 2023 06:39:05 -0800 (PST)
X-Gm-Message-State: AOJu0Yw37adKx06vxeBfd8Q35ORZ+sNSTGhy4Bo7ouPtRqEk1oOoGH1d
	ZQWcyMTRtkBCQGst+dNRiIey5Yx2/z0JjxDLJYGiUw==
X-Google-Smtp-Source: AGHT+IHm4asrHJFUvzcTf9TUol3uCZRdlRWObzUbaN9NBhZ48hMZf+a0gkHf3DLH6A9vTXJDlrBhAdl4XLP8qOvb+e4=
X-Received: by 2002:a19:7508:0:b0:50b:fcb7:313a with SMTP id
 y8-20020a197508000000b0050bfcb7313amr1770554lfe.12.1701959943696; Thu, 07 Dec
 2023 06:39:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZW+KYViDT3HWtKI1@CMGLRV3> <CACYkzJ5iyiUi_3r439ZMRnjM2f9Wd0XYoGJYQY=aXJ4QmX7e-A@mail.gmail.com>
 <CALOAHbDjdNhtkTdimkQaqrPOX2gOxao9Z_udjyPsfhPfu=+vKA@mail.gmail.com>
In-Reply-To: <CALOAHbDjdNhtkTdimkQaqrPOX2gOxao9Z_udjyPsfhPfu=+vKA@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 7 Dec 2023 15:38:52 +0100
X-Gmail-Original-Message-ID: <CACYkzJ6fgjMHvyUt0v5Z_-_uSKPu-zdKu+iXDZBNQZWsVc2WXQ@mail.gmail.com>
Message-ID: <CACYkzJ6fgjMHvyUt0v5Z_-_uSKPu-zdKu+iXDZBNQZWsVc2WXQ@mail.gmail.com>
Subject: Re: BPF LSM prevent program unload
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Frederick Lawler <fred@cloudflare.com>, revest@chromium.org, jackmanb@chromium.org, 
	bpf@vger.kernel.org, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"

> >
> > IMHO this is the best option. Here:
> >
> > * BPF LSM Program = MAC Policy
> > * Removing / detaching / updating programs = Updating MAC policy
>
> What happens if a privileged user terminates the BPF LSM task and
> deletes any pinned BPF files that might exist?

The LSM program is pinned, so it does not matter if the task is terminated.

> We can apply specific capabilities to restrict access, but it's
> important to note that privileged users might also possess these

That depends on how you implement your restriction logic. If your LSM
program says, check CAP_MAC_ADMIN -> Allow removal, then your logic
explicitly grants the privilege. If your LSM hook denies all
privileged users the ability to remove the program, then no privileged
user can remove the LSM program.

The whole point here is to restrict privileged users from doing stuff.

- KP

> capabilities.
>
> >
> > The decision around who can update MAC policy can be governed by the
> > policy itself a.k.a. implemented with BPF LSM programs.  So we can
> > update hooks (as suggested here inode_unlink, sb_unmount, path_unlink)
> > to only allow this action for a subset of users (e.g. CAP_MAC_ADMIN or
> > even further restricted)
> >
> > While, I think this may be doable with existing LSM hooks but we need
> > to probably have to cover multiple hook points needed to prevent one
> > action which makes a good case for another LSM hook, perhaps something
> > in the link->ops->detach path like
> > https://elixir.bootlin.com/linux/latest/source/kernel/bpf/syscall.c#L5074
> >
> > What do you think?
> >
> > - KP

>
>
> --
> Regards
> Yafang

