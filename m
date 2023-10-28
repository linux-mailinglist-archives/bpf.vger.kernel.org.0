Return-Path: <bpf+bounces-13528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E259E7DA47F
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 02:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D92B1C21194
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 00:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BFB635;
	Sat, 28 Oct 2023 00:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LV1CRQQn"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2F139B
	for <bpf@vger.kernel.org>; Sat, 28 Oct 2023 00:48:12 +0000 (UTC)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41FBB8
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 17:48:09 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-5842a7fdc61so1518407eaf.3
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 17:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698454089; x=1699058889; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jwii8FEJXLiSOiAYVAC/vI37pBdfiNR0NrWIScbTuM4=;
        b=LV1CRQQnZwSNUIr8I1YlT10s2ISWTeDeg/HibzwSZ5iceAMVHkDUDbBuXO4G+Vm2To
         dvLEhXbComF+PU+WUBrnC5C/P5IAuJ8ZMO7/L7FLfTvm+QuJh+ciyrrPT04NxhnWEvcO
         +Fjj0les5CMv6aOttc9PIKYsgb8hgUhU3gbBcSbZZMEk0Z5ZggMhYqS/me3L+rI4yKNo
         szPWPnnEmAsJkMojp1OHTZXQ6ICWHu2DHrgR43XHg7cE8gl1eXZlmgEh9WptQ+DdSWSs
         kSu9oWvCAMsfBlUM/XZizGF25XNmW015r8ABeC+Cx/JCTB1kEFHfB96PXp2EnWivuV/T
         j7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698454089; x=1699058889;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jwii8FEJXLiSOiAYVAC/vI37pBdfiNR0NrWIScbTuM4=;
        b=j6EDQQ+phQKdF+Hu6cNhSReTFMrfr/MTzxIt+uIe61dxgDHJstzRfyg+8V0UwhS5Rj
         Gi4GJ/nSU2lHYc+llMyL40bmal52kOzb2bgDCFx1udO+gsanAgGevGU56SHAgIaM5uLb
         WHcsk7bq+jLHXYZUTl+btq3GW9PnGZ1FjdmflMhysB3tBm0qxnEG7KThm8v1mdZAalJZ
         vtsf93tHUMhZbXViu719Im88Tfut5C9PJ264qzNqgwpaOtb9wrDU0BfUoFa0Mg7hKZgi
         tOK68XSfUKqLQ2YOUQowxvS50dFdCQSxe1mrAFXzRtczmm0F/o0s01l/p0nxPqaivUka
         W2QQ==
X-Gm-Message-State: AOJu0Yw4THGj6s8hNo4dxxeyq7oCH2y+5JD+cL5CrPNol26inm/MC5MD
	RE26resSv/X0tp5BwsfCxxDVECLst0xMbQ==
X-Google-Smtp-Source: AGHT+IETVgybHA8xIXcRf6IAizgiDnUzsN7AQHknzcXOGTFRf3lkfkkXivFG0CGMAxi5zaK7pIAumQ==
X-Received: by 2002:a05:6358:6f0c:b0:168:e9a2:6cb4 with SMTP id r12-20020a0563586f0c00b00168e9a26cb4mr4159725rwn.13.1698454088552;
        Fri, 27 Oct 2023 17:48:08 -0700 (PDT)
Received: from surya ([2600:1700:3ec2:2011:3ef3:bbdb:b46b:4676])
        by smtp.gmail.com with ESMTPSA id l21-20020a639855000000b005b46e691108sm1526967pgo.68.2023.10.27.17.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 17:48:08 -0700 (PDT)
Date: Fri, 27 Oct 2023 17:48:05 -0700
From: Manu Bretelle <chantr4@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, quentin@isovalent.com, andrii@kernel.org,
	daniel@iogearbox.net, ast@kernel.org, martin.lau@linux.dev,
	song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, jolsa@kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: consolidate VIRTIO/9P configs in
 the generic config file
Message-ID: <ZTxaRT8AXCNXYmRd@surya>
References: <20231027212304.3354504-1-chantr4@gmail.com>
 <CAEf4BzaR-g20XOHk0XVUA7tqRJ56wFfFaFmbWA=30d5w7fd2cA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaR-g20XOHk0XVUA7tqRJ56wFfFaFmbWA=30d5w7fd2cA@mail.gmail.com>

On Fri, Oct 27, 2023 at 02:38:36PM -0700, Andrii Nakryiko wrote:
> On Fri, Oct 27, 2023 at 2:23 PM Manu Bretelle <chantr4@gmail.com> wrote:
> >
> > Those configs are needed to be able to run VM somewhat consistently.
> > For instance, ATM, s390x is missing the `CONFIG_VIRTIO_CONSOLE` which
> > prevents s390x kernels built in CI to leverage qemu-guest-agent.
> >
> > By moving them to `config`, we should have selftest kernels which are
> > equal in term of functionalities.
> >
> > The set of config unabled were picked using
> >
> >     grep -h -E '(_9P|_VIRTIO)' config.x86_64 config | sort | uniq
> >
> > added to `config` and then
> >     grep -vE '(_9P|_VIRTIO)' config.{x86_64,aarch64,s390x}
> >
> > as a side-effect, some config may have disappeared to the aarch64 and
> > s390x kernels, but they should not be needed. CI will tell.
> >
> > Signed-off-by: Manu Bretelle <chantr4@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/config         | 13 +++++++++++++
> >  tools/testing/selftests/bpf/config.aarch64 | 16 ----------------
> >  tools/testing/selftests/bpf/config.s390x   |  9 ---------
> >  tools/testing/selftests/bpf/config.x86_64  | 12 ------------
> >  4 files changed, 13 insertions(+), 37 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> > index 3ec5927ec3e5..c22a068bc1de 100644
> > --- a/tools/testing/selftests/bpf/config
> > +++ b/tools/testing/selftests/bpf/config
> 
> This config is meant to specify configuration necessary to run
> selftests in general, not necessarily in BPF CI. So it's confusing and
> unnecessary to add 9P_FS here, as strictly speaking that's not a
> dependency.
> 

BPF CI is one, but there is also the *not so well maintained* vmtest.sh [0]
that relies on running in a VM.

> So perhaps instead we should just have a "config.ci" file with all the
> common configuration options necessary for BPF CI workflows to work?
> 
> 
That being said, I am fine moving it to a `config.ci` or `config.vm` and
updating vmtest.sh to include it if this is more desirable.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/tools/testing/selftests/bpf/vmtest.sh?h=for-next&id=6808918343a8b4b6970ba52ba2d1d511a0976748

> > @@ -86,3 +86,16 @@ CONFIG_VXLAN=y
> >  CONFIG_XDP_SOCKETS=y
> >  CONFIG_XFRM_INTERFACE=y
> >  CONFIG_VSOCKETS=y
> > +# VIRTIO/9P configs to run in VMs
> > +CONFIG_9P_FS_POSIX_ACL=y
> > +CONFIG_9P_FS_SECURITY=y
> > +CONFIG_9P_FS=y
> > +CONFIG_CRYPTO_DEV_VIRTIO=y
> > +CONFIG_NET_9P_VIRTIO=y
> > +CONFIG_NET_9P=y
> > +CONFIG_VIRTIO_BALLOON=y
> > +CONFIG_VIRTIO_BLK=y
> > +CONFIG_VIRTIO_CONSOLE=y
> > +CONFIG_VIRTIO_NET=y
> > +CONFIG_VIRTIO_PCI=y
> > +CONFIG_VIRTIO_VSOCKETS_COMMON=y
> > diff --git a/tools/testing/selftests/bpf/config.aarch64 b/tools/testing/selftests/bpf/config.aarch64
> > index 253821494884..fa8ecf626c73 100644
> > --- a/tools/testing/selftests/bpf/config.aarch64
> > +++ b/tools/testing/selftests/bpf/config.aarch64
> > @@ -1,4 +1,3 @@
> > -CONFIG_9P_FS=y
> >  CONFIG_ARCH_VEXPRESS=y
> >  CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
> >  CONFIG_ARM_SMMU_V3=y
> > @@ -46,7 +45,6 @@ CONFIG_DEBUG_SG=y
> >  CONFIG_DETECT_HUNG_TASK=y
> >  CONFIG_DEVTMPFS_MOUNT=y
> >  CONFIG_DEVTMPFS=y
> > -CONFIG_DRM_VIRTIO_GPU=y
> >  CONFIG_DRM=y
> >  CONFIG_DUMMY=y
> >  CONFIG_EXPERT=y
> > @@ -67,7 +65,6 @@ CONFIG_HAVE_KRETPROBES=y
> >  CONFIG_HEADERS_INSTALL=y
> >  CONFIG_HIGH_RES_TIMERS=y
> >  CONFIG_HUGETLBFS=y
> > -CONFIG_HW_RANDOM_VIRTIO=y
> >  CONFIG_HW_RANDOM=y
> >  CONFIG_HZ_100=y
> >  CONFIG_IDLE_PAGE_TRACKING=y
> > @@ -99,8 +96,6 @@ CONFIG_MEMCG=y
> >  CONFIG_MEMORY_HOTPLUG=y
> >  CONFIG_MEMORY_HOTREMOVE=y
> >  CONFIG_NAMESPACES=y
> > -CONFIG_NET_9P_VIRTIO=y
> > -CONFIG_NET_9P=y
> >  CONFIG_NET_ACT_BPF=y
> >  CONFIG_NET_ACT_GACT=y
> >  CONFIG_NETDEVICES=y
> > @@ -140,7 +135,6 @@ CONFIG_SCHED_TRACER=y
> >  CONFIG_SCSI_CONSTANTS=y
> >  CONFIG_SCSI_LOGGING=y
> >  CONFIG_SCSI_SCAN_ASYNC=y
> > -CONFIG_SCSI_VIRTIO=y
> >  CONFIG_SCSI=y
> >  CONFIG_SECURITY_NETWORK=y
> >  CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
> > @@ -167,16 +161,6 @@ CONFIG_UPROBES=y
> >  CONFIG_USELIB=y
> >  CONFIG_USER_NS=y
> >  CONFIG_VETH=y
> > -CONFIG_VIRTIO_BALLOON=y
> > -CONFIG_VIRTIO_BLK=y
> > -CONFIG_VIRTIO_CONSOLE=y
> > -CONFIG_VIRTIO_FS=y
> > -CONFIG_VIRTIO_INPUT=y
> > -CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
> > -CONFIG_VIRTIO_MMIO=y
> > -CONFIG_VIRTIO_NET=y
> > -CONFIG_VIRTIO_PCI=y
> > -CONFIG_VIRTIO_VSOCKETS_COMMON=y
> >  CONFIG_VLAN_8021Q=y
> >  CONFIG_VSOCKETS=y
> >  CONFIG_VSOCKETS_LOOPBACK=y
> > diff --git a/tools/testing/selftests/bpf/config.s390x b/tools/testing/selftests/bpf/config.s390x
> > index 2ba92167be35..e93330382849 100644
> > --- a/tools/testing/selftests/bpf/config.s390x
> > +++ b/tools/testing/selftests/bpf/config.s390x
> > @@ -1,4 +1,3 @@
> > -CONFIG_9P_FS=y
> >  CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
> >  CONFIG_AUDIT=y
> >  CONFIG_BLK_CGROUP=y
> > @@ -84,8 +83,6 @@ CONFIG_MEMORY_HOTPLUG=y
> >  CONFIG_MEMORY_HOTREMOVE=y
> >  CONFIG_NAMESPACES=y
> >  CONFIG_NET=y
> > -CONFIG_NET_9P=y
> > -CONFIG_NET_9P_VIRTIO=y
> >  CONFIG_NET_ACT_BPF=y
> >  CONFIG_NET_ACT_GACT=y
> >  CONFIG_NET_KEY=y
> > @@ -114,7 +111,6 @@ CONFIG_SAMPLE_SECCOMP=y
> >  CONFIG_SAMPLES=y
> >  CONFIG_SCHED_TRACER=y
> >  CONFIG_SCSI=y
> > -CONFIG_SCSI_VIRTIO=y
> >  CONFIG_SECURITY_NETWORK=y
> >  CONFIG_STACK_TRACER=y
> >  CONFIG_STATIC_KEYS_SELFTEST=y
> > @@ -136,11 +132,6 @@ CONFIG_UPROBES=y
> >  CONFIG_USELIB=y
> >  CONFIG_USER_NS=y
> >  CONFIG_VETH=y
> > -CONFIG_VIRTIO_BALLOON=y
> > -CONFIG_VIRTIO_BLK=y
> > -CONFIG_VIRTIO_NET=y
> > -CONFIG_VIRTIO_PCI=y
> > -CONFIG_VIRTIO_VSOCKETS_COMMON=y
> >  CONFIG_VLAN_8021Q=y
> >  CONFIG_VSOCKETS=y
> >  CONFIG_VSOCKETS_LOOPBACK=y
> > diff --git a/tools/testing/selftests/bpf/config.x86_64 b/tools/testing/selftests/bpf/config.x86_64
> > index 2e70a6048278..f7bfb2b09c82 100644
> > --- a/tools/testing/selftests/bpf/config.x86_64
> > +++ b/tools/testing/selftests/bpf/config.x86_64
> > @@ -1,6 +1,3 @@
> > -CONFIG_9P_FS=y
> > -CONFIG_9P_FS_POSIX_ACL=y
> > -CONFIG_9P_FS_SECURITY=y
> >  CONFIG_AGP=y
> >  CONFIG_AGP_AMD64=y
> >  CONFIG_AGP_INTEL=y
> > @@ -45,7 +42,6 @@ CONFIG_CPU_IDLE_GOV_LADDER=y
> >  CONFIG_CPUSETS=y
> >  CONFIG_CRC_T10DIF=y
> >  CONFIG_CRYPTO_BLAKE2B=y
> > -CONFIG_CRYPTO_DEV_VIRTIO=y
> >  CONFIG_CRYPTO_SEQIV=y
> >  CONFIG_CRYPTO_XXHASH=y
> >  CONFIG_DCB=y
> > @@ -145,8 +141,6 @@ CONFIG_MEMORY_FAILURE=y
> >  CONFIG_MINIX_SUBPARTITION=y
> >  CONFIG_NAMESPACES=y
> >  CONFIG_NET=y
> > -CONFIG_NET_9P=y
> > -CONFIG_NET_9P_VIRTIO=y
> >  CONFIG_NET_ACT_BPF=y
> >  CONFIG_NET_CLS_CGROUP=y
> >  CONFIG_NET_EMATCH=y
> > @@ -228,12 +222,6 @@ CONFIG_USER_NS=y
> >  CONFIG_VALIDATE_FS_PARSER=y
> >  CONFIG_VETH=y
> >  CONFIG_VIRT_DRIVERS=y
> > -CONFIG_VIRTIO_BALLOON=y
> > -CONFIG_VIRTIO_BLK=y
> > -CONFIG_VIRTIO_CONSOLE=y
> > -CONFIG_VIRTIO_NET=y
> > -CONFIG_VIRTIO_PCI=y
> > -CONFIG_VIRTIO_VSOCKETS_COMMON=y
> >  CONFIG_VLAN_8021Q=y
> >  CONFIG_VSOCKETS=y
> >  CONFIG_VSOCKETS_LOOPBACK=y
> > --
> > 2.39.3
> >

