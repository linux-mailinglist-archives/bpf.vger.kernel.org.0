Return-Path: <bpf+bounces-13749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 619417DD650
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 19:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B5671C20CF6
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 18:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E27520B32;
	Tue, 31 Oct 2023 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iggsLkVn"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B17620332
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 18:49:37 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1952FA6
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 11:49:36 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9c603e2354fso23962466b.1
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 11:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698778174; x=1699382974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpcvV1wqnzigOKvxEFvhwq2w5/7Q3CDrhskXCEtU7BM=;
        b=iggsLkVnu6RojNxlmOxCmSgQe+rIdxluCziWAmJ16ZihoWj5EiX4RwRnsXsUCATdMQ
         BPQSv91VAYt6EpjDs8d+9cfDXrRYpkdgneKMbPoaavrDcPvwxFyiMnirArY6YdxzHcG+
         GV3YsLeP+c3m0zZUeMaGDwpRBn1RRsLLP4ielLhOeFl9CsLKHn+8ljPWIQHKQf2dX39o
         5O4U/XPXDuKv4+hJRmdIIdrZJ7QBgBszHVqCBxDl4E0kY5HFCq2RMusbCs3dgZi13Z8r
         kuRHmn2Ga+aPPXX4DoWe4pD2virK22ltbpGv0rZ/S3YNgytFhcS3xtYM5ErXbV3pn/9/
         GQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698778174; x=1699382974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpcvV1wqnzigOKvxEFvhwq2w5/7Q3CDrhskXCEtU7BM=;
        b=uLejmSPTCeTXP+ih4Mlp7D7rmgkHhB9oH9k0mVjj8WuGzChqoFT1IGHQYniQf8yREy
         9WC7MTPpzk+Xl/zdKTKeSUMC2tI10A+L7oKwuThVfdlPgCetrtYp0efEeu9ldxTNrD1R
         p3t5ZIBZvp2OzcJjlDmJip3WAhce8g2Mc0yXkicNRgQfatq0yoQQXOLMiPkf0Nx7JdN/
         EHE869Hjy3kuHCx05Z30X5jHwx1ppeW3/1NhrIBMGGw2IOjcJkZAxeEhRBTF6U+yP5Mq
         mga1ROXrSWk1MeLucxjIDkXYBpsbwT6UoQxEXt8ZAoTdptAtG93m3tACdGK5zDA23PtW
         sAig==
X-Gm-Message-State: AOJu0YzEpjAWyF5NsU62mKwt/PaHtxpeNOfH/73IgcsRd6Y3L7uB+WkK
	KgHOhA6hewlZf7inyVmn6BVXn+8tpESJS5I0MY4=
X-Google-Smtp-Source: AGHT+IH78x4xWW0+sgSo4M1JrsCv1TmeG7gXbIvvL2Jja7bhStk1WeS+VlKC6i2x+Hv6aaF5sHumwajaiDnL62Y7HQE=
X-Received: by 2002:a17:906:7956:b0:9b2:bcea:e517 with SMTP id
 l22-20020a170906795600b009b2bceae517mr174356ejo.10.1698778174476; Tue, 31 Oct
 2023 11:49:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027181346.4019398-1-andrii@kernel.org> <20231027181346.4019398-7-andrii@kernel.org>
 <d7af631802f0cfae20df77fe70068702d24bbd31.camel@gmail.com>
 <CAEf4BzZVmEUP-+jP34H+UJF5qK2boKFHH3+rpKkjEVEKvN4eMQ@mail.gmail.com> <CAADnVQK0uAgEDN38uwH581=a0A4QQjCWaORQLbKzBoUbXfovpw@mail.gmail.com>
In-Reply-To: <CAADnVQK0uAgEDN38uwH581=a0A4QQjCWaORQLbKzBoUbXfovpw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 31 Oct 2023 11:49:23 -0700
Message-ID: <CAEf4BzY4KcyZt+EDG8y6ERq=uRtTaMYS2X8e6vgSxrHmiUevYw@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 06/23] bpf: add special smin32/smax32
 derivation from 64-bit bounds
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 11:41=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Oct 31, 2023 at 10:39=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > > fwiw, an alternative explanation might be arithmetic based.
> > > Suppose:
> > > . there are numbers a, b, c
> > > . 2**31 <=3D b < 2**32
> > > . 0 <=3D c < 2**31
> > > . umin =3D 2**32 * a + b
> > > . umax =3D 2**32 * (a + 1) + c
> > >
> > > The number of values in the range represented by [umin; umax] is:
> > > . N =3D umax - umin + 1 =3D 2**32 + c - b + 1
> > > . min(N) =3D 2**32 + 0 - (2**32-1) + 1 =3D 2
> > > . max(N) =3D 2**32 + (2**31 - 1) - 2**31 + 1 =3D 2**32
> > > Hence [(s32)b; (s32)c] form a valid range.
> > >
> > > At-least that's how I convinced myself.
> >
> > So the logic here follows the (visual) intuition how s64 and u64 (and
> > also u32 and s32) correlate. That's how I saw it. TBH, the above
> > mathematical way seems scary and not so straightforward to follow, so
> > I'm hesitant to add it to comments to not scare anyone away :)
>
> Actually Ed's math carried me across the line.
> Could you add it to the commit log at least?

Sure, whatever it takes :) Will add to the commit message.

>
> > I did try to visually represent it, but I'm not creative enough ASCII
> > artist to pull this off, apparently. I'll just leave it as it is for
> > now.
>
> Your comment is also good, keep it as-is,
> but it's harder to see that it's correct without the math part.
>
> > > > +      * upper 32 bits. As a random example, s64 range
> > > > +      * [0xfffffff0ffffff00; 0xfffffff100000010], forms a valid s3=
2 range
> > > > +      * [-16, 16] ([0xffffff00; 0x00000010]) in its 32 bit subregi=
ster.
> > > > +      */
>
> typo. It's [-256, 16]

I think I wanted to have 0xfffffff0 (one more f) for [-16, 16], but I
can also leave asymmetrical bounds [-256, 16]

