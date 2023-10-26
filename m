Return-Path: <bpf+bounces-13358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 648B07D8A6F
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 23:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0582BB212E9
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 21:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD953D987;
	Thu, 26 Oct 2023 21:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUsVyjH4"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254BE11C9E
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 21:35:26 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C511EC1
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 14:35:24 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32003aae100so1558828f8f.0
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 14:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698356123; x=1698960923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0mR35KT6Hsd8MM0x5OwTbVxWUczvUFC3BLMf9bmIjo=;
        b=QUsVyjH4UeBgQCE0/y8cZ8B0G2ojWb36ufpdIjaZVIoXM93y5sF7HpiybRJD7PwI07
         Uy7HvrhhHuqqtcWJGnWDahoNzSKJzzBFpsN/SSj8tWKYqy0Apu2FHTZlx+wpLUWMOAxR
         pfHw/20LHhqHN49p+LFiOtPAWm5Yftd0oszZ3bQ+3a0CV56TcvbgdRdeyScrxDUyT7LM
         j5uYaCxT29uItyiXNCBW0c6/yL5uOY9NBCyTU8WjLMAdlpA7FFwN7yjwl8vU22bFsd6x
         uNIcArlu8inZ4aAlBp8BCgJrZ66vA6ssY95jwWGCCl7NfjZVb7iAtDjOYY1V3czID8YV
         9FxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698356123; x=1698960923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0mR35KT6Hsd8MM0x5OwTbVxWUczvUFC3BLMf9bmIjo=;
        b=ghCgOQaSlAwhmwNE1eP+SV7vhH6Qcnl428C12aSs7NgiDdaV6iycoGS3V7THkowg5T
         ZlesKoP6X39e0msAbhb0SHMUd1j6ksI+GdmVKJmz5RnhgfSay+ACHMrK5eCvxumISQDV
         o1jP0La+7z8aQ+DsxxG9vZfZL+M2JAraNGpFJYifpWHoPQVdOkOBIAL3pLxxuO3Xt3AT
         KsGKnUC8ktGIPvsdbnlHYH1iDDvh0poAJCb4227pA8V2VhwLHNgb6vxhwUYsrmxSMLC2
         luOuvJCH+ANpEYNOFQMsd0n389x2eB70gnqlLNhY3tVACQAniAfJ0+3hrFgqhJV2/3fb
         vjKw==
X-Gm-Message-State: AOJu0Yw3GQx00aCQtzvwbxvEmGUjh7ASnGrlnPUI0M4sHdzVfQYVp5xk
	TRCWxIBTtFHbjYIe7v83SIyJi3UCDMVzCchmaRo=
X-Google-Smtp-Source: AGHT+IGg2N4KenBFXip8fYtut8GKcmk4o/0gdbmWnuZGA6+8Z943B1W9Nynz5cbFVTM7AgTtv7ld6D5KOMscje1DqCE=
X-Received: by 2002:a5d:6c66:0:b0:32d:888d:7598 with SMTP id
 r6-20020a5d6c66000000b0032d888d7598mr1220120wrz.4.1698356122951; Thu, 26 Oct
 2023 14:35:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024201852.1512720-1-chantr4@gmail.com> <041a3ea2-8cc6-4f0f-8ed9-6ca459e5bbb7@gmail.com>
 <ZTiqp7URqNjqrSEk@surya>
In-Reply-To: <ZTiqp7URqNjqrSEk@surya>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 26 Oct 2023 14:35:11 -0700
Message-ID: <CAADnVQ++5v46OYD-zR28dM=PaZ1RYLoijLicg+8DgnAZAZ_qtw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: umount children of TDIR in test_bpffs
To: Manu Bretelle <chantr4@gmail.com>
Cc: Kui-Feng Lee <sinquersw@gmail.com>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 10:42=E2=80=AFPM Manu Bretelle <chantr4@gmail.com> =
wrote:
>
> On Tue, Oct 24, 2023 at 02:29:19PM -0700, Kui-Feng Lee wrote:
> >
> >
> > On 10/24/23 13:18, Manu Bretelle wrote:
> > > Currently this tests tries to umount /sys/kernel/debug (TDIR) but the
> > > system it is running on may have mounts below.
> > >
> > > For example, danobi/vmtest [0] VMs have
> > >      mount -t tracefs tracefs /sys/kernel/debug/tracing
> > > as part of their init.
> > >
> > > This change list mounts and will umount any mounts below TDIR before
> > > umounting TDIR itself.
> > >
> > > Note that it is not umounting recursively, so in the case of a sub-mo=
unt
> > > of TDIR  having another sub-mount, this will fail as mtab is ordered.
> >
> > Should we move TID to a random path likes "/sys/kernel/debug-<pid>/"?
> >
>
> Fair point, I suppose we would want to keep TDIR a defined string as it d=
oes
> simplify the gymnastic involved through the rest of the script, but yeah
> looking at the original commit:
> edb65ee5aa25 (selftests/bpf: Add bpffs preload test)
>
> I don't see any reason to use an alternate directory and rather mkdir it =
vs
> umounting the original one.
> so something like
>
>     #define TDIR "/sys/kernel/test_bpffs"
>
> Would probably do.
>
> Alexei could confirm his original intent probably.

I don't remember why I picked /sys/kernel/debug back then.
I suspect TDIR /tmp/foo and mkdir would work the same way.

