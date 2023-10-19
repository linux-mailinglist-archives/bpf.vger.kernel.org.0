Return-Path: <bpf+bounces-12725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F697D0190
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 20:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94FD2282227
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 18:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A9E328DB;
	Thu, 19 Oct 2023 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D09Re79m"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC3B39840
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 18:32:11 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76826BB
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 11:32:09 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c50305c5c4so107819381fa.1
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 11:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697740328; x=1698345128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Swi+p436wl6VlbIiGdNYVpHeEg0Or3ahHOX2Tw5HyZc=;
        b=D09Re79myOKhLv0uxMpvc/HnfW1hzrti2VRnzdKQ0gTjyPPg/mK9rjyjqRHawdGpC3
         ozUVAz6NtsYFKlny3uU/qhIyp3vOeAulgrHMNiU7DLSLs4ECIhAgcWQq+vcEB6O6dAJb
         kegcBHQ6gA6DVIeq+6wOCpSWPOgxKoBvA9R7l7nRPDk+oX3A+bDbrQwgDvu6yjyHLJEU
         KaDHdbaLkP4CH+cqlV/smIOUdqx0gAgUs+zwNI0BrMTsNgLHeuIjeMUjXDvYd1t9E5eo
         2QsXDvFt9aqyA++v70xK+r/NDI4Nybd+ZdXsU7sCaXp8OV9XF8SzMYL3EpHoSAIe/lwP
         Qccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697740328; x=1698345128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Swi+p436wl6VlbIiGdNYVpHeEg0Or3ahHOX2Tw5HyZc=;
        b=OysQIu+Fbhl6lEP/Is5VXyVjjN0ODdes/sOpYwKty/rW/NSKbbjF8VcW/gYVC3S2i+
         YGt1WWtSOtxyDUPeF0SByEswX41hUUcBrxBHzsJpEV3uq6vWI5/ME6F6Zkvn1yNYAPCH
         toVtSJTBwtIv0iP6I+L6xUZstmKOdphz8Ii94zoLMOHyAA1XI7DobL6KpAPidnBC+fKg
         NJKmkx/gP9qqF9eALaj+MyQG/McI/Iy0r2lHWGUK5ZUo/E+APUYteEl3H8kWzAScoirY
         W4JRhLsAUtj/o2Uc7NZaYDqH6PXbUQFbY1uvE/k6xZaydzj62131E4Txbti42Rej47ox
         y8Kg==
X-Gm-Message-State: AOJu0Yy1qzMJL9OgnHjYHFP4t9q+W/Exsjud3m36WpU3Hjkl1AqFqv33
	cocM9XX7+TzjOfE4maAhxjWu74smMuzyjoESdeg=
X-Google-Smtp-Source: AGHT+IEHM0hhV4MD3OhJOp3pmi0RF+JQBAxg6uWZScMcY7TAc7PIjjbaBale0Jo3VUizfP62xPPrAkgS8LlLOLuMIuc=
X-Received: by 2002:a19:8c52:0:b0:4f8:77db:1d9e with SMTP id
 i18-20020a198c52000000b004f877db1d9emr1901305lfj.12.1697740327254; Thu, 19
 Oct 2023 11:32:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231019042405.2971130-1-andrii@kernel.org> <20231019042405.2971130-8-andrii@kernel.org>
 <ZTDbGWHu4CnJYWAs@u94a>
In-Reply-To: <ZTDbGWHu4CnJYWAs@u94a>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 19 Oct 2023 11:31:55 -0700
Message-ID: <CAEf4Bzad+jgPWQ37VM5JOw4GPHbjZpJrxmRsFs8N0MqeMHyLSA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 7/7] selftests/bpf: BPF register range bounds tester
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Langston Barrett <langston.barrett@gmail.com>, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Santosh Nagarakatte <santosh.nagarakatte@cs.rutgers.edu>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 12:30=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse.co=
m> wrote:
>
> On Wed, Oct 18, 2023 at 09:24:05PM -0700, Andrii Nakryiko wrote:
> > Add tests that validate correctness and completeness of BPF verifier's
> > register range bounds.
>
> Nitpick: in abstract-interpretation-speak, completeness seems to mean
> something different. I believe what we're trying to check here is
> soundness[1], again, in abstraction-interpretation-speak), so using
> completeness here may be misleading to some. (I'll leave explanation to
> other that understand this concept better than I do, rather than making a=
n
> ill attempt that would probably just make things worst)

I'll just say "Add test to validate BPF verifier's register range
bounds tracking logic." to avoid terminology hazards :)

>
> > The main bulk is a lot of auto-generated tests based on a small set of
> > seed values for lower and upper 32 bits of full 64-bit values.
> > Currently we validate only range vs const comparisons, but the idea is
> > to start validating range over range comparisons in subsequent patch se=
t.
>
> CC Langston Barrett who had previously send kunit-based tnum checks[2] a
> while back. If this patch is merged, perhaps we can consider adding
> validation for tnum as well in the future using similar framework.
>
> More comments below
>
> > When setting up initial register ranges we treat registers as one of
> > u64/s64/u32/s32 numeric types, and then independently perform condition=
al
> > comparisons based on a potentially different u64/s64/u32/s32 types. Thi=
s
> > tests lots of tricky cases of deriving bounds information across
> > different numeric domains.
> >
> > Given there are lots of auto-generated cases, we guard them behind
> > SLOW_TESTS=3D1 envvar requirement, and skip them altogether otherwise.
> > With current full set of upper/lower seed value, all supported
> > comparison operators and all the combinations of u64/s64/u32/s32 number
> > domains, we get about 7.7 million tests, which run in about 35 minutes
> > on my local qemu instance. So it's something that can be run manually
> > for exhaustive check in a reasonable time, and perhaps as a nightly CI
> > test, but certainly is too slow to run as part of a default test_progs =
run.
>
> FWIW an alternative approach that speeds things up is to use model checke=
rs
> like Z3 or CBMC. On my laptop, using Z3 to validate tnum_add() against *a=
ll*
> possible inputs takes less than 1.3 seconds[3] (based on code from [1]
> paper, but I somehow lost the link to their GitHub repository).
>
> One of the potential issue with [3] is that Z3Py is written in Python. So
> there's the large over head of translating the C-implementation into Pyth=
on
> using Z3Py APIs each time we changed relevant code. This overhead could
> potentially be removed with CBMC, which understand C, and we had a
> precedence of using CBMC[4] within the kernel source code, though it was
> later removed[5] due because SRCU changes are still happening too fast fo=
r
> the format tests to keep up, so it looks like CBMC is not a silver-bullet=
.
>
> I really meant to look into the CMBC approach for verification of ranges =
and
> tnum, but fails to allocate time for it, so far.

It would be great if someone did a proper model checker-based
verification of range tracking logic of overall BPF verifier logic,
agreed. Until we have that (and depending on how easy it is to
integrate that approach into BPF CI), I think having something as part
of test_progs is a good practical step forward.

>
> Shung-Hsi
>
> > ...
>
> 1: https://people.cs.rutgers.edu/~sn349/papers/cgo-2022.pdf
> 2: https://lore.kernel.org/bpf/20220430215727.113472-1-langston.barrett@g=
mail.com/
> 3: https://gist.github.com/shunghsiyu/a63e08e6231553d1abdece4aef29f70e
> 4: https://lore.kernel.org/all/1485295229-14081-3-git-send-email-paulmck@=
linux.vnet.ibm.com/

