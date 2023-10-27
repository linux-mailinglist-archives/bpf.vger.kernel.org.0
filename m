Return-Path: <bpf+bounces-13512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF977DA282
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 23:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB9C51C2118A
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 21:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FBB3FE39;
	Fri, 27 Oct 2023 21:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBmc6k3b"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C724D3C08B
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 21:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4612CC433CB
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 21:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698442429;
	bh=Qs8Xp8HwkZCtv6qvNG3NJwu7y/mkOOMp5bwS+TI/V+8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uBmc6k3bSDny4XVB/elBZ2LoyohSEViCFV7het8BMfeLuC4mxA//hDI/ZKWKi8vQR
	 wENvanIHZIZxAw+ybOb9UhTihwtREVqjHR7Y8WLYqACzF1ihYq3oXZHCljF0F1Jsd4
	 Q0hVa/YQDZUlMSwfRJBNg9xe3B6ZK7suw/sKsDdvQEtWddKYRMJ2Ksmw+ZMfmSt3hi
	 bFSpJ9Ur+jEKc8jlu3nb35vc1C2KGzdz+zx57geqPN+ywRoEmbmP0Ekx78eB5w8Pl0
	 4TrIPGs4bcMNNbJfw5fiP0d0t4M4I9ezXaynZ3mNpEh/RGdu/qhImYFycnZ0Wm5lPK
	 8xajos9UkNTRQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-507a3b8b113so3655438e87.0
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 14:33:49 -0700 (PDT)
X-Gm-Message-State: AOJu0YxI8CxN4CqwNGuFQMv0ytEIvHfT+l0aiMp8bzJm62glqAo1Kmyb
	BiBr4+Rsf1v6wRAVTGdwzikW7K8OUeJQ4pFRKDc=
X-Google-Smtp-Source: AGHT+IF1XEFg+W5qtGl73GMX3agsupKIdFvW/YiyHjbsqn5OIIncAZ8Uq9RQ1zbkWoff886rjzo5beCaKAHF8TPkH7I=
X-Received: by 2002:a19:f007:0:b0:504:7ff8:3430 with SMTP id
 p7-20020a19f007000000b005047ff83430mr2705338lfc.10.1698442427389; Fri, 27 Oct
 2023 14:33:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027212304.3354504-1-chantr4@gmail.com>
In-Reply-To: <20231027212304.3354504-1-chantr4@gmail.com>
From: Song Liu <song@kernel.org>
Date: Fri, 27 Oct 2023 14:33:34 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5em+cY6HiwAyS0j5GwUQMoSXWUHTt45omXR6JDOXpTRA@mail.gmail.com>
Message-ID: <CAPhsuW5em+cY6HiwAyS0j5GwUQMoSXWUHTt45omXR6JDOXpTRA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: consolidate VIRTIO/9P configs in
 the generic config file
To: Manu Bretelle <chantr4@gmail.com>
Cc: bpf@vger.kernel.org, quentin@isovalent.com, andrii@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org, martin.lau@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 2:23=E2=80=AFPM Manu Bretelle <chantr4@gmail.com> w=
rote:
>
> Those configs are needed to be able to run VM somewhat consistently.
> For instance, ATM, s390x is missing the `CONFIG_VIRTIO_CONSOLE` which
> prevents s390x kernels built in CI to leverage qemu-guest-agent.
>
> By moving them to `config`, we should have selftest kernels which are
> equal in term of functionalities.
>
> The set of config unabled were picked using
>
>     grep -h -E '(_9P|_VIRTIO)' config.x86_64 config | sort | uniq
>
> added to `config` and then
>     grep -vE '(_9P|_VIRTIO)' config.{x86_64,aarch64,s390x}
>
> as a side-effect, some config may have disappeared to the aarch64 and
> s390x kernels, but they should not be needed. CI will tell.
>
> Signed-off-by: Manu Bretelle <chantr4@gmail.com>
> ---
>  tools/testing/selftests/bpf/config         | 13 +++++++++++++
>  tools/testing/selftests/bpf/config.aarch64 | 16 ----------------
>  tools/testing/selftests/bpf/config.s390x   |  9 ---------
>  tools/testing/selftests/bpf/config.x86_64  | 12 ------------
>  4 files changed, 13 insertions(+), 37 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests=
/bpf/config
> index 3ec5927ec3e5..c22a068bc1de 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -86,3 +86,16 @@ CONFIG_VXLAN=3Dy
>  CONFIG_XDP_SOCKETS=3Dy
>  CONFIG_XFRM_INTERFACE=3Dy
>  CONFIG_VSOCKETS=3Dy
> +# VIRTIO/9P configs to run in VMs
> +CONFIG_9P_FS_POSIX_ACL=3Dy
> +CONFIG_9P_FS_SECURITY=3Dy
> +CONFIG_9P_FS=3Dy
> +CONFIG_CRYPTO_DEV_VIRTIO=3Dy
> +CONFIG_NET_9P_VIRTIO=3Dy
> +CONFIG_NET_9P=3Dy
> +CONFIG_VIRTIO_BALLOON=3Dy
> +CONFIG_VIRTIO_BLK=3Dy
> +CONFIG_VIRTIO_CONSOLE=3Dy
> +CONFIG_VIRTIO_NET=3Dy
> +CONFIG_VIRTIO_PCI=3Dy
> +CONFIG_VIRTIO_VSOCKETS_COMMON=3Dy

Please keep these in alphabetical order.

Thanks,
Song

