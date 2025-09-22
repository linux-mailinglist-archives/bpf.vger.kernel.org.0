Return-Path: <bpf+bounces-69255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F0DB92782
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 19:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E28D91904FD5
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 17:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BA23126BF;
	Mon, 22 Sep 2025 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joKgfAjB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7AA8634F
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 17:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758563214; cv=none; b=TkHBsonm9OGO7zZeM6NbPMPgMU3x/fm98y758SJeKnNxpNIKLqUV2JR74rpDSEYFF2wG0vMcSy1RH4E8BmmeFqAhAJA4P2o1F3AT5jcZBhA0fUjV5LWvip+jv6yK4UHSvXSEJIX64N7r9boEOxabr0OhVLaeBOwFVKvFFzkRLIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758563214; c=relaxed/simple;
	bh=1Uu0YzEwaTr/Q540ag2EGNQrFBJuVIiwb71rS/qZMX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYV6F6MUVAr36xegL+/3ZXNE4rx3lblngzWo+L0EeFnIwHlJllN1F9T5fMakyQsnP61UBivCVd0nGDD4ECCIDjzocrh7O4qhKzznY3SQDaO8tAsTmEDEuXBWgeTjB3my2a/pf9eHToRCnx2JlQ1quelYN9V5Ny39pBxs/H3d2bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joKgfAjB; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-72e565bf2f0so36678597b3.3
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 10:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758563212; x=1759168012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHCpNXjzK4vjqWyITZQZXGAhxF9CSpOnc360flcFvFE=;
        b=joKgfAjBpPECvK80NAd/2KhvNp6UGJCU+aX1/vkoQiJHbGaLtMDSdJnR5oDUvFxAtY
         TAkd7qrO3JEvWlUYaFgbNcK5yYWFmRHAPOyYekOSi6eS3Jva813FYD0lyytw1ShUhYA4
         v3OYUR5RVHvPFW+xMCAJriNxhUVeaupgy2Zq/sxHNeS7RFkE6doMf3mWwd9K4Bwe75GY
         vH2mlKUwZyYiRrBQZO3sD2rLy0omlI/30eWdF4Frw7OiY9IqWdw+h3HnJv9RDdFCdh78
         c5EL1jQ2ocHhq4w8/ibfsTafCkxkQweSOLMQ2jBzvXVlEXVxFVfiQxIfKDVAEDkWQfCp
         XGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758563212; x=1759168012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHCpNXjzK4vjqWyITZQZXGAhxF9CSpOnc360flcFvFE=;
        b=lQW+7sgz+EqD9J8ZsQbqTNrpMH0fFQ/Yi3wcKP00XjORIBA46VdDMzAIrCfZzS3kSt
         wtJg6Q90ugR80zyKO6A4MvVS7uGZkvEfzzawbF6cdafD+RyTRzH/G9fNtthAO9dQhnsI
         73fo1XxyZ8rZLi7nKICaSUhZf2zYb/7bkYU48N8e/Vtnd5o9rPChyLgafJc01VeGSgXW
         P29hblIkR9bNudNuViF1apoeR5Xl5ki5CIBAVoaCd9053TCC85XA4Dfglkqs/0Tjvoru
         e9JvaZZVbA5GVhXbTl7Kh1h/QlKOgt4sjILN3cHoxOLqlnbfrt0jaKQPo6dFHWhkh47a
         4Wng==
X-Gm-Message-State: AOJu0YzNwwRko9g6d3QhMYi7WacbVBXb3Y859qR6CbI/nBy1dOCQpQep
	8RmmnHdjrTD7oDJ15Ug6pV7uaUB54s6X8VAyR62txaThTBkfgEh485n1kBCEPm5zFYRbKl5TVCZ
	Z1GTQFo54ExsyF3eZLMKItONfxfpzUTE=
X-Gm-Gg: ASbGncstepplba42c40+iy8cYXNhs7XHDYVMn9wYpc4rkgHW8ACL4uRnf0WBBRtOfJw
	e5JglKkI30rNxjdSL4Xf2Y1rndy2gs+1MPQQAOnzlZmtkhqhE6umdVVOD8gyZ9LyFDUrP+p3+Ll
	6Jeqc0wFU3ZI/EBvQY3JtvLnR7Iy3WPA0jatsZ3urXOkfgu1+kYZCKeVJvqGtnhbys4kUQz8eW6
	1SSt785R4ZSwiF2b6Eb1kE=
X-Google-Smtp-Source: AGHT+IFMhlXiLGOZ7dFStpyLWJUA1kJ8zHpWmMnZhUx/GAT0w2n349xwsIY6W7PusLnkJppK4nu/PhOSKjh8Ctk3W/Y=
X-Received: by 2002:a05:690c:48c9:b0:730:67c0:eff8 with SMTP id
 00721157ae682-73d0b595ac5mr123807887b3.0.1758563211624; Mon, 22 Sep 2025
 10:46:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919230952.3628709-1-ameryhung@gmail.com> <aNFlpcGxd9yI6qLJ@boxer>
In-Reply-To: <aNFlpcGxd9yI6qLJ@boxer>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 22 Sep 2025 10:46:39 -0700
X-Gm-Features: AS18NWDnfkg0_XUQt9K1B34B1VfkZy9WZbSKnIrwHvDBa0v7gEPnBaIBRxDdxB4
Message-ID: <CAMB2axPh4Ax=+1vzzm_AiWN8KKMwydLh=aUhqpd2x8rLT18yzw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 0/7] Add kfunc bpf_xdp_pull_data
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, paul.chaignon@gmail.com, 
	kuba@kernel.org, stfomichev@gmail.com, martin.lau@kernel.org, 
	mohsin.bashr@gmail.com, noren@nvidia.com, dtatulea@nvidia.com, 
	saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 8:06=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Fri, Sep 19, 2025 at 04:09:45PM -0700, Amery Hung wrote:
> > v6 -> v5
> >   patch 6
> >   - v5 selftest failed on S390 when changing how tailroom occupied by
> >     skb_shared_info is calculated. Revert selftest to v4, where we get
> >     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) by running an XDP
> >     program
>
> Hi Amery, could you shed more light on this? Would be nice to stick with
> BTF approach as it looked clean to me. Was this due to SMP_CACHE_BYTES
> being different between archs?

Right.

I think it would be simpler to just find the tailroom occupied by
skb_shared_info by running an XDP program instead of trying to
duplicate how the kernel derives that size in the user space.

WDYT?

>
> >
> > v5 -> v4
> >   patch 1
> >   - Add a new patch clearing pfmemalloc bit in xdp->frags when all frag=
s
> >     are freed in bpf_xdp_adjust_tail() (Maciej)
> >
> >   patch 2
> >   - Refactor bpf_xdp_shrink_data() (Maciej)
> >
> >   patch 3
> >   - Clear pfmemalloc when all frags are freed in bpf_xdp_pull_data()
> >     (Maciej)
> >
> >   patch 6
> >   - Use BTF to get sizes of skb_shared_info and xdp_frame (Maciej)
> >
> >   Link: https://lore.kernel.org/bpf/20250919182100.1925352-1-ameryhung@=
gmail.com/
> >
> > v3 -> v4
> >   patch 2
> >   - Improve comments (Jakub)
> >   - Drop new_end and len_free to simplify code (Jakub)
> >
> >   patch 4
> >   - Instead of adding is_xdp to bpf_test_init, move lower-bound check
> >     of user_size to callers (Martin)
> >   - Simplify linear data size calculation (Martin)
> >
> >   patch 5
> >   - Add static function identifier (Martin)
> >   - Free calloc-ed buf (Martin)
> >
> >   Link: https://lore.kernel.org/bpf/20250917225513.3388199-1-ameryhung@=
gmail.com/
> >
> > v2 -> v3
> >   Separate mlx5 fixes from the patchset
> >
> >   patch 2
> >   - Use headroom for pulling data by shifting metadata and data down
> >     (Jakub)
> >   - Drop the flags argument (Martin)
> >
> >   patch 4
> >   - Support empty linear xdp data for BPF_PROG_TEST_RUN
> >
> >   Link: https://lore.kernel.org/bpf/20250915224801.2961360-1-ameryhung@=
gmail.com/
> >
> > v1 -> v2
> >   Rebase onto bpf-next
> >
> >   Try to build on top of the mlx5 patchset that avoids copying payload
> >   to linear part by Christoph but got a kernel panic. Will rebase on
> >   that patchset if it got merged first, or separate the mlx5 fix
> >   from this set.
> >
> >   patch 1
> >   - Remove the unnecessary head frag search (Dragos)
> >   - Rewind the end frag pointer to simplify the change (Dragos)
> >   - Rewind the end frag pointer and recalculate truesize only when the
> >     number of frags changed (Dragos)
> >
> >   patch 3
> >   - Fix len =3D=3D zero behavior. To mirror bpf_skb_pull_data() correct=
ly,
> >     the kfunc should do nothing (Stanislav)
> >   - Fix a pointer wrap around bug (Jakub)
> >   - Use memmove() when moving sinfo->frags (Jakub)
> >
> >   Link: https://lore.kernel.org/bpf/20250905173352.3759457-1-ameryhung@=
gmail.com/
> >
> > ---
> >
> > Hi all,
> >
> > This patchset introduces a new kfunc bpf_xdp_pull_data() to allow
> > pulling nonlinear xdp data. This may be useful when a driver places
> > headers in fragments. When an xdp program would like to keep parsing
> > packet headers using direct packet access, it can call
> > bpf_xdp_pull_data() to make the header available in the linear data
> > area. The kfunc can also be used to decapsulate the header in the
> > nonlinear data, as currently there is no easy way to do this.
> >
> > Tested with the added bpf selftest using bpf test_run and also on
> > mlx5 with the tools/testing/selftests/drivers/net/{xdp.py, ping.py}.
> > mlx5 with striding RQ enabled always passse xdp_buff with empty linear
> > data to xdp programs. xdp.test_xdp_native_pass_mb would fail to parse
> > the header before this patchset.
> >
> > Thanks!
> > Amery
> >
> > Amery Hung (7):
> >   bpf: Clear pfmemalloc flag when freeing all fragments
> >   bpf: Allow bpf_xdp_shrink_data to shrink a frag from head and tail
> >   bpf: Support pulling non-linear xdp data
> >   bpf: Clear packet pointers after changing packet data in kfuncs
> >   bpf: Support specifying linear xdp packet data size for
> >     BPF_PROG_TEST_RUN
> >   selftests/bpf: Test bpf_xdp_pull_data
> >   selftests: drv-net: Pull data before parsing headers
> >
> >  include/net/xdp.h                             |   5 +
> >  include/net/xdp_sock_drv.h                    |  21 +-
> >  kernel/bpf/verifier.c                         |  13 ++
> >  net/bpf/test_run.c                            |   9 +-
> >  net/core/filter.c                             | 135 +++++++++++--
> >  .../bpf/prog_tests/xdp_context_test_run.c     |   4 +-
> >  .../selftests/bpf/prog_tests/xdp_pull_data.c  | 179 ++++++++++++++++++
> >  .../selftests/bpf/progs/test_xdp_pull_data.c  |  48 +++++
> >  .../selftests/net/lib/xdp_native.bpf.c        |  89 +++++++--
> >  9 files changed, 463 insertions(+), 40 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_pull_dat=
a.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_pull_dat=
a.c
> >
> > --
> > 2.47.3
> >

