Return-Path: <bpf+bounces-16387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1D5800DC1
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 15:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED8A281720
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 14:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0C83E46C;
	Fri,  1 Dec 2023 14:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k10YZtxH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C80A10FA
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 06:52:56 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a196f84d217so164169566b.3
        for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 06:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701442375; x=1702047175; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9nFlIriU13YWR+IsyA3UjzLbMz/VibKu7Uw6owcv8E0=;
        b=k10YZtxHrlujgWdwug6abYjSQDpWyKMZHMx0Ek+8xTwTYmHkeTJg1cSnfkgqqnjzEY
         rBQi8Qc0ADKZ9iLGH70O2EUbpNKyeDDuTkD2mLjkZh1u2MaTSfVLuPOH58rMxB8/g3rN
         MhtIPc1Qlq7epRFIpvmIuzX0b5hkhqZ6+QxZLRR+QPKYsgnjLOcu+gtBcjnEw554UJnS
         91havkg5jf+y9vl6wWTdbaQ2/bgqzg6VPlR3rtgD1gW+H1fDG4cBu73Y3rmuTIIlhhkM
         jjySyTPXtypxs/T7NR5J2mzQaHaqWCMCA7YUs9P2keKyk0O0Ed/BwS20Ry330WKJwIS6
         P1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701442375; x=1702047175;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9nFlIriU13YWR+IsyA3UjzLbMz/VibKu7Uw6owcv8E0=;
        b=Rdfb8ZiJEvyZTRQPuWBygKzujRAFXLn7j8L33jjoXsiTpdRCjYSH6GPGInLTN9mIUl
         yiZwVQsIn5jp5AFR8WtTJ5Bsk3aomy+Muwm0aaZ+miLtV3qklQvLpKCHJjbJRIHoeNLn
         QafHGGe8GzLZU0fQan1gT7T7WDU3Jq9Qcib6QWIOs+XI0MCA+jt2x1Vn4HZVnJeMnBkv
         vyfroiQQcGHUZ/Dg7nvuFyXX8QiDRxCK/2Gvfn//qOhTgqb1WJ/FK8VMHGPLkazawUwM
         ffkBhP70f9EidZGg145kYXL5Dxk8PYk7U05ty82qC2UKLSiAbQU/CzqzXo0nf7tti7Em
         8iKg==
X-Gm-Message-State: AOJu0YzaE5osXn/VOe/5v2aX6m6F9RHsrddoneNs/jPVt2crcgF4YlHi
	eiIVBMHVqxxKr0yRpDVcEZw=
X-Google-Smtp-Source: AGHT+IFz2dN8BdjDNDgD9tvauIedjT1e3/K5ezdbW7UFfKJj7EQMlGb4knwcjafsR537Rs14EMAzZQ==
X-Received: by 2002:a17:906:1953:b0:a19:a1ba:8cdc with SMTP id b19-20020a170906195300b00a19a1ba8cdcmr1032146eje.122.1701442374462;
        Fri, 01 Dec 2023 06:52:54 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id k11-20020a1709061c0b00b009be14e5cd54sm1969318ejg.57.2023.12.01.06.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 06:52:54 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 1 Dec 2023 15:52:51 +0100
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Xu Kuohai <xukuohai@huawei.com>, Will Deacon <will@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: Re: [PATCHv2 bpf 0/2] bpf: Fix prog_array_map_poke_run map poke
 update
Message-ID: <ZWnzQ6y98cBNAr7a@krava>
References: <20231128092850.1545199-1-jolsa@kernel.org>
 <22e3824bce10a895b1c9ce33ed7473561d288e69.camel@linux.ibm.com>
 <ZWc7OHnLux47RpOr@krava>
 <ZWnb8ptRW1DW6JLp@krava>
 <a3e9cb8d96b663e9c110bdd6b90bdd37b92028d7.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3e9cb8d96b663e9c110bdd6b90bdd37b92028d7.camel@linux.ibm.com>

On Fri, Dec 01, 2023 at 03:31:57PM +0100, Ilya Leoshkevich wrote:
> On Fri, 2023-12-01 at 14:13 +0100, Jiri Olsa wrote:
> > On Wed, Nov 29, 2023 at 02:23:04PM +0100, Jiri Olsa wrote:
> > > On Tue, Nov 28, 2023 at 11:44:33PM +0100, Ilya Leoshkevich wrote:
> > > > On Tue, 2023-11-28 at 10:28 +0100, Jiri Olsa wrote:
> > > > > hi,
> > > > > this patchset fixes the issue reported in [0].
> > > > > 
> > > > > For the actual fix in patch 2 I'm changing bpf_arch_text_poke
> > > > > to
> > > > > allow to skip
> > > > > ip address check in patch 1. I considered adding separate
> > > > > function
> > > > > for that,
> > > > > but because each arch implementation is bit different, adding
> > > > > extra
> > > > > arg seemed
> > > > > like better option.
> > > > > 
> > > > > v2 changes:
> > > > >   - make it work for other archs
> > > > > 
> > > > > thanks,
> > > > > jirka
> > > > > 
> > > > > 
> > > > > [0]
> > > > > https://syzkaller.appspot.com/bug?extid=97a4fe20470e9bc30810
> > > > > ---
> > > > > Jiri Olsa (2):
> > > > >       bpf: Add checkip argument to bpf_arch_text_poke
> > > > >       bpf, x64: Fix prog_array_map_poke_run map poke update
> > > > > 
> > > > >  arch/arm64/net/bpf_jit_comp.c   |  3 ++-
> > > > >  arch/riscv/net/bpf_jit_comp64.c |  5 +++--
> > > > >  arch/s390/net/bpf_jit_comp.c    |  3 ++-
> > > > >  arch/x86/net/bpf_jit_comp.c     | 24 +++++++++++++-----------
> > > > >  include/linux/bpf.h             |  2 +-
> > > > >  kernel/bpf/arraymap.c           | 31 +++++++++++--------------
> > > > > ------
> > > > >  kernel/bpf/core.c               |  2 +-
> > > > >  kernel/bpf/trampoline.c         | 12 ++++++------
> > > > >  8 files changed, 39 insertions(+), 43 deletions(-)
> > > > 
> > > > Would it be possible to add a minimized version of the reproducer
> > > > as a
> > > > testcase?
> > > 
> > > there's reproducer I used in here:
> > >   https://syzkaller.appspot.com/text?tag=ReproC&x=1397180f680000
> > > 
> > > I can try, but not sure I'll be able to come up with something that
> > > would fit as testcase.. I'll check
> > 
> > the test below reproduces it for me.. the only tricky part is that
> > I need to repeat the loop 10 times to trigger that on my setup..
> > which is not terrible, but not great for a test I think
> > 
> > jirka
> 
> The test looks useful to me. I think having magic repetition counts
> like this 10 here is almost inevitable when trying to reproduce race
> conditions. The test also runs quickly for me. You can have my
> 
> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> in case you decide to make a formal patch.

great, thanks

jirka

