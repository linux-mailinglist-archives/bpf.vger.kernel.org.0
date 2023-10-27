Return-Path: <bpf+bounces-13513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4573E7DA291
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 23:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAF88B2157A
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 21:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356603FE43;
	Fri, 27 Oct 2023 21:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlSsIeiw"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E13B3C08B
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 21:38:51 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2951B9
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 14:38:49 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9be3b66f254so376452066b.3
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 14:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698442728; x=1699047528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOnIed4SzxaM040ILk/3uNjBKBndP+pwQM+LMhri08M=;
        b=DlSsIeiwPIJJbL0lRHlXHvClr5/ChRxA1GSVv6YguqKqdnwALtk4SCFesjZAW0B7B/
         SoSYgqVSUWufix9ezB6wZol75UlaE+if26jqiK/Bcn2KoIWKux4Qsq3p1u4LqKK/Zz3A
         JtpGD9v3UwoVHNcMEc6H1WQLDIY+R/+Tvowq0gNagc2rFrfP8lNAzhtvzvgC5pJkmWlq
         4CJn/FBj42SCy8SwERLSjbLSznz3sMWshcISZkrNhVtzsfTeGbq74dfyNSEXq8+OgV8Q
         D+4ldWZKfcJkvCd+gEyOLY8mwZSoNAZCT6cRoxsGthGCBdpNa9qc7LF7FqVSrhp/vWq/
         fV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698442728; x=1699047528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOnIed4SzxaM040ILk/3uNjBKBndP+pwQM+LMhri08M=;
        b=tDpoyeSjVLkP7RDWr8+BSwTZ/X3kNXTLsrX1WO0KQeJSSM8ICY7pSKZKaJ19pfRGaC
         2vAVusEr3sXoMD2V5bVzp/7U7mZNMnkUP8OhdNDzr6hxNA+hqdIY/aEbXeM+4ASIbM16
         gZtv9Wt35uO6DL4e02WSag8VIYVTOxt/6L6Zm7gmMuIUSxokZp6bwANFjHyJwGUukOsM
         KY5j5bx6OcMJA7Z2lfsVdbM/1+ZZFQgEhSIY8m/0LrYku8BvltOsKdPHED9ZfD9NxJLX
         LyitG6cyeIWyl34o98KmhFAtPrA8Fbper7MN3LDuY1DtBa693Ja9bHx77FBYANI+SlsX
         l9mw==
X-Gm-Message-State: AOJu0YyCpEoEoStKIHR1amhAwxeNzLAeFovE8zbMeith66qzVDx7tqtA
	RzN+WoMI06l6Ds2XO2DIYQOIgMaC7Zd3wB3KB4w=
X-Google-Smtp-Source: AGHT+IFtOfD93HspTHLX3sjFGZMYlfvRtOXoSbEt+3tt7KOJvxje/Uq7wpV1jOVLy2Q4jfOwoJ4rQ3gShGC87nkzwtM=
X-Received: by 2002:a17:907:7f19:b0:9be:cdca:dae9 with SMTP id
 qf25-20020a1709077f1900b009becdcadae9mr3086286ejc.36.1698442727493; Fri, 27
 Oct 2023 14:38:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027212304.3354504-1-chantr4@gmail.com>
In-Reply-To: <20231027212304.3354504-1-chantr4@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 27 Oct 2023 14:38:36 -0700
Message-ID: <CAEf4BzaR-g20XOHk0XVUA7tqRJ56wFfFaFmbWA=30d5w7fd2cA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: consolidate VIRTIO/9P configs in
 the generic config file
To: Manu Bretelle <chantr4@gmail.com>
Cc: bpf@vger.kernel.org, quentin@isovalent.com, andrii@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org, martin.lau@linux.dev, song@kernel.org, 
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

This config is meant to specify configuration necessary to run
selftests in general, not necessarily in BPF CI. So it's confusing and
unnecessary to add 9P_FS here, as strictly speaking that's not a
dependency.

So perhaps instead we should just have a "config.ci" file with all the
common configuration options necessary for BPF CI workflows to work?


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
> diff --git a/tools/testing/selftests/bpf/config.aarch64 b/tools/testing/s=
elftests/bpf/config.aarch64
> index 253821494884..fa8ecf626c73 100644
> --- a/tools/testing/selftests/bpf/config.aarch64
> +++ b/tools/testing/selftests/bpf/config.aarch64
> @@ -1,4 +1,3 @@
> -CONFIG_9P_FS=3Dy
>  CONFIG_ARCH_VEXPRESS=3Dy
>  CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=3Dy
>  CONFIG_ARM_SMMU_V3=3Dy
> @@ -46,7 +45,6 @@ CONFIG_DEBUG_SG=3Dy
>  CONFIG_DETECT_HUNG_TASK=3Dy
>  CONFIG_DEVTMPFS_MOUNT=3Dy
>  CONFIG_DEVTMPFS=3Dy
> -CONFIG_DRM_VIRTIO_GPU=3Dy
>  CONFIG_DRM=3Dy
>  CONFIG_DUMMY=3Dy
>  CONFIG_EXPERT=3Dy
> @@ -67,7 +65,6 @@ CONFIG_HAVE_KRETPROBES=3Dy
>  CONFIG_HEADERS_INSTALL=3Dy
>  CONFIG_HIGH_RES_TIMERS=3Dy
>  CONFIG_HUGETLBFS=3Dy
> -CONFIG_HW_RANDOM_VIRTIO=3Dy
>  CONFIG_HW_RANDOM=3Dy
>  CONFIG_HZ_100=3Dy
>  CONFIG_IDLE_PAGE_TRACKING=3Dy
> @@ -99,8 +96,6 @@ CONFIG_MEMCG=3Dy
>  CONFIG_MEMORY_HOTPLUG=3Dy
>  CONFIG_MEMORY_HOTREMOVE=3Dy
>  CONFIG_NAMESPACES=3Dy
> -CONFIG_NET_9P_VIRTIO=3Dy
> -CONFIG_NET_9P=3Dy
>  CONFIG_NET_ACT_BPF=3Dy
>  CONFIG_NET_ACT_GACT=3Dy
>  CONFIG_NETDEVICES=3Dy
> @@ -140,7 +135,6 @@ CONFIG_SCHED_TRACER=3Dy
>  CONFIG_SCSI_CONSTANTS=3Dy
>  CONFIG_SCSI_LOGGING=3Dy
>  CONFIG_SCSI_SCAN_ASYNC=3Dy
> -CONFIG_SCSI_VIRTIO=3Dy
>  CONFIG_SCSI=3Dy
>  CONFIG_SECURITY_NETWORK=3Dy
>  CONFIG_SERIAL_AMBA_PL011_CONSOLE=3Dy
> @@ -167,16 +161,6 @@ CONFIG_UPROBES=3Dy
>  CONFIG_USELIB=3Dy
>  CONFIG_USER_NS=3Dy
>  CONFIG_VETH=3Dy
> -CONFIG_VIRTIO_BALLOON=3Dy
> -CONFIG_VIRTIO_BLK=3Dy
> -CONFIG_VIRTIO_CONSOLE=3Dy
> -CONFIG_VIRTIO_FS=3Dy
> -CONFIG_VIRTIO_INPUT=3Dy
> -CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=3Dy
> -CONFIG_VIRTIO_MMIO=3Dy
> -CONFIG_VIRTIO_NET=3Dy
> -CONFIG_VIRTIO_PCI=3Dy
> -CONFIG_VIRTIO_VSOCKETS_COMMON=3Dy
>  CONFIG_VLAN_8021Q=3Dy
>  CONFIG_VSOCKETS=3Dy
>  CONFIG_VSOCKETS_LOOPBACK=3Dy
> diff --git a/tools/testing/selftests/bpf/config.s390x b/tools/testing/sel=
ftests/bpf/config.s390x
> index 2ba92167be35..e93330382849 100644
> --- a/tools/testing/selftests/bpf/config.s390x
> +++ b/tools/testing/selftests/bpf/config.s390x
> @@ -1,4 +1,3 @@
> -CONFIG_9P_FS=3Dy
>  CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=3Dy
>  CONFIG_AUDIT=3Dy
>  CONFIG_BLK_CGROUP=3Dy
> @@ -84,8 +83,6 @@ CONFIG_MEMORY_HOTPLUG=3Dy
>  CONFIG_MEMORY_HOTREMOVE=3Dy
>  CONFIG_NAMESPACES=3Dy
>  CONFIG_NET=3Dy
> -CONFIG_NET_9P=3Dy
> -CONFIG_NET_9P_VIRTIO=3Dy
>  CONFIG_NET_ACT_BPF=3Dy
>  CONFIG_NET_ACT_GACT=3Dy
>  CONFIG_NET_KEY=3Dy
> @@ -114,7 +111,6 @@ CONFIG_SAMPLE_SECCOMP=3Dy
>  CONFIG_SAMPLES=3Dy
>  CONFIG_SCHED_TRACER=3Dy
>  CONFIG_SCSI=3Dy
> -CONFIG_SCSI_VIRTIO=3Dy
>  CONFIG_SECURITY_NETWORK=3Dy
>  CONFIG_STACK_TRACER=3Dy
>  CONFIG_STATIC_KEYS_SELFTEST=3Dy
> @@ -136,11 +132,6 @@ CONFIG_UPROBES=3Dy
>  CONFIG_USELIB=3Dy
>  CONFIG_USER_NS=3Dy
>  CONFIG_VETH=3Dy
> -CONFIG_VIRTIO_BALLOON=3Dy
> -CONFIG_VIRTIO_BLK=3Dy
> -CONFIG_VIRTIO_NET=3Dy
> -CONFIG_VIRTIO_PCI=3Dy
> -CONFIG_VIRTIO_VSOCKETS_COMMON=3Dy
>  CONFIG_VLAN_8021Q=3Dy
>  CONFIG_VSOCKETS=3Dy
>  CONFIG_VSOCKETS_LOOPBACK=3Dy
> diff --git a/tools/testing/selftests/bpf/config.x86_64 b/tools/testing/se=
lftests/bpf/config.x86_64
> index 2e70a6048278..f7bfb2b09c82 100644
> --- a/tools/testing/selftests/bpf/config.x86_64
> +++ b/tools/testing/selftests/bpf/config.x86_64
> @@ -1,6 +1,3 @@
> -CONFIG_9P_FS=3Dy
> -CONFIG_9P_FS_POSIX_ACL=3Dy
> -CONFIG_9P_FS_SECURITY=3Dy
>  CONFIG_AGP=3Dy
>  CONFIG_AGP_AMD64=3Dy
>  CONFIG_AGP_INTEL=3Dy
> @@ -45,7 +42,6 @@ CONFIG_CPU_IDLE_GOV_LADDER=3Dy
>  CONFIG_CPUSETS=3Dy
>  CONFIG_CRC_T10DIF=3Dy
>  CONFIG_CRYPTO_BLAKE2B=3Dy
> -CONFIG_CRYPTO_DEV_VIRTIO=3Dy
>  CONFIG_CRYPTO_SEQIV=3Dy
>  CONFIG_CRYPTO_XXHASH=3Dy
>  CONFIG_DCB=3Dy
> @@ -145,8 +141,6 @@ CONFIG_MEMORY_FAILURE=3Dy
>  CONFIG_MINIX_SUBPARTITION=3Dy
>  CONFIG_NAMESPACES=3Dy
>  CONFIG_NET=3Dy
> -CONFIG_NET_9P=3Dy
> -CONFIG_NET_9P_VIRTIO=3Dy
>  CONFIG_NET_ACT_BPF=3Dy
>  CONFIG_NET_CLS_CGROUP=3Dy
>  CONFIG_NET_EMATCH=3Dy
> @@ -228,12 +222,6 @@ CONFIG_USER_NS=3Dy
>  CONFIG_VALIDATE_FS_PARSER=3Dy
>  CONFIG_VETH=3Dy
>  CONFIG_VIRT_DRIVERS=3Dy
> -CONFIG_VIRTIO_BALLOON=3Dy
> -CONFIG_VIRTIO_BLK=3Dy
> -CONFIG_VIRTIO_CONSOLE=3Dy
> -CONFIG_VIRTIO_NET=3Dy
> -CONFIG_VIRTIO_PCI=3Dy
> -CONFIG_VIRTIO_VSOCKETS_COMMON=3Dy
>  CONFIG_VLAN_8021Q=3Dy
>  CONFIG_VSOCKETS=3Dy
>  CONFIG_VSOCKETS_LOOPBACK=3Dy
> --
> 2.39.3
>

