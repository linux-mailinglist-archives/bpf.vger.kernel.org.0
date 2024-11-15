Return-Path: <bpf+bounces-44998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC44D9CF9D3
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 23:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D5F4284F2C
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 22:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A69191499;
	Fri, 15 Nov 2024 22:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSwS41H6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D026818FC67
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 22:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731709890; cv=none; b=fg5oa4g/Sg9a7kAMoljBvrBjOLAMFLNJ4ghBH4jcjMwoQ9149YGdyzxazaXzwPegBv+w7bWam3waFTDJOhEuQaPDDZgYBK8xIXKzN7Pzt+l8W5GTncmjRqnjDTur8QhITyGiDXAKOMFAColQ4C+PQl7ZRYVVV1IMWODP1J55xkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731709890; c=relaxed/simple;
	bh=FF+sZpaX5A6jHgsCh1Pb7DWj6cSXvU97x+F74wawL5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fgWqfxFxP38SSVOFAA1aT/oJonZNYGo6dwUMgPpZhMPQ1ER2CUXoG7Lt8R3nnsJIXPWkgqsxCkJfVFUYvmreH4pESIu9iSj8NGsI8oV7vuVey2rfoyO10NHzOny8fxuXxkGWF5qb26ZClWaTYYC4xxUxULe5MPtBcBjCrn94L1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSwS41H6; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c95a962c2bso1916337a12.2
        for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 14:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731709887; x=1732314687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ho19FBSuXI2+lBXyMQkW8zBlk9+GTzQIlhtxALAzc+I=;
        b=aSwS41H6OjFjxCrG7jNAAWCCH/ZV5sJLsRMGRS80u8leLhRBtmxSnlMw+wiP9sTrkz
         dGx27/zAYX6kRo0WLpsPODrLz76pMibounxqWM62PyAUL9cuD7d2xAHclBf3hme7Kifa
         b2TuMjixO8jpXLmRBL48dDfPLKmw8luc6UY5Nset3QggLnhMQiba2qNENBYUXTBm2dQ7
         9zPlOabLELlh18HCOuJKD7Ijq4qdxPeOYoZ4yXtfVuY3jTKCR/B1unCq0/ZOi84IRgn3
         frmELzSdoDSRHc3sImKMpy5svsuq3xs6vsEXHeFp9u4W3ANEgP7Jdfjvydc6sojBZklG
         EM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731709887; x=1732314687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ho19FBSuXI2+lBXyMQkW8zBlk9+GTzQIlhtxALAzc+I=;
        b=o6YbMqSYoZwTxvJw+gfebUgWy94BeWdcl6RTOft8rakEIM36EDVgHOF9X0zlTyNsEA
         mgw/b53wIYiERHs+qHUeXDV7VtTTZjdPauJQcl1qPf62fzECEKj9V5rQSyew8KdFBBFC
         z4SkCu4Nip0erSMHSY2mVe6K2ngp1ErZId2pjlcwAIZU96QUXLbYPhBTznNLG2sBDttv
         QQPsgeRHTHO+63VSe/xLYqUrwTD5mpT6nzXXB+VxAJQE4r2PP0UrbGCIDNDlrCGys4zj
         Q+1N07LeeRESeDa9X6+Ky/wwKZmNsZMvPrCdLjL6txfKucGYMtpU++Z7EpfqeCpl9FdX
         gWVg==
X-Gm-Message-State: AOJu0YyHyjhGDrcGUbb/XM53oQHiSBSoGsBMobJX/AjuSJW7bC0p+gQS
	gcXBmuCPICRCzuskCVO8gFFqk7KM/vNPs+JyZ7s4Uay+cYKmmWZYIKN8xWibRQx6mV+1Oq0wo9U
	xrIVaUSHHZltHU2886uvJW4Mv160=
X-Google-Smtp-Source: AGHT+IHXdTO+CkaWrTc/LHHfZ1uvGE70x5Il2p1hwBNOS5yodqXRi7kbiI8on8gOQ0WMb4pRHAk5DA+KoKN5Lqz8XpI=
X-Received: by 2002:a05:6402:545:b0:5cf:9cd1:1f74 with SMTP id
 4fb4d7f45d1cf-5cf9cd12158mr1384240a12.9.1731709886973; Fri, 15 Nov 2024
 14:31:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114170721.3939099-1-ryantimwilson@gmail.com> <CAEf4BzZXHK-v6MSQ0vDjTE-jFvqk9UwSGkBgcXihpfc2n91RyA@mail.gmail.com>
In-Reply-To: <CAEf4BzZXHK-v6MSQ0vDjTE-jFvqk9UwSGkBgcXihpfc2n91RyA@mail.gmail.com>
From: Ryan Wilson <ryantimwilson@gmail.com>
Date: Fri, 15 Nov 2024 14:31:15 -0800
Message-ID: <CA+Fy8UbaxHDmTKmX6oRBD-oaYq=1B=r4zXur5JKStTmnbzp0SQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add multi-prog support for XDP BPF programs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, ryantimwilson@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 2:09=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Nov 14, 2024 at 9:07=E2=80=AFAM Ryan Wilson <ryantimwilson@gmail.=
com> wrote:
> >
> > Currently, network devices only support a single XDP program. However,
> > there are use cases for multiple XDP programs per device. For example,
> > at Meta, we have XDP programs for firewalls, DDOS and logging that must
> > all run in a specific order. To work around the lack of multi-program
> > support, a single daemon loads all programs and uses bpf_tail_call()
> > in a loop to jump to each program contained in a BPF map.
> >
> > This patch proposes allowing multiple XDP programs per device based
> > on the mprog API from the below commit:
> >
> > Commit 053c8e1f235d ("bpf: Add generic attach/detach/query API for
> > multi-progs")
> >
> > This patch adds support for multi-progs for generic XDP and the tunnel
> > driver, as it shares many APIs with generic XDP. Each driver can be
> > migrated by:
> > 1. Return 0 for command =3D XDP_QUERY_MPROG_SUPPORT
> > 2. Codemod xdp.prog -> xdp.array in driver code
> > 3. Run programs with bpf_mprog_run_xdp()
> > 4. Change bpf_prog_put() to bpf_mprog_array_put()
> >
> > Note non-migrated driver are currently backwards compatible. They will
> > receive a single program object but attachment will fail if user tries
> > to attach multiple BPF programs.
> >
> > Note this patch is more complex than its TCX counterpart
> >
> > Commit e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with
> > link support")
> >
> > This is because XDP program attachment/detachment is done via BPF links=
 and
> > netlink socket unlike bpf_prog_attach() syscall. We only add multi-prog=
s
> > support for BPF links in this commit but ensure the netlink socket is
> > backwards compatible with single program attachment/detachment/queries.
> >
> > Unlike TCX, each driver needs to own a reference to the BPF programs it
> > runs. Thus, we introduce struct bpf_mprog_array to copy from
> > bpf_mprog_entry owned by the network device. The BPF driver then will
> > release the array via bpf_mprog_array_put() which will decrement each
> > BPF program refcount and free the array memory.
> >
> > Furthermore, we typically set the BPF multi-prog flags via
> > link_create.flags e.g. BPF_F_BEFORE. However, there are already XDP_*
> > flags set via link_create.flags e.g. XDP_FLAGS_SKB_MODE. For example,
> > BPF_F_REPLACE and XDP_FLAGS_DRV_MODE both have the same value. Thus to
> > allow for setting both XDP_* mode and BPF_* multi-prog flags when using
> > BPF links, we introduce link_create.xdp.flags for setting BPF_* flags
> > specifically. However, feedback is needed on this approach to make sure
> > its compatible with libbpf.
> >
> > Note I am in the process of verifying no/minimal performance overhead
> > for a real driver but I am sending this patch for feedback on the overa=
ll
> > approach.
> >
> > Signed-off-by: Ryan Wilson <ryantimwilson@gmail.com>
> > ---
>
> So I looked through this once, but it's a bit too much code to grok at
> once, so please bear with me if I'm proposing something stupid. But
> just a few initial thoughts.
>
> First, you bundled everything into a single patch, which makes it
> harder to review. At the very least, split out selftests. If you can
> break it further, say into mprog_array abstraction patch, then generic
> XDP infrastructure patch, then tun-specific patch, etc, that would
> make it much easier to follow and review.

Good point. I'll split this up into multiple patches.

Note I really didn't add new selftests, I only changed an existing
selftest that expected multiple links attaching to an XDP device to
fail - that now works. I'll add a more complete selftest to the v2
patch set that makes use of all the relevant BPF_F_* multiprog flags.

>
> Looking at tun.c, I like how straightforward the conversion is thanks
> to bpf_mprog_array, nice job with that! Converting the other 50 use
> cases should be easy ;)
>
> There seems to be dev_xdp_attach_netlink() duplication, is it
> absolutely necessary or can we keep a common dev_xdp_attach()
> implementation between BPF link and netlink implementations?

So I ended up splitting these because I thought it was harder to read,
especially now that netlink doesn't support mprog and link does. :) I
tried to combine a lot of the logic in verify_dev_xdp_attach but maybe
that wasn't enough. I'll try recombining dev_xdp_attach() again and
see how it looks.

>
> But overall everything seems to make sense, but again, a bit much
> code, so I'll need few more passes (maybe next week).
>
>
> >  drivers/net/tun.c                             |  54 +--
> >  include/linux/bpf_mprog.h                     |  72 +++
> >  include/linux/netdevice.h                     |  23 +-
> >  include/linux/skbuff.h                        |   3 +-
> >  include/net/xdp.h                             |  94 ++++
> >  include/uapi/linux/bpf.h                      |  12 +
> >  net/core/dev.c                                | 422 ++++++++++++++----
> >  net/core/rtnetlink.c                          |  16 +-
> >  net/core/skbuff.c                             |  11 +-
> >  .../selftests/bpf/prog_tests/xdp_link.c       |  15 +-
> >  10 files changed, 571 insertions(+), 151 deletions(-)
>
> [...]

