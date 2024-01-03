Return-Path: <bpf+bounces-18915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 658CF8236C9
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 21:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B7631C24558
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 20:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AD71D544;
	Wed,  3 Jan 2024 20:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNSTgAgG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E41F1D548
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 20:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55569b59f81so6834792a12.1
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 12:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704315076; x=1704919876; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wcD4SjhlNeO+Xdt8VG7DB2eJpKaYJCZEiUBbuAhzi4Y=;
        b=QNSTgAgGzNN4tw3yoTbEOAZg6KN8JPTmXMDGvqk2dY57PijVjE5vpMg94pXnde4TAc
         +3uH4AFUBgu3P5KKwZEWUhOaeo3Ar3Uw5ne0fuPXktuJwBLQrlOs2rJkhLUK5cldh3tf
         LG6AFbGlMaWv1rWcEXrDq1fPMC7EIw2t69JxWlRu6Nzfew+4M3d7qUXuo/g/k06KP4+I
         8eIMHXwBIMh3+3nIuykroSNSlsYW1QaOl2kl3ocsd7ThM+EmQVRETlrzFCIkB0Yj+QuB
         OBL1zCGBzF51awnp1HtZtcVCeMqtDxB/PeSgASSeQBraeYAm8s+HJ/1M/E6tMjmnDOId
         Ed9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704315076; x=1704919876;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wcD4SjhlNeO+Xdt8VG7DB2eJpKaYJCZEiUBbuAhzi4Y=;
        b=LkPjW8kC1cdeGpWbEcCsD2S9PwcuN7LAKNfbn501JydUNio/t+Y6T7++ANpOdgMaeE
         EeeR1ARAeEvE7xr1/JkwIhSCOhaFqV2I7aKVxrkVujXULA5GmYhFb1fz3PKlcrNCH0V9
         pRJe30ixxUMPMmLm3T9zcQgNcSv5iBqwRBHv2TAuzO2TdqHUtaLhOrsDnlN9fyopIIDO
         XD1Exi89q3LA7Fuu7w+j897gcMLxGO6SyN8PIme0XEfiFywWrL71bLUEmsLjxysQXawp
         Ecjr74OTX/s+8VheTcwKYpewiKIYUU9LOT9WjvrkLrJ6HLddKQLPqrn549MEofPWId8D
         SMUw==
X-Gm-Message-State: AOJu0YyBdZORPPuCNbHzSEn65GHDJkgMKAv9FHBhWA/VUM1FDR9dxlYo
	p5cn9peVvV7J1T71XCvULy8=
X-Google-Smtp-Source: AGHT+IFzNV/Y5l0meQ33FFtcCrnN3NkOWtbI2vRVvEYfbwaFdeJVB0ZsDHfPqRTB0TwRyJRAdhRgoA==
X-Received: by 2002:a17:906:4f8e:b0:a27:9b17:aa31 with SMTP id o14-20020a1709064f8e00b00a279b17aa31mr4287088eju.81.1704315075732;
        Wed, 03 Jan 2024 12:51:15 -0800 (PST)
Received: from erthalion.local (dslb-178-005-229-020.178.005.pools.vodafone-ip.de. [178.5.229.20])
        by smtp.gmail.com with ESMTPSA id ad5-20020a170907258500b00a28825e0a2bsm1136374ejc.22.2024.01.03.12.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 12:51:15 -0800 (PST)
Date: Wed, 3 Jan 2024 21:51:06 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev,
	dan.carpenter@linaro.org, olsajiri@gmail.com, asavkov@redhat.com
Subject: Re: [PATCH bpf-next v12 2/4] selftests/bpf: Add test for recursive
 attachment of tracing progs
Message-ID: <20240103205106.i7pukj7baii6xk7z@erthalion.local>
References: <20240103190559.14750-1-9erthalion6@gmail.com>
 <20240103190559.14750-3-9erthalion6@gmail.com>
 <CAPhsuW7Nn2i1PBCH5JDcShH6dYYwPKU9tHrVmT822n7BHNByLw@mail.gmail.com>
 <20240103201853.xqh4hhdp7p4owkna@erthalion.local>
 <CAPhsuW4rRXLU=Pt6eqhjHW1gxy8ypo0BkFaEPP-Ny+GGEpjPrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW4rRXLU=Pt6eqhjHW1gxy8ypo0BkFaEPP-Ny+GGEpjPrw@mail.gmail.com>

> On Wed, Jan 03, 2024 at 12:47:44PM -0800, Song Liu wrote:
> On Wed, Jan 3, 2024 at 12:19 PM Dmitry Dolgov <9erthalion6@gmail.com> wrote:
> >
> > > On Wed, Jan 03, 2024 at 11:47:14AM -0800, Song Liu wrote:
> > > On Wed, Jan 3, 2024 at 11:06 AM Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
> > > > +char _license[] SEC("license") = "GPL";
> > > > +
> > > > +/*
> > > > + * Dummy fentry bpf prog for testing fentry attachment chains. It's going to be
> > > > + * a start of the chain.
> > > > + */
> > >
> > > Comment  style. I guess we don't need to respin the set just for this.
> >
> > Damn, I thought I've corrected them all, sorry.
> >
> > What do you mean by not needing to respin the set, are you suggesting
> > leaving it like this, or to change it without bumping the patch set
> > number?
>
> I meant let's not send v13 yet. If this is the only fix we need, the maintainer
> can probably fix it when applying the patches.

Sounds reasonable, thanks.

