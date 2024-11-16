Return-Path: <bpf+bounces-45037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BBA9D0137
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 23:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FA8F2849FF
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 22:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA6F1B21B6;
	Sat, 16 Nov 2024 22:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSvfgsHM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DAC19AA63;
	Sat, 16 Nov 2024 22:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731795460; cv=none; b=MUkvcLbcDXOJxHMADcjKKQopgf8vgTDzxRGHC6Ki0L29W+9OPCz+kqHDz0KGhnaOj9r02vhPeu2GW0lXxhKtxun2OwVWift/3mTOJAnOXNNR5UMlePSH/dZ7tEt61HeVGIyL9k61C+BqRXp8VPJ/TQHBm/x/bze16b13a6aDAjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731795460; c=relaxed/simple;
	bh=jODuxhQrkthqMKTotq75vT9xRvR6f3kKB2DRq4n4UIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bxHnYOtLiMV1KIRnRQTB3l16vnO6C0FnljWH7YyVlOLrNMSQoG7a00FMPbyjApNchXxUW0W6uk1R/a7d96ko7/ccsuQZs6p49nPSiS3LqNpl1xus9eBkcvgIshdesSrvvOUUXzXusmkMDd/oK55PfVBwXN/YYtpJrFYe+LQ8Z+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSvfgsHM; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d4c482844so2045580f8f.0;
        Sat, 16 Nov 2024 14:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731795457; x=1732400257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jODuxhQrkthqMKTotq75vT9xRvR6f3kKB2DRq4n4UIM=;
        b=XSvfgsHMzCWXnZM5Yz/BKA0jAGQdYKdZOv5/KqT90VyHOcS2PHnMPmZTaIAF1GA59y
         kKUPgBmFheIEE2nKpa223pVG9RQJPaJQnlYQIAokaPpqWrDTC4Y7kmwG8bs3HMwa921f
         iKHuUamLH2p9WAHO2UveIUGXhP1xu4ojQ0qMSOvj7atbIay2WrLxGpDu5tCG9xQEQN/V
         kGWXOzjOPilcLURCzE+AoDPqJG8AHrKEKoftZQzq9r7fz97Ex6uaG87Pp1wtwamIDRKe
         2nzfydGMf/LzAvOs8Dm41/aIcJBZzYBYBHuTATReTtrJUqc3LQ+vf1Q/5Yl/SnKhXj2B
         aKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731795457; x=1732400257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jODuxhQrkthqMKTotq75vT9xRvR6f3kKB2DRq4n4UIM=;
        b=AGi/XkCqroLmQRKtFX1CWwujMPwaMnXk8SSIYg54VkRQR2k80wimVU+TWWl8J7SscM
         64v9ZeLXWzpkeHP+O9jZTaVX69qw7kOcyFss9V/X0YOBBjYXEZvZs482GdnV23J720bw
         UGjSkaHX3e9RifBocX9vXGCc85KxPp3ihCIft6CPTEFIwnulDwqQ1JueZa2tlFMcCKph
         /US0gYjxv9nT373ibfPdxleTMUiR9DhLUGxggGHWKPtJr03DIPwcIRopI48RtnGDBRZH
         hpF9euzTQlmanEgCA3CBCuIYymxT0VXJB58HuQYIWArAwz9H5wdtLcOYTUUDCxpA8jcc
         ZUmw==
X-Forwarded-Encrypted: i=1; AJvYcCUkZDJ/40pw2e4QkA9EdzFkqbwNG+VNR7EZ82s3XGXVddxshcbPMWvxDPDI9KVL3b5pv7LjsHWc@vger.kernel.org, AJvYcCV55kNflRN9xtsJrWyZmZPqgWp7hkOnVM23z4bm78d1yglPmgWtf8bU2wLEOT82PlaFkfOczsfBtzDtyQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaARTxuvdt0eeawYGwsau4p76qKU8qHjdyshZoa3CfTTCLdnpn
	V8O7D+sM2mojMa+r3VpzvoriOrQtQGkmnPaeFN6ezFG4OFo3+WBXRKC6ZS3CKFteD2SDO+GR5oS
	m1trNHO9T8U2TJbNCwUNv2Bee8kBkmw==
X-Google-Smtp-Source: AGHT+IFYmGciyNyCsJ3UHebFQYick7MIaSOI+qoOJ71TeEGVvgpvaxlPRgrAN8zDebPcHjDB3pY0VlLDJWWfhHQeYFM=
X-Received: by 2002:a05:6000:796:b0:37e:f4ae:987d with SMTP id
 ffacd0b85a97d-38225a05956mr5667325f8f.29.1731795456743; Sat, 16 Nov 2024
 14:17:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1692748902.git.dxu@dxuuu.xyz> <eb20fd2c-0fb7-48f7-9fd0-4d654363f4da@app.fastmail.com>
In-Reply-To: <eb20fd2c-0fb7-48f7-9fd0-4d654363f4da@app.fastmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 16 Nov 2024 14:17:25 -0800
Message-ID: <CAADnVQ+T2nSCA8Tcddh8eD27CnvD1E3vPK0zutDt8Boz7MURQA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/2] Improve prog array uref semantics
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 11:36=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Hey Daniel,
>
> On Wed, Aug 23, 2023, at 9:08 AM, Daniel Xu wrote:
> > This patchset changes the behavior of TC and XDP hooks during attachmen=
t
> > such that any BPF_MAP_TYPE_PROG_ARRAY that the prog uses has an extra
> > uref taken.
> >
> > The goal behind this change is to try and prevent confusion for the
> > majority of use cases. The current behavior where when the last uref is
> > dropped the prog array map is emptied is quite confusing. Confusing
> > enough for there to be multiple references to it in ebpf-go [0][1].
> >
> > Completely solving the problem is difficult. As stated in c9da161c6517
> > ("bpf: fix clearing on persistent program array maps"), it is
> > difficult-to-impossible to walk the full dependency graph b/c it is too
> > dynamic.
> >
> > However in practice, I've found that all progs in a tailcall chain
> > share the same prog array map. Knowing that, if we take a uref on any
> > used prog array map when the program is attached, we can simplify the
> > majority use case and make it more ergonomic.

Are you proposing to inc map uref when prog is attached?

But that re-adds the circular dependency that uref concept is solving.
When prog is inserted into prog array prog refcnt is incremented.
So if prog also incremented uref. The user space can exit
but prog array and progs will stay there though nothing is using them.
I guess I'm missing the idea.

> >
> > I'll be the first to admit this is not a very clean solution. It does
> > not fully solve the problem. Nor does it make overall logic any simpler=
.
> > But I do think it makes a pretty big usability hole slightly smaller.
> >
> > I've done some basic testing using a repro program [3] I wrote to debug
> > the original issue that eventually led me to this patchset. If we wanna
> > move forward with this approach, I'll resend with selftests.
> >
> > [0]:
> > https://github.com/cilium/ebpf/blob/01ebd4c1e2b9f8b3dd4fd2382aa1092c3c9=
bfc9d/doc.go#L22-L24
> > [1]:
> > https://github.com/cilium/ebpf/blob/d1a52333f2c0fed085f8d742a5a3c164795=
d8492/collection.go#L320-L321
> > [2]: https://github.com/danobi/tc_tailcall_repro
>
> I recently remembered about this again. Was suggested I poke you in case =
you're interested.
> I looked again and I think this is kinda a neat hack. I probably won't ha=
ve time to pick this back
> up either way.
>

