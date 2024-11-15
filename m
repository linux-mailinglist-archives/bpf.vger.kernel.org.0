Return-Path: <bpf+bounces-44995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A532B9CF99D
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 23:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 354801F21552
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 22:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443341FB883;
	Fri, 15 Nov 2024 22:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IO4itoVq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2B718D63A
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 22:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731708553; cv=none; b=drf6IFxpODDedQSzLKbcJnpZiJqzQoXLLrZfF9WvwCWp/Y2MWpdQndU7hF+gj5RUIpcTxqDFpDHk3/qO5ohixbD4KMj7i8DDNHB4hixYj7dyoojNnAIUkdtEIX0y4Bf/A6s9e1XkEPGk4J+FJm6ZEp0wqYY9/Axo4dmB4qmK3g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731708553; c=relaxed/simple;
	bh=srKvfuEbZNy+Px+mpIklHKSttvPSk88EtYs3KKGiy64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p6OLjKk2NS54IO+kHuvZPb25yEHrhehxWKqwvUMlTBLTG8oEp5TYM7zvQjDIjLk9HnwMEcFtvRCgYhr58/Kn1FqdPLvOw6WK7QTBuv/fNax+lmp3Kuh3n+TEF17QgczHH0MhIggZN0WOR1iz9cXySZaq2yMlW6av5V2bJLf3Pg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IO4itoVq; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ea0bd709c0so88823a91.3
        for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 14:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731708551; x=1732313351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gS9DwlkBUBMROqpPR6WlzLiT8dRuGL5+HNI4bwzyLMw=;
        b=IO4itoVqsNu3M6QBGR+V69qwOEtxmhiJ3QrCsFxUoVONrpkKuMAcotHX978/xGUUZy
         o4xrT//P9KBlJ4OdVpvQKahGgEdiBBTtU0ZABfRKTdL8vNlas4AseYfvdbNlhOKlQvnK
         AQfZEAQgFkcFgdOvehN6//98aidSXUKwswNPc7XnoSTnUlCECB3ytQ1yXotZXveahJil
         haaPRzecRhjhprKYAVDBoOlCK8lC+N1Ag5pOyjlyeMzRrbHr4DVgyzpZ21jZjTEwyySJ
         vNs/OrhVTzyyR/LaPCVZc6hmEADivS/sQ9diFNvNvdIoEx5PY0Zs+xN1uGvk0zc6BbRj
         N1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731708551; x=1732313351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gS9DwlkBUBMROqpPR6WlzLiT8dRuGL5+HNI4bwzyLMw=;
        b=Sf2AeyZ9AkDPpSas8AAqRZek1TVB2GDJTKTW7yI+crSfbA+CpPY1Fr/2LWUt7WgSZK
         Dm7JI4AQBVVs/gBFLB3VoBfw+G0IXHQlJwqdkjAAoUkNNpCDrQcg6Ie45Hgo/i8C24i+
         IXuwRSl3x+vk57d/hvWx+rsD4bzI2pgaXgXDZMRpVtnuQu136adFKxjb9IXPsfR35/22
         UAr3yQVzfweA5YruBCPycjgPAdASkHxwZIeb5iaxGtEzVv/3/8AH0ConPSbl1zeQxc/a
         SI2j3MYOzIG0pGBFodDtAWbg2hSc0XwEX5LtChBhn35Hq0iosT5slbs2UQcEHIpVhnXV
         +M8w==
X-Gm-Message-State: AOJu0Yz6Afo3joQG99bi7dEe0yLqk8abe6HCfEX5CYtMONGoqkiVB26R
	GChWPjKQJuDToVWn+AArz5/4M3ya8gF9OG0El8xkOrji33wFp6WADVwnHZM121ExZvWUtMzTWSF
	dq6bE3ouWhMI/yJbisoU5LcpbgO8=
X-Google-Smtp-Source: AGHT+IGDDCDz7BdJoUB+PtpvLbSZ/rPvapwBZDBo3sUjcSwXEuJ2jOhEZQXHUuhPGUBeUGhZ3UYG79pQcDSmoLsEfhk=
X-Received: by 2002:a17:90b:278e:b0:2e9:4967:244 with SMTP id
 98e67ed59e1d1-2ea15585d4dmr5186704a91.24.1731708551508; Fri, 15 Nov 2024
 14:09:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114170721.3939099-1-ryantimwilson@gmail.com>
In-Reply-To: <20241114170721.3939099-1-ryantimwilson@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 Nov 2024 14:08:59 -0800
Message-ID: <CAEf4BzZXHK-v6MSQ0vDjTE-jFvqk9UwSGkBgcXihpfc2n91RyA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add multi-prog support for XDP BPF programs
To: Ryan Wilson <ryantimwilson@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, ryantimwilson@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 9:07=E2=80=AFAM Ryan Wilson <ryantimwilson@gmail.co=
m> wrote:
>
> Currently, network devices only support a single XDP program. However,
> there are use cases for multiple XDP programs per device. For example,
> at Meta, we have XDP programs for firewalls, DDOS and logging that must
> all run in a specific order. To work around the lack of multi-program
> support, a single daemon loads all programs and uses bpf_tail_call()
> in a loop to jump to each program contained in a BPF map.
>
> This patch proposes allowing multiple XDP programs per device based
> on the mprog API from the below commit:
>
> Commit 053c8e1f235d ("bpf: Add generic attach/detach/query API for
> multi-progs")
>
> This patch adds support for multi-progs for generic XDP and the tunnel
> driver, as it shares many APIs with generic XDP. Each driver can be
> migrated by:
> 1. Return 0 for command =3D XDP_QUERY_MPROG_SUPPORT
> 2. Codemod xdp.prog -> xdp.array in driver code
> 3. Run programs with bpf_mprog_run_xdp()
> 4. Change bpf_prog_put() to bpf_mprog_array_put()
>
> Note non-migrated driver are currently backwards compatible. They will
> receive a single program object but attachment will fail if user tries
> to attach multiple BPF programs.
>
> Note this patch is more complex than its TCX counterpart
>
> Commit e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with
> link support")
>
> This is because XDP program attachment/detachment is done via BPF links a=
nd
> netlink socket unlike bpf_prog_attach() syscall. We only add multi-progs
> support for BPF links in this commit but ensure the netlink socket is
> backwards compatible with single program attachment/detachment/queries.
>
> Unlike TCX, each driver needs to own a reference to the BPF programs it
> runs. Thus, we introduce struct bpf_mprog_array to copy from
> bpf_mprog_entry owned by the network device. The BPF driver then will
> release the array via bpf_mprog_array_put() which will decrement each
> BPF program refcount and free the array memory.
>
> Furthermore, we typically set the BPF multi-prog flags via
> link_create.flags e.g. BPF_F_BEFORE. However, there are already XDP_*
> flags set via link_create.flags e.g. XDP_FLAGS_SKB_MODE. For example,
> BPF_F_REPLACE and XDP_FLAGS_DRV_MODE both have the same value. Thus to
> allow for setting both XDP_* mode and BPF_* multi-prog flags when using
> BPF links, we introduce link_create.xdp.flags for setting BPF_* flags
> specifically. However, feedback is needed on this approach to make sure
> its compatible with libbpf.
>
> Note I am in the process of verifying no/minimal performance overhead
> for a real driver but I am sending this patch for feedback on the overall
> approach.
>
> Signed-off-by: Ryan Wilson <ryantimwilson@gmail.com>
> ---

So I looked through this once, but it's a bit too much code to grok at
once, so please bear with me if I'm proposing something stupid. But
just a few initial thoughts.

First, you bundled everything into a single patch, which makes it
harder to review. At the very least, split out selftests. If you can
break it further, say into mprog_array abstraction patch, then generic
XDP infrastructure patch, then tun-specific patch, etc, that would
make it much easier to follow and review.

Looking at tun.c, I like how straightforward the conversion is thanks
to bpf_mprog_array, nice job with that! Converting the other 50 use
cases should be easy ;)

There seems to be dev_xdp_attach_netlink() duplication, is it
absolutely necessary or can we keep a common dev_xdp_attach()
implementation between BPF link and netlink implementations?

But overall everything seems to make sense, but again, a bit much
code, so I'll need few more passes (maybe next week).


>  drivers/net/tun.c                             |  54 +--
>  include/linux/bpf_mprog.h                     |  72 +++
>  include/linux/netdevice.h                     |  23 +-
>  include/linux/skbuff.h                        |   3 +-
>  include/net/xdp.h                             |  94 ++++
>  include/uapi/linux/bpf.h                      |  12 +
>  net/core/dev.c                                | 422 ++++++++++++++----
>  net/core/rtnetlink.c                          |  16 +-
>  net/core/skbuff.c                             |  11 +-
>  .../selftests/bpf/prog_tests/xdp_link.c       |  15 +-
>  10 files changed, 571 insertions(+), 151 deletions(-)

[...]

