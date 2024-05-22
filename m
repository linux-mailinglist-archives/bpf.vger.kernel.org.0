Return-Path: <bpf+bounces-30316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF278CC595
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 19:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66421F22C46
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 17:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A97C1422B8;
	Wed, 22 May 2024 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAfJcdHX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC4376048
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716399248; cv=none; b=joa7RX40zra6XLPWv3e+/kx5wl8YF28qeO+bxgvNwnvirwPykIQUfEZBW5BgS6hcnh8NpzZ/sGBlRUq15wFxkYdsot+EYAHi1XjFlk+293HOhQlYPeYeG8gHMn8S36+ymTOUdNVnsnMnqJyBQ2UfoUPzcwU48I3YT6CwU2pNRPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716399248; c=relaxed/simple;
	bh=PJRV17z0YKT7WdKwElz8Gtyvorzhx/mgkohKREg8JoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMIs6yLLbvvke9oKDBM7N9EwXU9BdibPSVjQiUm5yfNron3o3B43qybAXaOX68KPWCHpelI+8mVRaeUpBkBSIZn+dW/lAB210xKCl9aoQ+e/+JyFJ38NeEKuvIA+pwa2RXGeiHA7mzPs493cj7ujOMSNjsPudBLtnPG0G3aIvL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAfJcdHX; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so921489276.1
        for <bpf@vger.kernel.org>; Wed, 22 May 2024 10:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716399246; x=1717004046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5njBBAVBmAl8lad7cqRkTCGeZGU2mFB9jktNk1LZ3s=;
        b=mAfJcdHX56pGTMbhILp2PdVsFhkyIAZXBgLTFaSiiP5fi8Qp6j29ksabeeTWp7p7VS
         WfUAyzCxbIX167fqvE71LZWpocSVwVyEHsoSzhvP7E/bgD+U4L8FAlfBV7BfxnFbDt8A
         jeUz+oLz3jD+x88DJbedpVXaDAjd5ai2/iBJXNL5cbAjO7ii3uA2fE5iOlAG6bGSj8yh
         ixcMMcTooL1JSXm5JG27HPMRY1y6yXBCjHBJVjSyBBwW9LesT+K+ernB2huEdU1jP+s0
         SNucwQHzq5TWASjE+kbiU7kTSZURJpFJQE+3BD/ikWAb94Af8TMMR4bjA34X6T/oV+K2
         5WHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716399246; x=1717004046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5njBBAVBmAl8lad7cqRkTCGeZGU2mFB9jktNk1LZ3s=;
        b=w3R2hSJzmfCsUo07Y6k2Gj8MSffcHZIc3idaaTl3syHzEnt8SzOHYQC9xV6l5RVM7u
         q5AeroplKkK1HBlM54TqecMhLOLHTjmK+164fGw56NgvqN/lsdOq0ORbmVDjFJfBm0qH
         VdwYvdjA07PiQJJbsX7vYJbjk2ojzH8RXj3wxUCZ6NGcY6wmDDPfXSXH7xeaukuyot33
         2f6JJf8/RPYHZbDjkZagEE6g9Vq3N3BQ3sP+nc3ubDD5pGYLmP+D1cY01BzSnD0Awi6+
         J2lLxpIevNng/sW47SbCxPqGibE4hkL/KwrXL+mvhAWimoRzgtm+kYgY9o4Qiktg6TGF
         k1Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUgDzbBaL/E0IXLcR5vPj60Plp1eChdCQYKf0Ab7ylOjVXJ+Si4zVuk0fO0EQ/ShzZ99fhqfOrTFH0sDNaVCxpgFMBi
X-Gm-Message-State: AOJu0YxBEDj+CnV3s6lAYNCDGOdBQTa52cjdUbHQ0xarvnM2B6eY+iGq
	F9bfm4fRNIB/Aj2pYfHbVZNut7NHRy8qtca6LTetsEYAGn7QxC4+5w9WYx5pmR4Dv/Up0wP6zsa
	ntY2z2olzlE+IpB+copoHqCNFhhkTog==
X-Google-Smtp-Source: AGHT+IFXXtsYQHwpduXnF3H/v7Vg3/z9N7IMlSDgwkVXe3caLTRe8yg4HqN7z5R4wUDgu97J7D6xDBR1CeZRCfw3u70=
X-Received: by 2002:a25:ce8c:0:b0:df1:cdf5:d2c1 with SMTP id
 3f1490d57ef6-df4e0982817mr2122838276.0.1716399246188; Wed, 22 May 2024
 10:34:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510002942.1253354-1-thinker.li@gmail.com>
 <20240510002942.1253354-7-thinker.li@gmail.com> <20240521225252.GA3845630@bytedance>
 <033f0d5a-5e3d-4e53-9301-5075b6d74480@gmail.com>
In-Reply-To: <033f0d5a-5e3d-4e53-9301-5075b6d74480@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 22 May 2024 10:33:55 -0700
Message-ID: <CAMB2axO4odR3L0jpnirB9-ng_CLmEPbmNhvnfdboOam5QGSgwA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 6/7] selftests/bpf: detach a struct_ops link
 from the subsystem managing it.
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 5:31=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com> =
wrote:
>
>
>
> On 5/21/24 15:56, Amery Hung wrote:
> > On Thu, May 09, 2024 at 05:29:41PM -0700, Kui-Feng Lee wrote:
> >> Not only a user space program can detach a struct_ops link, the subsys=
tem
> >> managing a link can also detach the link. This patch adds a kfunc to
> >> simulate detaching a link by the subsystem managing it and makes sure =
user
> >> space programs get notified through epoll.
> >>
> >> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> >> ---
> >>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 42 ++++++++++++
> >>   .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |  1 +
> >>   .../bpf/prog_tests/test_struct_ops_module.c   | 67 +++++++++++++++++=
++
> >>   .../selftests/bpf/progs/struct_ops_detach.c   |  7 ++
> >>   4 files changed, 117 insertions(+)
> >>
> >> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/t=
ools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> >> index 1150e758e630..1f347eed6c18 100644
> >> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> >> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> >> @@ -741,6 +741,38 @@ __bpf_kfunc int bpf_kfunc_call_kernel_getpeername=
(struct addr_args *args)
> >>      return err;
> >>   }
> >>
> >> +static DEFINE_SPINLOCK(detach_lock);
> >> +static struct bpf_link *link_to_detach;
> >> +
> >> +__bpf_kfunc int bpf_dummy_do_link_detach(void)
> >> +{
> >> +    struct bpf_link *link;
> >> +    int ret =3D -ENOENT;
> >> +
> >> +    /* A subsystem must ensure that a link is valid when detaching th=
e
> >> +     * link. In order to achieve that, the subsystem may need to obta=
in
> >> +     * a lock to safeguard a table that holds the pointer to the link
> >> +     * being detached. However, the subsystem cannot invoke
> >> +     * link->ops->detach() while holding the lock because other tasks
> >> +     * may be in the process of unregistering, which could lead to
> >> +     * acquiring the same lock and causing a deadlock. This is why
> >> +     * bpf_link_inc_not_zero() is used to maintain the link's validit=
y.
> >> +     */
> >> +    spin_lock(&detach_lock);
> >> +    link =3D link_to_detach;
> >> +    /* Make sure the link is still valid by increasing its refcnt */
> >> +    if (link && IS_ERR(bpf_link_inc_not_zero(link)))
> >> +            link =3D NULL;
> >> +    spin_unlock(&detach_lock);
> >> +
> >
> > I know it probably doesn't matter in this example, but where would you =
set
> > link_to_detach to NULL if reg and unreg can be called multiple times?
>
> For the same link if there is, reg() can be called only once
> except if unreg() has been called for the previous reg() call on the
> same link. Unreg() can only be called for once after a reg() call on the
> same link.
>
> For struct_ops map with link, unreg() is called by
> bpf_struct_ops_map_link_dealloc() and bpf_struct_ops_map_link_detach().
> The former one is called for a link only if the refcnt of the link has
> dropped to zero. The later one is called for a link only if the refcnt
> is not zero, and it holds update_mutex. Once unreg() has been called,
> link->map will be cleared as well. So, unreg() should not be called
> twice on the same link except it is registered again.
>
> Does that answer your question?
>

Thanks for the detailed explanation. That makes sense to me.

> >
> >> +    if (link) {
> >> +            ret =3D link->ops->detach(link);
> >> +            bpf_link_put(link);
> >> +    }
> >> +
> >> +    return ret;
> >> +}
> >
> > [...]

