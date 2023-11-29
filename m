Return-Path: <bpf+bounces-16145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D887FD7F3
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 14:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D120B216A6
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 13:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C26D200C7;
	Wed, 29 Nov 2023 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCnKAQ45"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A6C19AE
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 05:23:08 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-332f4ad27d4so3087100f8f.2
        for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 05:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701264187; x=1701868987; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B/ScrL3aE/gkBKPD4BxWyFIo/C5EuuRsLwAfNx4K4ao=;
        b=bCnKAQ45f0P+bou99JubFP9guGGfsKDI84MkFoy1d5VLbE2mNifIUvCkUfIpFNz9Z0
         TsnHkAdVxVajtxrdLYN6Ht9j1PxaAadu6mnyd+exyn5h4EP5Pq1KyX/tYoibAH9htdv8
         LygzGL8oooC7lY4X0ruCPE+6whjSksv71g+6VgVpXElguOBV1++9025UTut8LqgBSJw8
         wT9k7btldZIDQSgNPNZqAOtbQevtQDFO9wFZFKDkgiDlXNqLpoZLGQ/99WljCs/G2m2J
         DJV7E9FvCJXOH0enLTgA2FQZH6APke2XO44Ij7Rl3W5chvG8k+mHVXTV/or5JJyS3wUV
         M9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701264187; x=1701868987;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B/ScrL3aE/gkBKPD4BxWyFIo/C5EuuRsLwAfNx4K4ao=;
        b=qg+UdqoIxNY9njAV5qslfCimYQsUAoieZvvcWKcqhCzn7EEoReON7Dsn41cx91RnjI
         /ao1di9L4wynfmjIC3dAfzq95f1fcDx+L0ixuD6gkTqV7ZosfHQL27Aa8AqI9lH7SN4e
         PJXsJ1gHN5AmdmOJCAFfoXGGyl4+lQtoFbB6zFLDnAX91JZgxO73KzjlOCnXDvGw/Wwu
         s5w3Jdn/tBWVWzW9QJbU0lrVpjL73pd8SgpQgo67kW8Wz7VaI3fwYsKxXj/+/K2VboiA
         ti//Ak1oGbUIv+/MQ4ef4kBv72MVL5bPLiUX5mSOPcaVMfquDn6ec6BLp/aA6CmkcZYU
         Eixw==
X-Gm-Message-State: AOJu0Yy+HiWxhf7zekDEB0DEESsjnbIikEipANxDJID83ayuMIK35MBZ
	a50YpGVBkuBPSctOWZntrbY=
X-Google-Smtp-Source: AGHT+IGe7dhpWyKN2FVPeG4afDTEPHDf3lmnTAOZlKoeBAt9VgY9ylEarvtM+lQsDs8h09jFxeBMHQ==
X-Received: by 2002:a05:6000:e:b0:332:ea50:40c4 with SMTP id h14-20020a056000000e00b00332ea5040c4mr13246628wrx.48.1701264186770;
        Wed, 29 Nov 2023 05:23:06 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id c17-20020adffb51000000b00333195cf61csm1513747wrs.13.2023.11.29.05.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 05:23:06 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 29 Nov 2023 14:23:04 +0100
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
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
Message-ID: <ZWc7OHnLux47RpOr@krava>
References: <20231128092850.1545199-1-jolsa@kernel.org>
 <22e3824bce10a895b1c9ce33ed7473561d288e69.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22e3824bce10a895b1c9ce33ed7473561d288e69.camel@linux.ibm.com>

On Tue, Nov 28, 2023 at 11:44:33PM +0100, Ilya Leoshkevich wrote:
> On Tue, 2023-11-28 at 10:28 +0100, Jiri Olsa wrote:
> > hi,
> > this patchset fixes the issue reported in [0].
> > 
> > For the actual fix in patch 2 I'm changing bpf_arch_text_poke to
> > allow to skip
> > ip address check in patch 1. I considered adding separate function
> > for that,
> > but because each arch implementation is bit different, adding extra
> > arg seemed
> > like better option.
> > 
> > v2 changes:
> >   - make it work for other archs
> > 
> > thanks,
> > jirka
> > 
> > 
> > [0] https://syzkaller.appspot.com/bug?extid=97a4fe20470e9bc30810
> > ---
> > Jiri Olsa (2):
> >       bpf: Add checkip argument to bpf_arch_text_poke
> >       bpf, x64: Fix prog_array_map_poke_run map poke update
> > 
> >  arch/arm64/net/bpf_jit_comp.c   |  3 ++-
> >  arch/riscv/net/bpf_jit_comp64.c |  5 +++--
> >  arch/s390/net/bpf_jit_comp.c    |  3 ++-
> >  arch/x86/net/bpf_jit_comp.c     | 24 +++++++++++++-----------
> >  include/linux/bpf.h             |  2 +-
> >  kernel/bpf/arraymap.c           | 31 +++++++++++--------------------
> >  kernel/bpf/core.c               |  2 +-
> >  kernel/bpf/trampoline.c         | 12 ++++++------
> >  8 files changed, 39 insertions(+), 43 deletions(-)
> 
> Would it be possible to add a minimized version of the reproducer as a
> testcase?

there's reproducer I used in here:
  https://syzkaller.appspot.com/text?tag=ReproC&x=1397180f680000

I can try, but not sure I'll be able to come up with something that
would fit as testcase.. I'll check

jirka

