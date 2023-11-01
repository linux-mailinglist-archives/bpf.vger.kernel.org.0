Return-Path: <bpf+bounces-13801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D547DE110
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 13:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8CAA1C20D27
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 12:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A48711CB5;
	Wed,  1 Nov 2023 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+R1ve0b"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68A6567B
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 12:37:50 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7F510C
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 05:37:41 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40859c464daso52324955e9.1
        for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 05:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698842260; x=1699447060; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cxiGG13lweFpiLFe53EjbzmpEkoIUDPOrMvnNbNjOhM=;
        b=L+R1ve0bcMSybQ7kenLayexhcSykhNE753N8xqLAx1JMV3Cz/3FDrqjgBUFXCFWiE1
         vT6mLdQli816bQu5bN1b+RMTAqxcQ329JW4QaEhem/H/KJwJPP810jMIuFdSrifRb2Xl
         WJMrYPmsOFliFXuRthMapB4h9cDP3QPTjjP7yBb9I1MAJ27aMFqvOoy5+acpMfRi/pDb
         1fMN59OlKwxbgZ/9oKu3WM30zfCuX8ks4J4sGXQSi9GdIBEVnCc74GYc9JhA6R0gmzVc
         Ao4Utvn5J/9lrzBY7bsRYawCUP2CdtWiDQhkIgy+dcwTIwg72a7/rjNmN8lVK3vLjX0c
         Uo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698842260; x=1699447060;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cxiGG13lweFpiLFe53EjbzmpEkoIUDPOrMvnNbNjOhM=;
        b=vBEcf1J6zCgOKdzDOCIBkBxzIht6BaS6ZvsDnE8PifhxUUxWL6Xt46IiDdP/AufwbF
         zLy6PhQ4ehFEcuA+bqM1YPthvs4zuEF5Op5eQ2m5OyLL838xc6xkGVO1DUAUBNuT/Zvs
         hyYTkw8JgMPUZxcAMrvxN2P/yVYNgHeMsWPVlFddRglfJMu/tC/ieuPQjh/bKNT29Srj
         Dc74KP5FSBodwjktPRhRpOB2MXbGRiqKg4dQ0XV/AeNYvGGIVOlT+HYVaeYDozoCiqRi
         ZcBBP3X/1Rc3ARVH/Hvl4gQlkm0J71RC+5p4H1KnOJ3zCIV2pLzUl9WXPCzCriFfjjwV
         KoIA==
X-Gm-Message-State: AOJu0YwDURMM5vWt3Bb5YThw73DQkbm8DSgQia59n5kPS+YiTqkUCwKv
	y3ma+Jm6tNx/B8Dgkk6O3sE=
X-Google-Smtp-Source: AGHT+IHJlWddeq1LzoiSuuDIUKwOMPZm/fDdXiJROjQL4VO2hDkpw+770/FBPHEleISJpuY0Zq/ZTQ==
X-Received: by 2002:adf:f6c5:0:b0:32d:9e4f:718f with SMTP id y5-20020adff6c5000000b0032d9e4f718fmr10903777wrp.44.1698842259884;
        Wed, 01 Nov 2023 05:37:39 -0700 (PDT)
Received: from Mem (2a01cb0890a26e008c54362b1633acea.ipv6.abo.wanadoo.fr. [2a01:cb08:90a2:6e00:8c54:362b:1633:acea])
        by smtp.gmail.com with ESMTPSA id i8-20020a05600011c800b0032179c4a46dsm4041510wrx.100.2023.11.01.05.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 05:37:38 -0700 (PDT)
Date: Wed, 1 Nov 2023 13:37:37 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@rutgers.edu>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Paul Chaignon <paul@isovalent.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v5 bpf-next 00/23] BPF register bounds logic and testing
 improvements
Message-ID: <ZUJGkRGnw+qI15Pv@Mem>
References: <20231027181346.4019398-1-andrii@kernel.org>
 <20231030175513.4zy3ubkpse2f6gqz@MacBook-Pro-49.local>
 <CAEf4BzZyLwO_ZppGObkY=4aXZEGE+k+tTtJug7MP63DffoxrYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZyLwO_ZppGObkY=4aXZEGE+k+tTtJug7MP63DffoxrYA@mail.gmail.com>

On Mon, Oct 30, 2023 at 10:19:01PM -0700, Andrii Nakryiko wrote:
> On Mon, Oct 30, 2023 at 10:55 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Oct 27, 2023 at 11:13:23AM -0700, Andrii Nakryiko wrote:
> > >
> > > Note, this is not unique to <range> vs <range> logic. Just recently ([0])
> > > a related issue was reported for existing verifier logic. This patch set does
> > > fix that issues as well, as pointed out on the mailing list.
> > >
> > >   [0] https://lore.kernel.org/bpf/CAEf4Bzbgf-WQSCz8D4Omh3zFdS4oWS6XELnE7VeoUWgKf3cpig@mail.gmail.com/
> >
> > Quick comment regarding shift out of bound issue.
> > I think this patch set makes Hao Sun's repro not working, but I don't think
> > the range vs range improvement fixes the underlying issue.
> 
> Correct, yes, I think adjust_reg_min_max_vals() might still need some fixing.
> 
> > Currently we do:
> > if (umax_val >= insn_bitness)
> >   mark_reg_unknown
> > else
> >   here were use src_reg->u32_max_value or src_reg->umax_value
> > I suspect the insn_bitness check is buggy and it's still possible to hit UBSAN splat with
> > out of bounds shift. Just need to try harder.
> > if w8 < 0xffffffff goto +2;
> > if r8 != r6 goto +1;
> > w0 >>= w8;
> > won't be enough anymore.
> 
> Agreed, but I felt that fixing adjust_reg_min_max_vals() is out of
> scope for this already large patch set. If someone can take a deeper
> look into reg bounds for arithmetic operations, it would be great.
> 
> On the other hand, one of those academic papers claimed to verify
> soundness of verifier's reg bounds, so I wonder why they missed this?

AFAICS, it should have been able to detect this bug. Equation (3) from
[1, page 10] encodes the soundness condition for conditional jumps and
the implementation definitely covers BPF_JEQ/JNE and the logic in
check_cond_jmp_op. So either there's a bug in the implementation or I'm
missing something about how it works. Let me cc two of the paper's
authors :)

Hari, Srinivas: Hao Sun recently discovered a bug in the range analysis
logic of the verifier, when comparing two unknown scalars with
non-overlapping ranges. See [2] for Eduard Zingerman's explanation. It
seems to have existed for a while. Any idea why Agni didn't uncover it?

1 - https://harishankarv.github.io/assets/files/agni-cav23.pdf
2 - https://lore.kernel.org/bpf/8731196c9a847ff35073a2034662d3306cea805f.camel@gmail.com/

> cc Paul, maybe he can clarify (and also, Paul, please try to run all
> that formal verification machinery against this patch set, thanks!)

I tried it yesterday but am running into what looks like a bug in the
LLVM IR to SMT conversion. Probably not something I can fix myself
quickly so I'll need help from Hari & co.

That said, even without your patchset, I'm running into another issue
where the formal verification takes several times longer (up to weeks
/o\) since v6.4.


