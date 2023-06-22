Return-Path: <bpf+bounces-3124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CAB739A8C
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 10:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90A91281698
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 08:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538813D61;
	Thu, 22 Jun 2023 08:47:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DDE80C
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 08:47:23 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79DB1735;
	Thu, 22 Jun 2023 01:47:21 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b44eddb52dso100455931fa.3;
        Thu, 22 Jun 2023 01:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687423640; x=1690015640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ep2nmcwhqoubpUdoFoZiWlPysqbDDgRr+0DZ2J7o3XE=;
        b=RJixZshx3SJx3vK9bdq7GVj+cUXmPXuTZVIJJAQTFcQ68CQzLNUJ09lGmememENSft
         Y7doBAAcYDz+s1spBZL1vlBiBjKHF23pLMycLSFU3px9e9lf9IH6NjknT8UaqLc9pP4o
         Tqfn5gLm3/2k4oNOEDCD0WFfQrbeA9OaidJv/YGgld2ulPeb1szl2bur+XJqttgChpd4
         bH5vlR/jzBRgIKkb4qfJG/uj/JPOTC1VdLNwLmbPTIwUWcD9OFRbqBXASes7XjCXJhbK
         PxfW4Ut96w3wrPMKMLADtIpd/BNLKef4kwtRZqu2ajNqEFI/gIMXU13UvJthWfSQoB9P
         WJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687423640; x=1690015640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ep2nmcwhqoubpUdoFoZiWlPysqbDDgRr+0DZ2J7o3XE=;
        b=W4+keb9/Ykm4ri6xiPYGdZ0vfsH9yNqeCqb1jSwB68MsnDZNe5YqE52z5LyRnPtPhZ
         ljalIOGYvwGDOXIUfXiqqI7bnHet0+UgDGvLHdbhgV8yu3Sd58hc+ph7aDO+aHJjR4Ec
         WLYnoJFtRlKoIZ1zSwCeHe85ZK48Z6Pc90HsMcxKUrzHBub5EUgzUUsUv7CdkvIe42NR
         0Z8WPybfSBozWKGPvlv7x2TDR0+pqnMUNqQeJMk0PHTNqVErsJF8/g6hJ4cqetuLQtbA
         RqzUg48KZ4V4QW7o2QF8vH5NTyU/DDtDYVkRh6eUh12coxo1XPzAB9fUouuL6RK+8ZgL
         Flyw==
X-Gm-Message-State: AC+VfDw7FstylV9nDlKj0iXfJ1l/Vcxqw2rGsb5bDa1ikHJFhvvjXGmA
	GZ9sIFuMC2ChjBuG/zkvEvunOBqz+TUDdx6ngG5BZryd7b5Unhlf7sU=
X-Google-Smtp-Source: ACHHUZ5ettnmOIGPAQ5ZENLICkzufS9+rfxEAdPUjWtPlkSQhng2OX/mSNvyVeYSimj9Exds/y2TnnYUfHYnqCYrJt0=
X-Received: by 2002:a2e:2d02:0:b0:2ac:7852:4096 with SMTP id
 t2-20020a2e2d02000000b002ac78524096mr10605090ljt.24.1687423639478; Thu, 22
 Jun 2023 01:47:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230619100121.27534-1-puranjay12@gmail.com> <20230619100121.27534-4-puranjay12@gmail.com>
 <ZJMXqTffB22LSOkd@FVFF77S0Q05N> <CANk7y0h5ucxmMz4K8sGx7qogFyx6PRxYxmFtwTRO7=0Y=B4ugw@mail.gmail.com>
 <ZJQE9PIjxuA3Q8Sm@FVFF77S0Q05N>
In-Reply-To: <ZJQE9PIjxuA3Q8Sm@FVFF77S0Q05N>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 22 Jun 2023 10:47:08 +0200
Message-ID: <CANk7y0jtm9yYobPLsMEHAem+R-wKjVOLWo=EeU-bojYks9tetQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] bpf, arm64: use bpf_jit_binary_pack_alloc
To: Mark Rutland <mark.rutland@arm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, catalin.marinas@arm.com, 
	bpf@vger.kernel.org, kpsingh@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Mark,

On Thu, Jun 22, 2023 at 10:23=E2=80=AFAM Mark Rutland <mark.rutland@arm.com=
> wrote:
>
> On Wed, Jun 21, 2023 at 10:57:20PM +0200, Puranjay Mohan wrote:
> > On Wed, Jun 21, 2023 at 5:31=E2=80=AFPM Mark Rutland <mark.rutland@arm.=
com> wrote:
> > > On Mon, Jun 19, 2023 at 10:01:21AM +0000, Puranjay Mohan wrote:
> > > > @@ -1562,34 +1610,39 @@ struct bpf_prog *bpf_int_jit_compile(struct=
 bpf_prog *prog)
> > > >
> > > >       /* 3. Extra pass to validate JITed code. */
> > > >       if (validate_ctx(&ctx)) {
> > > > -             bpf_jit_binary_free(header);
> > > >               prog =3D orig_prog;
> > > > -             goto out_off;
> > > > +             goto out_free_hdr;
> > > >       }
> > > >
> > > >       /* And we're done. */
> > > >       if (bpf_jit_enable > 1)
> > > >               bpf_jit_dump(prog->len, prog_size, 2, ctx.image);
> > > >
> > > > -     bpf_flush_icache(header, ctx.image + ctx.idx);
> > > > +     bpf_flush_icache(ro_header, ctx.ro_image + ctx.idx);
> > >
> > > I think this is too early; we haven't copied the instructions into th=
e
> > > ro_header yet, so that still contains stale instructions.
> > >
> > > IIUC at the whole point of this is to pack multiple programs into sha=
red ROX
> > > pages, and so there can be an executable mapping of the RO page at th=
is point,
> > > and the CPU can fetch stale instructions throught that.
> > >
> > > Note that *regardless* of whether there is an executeable mapping at =
this point
> > > (and even if no executable mapping exists until after the copy), we a=
t least
> > > need a data cache clean to the PoU *after* the copy (so fetches don't=
 get a
> > > stale value from the PoU), and the I-cache maintenance has to happeon=
 the VA
> > > the instrutions will be executed from (or VIPT I-caches can still con=
tain stale
> > > instructions).
> >
> > Thanks for catching this, It is a big miss from my side.
> >
> > I was able to reproduce the boot issue in the other thread on my
> > raspberry pi. I think it is connected to the
> > wrong I-cache handling done by me.
> >
> > As you rightly pointed out: We need to do bpf_flush_icache() after
> > copying the instructions to the ro_header or the CPU can run
> > incorrect instructions.
> >
> > When I move the call to bpf_flush_icache() after
> > bpf_jit_binary_pack_finalize() (this does the copy to ro_header), the
> > boot issue
> > is fixed. Would this change be enough to make this work or I would
> > need to do more with the data cache as well to catch other
> > edge cases?
>
> AFAICT, bpf_flush_icache() calls flush_icache_range(). Despite its name,
> flush_icache_range() has d-cache maintenance, i-cache maintenance, and co=
ntext
> synchronization (i.e. it does everything necessary).
>
> As long as you call that with the VAs the code will be executed from, tha=
t
> should be sufficient, and you don't need to do any other work.

Thanks for explaining this.
After reading your explanation, I feel this should work.

bpf_jit_binary_pack_finalize() will copy the instructions from
rw_header to ro_header.
After the copy, calling bpf_flush_icache(ro_header, ctx.ro_image +
ctx.idx); will invalidate the caches
for the VAs in the ro_header, this is where the code will be executed from.

I will send the v4 patchset with this change.

Thanks,
Puranjay

