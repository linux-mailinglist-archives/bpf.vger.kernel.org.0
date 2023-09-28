Return-Path: <bpf+bounces-11079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CFF7B2727
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 23:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 506C128378A
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 21:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120F916409;
	Thu, 28 Sep 2023 21:09:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2A08839
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 21:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81907C433C8
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 21:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695935396;
	bh=J48G7q2dfvunzXe1tvK4+YBYxHYkh0UDxUPeKF0gmAo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LCXy2p3uzlkF6XDTqe+TL+bXQcRx5BomuAXELh8mxdyp9qwUP58rInZbpIcbM3glf
	 VEWJQwBj3LdkjJ5B5HydAafgtEWOR0rYcmjqD0LYhce9UUC6x7+IiQl7bVmIriJmhL
	 tabHvP9fLm8wvyBlaa5oifw0dMmoLmIXV+REkfmd0BgGqbKCcYz7wkydhl5V+2BAOS
	 jrEAoR6zbztePCv9KXutr0MRvL+35Ye9NvcZEIwpRsyFK2y8n32+SEdNsn2OKQNSBL
	 HGYjxAWrtZqi7uQqOe/GQx+A+3vMC6KWRFNFALt+Phhna+o+2UTHTzVD5z6/DQZZPQ
	 Qlk9dtzdXLggA==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5044dd5b561so16086949e87.1
        for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 14:09:56 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywvg8wSqFzbMZJxUaF6CbGLkaRV5SK7NJll+kaQ3JYB9llPiIEO
	O0xIOpXUFS4IgeuePVxTS6Pm4dSE9Zo60Rnosc4=
X-Google-Smtp-Source: AGHT+IGO3l8pkUj/r3UKEYdGea9o8YaYCh7E69o9Ca0lJkrFgm2S+nq4EQxS1uOTl1SzpmTFb84P8wjEE3KdKZnVzzU=
X-Received: by 2002:a05:6512:1189:b0:502:a46e:257a with SMTP id
 g9-20020a056512118900b00502a46e257amr1977126lfr.56.1695935394750; Thu, 28 Sep
 2023 14:09:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230928194818.261163-1-hbathini@linux.ibm.com> <20230928194818.261163-5-hbathini@linux.ibm.com>
In-Reply-To: <20230928194818.261163-5-hbathini@linux.ibm.com>
From: Song Liu <song@kernel.org>
Date: Thu, 28 Sep 2023 14:09:42 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7TRmqGQ+-sFbUpWV7_8OftKFLpsKjnUzRWvQMyZoTwgQ@mail.gmail.com>
Message-ID: <CAPhsuW7TRmqGQ+-sFbUpWV7_8OftKFLpsKjnUzRWvQMyZoTwgQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] powerpc/bpf: rename powerpc64_jit_data to powerpc_jit_data
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <songliubraving@fb.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 12:48=E2=80=AFPM Hari Bathini <hbathini@linux.ibm.c=
om> wrote:
>
> powerpc64_jit_data is a misnomer as it is meant for both ppc32 and
> ppc64. Rename it to powerpc_jit_data.
>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>

Acked-by: Song Liu <song@kernel.org>

