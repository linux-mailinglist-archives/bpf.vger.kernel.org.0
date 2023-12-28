Return-Path: <bpf+bounces-18704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF1B81F471
	for <lists+bpf@lfdr.de>; Thu, 28 Dec 2023 04:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 653451C21A8D
	for <lists+bpf@lfdr.de>; Thu, 28 Dec 2023 03:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824071396;
	Thu, 28 Dec 2023 03:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsusIfCb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD0E1106
	for <bpf@vger.kernel.org>; Thu, 28 Dec 2023 03:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-427e83601c4so8203691cf.0
        for <bpf@vger.kernel.org>; Wed, 27 Dec 2023 19:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703735018; x=1704339818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qn+pYqpkX2sZEXMFr3AklE8boNC3eV1GunMt35F76fE=;
        b=NsusIfCbLlM3P7bUBtlZKXZ6iYqDAv/3oRCe0Bw3VSXNZ9l+aCR+KqV7/NxtHlwY6c
         KWDfyeak/daB9g9mm0NwbcYXoDu5PGvoMMHPfMrJhQcQ8kP2bQWIuGoSVYZb7JMK8w0n
         8uGPuGfBhFlv/qgGLU8lfklVIxqGcpgnGnMJ0aOh9zNLsxxfk+U6Xk2N5mfWYM0Zo3vt
         1b/1brTzLFyfitmfKE0M+vvTPMYdFBPtFfnuBR5/CiqsBD93ba6z91Mw7W/VWOeAe/Yc
         Wq6Ca76Q7QoZJjxiizwApQqrd1RxMcuJuD04owfZm1pm0RTA7Y7DuXNrSGhAw/ib/G3w
         XyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703735018; x=1704339818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qn+pYqpkX2sZEXMFr3AklE8boNC3eV1GunMt35F76fE=;
        b=oEDmgOq/r3zDb3wZwYbSc9k5k8zspwheHNGwsKaKuD5yHQprVuqUIByP5qearf8T2y
         aIvMwU/4TPNvGNuZGTYOu+VrXxqPJgz9xKVw87El0urPG+6vT2t8riQU9/afUwl80/PW
         sI/ChfvQEOS0J5CmmzgXFSiMrlnCmb8i4kB95ycPd2gv69Wn5M5ygJCMrCZZSnLzIREp
         d2vYmFnvY6zT6q5XkhLhW4Hby7IKgZhiVcs1rObWG22EZTLlXLMEZquk61vlMGV9pdP0
         eE7xvnXGBL17Gr5DqsvciWMD3D82QsYhYyWhEeKS4IzsJVQgGqt6bEQI9PaBu2THFgWW
         dT0w==
X-Gm-Message-State: AOJu0YzwQY7nafKc4qvlHQaSQD5hi5bVvLyJWeEPTIjW2dzcEh4L7mKd
	aO5I48IHRjHm+BfmXj91E4OFjyO/uifzaQz0tlA=
X-Google-Smtp-Source: AGHT+IE/xb66Etr72nvzuE8U1y86ndiGAcKjjF/BRIjpePAWTAskewq84IjzyzAV6UQJeZBhjgDTEwVG9jx5/lXpwoo=
X-Received: by 2002:ac8:5f8b:0:b0:427:ee9e:658 with SMTP id
 j11-20020ac85f8b000000b00427ee9e0658mr2199235qta.22.1703735018596; Wed, 27
 Dec 2023 19:43:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK3+h2z-aymvqqCnuh_LgdF_PnOBRd5PxF7LQxHcQ4uoEirsDQ@mail.gmail.com>
 <lc2bp2dzzn3jtwjunfgdifppmtjj27dargat276utybmjndzn7@tvzhqos2u5vd>
In-Reply-To: <lc2bp2dzzn3jtwjunfgdifppmtjj27dargat276utybmjndzn7@tvzhqos2u5vd>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Wed, 27 Dec 2023 19:43:27 -0800
Message-ID: <CAK3+h2xJ+8JD=+A_FY3+Rja6D=xn0p7kq7e5VLOsez1sagQm+A@mail.gmail.com>
Subject: Re: progs/test_tunnel_kern.c:802:43: error: use of undeclared
 identifier 'FOU_BPF_ENCAP_FOU'
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 7:10=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Hi Vincent,
>
> On Wed, Dec 27, 2023 at 06:59:12PM -0800, Vincent Li wrote:
> > Hi,
> >
> > When I make the bpf-next master branch bpf selftests, which failed
> > with error below, seems related to commit 02b4e126e6 bpf: selftests:
> > test_tunnel: Use vmlinux.h declarations ?
> >
> >   CLNG-BPF [test_maps] test_tunnel_kern.bpf.o
> >
> > progs/test_tunnel_kern.c:30:13: error: declaration of 'struct
> > bpf_fou_encap' will not be visible outside of this function
> > [-Werror,-Wvisibility]
> >
> >                           struct bpf_fou_encap *encap, int type) __ksym=
;
> >
> >                                  ^
> >
> > progs/test_tunnel_kern.c:32:13: error: declaration of 'struct
> > bpf_fou_encap' will not be visible outside of this function
> > [-Werror,-Wvisibility]
> >
> >                           struct bpf_fou_encap *encap) __ksym;
> >
> >                                  ^
> >
> > progs/test_tunnel_kern.c:741:23: error: variable has incomplete type
> > 'struct bpf_fou_encap'
>
> [...]
>
> Do you have CONFIG_NET_FOU enabled? I think you'll need that for
> test_tunnel to build correctly. BPF CI enables this.
> tools/testing/selftests/bpf/config has it set to =3Dy.
>

Thanks Daniel for your quick response. I have CONFIG_NET_FOU enabled
but as module (m), not builtin (y), I guess if enabled as module, the
vmlinux.h would not include the bpf_fou_encap type. I will try
tools/testing/selftests/bpf/config

> Thanks,
> Daniel

