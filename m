Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB52B302248
	for <lists+bpf@lfdr.de>; Mon, 25 Jan 2021 08:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbhAYG5p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Jan 2021 01:57:45 -0500
Received: from mga14.intel.com ([192.55.52.115]:13749 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbhAYG5g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jan 2021 01:57:36 -0500
IronPort-SDR: iQU991RrO1GWlZUnsH5QFCyrT8VR++Ia0xcmnsvTSWWN6Xm4zpSK5NrsdsMFy37Q7bQl0IOp7c
 cQ5bObADr3Ag==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="178896450"
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; 
   d="scan'208";a="178896450"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2021 22:55:43 -0800
IronPort-SDR: MgNIXU4QAwNlAxiWTxOUvMpJeynmCqpGcyVTgDsobb3zBnjYDjktAUqBFvNnloNHzQwkZe+wL1
 9EWdluiYOoPQ==
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; 
   d="scan'208";a="361248096"
Received: from ymachlev-mobl1.ger.corp.intel.com (HELO outtakka) ([10.214.244.152])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2021 22:55:37 -0800
Date:   Mon, 25 Jan 2021 08:55:24 +0200
From:   Mikko Ylinen <mikko.ylinen@linux.intel.com>
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        KP Singh <kpsingh@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH] bpf: Drop disabled LSM hooks from the sleepable set
Message-ID: <YA5rXLwy4mcgcvLx@outtakka>
References: <20210122123003.46125-1-mikko.ylinen@linux.intel.com>
 <CACYkzJ6sMBvZ_ZG9++jwpQ+JQL3PL02okhD0O5Ftz4Hd7jEC3Q@mail.gmail.com>
 <CACYkzJ5i6DNxY3D3SqiO_LO2HBbA-EgPFdK8ZBcFNmTVWweucg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACYkzJ5i6DNxY3D3SqiO_LO2HBbA-EgPFdK8ZBcFNmTVWweucg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jan 23, 2021 at 12:50:21AM +0100, KP Singh wrote:
> On Fri, Jan 22, 2021 at 11:33 PM KP Singh <kpsingh@kernel.org> wrote:
> >
> > On Fri, Jan 22, 2021 at 1:32 PM Mikko Ylinen
> > <mikko.ylinen@linux.intel.com> wrote:
> > >
> > > Networking LSM hooks are conditionally enabled and when building the new
> > > sleepable BPF LSM hooks with the networking LSM hooks disabled, the
> > > following build error occurs:
> > >
> > > BTFIDS  vmlinux
> > > FAILED unresolved symbol bpf_lsm_socket_socketpair
> > >
> > > To fix the error, conditionally add the networking LSM hooks to the
> > > sleepable set.
> > >
> > > Fixes: 423f16108c9d8 ("bpf: Augment the set of sleepable LSM hooks")
> > > Signed-off-by: Mikko Ylinen <mikko.ylinen@linux.intel.com>
> >
> > Thanks!
> >
> > Acked-by: KP Singh <kpsingh@kernel.org>
> 
> Btw, I was noticing that there's another hook that is surrounded by ifdefs:
> 
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 70e5e0b6d69d..f7f7754e938d 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -166,7 +166,11 @@ BTF_ID(func, bpf_lsm_inode_symlink)
>  BTF_ID(func, bpf_lsm_inode_unlink)
>  BTF_ID(func, bpf_lsm_kernel_module_request)
>  BTF_ID(func, bpf_lsm_kernfs_init_security)
> +
> +#ifdef CONFIG_KEYS
>  BTF_ID(func, bpf_lsm_key_free)
> +#endif
> +
>  BTF_ID(func, bpf_lsm_mmap_file)
>  BTF_ID(func, bpf_lsm_netlink_send)
>  BTF_ID(func, bpf_lsm_path_notify)
> 
> It would be great if you can also add this to your patch :)

Thanks for noticing! I cross-checked the sleepable set but somehow
missed this. Just posted v2.

> I guess the cleanest solution to never let this happen would be to
> incorporate this in
> lsm_hook_defs.h and mark hooks as SLEEPABLE and NON_SLEEPABLE with an
> extra parameter to the LSM_HOOK macro and then only generate the BTF IDs
> based on this macro parameter.

Agree, a way to get the set automatically created makes sense. But the
extra parameter to LSM_HOOK macro would be BPF specific, right?

-- Regards, Mikko
