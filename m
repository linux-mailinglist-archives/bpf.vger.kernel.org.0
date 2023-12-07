Return-Path: <bpf+bounces-17059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3DF8096B5
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 00:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA39B1F21343
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 23:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3455732F;
	Thu,  7 Dec 2023 23:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTvgffb7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557DE4AF93;
	Thu,  7 Dec 2023 23:43:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A40C433C9;
	Thu,  7 Dec 2023 23:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701992582;
	bh=wcWPEmfjq6jvvb3POH12HzDujy4J/b5obOd0n9Za7EE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dTvgffb7aN2eDey3iaUseIVTmSA+D75zi6g8RNt7CuQY8E+0mux4aKe1PVwrJuseL
	 T5SYMS5hWJ+/XcrH586dfadrngCkTTD0x8nyMP+TIhholoLMdVVKHHJaEDOfY/BpkY
	 OBomZfzrS8J1l/iItZBUvWTc0BMjRtT0dvFhU+3ikwUbc/8d6VIea/XJJU260Ous4F
	 FAOOonWDqHlZWoI1ernREnEzt8Zl1qygQOz28pWNmANEklHzex3gfpeYcgqkV5q7JC
	 LrxlL7C4LNTDyUCOksq5IyJl3lZqcduRM8n4SS8rSuAzBiAdqKemQv5Uz9MpmW/Y40
	 KaZkGAJTzrIqQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50bf3efe2cbso1662586e87.2;
        Thu, 07 Dec 2023 15:43:02 -0800 (PST)
X-Gm-Message-State: AOJu0YyMvgnOJEh7LgGidRqTOlx1SIW/rwLGy/Oqqeyj7EqsPutp24dQ
	ISvzpDZ/qROFXsAMZh2JyHjV1aKMdqGnXxtq/sE=
X-Google-Smtp-Source: AGHT+IFrGpx5bS0dIqhanZTe0/anNDnOxiZrTUREBukJIii7ongRRR+ad6gRx2sFZf0iZVj7hHX1rIq8Y2dZXHDgPKc=
X-Received: by 2002:a19:501c:0:b0:50b:e724:62aa with SMTP id
 e28-20020a19501c000000b0050be72462aamr874024lfb.226.1701992581136; Thu, 07
 Dec 2023 15:43:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZW+KYViDT3HWtKI1@CMGLRV3> <CACYkzJ5iyiUi_3r439ZMRnjM2f9Wd0XYoGJYQY=aXJ4QmX7e-A@mail.gmail.com>
 <ZXJViQDsdj7Bg4e9@CMGLRV3>
In-Reply-To: <ZXJViQDsdj7Bg4e9@CMGLRV3>
From: Song Liu <song@kernel.org>
Date: Thu, 7 Dec 2023 15:42:49 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6dib__mB8RJUPQGz_f+NLKmdVE3HsZ1JTy6_Ga7ysViw@mail.gmail.com>
Message-ID: <CAPhsuW6dib__mB8RJUPQGz_f+NLKmdVE3HsZ1JTy6_Ga7ysViw@mail.gmail.com>
Subject: Re: BPF LSM prevent program unload
To: Frederick Lawler <fred@cloudflare.com>
Cc: KP Singh <kpsingh@kernel.org>, revest@chromium.org, jackmanb@chromium.org, 
	bpf@vger.kernel.org, kernel-team@cloudflare.com, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	laoar.shao@gmail.com, casey@schaufler-ca.com, 
	penguin-kernel@i-love.sakura.ne.jp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frederick,

On Thu, Dec 7, 2023 at 3:30=E2=80=AFPM Frederick Lawler <fred@cloudflare.co=
m> wrote:
>
[...]
> > While, I think this may be doable with existing LSM hooks but we need
> > to probably have to cover multiple hook points needed to prevent one
> > action which makes a good case for another LSM hook, perhaps something
> > in the link->ops->detach path like
> > https://elixir.bootlin.com/linux/latest/source/kernel/bpf/syscall.c#L50=
74
> >
> > What do you think?
>
> That's what I was thinking for option (4) "introduce a
> security_bpf_prog_unload()". Anyway, I agree. Paul brought up a good
> point that he'd like to see more discussion around this idea [1].
> Mucking with the mounts (see below) is a bit of a mess, and there could
> still exist other methods for unloading I'm not aware of yet.
>
> Yesterday I whipped up a hack such that:
>
>         mkdir -p /run/fs/bpf-lsm
>         mount -t bpf none /run/fs/bpf-lsm
>         ./load-policies /run/fs/bpf-lsm

Trying to understand the solution here. Does load-policies add multiple
policies to stop different ways to unload the LSM BPF program (unpin,
umount, etc.)? So the only way to unload these policies is reboot. If this
is the case, could you please share the list of hooks needed to achieve a
secure result? If the list is really long, we should probably add an option=
 to
permanently load and attach a program (until reboot).

Thanks,
Song

