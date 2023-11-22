Return-Path: <bpf+bounces-15626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F897F3CF6
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 05:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D18171F23686
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 04:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52AA8494;
	Wed, 22 Nov 2023 04:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HILqKYZ4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A25193
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 20:41:27 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-da0359751dbso399219276.1
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 20:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700628087; x=1701232887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGTSoBXC/6Jkt5M8V7vCMsiBLn/G0YqKZNvpHoWAN7w=;
        b=HILqKYZ4n1N9Ad42Z/VVJUn+8ranxQhzx9VA0YXdMNGpyGLaH19kcqhf0DOT8b1ti9
         Zty/AZrfNDWUuF/egTOeVG3iCUyp55OxpWcEDrJjioY5l5Jpjfq3om/wQI9vOt/2ijEH
         SazXpSdMm7xzeu2Quhha+0+MJWvCG5zZBySI2+zWj4Xdi6OtTcUuWMOo/6V1EOtljMI8
         aRfPGC7vgdmzx7Ofjzm9MZNucg701zIAVyokCRBkNgpApINy8TGOtl3v0c+yrMZjitTa
         cG5MCIdP3BmeiC7N3FqHs5YexVkV3nZWkgp5e5UI17T1YGnFMqcJsayiijr2tWuFn9eX
         aXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700628087; x=1701232887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGTSoBXC/6Jkt5M8V7vCMsiBLn/G0YqKZNvpHoWAN7w=;
        b=BscoJcqzMnyK5lesQ2EWIBKMRPklK93kwEZFUl6QTF3mEX/6NDmsEtRVz6OfVAVsdb
         V4/JHwVJ13ltwyw3nmi3xEN55qSG82KZQSeJeCSGiwKeqPoVc/vYbKWBWRRRZnPNpVZE
         ZMC0j8uB26NcZ6uQkJdlxxHkkc8LRkWE0POHh+IvYfF8k/kdOZkiCGdCnXq3rKOcOMR4
         meJtoEtBnP6JR/3dLlOOn6ezk+rKpJofN0oJ4rnnA/87d4Uh2AfHm6tQaB9jRBiXkqvb
         KfH+ZGUFUCil7FJJ9h9790bP4fPL/yQQmvbRe5xKmt7qSb9//IL0q00ZuYMdnfUuJi3M
         yNyw==
X-Gm-Message-State: AOJu0YxdWwIDnDJUJuYsa4XREACvYi/SYtYC1W5Bf9jIrGUVjdRV8fjs
	R1s2AkgLISL8ENcYSbZVgMWrCRmBuBdLKAsDczBS
X-Google-Smtp-Source: AGHT+IHe8amBKBsj3yLOHRxofJ+KPSrg0taVp4UY3/qytXiDrVNd3+3/eM9zDlh5XZb5Egn1ifS1YQTJpxov+QEIpYM=
X-Received: by 2002:a25:3496:0:b0:db3:5185:1737 with SMTP id
 b144-20020a253496000000b00db351851737mr1001554yba.17.1700628086781; Tue, 21
 Nov 2023 20:41:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <93b5e861-c1ec-417c-b21e-56d0c4a3ae79@I-love.SAKURA.ne.jp>
 <CAHC9VhRbak9Mij=uKQ-Drod0tQu1+Z+JaahUzH5uj9JUf7ZTuA@mail.gmail.com> <7b9e471a-a9df-4ff6-89bf-0fed01fcd5e7@I-love.SAKURA.ne.jp>
In-Reply-To: <7b9e471a-a9df-4ff6-89bf-0fed01fcd5e7@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 21 Nov 2023 23:41:16 -0500
Message-ID: <CAHC9VhRy_sZNSRHMJoULFX2vb=opj1s2hEffaVNJyaHycWF+=w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/4] LSM: Officially support appending LSM hooks
 after boot.
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-security-module <linux-security-module@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, song@kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, renauld@google.com, 
	Paolo Abeni <pabeni@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 8:03=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2023/11/21 7:52, Paul Moore wrote:
> > On Mon, Nov 20, 2023 at 8:28=E2=80=AFAM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>
> >> This functionality will be used by TOMOYO security module.
> >>
> >> In order to officially use an LSM module, that LSM module has to be
> >> built into vmlinux. This limitation has been a big barrier for allowin=
g
> >> distribution kernel users to use LSM modules which the organization wh=
o
> >> builds that distribution kernel cannot afford supporting [1]. Therefor=
e,
> >> I've been asking for ability to append LSM hooks from LKM-based LSMs s=
o
> >> that distribution kernel users can use LSMs which the organization who
> >> builds that distribution kernel cannot afford supporting.
> >
> > It doesn't really matter for this discussion, but based on my days
> > working for a Linux distro company I would be very surprised if a
> > commercial distro would support a system running unapproved
> > third-party kernel modules.
>
> A commercial distro does not care about problems that are caused by
> using kernel modules that are not included in that distro's kernels.

My experience has taught me otherwise.

> If a commercial distro does not want to allow use of kernel modules that
> are not included in that distro's kernels, that distro would enforce modu=
le
> signature verification rather than disabling loadable module support.
> Keeping loadable module support enabled is a balance that is important fo=
r
> getting wider developers/users.

We don't currently support LSMs as dynamically loadable kernel modules
and if the only reasons for doing so are either to A) support
out-of-tree LSMs or B) avoid having to recompile a kernel (to hack an
unsupported LSM into a distro kernel) I have to say (yet again) that I
am not interested.

> > We've talked a lot about this core problem and I maintain that it is
> > still a disto problem and not something I'm really concerned about
> > upstream.
>
> LSM modules that are not built into vmlinux currently cannot be appended
> after boot. Such asymmetry is strange and remains a big barrier.
>
> You are not concerned about this asymmetry, but I am very much concerned.
> Please give me feedback on not "I don't need it" but "how we can do it".

I thought my feedback has been clear up to this point, but perhaps I
need to be more direct.  At this point in time I am not interested in
supporting dynamically loaded LSM kernel modules if the only reasons
are to support out-of-tree LSMs or users who want to hack unsupported
LSMs into pre-built distro kernels; both of these use cases can be
solved today by compiling your own kernel.

As with the other threads involving this topic, I'm going to refrain
from any further comments until I see a new discussion point.

--
paul-moore.com

